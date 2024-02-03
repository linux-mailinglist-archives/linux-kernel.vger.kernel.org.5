Return-Path: <linux-kernel+bounces-50906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 636DE84801D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9BD28B05A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BE1168BC;
	Sat,  3 Feb 2024 04:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dEq3RbJa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C70A11C82;
	Sat,  3 Feb 2024 04:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933050; cv=none; b=DLqrchm8LHid9bD5tON25lrML8TEku746iSseSo7pi1TQ3p0lKTs9n8FgUubPw6pK7Aj7QvFl04uG3KD4BdlgDf8+pOKhT27zHb2V43HGZRV1SZC5yOgcd5++oJYQRwvM1ljd72t6DdHAE2I3ikv+K5sLg1B66NFJbaNA87ny/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933050; c=relaxed/simple;
	bh=b0WZrZfGAqqetqqX3SCPK7BemWXSqpe0nj9hC32/ijk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KLrWA3yuHJV+hyCfg3JNIzxX6zHGCtMRBRA173/Mzn6QrQt0KS8MJpRNJ81s3nhoAI6eFx6QXo/1Vhwm64isihwBP73Dv8y1u7+4acLanJ13h41G4A00k8WvB5Ga2PDK7nJRfzTY/HoAt1R4U1i/WCMD24WldZMcSuwlYW/Boug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dEq3RbJa; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706933049; x=1738469049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=b0WZrZfGAqqetqqX3SCPK7BemWXSqpe0nj9hC32/ijk=;
  b=dEq3RbJalQFdDrkY8yCAwhF8VYVFRQFX8Aq/iTwuyDLXZhl7hpGanTCG
   VS2l/AjMadHawxZnfgD3vMGDV/Vkbubtf5kfaMify+b5V6D4QT1pMQhL/
   YDrfJHmnxH/ujFwMZPP7xyWBVOZWv851SRIXrKqT2YfkoIblw9G9JPZBW
   fTTAdBTer0AB5h8p/Rm62Ds7rqkMb7xmIkosoWKTqFRugctZPqEbNGldI
   TSPQvK1jfSbpsnbnyazowtvbrSojTm3L1wrSwdj2Nt+MljJspl16KoCbp
   QY9A1O9AmTVmeSMYl2H3bz9D01cuKDbm7fd6mys5JsRtM+iHNmUT4avtI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="4181427"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4181427"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 20:04:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="823382528"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="823382528"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2024 20:04:05 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Zhuocheng Ding <zhuocheng.ding@intel.com>,
	x86@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Zhao Liu <zhao1.liu@linux.intel.com>
Subject: [PATCH 8/9] x86/hreset: Configure history reset
Date: Fri,  2 Feb 2024 20:05:14 -0800
Message-Id: <20240203040515.23947-9-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
References: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Configure the MSR that controls the behavior of HRESET on each logical
processor.

Cc: Len Brown <len.brown@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Zhuocheng Ding <zhuocheng.ding@intel.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Patch cherry-picked from the IPC classes patchset
---
---
 arch/x86/kernel/cpu/common.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0b97bcde70c6..bce8719b47c9 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -381,6 +381,26 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 	cr4_clear_bits(X86_CR4_UMIP);
 }
 
+static u32 hardware_history_features __ro_after_init;
+
+static __always_inline void setup_hreset(struct cpuinfo_x86 *c)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_HRESET))
+		return;
+
+	/*
+	 * Use on all CPUs the hardware history features that the boot
+	 * CPU supports.
+	 */
+	if (c == &boot_cpu_data)
+		hardware_history_features = cpuid_ebx(0x20);
+
+	if (!hardware_history_features)
+		return;
+
+	wrmsrl(MSR_IA32_HW_HRESET_ENABLE, hardware_history_features);
+}
+
 /* These bits should not change their value after CPU init is finished. */
 static const unsigned long cr4_pinned_mask =
 	X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
@@ -1872,10 +1892,11 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Disable the PN if appropriate */
 	squash_the_stupid_serial_number(c);
 
-	/* Set up SMEP/SMAP/UMIP */
+	/* Set up SMEP/SMAP/UMIP/HRESET */
 	setup_smep(c);
 	setup_smap(c);
 	setup_umip(c);
+	setup_hreset(c);
 
 	/* Enable FSGSBASE instructions if available. */
 	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
-- 
2.25.1


