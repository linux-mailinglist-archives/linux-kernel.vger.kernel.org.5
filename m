Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E477908AD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 18:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjIBQ0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 12:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjIBQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 12:26:44 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACC121B1;
        Sat,  2 Sep 2023 09:26:40 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,222,1688396400"; 
   d="scan'208";a="174798223"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 03 Sep 2023 01:26:38 +0900
Received: from localhost.localdomain (unknown [10.226.92.16])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 33CA840071F9;
        Sun,  3 Sep 2023 01:26:35 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: [PATCH] iio: adc: ti-adc081c: Simplify probe()
Date:   Sat,  2 Sep 2023 17:26:33 +0100
Message-Id: <20230902162633.50546-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simpilfy probe() by replacing of_device_get_match_data() and id lookup for
retrieving match data by using i2c_get_match_data() by making similar
OF/I2C/ACPI match tables.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/iio/adc/ti-adc081c.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index 50c450e7a55f..6c2cb3dabbbf 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -154,7 +154,6 @@ static void adc081c_reg_disable(void *reg)
 
 static int adc081c_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct iio_dev *iio;
 	struct adc081c *adc;
 	const struct adcxx1c_model *model;
@@ -163,10 +162,7 @@ static int adc081c_probe(struct i2c_client *client)
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
 		return -EOPNOTSUPP;
 
-	if (dev_fwnode(&client->dev))
-		model = device_get_match_data(&client->dev);
-	else
-		model = &adcxx1c_models[id->driver_data];
+	model = i2c_get_match_data(client);
 
 	iio = devm_iio_device_alloc(&client->dev, sizeof(*adc));
 	if (!iio)
@@ -207,9 +203,9 @@ static int adc081c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adc081c_id[] = {
-	{ "adc081c", ADC081C },
-	{ "adc101c", ADC101C },
-	{ "adc121c", ADC121C },
+	{ "adc081c", (kernel_ulong_t)&adcxx1c_models[ADC081C] },
+	{ "adc101c", (kernel_ulong_t)&adcxx1c_models[ADC101C] },
+	{ "adc121c", (kernel_ulong_t)&adcxx1c_models[ADC121C] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adc081c_id);
-- 
2.25.1

