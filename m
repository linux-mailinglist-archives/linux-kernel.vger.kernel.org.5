Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A3B7AAD13
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjIVItH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjIVItG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:49:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DF4A9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695372540; x=1726908540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZSI9mPubS2DHXuo/DkyS/wKdsH+OUEEwQ2sjwqZm2/Q=;
  b=JBcIrj1SbxgTSeUti4lFdyW/NlQEYp6VC1pVRN5vGa0BcJI/Szh6Q0Pv
   s64IwAFSdavVO0UkG8+fm/6OqWdeuwiQn+r7IPo4aPR+NVVGizxrHHnyh
   6DkGTgT+AOlVrvPUcT3JIjQhHOJtCn9gY7F/VAba7qk0H9Q0uq0G1KPrS
   wXJ3fAoCGdoFCHaJEOC4zb0PiZHqV3A+5+KUVlFXa6yZWB+XlYzDigUIg
   W7IvHvgDdo9mSv+OG1FdUPXuyvxGQAsR0kREVo5lEy6apXyghqkyr5sGs
   vZrZodX68SZyKoa1sH9LohcPiAZegbLKJqPgbFQ6iIDo/Uvo9hWroq2bN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="383524440"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="383524440"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 01:48:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="750769479"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="750769479"
Received: from bmatwiej-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.8.2])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 01:48:56 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] x86/resctrl: Enable non-contiguous bits in Intel CAT
Date:   Fri, 22 Sep 2023 10:48:23 +0200
Message-ID: <918e147601697b1d4b8f8589f5751e05d6ceccdf.1695371055.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695371055.git.maciej.wieczor-retman@intel.com>
References: <cover.1695371055.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Rewrite part of a comment concerning Haswell. (Reinette)

 arch/x86/kernel/cpu/resctrl/core.c        |  9 ++++++---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 10 ++++++----
 arch/x86/kernel/cpu/resctrl/internal.h    |  9 +++++++++
 3 files changed, 21 insertions(+), 7 deletions(-)

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
index b44c487727d4..f076f12cf8e8 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -87,10 +87,12 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 
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
+ * Haswell does not support a non-contiguous 1s value and additionally
+ * requires at least two bits set.
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

