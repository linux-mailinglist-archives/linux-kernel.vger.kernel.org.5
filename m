Return-Path: <linux-kernel+bounces-77161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9298601C8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3671C2521F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC6271739;
	Thu, 22 Feb 2024 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ke59vf46"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E606E602
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627177; cv=none; b=ASX0WDKAg7yNFTAknFuPZKoIRCPUWLU5fBqOqwQZksOaUMpxMnZBfLTnJ4rPjNAusZeUoasFMOmQqTkuRztMabXHo54mP9lA+kQONXLMV4WF/jPorsshArlTsW8qcgqiYfBhFRtWlWd3kq+VInPwuGcebH+ajCQFMhKoXmOD1zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627177; c=relaxed/simple;
	bh=rsFsu/cEO8uggTXoV412vUNfouqZDj34S3bAyQtscUc=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=jTY/9Or5H0HIYybA9OVQz6cdlvq0x0pZESwjEln83xSNwc3Pa1drn7PAyKMdfgd9KKfgj2qUP7Fef03RsooZUjqd/bBi2z/GXaBhd/MdvVYlJC2E67OidUsj1EaENaGmXhLvFOpvRizKXkkyFMhgXGZwvG4ZbJzpDZIAJ9DQQlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ke59vf46; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627177; x=1740163177;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=rsFsu/cEO8uggTXoV412vUNfouqZDj34S3bAyQtscUc=;
  b=Ke59vf46hCB8/Y38lI5g097MW0ExmetfvzN+yayXeJDw+ExuaFCmtA+a
   2CVic5l2rgqi1jjqEpQ/UXsJ1/QjDs9zMmpmLugFbPBoGLm6iMOoCUuGx
   QNIdhD40uLuHiNutswp4JRz4xdxYDn8I2vEnEteiAMao1Z3cMx+dS+myA
   qLzter1YHNvOMtPNNTPEKZgDedbv5rU1G1FMAiLXGA8VBI0Xoq0pMMw+F
   cEbdByQdPgzNC2242FqU6lDPG9LxGWiDnoN0h1VoT3C5n5EltrjfufeeZ
   lmEquCaAQQq63ar959dzgeu2dwr/H1HePyFWhv9QdQgJ91GK2Va93KqHr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031733"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031733"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975440"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:36 -0800
Subject: [RFC][PATCH 07/34] x86/mm: Introduce virtual address space limit helper
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:35 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183935.286751FF@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

This uses the same logic and approach which were used for the physical
address limits with x86_phys_bits() and extends them to the virtual
address space.

Introduce a system-wide helper for users to query the size of the
virtual address space: x86_virt_bits()

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/events/amd/brs.c        |    2 +-
 b/arch/x86/events/amd/lbr.c        |    2 +-
 b/arch/x86/events/intel/pt.c       |    4 ++--
 b/arch/x86/include/asm/processor.h |    5 +++++
 b/arch/x86/kernel/cpu/proc.c       |    2 +-
 b/arch/x86/mm/maccess.c            |    4 ++--
 6 files changed, 12 insertions(+), 7 deletions(-)

diff -puN arch/x86/events/amd/brs.c~x86_virt_bits-func arch/x86/events/amd/brs.c
--- a/arch/x86/events/amd/brs.c~x86_virt_bits-func	2024-02-22 10:08:51.528573793 -0800
+++ b/arch/x86/events/amd/brs.c	2024-02-22 10:08:51.536574107 -0800
@@ -285,7 +285,7 @@ void amd_brs_drain(void)
 	struct perf_branch_entry *br = cpuc->lbr_entries;
 	union amd_debug_extn_cfg cfg;
 	u32 i, nr = 0, num, tos, start;
-	u32 shift = 64 - boot_cpu_data.x86_virt_bits;
+	u32 shift = 64 - x86_virt_bits();
 
 	/*
 	 * BRS event forced on PMC0,
diff -puN arch/x86/events/amd/lbr.c~x86_virt_bits-func arch/x86/events/amd/lbr.c
--- a/arch/x86/events/amd/lbr.c~x86_virt_bits-func	2024-02-22 10:08:51.528573793 -0800
+++ b/arch/x86/events/amd/lbr.c	2024-02-22 10:08:51.536574107 -0800
@@ -89,7 +89,7 @@ static __always_inline u64 amd_pmu_lbr_g
 
 static __always_inline u64 sign_ext_branch_ip(u64 ip)
 {
-	u32 shift = 64 - boot_cpu_data.x86_virt_bits;
+	u32 shift = 64 - x86_virt_bits();
 
 	return (u64)(((s64)ip << shift) >> shift);
 }
diff -puN arch/x86/events/intel/pt.c~x86_virt_bits-func arch/x86/events/intel/pt.c
--- a/arch/x86/events/intel/pt.c~x86_virt_bits-func	2024-02-22 10:08:51.528573793 -0800
+++ b/arch/x86/events/intel/pt.c	2024-02-22 10:08:51.536574107 -0800
@@ -1453,8 +1453,8 @@ static void pt_event_addr_filters_sync(s
 			 * canonical addresses does not affect the result of the
 			 * address filter.
 			 */
-			msr_a = clamp_to_ge_canonical_addr(a, boot_cpu_data.x86_virt_bits);
-			msr_b = clamp_to_le_canonical_addr(b, boot_cpu_data.x86_virt_bits);
+			msr_a = clamp_to_ge_canonical_addr(a, x86_virt_bits());
+			msr_b = clamp_to_le_canonical_addr(b, x86_virt_bits());
 			if (msr_b < msr_a)
 				msr_a = msr_b = 0;
 		}
diff -puN arch/x86/include/asm/processor.h~x86_virt_bits-func arch/x86/include/asm/processor.h
--- a/arch/x86/include/asm/processor.h~x86_virt_bits-func	2024-02-22 10:08:51.532573950 -0800
+++ b/arch/x86/include/asm/processor.h	2024-02-22 10:08:51.536574107 -0800
@@ -772,4 +772,9 @@ static inline u8 x86_phys_bits(void)
 	return boot_cpu_data.x86_phys_bits;
 }
 
+static inline u8 x86_virt_bits(void)
+{
+	return boot_cpu_data.x86_virt_bits;
+}
+
 #endif /* _ASM_X86_PROCESSOR_H */
diff -puN arch/x86/kernel/cpu/proc.c~x86_virt_bits-func arch/x86/kernel/cpu/proc.c
--- a/arch/x86/kernel/cpu/proc.c~x86_virt_bits-func	2024-02-22 10:08:51.532573950 -0800
+++ b/arch/x86/kernel/cpu/proc.c	2024-02-22 10:08:51.536574107 -0800
@@ -133,7 +133,7 @@ static int show_cpuinfo(struct seq_file
 	seq_printf(m, "clflush size\t: %u\n", c->x86_clflush_size);
 	seq_printf(m, "cache_alignment\t: %d\n", c->x86_cache_alignment);
 	seq_printf(m, "address sizes\t: %u bits physical, %u bits virtual\n",
-		   x86_phys_bits(), c->x86_virt_bits);
+		   x86_phys_bits(), x86_virt_bits());
 
 	seq_puts(m, "power management:");
 	for (i = 0; i < 32; i++) {
diff -puN arch/x86/mm/maccess.c~x86_virt_bits-func arch/x86/mm/maccess.c
--- a/arch/x86/mm/maccess.c~x86_virt_bits-func	2024-02-22 10:08:51.536574107 -0800
+++ b/arch/x86/mm/maccess.c	2024-02-22 10:08:51.536574107 -0800
@@ -20,10 +20,10 @@ bool copy_from_kernel_nofault_allowed(co
 	 * is initialized.  Needed for instruction decoding in early
 	 * exception handlers.
 	 */
-	if (!boot_cpu_data.x86_virt_bits)
+	if (!x86_virt_bits())
 		return true;
 
-	return __is_canonical_address(vaddr, boot_cpu_data.x86_virt_bits);
+	return __is_canonical_address(vaddr, x86_virt_bits());
 }
 #else
 bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
_

