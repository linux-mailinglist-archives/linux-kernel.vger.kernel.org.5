Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC0D7999CF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjIIQZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346724AbjIIQC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 12:02:28 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 306D713E;
        Sat,  9 Sep 2023 09:02:24 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,239,1688396400"; 
   d="scan'208";a="175534154"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Sep 2023 01:02:23 +0900
Received: from localhost.localdomain (unknown [10.226.92.15])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 62F274019305;
        Sun, 10 Sep 2023 01:02:21 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] clk: rs9: Use i2c_get_match_data() instead of device_get_match_data()
Date:   Sat,  9 Sep 2023 17:02:18 +0100
Message-Id: <20230909160218.33078-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/clk/clk-renesas-pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-renesas-pcie.c b/drivers/clk/clk-renesas-pcie.c
index 7d7b2cb75318..380245f635d6 100644
--- a/drivers/clk/clk-renesas-pcie.c
+++ b/drivers/clk/clk-renesas-pcie.c
@@ -298,7 +298,7 @@ static int rs9_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, rs9);
 	rs9->client = client;
-	rs9->chip_info = device_get_match_data(&client->dev);
+	rs9->chip_info = i2c_get_match_data(client);
 	if (!rs9->chip_info)
 		return -EINVAL;
 
-- 
2.25.1

