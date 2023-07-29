Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D40767A2F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjG2AxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjG2AxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:53:05 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066D449FE;
        Fri, 28 Jul 2023 17:52:39 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bbc06f830aso17411795ad.0;
        Fri, 28 Jul 2023 17:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591901; x=1691196701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UTNSsrWWKR414OaN79464JHIccJK6ZuB40p7bHAcZ8=;
        b=hW51BN/P4IpHkVxw8Wi6tqtee6bd7dz3hngx4W5l++mdPiioUYXOqQUqQk1TLTBuaE
         DNw8QIShKcYJ6BQH9Gvi+RXAzAAv0jq+O+UUF3PP5Vyf6n3u1HX5D547I/dEbi0TKbfs
         D47ScINacoknwCdBf2z2EkY8zBMj5q6vIT11AWjDWT883RdwkybMgoFG6DzrZB4tUQWe
         wtFWasZMl0wlnzW5z+8tD6wdlo9g8MqYaUDl6gDVSIMgTt6c8U868TVSlA02nc3XfES/
         Q2ZjXRo69KxnPdvNfnYfLhtfw4dfa9QfteH+9XnqTBOm7aK6UzkOWiHJk2CXpQQGhPIC
         m0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591901; x=1691196701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UTNSsrWWKR414OaN79464JHIccJK6ZuB40p7bHAcZ8=;
        b=TAjHCdgx77EXd3LCZxibucwrBmXb0x0Kps5s8qe4dGCljio6uVMvFzIcxwMTXvLdnt
         +gCU29bds8lIFW09oJn8r/yv6QFW5wmk4Ds08y8dtqJLiFuWiXpnJypti1zTRLBuMIYh
         VnQbYFRlrl8Nl+/Nyt9+0j0sJPVAOZrL12qQDCOWYKSSNVJuTBdyIEqC6vZkQL3YhrjM
         76nAt+7R6GhWEXZYgmyiHt3bT77A9SxDp2x78/uysjsg4e6Gk3LMSY4J0BwAaDGIpLOI
         CKtQpEILC+TMDYWShGOiPMZ8hWFIDG0iwxWOPFobGBwHTOltWEXd9yCz6xtIr020YalC
         uHAQ==
X-Gm-Message-State: ABy/qLZVy6VH0uGQtHJaXGcqSLe3AiOtQDfM1U8d+7L60ko8tpMxH3gn
        iPTDhKcbkgs41Fr7coHMYw8gm97gNv4=
X-Google-Smtp-Source: APBJJlGDfrW38jnbORBCtKu41B/I3PZ5cujziWau8w95X6AvhUUV1TCWHR8ilPc2QEiIeUyGDTeoZw==
X-Received: by 2002:a17:903:2281:b0:1b8:c63:4b79 with SMTP id b1-20020a170903228100b001b80c634b79mr4572402plh.19.1690591901385;
        Fri, 28 Jul 2023 17:51:41 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:41 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 06/22] Input: ad7879 - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:15 -0700
Message-ID: <20230729005133.1095051-6-dmitry.torokhov@gmail.com>
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
 drivers/input/touchscreen/ad7879-i2c.c |  7 ++++---
 drivers/input/touchscreen/ad7879-spi.c |  7 ++++---
 drivers/input/touchscreen/ad7879.c     | 10 ++++++----
 drivers/input/touchscreen/ad7879.h     |  3 +++
 4 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
index feaa6f8b01ed..5c094ab74698 100644
--- a/drivers/input/touchscreen/ad7879-i2c.c
+++ b/drivers/input/touchscreen/ad7879-i2c.c
@@ -58,9 +58,10 @@ MODULE_DEVICE_TABLE(of, ad7879_i2c_dt_ids);
 
 static struct i2c_driver ad7879_i2c_driver = {
 	.driver = {
-		.name	= "ad7879",
-		.pm	= &ad7879_pm_ops,
-		.of_match_table = of_match_ptr(ad7879_i2c_dt_ids),
+		.name		= "ad7879",
+		.dev_groups	= ad7879_groups,
+		.pm		= &ad7879_pm_ops,
+		.of_match_table	= of_match_ptr(ad7879_i2c_dt_ids),
 	},
 	.probe		= ad7879_i2c_probe,
 	.id_table	= ad7879_id,
diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
index 50e889846800..064968fe57cf 100644
--- a/drivers/input/touchscreen/ad7879-spi.c
+++ b/drivers/input/touchscreen/ad7879-spi.c
@@ -56,9 +56,10 @@ MODULE_DEVICE_TABLE(of, ad7879_spi_dt_ids);
 
 static struct spi_driver ad7879_spi_driver = {
 	.driver = {
-		.name	= "ad7879",
-		.pm	= &ad7879_pm_ops,
-		.of_match_table = of_match_ptr(ad7879_spi_dt_ids),
+		.name		= "ad7879",
+		.dev_groups	= ad7879_groups,
+		.pm		= &ad7879_pm_ops,
+		.of_match_table	= of_match_ptr(ad7879_spi_dt_ids),
 	},
 	.probe		= ad7879_spi_probe,
 };
diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index e850853328f1..e5d69bf2276e 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -391,6 +391,12 @@ static const struct attribute_group ad7879_attr_group = {
 	.attrs = ad7879_attributes,
 };
 
+const struct attribute_group *ad7879_groups[] = {
+	&ad7879_attr_group,
+	NULL
+};
+EXPORT_SYMBOL_GPL(ad7879_groups);
+
 #ifdef CONFIG_GPIOLIB
 static int ad7879_gpio_direction_input(struct gpio_chip *chip,
 					unsigned gpio)
@@ -612,10 +618,6 @@ int ad7879_probe(struct device *dev, struct regmap *regmap,
 
 	__ad7879_disable(ts);
 
-	err = devm_device_add_group(dev, &ad7879_attr_group);
-	if (err)
-		return err;
-
 	err = ad7879_gpio_add(ts);
 	if (err)
 		return err;
diff --git a/drivers/input/touchscreen/ad7879.h b/drivers/input/touchscreen/ad7879.h
index ae8aa1428e56..d71a8e787290 100644
--- a/drivers/input/touchscreen/ad7879.h
+++ b/drivers/input/touchscreen/ad7879.h
@@ -8,11 +8,14 @@
 #ifndef _AD7879_H_
 #define _AD7879_H_
 
+#include <linux/pm.h>
 #include <linux/types.h>
 
+struct attribute_group;
 struct device;
 struct regmap;
 
+extern const struct attribute_group *ad7879_groups[];
 extern const struct dev_pm_ops ad7879_pm_ops;
 
 int ad7879_probe(struct device *dev, struct regmap *regmap,
-- 
2.41.0.487.g6d72f3e995-goog

