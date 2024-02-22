Return-Path: <linux-kernel+bounces-77186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011F08601E3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C6F28862A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D8514262D;
	Thu, 22 Feb 2024 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AaisjB1w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CB114F97B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627213; cv=none; b=Wj0vHpaWRvqGw7Ea9YUS3Tq+62xe44MZjKsBv3rMSzMi102/jPC4cjCLVLs6hwPmxvgssCeSM1sum1+n5yNsCm/IZMwAXFZD6cb9yr/BX9A4PoCxtM6jyghwMdYvq3LAbUI7Mu6ck0WW7zJMW0Uct/7LEULAW/0FYeDQW+/qTvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627213; c=relaxed/simple;
	bh=ffiyNtjtFtp2uyQu201PfaCVjvxQzBbaXVP6y2cCQAo=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=mJAjWKXH2GhppBxmVELbpa9aXkm3vS845llsBYfDj2ByjA2b3Neqro573JBLqUuqAA1+H4SUZODzDbIQSem2r+xX27zH0xkOIBQhrNWD0qjZnfblaGbRPlxkOQOPz1Iz/n5xiJFIpVKJQmtOQWo24M2ek5s64BGD7FbGkOHrDW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AaisjB1w; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627210; x=1740163210;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=ffiyNtjtFtp2uyQu201PfaCVjvxQzBbaXVP6y2cCQAo=;
  b=AaisjB1w+v+5IydgIMQL0TaNCEQIOpvxlTEZNGipJ4g3WmEv7bnntKAx
   gHMKXeN4DiAL7FtUuQAw76FDkHn7Gkqmxez7AuvdHmGGX/VxpjS6uol+c
   72L5t1HAbX8hZLcNrGj4CeAPJIQN5t+iecjVd191DRYFGIxvNBaH39pnY
   upaIwJ+bzcZMpjs2J5amY4FUxa2bnXmnsBAEW6X9+UA4GV9F3haBxunV/
   kSDsFR1gt6910xQjU3DbS9oKpHBxXZ1p67wMaxy1cD3hhD2kYxmCycn+G
   17fg3PJCw104THcNG8z2Lfu7GKzJCSkUS4PcGjRaLpbFKZMkQV3WhwJau
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13584600"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13584600"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:40:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10265286"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa004.jf.intel.com with ESMTP; 22 Feb 2024 10:40:09 -0800
Subject: [RFC][PATCH 32/34] x86/cpu/amd: Move memory encryption detection
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:40:08 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222184008.9A33B01E@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Right now the AMD memory encryption detection code is run on every CPU
despite it operating on 'bsp_addr_config' and doing setup_clear_cpu_cap()
which only affects 'boot_cpu_data'.

Move it to bsp_init_amd() where it belongs and change its name to match.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/cpu/amd.c |  110 ++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff -puN arch/x86/kernel/cpu/amd.c~early_init_amd-__init arch/x86/kernel/cpu/amd.c
--- a/arch/x86/kernel/cpu/amd.c~early_init_amd-__init	2024-02-22 10:09:04.201071279 -0800
+++ b/arch/x86/kernel/cpu/amd.c	2024-02-22 10:09:04.201071279 -0800
@@ -468,8 +468,62 @@ static void early_init_amd_mc(struct cpu
 #endif
 }
 
-static void bsp_init_amd(struct cpuinfo_x86 *c)
+static void bsp_detect_mem_encrypt(struct cpuinfo_x86 *c)
 {
+	u64 msr;
+
+	/*
+	 * BIOS support is required for SME and SEV.
+	 *   For SME: If BIOS has enabled SME then adjust x86_phys_bits by
+	 *	      the SME physical address space reduction value.
+	 *	      If BIOS has not enabled SME then don't advertise the
+	 *	      SME feature (set in scattered.c).
+	 *	      If the kernel has not enabled SME via any means then
+	 *	      don't advertise the SME feature.
+	 *   For SEV: If BIOS has not enabled SEV then don't advertise the
+	 *            SEV and SEV_ES feature (set in scattered.c).
+	 *
+	 *   In all cases, since support for SME and SEV requires long mode,
+	 *   don't advertise the feature under CONFIG_X86_32.
+	 */
+	if (cpu_has(c, X86_FEATURE_SME) || cpu_has(c, X86_FEATURE_SEV)) {
+		/* Check if memory encryption is enabled */
+		rdmsrl(MSR_AMD64_SYSCFG, msr);
+		if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
+			goto clear_all;
+
+		/*
+		 * Always adjust physical address bits. Even though this
+		 * will be a value above 32-bits this is still done for
+		 * CONFIG_X86_32 so that accurate values are reported.
+		 */
+		bsp_addr_config.phys_addr_reduction_bits =
+			(cpuid_ebx(0x8000001f) >> 6) & 0x3f;
+
+		if (IS_ENABLED(CONFIG_X86_32))
+			goto clear_all;
+
+		if (!sme_me_mask)
+			setup_clear_cpu_cap(X86_FEATURE_SME);
+
+		rdmsrl(MSR_K7_HWCR, msr);
+		if (!(msr & MSR_K7_HWCR_SMMLOCK))
+			goto clear_sev;
+
+		return;
+
+clear_all:
+		setup_clear_cpu_cap(X86_FEATURE_SME);
+clear_sev:
+		setup_clear_cpu_cap(X86_FEATURE_SEV);
+		setup_clear_cpu_cap(X86_FEATURE_SEV_ES);
+	}
+}
+
+static void __init bsp_init_amd(struct cpuinfo_x86 *c)
+{
+	bsp_detect_mem_encrypt(c);
+
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC)) {
 
 		if (c->x86 > 0x10 ||
@@ -593,58 +647,6 @@ warn:
 	WARN_ONCE(1, "Family 0x%x, model: 0x%x??\n", c->x86, c->x86_model);
 }
 
-static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
-{
-	u64 msr;
-
-	/*
-	 * BIOS support is required for SME and SEV.
-	 *   For SME: If BIOS has enabled SME then adjust x86_phys_bits by
-	 *	      the SME physical address space reduction value.
-	 *	      If BIOS has not enabled SME then don't advertise the
-	 *	      SME feature (set in scattered.c).
-	 *	      If the kernel has not enabled SME via any means then
-	 *	      don't advertise the SME feature.
-	 *   For SEV: If BIOS has not enabled SEV then don't advertise the
-	 *            SEV and SEV_ES feature (set in scattered.c).
-	 *
-	 *   In all cases, since support for SME and SEV requires long mode,
-	 *   don't advertise the feature under CONFIG_X86_32.
-	 */
-	if (cpu_has(c, X86_FEATURE_SME) || cpu_has(c, X86_FEATURE_SEV)) {
-		/* Check if memory encryption is enabled */
-		rdmsrl(MSR_AMD64_SYSCFG, msr);
-		if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
-			goto clear_all;
-
-		/*
-		 * Always adjust physical address bits. Even though this
-		 * will be a value above 32-bits this is still done for
-		 * CONFIG_X86_32 so that accurate values are reported.
-		 */
-		bsp_addr_config.phys_addr_reduction_bits =
-			(cpuid_ebx(0x8000001f) >> 6) & 0x3f;
-
-		if (IS_ENABLED(CONFIG_X86_32))
-			goto clear_all;
-
-		if (!sme_me_mask)
-			setup_clear_cpu_cap(X86_FEATURE_SME);
-
-		rdmsrl(MSR_K7_HWCR, msr);
-		if (!(msr & MSR_K7_HWCR_SMMLOCK))
-			goto clear_sev;
-
-		return;
-
-clear_all:
-		setup_clear_cpu_cap(X86_FEATURE_SME);
-clear_sev:
-		setup_clear_cpu_cap(X86_FEATURE_SEV);
-		setup_clear_cpu_cap(X86_FEATURE_SEV_ES);
-	}
-}
-
 static void early_init_amd(struct cpuinfo_x86 *c)
 {
 	u64 value;
@@ -715,8 +717,6 @@ static void early_init_amd(struct cpuinf
 	if (c->x86 == 0x16 && c->x86_model <= 0xf)
 		msr_set_bit(MSR_AMD64_LS_CFG, 15);
 
-	early_detect_mem_encrypt(c);
-
 	/* Re-enable TopologyExtensions if switched off by BIOS */
 	if (c->x86 == 0x15 &&
 	    (c->x86_model >= 0x10 && c->x86_model <= 0x6f) &&
_

