Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF667F1949
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjKTRGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjKTRGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:06:14 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D28BE;
        Mon, 20 Nov 2023 09:06:10 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 84998E0005;
        Mon, 20 Nov 2023 17:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700499969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQQDcKI+dpqgp9ry2CvzyMUklTw/BkteRs5/KYF01kQ=;
        b=bqXXNWdpzIkufw4/eBc9jm55Uw3x8QkodfspyE1V7Jt+eTNF+aB5jVNMr63m7CJKLPL9V/
        25zj0k/IZmeIlj2rNI9vNOSsHQ1zIsBpG9jm8NDXSlWdiao3FRmKMgZsojofjej2IsLGQn
        4eUhchBUDXdeiYU1BlCqjjwjm3ruF33e6vUAI1nI5MXjt4EX83GhArHCoA4z3MQ0VlRUBY
        7kjlZPtdgMbG7ja9akO+ifJXVaAAzpSF9+3bRs/HDtUD3hXeITuXdenKFW4ESOuknxNc8r
        quOGntw4hqr2MDIbSBQKIhDfbNaVrP6+saU9tTuCjXizS1knc8rGLiNcuN/k6A==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Mon, 20 Nov 2023 18:06:02 +0100
Subject: [PATCH v2 2/7] usb: cdns3-ti: remove runtime PM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231120-j7200-usb-suspend-v2-2-038c7e4a3df4@bootlin.com>
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

The driver does not use RPM. It enables it & gets a reference at probe.
It then undoes that on probe error or at remove.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/cdns3-ti.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index 5945c4b1e11f..dc1594acdcee 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -135,13 +135,6 @@ static int cdns_ti_probe(struct platform_device *pdev)
 
 	rate_code = i;
 
-	pm_runtime_enable(dev);
-	error = pm_runtime_get_sync(dev);
-	if (error < 0) {
-		dev_err(dev, "pm_runtime_get_sync failed: %d\n", error);
-		goto err;
-	}
-
 	/* assert RESET */
 	reg = cdns_ti_readl(data, USBSS_W1);
 	reg &= ~USBSS_W1_PWRUP_RST;
@@ -179,16 +172,10 @@ static int cdns_ti_probe(struct platform_device *pdev)
 	error = of_platform_populate(node, NULL, NULL, dev);
 	if (error) {
 		dev_err(dev, "failed to create children: %d\n", error);
-		goto err;
+		return error;
 	}
 
 	return 0;
-
-err:
-	pm_runtime_put_sync(data->dev);
-	pm_runtime_disable(data->dev);
-
-	return error;
 }
 
 static int cdns_ti_remove_core(struct device *dev, void *c)
@@ -205,8 +192,6 @@ static void cdns_ti_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 
 	device_for_each_child(dev, NULL, cdns_ti_remove_core);
-	pm_runtime_put_sync(dev);
-	pm_runtime_disable(dev);
 
 	platform_set_drvdata(pdev, NULL);
 }

-- 
2.42.0

