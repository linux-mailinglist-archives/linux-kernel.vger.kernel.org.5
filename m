Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4279180A890
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574547AbjLHQOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574435AbjLHQNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:13:20 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9087F19A6;
        Fri,  8 Dec 2023 08:13:11 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D33A11BF207;
        Fri,  8 Dec 2023 16:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702051990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SPEzQFZi3EY+1srAURAaeFdl3rOp0xXgNIgrytCx+9g=;
        b=WJAOVmHzy9BHQXKJJKJP7OGCtpLckqhsjUp/JiiLNb1WbUHNjykXPErwS569LM1/DxD2YS
        hdgKtxsZ+96Muq9gft5MvCIVuwAYQV0DGXw6rIozP8psfqeIFg2BtcT/vMjhiBEWxqfvNW
        PQZ8p4On2lsOROI51zKw4apFwCTkcCQzdkrRMR89J8VOjtkLH6TSntkG9XVtDCZdkdLpDb
        WDzmMmcAnONGcQA300jFLBuws+/ENQvzm5+nisY2VaKd7K71ozWr4i+2aWHOu7l30YfISH
        mNxbFKpa23tRKojeLg4XYowgV8fXjqJBOueAv7NdCCxQwV/vG9iDsrTsq34Fpw==
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
Subject: [PATCH v4 21/22] MIPS: generic: Add support for Mobileye EyeQ5
Date:   Fri,  8 Dec 2023 17:12:37 +0100
Message-ID: <20231208161249.1827174-22-gregory.clement@bootlin.com>
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

Introduce support for the MIPS based Mobileye EyeQ5 SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/configs/generic/board-eyeq5.config | 41 ++++++++++++++++++++
 arch/mips/generic/Kconfig                    | 15 +++++++
 arch/mips/generic/Platform                   |  2 +
 arch/mips/generic/board-epm5.its.S           | 24 ++++++++++++
 4 files changed, 82 insertions(+)
 create mode 100644 arch/mips/configs/generic/board-eyeq5.config
 create mode 100644 arch/mips/generic/board-epm5.its.S

diff --git a/arch/mips/configs/generic/board-eyeq5.config b/arch/mips/configs/generic/board-eyeq5.config
new file mode 100644
index 0000000000000..7a44bd9a46f17
--- /dev/null
+++ b/arch/mips/configs/generic/board-eyeq5.config
@@ -0,0 +1,41 @@
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_TASKSTATS=y
+CONFIG_FIT_IMAGE_FDT_EPM5=y
+CONFIG_BOARD_EYEQ5=y
+CONFIG_PHYSICAL_START=0xA800000080480000
+CONFIG_CPU_HAS_MSA=y
+CONFIG_NET_KEY=y
+CONFIG_CAN=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCI_DEBUG=y
+CONFIG_PCI_ENDPOINT=y
+CONFIG_CONNECTOR=y
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_RAM=y
+CONFIG_MTD_ROM=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_BLOCK2MTD=y
+CONFIG_MTD_UBI=y
+CONFIG_MTD_UBI_BLOCK=y
+CONFIG_NETDEVICES=y
+CONFIG_MACVLAN=y
+CONFIG_IPVLAN=y
+CONFIG_MACB=y
+CONFIG_MARVELL_PHY=y
+CONFIG_MICREL_PHY=y
+CONFIG_CAN_M_CAN=y
+CONFIG_SERIAL_AMBA_PL011=y
+CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_PINCTRL=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_CADENCE=y
+CONFIG_RESET_CONTROLLER=y
+CONFIG_FANOTIFY=y
+CONFIG_ROMFS_FS=y
+CONFIG_ROMFS_BACKED_BY_BOTH=y
+CONFIG_PAGE_SIZE_16KB=y
\ No newline at end of file
diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
index 7dc5b3821cc6e..04e1fc6f789b5 100644
--- a/arch/mips/generic/Kconfig
+++ b/arch/mips/generic/Kconfig
@@ -48,6 +48,13 @@ config SOC_VCOREIII
 config MSCC_OCELOT
 	bool
 
+config SOC_EYEQ5
+	select ARM_AMBA
+	select WEAK_ORDERING
+	select WEAK_REORDERING_BEYOND_LLSC
+	select PHYSICAL_START_BOOL
+	bool
+
 comment "FIT/UHI Boards"
 
 config FIT_IMAGE_FDT_BOSTON
@@ -124,4 +131,12 @@ config VIRT_BOARD_RANCHU
 	  Android emulator. Android emulator is based on Qemu, and contains
 	  the support for the same set of virtual devices.
 
+config FIT_IMAGE_FDT_EPM5
+	bool "Include FDT for Mobileye EyeQ5 development platforms"
+	select SOC_EYEQ5
+	default n
+	help
+	  Enable this to include the FDT for the EyeQ5 development platforms
+	  from Mobileye in the FIT kernel image.
+	  This requires u-boot on the platform.
 endif
diff --git a/arch/mips/generic/Platform b/arch/mips/generic/Platform
index 0c03623f38970..45db9824a11d6 100644
--- a/arch/mips/generic/Platform
+++ b/arch/mips/generic/Platform
@@ -24,3 +24,5 @@ its-$(CONFIG_FIT_IMAGE_FDT_JAGUAR2)	+= board-jaguar2.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_SERVAL)	+= board-serval.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_XILFPGA)	+= board-xilfpga.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_MARDUK)	+= board-marduk.its.S
+its-$(CONFIG_FIT_IMAGE_FDT_EPM5)	+= board-epm5.its.S
+
diff --git a/arch/mips/generic/board-epm5.its.S b/arch/mips/generic/board-epm5.its.S
new file mode 100644
index 0000000000000..08e8c4f183d63
--- /dev/null
+++ b/arch/mips/generic/board-epm5.its.S
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/ {
+	images {
+		fdt-mobileye-epm5 {
+			description = "Mobileeye MP5 Device Tree";
+			data = /incbin/("boot/dts/mobileye/eyeq5-epm5.dtb");
+			type = "flat_dt";
+			arch = "mips";
+			compression = "none";
+			hash {
+				algo = "sha1";
+			};
+		};
+	};
+
+    configurations {
+		default = "conf-1";
+		conf-1 {
+			description = "Mobileye EPM5 Linux kernel";
+			kernel = "kernel";
+			fdt = "fdt-mobileye-epm5";
+		};
+	};
+};
-- 
2.42.0

