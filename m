Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E953280A871
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574347AbjLHQNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjLHQM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:12:59 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD81C1997;
        Fri,  8 Dec 2023 08:13:01 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF3E4E0007;
        Fri,  8 Dec 2023 16:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702051980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=csnOaxSt7JZQCahT2bN5IGKlGaknLCMr5TUNqVz3qJ8=;
        b=lfd/6isT0VX4Egalf6Do3M7LwdsJAm7pZed++q2SqPXqXIm5iRn9Ab915SwnV5LwYI3jNR
        +qyOYjElMM8o5r71l9qrpOTGJE/sh0RIbCYKatsZOqFskdMpM6BKO6effwlc4MA/MANDKW
        6YwStIHXFwifHg1GBuvjmYC9SxR9mFE3SwzbWkRxJqr0aAeRNj7IVIidl0/D8mOwAuwG02
        lSLx5obyqorc+kgklKY1IvN8hPWvD/eOM4LIYfbn7Y9Rm3KzEzeP2zZvElKxlhYUxzoZps
        3H1kz39R41mJRRRMh1DuOa490v9yJyPjDfkPMHwoskbVXOv0B2/IBUvYkKNGtA==
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v4 07/22] MIPS: Fix cache issue with mips_cps_core_entry
Date:   Fri,  8 Dec 2023 17:12:23 +0100
Message-ID: <20231208161249.1827174-8-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208161249.1827174-1-gregory.clement@bootlin.com>
References: <20231208161249.1827174-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split setup_cps_vecs and move back the cache management latter in
cps_smp_setup when the cache subsystem had been initialized. Without
this the blast_inv_dcache_range() call can lead to a crash.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/kernel/smp-cps.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 9aad678a32bd7..6cbdff917d147 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -53,6 +53,7 @@ UASM_L_LA(_not_nmi)
 
 static DECLARE_BITMAP(core_power, NR_CPUS);
 static uint32_t core_entry_reg;
+static phys_addr_t cps_vec_pa;
 
 struct core_boot_config *mips_cps_core_bootcfg;
 
@@ -112,17 +113,8 @@ static void __init *mips_cps_build_core_entry(void *addr)
 	return p;
 }
 
-static int __init setup_cps_vecs(void)
+static int __init allocate_cps_vecs(void)
 {
-	extern void excep_tlbfill(void);
-	extern void excep_xtlbfill(void);
-	extern void excep_cache(void);
-	extern void excep_genex(void);
-	extern void excep_intex(void);
-	extern void excep_ejtag(void);
-	phys_addr_t cps_vec_pa;
-	void *cps_vec;
-
 	/* Try to allocate in KSEG1 first */
 	cps_vec_pa = memblock_phys_alloc_range(BEV_VEC_SIZE, BEV_VEC_ALIGN,
 						0x0, KSEGX_SIZE - 1);
@@ -142,6 +134,19 @@ static int __init setup_cps_vecs(void)
 	if (!cps_vec_pa)
 		return -ENOMEM;
 
+	return 0;
+}
+
+static void __init setup_cps_vecs(void)
+{
+	extern void excep_tlbfill(void);
+	extern void excep_xtlbfill(void);
+	extern void excep_cache(void);
+	extern void excep_genex(void);
+	extern void excep_intex(void);
+	extern void excep_ejtag(void);
+	void *cps_vec;
+
 	/* We want to ensure cache is clean before writing uncached mem */
 	blast_dcache_range(TO_CAC(cps_vec_pa), TO_CAC(cps_vec_pa) + BEV_VEC_SIZE);
 	bc_wback_inv(TO_CAC(cps_vec_pa), BEV_VEC_SIZE);
@@ -161,8 +166,6 @@ static int __init setup_cps_vecs(void)
 	blast_inv_dcache_range(TO_CAC(cps_vec_pa), TO_CAC(cps_vec_pa) + BEV_VEC_SIZE);
 	bc_inv(TO_CAC(cps_vec_pa), BEV_VEC_SIZE);
 	__sync();
-
-	return 0;
 }
 
 static void __init cps_smp_setup(void)
@@ -224,8 +227,8 @@ static void __init cps_smp_setup(void)
 	/* Make core 0 coherent with everything */
 	write_gcr_cl_coherence(0xff);
 
-	if (setup_cps_vecs())
-		pr_err("Failed to setup CPS vectors\n");
+	if (allocate_cps_vecs())
+		pr_err("Failed to allocate CPS vectors\n");
 
 	if (core_entry_reg && mips_cm_revision() >= CM_REV_CM3)
 		write_gcr_bev_base(core_entry_reg);
@@ -280,6 +283,7 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 			(cca_unsuitable && cpu_has_dc_aliases) ? " & " : "",
 			cpu_has_dc_aliases ? "dcache aliasing" : "");
 
+	setup_cps_vecs();
 
 	/* Allocate core boot configuration structs */
 	ncores = mips_cps_numcores(0);
-- 
2.42.0

