Return-Path: <linux-kernel+bounces-26288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0114982DE1B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFEA3282A37
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36BF182BF;
	Mon, 15 Jan 2024 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BnhGgSoF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B0218035
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705338098; x=1736874098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hgHSCCkYdUQvQN3OmRimDqcNGoAmnLSX2bEwJ8BLOuU=;
  b=BnhGgSoFC9E3ZqxrABuvUoDn9QU/D4US16ZoZQfQlpOjhRtfs/pY+5il
   ro+wmM2n6ItAM0kgEwy73rnQ/sSW6kapEH5HbeST6ro4GvsUeZiFGoEbN
   Ae5kcBL0ju6YUUipSl6mn+MUo8jKVvrLWmADHResMZu3ZRNKzePTra1ea
   j01H8vgi4uyXz7CsJA3Z48wgP180Ux5wyftefEa9P7P6DpmymO/nsq7Xx
   xCljgaWPprBV/qnptO0Gg42rZiHjhlsCQgtnPJFj6Ggn4tZVLcxqz62BW
   h+Pf4uh6mwGQpgZH/YF0GJ0VFwdkyQT7K0Xd7uuaRAeaSs/XVdYk26PW0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="6408200"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="6408200"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 09:01:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="907101347"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="907101347"
Received: from mleonvig-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.223.101])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 09:01:34 -0800
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	tvrtko.ursulin@linux.intel.com
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
Subject: [RFC 2/3] drm/i915/pmu: Move i915 reference drop to new event->free()
Date: Mon, 15 Jan 2024 17:01:19 +0000
Message-Id: <20240115170120.662220-3-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240115170120.662220-1-tvrtko.ursulin@linux.intel.com>
References: <20240115170120.662220-1-tvrtko.ursulin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Avoids use after free in the perf core code on the event destruction
path, after the PCI driver has been unbound with the active perf file
descriptors.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Cc: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 21eb0c5b320d..010763a5bc39 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -514,7 +514,7 @@ static enum hrtimer_restart i915_sample(struct hrtimer *hrtimer)
 	return HRTIMER_RESTART;
 }
 
-static void i915_pmu_event_destroy(struct perf_event *event)
+static void i915_pmu_event_free(struct perf_event *event)
 {
 	struct i915_pmu *pmu = event_to_pmu(event);
 	struct drm_i915_private *i915 = pmu_to_i915(pmu);
@@ -630,7 +630,7 @@ static int i915_pmu_event_init(struct perf_event *event)
 
 	if (!event->parent) {
 		drm_dev_get(&i915->drm);
-		event->destroy = i915_pmu_event_destroy;
+		event->free = i915_pmu_event_free;
 	}
 
 	return 0;
-- 
2.40.1


