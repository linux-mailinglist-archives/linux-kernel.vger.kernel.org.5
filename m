Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7187B8009B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378615AbjLALQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378531AbjLALP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:15:26 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4581A4;
        Fri,  1 Dec 2023 03:15:31 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 94A1C40009;
        Fri,  1 Dec 2023 11:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701429330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=imSdkuhb1bmbiT2B28YIP5ZVYeyaD1qizr5YYVEXZZM=;
        b=iTgfcOgVmiQNTSVv6AoJ70lN5pQllZU5frq7r7c1qUs71NVXbFtMnIWLJrqBo5wCoEBuNe
        RBNZkqR7C2OAHmBTu8c4rvvYFi7RgQL/DwyKjUUkvWSKQLHqd5MOmpYzx3atcFBWMTXYW0
        c/oXxJEKDwCEeoe0+4MQ+Udb70nO7n+KuRZAm9mO2RBmghqpE5/8OIHO+Zo/faky/S+GoW
        RvxQQwYACPkqceZJIdQuDShUSfLzWP95lxsm/ElhYlerdgeMz/wl7U7y5uuvHHEYDapgWQ
        Rar35lsqQP9bs1ZuL/4BFfcLtMOumTWVUrPHxtXQdVEdz7e8az+dcD35TlU3VA==
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
Subject: [PATCH v3 09/22] MIPS: traps: Handle CPU with non standard vint offset
Date:   Fri,  1 Dec 2023 12:14:52 +0100
Message-ID: <20231201111512.803120-10-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201111512.803120-1-gregory.clement@bootlin.com>
References: <20231201111512.803120-1-gregory.clement@bootlin.com>
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Some BMIPS cpus has none standard start offset for vector interrupts.

Handle those CPUs in vector size calculation and handler setup process.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/kernel/traps.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index ea59d321f713e..651c9ec6265a9 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -74,7 +74,6 @@
 
 #include "access-helper.h"
 
-#define MAX(a, b) ((a) >= (b) ? (a) : (b))
 
 extern void check_wait(void);
 extern asmlinkage void rollback_handle_int(void);
@@ -2005,6 +2004,7 @@ void __noreturn nmi_exception_handler(struct pt_regs *regs)
 unsigned long ebase;
 EXPORT_SYMBOL_GPL(ebase);
 unsigned long exception_handlers[32];
+static unsigned long vi_vecbase;
 unsigned long vi_handlers[64];
 
 void reserve_exception_space(phys_addr_t addr, unsigned long size)
@@ -2074,7 +2074,7 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 		handler = (unsigned long) addr;
 	vi_handlers[n] = handler;
 
-	b = (unsigned char *)(ebase + 0x200 + n*VECTORSPACING);
+	b = (unsigned char *)(vi_vecbase + n*VECTORSPACING);
 
 	if (srs >= srssets)
 		panic("Shadow register set %d not supported", srs);
@@ -2370,20 +2370,33 @@ void __init trap_init(void)
 	extern char except_vec3_generic;
 	extern char except_vec4;
 	extern char except_vec3_r4000;
-	unsigned long i, vec_size;
+	unsigned long i, vec_size, vi_vec_offset;
 	phys_addr_t ebase_pa;
 
 	check_wait();
 
+	if (cpu_has_veic || cpu_has_vint) {
+		switch (current_cpu_type()) {
+		case CPU_BMIPS3300:
+		case CPU_BMIPS4380:
+			vi_vec_offset = 0x400;
+			break;
+		case CPU_BMIPS5000:
+			vi_vec_offset = 0x1000;
+			break;
+		default:
+			vi_vec_offset = 0x200;
+			break;
+		}
+		vec_size = vi_vec_offset + VECTORSPACING*64;
+	} else {
+		vec_size = 0x400;
+	}
+
 	if (!cpu_has_mips_r2_r6) {
 		ebase = CAC_BASE;
-		vec_size = 0x400;
 	} else {
-		if (cpu_has_veic || cpu_has_vint)
-			vec_size = 0x200 + VECTORSPACING*64;
-		else
-			vec_size = PAGE_SIZE;
-
+		vec_size = max(vec_size, PAGE_SIZE);
 		ebase_pa = memblock_phys_alloc(vec_size, 1 << fls(vec_size));
 		if (!ebase_pa)
 			panic("%s: Failed to allocate %lu bytes align=0x%x\n",
@@ -2450,6 +2463,7 @@ void __init trap_init(void)
 	 * Initialise interrupt handlers
 	 */
 	if (cpu_has_veic || cpu_has_vint) {
+		vi_vecbase = ebase + vi_vec_offset;
 		int nvec = cpu_has_veic ? 64 : 8;
 		for (i = 0; i < nvec; i++)
 			set_vi_handler(i, NULL);
-- 
2.42.0

