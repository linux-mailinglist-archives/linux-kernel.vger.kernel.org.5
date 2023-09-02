Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81FF79095C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 21:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjIBTdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 15:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjIBTdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 15:33:42 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A20FDCE0;
        Sat,  2 Sep 2023 12:33:38 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,223,1688396400"; 
   d="scan'208";a="174804168"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 03 Sep 2023 04:33:37 +0900
Received: from localhost.localdomain (unknown [10.226.92.16])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id D334A4003864;
        Sun,  3 Sep 2023 04:33:35 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] power: supply: bq24257_charger: Make chip type and name in sync
Date:   Sat,  2 Sep 2023 20:33:30 +0100
Message-Id: <20230902193331.83672-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230902193331.83672-1-biju.das.jz@bp.renesas.com>
References: <20230902193331.83672-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add struct bq2425x_chip_info to make enum bq2425x_chip and it's name in
sync and replace chip->info in struct bq24257_device and add struct
bq2425x_chip_info as match data for OF/ACPI/ID tables.

Simpilfy probe() by replacing acpi_match_device() and id lookup for
retrieving match data by using i2c_get_match_data().

Drop bq2425x_chip_name as there is no user and also drop the comment
related to syncing chip and name as it is taken care by struct
bq2425x_chip_info.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/power/supply/bq24257_charger.c | 70 +++++++++++++-------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/supply/bq24257_charger.c
index 2852860abf86..188812f4a79b 100644
--- a/drivers/power/supply/bq24257_charger.c
+++ b/drivers/power/supply/bq24257_charger.c
@@ -35,20 +35,15 @@
 
 #define BQ24257_ILIM_SET_DELAY		1000	/* msec */
 
-/*
- * When adding support for new devices make sure that enum bq2425x_chip and
- * bq2425x_chip_name[] always stay in sync!
- */
 enum bq2425x_chip {
 	BQ24250,
 	BQ24251,
 	BQ24257,
 };
 
-static const char *const bq2425x_chip_name[] = {
-	"bq24250",
-	"bq24251",
-	"bq24257",
+struct bq2425x_chip_info {
+	const char *const name;
+	enum bq2425x_chip chip;
 };
 
 enum bq24257_fields {
@@ -84,7 +79,7 @@ struct bq24257_device {
 	struct device *dev;
 	struct power_supply *charger;
 
-	enum bq2425x_chip chip;
+	const struct bq2425x_chip_info *info;
 
 	struct regmap *rmap;
 	struct regmap_field *rmap_fields[F_MAX_FIELDS];
@@ -329,7 +324,7 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_MODEL_NAME:
-		val->strval = bq2425x_chip_name[bq->chip];
+		val->strval = bq->info->name;
 		break;
 
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -947,10 +942,8 @@ static int bq24257_fw_probe(struct bq24257_device *bq)
 
 static int bq24257_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct i2c_adapter *adapter = client->adapter;
 	struct device *dev = &client->dev;
-	const struct acpi_device_id *acpi_id;
 	struct bq24257_device *bq;
 	int ret;
 	int i;
@@ -967,17 +960,9 @@ static int bq24257_probe(struct i2c_client *client)
 	bq->client = client;
 	bq->dev = dev;
 
-	if (ACPI_HANDLE(dev)) {
-		acpi_id = acpi_match_device(dev->driver->acpi_match_table,
-					    &client->dev);
-		if (!acpi_id) {
-			dev_err(dev, "Failed to match ACPI device\n");
-			return -ENODEV;
-		}
-		bq->chip = (enum bq2425x_chip)acpi_id->driver_data;
-	} else {
-		bq->chip = (enum bq2425x_chip)id->driver_data;
-	}
+	bq->info = i2c_get_match_data(client);
+	if (!bq->info)
+		return dev_err_probe(dev, -ENODEV, "Failed to match device\n");
 
 	mutex_init(&bq->lock);
 
@@ -1015,7 +1000,7 @@ static int bq24257_probe(struct i2c_client *client)
 	 * used for the automatic setting of the input current limit setting so
 	 * explicitly disable that feature.
 	 */
-	if (bq->chip == BQ24250)
+	if (bq->info->chip == BQ24250)
 		bq->iilimit_autoset_enable = false;
 
 	if (bq->iilimit_autoset_enable)
@@ -1028,7 +1013,7 @@ static int bq24257_probe(struct i2c_client *client)
 	 * the PG state. We also use a SW-based approach for all other devices
 	 * if the PG pin is either not defined or can't be probed.
 	 */
-	if (bq->chip != BQ24250)
+	if (bq->info->chip != BQ24250)
 		bq24257_pg_gpio_probe(bq);
 
 	if (PTR_ERR(bq->pg) == -EPROBE_DEFER)
@@ -1066,7 +1051,7 @@ static int bq24257_probe(struct i2c_client *client)
 					bq24257_irq_handler_thread,
 					IRQF_TRIGGER_FALLING |
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-					bq2425x_chip_name[bq->chip], bq);
+					bq->info->name, bq);
 	if (ret) {
 		dev_err(dev, "Failed to request IRQ #%d\n", client->irq);
 		return ret;
@@ -1132,27 +1117,42 @@ static const struct dev_pm_ops bq24257_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(bq24257_suspend, bq24257_resume)
 };
 
+static const struct bq2425x_chip_info bq24250_info = {
+	.name = "bq24250",
+	.chip = BQ24250,
+};
+
+static const struct bq2425x_chip_info bq24251_info = {
+	.name = "bq24251",
+	.chip = BQ24251,
+};
+
+static const struct bq2425x_chip_info bq24257_info = {
+	.name = "bq24257",
+	.chip = BQ24257,
+};
+
 static const struct i2c_device_id bq24257_i2c_ids[] = {
-	{ "bq24250", BQ24250 },
-	{ "bq24251", BQ24251 },
-	{ "bq24257", BQ24257 },
+	{ "bq24250", (kernel_ulong_t)&bq24250_info },
+	{ "bq24251", (kernel_ulong_t)&bq24251_info },
+	{ "bq24257", (kernel_ulong_t)&bq24257_info },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, bq24257_i2c_ids);
 
 static const struct of_device_id bq24257_of_match[] __maybe_unused = {
-	{ .compatible = "ti,bq24250", },
-	{ .compatible = "ti,bq24251", },
-	{ .compatible = "ti,bq24257", },
+	{ .compatible = "ti,bq24250", &bq24250_info },
+	{ .compatible = "ti,bq24251", &bq24251_info },
+	{ .compatible = "ti,bq24257", &bq24257_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bq24257_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id bq24257_acpi_match[] = {
-	{ "BQ242500", BQ24250 },
-	{ "BQ242510", BQ24251 },
-	{ "BQ242570", BQ24257 },
+	{ "BQ242500", (kernel_ulong_t)&bq24250_info },
+	{ "BQ242510", (kernel_ulong_t)&bq24251_info },
+	{ "BQ242570", (kernel_ulong_t)&bq24257_info },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, bq24257_acpi_match);
-- 
2.25.1

