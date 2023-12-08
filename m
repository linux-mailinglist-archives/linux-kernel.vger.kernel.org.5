Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B1780A887
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574213AbjLHQNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574139AbjLHQNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:13:04 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D2B19B3;
        Fri,  8 Dec 2023 08:13:04 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 429FA4000A;
        Fri,  8 Dec 2023 16:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702051982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ss+D9T5Uh+7fUYrH2xTy2RKRoXOlo2BBLgHNahkRQoc=;
        b=M3D+hiW/lX4+qnJ4aFIJLgwUJ/MXrOlPGFApd7eut7kxrhgSHrEACqqie+Ujnwm+cwmo0n
        MUuL76ydDD9qA1njh4Ew4OVPjU8hNxgJlVddYtl8Sfqq4W9IO4s0vuTCcQCKLM05IgHQ/s
        y92uWh3Vh9ENa4SyoRZz9hXHPgNBxMWIzpvYPgoUorxv7tWZaew9vm3y/kpo3sTyjwmfOk
        cdgKjLPP86qnwcIq2cP+AL0sTQpg3/KMmwNtnNF18TKaSUiDqs1nmEErmUjNMMnj3BDcMq
        WijDvCFsWY0QP0+cxiU/zVteTFDZsNyu7tVpYT9OANZddPME7DNBh8C32CMnyw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 10/22] MIPS: Avoid unnecessary reservation of exception space
Date:   Fri,  8 Dec 2023 17:12:26 +0100
Message-ID: <20231208161249.1827174-11-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208161249.1827174-1-gregory.clement@bootlin.com>
References: <20231208161249.1827174-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Nowadays we allocate exception base from memblock for r2_r6,
so we don't need to reverse exception space at the start of
the memory for r2_r6 processors.

For older processors the reservation is moved to traps_init
where we have knowledge of exact size we need. We also add
a sanity check to detect possible overlap with kernel.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/traps.h    |  1 -
 arch/mips/kernel/cpu-probe.c     |  5 -----
 arch/mips/kernel/cpu-r3k-probe.c |  2 --
 arch/mips/kernel/traps.c         | 12 +++++++-----
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/traps.h b/arch/mips/include/asm/traps.h
index 15cde638b4070..d3dddd1c083a9 100644
--- a/arch/mips/include/asm/traps.h
+++ b/arch/mips/include/asm/traps.h
@@ -24,7 +24,6 @@ extern void (*board_ebase_setup)(void);
 extern void (*board_cache_error_setup)(void);
 
 extern int register_nmi_notifier(struct notifier_block *nb);
-extern void reserve_exception_space(phys_addr_t addr, unsigned long size);
 extern char except_vec_nmi[];
 
 #define VECTORSPACING 0x100	/* for EI/VI mode */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index b406d8bfb15a3..54e8b0fd4a2ab 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1570,7 +1570,6 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_BMIPS3300;
 		__cpu_name[cpu] = "Broadcom BMIPS3300";
 		set_elf_platform(cpu, "bmips3300");
-		reserve_exception_space(0x400, VECTORSPACING * 64);
 		break;
 	case PRID_IMP_BMIPS43XX: {
 		int rev = c->processor_id & PRID_REV_MASK;
@@ -1581,7 +1580,6 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 			__cpu_name[cpu] = "Broadcom BMIPS4380";
 			set_elf_platform(cpu, "bmips4380");
 			c->options |= MIPS_CPU_RIXI;
-			reserve_exception_space(0x400, VECTORSPACING * 64);
 		} else {
 			c->cputype = CPU_BMIPS4350;
 			__cpu_name[cpu] = "Broadcom BMIPS4350";
@@ -1598,7 +1596,6 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 			__cpu_name[cpu] = "Broadcom BMIPS5000";
 		set_elf_platform(cpu, "bmips5000");
 		c->options |= MIPS_CPU_ULRI | MIPS_CPU_RIXI;
-		reserve_exception_space(0x1000, VECTORSPACING * 64);
 		break;
 	}
 }
@@ -1996,8 +1993,6 @@ void cpu_probe(void)
 	if (cpu == 0)
 		__ua_limit = ~((1ull << cpu_vmbits) - 1);
 #endif
-
-	reserve_exception_space(0, 0x1000);
 }
 
 void cpu_report(void)
diff --git a/arch/mips/kernel/cpu-r3k-probe.c b/arch/mips/kernel/cpu-r3k-probe.c
index be93469c0e0ec..05410b743e571 100644
--- a/arch/mips/kernel/cpu-r3k-probe.c
+++ b/arch/mips/kernel/cpu-r3k-probe.c
@@ -137,8 +137,6 @@ void cpu_probe(void)
 		cpu_set_fpu_opts(c);
 	else
 		cpu_set_nofpu_opts(c);
-
-	reserve_exception_space(0, 0x400);
 }
 
 void cpu_report(void)
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 651c9ec6265a9..b6e94654f6211 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2007,10 +2007,6 @@ unsigned long exception_handlers[32];
 static unsigned long vi_vecbase;
 unsigned long vi_handlers[64];
 
-void reserve_exception_space(phys_addr_t addr, unsigned long size)
-{
-	memblock_reserve(addr, size);
-}
 
 void __init *set_except_vector(int n, void *addr)
 {
@@ -2394,7 +2390,13 @@ void __init trap_init(void)
 	}
 
 	if (!cpu_has_mips_r2_r6) {
-		ebase = CAC_BASE;
+		ebase_pa = 0x0;
+		ebase = CKSEG0ADDR(ebase_pa);
+
+		if (__pa_symbol(_stext) < (ebase_pa + vec_size))
+			pr_err("Insufficient space for exception vectors\n");
+
+		memblock_reserve(ebase_pa, vec_size);
 	} else {
 		vec_size = max(vec_size, PAGE_SIZE);
 		ebase_pa = memblock_phys_alloc(vec_size, 1 << fls(vec_size));
-- 
2.42.0

