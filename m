Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BBC7999DA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbjIIQ0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjIIQU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 12:20:59 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF502197;
        Sat,  9 Sep 2023 09:20:53 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,239,1688396400"; 
   d="scan'208";a="179256689"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Sep 2023 01:20:52 +0900
Received: from localhost.localdomain (unknown [10.226.92.15])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 795EB402468A;
        Sun, 10 Sep 2023 01:20:50 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] clk: si5351: Simplify probe()
Date:   Sat,  9 Sep 2023 17:20:47 +0100
Message-Id: <20230909162047.41845-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver has an OF match table, still, it uses an ID lookup table for
retrieving match data. Currently, the driver is working on the
assumption that an I2C device registered via OF will always match a
legacy I2C device ID. The correct approach is to have an OF device ID
table using i2c_get_match_data() if the devices are registered via OF/ID.

Simplify probe() by replacing ID lookup table for retrieving match data
with i2c_get_match_data().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/clk-si5351.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 00fb9b09e030..afe12d1a9ddc 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -1385,8 +1385,7 @@ MODULE_DEVICE_TABLE(i2c, si5351_i2c_ids);
 
 static int si5351_i2c_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_match_id(si5351_i2c_ids, client);
-	enum si5351_variant variant = (enum si5351_variant)id->driver_data;
+	enum si5351_variant variant;
 	struct si5351_platform_data *pdata;
 	struct si5351_driver_data *drvdata;
 	struct clk_init_data init;
@@ -1394,6 +1393,7 @@ static int si5351_i2c_probe(struct i2c_client *client)
 	u8 num_parents, num_clocks;
 	int ret, n;
 
+	variant = (enum si5351_variant)(uintptr_t)i2c_get_match_data(client);
 	ret = si5351_dt_parse(client, variant);
 	if (ret)
 		return ret;
-- 
2.25.1

