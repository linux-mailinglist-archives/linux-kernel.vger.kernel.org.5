Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9DE7BE7FF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377402AbjJIRaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377524AbjJIRaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:30:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0032A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:30:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D75C433C8;
        Mon,  9 Oct 2023 17:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696872618;
        bh=sx1WoOjHaMFdTQ94kKpqfTIrZkWzcWgNOPYR3IAiEnA=;
        h=From:To:Cc:Subject:Date:From;
        b=Erz4h7PnwGdYsKPPDmpKjzmwgGq/yPUJJag64Hhs/bUOEcgTxiXmDSbq+fA/JmaNA
         gvkkYTsvOE6uoY+QT1L37QqfzSeXuQZqGoqO61cPxYgiu71sdA9GpFkNw5Vb8Hs2Az
         YDB5bLjFu4C5OwC4UuJYg/lpw7IW5lPdZbnUTJIGkFaFJ9hHN/CdiSxz8R4+Rfy0J9
         TDrBeKfgo4mXCw44hz/4yIyO8BNYZrQ79CGH2WI6n8FSWBL1oSIT7QiMCPKElYWsck
         EJaaOqVSzBNIW+dPfMkep+MB4n05HuNCF2dJKVbYH9xixhkmPNCHPKiN+XWIEDON5D
         pglJS28VkhafA==
Received: (nullmailer pid 2480196 invoked by uid 1000);
        Mon, 09 Oct 2023 17:30:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Stefan Agner <stefan@agner.ch>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: Use device_get_match_data()
Date:   Mon,  9 Oct 2023 12:28:56 -0500
Message-ID: <20231009172923.2457844-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mtd/maps/physmap-core.c                | 10 +++-------
 drivers/mtd/nand/raw/cadence-nand-controller.c | 12 +++++-------
 drivers/mtd/nand/raw/vf610_nfc.c               | 10 ++++------
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-core.c
index fc8721339282..c99db9c6d25a 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>
@@ -37,7 +38,7 @@
 #include <linux/mtd/concat.h>
 #include <linux/mtd/cfi_endian.h>
 #include <linux/io.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/gpio/consumer.h>
 
@@ -296,14 +297,9 @@ static const char * const *of_get_part_probes(struct platform_device *dev)
 static const char *of_select_probe_type(struct platform_device *dev)
 {
 	struct device_node *dp = dev->dev.of_node;
-	const struct of_device_id *match;
 	const char *probe_type;
 
-	match = of_match_device(of_flash_match, &dev->dev);
-	if (!match)
-		return NULL;
-
-	probe_type = match->data;
+	probe_type = device_get_match_data(&dev->dev);
 	if (probe_type)
 		return probe_type;
 
diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 034ec564c2ed..f19bf06e9e05 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -15,8 +15,10 @@
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/of_device.h>
 #include <linux/iopoll.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 /*
@@ -2995,15 +2997,11 @@ static int cadence_nand_dt_probe(struct platform_device *ofdev)
 	struct cadence_nand_dt *dt;
 	struct cdns_nand_ctrl *cdns_ctrl;
 	int ret;
-	const struct of_device_id *of_id;
 	const struct cadence_nand_dt_devdata *devdata;
 	u32 val;
 
-	of_id = of_match_device(cadence_nand_dt_ids, &ofdev->dev);
-	if (of_id) {
-		ofdev->id_entry = of_id->data;
-		devdata = of_id->data;
-	} else {
+	devdata = device_get_match_data(&ofdev->dev);
+	if (!devdata) {
 		pr_err("Failed to find the right device id.\n");
 		return -ENOMEM;
 	}
diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index 3f783b8f76c9..f31d23219f91 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -29,8 +29,9 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/swab.h>
 
@@ -810,7 +811,6 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 	struct mtd_info *mtd;
 	struct nand_chip *chip;
 	struct device_node *child;
-	const struct of_device_id *of_id;
 	int err;
 	int irq;
 
@@ -840,12 +840,10 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 		return PTR_ERR(nfc->clk);
 	}
 
-	of_id = of_match_device(vf610_nfc_dt_ids, &pdev->dev);
-	if (!of_id)
+	nfc->variant = (enum vf610_nfc_variant)device_get_match_data(&pdev->dev);
+	if (!nfc->variant)
 		return -ENODEV;
 
-	nfc->variant = (uintptr_t)of_id->data;
-
 	for_each_available_child_of_node(nfc->dev->of_node, child) {
 		if (of_device_is_compatible(child, "fsl,vf610-nfc-nandcs")) {
 
-- 
2.42.0

