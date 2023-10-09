Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496EA7BE831
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378072AbjJIRcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378068AbjJIRck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:32:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D24BA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:32:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3A3C433C9;
        Mon,  9 Oct 2023 17:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696872759;
        bh=gNwIGig1RSpviawIcA3WM9ILVF/QqJCL1en6+KHTE78=;
        h=From:To:Cc:Subject:Date:From;
        b=C+aP2wa/68Yy8CjZntp0Q0tnb5pcxVGOrJrld6QUY7WarUV3b0yXih6VioBHvCHyS
         zIzVCbqg68T+EdVee5j4po9oA4MNb0UTnZmpG4vW1BO2a4XyS90Al/ErZQg9muAUnZ
         e2o83e7cmHzU2OKK2m1pUwRfflklRxXCQbg1ix8DnFkEbc9cD4DuHYTdOA4jY0HtxN
         JCwJ3tYq6rVHz+HwArAV0NmVhhCGPgZuCO75DUSqrbRtihZTLRn+3+5X3ZQ+QrpFtr
         jJWysBRc+Pxbz7pWeUoHc/NMP6oqcV5JckqEunF6lnJWP4AfxV6slPZ6Wut3xdPqWK
         2PRZEu+gVZCJg==
Received: (nullmailer pid 2529337 invoked by uid 1000);
        Mon, 09 Oct 2023 17:32:37 -0000
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: Drop unnecessary of_match_device() calls
Date:   Mon,  9 Oct 2023 12:29:11 -0500
Message-ID: <20231009172923.2457844-16-robh@kernel.org>
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

If probe is reached, we've already matched the device and in the case of
DT matching, the struct device_node pointer will be set. Therefore, there
is no need to call of_match_device() in probe.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/phy/motorola/phy-cpcap-usb.c |  7 -------
 drivers/phy/ti/phy-dm816x-usb.c      | 11 +----------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
index 74333e814221..7bbf729a7c90 100644
--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -15,7 +15,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/iio/consumer.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
@@ -612,14 +611,8 @@ static int cpcap_usb_phy_probe(struct platform_device *pdev)
 	struct phy *generic_phy;
 	struct phy_provider *phy_provider;
 	struct usb_otg *otg;
-	const struct of_device_id *of_id;
 	int error;
 
-	of_id = of_match_device(of_match_ptr(cpcap_usb_phy_id_table),
-				&pdev->dev);
-	if (!of_id)
-		return -EINVAL;
-
 	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;
diff --git a/drivers/phy/ti/phy-dm816x-usb.c b/drivers/phy/ti/phy-dm816x-usb.c
index db153a55f4e1..d5ae972a31fb 100644
--- a/drivers/phy/ti/phy-dm816x-usb.c
+++ b/drivers/phy/ti/phy-dm816x-usb.c
@@ -13,7 +13,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/delay.h>
 #include <linux/phy/phy.h>
-#include <linux/of_platform.h>
 
 #include <linux/mfd/syscon.h>
 
@@ -161,7 +160,6 @@ static UNIVERSAL_DEV_PM_OPS(dm816x_usb_phy_pm_ops,
 			    dm816x_usb_phy_runtime_resume,
 			    NULL);
 
-#ifdef CONFIG_OF
 static const struct of_device_id dm816x_usb_phy_id_table[] = {
 	{
 		.compatible = "ti,dm8168-usb-phy",
@@ -169,7 +167,6 @@ static const struct of_device_id dm816x_usb_phy_id_table[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, dm816x_usb_phy_id_table);
-#endif
 
 static int dm816x_usb_phy_probe(struct platform_device *pdev)
 {
@@ -178,14 +175,8 @@ static int dm816x_usb_phy_probe(struct platform_device *pdev)
 	struct phy *generic_phy;
 	struct phy_provider *phy_provider;
 	struct usb_otg *otg;
-	const struct of_device_id *of_id;
 	int error;
 
-	of_id = of_match_device(of_match_ptr(dm816x_usb_phy_id_table),
-				&pdev->dev);
-	if (!of_id)
-		return -EINVAL;
-
 	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy)
 		return -ENOMEM;
@@ -272,7 +263,7 @@ static struct platform_driver dm816x_usb_phy_driver = {
 	.driver		= {
 		.name	= "dm816x-usb-phy",
 		.pm	= &dm816x_usb_phy_pm_ops,
-		.of_match_table = of_match_ptr(dm816x_usb_phy_id_table),
+		.of_match_table = dm816x_usb_phy_id_table,
 	},
 };
 
-- 
2.42.0

