Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474A47ED43E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344586AbjKOU53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjKOU5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:57:16 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B09BC;
        Wed, 15 Nov 2023 12:57:13 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3b2f28caab9so63468b6e.1;
        Wed, 15 Nov 2023 12:57:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700081832; x=1700686632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwRLiSsmTQrLmr9QhLtbXwPVmZP/s3+9L17ecEUsq1Y=;
        b=byBXX3u+f69taHF+HfeH8xG+fvcZnftl8MhDY4qbFrSwP74gqeqC6+aJ/qhTRXkjJi
         VVLrAinLelY9/y6RoHJFQz8ndeCKIBqPXecYQ9wRiS+zS3kMxIKaq+akH0jsVVn/IYi0
         2rukSCt7rESTxqag3aQJMK63aJ9CxqBqhWp3uW58gO3h/pLXphiVoxztNztHvH6kyGk/
         QuxVQ3eCWnSjNzzTKu983BehUzEKpAAj28F1USu06kq67Xp9n3uIWN6viikXoTfEUUXR
         7WCNBUYOSOAesNWbzAnaQLP4bjs8y+jwEsx9I+yxz8KYrNcx6E/2qboGmHjmHArMNzzg
         N29w==
X-Gm-Message-State: AOJu0YzX55rHjhP12IgumYCRcs6E8uu55FEU3TTzyncay8zcBsxz7jC8
        qdiVVFm/5LkUro+b5fprJA==
X-Google-Smtp-Source: AGHT+IHxrHibQfLM7CBMaWfLrz9NFUZFSl1nKdReprme+Z5iEL8w5fIZuYi3BZGDlVz5bAJN2sjRQg==
X-Received: by 2002:a05:6808:2191:b0:3ae:16b6:6338 with SMTP id be17-20020a056808219100b003ae16b66338mr19677598oib.3.1700081832166;
        Wed, 15 Nov 2023 12:57:12 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k20-20020a544694000000b003af5d7d9f3bsm1607934oic.4.2023.11.15.12.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 12:57:10 -0800 (PST)
Received: (nullmailer pid 3730620 invoked by uid 1000);
        Wed, 15 Nov 2023 20:57:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Zev Weiss <zev@bewilderbeest.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] hwmon: nct6775-i2c: Use i2c_get_match_data()
Date:   Wed, 15 Nov 2023 14:57:01 -0600
Message-ID: <20231115205703.3730448-2-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115205703.3730448-1-robh@kernel.org>
References: <20231115205703.3730448-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred i2c_get_match_data() instead of of_match_device() and
i2c_match_id() to get the driver match data. With this, adjust the
includes to explicitly include the correct headers.

Adjust the 'kinds' enum to not use 0, so that no match data can be
distinguished from a valid enum value.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Split up per driver
---
 drivers/hwmon/nct6775-i2c.c | 14 ++------------
 drivers/hwmon/nct6775.h     |  2 +-
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/nct6775-i2c.c b/drivers/hwmon/nct6775-i2c.c
index 87a4fc78c571..63b669d511f4 100644
--- a/drivers/hwmon/nct6775-i2c.c
+++ b/drivers/hwmon/nct6775-i2c.c
@@ -21,7 +21,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include "nct6775.h"
 
@@ -155,23 +155,13 @@ static const struct regmap_config nct6775_i2c_regmap_config = {
 static int nct6775_i2c_probe(struct i2c_client *client)
 {
 	struct nct6775_data *data;
-	const struct of_device_id *of_id;
-	const struct i2c_device_id *i2c_id;
 	struct device *dev = &client->dev;
 
-	of_id = of_match_device(nct6775_i2c_of_match, dev);
-	i2c_id = i2c_match_id(nct6775_i2c_id, client);
-
-	if (of_id && (unsigned long)of_id->data != i2c_id->driver_data)
-		dev_notice(dev, "Device mismatch: %s in device tree, %s detected\n",
-			   of_id->name, i2c_id->name);
-
 	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->kind = i2c_id->driver_data;
-
+	data->kind = (enum kinds)i2c_get_match_data(client);
 	data->read_only = true;
 	data->driver_data = client;
 	data->driver_init = nct6775_i2c_probe_init;
diff --git a/drivers/hwmon/nct6775.h b/drivers/hwmon/nct6775.h
index 296eff99d003..d31e7a030216 100644
--- a/drivers/hwmon/nct6775.h
+++ b/drivers/hwmon/nct6775.h
@@ -4,7 +4,7 @@
 
 #include <linux/types.h>
 
-enum kinds { nct6106, nct6116, nct6775, nct6776, nct6779, nct6791, nct6792,
+enum kinds { nct6106 = 1, nct6116, nct6775, nct6776, nct6779, nct6791, nct6792,
 	     nct6793, nct6795, nct6796, nct6797, nct6798, nct6799 };
 enum pwm_enable { off, manual, thermal_cruise, speed_cruise, sf3, sf4 };
 
-- 
2.42.0

