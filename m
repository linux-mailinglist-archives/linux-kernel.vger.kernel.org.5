Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E583B7540B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbjGNRny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbjGNRnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:43:51 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CAD3A82;
        Fri, 14 Jul 2023 10:43:33 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-77a62a84855so87472239f.1;
        Fri, 14 Jul 2023 10:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356612; x=1691948612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzIUVKP6yHGbMpahIf7nQNh1TPGv38mvWOTZR+G2MN8=;
        b=SEipfkyc6BDsi4qB3i6yF2Nj0/Y2qm3OIq1lTU+N1NVkDRlj5x+DWztOL4c6hB6ZvT
         QvnVYjTMHBZlDThUxiOzTSDM8+NQw4VWCEX/dqrQMw4bx1Qqr3C9wy7Hu43V11Am8Zb1
         Il2apaMm0tMOEwE2rtvJKwl9/SpzkLQMpHP6hJQzAl5BC5wEX6HpUTF/GaG8pMsfPIqV
         M6oIlyNUgIoUFlK449ctE8nBRUY6QaDBR7Y2jky2JWyEK/ofAcs2iLgbNu90m7ljMYsG
         NCoGW9bUl/QJIV6S7+pe7VeUl1y7tZEMsk7uETidvtSIBdlEddNGj5d4hx+Svc4l4aPF
         MGNg==
X-Gm-Message-State: ABy/qLa54FYvwsa/psF0WclZDkCgCRwDdzGWkaPIcV5IDlOhdpV3f6pi
        GGhwcGwtYd9KIqgB0jMBEA==
X-Google-Smtp-Source: APBJJlEfLT3DdjyxsgVHwrmE2JGti7lB8I8A36u5mlvLwUQmbm4VZhT/SSYUdK3IWNYLHU6sZazBXA==
X-Received: by 2002:a92:d6ca:0:b0:346:6afb:8351 with SMTP id z10-20020a92d6ca000000b003466afb8351mr4633040ilp.9.1689356612593;
        Fri, 14 Jul 2023 10:43:32 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b1-20020a029a01000000b0042b279bb086sm2747683jal.66.2023.07.14.10.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:43:31 -0700 (PDT)
Received: (nullmailer pid 4052838 invoked by uid 1000);
        Fri, 14 Jul 2023 17:43:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Airlie <airlied@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Deepak Saxena <dsaxena@plexity.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Corey Minyard <minyard@acm.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com,
        openipmi-developer@lists.sourceforge.net,
        linux-aspeed@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: [PATCH] char: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:43:13 -0600
Message-Id: <20230714174315.4052438-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/char/agp/uninorth-agp.c        | 1 +
 drivers/char/bsr.c                     | 3 +--
 drivers/char/hw_random/atmel-rng.c     | 2 +-
 drivers/char/hw_random/bcm2835-rng.c   | 3 +--
 drivers/char/hw_random/ingenic-trng.c  | 2 +-
 drivers/char/hw_random/iproc-rng200.c  | 3 +--
 drivers/char/hw_random/npcm-rng.c      | 3 +--
 drivers/char/hw_random/omap-rng.c      | 2 --
 drivers/char/hw_random/omap3-rom-rng.c | 1 -
 drivers/char/hw_random/pasemi-rng.c    | 3 +--
 drivers/char/hw_random/pic32-rng.c     | 3 +--
 drivers/char/hw_random/stm32-rng.c     | 3 ++-
 drivers/char/hw_random/xgene-rng.c     | 5 ++---
 drivers/char/hw_random/xiphera-trng.c  | 1 -
 drivers/char/ipmi/kcs_bmc_aspeed.c     | 1 -
 drivers/char/tpm/tpm_ftpm_tee.c        | 1 -
 drivers/char/tpm/tpm_tis.c             | 1 -
 drivers/char/tpm/tpm_tis_spi_main.c    | 2 +-
 drivers/char/tpm/tpm_tis_synquacer.c   | 1 -
 19 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index 62de7f4ba864..84411b13c49f 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -3,6 +3,7 @@
  * UniNorth AGPGART routines.
  */
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/init.h>
diff --git a/drivers/char/bsr.c b/drivers/char/bsr.c
index 12143854aeac..70d31aed9011 100644
--- a/drivers/char/bsr.c
+++ b/drivers/char/bsr.c
@@ -6,11 +6,10 @@
  * Author: Sonny Rao <sonnyrao@us.ibm.com>
  */
 
+#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/cdev.h>
diff --git a/drivers/char/hw_random/atmel-rng.c b/drivers/char/hw_random/atmel-rng.c
index b8effe77d80f..a37367ebcbac 100644
--- a/drivers/char/hw_random/atmel-rng.c
+++ b/drivers/char/hw_random/atmel-rng.c
@@ -15,7 +15,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/hw_random.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
index e98fcac578d6..e19b0f9f48b9 100644
--- a/drivers/char/hw_random/bcm2835-rng.c
+++ b/drivers/char/hw_random/bcm2835-rng.c
@@ -8,8 +8,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/clk.h>
diff --git a/drivers/char/hw_random/ingenic-trng.c b/drivers/char/hw_random/ingenic-trng.c
index 0eb80f786f4d..759445d4f65a 100644
--- a/drivers/char/hw_random/ingenic-trng.c
+++ b/drivers/char/hw_random/ingenic-trng.c
@@ -11,8 +11,8 @@
 #include <linux/hw_random.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
diff --git a/drivers/char/hw_random/iproc-rng200.c b/drivers/char/hw_random/iproc-rng200.c
index 06bc060534d8..34df3f0d3e45 100644
--- a/drivers/char/hw_random/iproc-rng200.c
+++ b/drivers/char/hw_random/iproc-rng200.c
@@ -12,8 +12,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 
diff --git a/drivers/char/hw_random/npcm-rng.c b/drivers/char/hw_random/npcm-rng.c
index 9903d0357e06..8a304b754217 100644
--- a/drivers/char/hw_random/npcm-rng.c
+++ b/drivers/char/hw_random/npcm-rng.c
@@ -8,12 +8,11 @@
 #include <linux/init.h>
 #include <linux/random.h>
 #include <linux/err.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/hw_random.h>
 #include <linux/delay.h>
-#include <linux/of_irq.h>
 #include <linux/pm_runtime.h>
-#include <linux/of_device.h>
 
 #define NPCM_RNGCS_REG		0x00	/* Control and status register */
 #define NPCM_RNGD_REG		0x04	/* Data register */
diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index 00ff96703dd2..be03f76a2a80 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -26,8 +26,6 @@
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_address.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <linux/io.h>
diff --git a/drivers/char/hw_random/omap3-rom-rng.c b/drivers/char/hw_random/omap3-rom-rng.c
index f06e4f95114f..18dc46b1b58e 100644
--- a/drivers/char/hw_random/omap3-rom-rng.c
+++ b/drivers/char/hw_random/omap3-rom-rng.c
@@ -20,7 +20,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
diff --git a/drivers/char/hw_random/pasemi-rng.c b/drivers/char/hw_random/pasemi-rng.c
index 2498d4ef9fe2..6959d6edd44c 100644
--- a/drivers/char/hw_random/pasemi-rng.c
+++ b/drivers/char/hw_random/pasemi-rng.c
@@ -9,11 +9,10 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/hw_random.h>
 #include <linux/delay.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/io.h>
 
 #define SDCRNG_CTL_REG			0x00
diff --git a/drivers/char/hw_random/pic32-rng.c b/drivers/char/hw_random/pic32-rng.c
index 99c8bd0859a1..728b68b1a496 100644
--- a/drivers/char/hw_random/pic32-rng.c
+++ b/drivers/char/hw_random/pic32-rng.c
@@ -12,9 +12,8 @@
 #include <linux/hw_random.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index a6731cf0627a..efb6a9f9a11b 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -10,8 +10,9 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/char/hw_random/xgene-rng.c b/drivers/char/hw_random/xgene-rng.c
index 7c8f3cb7c6af..c25bb169563d 100644
--- a/drivers/char/hw_random/xgene-rng.c
+++ b/drivers/char/hw_random/xgene-rng.c
@@ -15,9 +15,8 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/timer.h>
 
 #define RNG_MAX_DATUM			4
diff --git a/drivers/char/hw_random/xiphera-trng.c b/drivers/char/hw_random/xiphera-trng.c
index 2a9fea72b2e0..2c586d1fe8a9 100644
--- a/drivers/char/hw_random/xiphera-trng.c
+++ b/drivers/char/hw_random/xiphera-trng.c
@@ -7,7 +7,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/hw_random.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 
diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index 2dea8cd5a09a..72640da55380 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/poll.h>
 #include <linux/regmap.h>
diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 528f35b14fb6..76adb108076c 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -11,7 +11,6 @@
 
 #include <linux/acpi.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/tee_drv.h>
 #include <linux/tpm.h>
diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 7db3593941ea..e4030404c64e 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -25,7 +25,6 @@
 #include <linux/acpi.h>
 #include <linux/freezer.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/kernel.h>
 #include <linux/dmi.h>
 #include "tpm.h"
diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index 1f5207974a17..c6101914629d 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -28,7 +28,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/spi/spi.h>
 #include <linux/tpm.h>
 
diff --git a/drivers/char/tpm/tpm_tis_synquacer.c b/drivers/char/tpm/tpm_tis_synquacer.c
index 49278746b0e2..7f9b4bfceb6e 100644
--- a/drivers/char/tpm/tpm_tis_synquacer.c
+++ b/drivers/char/tpm/tpm_tis_synquacer.c
@@ -9,7 +9,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/kernel.h>
 #include "tpm.h"
 #include "tpm_tis_core.h"
-- 
2.40.1

