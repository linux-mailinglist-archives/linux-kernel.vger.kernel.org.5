Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E847BC176
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjJFVo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbjJFVoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:44:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11378F9;
        Fri,  6 Oct 2023 14:44:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A98C433C8;
        Fri,  6 Oct 2023 21:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696628688;
        bh=mu/lIRhJDrCa7DuHJvaUMHjw/zy7mbs5KoPEOxnbT0k=;
        h=From:To:Cc:Subject:Date:From;
        b=TSBhAOcJ40um/DnGW6VF0LUGqiQWQtk5DVI0qLo0afN46m9Xmuh4QXssoH8qNRmER
         qXE953NsjLMgoaALnMZ/Swe93zYeNA42nsxeSJZEs7y1B6dfpg9J5hdjPgHTLFGUh1
         rHLP3mWhnoHLW3KSB8Ac+rPr528O/+FT2DSjP5Rq8MDmqqlQnxCmV9OhzSs/WKccGS
         akG1DmD1dKVSWmWf9CibKm8RsO/d4dj36xQoSgT1hg5kPq43ISOieD0HCajAujqH2/
         Qejz3uvnqZ+XTFfUuhhMWFhKRa9LE43DKR9O2hDnNlMZ5lZdpECHH4brC6fH+xhLf8
         norMmTCcH1T/A==
Received: (nullmailer pid 339997 invoked by uid 1000);
        Fri, 06 Oct 2023 21:44:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ata: imx: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 16:44:42 -0500
Message-Id: <20231006214442.339890-1-robh@kernel.org>
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
 drivers/ata/ahci_imx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 9fa005965f3b..cb768f66f0a7 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -9,10 +9,11 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/ahci_platform.h>
 #include <linux/gpio/consumer.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/libata.h>
@@ -1050,16 +1051,11 @@ static int imx8_sata_probe(struct device *dev, struct imx_ahci_priv *imxpriv)
 static int imx_ahci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *of_id;
 	struct ahci_host_priv *hpriv;
 	struct imx_ahci_priv *imxpriv;
 	unsigned int reg_val;
 	int ret;
 
-	of_id = of_match_device(imx_ahci_of_match, dev);
-	if (!of_id)
-		return -EINVAL;
-
 	imxpriv = devm_kzalloc(dev, sizeof(*imxpriv), GFP_KERNEL);
 	if (!imxpriv)
 		return -ENOMEM;
@@ -1067,7 +1063,7 @@ static int imx_ahci_probe(struct platform_device *pdev)
 	imxpriv->ahci_pdev = pdev;
 	imxpriv->no_device = false;
 	imxpriv->first_time = true;
-	imxpriv->type = (unsigned long)of_id->data;
+	imxpriv->type = (enum ahci_imx_type)device_get_match_data(dev);
 
 	imxpriv->sata_clk = devm_clk_get(dev, "sata");
 	if (IS_ERR(imxpriv->sata_clk)) {
-- 
2.40.1

