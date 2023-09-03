Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD39790BC5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 13:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbjICL4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 07:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236941AbjICL4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 07:56:11 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23138131;
        Sun,  3 Sep 2023 04:56:05 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,224,1688396400"; 
   d="scan'208";a="178550481"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2023 20:56:04 +0900
Received: from localhost.localdomain (unknown [10.226.92.30])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 149AE41C3085;
        Sun,  3 Sep 2023 20:56:01 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 3/4] iio: dac: mcp4725: Add use_ext_ref_voltage to struct mcp4725_chip_info
Date:   Sun,  3 Sep 2023 12:55:47 +0100
Message-Id: <20230903115548.59306-4-biju.das.jz@bp.renesas.com>
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

The MCP4725 has external voltage reference compared MCP4725 which
has reference embeedded in eeprom. Add use_ext_ref_voltage variable
to struct mcp4725_chip_info to handle this difference.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3:
 * New patch
---
 drivers/iio/dac/mcp4725.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index fe8981ec7923..9cbea6f223e4 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -33,6 +33,7 @@
 struct mcp4725_chip_info {
 	const struct iio_chan_spec *chan_spec;
 	unsigned int chip_id;
+	bool use_ext_ref_voltage;
 };
 
 struct mcp4725_data {
@@ -416,7 +417,7 @@ static int mcp4725_probe(struct i2c_client *client)
 		pdata = &pdata_dt;
 	}
 
-	if (info->chip_id == MCP4725 && pdata->use_vref) {
+	if (info->use_ext_ref_voltage && pdata->use_vref) {
 		dev_err(&client->dev,
 			"external reference is unavailable on MCP4725");
 		return -EINVAL;
@@ -472,10 +473,10 @@ static int mcp4725_probe(struct i2c_client *client)
 	data->powerdown = pd > 0;
 	data->powerdown_mode = pd ? pd - 1 : 2; /* largest resistor to gnd */
 	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
-	if (info->chip_id == MCP4726)
+	if (!info->use_ext_ref_voltage)
 		ref = (inbuf[3] >> 3) & 0x3;
 
-	if (info->chip_id == MCP4726 && ref != data->ref_mode) {
+	if (!info->use_ext_ref_voltage && ref != data->ref_mode) {
 		dev_info(&client->dev,
 			"voltage reference mode differs (conf: %u, eeprom: %u), setting %u",
 			data->ref_mode, ref, data->ref_mode);
@@ -515,6 +516,7 @@ static void mcp4725_remove(struct i2c_client *client)
 static const struct mcp4725_chip_info mcp4725 = {
 	.chan_spec = &mcp472x_channel[MCP4725],
 	.chip_id = MCP4725,
+	.use_ext_ref_voltage = true,
 };
 
 static const struct mcp4725_chip_info mcp4726 = {
-- 
2.25.1

