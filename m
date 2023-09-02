Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726FC790987
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 22:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbjIBUZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 16:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjIBUZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 16:25:15 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 918EECC5;
        Sat,  2 Sep 2023 13:25:12 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,223,1688396400"; 
   d="scan'208";a="174805738"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Sep 2023 05:25:12 +0900
Received: from localhost.localdomain (unknown [10.226.92.16])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 68D58407243A;
        Sun,  3 Sep 2023 05:25:10 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] power: supply: bq256xx: Use i2c_get_match_data()
Date:   Sat,  2 Sep 2023 21:25:04 +0100
Message-Id: <20230902202505.97609-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230902202505.97609-1-biju.das.jz@bp.renesas.com>
References: <20230902202505.97609-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use i2c_get_match_data() for OF/ID/ACPI match instead of ID lookup by
replacing OF/ACPI/ID match data from enum bq256xx_id to
struct bq256xx_chip_info.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/power/supply/bq256xx_charger.c | 44 +++++++++++++-------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 82d3cd5ee2f9..fda4286323ee 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -1702,7 +1702,7 @@ static int bq256xx_probe(struct i2c_client *client)
 
 	bq->client = client;
 	bq->dev = dev;
-	bq->chip_info = &bq256xx_chip_info_tbl[id->driver_data];
+	bq->chip_info = i2c_get_match_data(client);
 
 	mutex_init(&bq->lock);
 
@@ -1771,37 +1771,37 @@ static int bq256xx_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bq256xx_i2c_ids[] = {
-	{ "bq25600", BQ25600 },
-	{ "bq25600d", BQ25600D },
-	{ "bq25601", BQ25601 },
-	{ "bq25601d", BQ25601D },
-	{ "bq25611d", BQ25611D },
-	{ "bq25618", BQ25618 },
-	{ "bq25619", BQ25619 },
+	{ "bq25600", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25600] },
+	{ "bq25600d", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25600D] },
+	{ "bq25601", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25601] },
+	{ "bq25601d", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25601D] },
+	{ "bq25611d", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25611D] },
+	{ "bq25618", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25618] },
+	{ "bq25619", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25619] },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, bq256xx_i2c_ids);
 
 static const struct of_device_id bq256xx_of_match[] = {
-	{ .compatible = "ti,bq25600", .data = (void *)BQ25600 },
-	{ .compatible = "ti,bq25600d", .data = (void *)BQ25600D },
-	{ .compatible = "ti,bq25601", .data = (void *)BQ25601 },
-	{ .compatible = "ti,bq25601d", .data = (void *)BQ25601D },
-	{ .compatible = "ti,bq25611d", .data = (void *)BQ25611D },
-	{ .compatible = "ti,bq25618", .data = (void *)BQ25618 },
-	{ .compatible = "ti,bq25619", .data = (void *)BQ25619 },
+	{ .compatible = "ti,bq25600", .data = &bq256xx_chip_info_tbl[BQ25600] },
+	{ .compatible = "ti,bq25600d", .data = &bq256xx_chip_info_tbl[BQ25600D] },
+	{ .compatible = "ti,bq25601", .data = &bq256xx_chip_info_tbl[BQ25601] },
+	{ .compatible = "ti,bq25601d", .data = &bq256xx_chip_info_tbl[BQ25601D] },
+	{ .compatible = "ti,bq25611d", .data = &bq256xx_chip_info_tbl[BQ25611D] },
+	{ .compatible = "ti,bq25618", .data = &bq256xx_chip_info_tbl[BQ25618] },
+	{ .compatible = "ti,bq25619", .data = &bq256xx_chip_info_tbl[BQ25619] },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bq256xx_of_match);
 
 static const struct acpi_device_id bq256xx_acpi_match[] = {
-	{ "bq25600", BQ25600 },
-	{ "bq25600d", BQ25600D },
-	{ "bq25601", BQ25601 },
-	{ "bq25601d", BQ25601D },
-	{ "bq25611d", BQ25611D },
-	{ "bq25618", BQ25618 },
-	{ "bq25619", BQ25619 },
+	{ "bq25600", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25600] },
+	{ "bq25600d", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25600D] },
+	{ "bq25601", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25601] },
+	{ "bq25601d", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25601D] },
+	{ "bq25611d", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25611D] },
+	{ "bq25618", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25618] },
+	{ "bq25619", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25619] },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, bq256xx_acpi_match);
-- 
2.25.1

