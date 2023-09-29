Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B927B2ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjI2JDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjI2JC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:02:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C3A1AA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 02:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695978173; x=1727514173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9NUDEuMdcCR2MSLQ3XRZnc77sR3ihJFQ9lR6GNp+NYY=;
  b=B6neERAn2Tb+5Jble7olco4PRlbPsMccIX9V0twrDsX0FPqkC/0G0d//
   bawtszPpbBuLYTF+ySt2838+7EhF7XiapUHB0TncT2HCNi1ZWMgTXS3Dv
   In+pTTgx2Hh4xdlGV9TqES5XO5dwTjjvwlFmI0X+qERH+G7UWIQ5hdh9n
   XxRAWnJGMZRUjUrK773SeQtuyC+zCJfXWd1eSkksck4T6i4C1vAR8AkMq
   K3njA9uTW764a6MYvymw0FQJDpKL2NeNw3Ck7KFj9ppuy/gGcyRXNRajZ
   8p6jcGiEt7bqLRKXzdDZyhxKOQvoyWHFsxtgH7ryZ8Z774gztwgvJO50g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="385078547"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="385078547"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 02:02:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="749904513"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="749904513"
Received: from tzebrows-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.26.85])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 02:02:46 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Peter Newman <peternewman@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] x86/resctrl: Enable non-contiguous CBMs in Intel CAT
Date:   Fri, 29 Sep 2023 11:02:16 +0200
Message-ID: <54256710ab7f83bf5fd43c644c0a97b728b8f0b7.1695977733.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695977733.git.maciej.wieczor-retman@intel.com>
References: <cover.1695977733.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Peter Newman <peternewman@google.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v3:
- Add Peter's tested-by and reviewed-by tags.
- Change patch subject to mention CBMs. (Babu)

Changelog v2:
- Rewrite part of a comment concerning Haswell. (Reinette)

 arch/x86/kernel/cpu/resctrl/core.c        |  9 ++++++---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 10 ++++++----
 arch/x86/kernel/cpu/resctrl/internal.h    |  9 +++++++++
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index c09e4fdded3c..19e0681f0435 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -152,6 +152,7 @@ static inline void cache_alloc_hsw_probe(void)
 	r->cache.cbm_len = 20;
 	r->cache.shareable_bits = 0xc0000;
 	r->cache.min_cbm_bits = 2;
+	r->cache.arch_has_sparse_bitmasks = false;
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
+		r->cache.arch_has_sparse_bitmasks = ecx.split.noncont;
 	r->alloc_capable = true;
 }
 
@@ -872,7 +876,6 @@ static __init void rdt_init_res_defs_intel(void)
 
 		if (r->rid == RDT_RESOURCE_L3 ||
 		    r->rid == RDT_RESOURCE_L2) {
-			r->cache.arch_has_sparse_bitmasks = false;
 			r->cache.arch_has_per_cpu_cfg = false;
 			r->cache.min_cbm_bits = 1;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index ab45012288bb..beccb0e87ba7 100644
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

