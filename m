Return-Path: <linux-kernel+bounces-77170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D77C8601D3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5851F291D3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73C413BAF6;
	Thu, 22 Feb 2024 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YsxrWZa+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F886AF8E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627190; cv=none; b=EYAZy7n3Sx5beT083NILmsSYl5QULd5yI/A4RlLVEwUVwNS1t+6tfV1iHspTlk011dQbqmSYblo9XLbKvANGxSQ1ecak92L9DvpzNM/ux4n6/w2wEqD7sfnJk9uA3f0pU2XSXugEZQLULMA/9YDMVFXsFf0jJjPrcepaYym8z6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627190; c=relaxed/simple;
	bh=rjA2Z8evUUaXAhyNDxtdKE3+0AQEccNWNKV6rzUVbYE=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=aR0ITJAujxSrfmULzY2a1VqLCz/Y459fs+gZdbJamuB3oFAKCQbHlxyPK1FzC7tgoozoxqOkDGk25/aDgGKluV6nKMWvvLI6olx29PcjlgrSFFaY6RbQqqE0L5XpoSznEw3wkQsLawhLEO9KG2ZE7fLaSNTnR37OGSFIn3+VWn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YsxrWZa+; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627189; x=1740163189;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=rjA2Z8evUUaXAhyNDxtdKE3+0AQEccNWNKV6rzUVbYE=;
  b=YsxrWZa+jEObrCg6oCL6cDtT7Zbs04GAR24RfVMWECB3aMMV9UrRfuCD
   SBU83y/LjtdRiP2MZvdnXjsxGQr6YsTKS5OVTQynto1jwWk5GrBeBHNr2
   ZRkrKdtitYT0AYPPqu1wswzz6b6O5qMgUlXz5ghLxBulkzXZmKlF67j3V
   2o1iDD872007fz+HAPkrCC9D5dAyd2/P46lAWMe6/nOMjaFV2vLTzYIYq
   48MMS+wEf+3yYs0qU5SAyDR5EMMnkRpn/8uWqUKSKjhJkphgXpyKxrsZb
   ojl1BrmiLJrmBZPnk+TweCsPFJCWU/QsrKd7VHGG2V0b3E1k9HpC30t+i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031810"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031810"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975529"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:48 -0800
Subject: [RFC][PATCH 16/34] x86/cpu: Move physical address limit out of cpuinfo_x86
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:48 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183947.32D9A553@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

There are no longer any direct references to cpuinfo_x86->x86_phys_bits.
The only remaining references are to 'boot_cpu_data' via the
x86_phys_bits() helper.

This means the farce that x86_phys_bits is per-cpu data can end.  Remove
it from cpuinfo_x86 and add it to a new global data structure:
'x86_config'.  (Better names welcome)

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/processor.h |   16 ++++++++++++++--
 b/arch/x86/kernel/cpu/common.c     |   12 ++++++------
 b/arch/x86/kernel/setup.c          |    1 +
 3 files changed, 21 insertions(+), 8 deletions(-)

diff -puN arch/x86/include/asm/processor.h~no-cpu-data-phys_bits arch/x86/include/asm/processor.h
--- a/arch/x86/include/asm/processor.h~no-cpu-data-phys_bits	2024-02-22 10:08:56.220757996 -0800
+++ b/arch/x86/include/asm/processor.h	2024-02-22 10:08:56.228758310 -0800
@@ -118,7 +118,6 @@ struct cpuinfo_x86 {
 	__u32			vmx_capability[NVMXINTS];
 #endif
 	__u8			x86_virt_bits;
-	__u8			x86_phys_bits;
 	/* CPUID returned core id bits: */
 	__u8			x86_coreid_bits;
 	/* Max extended CPUID function supported: */
@@ -176,6 +175,19 @@ struct x86_addr_config {
 	u8 phys_addr_reduction_bits;
 };
 
+/*
+ * System-wide configuration that is shared by all processors.
+ *
+ * Built in early_cpu_init() on the boot CPU and and never
+ * modified after that.
+ */
+struct x86_sys_config {
+	/* Physical address bits supported by all processors */
+	u8	phys_bits;
+};
+
+extern struct x86_sys_config x86_config;
+
 #define X86_VENDOR_INTEL	0
 #define X86_VENDOR_CYRIX	1
 #define X86_VENDOR_AMD		2
@@ -783,7 +795,7 @@ static inline void weak_wrmsr_fence(void
 
 static inline u8 x86_phys_bits(void)
 {
-	return boot_cpu_data.x86_phys_bits;
+	return x86_config.phys_bits;
 }
 
 static inline u8 x86_virt_bits(void)
diff -puN arch/x86/kernel/cpu/common.c~no-cpu-data-phys_bits arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~no-cpu-data-phys_bits	2024-02-22 10:08:56.224758153 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-02-22 10:08:56.228758310 -0800
@@ -1107,27 +1107,27 @@ void get_cpu_address_sizes(struct cpuinf
 		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
 
 		c->x86_virt_bits = (eax >> 8) & 0xff;
-		c->x86_phys_bits = eax & 0xff;
+		x86_config.phys_bits = eax & 0xff;
 	} else {
 		if (IS_ENABLED(CONFIG_X86_64)) {
+			x86_config.phys_bits = 36;
 			c->x86_clflush_size = 64;
-			c->x86_phys_bits = 36;
 			c->x86_virt_bits = 48;
 		} else {
+			x86_config.phys_bits = 32;
 			c->x86_clflush_size = 32;
 			c->x86_virt_bits = 32;
-			c->x86_phys_bits = 32;
 
 			if (cpu_has(c, X86_FEATURE_PAE) ||
 			    cpu_has(c, X86_FEATURE_PSE36))
-				c->x86_phys_bits = 36;
+				x86_config.phys_bits = 36;
 		}
 	}
-	c->x86_cache_bits = c->x86_phys_bits;
+	c->x86_cache_bits = x86_config.phys_bits;
 	c->x86_cache_alignment = x86_clflush_size();
 
 	/* Do this last to avoid affecting ->x86_cache_bits. */
-	c->x86_phys_bits -= bsp_addr_config.phys_addr_reduction_bits;
+	x86_config.phys_bits -= bsp_addr_config.phys_addr_reduction_bits;
 }
 
 static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
diff -puN arch/x86/kernel/setup.c~no-cpu-data-phys_bits arch/x86/kernel/setup.c
--- a/arch/x86/kernel/setup.c~no-cpu-data-phys_bits	2024-02-22 10:08:56.224758153 -0800
+++ b/arch/x86/kernel/setup.c	2024-02-22 10:08:56.228758310 -0800
@@ -132,6 +132,7 @@ struct cpuinfo_x86 boot_cpu_data __read_
 EXPORT_SYMBOL(boot_cpu_data);
 
 struct x86_addr_config bsp_addr_config;
+struct x86_sys_config x86_config __read_mostly;
 
 #if !defined(CONFIG_X86_PAE) || defined(CONFIG_X86_64)
 __visible unsigned long mmu_cr4_features __ro_after_init;
_

