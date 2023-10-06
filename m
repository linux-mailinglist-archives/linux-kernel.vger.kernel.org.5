Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACA07BC249
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbjJFWoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjJFWoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:44:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E63CE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 15:44:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5F2C433C7;
        Fri,  6 Oct 2023 22:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696632260;
        bh=PQz5UeW21b7XKeFrQQ5YTYUWOaEon50sFtfDEhbwZFI=;
        h=From:To:Cc:Subject:Date:From;
        b=ZRDSzcuXNkG2Ofz//hmBSWeq0rZAbbcZKXhCpHriAcLi3qCd/YN4FO+Fjfy4LOiKG
         E5AWxEVE6S47bMDfbQFnN6mup+VdTkS/JbG3WUjBit8ODYf5QigaDor3zThHM6wLP8
         19RdhmlNluRo6yOlXY07THzReb8Eb5MfNMjWdHHm77B2UNzy2NbTqYSzG7xzGt5URy
         vH++CANyN5sWq8AYRO15bbLdyjFaLUupNu6B5jRvz1FjwO+0M+PSr9BYDx/jY8Rl45
         ASBEWOvBpjZfz2MnypD4l66UaHe23GhsZkTZlQza0nwj02uuI8mYMaCNSVnsZeo1NZ
         J+rVp110FSnvg==
Received: (nullmailer pid 442430 invoked by uid 1000);
        Fri, 06 Oct 2023 22:44:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 17:44:06 -0500
Message-Id: <20231006224407.442205-1-robh@kernel.org>
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

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mailbox/bcm-pdc-mailbox.c | 10 +++-------
 drivers/mailbox/mailbox-sti.c     |  8 +++-----
 drivers/mailbox/ti-msgmgr.c       | 12 ++----------
 3 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
index d67db63b482d..778faeced81e 100644
--- a/drivers/mailbox/bcm-pdc-mailbox.c
+++ b/drivers/mailbox/bcm-pdc-mailbox.c
@@ -33,10 +33,9 @@
 #include <linux/interrupt.h>
 #include <linux/wait.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/mailbox_controller.h>
 #include <linux/mailbox/brcm-message.h>
@@ -1494,7 +1493,6 @@ static int pdc_dt_read(struct platform_device *pdev, struct pdc_state *pdcs)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *dn = pdev->dev.of_node;
-	const struct of_device_id *match;
 	const int *hw_type;
 	int err;
 
@@ -1509,11 +1507,9 @@ static int pdc_dt_read(struct platform_device *pdev, struct pdc_state *pdcs)
 
 	pdcs->hw_type = PDC_HW;
 
-	match = of_match_device(of_match_ptr(pdc_mbox_of_match), dev);
-	if (match != NULL) {
-		hw_type = match->data;
+	hw_type = device_get_match_data(dev);
+	if (hw_type)
 		pdcs->hw_type = *hw_type;
-	}
 
 	return 0;
 }
diff --git a/drivers/mailbox/mailbox-sti.c b/drivers/mailbox/mailbox-sti.c
index 823061dd8c8e..b4b5bdd503cf 100644
--- a/drivers/mailbox/mailbox-sti.c
+++ b/drivers/mailbox/mailbox-sti.c
@@ -17,8 +17,8 @@
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 #include "mailbox.h"
@@ -403,7 +403,6 @@ MODULE_DEVICE_TABLE(of, sti_mailbox_match);
 
 static int sti_mbox_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct mbox_controller *mbox;
 	struct sti_mbox_device *mdev;
 	struct device_node *np = pdev->dev.of_node;
@@ -411,12 +410,11 @@ static int sti_mbox_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	match = of_match_device(sti_mailbox_match, &pdev->dev);
-	if (!match) {
+	pdev->dev.platform_data = (struct sti_mbox_pdata *)device_get_match_data(&pdev->dev);
+	if (!pdev->dev.platform_data) {
 		dev_err(&pdev->dev, "No configuration found\n");
 		return -ENODEV;
 	}
-	pdev->dev.platform_data = (struct sti_mbox_pdata *) match->data;
 
 	mdev = devm_kzalloc(&pdev->dev, sizeof(*mdev), GFP_KERNEL);
 	if (!mdev)
diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index a94577f16a47..9d2d4ff6cda4 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -15,10 +15,10 @@
 #include <linux/kernel.h>
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/soc/ti/ti-msgmgr.h>
 
 #define Q_DATA_OFFSET(proxy, queue, reg)	\
@@ -810,7 +810,6 @@ MODULE_DEVICE_TABLE(of, ti_msgmgr_of_match);
 static int ti_msgmgr_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *of_id;
 	struct device_node *np;
 	const struct ti_msgmgr_desc *desc;
 	struct ti_msgmgr_inst *inst;
@@ -828,19 +827,12 @@ static int ti_msgmgr_probe(struct platform_device *pdev)
 	}
 	np = dev->of_node;
 
-	of_id = of_match_device(ti_msgmgr_of_match, dev);
-	if (!of_id) {
-		dev_err(dev, "OF data missing\n");
-		return -EINVAL;
-	}
-	desc = of_id->data;
-
 	inst = devm_kzalloc(dev, sizeof(*inst), GFP_KERNEL);
 	if (!inst)
 		return -ENOMEM;
 
 	inst->dev = dev;
-	inst->desc = desc;
+	inst->desc = desc = device_get_match_data(dev);
 
 	inst->queue_proxy_region =
 		devm_platform_ioremap_resource_byname(pdev, desc->data_region_name);
-- 
2.40.1

