Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942037E9E9B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjKMO1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjKMO1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:27:08 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727B2D72;
        Mon, 13 Nov 2023 06:27:04 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9F7B31C0012;
        Mon, 13 Nov 2023 14:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699885623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+i4FLnvd6XaZ4FK4Rv/lHlLAWGwtUlxb23vylnIS6g=;
        b=iGLuVOPw+l/CxkdcZ/4FKg7+dIPMY8gL2CbmKr/0Umw9RnIJxa4RBep3RmGFRt7kBhrULY
        VwDCidB9ZXtJYNGEpMm+OebAMZUXYfTlOC6WPRXCsQDlE1rFkoETqtaBtODxEpHk8vM0Bx
        LvlOx6U2BL5fGVNNpN7HaBySe3mYNLBKTD5yVXxf6L9o/9DkK2O9Yc7v4HMH5ikcI5xrYs
        hhMFaP0Q7LaWWeg4Tl1vJKHTS/U2TKBee34xMElK4UoDmNjz25wzhPMHV0ugN4Xb5s/+Ze
        rxZOWCT2xetF5zM9gJBUSr2jeXjWlU+EC2QJA2RM+Z+BtYedyq0w4twkS9L2XA==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Mon, 13 Nov 2023 15:27:00 +0100
Subject: [PATCH 5/6] usb: cdns3-ti: notify cdns core that hardware resets
 across suspend on J7200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231113-j7200-usb-suspend-v1-5-ad1ee714835c@bootlin.com>
References: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
In-Reply-To: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
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
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the CDNS3_RESET_ON_RESUME quirk flag to inform the cdns3 core that
our J7200 USB controller will lose power during suspend. It therefore
must be reconfigured when we resume.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/cdns3-ti.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index 50b38c4b9c87..c65714c783fb 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -16,6 +16,7 @@
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include "core.h"
 
 /* USB Wrapper register offsets */
 #define USBSS_PID		0x0
@@ -127,6 +128,7 @@ static int cdns_ti_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = pdev->dev.of_node;
+	const struct of_dev_auxdata *auxdata;
 	struct cdns_ti *data;
 	unsigned long rate;
 	int error, i;
@@ -182,7 +184,8 @@ static int cdns_ti_probe(struct platform_device *pdev)
 
 	cdns_ti_init_hw(data);
 
-	error = of_platform_populate(node, NULL, NULL, dev);
+	auxdata = of_device_get_match_data(dev);
+	error = of_platform_populate(node, NULL, auxdata, dev);
 	if (error) {
 		dev_err(dev, "failed to create children: %d\n", error);
 		goto err;
@@ -261,8 +264,20 @@ static void cdns_ti_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 }
 
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
2.41.0

