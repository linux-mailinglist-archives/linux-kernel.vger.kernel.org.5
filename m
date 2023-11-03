Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2927E06A9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345581AbjKCQnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345287AbjKCQnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:43:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B42D44;
        Fri,  3 Nov 2023 09:43:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45509C433C8;
        Fri,  3 Nov 2023 16:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699029814;
        bh=AKJI6ud2/gqzwSf2vyoKUTsXLPjddX84FQGpHNeQVNE=;
        h=From:To:Cc:Subject:Date:From;
        b=m3wVna0kVxQ6v441O/jKbp5N8irWGgjATWudGzxUK9bGqx/kDunXmxDDUwWpf5w/m
         EkolboyL9WxzhbBo63r5HnTRMYoFGP7tcSO2kRxj4WD7N/tkmA1DgM6V/VU5mxVvOk
         RS2OAqremX9mWjsQrThv4EBpVQGsdN+wAgXcuNPapmOFNzFs4aeelXlGU9aGxAqgpC
         1rEZkl3Fen+LUVE9PtED1vw78RQldn0eHx68lL44l98PetaUubtEqQ+0CF1MUGguae
         4Ncu9HFwshrKHf9CJwxZy2b47KCIjC2o/OT0f47rUyZkVkfnH4nS7r7FuxdITIOWC+
         ZxjpcmDGUJluA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qyxHH-0003j7-05;
        Fri, 03 Nov 2023 17:44:11 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Stanley Chang <stanley_chang@realtek.com>
Subject: [PATCH] USB: xhci-plat: fix legacy PHY double init
Date:   Fri,  3 Nov 2023 17:43:23 +0100
Message-ID: <20231103164323.14294-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commits 7b8ef22ea547 ("usb: xhci: plat: Add USB phy support") and
9134c1fd0503 ("usb: xhci: plat: Add USB 3.0 phy support") added support
for looking up legacy PHYs from the sysdev devicetree node and
initialising them.

This broke drivers such as dwc3 which manages PHYs themself as the PHYs
would now be initialised twice, something which specifically can lead to
resources being left enabled during suspend (e.g. with the
usb_phy_generic PHY driver).

As the dwc3 driver uses driver-name matching for the xhci platform
device, fix this by only looking up and initialising PHYs for devices
that have been matched using OF.

Note that checking that the platform device has a devicetree node would
currently be sufficient, but that could lead to subtle breakages in case
anyone ever tries to reuse an ancestor's node.

Fixes: 7b8ef22ea547 ("usb: xhci: plat: Add USB phy support")
Fixes: 9134c1fd0503 ("usb: xhci: plat: Add USB 3.0 phy support")
Cc: stable@vger.kernel.org      # 4.1
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Stanley Chang <stanley_chang@realtek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/host/xhci-plat.c | 50 +++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 28218c8f1837..01d19d17153b 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/usb/phy.h>
 #include <linux/slab.h>
@@ -148,7 +149,7 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 	int			ret;
 	int			irq;
 	struct xhci_plat_priv	*priv = NULL;
-
+	bool			of_match;
 
 	if (usb_disabled())
 		return -ENODEV;
@@ -253,16 +254,23 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 					 &xhci->imod_interval);
 	}
 
-	hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
-	if (IS_ERR(hcd->usb_phy)) {
-		ret = PTR_ERR(hcd->usb_phy);
-		if (ret == -EPROBE_DEFER)
-			goto disable_clk;
-		hcd->usb_phy = NULL;
-	} else {
-		ret = usb_phy_init(hcd->usb_phy);
-		if (ret)
-			goto disable_clk;
+	/*
+	 * Drivers such as dwc3 manages PHYs themself (and rely on driver name
+	 * matching for the xhci platform device).
+	 */
+	of_match = of_match_device(pdev->dev.driver->of_match_table, &pdev->dev);
+	if (of_match) {
+		hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
+		if (IS_ERR(hcd->usb_phy)) {
+			ret = PTR_ERR(hcd->usb_phy);
+			if (ret == -EPROBE_DEFER)
+				goto disable_clk;
+			hcd->usb_phy = NULL;
+		} else {
+			ret = usb_phy_init(hcd->usb_phy);
+			if (ret)
+				goto disable_clk;
+		}
 	}
 
 	hcd->tpl_support = of_usb_host_tpl_support(sysdev->of_node);
@@ -285,15 +293,17 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 			goto dealloc_usb2_hcd;
 		}
 
-		xhci->shared_hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev,
-			    "usb-phy", 1);
-		if (IS_ERR(xhci->shared_hcd->usb_phy)) {
-			xhci->shared_hcd->usb_phy = NULL;
-		} else {
-			ret = usb_phy_init(xhci->shared_hcd->usb_phy);
-			if (ret)
-				dev_err(sysdev, "%s init usb3phy fail (ret=%d)\n",
-					    __func__, ret);
+		if (of_match) {
+			xhci->shared_hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev,
+										"usb-phy", 1);
+			if (IS_ERR(xhci->shared_hcd->usb_phy)) {
+				xhci->shared_hcd->usb_phy = NULL;
+			} else {
+				ret = usb_phy_init(xhci->shared_hcd->usb_phy);
+				if (ret)
+					dev_err(sysdev, "%s init usb3phy fail (ret=%d)\n",
+						__func__, ret);
+			}
 		}
 
 		xhci->shared_hcd->tpl_support = hcd->tpl_support;
-- 
2.41.0

