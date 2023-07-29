Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B270767A47
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbjG2Axr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbjG2AxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:53:15 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70D14497;
        Fri, 28 Jul 2023 17:52:53 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bbd03cb7c1so17286865ad.3;
        Fri, 28 Jul 2023 17:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591914; x=1691196714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQ4walodynTQZ2cRpT+46l/9m01tQFY85mxqkAELUk0=;
        b=PxW5h+UHiJAgT5mVL1r7FP+kz1r31kbrQrjeEGzWCDLF1nMzkUip808BWQMt1/T0Dl
         EfUGkoDB509dUWnsGS5Eu4AhHClMam6J0JuahLDzjLvJHjFoV25Uq7SOEpbeH45TT4zz
         jpKICdT0hubdS/SvmcafjjDDicz9tqOKI/yBA0fsOL4Qh9hYVxbpFGAcFWo+AS0TITY9
         ZlJZsCkgRA2bzw4gHpNvYguetDPTvW7hXACHQ6ny+0kyRpB3hL47TKak7s+CW7yU0S3s
         E32Os4AQbQMSKYCgz2/aC/af/IpAQOrOcdMVBEbpKSUo0zvQAUIKwKHGVqBVKziO+nkl
         B5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591914; x=1691196714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQ4walodynTQZ2cRpT+46l/9m01tQFY85mxqkAELUk0=;
        b=Rwm9OUCMR/LoNfpnXu0PlrEOlg5AB+FnNOAYXf2GxHZcZtC3x/RZellvxnSlkGJMng
         4t7iCkOjWdk8+Y9G7X9IGoWSKf1bOKiP1YS+U50ZSpwj4W6cfOWw+/fglsaIK5P2w1iY
         cqe1MqkX2DPqRUl3WypYjQ8CdaQUnNp2xFe//iFwCiVhqMC2C7hG6HigoAA4+AfNzA77
         9v8VbmQ6RBc4pNrm2Z4J2UmeFFzN+LuTtXHL8HBjw4UWkLAWad/poxUSBwtXxhyhL567
         AXT+cZbWcl+oM6BmbMMH5B5w0ZwyUjaJWoPmDcqzNexWhTinavhaCC4tG9ES1X/bnhvU
         AlQQ==
X-Gm-Message-State: ABy/qLaGEfP7B13RjeEAhKPsaENw8gYey7kq6f12ytGmdisifhvhjB2v
        6t1Ng9oMAVmr1ekwcMuC8IGDtRzlA9A=
X-Google-Smtp-Source: APBJJlGAgg0daMcw3QeKH9sovfKLojIr17N8/uNic838nCLNaWItcrGk5q5glPqeJ+vRYak+jjomVw==
X-Received: by 2002:a17:902:8a85:b0:1b9:e913:b585 with SMTP id p5-20020a1709028a8500b001b9e913b585mr2480753plo.13.1690591913718;
        Fri, 28 Jul 2023 17:51:53 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:53 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 22/22] Input: wdt87xx_i2c - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:31 -0700
Message-ID: <20230729005133.1095051-22-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
References: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of creating driver-specific device attributes with
devm_device_add_group() have device core do this by setting up dev_groups
pointer in the driver structure.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/wdt87xx_i2c.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
index cbc4750c53f9..128341a6696b 100644
--- a/drivers/input/touchscreen/wdt87xx_i2c.c
+++ b/drivers/input/touchscreen/wdt87xx_i2c.c
@@ -944,10 +944,7 @@ static struct attribute *wdt87xx_attrs[] = {
 	&dev_attr_update_fw.attr,
 	NULL
 };
-
-static const struct attribute_group wdt87xx_attr_group = {
-	.attrs = wdt87xx_attrs,
-};
+ATTRIBUTE_GROUPS(wdt87xx);
 
 static void wdt87xx_report_contact(struct input_dev *input,
 				   struct wdt87xx_sys_param *param,
@@ -1104,12 +1101,6 @@ static int wdt87xx_ts_probe(struct i2c_client *client)
 		return error;
 	}
 
-	error = devm_device_add_group(&client->dev, &wdt87xx_attr_group);
-	if (error) {
-		dev_err(&client->dev, "create sysfs failed: %d\n", error);
-		return error;
-	}
-
 	return 0;
 }
 
@@ -1172,8 +1163,9 @@ static struct i2c_driver wdt87xx_driver = {
 	.probe		= wdt87xx_ts_probe,
 	.id_table	= wdt87xx_dev_id,
 	.driver	= {
-		.name	= WDT87XX_NAME,
-		.pm     = pm_sleep_ptr(&wdt87xx_pm_ops),
+		.name = WDT87XX_NAME,
+		.dev_groups = wdt87xx_groups,
+		.pm = pm_sleep_ptr(&wdt87xx_pm_ops),
 		.acpi_match_table = ACPI_PTR(wdt87xx_acpi_id),
 	},
 };
-- 
2.41.0.487.g6d72f3e995-goog

