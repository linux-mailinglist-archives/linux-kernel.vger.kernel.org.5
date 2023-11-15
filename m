Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BA57ED53C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjKOVC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343823AbjKOVBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:01:54 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8BC199B;
        Wed, 15 Nov 2023 13:01:27 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-586f68b78ddso55068eaf.2;
        Wed, 15 Nov 2023 13:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700082086; x=1700686886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K03zmxasEq9FnnjGJz4u1w2YR1+3fOaUQl9N4LzfX7o=;
        b=JcBbdeVQh1houhbecenMGnI/oO0qUaxntpyhn7QkCg/n8vzYjbgwojFOXHgjtSFzlg
         vUHXyB8zC3uNQMcgSjfy/c7VoTZqwjyqfZjxQkFS9akr1QYVdMyxLrzxIqy4QUzabgJb
         PUEHQSCRiXlTkQ555Qk8MVt+8e6Ve2Jqk9pekdOLhuk0xLAMPgvNg53A9Vm6Q54OuVmY
         upYyKvsATf7ylttGRqqAUjXFeKEcrheaEBnL+HrZV9YX59Ux4m9UBo6DBazKKSqWTrCE
         ymObh9hpTfkuP+RJ6rLahAELk+hzjh7R+EW2bKIF5Jax32NOspnJGzH31y/tbYhykZtk
         sBtw==
X-Gm-Message-State: AOJu0YzqtlJQKXAULfdSjbkHnSX2i1S3SHro9tjT/9pHwfO1Iog6D8tb
        qw2AQQwoYWsDcPJ8Ji3Drg==
X-Google-Smtp-Source: AGHT+IHMGTv0+6qVwF7GC4xCcEfHpb+VL7SmBzNPo8jG4WM3SE4T2Y5RwR9z/bwlw/l/h6yWQYLSGA==
X-Received: by 2002:a4a:7648:0:b0:581:dd3e:dbce with SMTP id w8-20020a4a7648000000b00581dd3edbcemr12906231ooe.0.1700082086640;
        Wed, 15 Nov 2023 13:01:26 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 129-20020a4a0687000000b00587947707aasm819964ooj.4.2023.11.15.13.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:01:26 -0800 (PST)
Received: (nullmailer pid 3739323 invoked by uid 1000);
        Wed, 15 Nov 2023 21:01:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [RESEND PATCH] pwm: Use device_get_match_data()
Date:   Wed, 15 Nov 2023 15:01:20 -0600
Message-ID: <20231115210121.3738487-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

