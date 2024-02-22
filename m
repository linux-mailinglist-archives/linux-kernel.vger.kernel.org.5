Return-Path: <linux-kernel+bounces-77162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 589AA8601C9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D855E1F28982
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A4B5491F;
	Thu, 22 Feb 2024 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXxrxi6B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D376C71723
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627179; cv=none; b=SNYL5o5CdHIGuLnV6nUC2bKFF+8WER8LQ6R36mRQL1PJtJSzy0U41NNiu1rh7rFmb3ZEqSQ1ajTiOiJDxhQcD2utKX6ram7mEJn9TN9w3UmtEyGBEcTj5QIqLD8FuagnkfQ05jJ1uXR30/MZ+B3kNls1iaaPg7bzIJArMtHVoho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627179; c=relaxed/simple;
	bh=FehiVN43cGB3SSoJx1cXrEiiDX6N9eHmUXCTLrFRaO0=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=emSJuXnHwJAKV0ww6/jEd7+jv3WwIUYjm5W0YDL7yslvgU2Z+dnpv9nQlHYEgi3iqyykXo5Y0xPR4CjksMd+yO1Ruzm+GPkRXfbdH/DloVywnUUejxpktDXBQKk1JWlTxy+0kxo2Pefb+D4EPan1k4yQYPeaKiwjpepQI3UQun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXxrxi6B; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627178; x=1740163178;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=FehiVN43cGB3SSoJx1cXrEiiDX6N9eHmUXCTLrFRaO0=;
  b=TXxrxi6BjZglHKehqF+m8955WqvXb0uM5B55OnensW87eGncEtbFEt4T
   EyPMWxeKS1Wm6uLWspC2ut2t5KL1r+8yP+gArjh3EdQM/Vdi8Amer8h9Q
   blgzC2aonYN9GjpfAMQXmu/yq7n7JCDcilrCq2xAX4GyjDmR7Slbp36MS
   rmbdTFQVj4zlzldtgMuPFDdZWInnuNa46AKzYbzcV+5VOmPLFMz2ACPfF
   3rYIq3G8fOEN7vou64GXgKn0F+E2WYS30n54LAzFEdrv9NPXKp6HgeAOx
   OZaboVJhIalez8sLXzO8n5OgsKR9rAL6Bzkv38MkEkkp0d9K3rXGRQNzt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031742"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031742"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975454"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:38 -0800
Subject: [RFC][PATCH 08/34] x86/cpu: Add CLFLUSH size helper
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>,mpatocka@redhat.com,snitzer@redhat.com,daniel@ffwll.ch
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:37 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183937.981D71D9@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

This is probably starting to look familiar:  The size of a cacheline is
fundamental system-wide information.  Keeping it per-cpu is just silly.

Introduce a system-wide helper for looking up the cacheline size and
use it.

This does one slightly odd looking thing, it stops setting
c->x86_clflush_size on all but the boot CPU.  This is functionally OK
because all readers of the secondary CPU values also go away.  It also
makes it explicit that the 'boot_cpu_data' is the one true system-wide
value.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>

---

 b/arch/x86/include/asm/processor.h       |    5 +++++
 b/arch/x86/kernel/cpu/centaur.c          |    2 +-
 b/arch/x86/kernel/cpu/common.c           |    9 +++++----
 b/arch/x86/kernel/cpu/intel.c            |    2 +-
 b/arch/x86/kernel/cpu/proc.c             |    2 +-
 b/arch/x86/lib/usercopy_64.c             |    7 +++----
 b/arch/x86/mm/pat/set_memory.c           |    2 +-
 b/arch/x86/pci/common.c                  |    2 +-
 b/drivers/gpu/drm/drm_cache.c            |    4 ++--
 b/drivers/gpu/drm/i915/i915_cmd_parser.c |    3 +--
 b/drivers/gpu/drm/i915/i915_gem.c        |    2 +-
 b/drivers/md/dm-writecache.c             |    2 +-
 12 files changed, 23 insertions(+), 19 deletions(-)

diff -puN arch/x86/include/asm/processor.h~x86_clflush_size-func arch/x86/include/asm/processor.h
--- a/arch/x86/include/asm/processor.h~x86_clflush_size-func	2024-02-22 10:08:52.112596720 -0800
+++ b/arch/x86/include/asm/processor.h	2024-02-22 10:08:52.132597505 -0800
@@ -777,4 +777,9 @@ static inline u8 x86_virt_bits(void)
 	return boot_cpu_data.x86_virt_bits;
 }
 
+static inline u8 x86_clflush_size(void)
+{
+	return boot_cpu_data.x86_clflush_size;
+}
+
 #endif /* _ASM_X86_PROCESSOR_H */
diff -puN arch/x86/kernel/cpu/centaur.c~x86_clflush_size-func arch/x86/kernel/cpu/centaur.c
--- a/arch/x86/kernel/cpu/centaur.c~x86_clflush_size-func	2024-02-22 10:08:52.112596720 -0800
+++ b/arch/x86/kernel/cpu/centaur.c	2024-02-22 10:08:52.132597505 -0800
@@ -62,7 +62,7 @@ static void init_c3(struct cpuinfo_x86 *
 		set_cpu_cap(c, X86_FEATURE_3DNOW);
 #endif
 	if (c->x86 == 0x6 && c->x86_model >= 0xf) {
-		c->x86_cache_alignment = c->x86_clflush_size * 2;
+		c->x86_cache_alignment = x86_clflush_size() * 2;
 		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 	}
 
diff -puN arch/x86/kernel/cpu/common.c~x86_clflush_size-func arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~x86_clflush_size-func	2024-02-22 10:08:52.112596720 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-02-22 10:08:52.132597505 -0800
@@ -954,8 +954,9 @@ void cpu_detect(struct cpuinfo_x86 *c)
 		c->x86_stepping	= x86_stepping(tfms);
 
 		if (cap0 & (1<<19)) {
-			c->x86_clflush_size = ((misc >> 8) & 0xff) * 8;
-			c->x86_cache_alignment = c->x86_clflush_size;
+			if (c == &boot_cpu_data)
+				c->x86_clflush_size = ((misc >> 8) & 0xff) * 8;
+			c->x86_cache_alignment = x86_clflush_size();
 		}
 	}
 }
@@ -1123,7 +1124,7 @@ void get_cpu_address_sizes(struct cpuinf
 		}
 	}
 	c->x86_cache_bits = c->x86_phys_bits;
-	c->x86_cache_alignment = c->x86_clflush_size;
+	c->x86_cache_alignment = x86_clflush_size();
 }
 
 static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
@@ -1831,7 +1832,7 @@ static void identify_cpu(struct cpuinfo_
 	c->x86_phys_bits = 32;
 	c->x86_virt_bits = 32;
 #endif
-	c->x86_cache_alignment = c->x86_clflush_size;
+	c->x86_cache_alignment = x86_clflush_size();
 	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
 #ifdef CONFIG_X86_VMX_FEATURE_NAMES
 	memset(&c->vmx_capability, 0, sizeof(c->vmx_capability));
diff -puN arch/x86/kernel/cpu/intel.c~x86_clflush_size-func arch/x86/kernel/cpu/intel.c
--- a/arch/x86/kernel/cpu/intel.c~x86_clflush_size-func	2024-02-22 10:08:52.116596877 -0800
+++ b/arch/x86/kernel/cpu/intel.c	2024-02-22 10:08:52.132597505 -0800
@@ -653,7 +653,7 @@ static void init_intel(struct cpuinfo_x8
 
 #ifdef CONFIG_X86_64
 	if (c->x86 == 15)
-		c->x86_cache_alignment = c->x86_clflush_size * 2;
+		c->x86_cache_alignment = x86_clflush_size() * 2;
 	if (c->x86 == 6)
 		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 #else
diff -puN arch/x86/kernel/cpu/proc.c~x86_clflush_size-func arch/x86/kernel/cpu/proc.c
--- a/arch/x86/kernel/cpu/proc.c~x86_clflush_size-func	2024-02-22 10:08:52.116596877 -0800
+++ b/arch/x86/kernel/cpu/proc.c	2024-02-22 10:08:52.132597505 -0800
@@ -130,7 +130,7 @@ static int show_cpuinfo(struct seq_file
 	if (c->x86_tlbsize > 0)
 		seq_printf(m, "TLB size\t: %d 4K pages\n", c->x86_tlbsize);
 #endif
-	seq_printf(m, "clflush size\t: %u\n", c->x86_clflush_size);
+	seq_printf(m, "clflush size\t: %u\n", x86_clflush_size());
 	seq_printf(m, "cache_alignment\t: %d\n", c->x86_cache_alignment);
 	seq_printf(m, "address sizes\t: %u bits physical, %u bits virtual\n",
 		   x86_phys_bits(), x86_virt_bits());
diff -puN arch/x86/lib/usercopy_64.c~x86_clflush_size-func arch/x86/lib/usercopy_64.c
--- a/arch/x86/lib/usercopy_64.c~x86_clflush_size-func	2024-02-22 10:08:52.120597034 -0800
+++ b/arch/x86/lib/usercopy_64.c	2024-02-22 10:08:52.132597505 -0800
@@ -27,13 +27,12 @@
  */
 static void clean_cache_range(void *addr, size_t size)
 {
-	u16 x86_clflush_size = boot_cpu_data.x86_clflush_size;
-	unsigned long clflush_mask = x86_clflush_size - 1;
+	unsigned long clflush_mask = x86_clflush_size() - 1;
 	void *vend = addr + size;
 	void *p;
 
 	for (p = (void *)((unsigned long)addr & ~clflush_mask);
-	     p < vend; p += x86_clflush_size)
+	     p < vend; p += x86_clflush_size())
 		clwb(p);
 }
 
@@ -65,7 +64,7 @@ long __copy_user_flushcache(void *dst, c
 			clean_cache_range(dst, size);
 	} else {
 		if (!IS_ALIGNED(dest, 8)) {
-			dest = ALIGN(dest, boot_cpu_data.x86_clflush_size);
+			dest = ALIGN(dest, x86_clflush_size());
 			clean_cache_range(dst, 1);
 		}
 
diff -puN arch/x86/mm/pat/set_memory.c~x86_clflush_size-func arch/x86/mm/pat/set_memory.c
--- a/arch/x86/mm/pat/set_memory.c~x86_clflush_size-func	2024-02-22 10:08:52.120597034 -0800
+++ b/arch/x86/mm/pat/set_memory.c	2024-02-22 10:08:52.132597505 -0800
@@ -314,7 +314,7 @@ static unsigned long __cpa_addr(struct c
 
 static void clflush_cache_range_opt(void *vaddr, unsigned int size)
 {
-	const unsigned long clflush_size = boot_cpu_data.x86_clflush_size;
+	const unsigned long clflush_size = x86_clflush_size();
 	void *p = (void *)((unsigned long)vaddr & ~(clflush_size - 1));
 	void *vend = vaddr + size;
 
diff -puN arch/x86/pci/common.c~x86_clflush_size-func arch/x86/pci/common.c
--- a/arch/x86/pci/common.c~x86_clflush_size-func	2024-02-22 10:08:52.120597034 -0800
+++ b/arch/x86/pci/common.c	2024-02-22 10:08:52.132597505 -0800
@@ -480,7 +480,7 @@ void pcibios_scan_root(int busnum)
 
 void __init pcibios_set_cache_line_size(void)
 {
-	pci_dfl_cache_line_size = boot_cpu_data.x86_clflush_size >> 2;
+	pci_dfl_cache_line_size = x86_clflush_size() >> 2;
 	printk(KERN_DEBUG "PCI: pci_cache_line_size set to %d bytes\n",
 		pci_dfl_cache_line_size << 2);
 }
diff -puN drivers/gpu/drm/drm_cache.c~x86_clflush_size-func drivers/gpu/drm/drm_cache.c
--- a/drivers/gpu/drm/drm_cache.c~x86_clflush_size-func	2024-02-22 10:08:52.124597191 -0800
+++ b/drivers/gpu/drm/drm_cache.c	2024-02-22 10:08:52.132597505 -0800
@@ -52,7 +52,7 @@ drm_clflush_page(struct page *page)
 {
 	uint8_t *page_virtual;
 	unsigned int i;
-	const int size = boot_cpu_data.x86_clflush_size;
+	const int size = x86_clflush_size();
 
 	if (unlikely(page == NULL))
 		return;
@@ -160,7 +160,7 @@ drm_clflush_virt_range(void *addr, unsig
 {
 #if defined(CONFIG_X86)
 	if (static_cpu_has(X86_FEATURE_CLFLUSH)) {
-		const int size = boot_cpu_data.x86_clflush_size;
+		const int size = x86_clflush_size();
 		void *end = addr + length;
 
 		addr = (void *)(((unsigned long)addr) & -size);
diff -puN drivers/gpu/drm/i915/i915_cmd_parser.c~x86_clflush_size-func drivers/gpu/drm/i915/i915_cmd_parser.c
--- a/drivers/gpu/drm/i915/i915_cmd_parser.c~x86_clflush_size-func	2024-02-22 10:08:52.124597191 -0800
+++ b/drivers/gpu/drm/i915/i915_cmd_parser.c	2024-02-22 10:08:52.132597505 -0800
@@ -1203,8 +1203,7 @@ static u32 *copy_batch(struct drm_i915_g
 		 */
 		remain = length;
 		if (dst_needs_clflush & CLFLUSH_BEFORE)
-			remain = round_up(remain,
-					  boot_cpu_data.x86_clflush_size);
+			remain = round_up(remain, x86_clflush_size());
 
 		ptr = dst;
 		x = offset_in_page(offset);
diff -puN drivers/gpu/drm/i915/i915_gem.c~x86_clflush_size-func drivers/gpu/drm/i915/i915_gem.c
--- a/drivers/gpu/drm/i915/i915_gem.c~x86_clflush_size-func	2024-02-22 10:08:52.124597191 -0800
+++ b/drivers/gpu/drm/i915/i915_gem.c	2024-02-22 10:08:52.132597505 -0800
@@ -696,7 +696,7 @@ i915_gem_shmem_pwrite(struct drm_i915_ge
 	 */
 	partial_cacheline_write = 0;
 	if (needs_clflush & CLFLUSH_BEFORE)
-		partial_cacheline_write = boot_cpu_data.x86_clflush_size - 1;
+		partial_cacheline_write = x86_clflush_size() - 1;
 
 	user_data = u64_to_user_ptr(args->data_ptr);
 	remain = args->size;
diff -puN drivers/md/dm-writecache.c~x86_clflush_size-func drivers/md/dm-writecache.c
--- a/drivers/md/dm-writecache.c~x86_clflush_size-func	2024-02-22 10:08:52.128597348 -0800
+++ b/drivers/md/dm-writecache.c	2024-02-22 10:08:52.132597505 -0800
@@ -1229,7 +1229,7 @@ static void memcpy_flushcache_optimized(
 	 */
 #ifdef CONFIG_X86
 	if (static_cpu_has(X86_FEATURE_CLFLUSHOPT) &&
-	    likely(boot_cpu_data.x86_clflush_size == 64) &&
+	    likely(x86_clflush_size() == 64) &&
 	    likely(size >= 768)) {
 		do {
 			memcpy((void *)dest, (void *)source, 64);
_

