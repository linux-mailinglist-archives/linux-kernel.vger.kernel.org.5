Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DF07C5E33
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376356AbjJKUSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbjJKUSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:18:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFB1CF;
        Wed, 11 Oct 2023 13:18:22 -0700 (PDT)
Date:   Wed, 11 Oct 2023 20:18:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697055500;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jWuFbMswr09wMFrs5SzZIDyvGH/keIfGu9UO7V59BVk=;
        b=NvEyqHmB+xhhYrZAgzsCq5J3iubfVEqETQqBExliZjukyt7SLiRUQ4/PpZxxHLmRciExOs
        UI/syO1QQn7ew+y5XUOLXg+8djkSLkY7y6q87E75IGXZeah4/O68/b482JyrGmqme/2zYU
        9x7PICdYjCV7K5HTgd1r5fCxlhPj2nuWZuM37iQF0Qm8oUfogxPkzCaxtBKhJ4ulXgLNCS
        Z92Wp+VsTGXjRdo7zK/SwbpzKN1ltfn2gQKQhxZLOlEAMqaaM8lLGhbB6sW0Y1sKTPEwl6
        N+tPJWla1Jl+BRD2v80dy24B1HBw2JzsLXooxTmip5G0nBe+rMF80eFkP7J9gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697055500;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jWuFbMswr09wMFrs5SzZIDyvGH/keIfGu9UO7V59BVk=;
        b=ibhpmU50OA5XiwspUIImVkIwzgI+3tNJYHAnDp7Pa9H0P22fs9u/zlA32Tx/zq1C8bJxr0
        UJOzMw2HEEv9v5Ag==
From:   "tip-bot2 for Maciej Wieczor-Retman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Enable non-contiguous CBMs in Intel CAT
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        "Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        ilpo.jarvinen@linux.intel.com,
        Peter Newman <peternewman@google.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C1849b487256fe4de40b30f88450cba3d9abc9171=2E16969?=
 =?utf-8?q?34091=2Egit=2Emaciej=2Ewieczor-retman=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C1849b487256fe4de40b30f88450cba3d9abc9171=2E169693?=
 =?utf-8?q?4091=2Egit=2Emaciej=2Ewieczor-retman=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169705550008.3135.11514096638108067127.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     0e3cd31f6e9074886dea5a999bfcc563d144e7de
Gitweb:        https://git.kernel.org/tip/0e3cd31f6e9074886dea5a999bfcc563d14=
4e7de
Author:        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
AuthorDate:    Tue, 10 Oct 2023 12:42:37 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 11 Oct 2023 21:48:52 +02:00

x86/resctrl: Enable non-contiguous CBMs in Intel CAT

The setting for non-contiguous 1s support in Intel CAT is
hardcoded to false. On these systems, writing non-contiguous
1s into the schemata file will fail before resctrl passes
the value to the hardware.

In Intel CAT CPUID.0x10.1:ECX[3] and CPUID.0x10.2:ECX[3] stopped
being reserved and now carry information about non-contiguous 1s
value support for L3 and L2 cache respectively. The CAT
capacity bitmask (CBM) supports a non-contiguous 1s value if
the bit is set.

The exception are Haswell systems where non-contiguous 1s value
support needs to stay disabled since they can't make use of CPUID
for Cache allocation.

Originally-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Link: https://lore.kernel.org/r/1849b487256fe4de40b30f88450cba3d9abc9171.1696=
934091.git.maciej.wieczor-retman@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c        |  9 ++++++---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 10 ++++++----
 arch/x86/kernel/cpu/resctrl/internal.h    |  9 +++++++++
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index c09e4fd..19e0681 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -152,6 +152,7 @@ static inline void cache_alloc_hsw_probe(void)
 	r->cache.cbm_len =3D 20;
 	r->cache.shareable_bits =3D 0xc0000;
 	r->cache.min_cbm_bits =3D 2;
+	r->cache.arch_has_sparse_bitmasks =3D false;
 	r->alloc_capable =3D true;
=20
 	rdt_alloc_capable =3D true;
@@ -267,15 +268,18 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt=
_resource *r)
 {
 	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);
 	union cpuid_0x10_1_eax eax;
+	union cpuid_0x10_x_ecx ecx;
 	union cpuid_0x10_x_edx edx;
-	u32 ebx, ecx;
+	u32 ebx;
=20
-	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx, &edx.full);
+	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx.full, &edx.full);
 	hw_res->num_closid =3D edx.split.cos_max + 1;
 	r->cache.cbm_len =3D eax.split.cbm_len + 1;
 	r->default_ctrl =3D BIT_MASK(eax.split.cbm_len + 1) - 1;
 	r->cache.shareable_bits =3D ebx & r->default_ctrl;
 	r->data_width =3D (r->cache.cbm_len + 3) / 4;
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL)
+		r->cache.arch_has_sparse_bitmasks =3D ecx.split.noncont;
 	r->alloc_capable =3D true;
 }
=20
@@ -872,7 +876,6 @@ static __init void rdt_init_res_defs_intel(void)
=20
 		if (r->rid =3D=3D RDT_RESOURCE_L3 ||
 		    r->rid =3D=3D RDT_RESOURCE_L2) {
-			r->cache.arch_has_sparse_bitmasks =3D false;
 			r->cache.arch_has_per_cpu_cfg =3D false;
 			r->cache.min_cbm_bits =3D 1;
 		} else if (r->rid =3D=3D RDT_RESOURCE_MBA) {
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/=
resctrl/ctrlmondata.c
index ab45012..beccb0e 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -87,10 +87,12 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_=
schema *s,
=20
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
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/res=
ctrl/internal.h
index 85ceaf9..c47ef2f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -492,6 +492,15 @@ union cpuid_0x10_3_eax {
 	unsigned int full;
 };
=20
+/* CPUID.(EAX=3D10H, ECX=3DResID).ECX */
+union cpuid_0x10_x_ecx {
+	struct {
+		unsigned int reserved:3;
+		unsigned int noncont:1;
+	} split;
+	unsigned int full;
+};
+
 /* CPUID.(EAX=3D10H, ECX=3DResID).EDX */
 union cpuid_0x10_x_edx {
 	struct {
