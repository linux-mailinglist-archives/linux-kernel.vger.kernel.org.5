Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585D7790BC1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 13:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbjICL4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 07:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjICL4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 07:56:02 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6614F124;
        Sun,  3 Sep 2023 04:55:58 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,224,1688396400"; 
   d="scan'208";a="174843004"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Sep 2023 20:55:58 +0900
Received: from localhost.localdomain (unknown [10.226.92.30])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 566E141C2D8A;
        Sun,  3 Sep 2023 20:55:55 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 1/4] iio: dac: mcp4725: Replace variable 'id' from struct mcp4725_data
Date:   Sun,  3 Sep 2023 12:55:45 +0100
Message-Id: <20230903115548.59306-2-biju.das.jz@bp.renesas.com>
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

Replace the variable 'id' from struct mcp4725_data with local variable
chip_id in probe() as the id variable is not used elsewhere in the
driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * Update commit description with reason for change.
---
 drivers/iio/dac/mcp4725.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index f4a3124d29f2..33a61f65bc25 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -32,7 +32,6 @@
 
 struct mcp4725_data {
 	struct i2c_client *client;
-	int id;
 	unsigned ref_mode;
 	bool vref_buffered;
 	u16 dac_value;
@@ -387,6 +386,7 @@ static int mcp4725_probe(struct i2c_client *client)
 	struct mcp4725_data *data;
 	struct iio_dev *indio_dev;
 	struct mcp4725_platform_data *pdata, pdata_dt;
+	int chip_id;
 	u8 inbuf[4];
 	u8 pd;
 	u8 ref;
@@ -399,9 +399,9 @@ static int mcp4725_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 	if (dev_fwnode(&client->dev))
-		data->id = (uintptr_t)device_get_match_data(&client->dev);
+		chip_id = (uintptr_t)device_get_match_data(&client->dev);
 	else
-		data->id = id->driver_data;
+		chip_id = id->driver_data;
 	pdata = dev_get_platdata(&client->dev);
 
 	if (!pdata) {
@@ -414,7 +414,7 @@ static int mcp4725_probe(struct i2c_client *client)
 		pdata = &pdata_dt;
 	}
 
-	if (data->id == MCP4725 && pdata->use_vref) {
+	if (chip_id == MCP4725 && pdata->use_vref) {
 		dev_err(&client->dev,
 			"external reference is unavailable on MCP4725");
 		return -EINVAL;
@@ -455,12 +455,12 @@ static int mcp4725_probe(struct i2c_client *client)
 
 	indio_dev->name = id->name;
 	indio_dev->info = &mcp4725_info;
-	indio_dev->channels = &mcp472x_channel[id->driver_data];
+	indio_dev->channels = &mcp472x_channel[chip_id];
 	indio_dev->num_channels = 1;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* read current DAC value and settings */
-	err = i2c_master_recv(client, inbuf, data->id == MCP4725 ? 3 : 4);
+	err = i2c_master_recv(client, inbuf, chip_id == MCP4725 ? 3 : 4);
 
 	if (err < 0) {
 		dev_err(&client->dev, "failed to read DAC value");
@@ -470,10 +470,10 @@ static int mcp4725_probe(struct i2c_client *client)
 	data->powerdown = pd > 0;
 	data->powerdown_mode = pd ? pd - 1 : 2; /* largest resistor to gnd */
 	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
-	if (data->id == MCP4726)
+	if (chip_id == MCP4726)
 		ref = (inbuf[3] >> 3) & 0x3;
 
-	if (data->id == MCP4726 && ref != data->ref_mode) {
+	if (chip_id == MCP4726 && ref != data->ref_mode) {
 		dev_info(&client->dev,
 			"voltage reference mode differs (conf: %u, eeprom: %u), setting %u",
 			data->ref_mode, ref, data->ref_mode);
-- 
2.25.1

