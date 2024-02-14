Return-Path: <linux-kernel+bounces-65472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 688E3854D7F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AE428F993
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1155EE7E;
	Wed, 14 Feb 2024 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TwF2HKBl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C30D5C906;
	Wed, 14 Feb 2024 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926308; cv=none; b=fSPmGMA+4zfDclcWz7wZYHsGyG7dbgJFn3rlWr5qcmQZP+giE2OBDebSD2TK9Jx1WUS2j3xtswKgLYFGjkHNAfNYNHrhg4v/1OxE66Bbkl1uCbszD1q0YzAHM/aW4ltBHZLpFIwastQkt7pynwoTLYEGcfbyvY1JqUeqHPyQdt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926308; c=relaxed/simple;
	bh=av2l3DT4NNuDgqnCviERNX6CQA5HMtu7XOCwtcpS+1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YOxyAwsodSvcTSNXjzQUviT6g/njb8rnSPhOgPoboyrMEt1utffReuRT3nIU7Y01tpKpgEkrZTJGWa0UYR0Tbf2Pf7YyJEmLkM3pmEBFWKh+hMihMsuY85tuQX4jM7Bs2AxK0yL2b5CPf0DvY+lPimPUKC3UUBH9Z6BZS71Yh+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TwF2HKBl; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707926307; x=1739462307;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=av2l3DT4NNuDgqnCviERNX6CQA5HMtu7XOCwtcpS+1I=;
  b=TwF2HKBloaJxf28A8QeePFzTwbg/+Ccfhc0li9TEbhDshp2OPiUtVZtc
   +IEy8McpTKFJiQu+s2T6ox11hVnFmDaEE9fA6PPQZNHwyKrB8bJEVFv8+
   AM3cxzo29auRmB9ciT7PMPYaCXm9WdaGYEhSiqYilv16tVBhLYhLE4wbc
   RzPNmXbLiRmepJbF1ZE6xuUffLCP0PIuNmuRxSUvh3nQmQ42clBiG6+di
   SgdhrReLi2g7nCiyxs/7azEbPBxCd0RVRJitHY1UOODqRQLxeST8Wghsd
   45eywLqs/+Eh4kPMcmU84c0h02dualbjQPIZFJSbUaAzCWPb9CIS6XnfJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19392327"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="19392327"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 07:58:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="34286813"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 14 Feb 2024 07:58:25 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: irogers@google.com,
	mpetlan@redhat.com,
	eranian@google.com,
	ak@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] perf/x86/intel/uncore: Fix the bits of the CHA extended umask for SPR
Date: Wed, 14 Feb 2024 07:57:40 -0800
Message-Id: <20240214155740.3256216-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The perf stat errors out with UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL
event.

 $perf stat -e uncore_cha_55/event=0x35,umask=0x10c0008101/ -a -- ls
    event syntax error: '..0x35,umask=0x10c0008101/'
                                      \___ Bad event or PMU

The definition of the CHA umask is config:8-15,32-55, which is 32bit.
However, the umask of the event is bigger than 32bit.
This is an error in the original uncore spec.

Add a new umask_ext5 for the new CHA umask range.

Fixes: 949b11381f81 ("perf/x86/intel/uncore: Add Sapphire Rapids server CHA support")
Closes: https://lore.kernel.org/linux-perf-users/alpine.LRH.2.20.2401300733310.11354@Diego/
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/uncore_snbep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index a96496bef678..7924f315269a 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -461,6 +461,7 @@
 #define SPR_UBOX_DID				0x3250
 
 /* SPR CHA */
+#define SPR_CHA_EVENT_MASK_EXT			0xffffffff
 #define SPR_CHA_PMON_CTL_TID_EN			(1 << 16)
 #define SPR_CHA_PMON_EVENT_MASK			(SNBEP_PMON_RAW_EVENT_MASK | \
 						 SPR_CHA_PMON_CTL_TID_EN)
@@ -477,6 +478,7 @@ DEFINE_UNCORE_FORMAT_ATTR(umask_ext, umask, "config:8-15,32-43,45-55");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext2, umask, "config:8-15,32-57");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext3, umask, "config:8-15,32-39");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext4, umask, "config:8-15,32-55");
+DEFINE_UNCORE_FORMAT_ATTR(umask_ext5, umask, "config:8-15,32-63");
 DEFINE_UNCORE_FORMAT_ATTR(qor, qor, "config:16");
 DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
 DEFINE_UNCORE_FORMAT_ATTR(tid_en, tid_en, "config:19");
@@ -5957,7 +5959,7 @@ static struct intel_uncore_ops spr_uncore_chabox_ops = {
 
 static struct attribute *spr_uncore_cha_formats_attr[] = {
 	&format_attr_event.attr,
-	&format_attr_umask_ext4.attr,
+	&format_attr_umask_ext5.attr,
 	&format_attr_tid_en2.attr,
 	&format_attr_edge.attr,
 	&format_attr_inv.attr,
@@ -5993,7 +5995,7 @@ ATTRIBUTE_GROUPS(uncore_alias);
 static struct intel_uncore_type spr_uncore_chabox = {
 	.name			= "cha",
 	.event_mask		= SPR_CHA_PMON_EVENT_MASK,
-	.event_mask_ext		= SPR_RAW_EVENT_MASK_EXT,
+	.event_mask_ext		= SPR_CHA_EVENT_MASK_EXT,
 	.num_shared_regs	= 1,
 	.constraints		= skx_uncore_chabox_constraints,
 	.ops			= &spr_uncore_chabox_ops,
-- 
2.35.1


