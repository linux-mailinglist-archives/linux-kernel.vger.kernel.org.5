Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34588009B8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378694AbjLALQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378524AbjLALP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:15:29 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A3B10FD;
        Fri,  1 Dec 2023 03:15:33 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C761E24000F;
        Fri,  1 Dec 2023 11:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701429332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MsIlzSYwiKN+Kvh/DZTLi6i7jYagx2cwG1gcHhp8JFU=;
        b=S2ynWvCQ5mRw+QaAb52awO8om9Swl0S4Fpzrrxv3I6Jti++vjFlREmyY3/YxhydoN5QPTQ
        TJJtGzrHa+SnRVs0uVgPoF/eKaWwZ2zIGtrJnm4QTI6njahOeGYIzy+bSBGTqv+uHGQ3w7
        Z4oJjwUzj57gqcYKV8iNLovjreaku8rQD7ONFKGqnJIOb9yxkEyqFEfn1dTfqWlYk9KbbN
        z4QJCHhBEvFOJv59yXq9OXPCU4WW2HxncV/NtuQe0qZHAAwAABb39EspmRjp85tFkIuBtJ
        V3b3/c8ExIMXxyAwZw7dh9vTWL7rf2xqLo1ykq16RtWr3YAdg4jsTh7FKsC9HQ==
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
Subject: [PATCH v3 12/22] MIPS: Get rid of CONFIG_NO_EXCEPT_FILL
Date:   Fri,  1 Dec 2023 12:14:55 +0100
Message-ID: <20231201111512.803120-13-gregory.clement@bootlin.com>
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

NO_EXCEPT_FILL is used to indicate platform that does not
need to reserve ebase memory at start of kernel.

This is true for all R2+ platform as they allocate ebase
memory on fly, and also true for any platform that does
not load kernel at start of physical memory.

Get rid this Kconfig symbol by use macro to detect conditions
above.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig       | 8 --------
 arch/mips/kernel/head.S | 7 +++++--
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 11bacbd3971f6..88965b8f8fcc4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -150,7 +150,6 @@ config MIPS_GENERIC_KERNEL
 	select MIPS_CPU_SCACHE
 	select MIPS_GIC
 	select MIPS_L1_CACHE_SHIFT_7
-	select NO_EXCEPT_FILL
 	select PCI_DRIVERS_GENERIC
 	select SMP_UP if SMP
 	select SWAP_IO_SPACE
@@ -244,7 +243,6 @@ config BMIPS_GENERIC
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
 	select BOOT_RAW
-	select NO_EXCEPT_FILL
 	select USE_OF
 	select CEVT_R4K
 	select CSRC_R4K
@@ -288,7 +286,6 @@ config BCM47XX
 	select HAVE_PCI
 	select IRQ_MIPS_CPU
 	select SYS_HAS_CPU_MIPS32_R1
-	select NO_EXCEPT_FILL
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_MIPS16
@@ -424,7 +421,6 @@ config LANTIQ
 	select IRQ_MIPS_CPU
 	select CEVT_R4K
 	select CSRC_R4K
-	select NO_EXCEPT_FILL
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_SUPPORTS_BIG_ENDIAN
@@ -473,7 +469,6 @@ config MACH_LOONGSON64
 	select ISA
 	select I8259
 	select IRQ_MIPS_CPU
-	select NO_EXCEPT_FILL
 	select NR_CPUS_DEFAULT_64
 	select USE_GENERIC_EARLY_PRINTK_8250
 	select PCI_DRIVERS_GENERIC
@@ -1156,9 +1151,6 @@ config PCI_GT64XXX_PCI0
 config PCI_XTALK_BRIDGE
 	bool
 
-config NO_EXCEPT_FILL
-	bool
-
 config MIPS_SPRAM
 	bool
 
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index b825ed4476c70..4af53b1628f57 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -59,10 +59,13 @@
 #endif
 	.endm
 
-#ifndef CONFIG_NO_EXCEPT_FILL
+#if (MIPS_ISA_REV < 2) &&			\
+	((VMLINUX_LOAD_ADDRESS == KSEG0) ||	\
+	(VMLINUX_LOAD_ADDRESS == CKSEG0))
 	/*
 	 * Reserved space for exception handlers.
-	 * Necessary for machines which link their kernels at KSEG0.
+	 * Necessary for machines which link their kernels at KSEG0
+	 * and incapable of moving ebase.
 	 */
 	.fill	0x400
 #endif
-- 
2.42.0

