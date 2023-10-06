Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FC17BC163
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjJFVms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjJFVmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:42:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9140BE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:42:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10D5C433C7;
        Fri,  6 Oct 2023 21:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696628565;
        bh=pvPNLy/jIeBGg7wC3/rVpwO1svAHAzEF2z2bam7K3tE=;
        h=From:To:Cc:Subject:Date:From;
        b=nm6dsHfpevhcfM5r2Uqhi4R+LYo+202uay+6OilP7M+LSSwUo2ManE85lPe7EbN+Z
         2pAauATX+saPRunU8STGqsqcNGD21MULlOuN1QxCGM7cJFe4fK5Fgj+7A2bDoQahvl
         teZwElwYhn3VijjeSsG5XwUqZiiQsLm3P8dSCu4sYhcrkcj9f8iBDxMmkJW2KbCpAC
         ehuG91uVo1iKy/3GDhYUWeNfQmBr9ZyCuMKEFJBMM58BYIwooXDf68gZy16BaB+xHZ
         wme7p0q0wXzVNKDG3FExO7IOA9X8hpBMzKTsOmp3Z0R35BCGfuc2zxQGTGpS87v4D3
         YM0M8Yeh33QgQ==
Received: (nullmailer pid 337386 invoked by uid 1000);
        Fri, 06 Oct 2023 21:42:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] char: xilinx_hwicap: Modernize driver probe
Date:   Fri,  6 Oct 2023 16:42:28 -0500
Message-Id: <20231006214228.337064-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
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

Rework Xilinx hwicap driver probe to use current best practices using
devres APIs, device_get_match_data(), and typed firmware property accessors.

There's no longer any non-DT probing, so CONFIG_OF ifdefs can be dropped.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/char/xilinx_hwicap/xilinx_hwicap.c | 138 +++------------------
 1 file changed, 19 insertions(+), 119 deletions(-)

diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index f60bb6151402..019cf6079cec 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -84,18 +84,13 @@
 #include <linux/sysctl.h>
 #include <linux/fs.h>
 #include <linux/cdev.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
 
-#ifdef CONFIG_OF
-/* For open firmware. */
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
-#endif
-
 #include "xilinx_hwicap.h"
 #include "buffer_icap.h"
 #include "fifo_icap.h"
@@ -601,14 +596,14 @@ static const struct file_operations hwicap_fops = {
 	.llseek = noop_llseek,
 };
 
-static int hwicap_setup(struct device *dev, int id,
-		const struct resource *regs_res,
+static int hwicap_setup(struct platform_device *pdev, int id,
 		const struct hwicap_driver_config *config,
 		const struct config_registers *config_regs)
 {
 	dev_t devt;
 	struct hwicap_drvdata *drvdata = NULL;
-	int retval = 0;
+	struct device *dev = &pdev->dev;
+	int retval;
 
 	dev_info(dev, "Xilinx icap port driver\n");
 
@@ -636,72 +631,39 @@ static int hwicap_setup(struct device *dev, int id,
 
 	devt = MKDEV(XHWICAP_MAJOR, XHWICAP_MINOR + id);
 
-	drvdata = kzalloc(sizeof(struct hwicap_drvdata), GFP_KERNEL);
+	drvdata = devm_kzalloc(dev, sizeof(struct hwicap_drvdata), GFP_KERNEL);
 	if (!drvdata) {
 		retval = -ENOMEM;
-		goto failed0;
+		goto failed;
 	}
 	dev_set_drvdata(dev, (void *)drvdata);
 
-	if (!regs_res) {
-		dev_err(dev, "Couldn't get registers resource\n");
-		retval = -EFAULT;
-		goto failed1;
-	}
-
-	drvdata->mem_start = regs_res->start;
-	drvdata->mem_end = regs_res->end;
-	drvdata->mem_size = resource_size(regs_res);
-
-	if (!request_mem_region(drvdata->mem_start,
-					drvdata->mem_size, DRIVER_NAME)) {
-		dev_err(dev, "Couldn't lock memory region at %Lx\n",
-			(unsigned long long) regs_res->start);
-		retval = -EBUSY;
-		goto failed1;
+	drvdata->base_address = devm_platform_ioremap_resource(pdev, 0);
+	if (!drvdata->base_address) {
+		retval = -ENODEV;
+		goto failed;
 	}
 
 	drvdata->devt = devt;
 	drvdata->dev = dev;
-	drvdata->base_address = ioremap(drvdata->mem_start, drvdata->mem_size);
-	if (!drvdata->base_address) {
-		dev_err(dev, "ioremap() failed\n");
-		retval = -ENOMEM;
-		goto failed2;
-	}
-
 	drvdata->config = config;
 	drvdata->config_regs = config_regs;
 
 	mutex_init(&drvdata->sem);
 	drvdata->is_open = 0;
 
-	dev_info(dev, "ioremap %llx to %p with size %llx\n",
-		 (unsigned long long) drvdata->mem_start,
-		 drvdata->base_address,
-		 (unsigned long long) drvdata->mem_size);
-
 	cdev_init(&drvdata->cdev, &hwicap_fops);
 	drvdata->cdev.owner = THIS_MODULE;
 	retval = cdev_add(&drvdata->cdev, devt, 1);
 	if (retval) {
 		dev_err(dev, "cdev_add() failed\n");
-		goto failed3;
+		goto failed;
 	}
 
 	device_create(&icap_class, dev, devt, NULL, "%s%d", DRIVER_NAME, id);
 	return 0;		/* success */
 
- failed3:
-	iounmap(drvdata->base_address);
-
- failed2:
-	release_mem_region(regs_res->start, drvdata->mem_size);
-
- failed1:
-	kfree(drvdata);
-
- failed0:
+ failed:
 	mutex_lock(&icap_sem);
 	probed_devices[id] = 0;
 	mutex_unlock(&icap_sem);
@@ -723,75 +685,22 @@ static struct hwicap_driver_config fifo_icap_config = {
 	.reset = fifo_icap_reset,
 };
 
-#ifdef CONFIG_OF
-static int hwicap_of_probe(struct platform_device *op,
-				     const struct hwicap_driver_config *config)
-{
-	struct resource res;
-	const unsigned int *id;
-	const char *family;
-	int rc;
-	const struct config_registers *regs;
-
-
-	rc = of_address_to_resource(op->dev.of_node, 0, &res);
-	if (rc) {
-		dev_err(&op->dev, "invalid address\n");
-		return rc;
-	}
-
-	id = of_get_property(op->dev.of_node, "port-number", NULL);
-
-	/* It's most likely that we're using V4, if the family is not
-	 * specified
-	 */
-	regs = &v4_config_registers;
-	family = of_get_property(op->dev.of_node, "xlnx,family", NULL);
-
-	if (family) {
-		if (!strcmp(family, "virtex2p"))
-			regs = &v2_config_registers;
-		else if (!strcmp(family, "virtex4"))
-			regs = &v4_config_registers;
-		else if (!strcmp(family, "virtex5"))
-			regs = &v5_config_registers;
-		else if (!strcmp(family, "virtex6"))
-			regs = &v6_config_registers;
-	}
-	return hwicap_setup(&op->dev, id ? *id : -1, &res, config,
-			regs);
-}
-#else
-static inline int hwicap_of_probe(struct platform_device *op,
-				  const struct hwicap_driver_config *config)
-{
-	return -EINVAL;
-}
-#endif /* CONFIG_OF */
-
-static const struct of_device_id hwicap_of_match[];
 static int hwicap_drv_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
-	struct resource *res;
 	const struct config_registers *regs;
+	const struct hwicap_driver_config *config;
 	const char *family;
+	int id = -1;
 
-	match = of_match_device(hwicap_of_match, &pdev->dev);
-	if (match)
-		return hwicap_of_probe(pdev, match->data);
+	config = device_get_match_data(&pdev->dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
+	of_property_read_u32(pdev->dev.of_node, "port-number", &id);
 
 	/* It's most likely that we're using V4, if the family is not
 	 * specified
 	 */
 	regs = &v4_config_registers;
-	family = pdev->dev.platform_data;
-
-	if (family) {
+	if (!of_property_read_string(pdev->dev.of_node, "xlnx,family", &family)) {
 		if (!strcmp(family, "virtex2p"))
 			regs = &v2_config_registers;
 		else if (!strcmp(family, "virtex4"))
@@ -801,9 +710,7 @@ static int hwicap_drv_probe(struct platform_device *pdev)
 		else if (!strcmp(family, "virtex6"))
 			regs = &v6_config_registers;
 	}
-
-	return hwicap_setup(&pdev->dev, pdev->id, res,
-			&buffer_icap_config, regs);
+	return hwicap_setup(pdev, id, config, regs);
 }
 
 static void hwicap_drv_remove(struct platform_device *pdev)
@@ -815,16 +722,12 @@ static void hwicap_drv_remove(struct platform_device *pdev)
 
 	device_destroy(&icap_class, drvdata->devt);
 	cdev_del(&drvdata->cdev);
-	iounmap(drvdata->base_address);
-	release_mem_region(drvdata->mem_start, drvdata->mem_size);
-	kfree(drvdata);
 
 	mutex_lock(&icap_sem);
 	probed_devices[MINOR(dev->devt)-XHWICAP_MINOR] = 0;
 	mutex_unlock(&icap_sem);
 }
 
-#ifdef CONFIG_OF
 /* Match table for device tree binding */
 static const struct of_device_id hwicap_of_match[] = {
 	{ .compatible = "xlnx,opb-hwicap-1.00.b", .data = &buffer_icap_config},
@@ -832,9 +735,6 @@ static const struct of_device_id hwicap_of_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, hwicap_of_match);
-#else
-#define hwicap_of_match NULL
-#endif
 
 static struct platform_driver hwicap_platform_driver = {
 	.probe = hwicap_drv_probe,
-- 
2.40.1

