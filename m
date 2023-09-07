Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32B879785D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbjIGQqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243385AbjIGQqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:46:18 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BABEB524E;
        Thu,  7 Sep 2023 09:21:41 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,234,1688396400"; 
   d="scan'208";a="179023738"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 07 Sep 2023 16:14:13 +0900
Received: from localhost.localdomain (unknown [10.226.92.56])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id E73BC4010076;
        Thu,  7 Sep 2023 16:14:10 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Eric Tremblay <etremblay@distech-controls.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v6 1/2] hwmon: tmp513: Add max_channels variable to struct tmp51x_data
Date:   Thu,  7 Sep 2023 08:14:03 +0100
Message-Id: <20230907071404.24334-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230907071404.24334-1-biju.das.jz@bp.renesas.com>
References: <20230907071404.24334-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tmp512 chip has 3 channels whereas tmp513 has 4 channels. Avoid
using tmp51x_ids for this HW difference by replacing OF/ID table
data with maximum channels supported by the device.

Replace id->max_channels variable from struct tmp51x_data and drop the
macros TMP51{2,3}_TEMP_CONFIG_DEFAULT as it can be derived from the macro
TMP51X_TEMP_CONFIG_DEFAULT and update the logic in tmp51x_is_visible(),
tmp51x_read_properties() and tmp51x_init() using max_channels.

While at it, drop enum tmp51x_ids as there is no user and remove
trailing comma in the terminator entry for OF table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v5->v6:
 * Updated TMP51X_TEMP_CONFIG_CONV_RATE macro by removing FIELD_PREP macro
   and just use GENMASK(9, 7).
 * Dropped bitfield.h as there is no user.
v4->v5:
 * Updated the TMP51X_TEMP_CHANNEL_MASK macro.
 * Updated the indentation for TMP51X_TEMP_CONFIG_DEFAULT macro.
v3->v4:
 * Updated commit description
 * Updated macros TMP51X_TEMP_CONFIG_DEFAULT and TMP51X_TEMP_CHANNEL_MASK.
 * Removed trailing comma in the terminator entry for OF table.
v2->v3:
 * Updated the macro TMP51X_TEMP_CONFIG_DEFAULT by adding bit definitions.
 * Dropped unused macros TMP51{2,3}_TEMP_CONFIG_DEFAULT.
 * Avoided Yoda style logic.
 * Replaced OF/ID data from tmp51x_ids->max_channels
v2:
 * New patch.
---
 drivers/hwmon/tmp513.c | 49 ++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
index 9a180b1030c9..b336b95298ab 100644
--- a/drivers/hwmon/tmp513.c
+++ b/drivers/hwmon/tmp513.c
@@ -73,9 +73,6 @@
 #define TMP51X_PGA_DEFAULT		8
 #define TMP51X_MAX_REGISTER_ADDR	0xFF
 
-#define TMP512_TEMP_CONFIG_DEFAULT	0xBF80
-#define TMP513_TEMP_CONFIG_DEFAULT	0xFF80
-
 // Mask and shift
 #define CURRENT_SENSE_VOLTAGE_320_MASK	0x1800
 #define CURRENT_SENSE_VOLTAGE_160_MASK	0x1000
@@ -113,6 +110,17 @@
 
 #define MAX_TEMP_HYST			127500
 
+#define TMP512_MAX_CHANNELS		3
+#define TMP513_MAX_CHANNELS		4
+
+#define TMP51X_TEMP_CONFIG_CONV_RATE	GENMASK(9, 7)
+#define TMP51X_TEMP_CONFIG_RC		BIT(10)
+#define TMP51X_TEMP_CHANNEL_MASK(n)	(GENMASK((n) - 1, 0) << 11)
+#define TMP51X_TEMP_CONFIG_CONT		BIT(15)
+#define TMP51X_TEMP_CONFIG_DEFAULT(n)					\
+	(TMP51X_TEMP_CHANNEL_MASK(n) | TMP51X_TEMP_CONFIG_CONT |	\
+	 TMP51X_TEMP_CONFIG_CONV_RATE | TMP51X_TEMP_CONFIG_RC)
+
 static const u8 TMP51X_TEMP_INPUT[4] = {
 	TMP51X_LOCAL_TEMP_RESULT,
 	TMP51X_REMOTE_TEMP_RESULT_1,
@@ -152,10 +160,6 @@ static struct regmap_config tmp51x_regmap_config = {
 	.max_register = TMP51X_MAX_REGISTER_ADDR,
 };
 
-enum tmp51x_ids {
-	tmp512, tmp513
-};
-
 struct tmp51x_data {
 	u16 shunt_config;
 	u16 pga_gain;
@@ -169,7 +173,7 @@ struct tmp51x_data {
 	u32 curr_lsb_ua;
 	u32 pwr_lsb_uw;
 
-	enum tmp51x_ids id;
+	u8 max_channels;
 	struct regmap *regmap;
 };
 
@@ -434,7 +438,7 @@ static umode_t tmp51x_is_visible(const void *_data,
 
 	switch (type) {
 	case hwmon_temp:
-		if (data->id == tmp512 && channel == 3)
+		if (channel >= data->max_channels)
 			return 0;
 		switch (attr) {
 		case hwmon_temp_input:
@@ -585,7 +589,7 @@ static int tmp51x_init(struct tmp51x_data *data)
 	if (ret < 0)
 		return ret;
 
-	if (data->id == tmp513) {
+	if (data->max_channels == TMP513_MAX_CHANNELS) {
 		ret = regmap_write(data->regmap, TMP513_N_FACTOR_3,
 				   data->nfactor[2] << 8);
 		if (ret < 0)
@@ -601,22 +605,16 @@ static int tmp51x_init(struct tmp51x_data *data)
 }
 
 static const struct i2c_device_id tmp51x_id[] = {
-	{ "tmp512", tmp512 },
-	{ "tmp513", tmp513 },
+	{ "tmp512", TMP512_MAX_CHANNELS },
+	{ "tmp513", TMP513_MAX_CHANNELS },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tmp51x_id);
 
 static const struct of_device_id tmp51x_of_match[] = {
-	{
-		.compatible = "ti,tmp512",
-		.data = (void *)tmp512
-	},
-	{
-		.compatible = "ti,tmp513",
-		.data = (void *)tmp513
-	},
-	{ },
+	{ .compatible = "ti,tmp512", .data = (void *)TMP512_MAX_CHANNELS },
+	{ .compatible = "ti,tmp513", .data = (void *)TMP513_MAX_CHANNELS },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tmp51x_of_match);
 
@@ -674,9 +672,9 @@ static int tmp51x_read_properties(struct device *dev, struct tmp51x_data *data)
 		return ret;
 
 	ret = device_property_read_u32_array(dev, "ti,nfactor", nfactor,
-					    (data->id == tmp513) ? 3 : 2);
+					    data->max_channels - 1);
 	if (ret >= 0)
-		memcpy(data->nfactor, nfactor, (data->id == tmp513) ? 3 : 2);
+		memcpy(data->nfactor, nfactor, data->max_channels - 1);
 
 	// Check if shunt value is compatible with pga-gain
 	if (data->shunt_uohms > data->pga_gain * 40 * 1000 * 1000) {
@@ -698,8 +696,7 @@ static void tmp51x_use_default(struct tmp51x_data *data)
 static int tmp51x_configure(struct device *dev, struct tmp51x_data *data)
 {
 	data->shunt_config = TMP51X_SHUNT_CONFIG_DEFAULT;
-	data->temp_config = (data->id == tmp513) ?
-			TMP513_TEMP_CONFIG_DEFAULT : TMP512_TEMP_CONFIG_DEFAULT;
+	data->temp_config = TMP51X_TEMP_CONFIG_DEFAULT(data->max_channels);
 
 	if (dev->of_node)
 		return tmp51x_read_properties(dev, data);
@@ -720,7 +717,7 @@ static int tmp51x_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
-	data->id = (uintptr_t)i2c_get_match_data(client);
+	data->max_channels = (uintptr_t)i2c_get_match_data(client);
 
 	ret = tmp51x_configure(dev, data);
 	if (ret < 0) {
-- 
2.25.1

