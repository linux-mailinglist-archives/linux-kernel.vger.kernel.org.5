Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC427F1951
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjKTRG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjKTRGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:06:17 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66829E8;
        Mon, 20 Nov 2023 09:06:13 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 62A2FE0010;
        Mon, 20 Nov 2023 17:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700499972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nDo2L/kHH9S9njIE6FRuQXRwkc6RX5NfCLZkNNd2W9E=;
        b=QBqPbnsxX5rPc90WJBdLJNqmikqCqCW9lLULcko2NpiWhto/Vzx2pBz1B1AyHUAckANfOn
        NOWwyh1lTnaIn3E0HmBzw5lgnGbvDErrP5rlqISW7AtaDHhy95aNawkIA+uDfh4dnVRIRH
        YSLa5MXVUPQ41b7VwNYsC+fwgi30ZjmCC4Ue+pCLNQdzsVGwUDg1AToa0QzAE3uIsyu6TJ
        sQ5Okl4vkxi7vl06ZP13kvGpe4rfCBTUFYCjYLOcgZYyh7QyF8+lwewZXi/c49xIfLfIJp
        95vGcaCza1+nxKTvoiTUeZwjmxI19pSBXHfqH9c2Dyikj/koqNOy1PYXAQuQCA==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Mon, 20 Nov 2023 18:06:06 +0100
Subject: [PATCH v2 6/7] usb: cdns3-ti: signal reset-on-resume to xHCI for
 J7200 platform
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231120-j7200-usb-suspend-v2-6-038c7e4a3df4@bootlin.com>
References: <20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com>
In-Reply-To: <20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Thomas Petazzoni thomas.petazzoni"@bootlin.com,
        =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass CDNS3_RESET_ON_RESUME as platform data to cdns3 host role. It will
in turn pass it down to xHCI platform data as XHCI_RESET_ON_RESUME.

Avoid this warning on resume:

  [   16.017462] xhci-hcd xhci-hcd.1.auto: xHC error in resume, USBSTS 0x401, Reinit

When used, remote wakeup is not expected to work.

Only focus J7200 as other SoC are untested.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/cdns3-ti.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index 84f93c2fcd5c..7d56a1acbc54 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -16,6 +16,7 @@
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include "core.h"
 
 /* USB Wrapper register offsets */
 #define USBSS_PID		0x0
@@ -128,6 +129,7 @@ static int cdns_ti_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = pdev->dev.of_node;
+	const struct of_dev_auxdata *auxdata;
 	struct cdns_ti *data;
 	unsigned long rate;
 	int error, i;
@@ -177,7 +179,8 @@ static int cdns_ti_probe(struct platform_device *pdev)
 
 	cdns_ti_init_hw(data);
 
-	error = of_platform_populate(node, NULL, NULL, dev);
+	auxdata = of_device_get_match_data(dev);
+	error = of_platform_populate(node, NULL, auxdata, dev);
 	if (error) {
 		dev_err(dev, "failed to create children: %d\n", error);
 		return error;
@@ -222,8 +225,20 @@ static const struct dev_pm_ops cdns_ti_pm_ops = {
 
 #endif /* CONFIG_PM */
 
+static struct cdns3_platform_data cdns_ti_j7200_pdata = {
+	.quirks = CDNS3_RESET_ON_RESUME,
+};
+
+static const struct of_dev_auxdata cdns_ti_j7200_auxdata[] = {
+	{
+		.compatible = "cdns,usb3",
+		.platform_data = &cdns_ti_j7200_pdata,
+	},
+	{},
+};
+
 static const struct of_device_id cdns_ti_of_match[] = {
-	{ .compatible = "ti,j7200-usb", },
+	{ .compatible = "ti,j7200-usb", .data = cdns_ti_j7200_auxdata, },
 	{ .compatible = "ti,j721e-usb", },
 	{ .compatible = "ti,am64-usb", },
 	{},

-- 
2.42.0

