Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DC780F324
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376624AbjLLQgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbjLLQfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:35:32 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1435610B;
        Tue, 12 Dec 2023 08:35:35 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 876196000A;
        Tue, 12 Dec 2023 16:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702398934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xbVhFI1ZSGx1syULTaPHmMoUG7Z8rPeb2O8T42Bf6J0=;
        b=Bl13/LklFdMlZCq+xi34hEBNI5XOCfoKecmZRoJXC0V5Zv+kC/4dg46+mSjU8SyCDtxHVz
        Z7RK4V2/JNx2nRT0EL69glSn0cYryHwTptJOcVKlVCyJzhLqqo4U4+JmVXuWVsGUtrQuVi
        9D7SJCJwZ1QYsYP8A93mIk3ZkHzyu9B1aE77yRtuVtOJA9zxh10NXzRBGfylvxOLOq9VNA
        BDNOmIlYgacBoH0iwJZiYQXz4GH4Ls/oko06JFt7cnSIACm7/KhBs89msQTT70im/Zb40V
        gj42J1SlWOdHfbKofcofYWordNIeTKdJLtBJlJ+bCaDUixbNyAugpGF9U0XBMA==
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
Subject: [PATCH v5 12/22] MIPS: Get rid of CONFIG_NO_EXCEPT_FILL
Date:   Tue, 12 Dec 2023 17:34:44 +0100
Message-ID: <20231212163459.1923041-13-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231212163459.1923041-1-gregory.clement@bootlin.com>
References: <20231212163459.1923041-1-gregory.clement@bootlin.com>
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

NO_EXCEPT_FILL is employed to signal the platform that there is no
requirement to reserve EBASE memory at the beginning of the kernel.

This holds true for all R2+ platforms, as they dynamically allocate
ebase memory. It is also applicable to any platform that doesn't load
the kernel at the start of physical memory.

Eliminate this Kconfig symbol by employing a macro to identify the
mentioned conditions.

gc: use KSEG0 only for 32 bit configuration
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig       | 8 --------
 arch/mips/kernel/head.S | 7 +++++--
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 518376d578b70..59bc956859292 100644
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
@@ -474,7 +470,6 @@ config MACH_LOONGSON64
 	select ISA
 	select I8259
 	select IRQ_MIPS_CPU
-	select NO_EXCEPT_FILL
 	select NR_CPUS_DEFAULT_64
 	select USE_GENERIC_EARLY_PRINTK_8250
 	select PCI_DRIVERS_GENERIC
@@ -1157,9 +1152,6 @@ config PCI_GT64XXX_PCI0
 config PCI_XTALK_BRIDGE
 	bool
 
-config NO_EXCEPT_FILL
-	bool
-
 config MIPS_SPRAM
 	bool
 
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index b825ed4476c70..51a0ad49ac388 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -59,10 +59,13 @@
 #endif
 	.endm
 
-#ifndef CONFIG_NO_EXCEPT_FILL
+#if (MIPS_ISA_REV < 2) &&					     \
+    ((!defined( CONFIG_64BIT) && (VMLINUX_LOAD_ADDRESS == KSEG0)) || \
+    (VMLINUX_LOAD_ADDRESS == CKSEG0))
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

