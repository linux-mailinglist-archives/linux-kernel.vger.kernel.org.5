Return-Path: <linux-kernel+bounces-131555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69452898988
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF6E28A274
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CF31292E6;
	Thu,  4 Apr 2024 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFOrdJZG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA27F8528F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239659; cv=none; b=Pz5Or4xpqS50h3Jpf8cIVBrFJfqJ6GNBx0tkaZtFUJLvICLJrpaJEUZoUNt31Luw2XMnkAjRRih9asB9iYDKzGy9q47EbfflszeuS/C9MB0XIMJZMMms5S5eiuOVvKQF9Fsqot1F5ozYMaK8cXqMAMhG2SUeDWGs8vV1PMx5WKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239659; c=relaxed/simple;
	bh=kiewTNom2O47OTfFgOcrJGUfRo6DrcAKHxtaAdWUzTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bXTuiJ3vGEPi5jD55vJbPxtPMM9+x0Nvi2VfyPr8XilUqLHfeLs107Ot9PV3TYOqOmFcCflVQaVHySQa0GNAqozQnwXQ7HeDH+VW93aPiDTuvdfA8c8KMY4RmOy1L15ibuSTH+FueGbgrVMl/uSM+aDR3ZpPTARBLchIwkLW6wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFOrdJZG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712239657; x=1743775657;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kiewTNom2O47OTfFgOcrJGUfRo6DrcAKHxtaAdWUzTQ=;
  b=oFOrdJZGeEBHmyIuavJkvndltntyz5fx42Z+p6CPPVKsN+0G+IODHxDB
   SOtft2q0JEGnNd4NjtQFbnKAWOMofygXyEk/u/mPrvlAOJZ8chOBsnrnT
   KGtYaFb/p2bprzTj+sOX1dIFBce6XoW4z+OQqJKlBX5fy3XvAcwVCJ73O
   5cw/q9uDvWUCBv7s60oCQsWpQ8Mn2edgXQRInsCMdQewotOZLhXo5pnbE
   +ZXp9H77IgBMO/nm4Q5d2BqE33tVKKMaE5MHJbWu/8yX5NzIS23CEmCkL
   snDn7tWLW2IeQd6F1IBZC1IBsE8xnsqbI+3+V9vr4ntt7Yx35sHoT4TJ+
   w==;
X-CSE-ConnectionGUID: aKFKS+gySj2cO1xYW4KGIw==
X-CSE-MsgGUID: eMd3pSxESIyspdY9b5kciw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11346490"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="11346490"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:07:37 -0700
X-CSE-ConnectionGUID: l6OWsRlERea5xZuUYJiOHw==
X-CSE-MsgGUID: 2I5t2V03TdOGunV7LcnUww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23258841"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 04 Apr 2024 07:07:36 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 00/12] Support Lunar Lake and Arrow Lake core PMU
Date: Thu,  4 Apr 2024 07:06:25 -0700
Message-Id: <20240404140637.1232635-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

From the core PMU' perspective, the Lunar Lake and Arrow Lake are the
same, which are similar to the previous generation Meteor Lake. Both are
hybrid platforms, with e-core and p-core.

The key differences include:
- The e-core supports 3 new fixed counters
- The p-core supports an updated PEBS Data Source format
- More GP counters (Updated event constraint table)
- New Architectural performance monitoring V6
  (New Perfmon MSRs aliasing, umask2, eq).
- New PEBS format V6 (Counters Snapshotting group)
- New RDPMC metrics clear mode

The details for the above new features can be found in the Intel
Architecture Instruction Set Extensions and Future Features (052).
https://cdrdv2.intel.com/v1/dl/getContent/671368

The counters may not be continuous anymore. Patch 1-2 converts the max
number of counters to a mask of counters. The change is a generic change
which impacts all X86 platforms.

Patch 3-4 supports all the legacy features on LNL and ARL.

Patch 5-7 supports the new Architectural performance monitoring V6.

Patch 8-11 supports the new PEBS format V6.

Patch 12 supports the new RDPMC metrics clear mode.

Kan Liang (12):
  perf/x86/intel: Support the PEBS event mask
  perf/x86: Support counter mask
  perf/x86: Add Lunar Lake and Arrow Lake support
  perf/x86/intel: Support new data source for Lunar Lake
  perf/x86: Add config_mask to represent EVENTSEL bitmask
  perf/x86/intel: Support PERFEVTSEL extension
  perf/x86/intel: Support Perfmon MSRs aliasing
  perf/x86: Extend event update interface
  perf: Extend perf_output_read
  perf/x86/intel: Move PEBS event update after the sample output
  perf/x86/intel: Support PEBS counters snapshotting
  perf/x86/intel: Support RDPMC metrics clear mode

 arch/x86/events/amd/core.c           |  26 +-
 arch/x86/events/core.c               | 123 +++----
 arch/x86/events/intel/core.c         | 466 ++++++++++++++++++++-------
 arch/x86/events/intel/ds.c           | 267 +++++++++++++--
 arch/x86/events/intel/knc.c          |   2 +-
 arch/x86/events/intel/p4.c           |  12 +-
 arch/x86/events/intel/p6.c           |   2 +-
 arch/x86/events/perf_event.h         |  81 ++++-
 arch/x86/events/perf_event_flags.h   |   2 +-
 arch/x86/events/zhaoxin/core.c       |  14 +-
 arch/x86/include/asm/intel_ds.h      |   6 +
 arch/x86/include/asm/msr-index.h     |   6 +
 arch/x86/include/asm/perf_event.h    |  27 ++
 include/uapi/linux/perf_event.h      |   6 +-
 kernel/events/core.c                 |  15 +-
 tools/perf/Documentation/topdown.txt |   9 +-
 16 files changed, 810 insertions(+), 254 deletions(-)

-- 
2.35.1


