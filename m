Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1263077C4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjHOAsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbjHOAsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:48:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8711726
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71C9464B89
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE69C433CA;
        Tue, 15 Aug 2023 00:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692060500;
        bh=qJhz5HZk3a2z6HLY6Omtsh1bvWUP5b6b9jSQlFYUi88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RepP7PpGxF7xtsdAuxnk2hkCRD+ZQNMd32rkSghTliLyWIUdiA4zyK5+uM3G8tT70
         2r8axp88W8OIKiiEO/X4HJQOIMiG7DLSyCWdpJf54miqkalBpkkC2zjBYnQeozgWN/
         uSIeTbJ14uhmVpTcdRtghJklZ9ZYjBbaFkkBgC+aMvHEvvBmN3kVrVhrUMMhz7Ycaa
         zBa3elptRKvyTTPjsxcqlr+Kzbe05s/FrRLWj2jkNNivgCd1qv06uimFrCsmvSQNNy
         4fp0PQDcqxQE46n3vvVkpFrWrAaa1RyLHFHHD98vDFHgrnehV6fsb9Lawarxg6MQIA
         GshihXUuKkyfQ==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 06/20] ARC: boot log: eliminate struct cpuinfo_arc #2: cache
Date:   Mon, 14 Aug 2023 17:47:59 -0700
Message-Id: <20230815004813.555115-7-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815004813.555115-1-vgupta@kernel.org>
References: <20230815004813.555115-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/arcregs.h |  37 ++++++-
 arch/arc/include/asm/setup.h   |   1 -
 arch/arc/kernel/setup.c        |   3 +-
 arch/arc/mm/cache.c            | 171 ++++++++++++---------------------
 4 files changed, 97 insertions(+), 115 deletions(-)

diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
index af00cbe9b850..cb1ad1bb4ece 100644
--- a/arch/arc/include/asm/arcregs.h
+++ b/arch/arc/include/asm/arcregs.h
@@ -206,6 +206,38 @@ struct bcr_mmu_4 {
 #endif
 };
 
+struct bcr_cache {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	unsigned int pad:12, line_len:4, sz:4, config:4, ver:8;
+#else
+	unsigned int ver:8, config:4, sz:4, line_len:4, pad:12;
+#endif
+};
+
+struct bcr_slc_cfg {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	unsigned int pad:24, way:2, lsz:2, sz:4;
+#else
+	unsigned int sz:4, lsz:2, way:2, pad:24;
+#endif
+};
+
+struct bcr_clust_cfg {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	unsigned int pad:7, c:1, num_entries:8, num_cores:8, ver:8;
+#else
+	unsigned int ver:8, num_cores:8, num_entries:8, c:1, pad:7;
+#endif
+};
+
+struct bcr_volatile {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	unsigned int start:4, limit:4, pad:22, order:1, disable:1;
+#else
+	unsigned int disable:1, order:1, pad:22, limit:4, start:4;
+#endif
+};
+
 struct bcr_mpy {
 #ifdef CONFIG_CPU_BIG_ENDIAN
 	unsigned int pad:8, x1616:8, dsp:4, cycles:2, type:2, ver:8;
@@ -328,10 +360,6 @@ struct bcr_generic {
  * Generic structures to hold build configuration used at runtime
  */
 
-struct cpuinfo_arc_cache {
-	unsigned int sz_k:14, line_len:8, assoc:4, alias:1, vipt:1, pad:4;
-};
-
 struct cpuinfo_arc_bpu {
 	unsigned int ver, full, num_cache, num_pred, ret_stk;
 };
@@ -341,7 +369,6 @@ struct cpuinfo_arc_ccm {
 };
 
 struct cpuinfo_arc {
-	struct cpuinfo_arc_cache icache, dcache, slc;
 	struct cpuinfo_arc_bpu bpu;
 	struct bcr_identity core;
 	struct bcr_isa_arcv2 isa;
diff --git a/arch/arc/include/asm/setup.h b/arch/arc/include/asm/setup.h
index 76443f198778..4c0bacd0ff5c 100644
--- a/arch/arc/include/asm/setup.h
+++ b/arch/arc/include/asm/setup.h
@@ -39,7 +39,6 @@ extern char *arc_mmu_mumbojumbo(int cpu_id, char *buf, int len);
 
 extern void arc_cache_init(void);
 extern char *arc_cache_mumbojumbo(int cpu_id, char *buf, int len);
-extern void read_decode_cache_bcr(void);
 
 extern void __init handle_uboot_args(void);
 
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 094461540f8a..3ea834941c1f 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -186,8 +186,6 @@ static void read_arc_build_cfg_regs(void)
 	/* Read CCM BCRs for boot reporting even if not enabled in Kconfig */
 	read_decode_ccm_bcr(cpu);
 
-	read_decode_cache_bcr();
-
 	if (is_isa_arcompact()) {
 		struct bcr_fp_arcompact sp, dp;
 		struct bcr_bpu_arcompact bpu;
@@ -463,6 +461,7 @@ void setup_processor(void)
 
 	pr_info("%s", arc_cpu_mumbojumbo(cpu_id, str, sizeof(str)));
 	pr_info("%s", arc_mmu_mumbojumbo(cpu_id, str, sizeof(str)));
+	pr_info("%s", arc_cache_mumbojumbo(cpu_id, str, sizeof(str)));
 
 	arc_mmu_init();
 	arc_cache_init();
diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index bdaa4aa40947..7197bb845a40 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -28,6 +28,10 @@ int slc_enable = 1, ioc_enable = 1;
 unsigned long perip_base = ARC_UNCACHED_ADDR_SPACE; /* legacy value for boot */
 unsigned long perip_end = 0xFFFFFFFF; /* legacy value */
 
+static struct cpuinfo_arc_cache {
+	unsigned int sz_k, line_len, colors;
+} ic_info, dc_info, slc_info;
+
 void (*_cache_line_loop_ic_fn)(phys_addr_t paddr, unsigned long vaddr,
 			       unsigned long sz, const int op, const int full_page);
 
@@ -35,78 +39,24 @@ void (*__dma_cache_wback_inv)(phys_addr_t start, unsigned long sz);
 void (*__dma_cache_inv)(phys_addr_t start, unsigned long sz);
 void (*__dma_cache_wback)(phys_addr_t start, unsigned long sz);
 
-char *arc_cache_mumbojumbo(int c, char *buf, int len)
+static char *read_decode_cache_bcr_arcv2(int c, char *buf, int len)
 {
-	int n = 0;
-	struct cpuinfo_arc_cache *p;
-
-#define PR_CACHE(p, cfg, str)						\
-	if (!(p)->line_len)						\
-		n += scnprintf(buf + n, len - n, str"\t\t: N/A\n");	\
-	else								\
-		n += scnprintf(buf + n, len - n,			\
-			str"\t\t: %uK, %dway/set, %uB Line, %s%s%s\n",	\
-			(p)->sz_k, (p)->assoc, (p)->line_len,		\
-			(p)->vipt ? "VIPT" : "PIPT",			\
-			(p)->alias ? " aliasing" : "",			\
-			IS_USED_CFG(cfg));
-
-	PR_CACHE(&cpuinfo_arc700[c].icache, CONFIG_ARC_HAS_ICACHE, "I-Cache");
-	PR_CACHE(&cpuinfo_arc700[c].dcache, CONFIG_ARC_HAS_DCACHE, "D-Cache");
-
-	p = &cpuinfo_arc700[c].slc;
-	if (p->line_len)
-		n += scnprintf(buf + n, len - n,
-			       "SLC\t\t: %uK, %uB Line%s\n",
-			       p->sz_k, p->line_len, IS_USED_RUN(slc_enable));
-
-	n += scnprintf(buf + n, len - n, "Peripherals\t: %#lx%s%s\n",
-		       perip_base,
-		       IS_AVAIL3(ioc_exists, ioc_enable, ", IO-Coherency (per-device) "));
-
-	return buf;
-}
-
-/*
- * Read the Cache Build Confuration Registers, Decode them and save into
- * the cpuinfo structure for later use.
- * No Validation done here, simply read/convert the BCRs
- */
-static void read_decode_cache_bcr_arcv2(int cpu)
-{
-	struct cpuinfo_arc_cache *p_slc = &cpuinfo_arc700[cpu].slc;
+	struct cpuinfo_arc_cache *p_slc = &slc_info;
+	struct bcr_identity ident;
 	struct bcr_generic sbcr;
-
-	struct bcr_slc_cfg {
-#ifdef CONFIG_CPU_BIG_ENDIAN
-		unsigned int pad:24, way:2, lsz:2, sz:4;
-#else
-		unsigned int sz:4, lsz:2, way:2, pad:24;
-#endif
-	} slc_cfg;
-
-	struct bcr_clust_cfg {
-#ifdef CONFIG_CPU_BIG_ENDIAN
-		unsigned int pad:7, c:1, num_entries:8, num_cores:8, ver:8;
-#else
-		unsigned int ver:8, num_cores:8, num_entries:8, c:1, pad:7;
-#endif
-	} cbcr;
-
-	struct bcr_volatile {
-#ifdef CONFIG_CPU_BIG_ENDIAN
-		unsigned int start:4, limit:4, pad:22, order:1, disable:1;
-#else
-		unsigned int disable:1, order:1, pad:22, limit:4, start:4;
-#endif
-	} vol;
-
+	struct bcr_clust_cfg cbcr;
+	struct bcr_volatile vol;
+	int n = 0;
 
 	READ_BCR(ARC_REG_SLC_BCR, sbcr);
 	if (sbcr.ver) {
+		struct bcr_slc_cfg  slc_cfg;
 		READ_BCR(ARC_REG_SLC_CFG, slc_cfg);
 		p_slc->sz_k = 128 << slc_cfg.sz;
 		l2_line_sz = p_slc->line_len = (slc_cfg.lsz == 0) ? 128 : 64;
+		n += scnprintf(buf + n, len - n,
+			       "SLC\t\t: %uK, %uB Line%s\n",
+			       p_slc->sz_k, p_slc->line_len, IS_USED_RUN(slc_enable));
 	}
 
 	READ_BCR(ARC_REG_CLUSTER_BCR, cbcr);
@@ -129,70 +79,83 @@ static void read_decode_cache_bcr_arcv2(int cpu)
 		ioc_enable = 0;
 	}
 
+	READ_BCR(AUX_IDENTITY, ident);
+
 	/* HS 2.0 didn't have AUX_VOL */
-	if (cpuinfo_arc700[cpu].core.family > 0x51) {
+	if (ident.family > 0x51) {
 		READ_BCR(AUX_VOL, vol);
 		perip_base = vol.start << 28;
 		/* HS 3.0 has limit and strict-ordering fields */
-		if (cpuinfo_arc700[cpu].core.family > 0x52)
+		if (ident.family > 0x52)
 			perip_end = (vol.limit << 28) - 1;
 	}
+
+	n += scnprintf(buf + n, len - n, "Peripherals\t: %#lx%s%s\n",
+		       perip_base,
+		       IS_AVAIL3(ioc_exists, ioc_enable, ", IO-Coherency (per-device) "));
+
+	return buf;
 }
 
-void read_decode_cache_bcr(void)
+char *arc_cache_mumbojumbo(int c, char *buf, int len)
 {
-	struct cpuinfo_arc_cache *p_ic, *p_dc;
-	unsigned int cpu = smp_processor_id();
-	struct bcr_cache {
-#ifdef CONFIG_CPU_BIG_ENDIAN
-		unsigned int pad:12, line_len:4, sz:4, config:4, ver:8;
-#else
-		unsigned int ver:8, config:4, sz:4, line_len:4, pad:12;
-#endif
-	} ibcr, dbcr;
+	struct cpuinfo_arc_cache *p_ic = &ic_info, *p_dc = &dc_info;
+	struct bcr_cache ibcr, dbcr;
+	int vipt, assoc;
+	int n = 0;
 
-	p_ic = &cpuinfo_arc700[cpu].icache;
 	READ_BCR(ARC_REG_IC_BCR, ibcr);
-
 	if (!ibcr.ver)
 		goto dc_chk;
 
-	if (ibcr.ver <= 3) {
+	if (is_isa_arcompact() && (ibcr.ver <= 3)) {
 		BUG_ON(ibcr.config != 3);
-		p_ic->assoc = 2;		/* Fixed to 2w set assoc */
-	} else if (ibcr.ver >= 4) {
-		p_ic->assoc = 1 << ibcr.config;	/* 1,2,4,8 */
+		assoc = 2;		/* Fixed to 2w set assoc */
+	} else if (is_isa_arcv2() && (ibcr.ver >= 4)) {
+		assoc = 1 << ibcr.config;	/* 1,2,4,8 */
 	}
 
 	p_ic->line_len = 8 << ibcr.line_len;
 	p_ic->sz_k = 1 << (ibcr.sz - 1);
-	p_ic->vipt = 1;
-	p_ic->alias = p_ic->sz_k/p_ic->assoc/TO_KB(PAGE_SIZE) > 1;
+	p_ic->colors = p_ic->sz_k/assoc/TO_KB(PAGE_SIZE);
+
+	n += scnprintf(buf + n, len - n,
+			"I-Cache\t\t: %uK, %dway/set, %uB Line, VIPT%s%s\n",
+			p_ic->sz_k, assoc, p_ic->line_len,
+			p_ic->colors > 1 ? " aliasing" : "",
+			IS_USED_CFG(CONFIG_ARC_HAS_ICACHE));
 
 dc_chk:
-	p_dc = &cpuinfo_arc700[cpu].dcache;
 	READ_BCR(ARC_REG_DC_BCR, dbcr);
-
 	if (!dbcr.ver)
 		goto slc_chk;
 
-	if (dbcr.ver <= 3) {
+	if (is_isa_arcompact() && (dbcr.ver <= 3)) {
 		BUG_ON(dbcr.config != 2);
-		p_dc->assoc = 4;		/* Fixed to 4w set assoc */
-		p_dc->vipt = 1;
-		p_dc->alias = p_dc->sz_k/p_dc->assoc/TO_KB(PAGE_SIZE) > 1;
-	} else if (dbcr.ver >= 4) {
-		p_dc->assoc = 1 << dbcr.config;	/* 1,2,4,8 */
-		p_dc->vipt = 0;
-		p_dc->alias = 0;		/* PIPT so can't VIPT alias */
+		vipt = 1;
+		assoc = 4;		/* Fixed to 4w set assoc */
+		p_dc->colors = p_dc->sz_k/assoc/TO_KB(PAGE_SIZE);
+	} else if (is_isa_arcv2() && (dbcr.ver >= 4)) {
+		vipt = 0;
+		assoc = 1 << dbcr.config;	/* 1,2,4,8 */
+		p_dc->colors = 1;		/* PIPT so can't VIPT alias */
 	}
 
 	p_dc->line_len = 16 << dbcr.line_len;
 	p_dc->sz_k = 1 << (dbcr.sz - 1);
 
+	n += scnprintf(buf + n, len - n,
+			"D-Cache\t\t: %uK, %dway/set, %uB Line, %s%s%s\n",
+			p_dc->sz_k, assoc, p_dc->line_len,
+			vipt ? "VIPT" : "PIPT",
+			p_dc->colors > 1 ? " aliasing" : "",
+			IS_USED_CFG(CONFIG_ARC_HAS_DCACHE));
+
 slc_chk:
 	if (is_isa_arcv2())
-                read_decode_cache_bcr_arcv2(cpu);
+		read_decode_cache_bcr_arcv2(c, buf + n, len - n);
+
+	return buf;
 }
 
 /*
@@ -1133,10 +1096,8 @@ static noinline void __init arc_ioc_setup(void)
  */
 static noinline void __init arc_cache_init_master(void)
 {
-	unsigned int __maybe_unused cpu = smp_processor_id();
-
 	if (IS_ENABLED(CONFIG_ARC_HAS_ICACHE)) {
-		struct cpuinfo_arc_cache *ic = &cpuinfo_arc700[cpu].icache;
+		struct cpuinfo_arc_cache *ic = &ic_info;
 
 		if (!ic->line_len)
 			panic("cache support enabled but non-existent cache\n");
@@ -1149,14 +1110,14 @@ static noinline void __init arc_cache_init_master(void)
 		 * In MMU v4 (HS38x) the aliasing icache config uses IVIL/PTAG
 		 * pair to provide vaddr/paddr respectively, just as in MMU v3
 		 */
-		if (is_isa_arcv2() && ic->alias)
+		if (is_isa_arcv2() && ic->colors > 1)
 			_cache_line_loop_ic_fn = __cache_line_loop_v3;
 		else
 			_cache_line_loop_ic_fn = __cache_line_loop;
 	}
 
 	if (IS_ENABLED(CONFIG_ARC_HAS_DCACHE)) {
-		struct cpuinfo_arc_cache *dc = &cpuinfo_arc700[cpu].dcache;
+		struct cpuinfo_arc_cache *dc = &dc_info;
 
 		if (!dc->line_len)
 			panic("cache support enabled but non-existent cache\n");
@@ -1168,14 +1129,13 @@ static noinline void __init arc_cache_init_master(void)
 		/* check for D-Cache aliasing on ARCompact: ARCv2 has PIPT */
 		if (is_isa_arcompact()) {
 			int handled = IS_ENABLED(CONFIG_ARC_CACHE_VIPT_ALIASING);
-			int num_colors = dc->sz_k/dc->assoc/TO_KB(PAGE_SIZE);
 
-			if (dc->alias) {
+			if (dc->colors > 1) {
 				if (!handled)
 					panic("Enable CONFIG_ARC_CACHE_VIPT_ALIASING\n");
-				if (CACHE_COLORS_NUM != num_colors)
+				if (CACHE_COLORS_NUM != dc->colors)
 					panic("CACHE_COLORS_NUM not optimized for config\n");
-			} else if (!dc->alias && handled) {
+			} else if (handled && dc->colors == 1) {
 				panic("Disable CONFIG_ARC_CACHE_VIPT_ALIASING\n");
 			}
 		}
@@ -1218,9 +1178,6 @@ static noinline void __init arc_cache_init_master(void)
 void __ref arc_cache_init(void)
 {
 	unsigned int __maybe_unused cpu = smp_processor_id();
-	char str[256];
-
-	pr_info("%s", arc_cache_mumbojumbo(0, str, sizeof(str)));
 
 	if (!cpu)
 		arc_cache_init_master();
-- 
2.34.1

