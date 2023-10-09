Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6E47BEC74
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378633AbjJIVOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378151AbjJIVOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:14:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF6792;
        Mon,  9 Oct 2023 14:14:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C614AC433C7;
        Mon,  9 Oct 2023 21:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886048;
        bh=QXfTbUIE2k0njqWEXV6u+Uau+22OTmsX1QDZDU0Eblo=;
        h=From:To:Cc:Subject:Date:From;
        b=OyH2jxz1nCo/jE1otcDSKiA6qL9gTi8SkQDl8sqMkn4hrCaRkJkH97HEw2mxNF5nd
         E/in8QtZc4lPIVbSsE2FNI2MyOegPEYXVOXC+bAERICmvR2ZaS/DSCqVlfRO4t9l8c
         TC4sC3AZDWJZh5AcU0m4vQUnycuQ3o55+8ia9+PxJPhAWvFEcIfiu/ivErcCFgfpo+
         b4u+pmi0h7cffsZOHUkZAyriuiScusDCX3SQzE98bG5NgVA59saJx4ypvtTRo4AYWm
         0vAqG/uU8D2Fk92FpGuOJNfjbZnp9R0C9WUBLCImQ99/eoz1TeSAvAsfaI3YyosfN2
         KZ8FQVu8FybwA==
Received: (nullmailer pid 3245125 invoked by uid 1000);
        Mon, 09 Oct 2023 21:14:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: ir-hix5hd2: Use device_get_match_data()
Date:   Mon,  9 Oct 2023 16:13:31 -0500
Message-ID: <20231009211356.3242037-1-robh@kernel.org>
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
 drivers/media/rc/ir-hix5hd2.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/rc/ir-hix5hd2.c b/drivers/media/rc/ir-hix5hd2.c
index 0034f615b466..de5bb9a08ea4 100644
--- a/drivers/media/rc/ir-hix5hd2.c
+++ b/drivers/media/rc/ir-hix5hd2.c
@@ -9,7 +9,9 @@
 #include <linux/interrupt.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <media/rc-core.h>
 
@@ -251,7 +253,6 @@ static int hix5hd2_ir_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct hix5hd2_ir_priv *priv;
 	struct device_node *node = pdev->dev.of_node;
-	const struct of_device_id *of_id;
 	const char *map_name;
 	int ret;
 
@@ -259,12 +260,11 @@ static int hix5hd2_ir_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	of_id = of_match_device(hix5hd2_ir_table, dev);
-	if (!of_id) {
+	priv->socdata = device_get_match_data(dev);
+	if (!priv->socdata) {
 		dev_err(dev, "Unable to initialize IR data\n");
 		return -ENODEV;
 	}
-	priv->socdata = of_id->data;
 
 	priv->regmap = syscon_regmap_lookup_by_phandle(node,
 						       "hisilicon,power-syscon");
-- 
2.42.0

