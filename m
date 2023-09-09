Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983A07999D7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjIIQ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjIIP3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 11:29:00 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88BB71B0;
        Sat,  9 Sep 2023 08:28:53 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,239,1688396400"; 
   d="scan'208";a="179254153"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 Sep 2023 00:28:52 +0900
Received: from localhost.localdomain (unknown [10.226.92.15])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 793734000C61;
        Sun, 10 Sep 2023 00:28:50 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] clk: si521xx:  Use i2c_get_match_data() instead of device_get_match_data()
Date:   Sat,  9 Sep 2023 16:28:47 +0100
Message-Id: <20230909152847.16216-1-biju.das.jz@bp.renesas.com>
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

The device_get_match_data(), is to get match data for firmware interfaces
such as just OF/ACPI. This driver has I2C matching table as well. Use
i2c_get_match_data() to get match data for I2C, ACPI and DT-based
matching.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/clk-si521xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-si521xx.c b/drivers/clk/clk-si521xx.c
index 4eaf1b53f06b..14c8741b9ba0 100644
--- a/drivers/clk/clk-si521xx.c
+++ b/drivers/clk/clk-si521xx.c
@@ -279,7 +279,7 @@ si521xx_of_clk_get(struct of_phandle_args *clkspec, void *data)
 
 static int si521xx_probe(struct i2c_client *client)
 {
-	const u16 chip_info = (u16)(uintptr_t)device_get_match_data(&client->dev);
+	const u16 chip_info = (u16)(uintptr_t)i2c_get_match_data(client);
 	const struct clk_parent_data clk_parent_data = { .index = 0 };
 	struct si521xx *si;
 	unsigned char name[6] = "DIFF0";
-- 
2.25.1

