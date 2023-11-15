Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63607ED43B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbjKOU5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjKOU5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:57:15 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2C7198;
        Wed, 15 Nov 2023 12:57:10 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6cd09663b1cso42391a34.3;
        Wed, 15 Nov 2023 12:57:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700081830; x=1700686630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yn8cWgc0LR3eqt+tX9p4U9PZWhRMqUpEjC58C6kq9fE=;
        b=B/g6bTNulvrF4D1C+on42Mpg0ksJJv4fQ7mMXVN8wFA+ixA2t6Pu6GlKQhgF+913zX
         qHkfBva41hfWQElalsz1zX2SaiSU89HA+Hh4vTb+c6rvxdQociP042n9JiKdg+VJsdCK
         q/rI4hY2FGK9vvo20LigbPLN40Em0CAP//J9xWUGufO4drep0BKrsKOcOXjHvCkZqOQV
         DtFsMhay0OEsNdcCVBGMTnDLTkZsAhoT99c93bF2HtxFbyAQjl3lvg/Zfqa7o+pAyI4S
         CP/wvbtwXGOMeBnfI9vLkNXn0iM8qQFcaq+dAivPzGRd/wxQRfMI3t4dG0ZpdjCKoNG4
         uu0A==
X-Gm-Message-State: AOJu0YxMSmjRJkEd5+Ep3j1WD0KODiEN1v1G8CxMKiWxhDXX2nCi9xZF
        94herRwhxZP1u5o1/XZvnNayDYFpXQ==
X-Google-Smtp-Source: AGHT+IH9v+8lfC+47xxhorj2KGtbG1hK/QjCQLqm2wzXxqpzFQA6ulmJcmQteJ78UVZZZygsXL/8ew==
X-Received: by 2002:a9d:6553:0:b0:6d6:45f1:d7b4 with SMTP id q19-20020a9d6553000000b006d645f1d7b4mr6684680otl.35.1700081829927;
        Wed, 15 Nov 2023 12:57:09 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t10-20020a05683014ca00b006ce46212341sm689671otq.54.2023.11.15.12.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 12:57:08 -0800 (PST)
Received: (nullmailer pid 3730642 invoked by uid 1000);
        Wed, 15 Nov 2023 20:57:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] hwmon: lm25066: Use i2c_get_match_data()
Date:   Wed, 15 Nov 2023 14:57:02 -0600
Message-ID: <20231115205703.3730448-3-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115205703.3730448-1-robh@kernel.org>
References: <20231115205703.3730448-1-robh@kernel.org>
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

Use preferred i2c_get_match_data() instead of of_match_device() and
i2c_match_id() to get the driver match data. With this, adjust the
includes to explicitly include the correct headers.

Adjust the 'chips' enum to not use 0, so that no match data can be
distinguished from a valid enum value.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Split up per driver
---
 drivers/hwmon/pmbus/lm25066.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index 929fa6d34efd..bd43457094a6 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -14,10 +14,10 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/log2.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include "pmbus.h"
 
-enum chips { lm25056, lm25066, lm5064, lm5066, lm5066i };
+enum chips { lm25056 = 1, lm25066, lm5064, lm5066, lm5066i };
 
 #define LM25066_READ_VAUX		0xd0
 #define LM25066_MFR_READ_IIN		0xd1
@@ -468,8 +468,6 @@ static int lm25066_probe(struct i2c_client *client)
 	struct lm25066_data *data;
 	struct pmbus_driver_info *info;
 	const struct __coeff *coeff;
-	const struct of_device_id *of_id;
-	const struct i2c_device_id *i2c_id;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA))
@@ -484,14 +482,8 @@ static int lm25066_probe(struct i2c_client *client)
 	if (config < 0)
 		return config;
 
-	i2c_id = i2c_match_id(lm25066_id, client);
+	data->id = (enum chips)i2c_get_match_data(client);
 
-	of_id = of_match_device(lm25066_of_match, &client->dev);
-	if (of_id && (unsigned long)of_id->data != i2c_id->driver_data)
-		dev_notice(&client->dev, "Device mismatch: %s in device tree, %s detected\n",
-			   of_id->name, i2c_id->name);
-
-	data->id = i2c_id->driver_data;
 	info = &data->info;
 
 	info->pages = 1;
-- 
2.42.0

