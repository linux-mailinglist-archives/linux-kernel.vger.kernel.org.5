Return-Path: <linux-kernel+bounces-77179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 157BF8601DA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D6828C782
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD57214DFEC;
	Thu, 22 Feb 2024 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+0laI0Z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1714DFCA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627202; cv=none; b=EPXBxyrifDtEHKdIM4vtVYrWeLu7FLMurkP5iQzPd8Z2v2BJu3Frt3kKhr3ZBUHodrkKsMXApst9YmQc1HKItdcvk1ULKqlbZDSTXt2CPv7IhDTiwZUr+u5JgahISl8bfplChT5HkuTm26kT7s/6aK9o0RFGKU4EpsJEv5gcq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627202; c=relaxed/simple;
	bh=EaW9U2GVh2a4ff8twfadEFuAzYEJkIYZvc+7BRdXeIw=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=WppTmIgQ4cwNntKVBAixtwTc7zcAQw7ffuIrnIHbJBk8/09QrjE8hLfV8I1vTiFddIO0O6o0BNeWtZXOA5+mBt40sPufI1VGtv15LAdTWAFxLTW0FuDYfjR7MdYLZtaFilPVmkBJMnn4GbxPMDZ4HxYy1Hgx09U6C9vlihKQ6Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+0laI0Z; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627201; x=1740163201;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=EaW9U2GVh2a4ff8twfadEFuAzYEJkIYZvc+7BRdXeIw=;
  b=P+0laI0ZOC2XmHvMvquboye3X1GAbP46sEVPpfck1TtjvfFQP1XWEF+B
   lF3ynbaMTxBeGRtWKtV+myMc4Rj7hPLzZMWCEJuWlRyLPlPwMHAevc4u6
   8fNH0NzFL0l0G4UpStfqOnp+g0bMLDBf73qMdqCqy/RBE29im0hH8MxmU
   +hOydID5OJdCxHrf6YnCidYunJmzI3wlVlKvBgB+LaYhACUnWYtTnMR6Q
   36EK2ORrwYScGbpBT0ehwdUks2OYgVNrXsNQ7xRSlOHSnhfdrt+hwveO9
   L56JT+O1j0ehbi9Eb+y94k+sFp3d8VgEffsiMjkS7UrYQIl4x8J1sAOEB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13584552"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13584552"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10265229"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa004.jf.intel.com with ESMTP; 22 Feb 2024 10:40:00 -0800
Subject: [RFC][PATCH 25/34] x86/cpu: Move cache bits to global config
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:59 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183959.7061C5F3@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

x86_cache_bits is established and stored per-cpu despite being system-wide.
Move it from 'struct cpuinfo_x86' to 'x86_config' and give it a helper.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/processor.h |   10 +++++++---
 b/arch/x86/kernel/cpu/common.c     |    8 ++++----
 b/arch/x86/kvm/mmu/spte.c          |    6 +++---
 3 files changed, 14 insertions(+), 10 deletions(-)

diff -puN arch/x86/include/asm/processor.h~config-cache_bits arch/x86/include/asm/processor.h
--- a/arch/x86/include/asm/processor.h~config-cache_bits	2024-02-22 10:09:00.768936544 -0800
+++ b/arch/x86/include/asm/processor.h	2024-02-22 10:09:00.772936701 -0800
@@ -154,8 +154,6 @@ struct cpuinfo_x86 {
 	/*  Is SMT active on this core? */
 	bool			smt_active;
 	u32			microcode;
-	/* Address space bits used by the cache internally */
-	u8			x86_cache_bits;
 	unsigned		initialized : 1;
 } __randomize_layout;
 
@@ -195,6 +193,7 @@ struct x86_sys_config {
 	/* Address bits supported by all processors */
 	u8	phys_bits;
 	u8	virt_bits;
+	u8	cache_bits;
 	u16	clflush_size;
 	int	cache_alignment; /* in bytes */
 };
@@ -241,7 +240,7 @@ extern void cpu_detect(struct cpuinfo_x8
 
 static inline unsigned long long l1tf_pfn_limit(void)
 {
-	return BIT_ULL(boot_cpu_data.x86_cache_bits - 1 - PAGE_SHIFT);
+	return BIT_ULL(x86_config.cache_bits - 1 - PAGE_SHIFT);
 }
 
 extern void early_cpu_init(void);
@@ -816,6 +815,11 @@ static inline u8 x86_virt_bits(void)
 	return x86_config.virt_bits;
 }
 
+static inline u8 x86_cache_bits(void)
+{
+	return x86_config.cache_bits;
+}
+
 static inline u8 x86_clflush_size(void)
 {
 	return x86_config.clflush_size;
diff -puN arch/x86/kernel/cpu/common.c~config-cache_bits arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~config-cache_bits	2024-02-22 10:09:00.768936544 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-02-22 10:09:00.772936701 -0800
@@ -1138,15 +1138,15 @@ void get_cpu_address_sizes(struct cpuinf
 	}
 	x86_config.clflush_size = detect_clflush_size(c);
 
-	c->x86_cache_bits = x86_config.phys_bits;
-	if (c->x86_cache_bits < bsp_addr_config.min_cache_bits)
-		c->x86_cache_bits = bsp_addr_config.min_cache_bits;
+	x86_config.cache_bits = x86_config.phys_bits;
+	if (x86_config.cache_bits < bsp_addr_config.min_cache_bits)
+		x86_config.cache_bits = bsp_addr_config.min_cache_bits;
 
 	x86_config.cache_alignment = x86_clflush_size();
 	if (bsp_addr_config.cache_align_mult)
 		x86_config.cache_alignment *= bsp_addr_config.cache_align_mult;
 
-	/* Do this last to avoid affecting ->x86_cache_bits. */
+	/* Do this last to avoid affecting '.cache_bits'. */
 	x86_config.phys_bits -= bsp_addr_config.phys_addr_reduction_bits;
 }
 
diff -puN arch/x86/kvm/mmu/spte.c~config-cache_bits arch/x86/kvm/mmu/spte.c
--- a/arch/x86/kvm/mmu/spte.c~config-cache_bits	2024-02-22 10:09:00.772936701 -0800
+++ b/arch/x86/kvm/mmu/spte.c	2024-02-22 10:09:00.772936701 -0800
@@ -470,12 +470,12 @@ void kvm_mmu_reset_all_pte_masks(void)
 	shadow_nonpresent_or_rsvd_mask = 0;
 	low_phys_bits = x86_phys_bits();
 	if (boot_cpu_has_bug(X86_BUG_L1TF) &&
-	    !WARN_ON_ONCE(boot_cpu_data.x86_cache_bits >=
+	    !WARN_ON_ONCE(x86_cache_bits() >=
 			  52 - SHADOW_NONPRESENT_OR_RSVD_MASK_LEN)) {
-		low_phys_bits = boot_cpu_data.x86_cache_bits
+		low_phys_bits = x86_cache_bits()
 			- SHADOW_NONPRESENT_OR_RSVD_MASK_LEN;
 		shadow_nonpresent_or_rsvd_mask =
-			rsvd_bits(low_phys_bits, boot_cpu_data.x86_cache_bits - 1);
+			rsvd_bits(low_phys_bits, x86_cache_bits() - 1);
 	}
 
 	shadow_nonpresent_or_rsvd_lower_gfn_mask =
_

