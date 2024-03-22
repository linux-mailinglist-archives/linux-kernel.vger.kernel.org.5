Return-Path: <linux-kernel+bounces-111896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D4D887252
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37C21F228B6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9237560DC8;
	Fri, 22 Mar 2024 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hg0oIPa3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FC260894
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130194; cv=none; b=PJmtF2Ql9UKI+KY4kK36KqaazVsmhBSJdbsb1cML7adBNTGn5BBFRsm0rKMKecUauiFyf1KbtySzB1wafTusksSzdmHP13CsNEmySTwMrUmH2JxyU5Tr/ux2v22rhzhEXFkoYQlNOY1q2nFQxYtnMVv7apS6MfLr+1bHhNuNMbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130194; c=relaxed/simple;
	bh=zpniM12Plr/IbgqsKzUJwGxiwaeLzWobVxGgT3mo4kk=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=btbH+a3N+BVVwrx1pWTF96BRK/7VRSuZups3un3ABepzKqbefDoIRzf4rrdWT4Z0wt/FI/maoyaJJzd2LZ+MbdefYhAmbG1rmkKnNrWS3DCqxKxfBo16d5m2mKCS56euY/uI07ytIKfHyVg13iOnfJylddynHLFwFqhmsE+UUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hg0oIPa3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711130193; x=1742666193;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=zpniM12Plr/IbgqsKzUJwGxiwaeLzWobVxGgT3mo4kk=;
  b=Hg0oIPa3kT9l1QWxL61BZfhiYwiC+RdYu5X3zuYZjcBUkFpDnvUI3+C/
   HeU8tNzYDwRG7UI5m8qXBSZsbbcQDL3U29zwttp26Fu75p0TN5tB5xMs+
   pB2jWKSGoGuwhKpseTUp+Bn7tMyZM+YIfRv3DAHyBgZTe2XNoyiOny1Ud
   FtHYN2i3Kc2rnrsr0iex8n0SRxXuoo4sImmf7++N/zcqgJlezp5si/wDG
   QS0n4xkMUHI+9l7rdXCYgDyB7OhtammThgCtQwEujYtNMg0j8cqC0Yibs
   XpyI0Gjlv7J95HQFYNMLhzT8hrwE7mV+/lquhke+6iXFHmfqFwsJK0ABd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="28669679"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="28669679"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 10:56:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="15425569"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa006.jf.intel.com with ESMTP; 22 Mar 2024 10:56:31 -0700
Subject: [PATCH 1/4] x86/cpu: Add and use new CPUID region helper
To: linux-kernel@vger.kernel.org
Cc: jgross@suse.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 22 Mar 2024 10:56:30 -0700
References: <20240322175629.01E8B39D@davehans-spike.ostc.intel.com>
In-Reply-To: <20240322175629.01E8B39D@davehans-spike.ostc.intel.com>
Message-Id: <20240322175630.72CE974F@davehans-spike.ostc.intel.com>
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
Cc: Juergen Gross <jgross@suse.com>
---

 b/arch/x86/include/asm/cpuid.h    |   59 ++++++++++++++++++++++++++++++++++++++
 b/arch/x86/kernel/cpu/common.c    |   13 +++-----
 b/arch/x86/kernel/cpu/transmeta.c |    9 +----
 b/arch/x86/xen/enlighten_pv.c     |    9 +----
 4 files changed, 69 insertions(+), 21 deletions(-)

diff -puN arch/x86/include/asm/cpuid.h~cpuid-regions arch/x86/include/asm/cpuid.h
--- a/arch/x86/include/asm/cpuid.h~cpuid-regions	2024-03-18 15:12:20.676308753 -0700
+++ b/arch/x86/include/asm/cpuid.h	2024-03-22 09:17:13.296507986 -0700
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
+ * Consider a CPU that where the maximum leaf in the Transmeta
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
+        if ((eax >> 16) != region)
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
--- a/arch/x86/kernel/cpu/common.c~cpuid-regions	2024-03-18 15:12:20.676308753 -0700
+++ b/arch/x86/kernel/cpu/common.c	2024-03-18 15:12:20.684309023 -0700
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
--- a/arch/x86/kernel/cpu/transmeta.c~cpuid-regions	2024-03-18 15:12:20.680308889 -0700
+++ b/arch/x86/kernel/cpu/transmeta.c	2024-03-18 15:12:20.684309023 -0700
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
--- a/arch/x86/xen/enlighten_pv.c~cpuid-regions	2024-03-18 15:12:20.680308889 -0700
+++ b/arch/x86/xen/enlighten_pv.c	2024-03-22 09:15:33.280428290 -0700
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

