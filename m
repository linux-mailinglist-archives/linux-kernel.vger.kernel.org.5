Return-Path: <linux-kernel+bounces-130101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CF089741B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E03C1C24E23
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E9114A4FC;
	Wed,  3 Apr 2024 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XDdjKJ85"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFDA14A092
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158513; cv=none; b=YorfNMyp7LvmfKX10qTstbXKA4xO/PE+2nx1qLJYExejgYYfmzRVZEZjijD36Prf0U3GfS0H/BSHIHrcrWcUqoShXSjvLIbd0kO1TffeuKwWHsXcfRHb76TbYoFWvao6HJc+nsJKRzwtg6DF7Mef7Isilc2chiOc9gf9KHXPaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158513; c=relaxed/simple;
	bh=Wf5ddrRpRHX3prUPCD88r6sLOCPnyoEo7OA8sy+PQns=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=jiqrJ+SJ22bobAh9rx1vV8nEX9zmP8ejOcoi+/IrGnsJr+io0ViUX0eBMkyuf1XFoBc1skFjNKhchbvnCE90f38wvBuFlVduGA3gz7u1E1oWFBBBDsFaTwEgPEapHBJY/La83U4/AqTpmtFlPaxmG0MnbbhUXSZFkr4d900jaIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XDdjKJ85; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712158512; x=1743694512;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=Wf5ddrRpRHX3prUPCD88r6sLOCPnyoEo7OA8sy+PQns=;
  b=XDdjKJ85hEOozy03Pvf/XKG058vvfFZYPN/Z1+YQyW8O3Zr8jgZuFS5E
   N245jumD+CrCmebqxcugA81DC9sjTAXtkeD/WpcfnwmR1EKEk2hIyYOJq
   Xsq2+3rflvelJT1IvIHUc/xbMTD4nOvrZZpswj3g/boKJramv+HVoXrZP
   lpkPvxBUvkQDwpLVMSkYAeWBuYQAcHp+Fg+8ISFCsBfR8Ev9bfCGIvOy6
   is8AzUc6untKEzGIxVUj2phcVl9JZhsE1NH1jtFtOYNvnsj4sHaXtztmt
   1PdrfBswNZj3gouARH2Vf1i72uy6N7M+WW6hroBct9X5lRlFPGaX23zJY
   Q==;
X-CSE-ConnectionGUID: twQeUfEEQB6Jybg+szSfOQ==
X-CSE-MsgGUID: OOTQoDZ5T/C8ls3JCy3/Tg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18556316"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18556316"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 08:35:11 -0700
X-CSE-ConnectionGUID: JBZt3WQ2TC2kkRYVJPVCvA==
X-CSE-MsgGUID: wm9S4QMZRLuWZebduMz0zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18395600"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa010.fm.intel.com with ESMTP; 03 Apr 2024 08:35:10 -0700
Subject: [PATCH 1/4] x86/cpu: Add and use new CPUID region helper
To: linux-kernel@vger.kernel.org
Cc: jgross@suse.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>,kai.huang@intel.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 03 Apr 2024 08:35:10 -0700
References: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
In-Reply-To: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
Message-Id: <20240403153510.F327603D@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

There are some (before now) unwritten rules about CPUID "regions".
Basically, there is a 32-bit address space of CPUID leaves.  The
top 16 bits address a "region" and the first leaf in a region
is special.

The kernel only has a few spots that care about this, but it's
rather hard to make sense of the code as is.

Add a helper that explains regions.  Use it where applicable.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Cc: Juergen Gross <jgross@suse.com>

--

changes from v1:
 * Fix typo comment and whitespace gunk noted by Ingo

---

 b/arch/x86/include/asm/cpuid.h    |   59 ++++++++++++++++++++++++++++++++++++++
 b/arch/x86/kernel/cpu/common.c    |   13 +++-----
 b/arch/x86/kernel/cpu/transmeta.c |    9 +----
 b/arch/x86/xen/enlighten_pv.c     |    9 +----
 4 files changed, 69 insertions(+), 21 deletions(-)

diff -puN arch/x86/include/asm/cpuid.h~cpuid-regions arch/x86/include/asm/cpuid.h
--- a/arch/x86/include/asm/cpuid.h~cpuid-regions	2024-04-02 15:22:58.838912075 -0700
+++ b/arch/x86/include/asm/cpuid.h	2024-04-02 15:22:58.846912085 -0700
@@ -168,4 +168,63 @@ static inline uint32_t hypervisor_cpuid_
 	return 0;
 }
 
+/*
+ * By convention, CPUID is broken up into regions which each
+ * have 2^16 leaves.  EAX in the first leaf of each valid
+ * region returns the maximum valid leaf in that region.
+ *
+ * The regions can be thought of as being vendor-specific
+ * areas of CPUID, but that's imprecise because everybody
+ * implements the "Intel" region and Intel implements the
+ * AMD region.  There are a few well-known regions:
+ *  - Intel	(0x0000)
+ *  - AMD	(0x8000)
+ *  - Transmeta	(0x8086)
+ *  - Centaur	(0xC000)
+ *
+ * Consider a CPU where the maximum leaf in the Transmeta
+ * region is 2.  On such a CPU, leaf 0x80860000 would contain:
+ * EAX==0x80860002.
+ * region-^^^^
+ *   max leaf-^^^^
+ */
+static inline u32 cpuid_region_max_leaf(u16 region)
+{
+	u32 eax = cpuid_eax(region << 16);
+
+	/*
+	 * An unsupported region may return data from the last
+	 * "basic" leaf, which is essentially garbage.  Avoid
+	 * mistaking basic leaf data for region data.
+	 *
+	 * Note: this is not perfect.  It is theoretically
+	 * possible for the last basic leaf to _resemble_ a
+	 * valid first leaf from a region that doesn't exist.
+	 * But Intel at least seems to pad out the basic region
+	 * with 0's, possibly to avoid this.
+	 */
+	if ((eax >> 16) != region)
+		return 0;
+
+	return eax;
+}
+
+/* Returns true if the leaf exists and @value was populated */
+static inline bool get_cpuid_region_leaf(u32 leaf, enum cpuid_regs_idx reg,
+					 u32 *value)
+{
+	u16 region = leaf >> 16;
+	u32 regs[4];
+
+	if (cpuid_region_max_leaf(region) < leaf)
+		return false;
+
+	cpuid(leaf, &regs[CPUID_EAX], &regs[CPUID_EBX],
+	            &regs[CPUID_ECX], &regs[CPUID_EDX]);
+
+	*value = regs[reg];
+
+	return true;
+}
+
 #endif /* _ASM_X86_CPUID_H */
diff -puN arch/x86/kernel/cpu/common.c~cpuid-regions arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~cpuid-regions	2024-04-02 15:22:58.842912079 -0700
+++ b/arch/x86/kernel/cpu/common.c	2024-04-02 15:22:58.846912085 -0700
@@ -1049,16 +1049,13 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 	}
 
 	/* AMD-defined flags: level 0x80000001 */
-	eax = cpuid_eax(0x80000000);
-	c->extended_cpuid_level = eax;
+	c->extended_cpuid_level = cpuid_region_max_leaf(0x8000);
 
-	if ((eax & 0xffff0000) == 0x80000000) {
-		if (eax >= 0x80000001) {
-			cpuid(0x80000001, &eax, &ebx, &ecx, &edx);
+	if (c->extended_cpuid_level >= 0x80000001) {
+		cpuid(0x80000001, &eax, &ebx, &ecx, &edx);
 
-			c->x86_capability[CPUID_8000_0001_ECX] = ecx;
-			c->x86_capability[CPUID_8000_0001_EDX] = edx;
-		}
+		c->x86_capability[CPUID_8000_0001_ECX] = ecx;
+		c->x86_capability[CPUID_8000_0001_EDX] = edx;
 	}
 
 	if (c->extended_cpuid_level >= 0x80000007) {
diff -puN arch/x86/kernel/cpu/transmeta.c~cpuid-regions arch/x86/kernel/cpu/transmeta.c
--- a/arch/x86/kernel/cpu/transmeta.c~cpuid-regions	2024-04-02 15:22:58.842912079 -0700
+++ b/arch/x86/kernel/cpu/transmeta.c	2024-04-02 15:22:58.846912085 -0700
@@ -9,14 +9,9 @@
 
 static void early_init_transmeta(struct cpuinfo_x86 *c)
 {
-	u32 xlvl;
-
 	/* Transmeta-defined flags: level 0x80860001 */
-	xlvl = cpuid_eax(0x80860000);
-	if ((xlvl & 0xffff0000) == 0x80860000) {
-		if (xlvl >= 0x80860001)
-			c->x86_capability[CPUID_8086_0001_EDX] = cpuid_edx(0x80860001);
-	}
+	get_cpuid_region_leaf(0x80860001, CPUID_EDX,
+			  &c->x86_capability[CPUID_8086_0001_EDX]);
 }
 
 static void init_transmeta(struct cpuinfo_x86 *c)
diff -puN arch/x86/xen/enlighten_pv.c~cpuid-regions arch/x86/xen/enlighten_pv.c
--- a/arch/x86/xen/enlighten_pv.c~cpuid-regions	2024-04-02 15:22:58.842912079 -0700
+++ b/arch/x86/xen/enlighten_pv.c	2024-04-03 08:34:28.221534043 -0700
@@ -141,16 +141,13 @@ static void __init xen_set_mtrr_data(voi
 	};
 	unsigned int reg;
 	unsigned long mask;
-	uint32_t eax, width;
+	uint32_t width;
 	static struct mtrr_var_range var[MTRR_MAX_VAR_RANGES] __initdata;
 
 	/* Get physical address width (only 64-bit cpus supported). */
 	width = 36;
-	eax = cpuid_eax(0x80000000);
-	if ((eax >> 16) == 0x8000 && eax >= 0x80000008) {
-		eax = cpuid_eax(0x80000008);
-		width = eax & 0xff;
-	}
+	/* Will overwrite 'width' if available in CPUID: */
+	get_cpuid_region_leaf(0x80000008, CPUID_EAX, &width);
 
 	for (reg = 0; reg < MTRR_MAX_VAR_RANGES; reg++) {
 		op.u.read_memtype.reg = reg;
_

