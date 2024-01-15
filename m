Return-Path: <linux-kernel+bounces-26286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E343F82DE19
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949E51F22AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F7E1802E;
	Mon, 15 Jan 2024 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kzEIH7ib"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3D618021
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705338095; x=1736874095;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m8GjS5wZqsYvI+/FgqsVOw65DnUXGTviCMTTBgL69MQ=;
  b=kzEIH7ibo/iYH14Q2vK54qvN2aWM171aafH6w3r89WhADD1e1IjPhdXG
   P1yim7KokZChiuf5QJj5J4b2SsHCIVmwQ6ZV4hRN91QcllZK6nVjrTotm
   Fi3s2c9s55qI7ok5Ago0suO0yckmaVA49mTyLZO7SxGQG/y4K8Bf76ozV
   Z7Ah1b3TmxgkqOsT70DcPbqqyjNH9lJMPy3yiHjx/JB7aQQ9HtTpxStnG
   jG5DmHESELI4/4JMmgfNX5CiNNO1PbpHYeG4pCGFfvl24geKLf+eNOeco
   qTAIeZMF+HPssVA8McfRDP4sn8bLoGArBr9BlF4/89XELV/EV+B4zEGFe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="6408192"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="6408192"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 09:01:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="907101286"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="907101286"
Received: from mleonvig-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.223.101])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 09:01:28 -0800
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	tvrtko.ursulin@linux.intel.com
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
Subject: [RFC 0/3] Fixing i915 PMU use after free after driver unbind
Date: Mon, 15 Jan 2024 17:01:17 +0000
Message-Id: <20240115170120.662220-1-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Hi Peter, all,

This is an early RFC to outline a newly discovered problem in the current
handling of driver unbind with active perf fds.

The sequence is basically this:

1. Open a perf fd
2. Unbind a driver
3. Close the dangling fd

Or a slightly more evil variant:

1. Open a perf fd
2. Unbind a driver
3. Bind the driver again
4. Close the dangling fd

I thought we had this covered by recording the unbound status (pmu->closed in
i915_pmu.c) and making sure the struct i915_pmu (and struct perf_pmu) remain
active until the last event is closed (via internal reference counting). But
what I missed until now are two things:

1)
core.c: _free_event() will dereference event->pmu _after_ event->destroy().

KASAN catches this easily and patches 1 & 2 are the attempt to fix that.

2)
A more evil case where pmu->cpu_pmu_context per-cpu allocation gets re-used
_before_ the old perf fd is closed.

There things can nicely explode on the list_del_init inside event_sched_out on
list_del_init(&event->active_list); (with list debugging turned on of course).

Most easily reproducible by simply re-binding i915, which happens to grab the
same per-cpu block and then the new perf_pmu_register zaps the list_head which
the old event will try to unlink itself from.

This is what the third patch attempts to deal with. It is a bit incomplete
though, as I was unsure what is the best approach to fix and so thought to send
it out early for some guidance.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Cc: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>

Tvrtko Ursulin (3):
  perf: Add new late event free callback
  drm/i915/pmu: Move i915 reference drop to new event->free()
  perf: Reference count struct perf_cpu_pmu_context to fix driver unbind

 drivers/gpu/drm/i915/i915_pmu.c |  4 ++--
 include/linux/perf_event.h      |  2 ++
 kernel/events/core.c            | 34 ++++++++++++++++++++++++---------
 3 files changed, 29 insertions(+), 11 deletions(-)

-- 
2.40.1


