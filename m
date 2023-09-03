Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BD8790BC7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 13:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbjICL4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 07:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjICL4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 07:56:18 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 902EFE5D;
        Sun,  3 Sep 2023 04:56:08 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,224,1688396400"; 
   d="scan'208";a="178550485"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2023 20:56:08 +0900
Received: from localhost.localdomain (unknown [10.226.92.30])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7053F41C2D99;
        Sun,  3 Sep 2023 20:56:05 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 4/4] iio: dac: mcp4725: Add dac_reg_offset to struct mcp4725_chip_info
Date:   Sun,  3 Sep 2023 12:55:48 +0100
Message-Id: <20230903115548.59306-5-biju.das.jz@bp.renesas.com>
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

The MCP4725 has a register offset '3' for reading DAC value compared to
'4' for MCP4726. Add dac_reg_offset variable to struct mcp4725_chip_info
to handle this difference.

Drop chip_id from struct mcp4725_chip_info as it is unused.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3:
 * New patch.
---
 drivers/iio/dac/mcp4725.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 9cbea6f223e4..25bb1c0490af 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -32,7 +32,7 @@
 
 struct mcp4725_chip_info {
 	const struct iio_chan_spec *chan_spec;
-	unsigned int chip_id;
+	u8 dac_reg_offset;
 	bool use_ext_ref_voltage;
 };
 
@@ -463,7 +463,7 @@ static int mcp4725_probe(struct i2c_client *client)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* read current DAC value and settings */
-	err = i2c_master_recv(client, inbuf, info->chip_id == MCP4725 ? 3 : 4);
+	err = i2c_master_recv(client, inbuf, info->dac_reg_offset);
 
 	if (err < 0) {
 		dev_err(&client->dev, "failed to read DAC value");
@@ -515,13 +515,13 @@ static void mcp4725_remove(struct i2c_client *client)
 
 static const struct mcp4725_chip_info mcp4725 = {
 	.chan_spec = &mcp472x_channel[MCP4725],
-	.chip_id = MCP4725,
+	.dac_reg_offset = 3,
 	.use_ext_ref_voltage = true,
 };
 
 static const struct mcp4725_chip_info mcp4726 = {
 	.chan_spec = &mcp472x_channel[MCP4726],
-	.chip_id = MCP4726,
+	.dac_reg_offset = 4,
 };
 
 static const struct i2c_device_id mcp4725_id[] = {
-- 
2.25.1

