Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753AB7E9E98
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjKMO1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjKMO1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:27:07 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F66D60;
        Mon, 13 Nov 2023 06:27:03 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4CF531C0003;
        Mon, 13 Nov 2023 14:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699885621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xhQIX2l1AguLqLqqSuhrXlTHhHreB3Yx+m4gIExyzdk=;
        b=CdUrQ5QZKlKgfAHkaN5pRMkm6kJPA7FlAgX2N1M8ahm8ex2+uOgnaxX7lYbma/37xjoiRR
        XvjQ+AmQaJMrockgTuSlRkL1QUubiF49WGsh9YTkowiuuvRhl9EoaH3DspwDotkBdXLOwv
        LE9brLy6qOvyZkXRkYRhk8wg2GPX19qZGyr7ebhITZO+h+rXHfrYQk9V53UF5D5aVE3HeL
        XdU2nwVZ5T0MfN8IR33H+UiHkN7fy69Xr1hkKECt9SoTyZ5PR5IBBIj8p0aBPrddSnfhPS
        4m30yACn8GeoehQ57l1oVuMsJrzUg2PcR25Enpzsly5sV9f6yLG5IeL/tKxM+g==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Mon, 13 Nov 2023 15:26:58 +0100
Subject: [PATCH 3/6] usb: cdns3-ti: add suspend/resume procedures for J7200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231113-j7200-usb-suspend-v1-3-ad1ee714835c@bootlin.com>
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

Hardware initialisation is only done at probe. The J7200 USB controller
is reset at resume because of power-domains toggling off & on. We
therefore (1) toggle PM runtime at suspend/resume & (2) reconfigure the
hardware at resume.

Reuse the newly extracted cdns_ti_init_hw() function that contains the
register write sequence.

We guard this behavior based on compatible to avoid modifying the
current behavior on other platforms. If the controller does not reset
we do not want to touch PM runtime & do not want to redo reg writes.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/cdns3-ti.c | 48 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index c331bcd2faeb..50b38c4b9c87 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -197,6 +197,50 @@ static int cdns_ti_probe(struct platform_device *pdev)
 	return error;
 }
 
+#ifdef CONFIG_PM
+
+static int cdns_ti_suspend(struct device *dev)
+{
+	struct cdns_ti *data = dev_get_drvdata(dev);
+
+	if (!of_device_is_compatible(dev_of_node(dev), "ti,j7200-usb"))
+		return 0;
+
+	pm_runtime_put_sync(data->dev);
+
+	return 0;
+}
+
+static int cdns_ti_resume(struct device *dev)
+{
+	struct cdns_ti *data = dev_get_drvdata(dev);
+	int ret;
+
+	if (!of_device_is_compatible(dev_of_node(dev), "ti,j7200-usb"))
+		return 0;
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "pm_runtime_get_sync failed: %d\n", ret);
+		goto err;
+	}
+
+	cdns_ti_init_hw(data);
+
+	return 0;
+
+err:
+	pm_runtime_put_sync(data->dev);
+	pm_runtime_disable(data->dev);
+	return ret;
+}
+
+static const struct dev_pm_ops cdns_ti_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(cdns_ti_suspend, cdns_ti_resume)
+};
+
+#endif /* CONFIG_PM */
+
 static int cdns_ti_remove_core(struct device *dev, void *c)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -218,6 +262,7 @@ static void cdns_ti_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id cdns_ti_of_match[] = {
+	{ .compatible = "ti,j7200-usb", },
 	{ .compatible = "ti,j721e-usb", },
 	{ .compatible = "ti,am64-usb", },
 	{},
@@ -228,8 +273,9 @@ static struct platform_driver cdns_ti_driver = {
 	.probe		= cdns_ti_probe,
 	.remove_new	= cdns_ti_remove,
 	.driver		= {
-		.name	= "cdns3-ti",
+		.name		= "cdns3-ti",
 		.of_match_table	= cdns_ti_of_match,
+		.pm		= pm_ptr(&cdns_ti_pm_ops),
 	},
 };
 

-- 
2.41.0

