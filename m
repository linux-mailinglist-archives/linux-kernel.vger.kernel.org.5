Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC60A790BC3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 13:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbjICL4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 07:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbjICL4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 07:56:05 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B43213D;
        Sun,  3 Sep 2023 04:56:02 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,224,1688396400"; 
   d="scan'208";a="178550475"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2023 20:56:01 +0900
Received: from localhost.localdomain (unknown [10.226.92.30])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id B3CC541C2D99;
        Sun,  3 Sep 2023 20:55:58 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 2/4] iio: dac: mcp4725: Use i2c_get_match_data()
Date:   Sun,  3 Sep 2023 12:55:46 +0100
Message-Id: <20230903115548.59306-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230903115548.59306-1-biju.das.jz@bp.renesas.com>
References: <20230903115548.59306-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add struct mcp4725_chip_info with chan_spec and chip_id variable.
After this simplify probe() by replacing device_get_match_data() and id
lookup for retrieving match data by i2c_get_match_data() by converting
enum->pointer for data in the match table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Added struct mcp4725_chip_info with chan_spec and chip_id variable and
   used that as OF/ID table match data.
v2:
 * New patch
---
 drivers/iio/dac/mcp4725.c | 40 +++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 33a61f65bc25..fe8981ec7923 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -30,6 +30,11 @@
 #define MCP472X_REF_VREF_UNBUFFERED	0x02
 #define MCP472X_REF_VREF_BUFFERED	0x03
 
+struct mcp4725_chip_info {
+	const struct iio_chan_spec *chan_spec;
+	unsigned int chip_id;
+};
+
 struct mcp4725_data {
 	struct i2c_client *client;
 	unsigned ref_mode;
@@ -383,10 +388,10 @@ static int mcp4725_probe_dt(struct device *dev,
 static int mcp4725_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const struct mcp4725_chip_info *info;
 	struct mcp4725_data *data;
 	struct iio_dev *indio_dev;
 	struct mcp4725_platform_data *pdata, pdata_dt;
-	int chip_id;
 	u8 inbuf[4];
 	u8 pd;
 	u8 ref;
@@ -398,10 +403,7 @@ static int mcp4725_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
-	if (dev_fwnode(&client->dev))
-		chip_id = (uintptr_t)device_get_match_data(&client->dev);
-	else
-		chip_id = id->driver_data;
+	info = i2c_get_match_data(client);
 	pdata = dev_get_platdata(&client->dev);
 
 	if (!pdata) {
@@ -414,7 +416,7 @@ static int mcp4725_probe(struct i2c_client *client)
 		pdata = &pdata_dt;
 	}
 
-	if (chip_id == MCP4725 && pdata->use_vref) {
+	if (info->chip_id == MCP4725 && pdata->use_vref) {
 		dev_err(&client->dev,
 			"external reference is unavailable on MCP4725");
 		return -EINVAL;
@@ -455,12 +457,12 @@ static int mcp4725_probe(struct i2c_client *client)
 
 	indio_dev->name = id->name;
 	indio_dev->info = &mcp4725_info;
-	indio_dev->channels = &mcp472x_channel[chip_id];
+	indio_dev->channels = info->chan_spec;
 	indio_dev->num_channels = 1;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* read current DAC value and settings */
-	err = i2c_master_recv(client, inbuf, chip_id == MCP4725 ? 3 : 4);
+	err = i2c_master_recv(client, inbuf, info->chip_id == MCP4725 ? 3 : 4);
 
 	if (err < 0) {
 		dev_err(&client->dev, "failed to read DAC value");
@@ -470,10 +472,10 @@ static int mcp4725_probe(struct i2c_client *client)
 	data->powerdown = pd > 0;
 	data->powerdown_mode = pd ? pd - 1 : 2; /* largest resistor to gnd */
 	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
-	if (chip_id == MCP4726)
+	if (info->chip_id == MCP4726)
 		ref = (inbuf[3] >> 3) & 0x3;
 
-	if (chip_id == MCP4726 && ref != data->ref_mode) {
+	if (info->chip_id == MCP4726 && ref != data->ref_mode) {
 		dev_info(&client->dev,
 			"voltage reference mode differs (conf: %u, eeprom: %u), setting %u",
 			data->ref_mode, ref, data->ref_mode);
@@ -510,9 +512,19 @@ static void mcp4725_remove(struct i2c_client *client)
 	regulator_disable(data->vdd_reg);
 }
 
+static const struct mcp4725_chip_info mcp4725 = {
+	.chan_spec = &mcp472x_channel[MCP4725],
+	.chip_id = MCP4725,
+};
+
+static const struct mcp4725_chip_info mcp4726 = {
+	.chan_spec = &mcp472x_channel[MCP4726],
+	.chip_id = MCP4726,
+};
+
 static const struct i2c_device_id mcp4725_id[] = {
-	{ "mcp4725", MCP4725 },
-	{ "mcp4726", MCP4726 },
+	{ "mcp4725", (kernel_ulong_t)&mcp4725 },
+	{ "mcp4726", (kernel_ulong_t)&mcp4726 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mcp4725_id);
@@ -520,11 +532,11 @@ MODULE_DEVICE_TABLE(i2c, mcp4725_id);
 static const struct of_device_id mcp4725_of_match[] = {
 	{
 		.compatible = "microchip,mcp4725",
-		.data = (void *)MCP4725
+		.data = &mcp4725
 	},
 	{
 		.compatible = "microchip,mcp4726",
-		.data = (void *)MCP4726
+		.data = &mcp4726
 	},
 	{ }
 };
-- 
2.25.1

