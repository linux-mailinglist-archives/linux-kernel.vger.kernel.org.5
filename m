Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD2778FA4E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbjIAI4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIAI4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:56:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1672310D3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 01:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693558574; x=1725094574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nDVQFhqTixCtGXwWXAstRFhOuFQ3MPyV5OjPTLkEWEQ=;
  b=WT26XUG4/RvKE5CkgN4Md2wzaP0ctelYDAjJOEvTOr5rZ9capku3eHj5
   l+rRolJ/9EjVHbcCZErtoyMNFjJcF6p5kEvK17+Ehvv+BfM6WH+WoEq0b
   ICC7UUpjf4O+fZTqr3ZmsYUrGe+TWY7ckzxb6Xw0x1lxovpW8RTm2/JMr
   MRQjd4RA82ae5Nl/P23E3P3DKc1frUxUa8egCqD/9EyAJrZT2oisMJfl5
   QW1ZaHmR6PhAQazjJODln21CyC+YAdPwXHAnb3/s3Z8E25sbaLbHrQy/V
   sBhw3rzq2Vc8yPFldFgK/5KfWElFYcWS//LtX3QVLcicLFKh3OS2475RD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="440151652"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="440151652"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 01:56:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="769133437"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="769133437"
Received: from akoczor-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.14.236])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 01:56:09 -0700
From:   "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] x86/resctrl: Enable non-contiguous bits in Intel CAT
Date:   Fri,  1 Sep 2023 10:55:37 +0200
Message-ID: <1bd3aab725a4e2948530095eb48b11bcc4028f8e.1693557919.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693557919.git.maciej.wieczor-retman@intel.com>
References: <cover.1693557919.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setting for non-contiguous 1s support in Intel CAT is
hardcoded to false. On these systems, writing non-contiguous
1s into the schemata file will fail before resctrl passes
the value to the hardware.

In Intel CAT CPUID.0x10.1:ECX[3] and CPUID.0x10.2:ECX[3] stopped
being reserved and now carry information about non-contiguous 1s
value support for L3 and L2 cache respectively. The CAT
capacity bitmask (CBM) supports a non-contiguous 1s value if
the bit is set.

Replace the hardcoded non-contiguous support value with
the support learned from the hardware. Add hardcoded non-contiguous
support value to Haswell probe since it can't make use of CPUID for
Cache allocation.

Originally-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
---
 arch/x86/kernel/cpu/resctrl/core.c        |  9 ++++++---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 11 +++++++----
 arch/x86/kernel/cpu/resctrl/internal.h    |  9 +++++++++
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 030d3b409768..c783a873147c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -152,6 +152,7 @@ static inline void cache_alloc_hsw_probe(void)
 	r->cache.cbm_len = 20;
 	r->cache.shareable_bits = 0xc0000;
 	r->cache.min_cbm_bits = 2;
+	r->cache.arch_has_sparse_bitmaps = false;
 	r->alloc_capable = true;
 
 	rdt_alloc_capable = true;
@@ -267,15 +268,18 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	union cpuid_0x10_1_eax eax;
+	union cpuid_0x10_x_ecx ecx;
 	union cpuid_0x10_x_edx edx;
-	u32 ebx, ecx;
+	u32 ebx;
 
-	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx, &edx.full);
+	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx.full, &edx.full);
 	hw_res->num_closid = edx.split.cos_max + 1;
 	r->cache.cbm_len = eax.split.cbm_len + 1;
 	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
 	r->cache.shareable_bits = ebx & r->default_ctrl;
 	r->data_width = (r->cache.cbm_len + 3) / 4;
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		r->cache.arch_has_sparse_bitmaps = ecx.split.noncont;
 	r->alloc_capable = true;
 }
 
@@ -872,7 +876,6 @@ static __init void rdt_init_res_defs_intel(void)
 
 		if (r->rid == RDT_RESOURCE_L3 ||
 		    r->rid == RDT_RESOURCE_L2) {
-			r->cache.arch_has_sparse_bitmaps = false;
 			r->cache.arch_has_per_cpu_cfg = false;
 			r->cache.min_cbm_bits = 1;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index b44c487727d4..782e2700290b 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -87,10 +87,13 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 
 /*
  * Check whether a cache bit mask is valid.
- * For Intel the SDM says:
- *	Please note that all (and only) contiguous '1' combinations
- *	are allowed (e.g. FFFFH, 0FF0H, 003CH, etc.).
- * Additionally Haswell requires at least two bits set.
+ * On Intel CPUs, non-contiguous 1s value support is indicated by CPUID:
+ *   - CPUID.0x10.1:ECX[3]: L3 non-contiguous 1s value supported if 1
+ *   - CPUID.0x10.2:ECX[3]: L2 non-contiguous 1s value supported if 1
+ *
+ * Additionally Haswell requires at least two bits set. Since it does not
+ * have CPUID enumeration support for Cache allocation the non-contiguous 1s
+ * value support is disabled.
  * AMD allows non-contiguous bitmasks.
  */
 static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 85ceaf9a31ac..c47ef2f13e8e 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -492,6 +492,15 @@ union cpuid_0x10_3_eax {
 	unsigned int full;
 };
 
+/* CPUID.(EAX=10H, ECX=ResID).ECX */
+union cpuid_0x10_x_ecx {
+	struct {
+		unsigned int reserved:3;
+		unsigned int noncont:1;
+	} split;
+	unsigned int full;
+};
+
 /* CPUID.(EAX=10H, ECX=ResID).EDX */
 union cpuid_0x10_x_edx {
 	struct {
-- 
2.42.0

