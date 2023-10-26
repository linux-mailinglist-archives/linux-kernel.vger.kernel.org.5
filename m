Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD457D8941
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjJZTzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZTzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:55:23 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81C4B9;
        Thu, 26 Oct 2023 12:55:20 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ce291b5df9so710134a34.2;
        Thu, 26 Oct 2023 12:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698350120; x=1698954920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9SEmh3Ti6BweKuBsiI0z3j9kO6wl5de7iuUaFpsagQ=;
        b=qID3Hdr57cb9Nur07Oa3maNzD7TzNRE4oVUrkozYxDnoQs6++5KaPlKL9IJEAxZc4l
         c0KVkASptzjCFGNlKkvgPB4MiIQNCN+yxDkaKr/ezK8zZlEfQgymGyt8LNW/YehLv4IG
         nXSfjlQmMAy0VKf6FTD6/L/MA8mB8CWHoeWbOyLZf4Vf7Jgh5+7xOExJiL3I/SduRLfG
         dkuO1CMJAgughUgHooAwKir9hOieqZnNyBQziR5IKNIhNrSihlPeLZb0Jq7WXh3SL7BB
         iQwuNOXSTJqSJainResUKCXb2JhFWZ++TFvehZoOYviKwdD3nY4SDdqxFeCIS0cRpP0P
         swiA==
X-Gm-Message-State: AOJu0YyX3trdKa+XqUxfarLVgAiNr+fefIyIshwnm9CVlCIO1kQWF522
        K9Y8cgkVbuuOaUEROm0GzQ==
X-Google-Smtp-Source: AGHT+IGFKWUSjFLRB5b0vYmkzpMNPEPkC3HBf+pN5hkdBt1cX6fzmcK5kAGnnfuiZjJO1Sorv/ZI+Q==
X-Received: by 2002:a05:6830:314c:b0:6b8:9a3a:ea12 with SMTP id c12-20020a056830314c00b006b89a3aea12mr545041ots.12.1698350119860;
        Thu, 26 Oct 2023 12:55:19 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d64-20020a4a5243000000b005737ca61829sm5503oob.13.2023.10.26.12.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 12:55:19 -0700 (PDT)
Received: (nullmailer pid 69534 invoked by uid 1000);
        Thu, 26 Oct 2023 19:55:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2] pwm: Use device_get_match_data()
Date:   Thu, 26 Oct 2023 14:54:17 -0500
Message-ID: <20231026195417.68090-2-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

As these drivers only do DT based matching, of_match_device() will never
return NULL if we've gotten to probe(). Therefore, the NULL check and
error returns can be dropped.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Add to commit message about of_match_device() error checking

 drivers/pwm/pwm-img.c      | 8 ++------
 drivers/pwm/pwm-rockchip.c | 9 ++-------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 116fa060e302..0d218c0b690e 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -13,9 +13,9 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -260,7 +260,6 @@ static int img_pwm_probe(struct platform_device *pdev)
 	u64 val;
 	unsigned long clk_rate;
 	struct img_pwm_chip *imgchip;
-	const struct of_device_id *of_dev_id;
 
 	imgchip = devm_kzalloc(&pdev->dev, sizeof(*imgchip), GFP_KERNEL);
 	if (!imgchip)
@@ -272,10 +271,7 @@ static int img_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(imgchip->base))
 		return PTR_ERR(imgchip->base);
 
-	of_dev_id = of_match_device(img_pwm_of_match, &pdev->dev);
-	if (!of_dev_id)
-		return -ENODEV;
-	imgchip->data = of_dev_id->data;
+	imgchip->data = device_get_match_data(&pdev->dev);
 
 	imgchip->periph_regs = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
 							       "img,cr-periph");
diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index cce4381e188a..a7c647e37837 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -10,8 +10,8 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/pwm.h>
 #include <linux/time.h>
 
@@ -296,16 +296,11 @@ MODULE_DEVICE_TABLE(of, rockchip_pwm_dt_ids);
 
 static int rockchip_pwm_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *id;
 	struct rockchip_pwm_chip *pc;
 	u32 enable_conf, ctrl;
 	bool enabled;
 	int ret, count;
 
-	id = of_match_device(rockchip_pwm_dt_ids, &pdev->dev);
-	if (!id)
-		return -EINVAL;
-
 	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
 	if (!pc)
 		return -ENOMEM;
@@ -344,7 +339,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pc);
 
-	pc->data = id->data;
+	pc->data = device_get_match_data(&pdev->dev);
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &rockchip_pwm_ops;
 	pc->chip.npwm = 1;
-- 
2.42.0

