Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52FB7BC16E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbjJFVoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjJFVoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:44:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80535CA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:44:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99E6C433C8;
        Fri,  6 Oct 2023 21:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696628660;
        bh=DmsXWqZVA04oJx2004Lm5q2na1hsfJMHrU27+MQlR4Q=;
        h=From:To:Cc:Subject:Date:From;
        b=U68WKfV6UUALEGmGiUv81LMjFzEKXBUtsMinrOJe+TxRrdOStYpGbnAWdOVO27VvX
         wlLCrzV6Ak7Yh+xYaMRS/tnNc8J7anypiNC5JWDxcMK9PLqHD9yjTeXYm35JDIkkpb
         DFAtZ/X1CC+qghEaa6kBZU1SsB8SoLNiQ6hYj5ewJsfDwlHt+PbtDdifiI23Py+UAE
         Qw8Y7OhkRyI2fame18DqMYCXIOBh/m+UH2toHukBFBBgwcuJWtOakd5T1bEk9snX4w
         rt7kAl3jFR5xwUXm5EIqvgoRCLThYJaoizn1Rmj9Zv+sqCJWbuQwuok6yw3P6N9F14
         gf14CDK9X4LwA==
Received: (nullmailer pid 339385 invoked by uid 1000);
        Fri, 06 Oct 2023 21:44:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Paul Burton <paulburton@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] auxdisplay: img-ascii-lcd: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 16:44:12 -0500
Message-Id: <20231006214412.339250-1-robh@kernel.org>
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
 drivers/auxdisplay/img-ascii-lcd.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
index fa23e415f260..c16a14becdfc 100644
--- a/drivers/auxdisplay/img-ascii-lcd.c
+++ b/drivers/auxdisplay/img-ascii-lcd.c
@@ -8,9 +8,9 @@
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
@@ -225,17 +225,12 @@ MODULE_DEVICE_TABLE(of, img_ascii_lcd_matches);
  */
 static int img_ascii_lcd_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	const struct img_ascii_lcd_config *cfg;
 	struct device *dev = &pdev->dev;
 	struct img_ascii_lcd_ctx *ctx;
 	int err;
 
-	match = of_match_device(img_ascii_lcd_matches, dev);
-	if (!match)
-		return -ENODEV;
-
-	cfg = match->data;
+	cfg = device_get_match_data(&pdev->dev);
 	ctx = devm_kzalloc(dev, sizeof(*ctx) + cfg->num_chars, GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
-- 
2.40.1

