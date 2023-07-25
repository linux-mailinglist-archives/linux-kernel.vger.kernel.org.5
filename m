Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937797618F8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjGYMyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjGYMyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:54:38 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F3419AD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:54:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso7822058a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1690289673; x=1690894473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaZID9rRMTJ2nmqmshf6LreUn/mdy/eKyS3ZjSfkijA=;
        b=QSQREnbbcdT7o53ADS7jLKT3qpIMWfe8RoV5g6qY46jVm0R51waOSQqdRJg0ApFLMm
         SQYG6EayMQTwqlWpmU/lCKee37xrNSTeHtIpw9NCMV4SATK1rkGVEPq8k/5tsjY3gpOf
         FlVysqLRBLFbcyquWxI4A695NSz8VIYItgUMNqAFzOsBu5ecSTzuE7/S1BKtb7ifrwmk
         uBpYecLbeVg9ZYL3632aUsWqOn8nxHMLI3mA7YztEdx8GJ3oSL7MFd6WvZgegSVn9QKZ
         Grj7heTImBj3d7hyFxKbpD0/MEJz3K0Fgh37yVJj1Se8w4MmuzOqKM6MRf4ViOM5aRpL
         Vdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690289673; x=1690894473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaZID9rRMTJ2nmqmshf6LreUn/mdy/eKyS3ZjSfkijA=;
        b=SSS6OUG7mywj1bJ8GtvvJzj1R/BQKe+hAeUPyngqvV+VwEUwjJO9W2ZPvd8As/s8AM
         C2IubvhW6AupM7ffTc0CjYKXh+gZImYCjVP4yWUi2l5bVNZnuU9s1HpKCkEqKvCIVSlI
         Eo8G/h5YMMWQu2l7e1XY2cXeG+kFGs0FEnomECFz2t41TFViIR/OXnkbZ4ffaYoWl5Im
         D1vLXtUNhFttlbvOrcyJh5pv2C7SWam52E+ih6Cjjp3joPl1t9i1G1QBNmGEYhXBZ7eO
         OaWa4HGKVytXr1c+24WZCjEt8T6cGhnvzCOS7PwsxKBTCXNnXtJrJOO4TiEgUNLKCA4N
         9XGQ==
X-Gm-Message-State: ABy/qLY1QQjVLFjTnIFeMMrHr04aWg++ZPFmvsc+MoyAUejkcfNQ7PFE
        ehfHXEq9Y5ed9NSHnvQWrLncUX/Rj525JhUvDm0B0ZXn
X-Google-Smtp-Source: APBJJlFJOFr4Uo7wpRe7n2jDpOndOddkIBxsVclB5xlern0T4yJlEHsPydZm0qieojTKD5j5MFRMyw==
X-Received: by 2002:aa7:d354:0:b0:522:2b76:1985 with SMTP id m20-20020aa7d354000000b005222b761985mr4711832edr.2.1690289673250;
        Tue, 25 Jul 2023 05:54:33 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id u11-20020a056402064b00b0051dfa2e30b2sm7516682edx.9.2023.07.25.05.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:54:32 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] pmbus_core: Fix NULL pointer dereference
Date:   Tue, 25 Jul 2023 14:54:26 +0200
Message-ID: <20230725125428.3966803-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725125428.3966803-1-Naresh.Solanki@9elements.com>
References: <20230725125428.3966803-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Pass i2c_client to _pmbus_is_enabled to drop the assumption
that a regulator device is passed in.

This will fix the issue of a NULL pointer dereference when called from
_pmbus_get_flags.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
Changes in V2:
- Fix build error.
---
 drivers/hwmon/pmbus/pmbus_core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 42fb7286805b..30aeb59062a5 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2745,9 +2745,8 @@ static const struct pmbus_status_category __maybe_unused pmbus_status_flag_map[]
 	},
 };
 
-static int _pmbus_is_enabled(struct device *dev, u8 page)
+static int _pmbus_is_enabled(struct i2c_client *client, u8 page)
 {
-	struct i2c_client *client = to_i2c_client(dev->parent);
 	int ret;
 
 	ret = _pmbus_read_byte_data(client, page, PMBUS_OPERATION);
@@ -2758,14 +2757,13 @@ static int _pmbus_is_enabled(struct device *dev, u8 page)
 	return !!(ret & PB_OPERATION_CONTROL_ON);
 }
 
-static int __maybe_unused pmbus_is_enabled(struct device *dev, u8 page)
+static int __maybe_unused pmbus_is_enabled(struct i2c_client *client, u8 page)
 {
-	struct i2c_client *client = to_i2c_client(dev->parent);
 	struct pmbus_data *data = i2c_get_clientdata(client);
 	int ret;
 
 	mutex_lock(&data->update_lock);
-	ret = _pmbus_is_enabled(dev, page);
+	ret = _pmbus_is_enabled(client, page);
 	mutex_unlock(&data->update_lock);
 
 	return ret;
@@ -2844,7 +2842,7 @@ static int _pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flag
 	if (status < 0)
 		return status;
 
-	if (_pmbus_is_enabled(dev, page)) {
+	if (_pmbus_is_enabled(client, page)) {
 		if (status & PB_STATUS_OFF) {
 			*flags |= REGULATOR_ERROR_FAIL;
 			*event |= REGULATOR_EVENT_FAIL;
@@ -2898,7 +2896,10 @@ static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsi
 #if IS_ENABLED(CONFIG_REGULATOR)
 static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
 {
-	return pmbus_is_enabled(rdev_get_dev(rdev), rdev_get_id(rdev));
+	struct device *dev = rdev_get_dev(rdev);
+	struct i2c_client *client = to_i2c_client(dev->parent);
+
+	return pmbus_is_enabled(client, rdev_get_id(rdev));
 }
 
 static int _pmbus_regulator_on_off(struct regulator_dev *rdev, bool enable)
-- 
2.41.0

