Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DC97804BF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357717AbjHRDfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357759AbjHRDfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:35:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D9C12B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 20:35:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FFB6678DE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 03:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F820C433C8;
        Fri, 18 Aug 2023 03:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692329711;
        bh=j21IPnWewZRlopDY6KBkyKfCOLE74CiqYfYYtQ5oSQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tvL4pCW82+PXY5wShsLbFEwGV54OZqVRP1YG15gWaQIw5j99BBLwnhWl7n6oNHLgv
         bRV68GZTJLJxhuzxfcwiu5+CR0POz4kmpyDk4O6VbkGp8g0oTjIhpkwfAQqKam2U8u
         jn/e2aQT2UA+mJmtS5pguABy3R20+Yyc6vGB9ju/aUSBKDmULAnUfSI4c6v55qzME4
         JA8OSRc9u+/bc40IgEPkKz8lcMw4Ms7ln/4B49kq8qdAy31jYecinKwJTha+r0ccYY
         VCWTrgx2LuIqeyy3dEfQrdM3c5LevESStdmMJalxXQPC16g7nywfSSW6vO7QXpMlW+
         Aq/YXR+XtA3Cw==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Pavel.Kozlov@synopsys.com, Vineet Gupta <vgupta@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 08/20] ARC: boot log: eliminate struct cpuinfo_arc #4: boot log per ISA
Date:   Thu, 17 Aug 2023 20:35:09 -0700
Message-Id: <20230818033509.649805-1-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202308162101.Ve5jBg80-lkp@intel.com>
References: <202308162101.Ve5jBg80-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - boot log now clearly per ISA
 - global struct cpuinfo_arc[] elimiated
 - local struct struct arcinfo kept for passing info
   between functions

Tested-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308162101.Ve5jBg80-lkp@intel.com
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/arcregs.h |  33 +-
 arch/arc/include/asm/setup.h   |   4 +-
 arch/arc/kernel/setup.c        | 560 +++++++++++++++------------------
 arch/arc/mm/cache.c            |  10 +-
 arch/arc/mm/tlb.c              |   4 +-
 5 files changed, 268 insertions(+), 343 deletions(-)

diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
index 160ee3fab1bd..4b13f60fe7ca 100644
--- a/arch/arc/include/asm/arcregs.h
+++ b/arch/arc/include/asm/arcregs.h
@@ -23,7 +23,7 @@
 #define ARC_REG_ICCM_BUILD	0x78	/* ICCM size (common) */
 #define ARC_REG_XY_MEM_BCR	0x79
 #define ARC_REG_MAC_BCR		0x7a
-#define ARC_REG_MUL_BCR		0x7b
+#define ARC_REG_MPY_BCR		0x7b
 #define ARC_REG_SWAP_BCR	0x7c
 #define ARC_REG_NORM_BCR	0x7d
 #define ARC_REG_MIXMAX_BCR	0x7e
@@ -177,7 +177,7 @@ struct bcr_isa_arcv2 {
 #endif
 };
 
-struct bcr_uarch_build_arcv2 {
+struct bcr_uarch_build {
 #ifdef CONFIG_CPU_BIG_ENDIAN
 	unsigned int pad:8, prod:8, maj:8, min:8;
 #else
@@ -355,35 +355,6 @@ struct bcr_generic {
 #endif
 };
 
-/*
- *******************************************************************
- * Generic structures to hold build configuration used at runtime
- */
-
-struct cpuinfo_arc_bpu {
-	unsigned int ver, full, num_cache, num_pred, ret_stk;
-};
-
-struct cpuinfo_arc_ccm {
-	unsigned int base_addr, sz;
-};
-
-struct cpuinfo_arc {
-	struct cpuinfo_arc_bpu bpu;
-	struct bcr_identity core;
-	struct bcr_isa_arcv2 isa;
-	const char *release, *name;
-	unsigned int vec_base;
-	struct cpuinfo_arc_ccm iccm, dccm;
-	struct {
-		unsigned int swap:1, norm:1, minmax:1, barrel:1, crc:1, swape:1, pad1:2,
-			     fpu_sp:1, fpu_dp:1, dual:1, dual_enb:1, pad2:4,
-			     ap_num:4, ap_full:1, smart:1, rtt:1, pad3:1,
-			     timer0:1, timer1:1, rtc:1, gfrc:1, pad4:4;
-	} extn;
-	struct bcr_mpy extn_mpy;
-};
-
 static inline int is_isa_arcv2(void)
 {
 	return IS_ENABLED(CONFIG_ISA_ARCV2);
diff --git a/arch/arc/include/asm/setup.h b/arch/arc/include/asm/setup.h
index 4c0bacd0ff5c..1c6db599e1fc 100644
--- a/arch/arc/include/asm/setup.h
+++ b/arch/arc/include/asm/setup.h
@@ -35,10 +35,10 @@ long __init arc_get_mem_sz(void);
 #define IS_AVAIL3(v, v2, s)	IS_AVAIL1(v, s), IS_AVAIL1(v, IS_DISABLED_RUN(v2))
 
 extern void arc_mmu_init(void);
-extern char *arc_mmu_mumbojumbo(int cpu_id, char *buf, int len);
+extern int arc_mmu_mumbojumbo(int cpu_id, char *buf, int len);
 
 extern void arc_cache_init(void);
-extern char *arc_cache_mumbojumbo(int cpu_id, char *buf, int len);
+extern int arc_cache_mumbojumbo(int cpu_id, char *buf, int len);
 
 extern void __init handle_uboot_args(void);
 
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 3ea834941c1f..0aa49308d792 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -29,6 +29,7 @@
 #include <asm/mach_desc.h>
 #include <asm/smp.h>
 #include <asm/dsp-impl.h>
+#include <soc/arc/mcip.h>
 
 #define FIX_PTR(x)  __asm__ __volatile__(";" : "+r"(x))
 
@@ -43,19 +44,22 @@ const struct machine_desc *machine_desc;
 
 struct task_struct *_current_task[NR_CPUS];	/* For stack switching */
 
-struct cpuinfo_arc cpuinfo_arc700[NR_CPUS];
+struct cpuinfo_arc {
+	int arcver;
+	unsigned int t0:1, t1:1;
+	struct {
+		unsigned long base;
+		unsigned int sz;
+	} iccm, dccm;
+};
+
+#ifdef CONFIG_ISA_ARCV2
 
-static const struct id_to_str arc_legacy_rel[] = {
+static const struct id_to_str arc_hs_rel[] = {
 	/* ID.ARCVER,	Release */
-#ifdef CONFIG_ISA_ARCOMPACT
-	{ 0x34, 	"R4.10"},
-	{ 0x35, 	"R4.11"},
-#else
 	{ 0x51, 	"R2.0" },
 	{ 0x52, 	"R2.1" },
 	{ 0x53,		"R3.0" },
-#endif
-	{ 0x00,		NULL   }
 };
 
 static const struct id_to_str arc_hs_ver54_rel[] = {
@@ -66,320 +70,294 @@ static const struct id_to_str arc_hs_ver54_rel[] = {
 	{  3,		"R4.00a"},
 	{  0xFF,	NULL   }
 };
+#endif
 
-static void read_decode_ccm_bcr(struct cpuinfo_arc *cpu)
+static int
+arcompact_mumbojumbo(int c, struct cpuinfo_arc *info, char *buf, int len)
 {
-	if (is_isa_arcompact()) {
-		struct bcr_iccm_arcompact iccm;
-		struct bcr_dccm_arcompact dccm;
+	int n = 0;
+#ifdef CONFIG_ISA_ARCOMPACT
+	char *cpu_nm, *isa_nm = "ARCompact";
+	struct bcr_fp_arcompact fpu_sp, fpu_dp;
+	int atomic = 0, be, present;
+	int bpu_full, bpu_cache, bpu_pred;
+	struct bcr_bpu_arcompact bpu;
+	struct bcr_iccm_arcompact iccm;
+	struct bcr_dccm_arcompact dccm;
+	struct bcr_generic isa;
 
-		READ_BCR(ARC_REG_ICCM_BUILD, iccm);
-		if (iccm.ver) {
-			cpu->iccm.sz = 4096 << iccm.sz;	/* 8K to 512K */
-			cpu->iccm.base_addr = iccm.base << 16;
-		}
+	READ_BCR(ARC_REG_ISA_CFG_BCR, isa);
 
-		READ_BCR(ARC_REG_DCCM_BUILD, dccm);
-		if (dccm.ver) {
-			unsigned long base;
-			cpu->dccm.sz = 2048 << dccm.sz;	/* 2K to 256K */
+	if (!isa.ver)	/* ISA BCR absent, use Kconfig info */
+		atomic = IS_ENABLED(CONFIG_ARC_HAS_LLSC);
+	else {
+		/* ARC700_BUILD only has 2 bits of isa info */
+		atomic = isa.info & 1;
+	}
 
-			base = read_aux_reg(ARC_REG_DCCM_BASE_BUILD);
-			cpu->dccm.base_addr = base & ~0xF;
-		}
-	} else {
-		struct bcr_iccm_arcv2 iccm;
-		struct bcr_dccm_arcv2 dccm;
-		unsigned long region;
-
-		READ_BCR(ARC_REG_ICCM_BUILD, iccm);
-		if (iccm.ver) {
-			cpu->iccm.sz = 256 << iccm.sz00;	/* 512B to 16M */
-			if (iccm.sz00 == 0xF && iccm.sz01 > 0)
-				cpu->iccm.sz <<= iccm.sz01;
-
-			region = read_aux_reg(ARC_REG_AUX_ICCM);
-			cpu->iccm.base_addr = region & 0xF0000000;
-		}
+	be = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
 
-		READ_BCR(ARC_REG_DCCM_BUILD, dccm);
-		if (dccm.ver) {
-			cpu->dccm.sz = 256 << dccm.sz0;
-			if (dccm.sz0 == 0xF && dccm.sz1 > 0)
-				cpu->dccm.sz <<= dccm.sz1;
+	if (info->arcver < 0x34)
+		cpu_nm = "ARC750";
+	else
+		cpu_nm = "ARC770";
 
-			region = read_aux_reg(ARC_REG_AUX_DCCM);
-			cpu->dccm.base_addr = region & 0xF0000000;
-		}
-	}
-}
+	n += scnprintf(buf + n, len - n, "processor [%d]\t: %s (%s ISA) %s\n",
+		       c, cpu_nm, isa_nm, IS_AVAIL1(be, "[Big-Endian]"));
 
-static void decode_arc_core(struct cpuinfo_arc *cpu)
-{
-	struct bcr_uarch_build_arcv2 uarch;
-	const struct id_to_str *tbl;
-
-	if (cpu->core.family < 0x54) { /* includes arc700 */
+	READ_BCR(ARC_REG_FP_BCR, fpu_sp);
+	READ_BCR(ARC_REG_DPFP_BCR, fpu_dp);
 
-		for (tbl = &arc_legacy_rel[0]; tbl->id != 0; tbl++) {
-			if (cpu->core.family == tbl->id) {
-				cpu->release = tbl->str;
-				break;
-			}
-		}
+	if (fpu_sp.ver | fpu_dp.ver)
+		n += scnprintf(buf + n, len - n, "FPU\t\t: %s%s\n",
+			       IS_AVAIL1(fpu_sp.ver, "SP "),
+			       IS_AVAIL1(fpu_dp.ver, "DP "));
 
-		if (is_isa_arcompact())
-			cpu->name = "ARC700";
-		else if (tbl->str)
-			cpu->name = "HS38";
-		else
-			cpu->name = cpu->release = "Unknown";
+	READ_BCR(ARC_REG_BPU_BCR, bpu);
+	bpu_full = bpu.fam ? 1 : 0;
+	bpu_cache = 256 << (bpu.ent - 1);
+	bpu_pred = 256 << (bpu.ent - 1);
 
-		return;
+	n += scnprintf(buf + n, len - n,
+			"BPU\t\t: %s%s match, cache:%d, Predict Table:%d\n",
+			IS_AVAIL1(bpu_full, "full"),
+			IS_AVAIL1(!bpu_full, "partial"),
+			bpu_cache, bpu_pred);
+
+	READ_BCR(ARC_REG_ICCM_BUILD, iccm);
+	if (iccm.ver) {
+		info->iccm.sz = 4096 << iccm.sz;	/* 8K to 512K */
+		info->iccm.base = iccm.base << 16;
 	}
 
-	/*
-	 * Initial HS cores bumped AUX IDENTITY.ARCVER for each release until
-	 * ARCVER 0x54 which introduced AUX MICRO_ARCH_BUILD and subsequent
-	 * releases only update it.
-	 */
-	READ_BCR(ARC_REG_MICRO_ARCH_BCR, uarch);
-
-	if (uarch.prod == 4) {
-		cpu->name = "HS48";
-		cpu->extn.dual = 1;
+	READ_BCR(ARC_REG_DCCM_BUILD, dccm);
+	if (dccm.ver) {
+		unsigned long base;
+		info->dccm.sz = 2048 << dccm.sz;	/* 2K to 256K */
 
-	} else {
-		cpu->name = "HS38";
+		base = read_aux_reg(ARC_REG_DCCM_BASE_BUILD);
+		info->dccm.base = base & ~0xF;
 	}
 
-	for (tbl = &arc_hs_ver54_rel[0]; tbl->id != 0xFF; tbl++) {
-		if (uarch.maj == tbl->id) {
-			cpu->release = tbl->str;
-			break;
-		}
-	}
+	/* ARCompact ISA specific sanity checks */
+	present = fpu_dp.ver;	/* SP has no arch visible regs */
+	CHK_OPT_STRICT(CONFIG_ARC_FPU_SAVE_RESTORE, present);
+#endif
+	return n;
+
 }
 
-static void read_arc_build_cfg_regs(void)
+static int arcv2_mumbojumbo(int c, struct cpuinfo_arc *info, char *buf, int len)
 {
-	struct bcr_timer timer;
-	struct bcr_generic bcr;
-	struct cpuinfo_arc *cpu = &cpuinfo_arc700[smp_processor_id()];
+	int n = 0;
+#ifdef CONFIG_ISA_ARCV2
+	const char *release, *cpu_nm, *isa_nm = "ARCv2";
+	int dual_issue = 0, dual_enb = 0, mpy_opt, present;
+	int bpu_full, bpu_cache, bpu_pred, bpu_ret_stk;
+	char mpy_nm[16], lpb_nm[32];
 	struct bcr_isa_arcv2 isa;
-	struct bcr_actionpoint ap;
-
-	FIX_PTR(cpu);
-
-	READ_BCR(AUX_IDENTITY, cpu->core);
-	decode_arc_core(cpu);
+	struct bcr_mpy mpy;
+	struct bcr_fp_arcv2 fpu;
+	struct bcr_bpu_arcv2 bpu;
+	struct bcr_lpb lpb;
+	struct bcr_iccm_arcv2 iccm;
+	struct bcr_dccm_arcv2 dccm;
+	struct bcr_erp erp;
 
-	READ_BCR(ARC_REG_TIMERS_BCR, timer);
-	cpu->extn.timer0 = timer.t0;
-	cpu->extn.timer1 = timer.t1;
-	cpu->extn.rtc = timer.rtc;
+	/*
+	 * Initial HS cores bumped AUX IDENTITY.ARCVER for each release until
+	 * ARCVER 0x54 which introduced AUX MICRO_ARCH_BUILD and subsequent
+	 * releases only update it.
+	 */
 
-	cpu->vec_base = read_aux_reg(AUX_INTR_VEC_BASE);
+	cpu_nm = "HS38";
 
-	READ_BCR(ARC_REG_MUL_BCR, cpu->extn_mpy);
+	if (info->arcver > 0x50 && info->arcver <= 0x53) {
+		release = arc_hs_rel[info->arcver - 0x51].str;
+	} else {
+		const struct id_to_str *tbl;
+		struct bcr_uarch_build uarch;
 
-	/* Read CCM BCRs for boot reporting even if not enabled in Kconfig */
-	read_decode_ccm_bcr(cpu);
+		READ_BCR(ARC_REG_MICRO_ARCH_BCR, uarch);
 
-	if (is_isa_arcompact()) {
-		struct bcr_fp_arcompact sp, dp;
-		struct bcr_bpu_arcompact bpu;
-
-		READ_BCR(ARC_REG_FP_BCR, sp);
-		READ_BCR(ARC_REG_DPFP_BCR, dp);
-		cpu->extn.fpu_sp = sp.ver ? 1 : 0;
-		cpu->extn.fpu_dp = dp.ver ? 1 : 0;
-
-		READ_BCR(ARC_REG_BPU_BCR, bpu);
-		cpu->bpu.ver = bpu.ver;
-		cpu->bpu.full = bpu.fam ? 1 : 0;
-		if (bpu.ent) {
-			cpu->bpu.num_cache = 256 << (bpu.ent - 1);
-			cpu->bpu.num_pred = 256 << (bpu.ent - 1);
+		for (tbl = &arc_hs_ver54_rel[0]; tbl->id != 0xFF; tbl++) {
+			if (uarch.maj == tbl->id) {
+				release = tbl->str;
+				break;
+			}
 		}
-	} else {
-		struct bcr_fp_arcv2 spdp;
-		struct bcr_bpu_arcv2 bpu;
-
-		READ_BCR(ARC_REG_FP_V2_BCR, spdp);
-		cpu->extn.fpu_sp = spdp.sp ? 1 : 0;
-		cpu->extn.fpu_dp = spdp.dp ? 1 : 0;
-
-		READ_BCR(ARC_REG_BPU_BCR, bpu);
-		cpu->bpu.ver = bpu.ver;
-		cpu->bpu.full = bpu.ft;
-		cpu->bpu.num_cache = 256 << bpu.bce;
-		cpu->bpu.num_pred = 2048 << bpu.pte;
-		cpu->bpu.ret_stk = 4 << bpu.rse;
-
-		/* if dual issue hardware, is it enabled ? */
-		if (cpu->extn.dual) {
+		if (uarch.prod == 4) {
 			unsigned int exec_ctrl;
 
+			cpu_nm = "HS48";
+			dual_issue = 1;
+			/* if dual issue hardware, is it enabled ? */
 			READ_BCR(AUX_EXEC_CTRL, exec_ctrl);
-			cpu->extn.dual_enb = !(exec_ctrl & 1);
+			dual_enb = !(exec_ctrl & 1);
 		}
 	}
 
-	READ_BCR(ARC_REG_AP_BCR, ap);
-	if (ap.ver) {
-		cpu->extn.ap_num = 2 << ap.num;
-		cpu->extn.ap_full = !ap.min;
-	}
-
-	READ_BCR(ARC_REG_SMART_BCR, bcr);
-	cpu->extn.smart = bcr.ver ? 1 : 0;
-
-	READ_BCR(ARC_REG_RTT_BCR, bcr);
-	cpu->extn.rtt = bcr.ver ? 1 : 0;
-
 	READ_BCR(ARC_REG_ISA_CFG_BCR, isa);
 
-	/* some hacks for lack of feature BCR info in old ARC700 cores */
-	if (is_isa_arcompact()) {
-		if (!isa.ver)	/* ISA BCR absent, use Kconfig info */
-			cpu->isa.atomic = IS_ENABLED(CONFIG_ARC_HAS_LLSC);
-		else {
-			/* ARC700_BUILD only has 2 bits of isa info */
-			struct bcr_generic bcr = *(struct bcr_generic *)&isa;
-			cpu->isa.atomic = bcr.info & 1;
-		}
-
-		cpu->isa.be = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
+	n += scnprintf(buf + n, len - n, "processor [%d]\t: %s %s (%s ISA) %s%s%s\n",
+		       c, cpu_nm, release, isa_nm,
+		       IS_AVAIL1(isa.be, "[Big-Endian]"),
+		       IS_AVAIL3(dual_issue, dual_enb, " Dual-Issue "));
+
+	READ_BCR(ARC_REG_MPY_BCR, mpy);
+	mpy_opt = 2;	/* stock MPY/MPYH */
+	if (mpy.dsp)	/* OPT 7-9 */
+		mpy_opt = mpy.dsp + 6;
+
+	scnprintf(mpy_nm, 16, "mpy[opt %d] ", mpy_opt);
+
+	READ_BCR(ARC_REG_FP_V2_BCR, fpu);
+
+	n += scnprintf(buf + n, len - n, "ISA Extn\t: %s%s%s%s%s%s%s%s%s%s%s\n",
+		       IS_AVAIL2(isa.atomic, "atomic ", CONFIG_ARC_HAS_LLSC),
+		       IS_AVAIL2(isa.ldd, "ll64 ", CONFIG_ARC_HAS_LL64),
+		       IS_AVAIL2(isa.unalign, "unalign ", CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS),
+		       IS_AVAIL1(mpy.ver, mpy_nm),
+		       IS_AVAIL1(isa.div_rem, "div_rem "),
+		       IS_AVAIL1((fpu.sp | fpu.dp), "  FPU:"),
+		       IS_AVAIL1(fpu.sp, " sp"),
+		       IS_AVAIL1(fpu.dp, " dp"));
+
+	READ_BCR(ARC_REG_BPU_BCR, bpu);
+	bpu_full = bpu.ft;
+	bpu_cache = 256 << bpu.bce;
+	bpu_pred = 2048 << bpu.pte;
+	bpu_ret_stk = 4 << bpu.rse;
+
+	READ_BCR(ARC_REG_LPB_BUILD, lpb);
+	if (lpb.ver) {
+		unsigned int ctl;
+		ctl = read_aux_reg(ARC_REG_LPB_CTRL);
+
+		scnprintf(lpb_nm, sizeof(lpb_nm), " Loop Buffer:%d %s",
+			  lpb.entries, IS_DISABLED_RUN(!ctl));
+	}
 
-		 /* there's no direct way to distinguish 750 vs. 770 */
-		if (unlikely(cpu->core.family < 0x34))
-			cpu->name = "ARC750";
-	} else {
-		cpu->isa = isa;
+	n += scnprintf(buf + n, len - n,
+			"BPU\t\t: %s%s match, cache:%d, Predict Table:%d Return stk: %d%s\n",
+			IS_AVAIL1(bpu_full, "full"),
+			IS_AVAIL1(!bpu_full, "partial"),
+			bpu_cache, bpu_pred, bpu_ret_stk,
+			lpb_nm);
+
+	READ_BCR(ARC_REG_ICCM_BUILD, iccm);
+	if (iccm.ver) {
+		unsigned long base;
+		info->iccm.sz = 256 << iccm.sz00;	/* 512B to 16M */
+		if (iccm.sz00 == 0xF && iccm.sz01 > 0)
+			info->iccm.sz <<= iccm.sz01;
+		base = read_aux_reg(ARC_REG_AUX_ICCM);
+		info->iccm.base = base & 0xF0000000;
 	}
-}
 
-static char *arc_cpu_mumbojumbo(int cpu_id, char *buf, int len)
-{
-	struct cpuinfo_arc *cpu = &cpuinfo_arc700[cpu_id];
-	struct bcr_identity *core = &cpu->core;
-	char mpy_opt[16];
-	int n = 0;
+	READ_BCR(ARC_REG_DCCM_BUILD, dccm);
+	if (dccm.ver) {
+		unsigned long base;
+		info->dccm.sz = 256 << dccm.sz0;
+		if (dccm.sz0 == 0xF && dccm.sz1 > 0)
+			info->dccm.sz <<= dccm.sz1;
+		base = read_aux_reg(ARC_REG_AUX_DCCM);
+		info->dccm.base = base & 0xF0000000;
+	}
 
-	FIX_PTR(cpu);
+	/* Error Protection: ECC/Parity */
+	READ_BCR(ARC_REG_ERP_BUILD, erp);
+	if (erp.ver) {
+		struct ctl_erp ctl;
+		READ_BCR(ARC_REG_ERP_CTRL, ctl);
+		/* inverted bits: 0 means enabled */
+		n += scnprintf(buf + n, len - n, "Extn [ECC]\t: %s%s%s%s%s%s\n",
+				IS_AVAIL3(erp.ic,  !ctl.dpi, "IC "),
+				IS_AVAIL3(erp.dc,  !ctl.dpd, "DC "),
+				IS_AVAIL3(erp.mmu, !ctl.mpd, "MMU "));
+	}
 
-	n += scnprintf(buf + n, len - n,
-		       "\nIDENTITY\t: ARCVER [%#02x] ARCNUM [%#02x] CHIPID [%#4x]\n",
-		       core->family, core->cpu_id, core->chip_id);
+	/* ARCv2 ISA specific sanity checks */
+	present = fpu.sp | fpu.dp | mpy.dsp;	/* DSP and/or FPU */
+	CHK_OPT_STRICT(CONFIG_ARC_HAS_ACCL_REGS, present);
 
-	n += scnprintf(buf + n, len - n, "processor [%d]\t: %s %s (%s ISA) %s%s%s\n",
-		       cpu_id, cpu->name, cpu->release,
-		       is_isa_arcompact() ? "ARCompact" : "ARCv2",
-		       IS_AVAIL1(cpu->isa.be, "[Big-Endian]"),
-		       IS_AVAIL3(cpu->extn.dual, cpu->extn.dual_enb, " Dual-Issue "));
+	dsp_config_check();
+#endif
+	return n;
+}
 
-	n += scnprintf(buf + n, len - n, "Timers\t\t: %s%s%s%s%s%s\nISA Extn\t: ",
-		       IS_AVAIL1(cpu->extn.timer0, "Timer0 "),
-		       IS_AVAIL1(cpu->extn.timer1, "Timer1 "),
-		       IS_AVAIL2(cpu->extn.rtc, "RTC [UP 64-bit] ", CONFIG_ARC_TIMERS_64BIT),
-		       IS_AVAIL2(cpu->extn.gfrc, "GFRC [SMP 64-bit] ", CONFIG_ARC_TIMERS_64BIT));
+static char *arc_cpu_mumbojumbo(int c, struct cpuinfo_arc *info, char *buf, int len)
+{
+	struct bcr_identity ident;
+	struct bcr_timer timer;
+	struct bcr_generic bcr;
+	struct mcip_bcr mp;
+	struct bcr_actionpoint ap;
+	unsigned long vec_base;
+	int ap_num, ap_full, smart, rtt, n;
 
-	if (cpu->extn_mpy.ver) {
-		if (is_isa_arcompact()) {
-			scnprintf(mpy_opt, 16, "mpy");
-		} else {
+	memset(info, 0, sizeof(struct cpuinfo_arc));
 
-			int opt = 2;	/* stock MPY/MPYH */
+	READ_BCR(AUX_IDENTITY, ident);
+	info->arcver = ident.family;
 
-			if (cpu->extn_mpy.dsp)	/* OPT 7-9 */
-				opt = cpu->extn_mpy.dsp + 6;
+	n = scnprintf(buf, len,
+		       "\nIDENTITY\t: ARCVER [%#02x] ARCNUM [%#02x] CHIPID [%#4x]\n",
+		       ident.family, ident.cpu_id, ident.chip_id);
 
-			scnprintf(mpy_opt, 16, "mpy[opt %d] ", opt);
-		}
+	if (is_isa_arcompact()) {
+		n += arcompact_mumbojumbo(c, info, buf + n, len - n);
+	} else if (is_isa_arcv2()){
+		n += arcv2_mumbojumbo(c, info, buf + n, len - n);
 	}
 
-	n += scnprintf(buf + n, len - n, "%s%s%s%s%s%s%s%s\n",
-		       IS_AVAIL2(cpu->isa.atomic, "atomic ", CONFIG_ARC_HAS_LLSC),
-		       IS_AVAIL2(cpu->isa.ldd, "ll64 ", CONFIG_ARC_HAS_LL64),
-		       IS_AVAIL2(cpu->isa.unalign, "unalign ", CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS),
-		       IS_AVAIL1(cpu->extn_mpy.ver, mpy_opt),
-		       IS_AVAIL1(cpu->isa.div_rem, "div_rem "));
+	n += arc_mmu_mumbojumbo(c, buf + n, len - n);
+	n += arc_cache_mumbojumbo(c, buf + n, len - n);
 
-	if (cpu->bpu.ver) {
-		n += scnprintf(buf + n, len - n,
-			      "BPU\t\t: %s%s match, cache:%d, Predict Table:%d Return stk: %d",
-			      IS_AVAIL1(cpu->bpu.full, "full"),
-			      IS_AVAIL1(!cpu->bpu.full, "partial"),
-			      cpu->bpu.num_cache, cpu->bpu.num_pred, cpu->bpu.ret_stk);
-
-		if (is_isa_arcv2()) {
-			struct bcr_lpb lpb;
-
-			READ_BCR(ARC_REG_LPB_BUILD, lpb);
-			if (lpb.ver) {
-				unsigned int ctl;
-				ctl = read_aux_reg(ARC_REG_LPB_CTRL);
-
-				n += scnprintf(buf + n, len - n, " Loop Buffer:%d %s",
-					       lpb.entries,
-					       IS_DISABLED_RUN(!ctl));
-			}
-		}
-		n += scnprintf(buf + n, len - n, "\n");
-	}
+	READ_BCR(ARC_REG_TIMERS_BCR, timer);
+	info->t0 = timer.t0;
+	info->t1 = timer.t1;
 
-	return buf;
-}
+	READ_BCR(ARC_REG_MCIP_BCR, mp);
+	vec_base = read_aux_reg(AUX_INTR_VEC_BASE);
 
-static char *arc_extn_mumbojumbo(int cpu_id, char *buf, int len)
-{
-	int n = 0;
-	struct cpuinfo_arc *cpu = &cpuinfo_arc700[cpu_id];
+	n += scnprintf(buf + n, len - n,
+		       "Timers\t\t: %s%s%s%s%s%s\nVector Table\t: %#lx\n",
+		       IS_AVAIL1(timer.t0, "Timer0 "),
+		       IS_AVAIL1(timer.t1, "Timer1 "),
+		       IS_AVAIL2(timer.rtc, "RTC [UP 64-bit] ", CONFIG_ARC_TIMERS_64BIT),
+		       IS_AVAIL2(mp.gfrc, "GFRC [SMP 64-bit] ", CONFIG_ARC_TIMERS_64BIT),
+		       vec_base);
 
-	FIX_PTR(cpu);
+	READ_BCR(ARC_REG_AP_BCR, ap);
+	if (ap.ver) {
+		ap_num = 2 << ap.num;
+		ap_full = !ap.min;
+	}
 
-	n += scnprintf(buf + n, len - n, "Vector Table\t: %#x\n", cpu->vec_base);
+	READ_BCR(ARC_REG_SMART_BCR, bcr);
+	smart = bcr.ver ? 1 : 0;
 
-	if (cpu->extn.fpu_sp || cpu->extn.fpu_dp)
-		n += scnprintf(buf + n, len - n, "FPU\t\t: %s%s\n",
-			       IS_AVAIL1(cpu->extn.fpu_sp, "SP "),
-			       IS_AVAIL1(cpu->extn.fpu_dp, "DP "));
+	READ_BCR(ARC_REG_RTT_BCR, bcr);
+	rtt = bcr.ver ? 1 : 0;
 
-	if (cpu->extn.ap_num | cpu->extn.smart | cpu->extn.rtt) {
+	if (ap.ver | smart | rtt) {
 		n += scnprintf(buf + n, len - n, "DEBUG\t\t: %s%s",
-			       IS_AVAIL1(cpu->extn.smart, "smaRT "),
-			       IS_AVAIL1(cpu->extn.rtt, "RTT "));
-		if (cpu->extn.ap_num) {
+			       IS_AVAIL1(smart, "smaRT "),
+			       IS_AVAIL1(rtt, "RTT "));
+		if (ap.ver) {
 			n += scnprintf(buf + n, len - n, "ActionPoint %d/%s",
-				       cpu->extn.ap_num,
-				       cpu->extn.ap_full ? "full":"min");
+				       ap_num,
+				       ap_full ? "full":"min");
 		}
 		n += scnprintf(buf + n, len - n, "\n");
 	}
 
-	if (cpu->dccm.sz || cpu->iccm.sz)
-		n += scnprintf(buf + n, len - n, "Extn [CCM]\t: DCCM @ %x, %d KB / ICCM: @ %x, %d KB\n",
-			       cpu->dccm.base_addr, TO_KB(cpu->dccm.sz),
-			       cpu->iccm.base_addr, TO_KB(cpu->iccm.sz));
-
-	if (is_isa_arcv2()) {
-
-		/* Error Protection: ECC/Parity */
-		struct bcr_erp erp;
-		READ_BCR(ARC_REG_ERP_BUILD, erp);
-
-		if (erp.ver) {
-			struct  ctl_erp ctl;
-			READ_BCR(ARC_REG_ERP_CTRL, ctl);
-
-			/* inverted bits: 0 means enabled */
-			n += scnprintf(buf + n, len - n, "Extn [ECC]\t: %s%s%s%s%s%s\n",
-				IS_AVAIL3(erp.ic,  !ctl.dpi, "IC "),
-				IS_AVAIL3(erp.dc,  !ctl.dpd, "DC "),
-				IS_AVAIL3(erp.mmu, !ctl.mpd, "MMU "));
-		}
-	}
+	if (info->dccm.sz || info->iccm.sz)
+		n += scnprintf(buf + n, len - n,
+			       "Extn [CCM]\t: DCCM @ %lx, %d KB / ICCM: @ %lx, %d KB\n",
+			       info->dccm.base, TO_KB(info->dccm.sz),
+			       info->iccm.base, TO_KB(info->iccm.sz));
 
 	return buf;
 }
@@ -398,15 +376,15 @@ void chk_opt_weak(char *opt_name, bool hw_exists, bool opt_ena)
 		panic("Disable %s, hardware NOT present\n", opt_name);
 }
 
-static void arc_chk_core_config(void)
+/*
+ * ISA agnostic sanity checks
+ */
+static void arc_chk_core_config(struct cpuinfo_arc *info)
 {
-	struct cpuinfo_arc *cpu = &cpuinfo_arc700[smp_processor_id()];
-	int present = 0;
-
-	if (!cpu->extn.timer0)
+	if (!info->t0)
 		panic("Timer0 is not present!\n");
 
-	if (!cpu->extn.timer1)
+	if (!info->t1)
 		panic("Timer1 is not present!\n");
 
 #ifdef CONFIG_ARC_HAS_DCCM
@@ -414,35 +392,17 @@ static void arc_chk_core_config(void)
 	 * DCCM can be arbit placed in hardware.
 	 * Make sure it's placement/sz matches what Linux is built with
 	 */
-	if ((unsigned int)__arc_dccm_base != cpu->dccm.base_addr)
+	if ((unsigned int)__arc_dccm_base != info->dccm.base)
 		panic("Linux built with incorrect DCCM Base address\n");
 
-	if (CONFIG_ARC_DCCM_SZ * SZ_1K != cpu->dccm.sz)
+	if (CONFIG_ARC_DCCM_SZ * SZ_1K != info->dccm.sz)
 		panic("Linux built with incorrect DCCM Size\n");
 #endif
 
 #ifdef CONFIG_ARC_HAS_ICCM
-	if (CONFIG_ARC_ICCM_SZ * SZ_1K != cpu->iccm.sz)
+	if (CONFIG_ARC_ICCM_SZ * SZ_1K != info->iccm.sz)
 		panic("Linux built with incorrect ICCM Size\n");
 #endif
-
-	/*
-	 * FP hardware/software config sanity
-	 * -If hardware present, kernel needs to save/restore FPU state
-	 * -If not, it will crash trying to save/restore the non-existant regs
-	 */
-
-	if (is_isa_arcompact()) {
-		/* only DPDP checked since SP has no arch visible regs */
-		present = cpu->extn.fpu_dp;
-		CHK_OPT_STRICT(CONFIG_ARC_FPU_SAVE_RESTORE, present);
-	} else {
-		/* Accumulator Low:High pair (r58:59) present if DSP MPY or FPU */
-		present = cpu->extn_mpy.dsp | cpu->extn.fpu_sp | cpu->extn.fpu_dp;
-		CHK_OPT_STRICT(CONFIG_ARC_HAS_ACCL_REGS, present);
-
-		dsp_config_check();
-	}
 }
 
 /*
@@ -453,23 +413,19 @@ static void arc_chk_core_config(void)
 
 void setup_processor(void)
 {
+	struct cpuinfo_arc info;
+	int c = smp_processor_id();
 	char str[512];
-	int cpu_id = smp_processor_id();
 
-	read_arc_build_cfg_regs();
-	arc_init_IRQ();
+	pr_info("%s", arc_cpu_mumbojumbo(c, &info, str, sizeof(str)));
+	pr_info("%s", arc_platform_smp_cpuinfo());
 
-	pr_info("%s", arc_cpu_mumbojumbo(cpu_id, str, sizeof(str)));
-	pr_info("%s", arc_mmu_mumbojumbo(cpu_id, str, sizeof(str)));
-	pr_info("%s", arc_cache_mumbojumbo(cpu_id, str, sizeof(str)));
+	arc_chk_core_config(&info);
 
+	arc_init_IRQ();
 	arc_mmu_init();
 	arc_cache_init();
 
-	pr_info("%s", arc_extn_mumbojumbo(cpu_id, str, sizeof(str)));
-	pr_info("%s", arc_platform_smp_cpuinfo());
-
-	arc_chk_core_config();
 }
 
 static inline bool uboot_arg_invalid(unsigned long addr)
@@ -616,6 +572,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	char *str;
 	int cpu_id = ptr_to_cpu(v);
 	struct device *cpu_dev = get_cpu_device(cpu_id);
+	struct cpuinfo_arc info;
 	struct clk *cpu_clk;
 	unsigned long freq = 0;
 
@@ -628,7 +585,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	if (!str)
 		goto done;
 
-	seq_printf(m, arc_cpu_mumbojumbo(cpu_id, str, PAGE_SIZE));
+	seq_printf(m, arc_cpu_mumbojumbo(cpu_id, &info, str, PAGE_SIZE));
 
 	cpu_clk = clk_get(cpu_dev, NULL);
 	if (IS_ERR(cpu_clk)) {
@@ -645,9 +602,6 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		   loops_per_jiffy / (500000 / HZ),
 		   (loops_per_jiffy / (5000 / HZ)) % 100);
 
-	seq_printf(m, arc_mmu_mumbojumbo(cpu_id, str, PAGE_SIZE));
-	seq_printf(m, arc_cache_mumbojumbo(cpu_id, str, PAGE_SIZE));
-	seq_printf(m, arc_extn_mumbojumbo(cpu_id, str, PAGE_SIZE));
 	seq_printf(m, arc_platform_smp_cpuinfo());
 
 	free_page((unsigned long)str);
diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 7197bb845a40..4510f805b21d 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -39,7 +39,7 @@ void (*__dma_cache_wback_inv)(phys_addr_t start, unsigned long sz);
 void (*__dma_cache_inv)(phys_addr_t start, unsigned long sz);
 void (*__dma_cache_wback)(phys_addr_t start, unsigned long sz);
 
-static char *read_decode_cache_bcr_arcv2(int c, char *buf, int len)
+static int read_decode_cache_bcr_arcv2(int c, char *buf, int len)
 {
 	struct cpuinfo_arc_cache *p_slc = &slc_info;
 	struct bcr_identity ident;
@@ -94,10 +94,10 @@ static char *read_decode_cache_bcr_arcv2(int c, char *buf, int len)
 		       perip_base,
 		       IS_AVAIL3(ioc_exists, ioc_enable, ", IO-Coherency (per-device) "));
 
-	return buf;
+	return n;
 }
 
-char *arc_cache_mumbojumbo(int c, char *buf, int len)
+int arc_cache_mumbojumbo(int c, char *buf, int len)
 {
 	struct cpuinfo_arc_cache *p_ic = &ic_info, *p_dc = &dc_info;
 	struct bcr_cache ibcr, dbcr;
@@ -153,9 +153,9 @@ char *arc_cache_mumbojumbo(int c, char *buf, int len)
 
 slc_chk:
 	if (is_isa_arcv2())
-		read_decode_cache_bcr_arcv2(c, buf + n, len - n);
+		n += read_decode_cache_bcr_arcv2(c, buf + n, len - n);
 
-	return buf;
+	return n;
 }
 
 /*
diff --git a/arch/arc/mm/tlb.c b/arch/arc/mm/tlb.c
index 861cabe81e87..d70eaff71759 100644
--- a/arch/arc/mm/tlb.c
+++ b/arch/arc/mm/tlb.c
@@ -562,7 +562,7 @@ void local_flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
  * the cpuinfo structure for later use.
  * No Validation is done here, simply read/convert the BCRs
  */
-char *arc_mmu_mumbojumbo(int c, char *buf, int len)
+int arc_mmu_mumbojumbo(int c, char *buf, int len)
 {
 	struct cpuinfo_arc_mmu *mmu = &mmuinfo;
 	unsigned int bcr, u_dtlb, u_itlb, sasid;
@@ -607,7 +607,7 @@ char *arc_mmu_mumbojumbo(int c, char *buf, int len)
 		       IS_AVAIL1(sasid, ", SASID"),
 		       IS_AVAIL2(mmu->pae, ", PAE40 ", CONFIG_ARC_HAS_PAE40));
 
-	return buf;
+	return n;
 }
 
 int pae40_exist_but_not_enab(void)
-- 
2.34.1

