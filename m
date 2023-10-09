Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079907BEC91
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378723AbjJIVPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378785AbjJIVOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:14:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D905C1A1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:14:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A26EC433C8;
        Mon,  9 Oct 2023 21:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886073;
        bh=X1cH/h9NDVZrOok4vly/3g9sh+E04rVkCkSlfXlWOkc=;
        h=From:To:Cc:Subject:Date:From;
        b=UX5AlFcsmSNuOATqpTq/hIGo5FVEW6AOvZIzMyjgNvPnEIMxc0WKvQu08BweMdCFw
         0zCmWnxuIchvRaQE/rVjCjZwq4po/w6dpkLmCDkI9D1Na1t0515QYR2RidgCz5Rd90
         gdYcXPc0XrMJCb1s2LWdURita5X6F46xykVT0w25UhELnABfNrQ8xod18E3DeOgYAx
         tyXN6j/t9dhuK06eMT4UBk+nV+3s6U149ln3ThjasbJeCwtIcBTfCwWOtYlzuYrlxe
         mdEFlKV9cyMp0wjIPJUQGKLMKwkMzrWWijwCSKm7L6KNtXaN/x83pdrstCq1bDtYU1
         EWK50UVpWY+/g==
Received: (nullmailer pid 3246487 invoked by uid 1000);
        Mon, 09 Oct 2023 21:14:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Li Yang <leoyang.li@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] usb: Use device_get_match_data()
Date:   Mon,  9 Oct 2023 16:13:46 -0500
Message-ID: <20231009211356.3242037-16-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/usb/chipidea/ci_hdrc_usb2.c | 11 +++++------
 drivers/usb/dwc2/params.c           | 21 ++++++---------------
 drivers/usb/gadget/udc/fsl_qe_udc.c | 10 +++-------
 drivers/usb/misc/onboard_usb_hub.c  |  7 +------
 4 files changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/ci_hdrc_usb2.c
index 1321ee67f3b8..180a632dd7ba 100644
--- a/drivers/usb/chipidea/ci_hdrc_usb2.c
+++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
@@ -9,9 +9,9 @@
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/usb/chipidea.h>
 #include <linux/usb/hcd.h>
 #include <linux/usb/ulpi.h>
@@ -51,8 +51,8 @@ static int ci_hdrc_usb2_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ci_hdrc_usb2_priv *priv;
 	struct ci_hdrc_platform_data *ci_pdata = dev_get_platdata(dev);
+	const struct ci_hdrc_platform_data *data;
 	int ret;
-	const struct of_device_id *match;
 
 	if (!ci_pdata) {
 		ci_pdata = devm_kmalloc(dev, sizeof(*ci_pdata), GFP_KERNEL);
@@ -61,11 +61,10 @@ static int ci_hdrc_usb2_probe(struct platform_device *pdev)
 		*ci_pdata = ci_default_pdata;	/* struct copy */
 	}
 
-	match = of_match_device(ci_hdrc_usb2_of_match, &pdev->dev);
-	if (match && match->data) {
+	data = device_get_match_data(&pdev->dev);
+	if (data)
 		/* struct copy */
-		*ci_pdata = *(struct ci_hdrc_platform_data *)match->data;
-	}
+		*ci_pdata = *data;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 93f52e371cdd..fb03162ae9b7 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -5,7 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/usb/of.h>
 #include <linux/pci_ids.h>
 #include <linux/pci.h>
@@ -968,26 +968,17 @@ typedef void (*set_params_cb)(struct dwc2_hsotg *data);
 
 int dwc2_init_params(struct dwc2_hsotg *hsotg)
 {
-	const struct of_device_id *match;
 	set_params_cb set_params;
 
 	dwc2_set_default_params(hsotg);
 	dwc2_get_device_properties(hsotg);
 
-	match = of_match_device(dwc2_of_match_table, hsotg->dev);
-	if (match && match->data) {
-		set_params = match->data;
+	set_params = device_get_match_data(hsotg->dev);
+	if (set_params) {
 		set_params(hsotg);
-	} else if (!match) {
-		const struct acpi_device_id *amatch;
-		const struct pci_device_id *pmatch = NULL;
-
-		amatch = acpi_match_device(dwc2_acpi_match, hsotg->dev);
-		if (amatch && amatch->driver_data) {
-			set_params = (set_params_cb)amatch->driver_data;
-			set_params(hsotg);
-		} else if (!amatch)
-			pmatch = pci_match_id(dwc2_pci_ids, to_pci_dev(hsotg->dev->parent));
+	} else {
+		const struct pci_device_id *pmatch =
+			pci_match_id(dwc2_pci_ids, to_pci_dev(hsotg->dev->parent));
 
 		if (pmatch && pmatch->driver_data) {
 			set_params = (set_params_cb)pmatch->driver_data;
diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index 4aae86b47edf..4e88681a79b6 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -27,9 +27,10 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/moduleparam.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -2471,17 +2472,12 @@ static const struct of_device_id qe_udc_match[];
 static int qe_udc_probe(struct platform_device *ofdev)
 {
 	struct qe_udc *udc;
-	const struct of_device_id *match;
 	struct device_node *np = ofdev->dev.of_node;
 	struct qe_ep *ep;
 	unsigned int ret = 0;
 	unsigned int i;
 	const void *prop;
 
-	match = of_match_device(qe_udc_match, &ofdev->dev);
-	if (!match)
-		return -EINVAL;
-
 	prop = of_get_property(np, "mode", NULL);
 	if (!prop || strcmp(prop, "peripheral"))
 		return -ENODEV;
@@ -2493,7 +2489,7 @@ static int qe_udc_probe(struct platform_device *ofdev)
 		return -ENOMEM;
 	}
 
-	udc->soc_type = (unsigned long)match->data;
+	udc->soc_type = (unsigned long)device_get_match_data(&ofdev->dev);
 	udc->usb_regs = of_iomap(np, 0);
 	if (!udc->usb_regs) {
 		ret = -ENOMEM;
diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 57bbe1309094..a341b2fbb7b4 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -240,7 +240,6 @@ static void onboard_hub_attach_usb_driver(struct work_struct *work)
 
 static int onboard_hub_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
 	struct onboard_hub *hub;
 	unsigned int i;
@@ -250,11 +249,7 @@ static int onboard_hub_probe(struct platform_device *pdev)
 	if (!hub)
 		return -ENOMEM;
 
-	of_id = of_match_device(onboard_hub_match, &pdev->dev);
-	if (!of_id)
-		return -ENODEV;
-
-	hub->pdata = of_id->data;
+	hub->pdata = device_get_match_data(&pdev->dev);
 	if (!hub->pdata)
 		return -EINVAL;
 
-- 
2.42.0

