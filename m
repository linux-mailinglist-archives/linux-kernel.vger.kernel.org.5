Return-Path: <linux-kernel+bounces-126689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9C0893B7A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE3CB211D1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E2F3F9CB;
	Mon,  1 Apr 2024 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6rNwAdH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E17F9DF;
	Mon,  1 Apr 2024 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711978457; cv=none; b=sbK0QXBIy41YOTQR31wXhvW8Hb0oa3GqKOW3EBVq52/2ms8aI479ruxxArCc4tY+GZZ5uxfVGEv1b4cUltJ+175akdQiXQ6JWjEYusS1rhRROQjuO6bfzlYL9Zb4tTA1Byvd/rfcQWfLbklOnWmKTj1KfvhG3g8rze1idg6HwV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711978457; c=relaxed/simple;
	bh=7q7c16TVmDniIvjtlhRzSb4l1WN3kAM4kW5UI26QoWI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JJ6xsQYcntDmSMVmLm42iqO3C6qgxMZFEi85PztLc5dZOs5SiE78T52awkEBvBaZQ9dKI0ctMBz0ELfN/OofedC826r75W80716Ff0xQab9HtcJMWfUUHzLVrxSqRsUOLYCU3OvwJD/USL8C8NAsrGzTYDwPCP1R11dPOsl65Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6rNwAdH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711978456; x=1743514456;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7q7c16TVmDniIvjtlhRzSb4l1WN3kAM4kW5UI26QoWI=;
  b=K6rNwAdHX+cP3Z0gqWcRpCxHkB1vBKwu0F/p/aBFF0P44Dmwb5PV9Poz
   mGXkXOZ7jo4HpDtNchd1Hfizo+calBfOjPVMvcVTYCQ3JK9TCmRjfhLNv
   wQoJr7XPGltAKCSd1sxa8ehYSXMdKJQ+IugvE6JrmojjhDHhwSFkY3V1W
   t4v/SR7w1BDd4kW1LUBhfej3Zi8Hd5eMoLn9IBDbrJmv67u8TKDxFapyV
   ZjGlsiD4jqaCwq4dee7P1eDasHblpZSSqwve0GrK2XHOSkFczb/1GBTqw
   Bd9ZyPnYtBx20NpC33BeMz9qHARCQVJVq/Zd+kMnDs/FFtcloWfaYM/IW
   w==;
X-CSE-ConnectionGUID: R5+N+s1fR32XeSqeTJBjVA==
X-CSE-MsgGUID: P/KAJsQDRjir+6+d1KT63w==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="17823915"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="17823915"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 06:34:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="17790851"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2024 06:34:14 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	eranian@google.com,
	ak@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] perf/x86/intel/ds: Don't clear the pebs_data_cfg for the last PEBS event
Date: Mon,  1 Apr 2024 06:33:20 -0700
Message-Id: <20240401133320.703971-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The MSR_PEBS_DATA_CFG is to configure which data groups should be
generated into a PEBS record. It's shared among counters. If there are
different configurations among counters, perf combines all the
configurations.

The first perf command as below requires a complete PEBS record
(including memory info, GPRs, XMMs, and LBRs). The second perf command
only requires a basic group. However, after the second perf command is
running, the MSR_PEBS_DATA_CFG is cleared. Only a basic group is
generated in a PEBS record, which is wrong. The required information
for the first perf command is missed.

 $perf record --intr-regs=AX,SP,XMM0 -a -C 8 -b -W -d -c 100000003
  -o /dev/null -e cpu/event=0xd0,umask=0x81/upp &
 $sleep 5
 $perf record  --per-thread  -c 1  -e cycles:pp --no-timestamp --no-tid
  taskset -c 8 ./noploop 1000

The first PEBS event is a system-wide PEBS event. The second PEBS event
is a per-thread event. When the thread is scheduled out, the
intel_pmu_pebs_del() is invoked to update the PEBS state. Since the
system-wide event is still available, the cpuc->n_pebs is 1. The
cpuc->pebs_data_cfg is cleared. The data configuration for the
system-wide PEBS event is lost.

The (cpuc->n_pebs == 1) was introduced in the commit b6a32f023fcc
("perf/x86: Fix PEBS threshold initialization"). At that time, it indeed
didn't hurt whether the state was updated during the removal. Because
only the threshold is updated. The calculation of the threshold takes
the last PEBS event into account. However, the commit b752ea0c28e3
("perf/x86/intel/ds: Flush PEBS DS when changing PEBS_DATA_CFG") delay
the threshold update, and clears the PEBS data config, which brings the
issue.

The PEBS data config update should not be shrink in the removal.

Fixes: b752ea0c28e3 ("perf/x86/intel/ds: Flush PEBS DS when changing PEBS_DATA_CFG")
Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/ds.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 2641ba620f12..20ddfed3e721 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1237,11 +1237,11 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
 	struct pmu *pmu = event->pmu;
 
 	/*
-	 * Make sure we get updated with the first PEBS
-	 * event. It will trigger also during removal, but
-	 * that does not hurt:
+	 * Make sure we get updated with the first PEBS event.
+	 * During removal, the pebs_data_cfg is still valid for
+	 * the last PEBS event. Don't clear it.
 	 */
-	if (cpuc->n_pebs == 1)
+	if ((cpuc->n_pebs == 1) && add)
 		cpuc->pebs_data_cfg = PEBS_UPDATE_DS_SW;
 
 	if (needed_cb != pebs_needs_sched_cb(cpuc)) {
-- 
2.35.1


