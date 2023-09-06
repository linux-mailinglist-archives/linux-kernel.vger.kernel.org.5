Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F7D7942C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243683AbjIFSIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIFSIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:08:50 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB68B10F7;
        Wed,  6 Sep 2023 11:08:46 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,232,1688396400"; 
   d="scan'208";a="175233625"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Sep 2023 03:08:46 +0900
Received: from localhost.localdomain (unknown [10.226.92.21])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id B1083404A6D7;
        Thu,  7 Sep 2023 03:08:43 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Eric Tremblay <etremblay@distech-controls.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 1/2] hwmon: tmp513: Add max_channels variable to struct tmp51x_data
Date:   Wed,  6 Sep 2023 19:08:36 +0100
Message-Id: <20230906180837.284743-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230906180837.284743-1-biju.das.jz@bp.renesas.com>
References: <20230906180837.284743-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/hwmon/tmp513.c | 50 ++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
index 9a180b1030c9..290390c842e6 100644
--- a/drivers/hwmon/tmp513.c
+++ b/drivers/hwmon/tmp513.c
@@ -19,6 +19,7 @@
  * the Free Software Foundation; version 2 of the License.
  */
 
+#include <linux/bitfield.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
 #include <linux/i2c.h>
@@ -73,9 +74,6 @@
 #define TMP51X_PGA_DEFAULT		8
 #define TMP51X_MAX_REGISTER_ADDR	0xFF
 
-#define TMP512_TEMP_CONFIG_DEFAULT	0xBF80
-#define TMP513_TEMP_CONFIG_DEFAULT	0xFF80
-
 // Mask and shift
 #define CURRENT_SENSE_VOLTAGE_320_MASK	0x1800
 #define CURRENT_SENSE_VOLTAGE_160_MASK	0x1000
@@ -113,6 +111,17 @@
 
 #define MAX_TEMP_HYST			127500
 
+#define TMP512_MAX_CHANNELS		3
+#define TMP513_MAX_CHANNELS		4
+
+#define TMP51X_TEMP_CONFIG_CONV_RATE	FIELD_PREP(GENMASK(9, 7), 0x7)
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
@@ -152,10 +161,6 @@ static struct regmap_config tmp51x_regmap_config = {
 	.max_register = TMP51X_MAX_REGISTER_ADDR,
 };
 
-enum tmp51x_ids {
-	tmp512, tmp513
-};
-
 struct tmp51x_data {
 	u16 shunt_config;
 	u16 pga_gain;
@@ -169,7 +174,7 @@ struct tmp51x_data {
 	u32 curr_lsb_ua;
 	u32 pwr_lsb_uw;
 
-	enum tmp51x_ids id;
+	u8 max_channels;
 	struct regmap *regmap;
 };
 
@@ -434,7 +439,7 @@ static umode_t tmp51x_is_visible(const void *_data,
 
 	switch (type) {
 	case hwmon_temp:
-		if (data->id == tmp512 && channel == 3)
+		if (channel >= data->max_channels)
 			return 0;
 		switch (attr) {
 		case hwmon_temp_input:
@@ -585,7 +590,7 @@ static int tmp51x_init(struct tmp51x_data *data)
 	if (ret < 0)
 		return ret;
 
-	if (data->id == tmp513) {
+	if (data->max_channels == TMP513_MAX_CHANNELS) {
 		ret = regmap_write(data->regmap, TMP513_N_FACTOR_3,
 				   data->nfactor[2] << 8);
 		if (ret < 0)
@@ -601,22 +606,16 @@ static int tmp51x_init(struct tmp51x_data *data)
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
 
@@ -674,9 +673,9 @@ static int tmp51x_read_properties(struct device *dev, struct tmp51x_data *data)
 		return ret;
 
 	ret = device_property_read_u32_array(dev, "ti,nfactor", nfactor,
-					    (data->id == tmp513) ? 3 : 2);
+					    data->max_channels - 1);
 	if (ret >= 0)
-		memcpy(data->nfactor, nfactor, (data->id == tmp513) ? 3 : 2);
+		memcpy(data->nfactor, nfactor, data->max_channels - 1);
 
 	// Check if shunt value is compatible with pga-gain
 	if (data->shunt_uohms > data->pga_gain * 40 * 1000 * 1000) {
@@ -698,8 +697,7 @@ static void tmp51x_use_default(struct tmp51x_data *data)
 static int tmp51x_configure(struct device *dev, struct tmp51x_data *data)
 {
 	data->shunt_config = TMP51X_SHUNT_CONFIG_DEFAULT;
-	data->temp_config = (data->id == tmp513) ?
-			TMP513_TEMP_CONFIG_DEFAULT : TMP512_TEMP_CONFIG_DEFAULT;
+	data->temp_config = TMP51X_TEMP_CONFIG_DEFAULT(data->max_channels);
 
 	if (dev->of_node)
 		return tmp51x_read_properties(dev, data);
@@ -720,7 +718,7 @@ static int tmp51x_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
-	data->id = (uintptr_t)i2c_get_match_data(client);
+	data->max_channels = (uintptr_t)i2c_get_match_data(client);
 
 	ret = tmp51x_configure(dev, data);
 	if (ret < 0) {
-- 
2.25.1

