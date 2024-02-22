Return-Path: <linux-kernel+bounces-77178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A690E8601D9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320851F29C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1449C14DFD6;
	Thu, 22 Feb 2024 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZTrol+e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9E914CAD5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627201; cv=none; b=pw2P6BXdOlVutFYYov7Nwiefa293at6VCv8I4o8qpZXw1JkOeqfpkrSKRxWTcIqUfvjXRJ14vj+9mmfEUXxIfdaY1C5HWop4dBsxHBPWyXYJ/AWngfGp8J6sRbdVt04Ye1tL/cIEpsuhD5cTkGkRXhR+vFX8lBNp7ULvhNijM04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627201; c=relaxed/simple;
	bh=g9iOQCfCOGeDHAxU5yPd22RT/hffnnPIA4rM0xaPx8k=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=d40yDAzKFcBntXLjc2dAOOwaTe+v83+U9nHgmuqSdLg+rixYNq2AuF/Vo90Z23XbapLBPOdhf5+o0yqvUu+C+s9MyJmYNPDvjXoT2RH0VENtnq5qzBgplON/1pA0g1kS4ZYJNFrAsrNldwXY3oUJkO1h0UmSiCHSyMx+rFxtqh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZTrol+e; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627199; x=1740163199;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=g9iOQCfCOGeDHAxU5yPd22RT/hffnnPIA4rM0xaPx8k=;
  b=ZZTrol+ejY0zPk4sWMIbVf27nZdPRbQltD4HlA893sxo8vpSPLPaMj00
   5vAoT+EwU8rws8xp710uVW6FYdG2G/g2glku6DoQXOqvJipYXdh0RCbET
   4Ubxmy56Q47HxvNA8KBxNIDErmRJyF6E7QeQtaIF2vhjb6iKqtoVIIWWn
   XQgZZEnhddcxT4B3ESOSqur/wTz/rKuqpSmEpvuL4+ejYgJWkBGxabbKq
   WJ08me6J5zEOhz2i097xHv72zuwdlomhI1BhyXldraAELOjhD+geCUJUk
   PjKhH25OskuxhBGWtKaJQ4zr+aD6HG6bDkO6eD72EP2uzFkLB+JS8jom+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13584547"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13584547"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10265228"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa004.jf.intel.com with ESMTP; 22 Feb 2024 10:39:59 -0800
Subject: [RFC][PATCH 24/34] x86/cpu: Establish 'min_cache_bits' configuration
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:58 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183958.F5A0812A@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Continue moving towards a setup where code never tweaks 'boot_cpu_data'.

Code must establish their intent in 'x86_addr_config' and then later
code will use that config information to establish the system-wide
config.

The L1TF wants to tweak x86_cache_bits.  Let it do this, but move
the code away from bugs.c so that ti can be easily called earlier
en boot.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/processor.h |    6 +++++
 b/arch/x86/kernel/cpu/bugs.c       |   41 -------------------------------------
 b/arch/x86/kernel/cpu/common.c     |    2 +
 b/arch/x86/kernel/cpu/intel.c      |   40 ++++++++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 41 deletions(-)

diff -puN arch/x86/include/asm/processor.h~bsp-min_cache_bits arch/x86/include/asm/processor.h
--- a/arch/x86/include/asm/processor.h~bsp-min_cache_bits	2024-02-22 10:09:00.220915031 -0800
+++ b/arch/x86/include/asm/processor.h	2024-02-22 10:09:00.224915188 -0800
@@ -177,6 +177,12 @@ struct x86_addr_config {
 	 * will take place at a more coarse granularity.
 	 */
 	u8 cache_align_mult;
+
+	/*
+	 * Specify a floor for the number of bits that the CPU
+	 * caches comprehend.  Used only for L1TF mitigation.
+	 */
+	u8 min_cache_bits;
 };
 
 /*
diff -puN arch/x86/kernel/cpu/bugs.c~bsp-min_cache_bits arch/x86/kernel/cpu/bugs.c
--- a/arch/x86/kernel/cpu/bugs.c~bsp-min_cache_bits	2024-02-22 10:09:00.220915031 -0800
+++ b/arch/x86/kernel/cpu/bugs.c	2024-02-22 10:09:00.224915188 -0800
@@ -2237,45 +2237,6 @@ EXPORT_SYMBOL_GPL(l1tf_mitigation);
 enum vmx_l1d_flush_state l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_AUTO;
 EXPORT_SYMBOL_GPL(l1tf_vmx_mitigation);
 
-/*
- * These CPUs all support 44bits physical address space internally in the
- * cache but CPUID can report a smaller number of physical address bits.
- *
- * The L1TF mitigation uses the top most address bit for the inversion of
- * non present PTEs. When the installed memory reaches into the top most
- * address bit due to memory holes, which has been observed on machines
- * which report 36bits physical address bits and have 32G RAM installed,
- * then the mitigation range check in l1tf_select_mitigation() triggers.
- * This is a false positive because the mitigation is still possible due to
- * the fact that the cache uses 44bit internally. Use the cache bits
- * instead of the reported physical bits and adjust them on the affected
- * machines to 44bit if the reported bits are less than 44.
- */
-static void override_cache_bits(struct cpuinfo_x86 *c)
-{
-	if (c->x86 != 6)
-		return;
-
-	switch (c->x86_model) {
-	case INTEL_FAM6_NEHALEM:
-	case INTEL_FAM6_WESTMERE:
-	case INTEL_FAM6_SANDYBRIDGE:
-	case INTEL_FAM6_IVYBRIDGE:
-	case INTEL_FAM6_HASWELL:
-	case INTEL_FAM6_HASWELL_L:
-	case INTEL_FAM6_HASWELL_G:
-	case INTEL_FAM6_BROADWELL:
-	case INTEL_FAM6_BROADWELL_G:
-	case INTEL_FAM6_SKYLAKE_L:
-	case INTEL_FAM6_SKYLAKE:
-	case INTEL_FAM6_KABYLAKE_L:
-	case INTEL_FAM6_KABYLAKE:
-		if (c->x86_cache_bits < 44)
-			c->x86_cache_bits = 44;
-		break;
-	}
-}
-
 static void __init l1tf_select_mitigation(void)
 {
 	u64 half_pa;
@@ -2288,8 +2249,6 @@ static void __init l1tf_select_mitigatio
 	else if (cpu_mitigations_auto_nosmt())
 		l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
 
-	override_cache_bits(&boot_cpu_data);
-
 	switch (l1tf_mitigation) {
 	case L1TF_MITIGATION_OFF:
 	case L1TF_MITIGATION_FLUSH_NOWARN:
diff -puN arch/x86/kernel/cpu/common.c~bsp-min_cache_bits arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~bsp-min_cache_bits	2024-02-22 10:09:00.220915031 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-02-22 10:09:00.228915345 -0800
@@ -1139,6 +1139,8 @@ void get_cpu_address_sizes(struct cpuinf
 	x86_config.clflush_size = detect_clflush_size(c);
 
 	c->x86_cache_bits = x86_config.phys_bits;
+	if (c->x86_cache_bits < bsp_addr_config.min_cache_bits)
+		c->x86_cache_bits = bsp_addr_config.min_cache_bits;
 
 	x86_config.cache_alignment = x86_clflush_size();
 	if (bsp_addr_config.cache_align_mult)
diff -puN arch/x86/kernel/cpu/intel.c~bsp-min_cache_bits arch/x86/kernel/cpu/intel.c
--- a/arch/x86/kernel/cpu/intel.c~bsp-min_cache_bits	2024-02-22 10:09:00.224915188 -0800
+++ b/arch/x86/kernel/cpu/intel.c	2024-02-22 10:09:00.228915345 -0800
@@ -395,6 +395,44 @@ detect_keyid_bits:
 	return keyid_bits;
 }
 
+/*
+ * These CPUs all support 44bits physical address space internally in the
+ * cache but CPUID can report a smaller number of physical address bits.
+ *
+ * The L1TF mitigation uses the top most address bit for the inversion of
+ * non present PTEs. When the installed memory reaches into the top most
+ * address bit due to memory holes, which has been observed on machines
+ * which report 36bits physical address bits and have 32G RAM installed,
+ * then the mitigation range check in l1tf_select_mitigation() triggers.
+ * This is a false positive because the mitigation is still possible due to
+ * the fact that the cache uses 44bit internally. Use the cache bits
+ * instead of the reported physical bits and adjust them on the affected
+ * machines to 44bit if the reported bits are less than 44.
+ */
+static void set_min_cache_bits(struct cpuinfo_x86 *c)
+{
+	if (c->x86 != 6)
+		return;
+
+	switch (c->x86_model) {
+	case INTEL_FAM6_NEHALEM:
+	case INTEL_FAM6_WESTMERE:
+	case INTEL_FAM6_SANDYBRIDGE:
+	case INTEL_FAM6_IVYBRIDGE:
+	case INTEL_FAM6_HASWELL:
+	case INTEL_FAM6_HASWELL_L:
+	case INTEL_FAM6_HASWELL_G:
+	case INTEL_FAM6_BROADWELL:
+	case INTEL_FAM6_BROADWELL_G:
+	case INTEL_FAM6_SKYLAKE_L:
+	case INTEL_FAM6_SKYLAKE:
+	case INTEL_FAM6_KABYLAKE_L:
+	case INTEL_FAM6_KABYLAKE:
+		bsp_addr_config.min_cache_bits = 44;
+		break;
+	}
+}
+
 static void bsp_init_intel(struct cpuinfo_x86 *c)
 {
 	int keyid_bits = 0;
@@ -418,6 +456,8 @@ static void bsp_init_intel(struct cpuinf
 	/* Netburst reports 64 bytes clflush size, but does IO in 128 bytes */
 	if (c->x86 == 15)
 		bsp_addr_config.cache_align_mult = 2;
+
+	set_min_cache_bits(c);
 }
 
 #ifdef CONFIG_X86_32
_

