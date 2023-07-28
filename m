Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD25767691
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbjG1TuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjG1TuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E51E3C1D;
        Fri, 28 Jul 2023 12:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B61BF621B1;
        Fri, 28 Jul 2023 19:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0C8C433C8;
        Fri, 28 Jul 2023 19:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690573821;
        bh=8A1fFoi2i3ClsvIaTPCzChy1Ou5AvBRLB5R1quDdZ5Y=;
        h=From:To:Cc:Subject:Date:From;
        b=NPeFfzhmU9NNpWg7TVewexSPClWcgfQuxg1LISNtMMfJKfTi2LxD8KLfXZGVGye8J
         wKWIboAtbqNbEejlJIPncR1GwomPHaxXdk4uomC62vzIXp+UmYRv7Cb/0H7PmyUnjM
         gwEwi0sDPppgOv3lxEk+VOmLJNMESFv+42pSDUyMkRaDsIrta0yLYRpXgT2rzU2UqS
         qHQJEbb8a1lbDxkN30J4vY2ooKc2E0ZJnNRV8uGdDAlHY5j4CPtkfYElWPmtVRmO1i
         DXZ0tdEvQgStZ0Uy32Dz1pabSJqgxa/tM0dLdZJ4L3+kSSnb5ZhZ8eFzhNLqNpNZn0
         meTEFg8jwtSzw==
Received: (nullmailer pid 1198518 invoked by uid 1000);
        Fri, 28 Jul 2023 19:50:19 -0000
From:   Rob Herring <robh@kernel.org>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH] hwrng: Enable COMPILE_TEST for more drivers
Date:   Fri, 28 Jul 2023 13:50:15 -0600
Message-Id: <20230728195015.1198427-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's quite a few hwrng drivers which are easily enabled for
COMPILE_TEST, so let's enable them.

The dependency on HW_RANDOM is redundant, so drop that while we're here.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Passed allyesconfig builds on arm, arm64, x86, riscv, powerpc, sparc
---
 drivers/char/hw_random/Kconfig       | 35 ++++++++++++++--------------
 drivers/char/hw_random/amd-rng.c     |  1 +
 drivers/char/hw_random/ingenic-rng.c |  2 +-
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index e0b3786ca51b..b82733759e60 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -37,7 +37,7 @@ config HW_RANDOM_TIMERIOMEM
 
 config HW_RANDOM_INTEL
 	tristate "Intel HW Random Number Generator support"
-	depends on (X86 || IA64) && PCI
+	depends on (X86 || IA64 || COMPILE_TEST) && PCI
 	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number
@@ -50,7 +50,8 @@ config HW_RANDOM_INTEL
 
 config HW_RANDOM_AMD
 	tristate "AMD HW Random Number Generator support"
-	depends on (X86 || PPC_MAPLE) && PCI
+	depends on (X86 || PPC_MAPLE || COMPILE_TEST)
+	depends on PCI && HAS_IOPORT_MAP
 	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number
@@ -63,7 +64,7 @@ config HW_RANDOM_AMD
 
 config HW_RANDOM_ATMEL
 	tristate "Atmel Random Number Generator support"
-	depends on (ARCH_AT91 || COMPILE_TEST) && HAVE_CLK && OF
+	depends on (ARCH_AT91 || COMPILE_TEST)
 	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number
@@ -113,7 +114,8 @@ config HW_RANDOM_IPROC_RNG200
 
 config HW_RANDOM_GEODE
 	tristate "AMD Geode HW Random Number Generator support"
-	depends on X86_32 && PCI
+	depends on (X86_32 || COMPILE_TEST)
+	depends on PCI
 	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number
@@ -205,7 +207,7 @@ config HW_RANDOM_OCTEON
 
 config HW_RANDOM_PASEMI
 	tristate "PA Semi HW Random Number Generator support"
-	depends on PPC_PASEMI
+	depends on PPC_PASEMI || (PPC && COMPILE_TEST)
 	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number
@@ -228,7 +230,7 @@ config HW_RANDOM_VIRTIO
 
 config HW_RANDOM_MXC_RNGA
 	tristate "Freescale i.MX RNGA Random Number Generator"
-	depends on SOC_IMX31
+	depends on SOC_IMX31 || COMPILE_TEST
 	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number
@@ -241,7 +243,7 @@ config HW_RANDOM_MXC_RNGA
 
 config HW_RANDOM_IMX_RNGC
 	tristate "Freescale i.MX RNGC Random Number Generator"
-	depends on HAS_IOMEM && HAVE_CLK
+	depends on HAS_IOMEM
 	depends on SOC_IMX25 || SOC_IMX6SL || SOC_IMX6SLL || SOC_IMX6UL || COMPILE_TEST
 	default HW_RANDOM
 	help
@@ -256,8 +258,7 @@ config HW_RANDOM_IMX_RNGC
 
 config HW_RANDOM_INGENIC_RNG
 	tristate "Ingenic Random Number Generator support"
-	depends on HW_RANDOM
-	depends on MACH_JZ4780 || MACH_X1000
+	depends on MACH_JZ4780 || MACH_X1000 || COMPILE_TEST
 	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number Generator
@@ -271,8 +272,7 @@ config HW_RANDOM_INGENIC_RNG
 
 config HW_RANDOM_INGENIC_TRNG
 	tristate "Ingenic True Random Number Generator support"
-	depends on HW_RANDOM
-	depends on MACH_X1830
+	depends on MACH_X1830 || COMPILE_TEST
 	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the True Random Number Generator
@@ -324,7 +324,7 @@ config HW_RANDOM_POWERNV
 
 config HW_RANDOM_HISI
 	tristate "Hisilicon Random Number Generator support"
-	depends on HW_RANDOM && ARCH_HISI
+	depends on ARCH_HISI || COMPILE_TEST
 	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number
@@ -348,7 +348,7 @@ config HW_RANDOM_HISTB
 
 config HW_RANDOM_ST
 	tristate "ST Microelectronics HW Random Number Generator support"
-	depends on HW_RANDOM && (ARCH_STI || COMPILE_TEST)
+	depends on ARCH_STI || COMPILE_TEST
 	help
 	  This driver provides kernel-side support for the Random Number
 	  Generator hardware found on STi series of SoCs.
@@ -358,7 +358,7 @@ config HW_RANDOM_ST
 
 config HW_RANDOM_XGENE
 	tristate "APM X-Gene True Random Number Generator (TRNG) support"
-	depends on HW_RANDOM && ARCH_XGENE
+	depends on ARCH_XGENE || COMPILE_TEST
 	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number
@@ -371,7 +371,7 @@ config HW_RANDOM_XGENE
 
 config HW_RANDOM_STM32
 	tristate "STMicroelectronics STM32 random number generator"
-	depends on HW_RANDOM && (ARCH_STM32 || COMPILE_TEST)
+	depends on ARCH_STM32 || COMPILE_TEST
 	depends on HAS_IOMEM
 	default HW_RANDOM
 	help
@@ -385,7 +385,7 @@ config HW_RANDOM_STM32
 
 config HW_RANDOM_PIC32
 	tristate "Microchip PIC32 Random Number Generator support"
-	depends on HW_RANDOM && MACH_PIC32
+	depends on MACH_PIC32 || COMPILE_TEST
 	default y
 	help
 	  This driver provides kernel-side support for the Random Number
@@ -425,7 +425,8 @@ config HW_RANDOM_MESON
 
 config HW_RANDOM_CAVIUM
 	tristate "Cavium ThunderX Random Number Generator support"
-	depends on HW_RANDOM && PCI && ARCH_THUNDER
+	depends on PCI
+	depends on ARCH_THUNDER || (ARM64 && COMPILE_TEST)
 	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number
diff --git a/drivers/char/hw_random/amd-rng.c b/drivers/char/hw_random/amd-rng.c
index 0555e3838bce..86162a13681e 100644
--- a/drivers/char/hw_random/amd-rng.c
+++ b/drivers/char/hw_random/amd-rng.c
@@ -26,6 +26,7 @@
 
 #include <linux/delay.h>
 #include <linux/hw_random.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff --git a/drivers/char/hw_random/ingenic-rng.c b/drivers/char/hw_random/ingenic-rng.c
index 055cfe59f519..4f18c3fa5427 100644
--- a/drivers/char/hw_random/ingenic-rng.c
+++ b/drivers/char/hw_random/ingenic-rng.c
@@ -95,7 +95,7 @@ static int ingenic_rng_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 	}
 
-	priv->version = (enum ingenic_rng_version)of_device_get_match_data(&pdev->dev);
+	priv->version = (enum ingenic_rng_version)(uintptr_t)of_device_get_match_data(&pdev->dev);
 
 	priv->rng.name = pdev->name;
 	priv->rng.init = ingenic_rng_init;
-- 
2.40.1

