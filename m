Return-Path: <linux-kernel+bounces-77171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA888601D7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEDA9B2AE6F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6098114036A;
	Thu, 22 Feb 2024 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I9hzTZxp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC2713BADF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627191; cv=none; b=PT6r0ncInl0uEZ7vPq5Ga4ToTSjJTGAlhV2kpiCtUqyJzfiW+62dweBwhGaXoE+3t3AOddaNjdjT67TFPb0Gf+CtSS0Z2eHKntl5wpBnNOq2OJW6kFp4TPgEqXVfA7Us94KPakrnZhoIIA28JIVozwwvDFQ1eekqbH++FIQ/TT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627191; c=relaxed/simple;
	bh=buneXK45S59L265wMYbZIbp62iDWv2uaPtRPDjg659o=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=R6lOHY18iExwQP8KQ6LwygOkH4zuUR4TN69+7WE4PmP8mzsnInPYWYqLogFlQh9zaLyzi9sxUEKY35ews4XbuEhrpakv4Jm5GKJlBcDcVuM6JsRSSHUV9aft/7KDkDn+wS6MBx4hsizryCcduUiNglCgiTkDmmhphazDiFSxW7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I9hzTZxp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627191; x=1740163191;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=buneXK45S59L265wMYbZIbp62iDWv2uaPtRPDjg659o=;
  b=I9hzTZxpfBReaGeCDchDKhaAiEYy/6+MJj4eyVwR918nKwR4z+gycbm6
   QhxljElDmPCdq4YeMmuk8Y5v3XN2aR8nX+5y+ekKlba73wlriQRPbqW/l
   flY47BQy2GJKFR1WVVugmksNLtXzHhpVNuy4ZojwT7I88ShEvmRy0Pplk
   OzWmipRHUEMFOerhUwEtwnBry7gZii2byKfqzxIX+KEBzVZGbl3KLyI2v
   lMETii/FwjG4bstfRa6YHRohs6aCgJTJYPfYBRIMqxhohbel0g4K60R1u
   Vytsyjgwa4t3tAhuDCFlszw8G9Rzgn6a7oBso2ANUjyAm7uDEjkKN0a99
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031816"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031816"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975536"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:50 -0800
Subject: [RFC][PATCH 17/34] x86/cpu: Move virtual address limit out of cpuinfo_x86
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:49 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183949.9E1C5A1E@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

There are no longer any direct references to
cpuinfo_x86->x86_virt_bits.  The only remaining references are to
'boot_cpu_data' via the x86_virt_bits() helper.

This means the farce that x86_virt_bits is per-cpu data can end.
Remove it from cpuinfo_x86 and add it to 'x86_config'.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/processor.h |    6 +++---
 b/arch/x86/kernel/cpu/common.c     |    8 +++-----
 b/arch/x86/mm/maccess.c            |    9 +++++----
 3 files changed, 11 insertions(+), 12 deletions(-)

diff -puN arch/x86/include/asm/processor.h~no-cpu-data-virt_bits arch/x86/include/asm/processor.h
--- a/arch/x86/include/asm/processor.h~no-cpu-data-virt_bits	2024-02-22 10:08:56.748778725 -0800
+++ b/arch/x86/include/asm/processor.h	2024-02-22 10:08:56.752778882 -0800
@@ -117,7 +117,6 @@ struct cpuinfo_x86 {
 #ifdef CONFIG_X86_VMX_FEATURE_NAMES
 	__u32			vmx_capability[NVMXINTS];
 #endif
-	__u8			x86_virt_bits;
 	/* CPUID returned core id bits: */
 	__u8			x86_coreid_bits;
 	/* Max extended CPUID function supported: */
@@ -182,8 +181,9 @@ struct x86_addr_config {
  * modified after that.
  */
 struct x86_sys_config {
-	/* Physical address bits supported by all processors */
+	/* Address bits supported by all processors */
 	u8	phys_bits;
+	u8	virt_bits;
 };
 
 extern struct x86_sys_config x86_config;
@@ -800,7 +800,7 @@ static inline u8 x86_phys_bits(void)
 
 static inline u8 x86_virt_bits(void)
 {
-	return boot_cpu_data.x86_virt_bits;
+	return x86_config.virt_bits;
 }
 
 static inline u8 x86_clflush_size(void)
diff -puN arch/x86/kernel/cpu/common.c~no-cpu-data-virt_bits arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~no-cpu-data-virt_bits	2024-02-22 10:08:56.748778725 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-02-22 10:08:56.752778882 -0800
@@ -1106,17 +1106,17 @@ void get_cpu_address_sizes(struct cpuinf
 	if (vp_bits_from_cpuid) {
 		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
 
-		c->x86_virt_bits = (eax >> 8) & 0xff;
+		x86_config.virt_bits = (eax >> 8) & 0xff;
 		x86_config.phys_bits = eax & 0xff;
 	} else {
 		if (IS_ENABLED(CONFIG_X86_64)) {
 			x86_config.phys_bits = 36;
+			x86_config.virt_bits = 48;
 			c->x86_clflush_size = 64;
-			c->x86_virt_bits = 48;
 		} else {
 			x86_config.phys_bits = 32;
+			x86_config.virt_bits = 32;
 			c->x86_clflush_size = 32;
-			c->x86_virt_bits = 32;
 
 			if (cpu_has(c, X86_FEATURE_PAE) ||
 			    cpu_has(c, X86_FEATURE_PSE36))
@@ -1827,11 +1827,9 @@ static void identify_cpu(struct cpuinfo_
 	c->topo.l2c_id = BAD_APICID;
 #ifdef CONFIG_X86_64
 	c->x86_clflush_size = 64;
-	c->x86_virt_bits = 48;
 #else
 	c->cpuid_level = -1;	/* CPUID not detected */
 	c->x86_clflush_size = 32;
-	c->x86_virt_bits = 32;
 #endif
 	c->x86_cache_alignment = x86_clflush_size();
 	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
diff -puN arch/x86/mm/maccess.c~no-cpu-data-virt_bits arch/x86/mm/maccess.c
--- a/arch/x86/mm/maccess.c~no-cpu-data-virt_bits	2024-02-22 10:08:56.752778882 -0800
+++ b/arch/x86/mm/maccess.c	2024-02-22 10:08:56.752778882 -0800
@@ -16,11 +16,12 @@ bool copy_from_kernel_nofault_allowed(co
 		return false;
 
 	/*
-	 * Allow everything during early boot before 'x86_virt_bits'
-	 * is initialized.  Needed for instruction decoding in early
-	 * exception handlers.
+	 * Allow everything during early boot before 'virt_bits' is
+	 * initialized.  Needed for instruction decoding in early
+	 * exception handlers.  Avoid the helper because it may do
+	 * error checking for being uninitiazed.
 	 */
-	if (!x86_virt_bits())
+	if (!x86_config.virt_bits)
 		return true;
 
 	return __is_canonical_address(vaddr, x86_virt_bits());
_

