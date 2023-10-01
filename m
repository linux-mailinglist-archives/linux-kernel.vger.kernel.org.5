Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AB97B4841
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 17:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbjJAPB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 11:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbjJAPB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 11:01:26 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D059D8;
        Sun,  1 Oct 2023 08:01:23 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,191,1694703600"; 
   d="scan'208";a="177808876"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 02 Oct 2023 00:01:22 +0900
Received: from localhost.localdomain (unknown [10.226.92.25])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9B45D420635B;
        Mon,  2 Oct 2023 00:01:20 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 1/3] pinctrl: mcp23s08_i2c: Extend match support for OF tables
Date:   Sun,  1 Oct 2023 16:01:11 +0100
Message-Id: <20231001150113.7752-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231001150113.7752-1-biju.das.jz@bp.renesas.com>
References: <20231001150113.7752-1-biju.das.jz@bp.renesas.com>
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

The driver has OF match table, still it uses ID lookup table for
retrieving match data. Currently the driver is working on the
assumption that a I2C device registered via OF will always match a
legacy I2C device ID. The correct approach is to have an OF device ID
table using of_device_match_data() if the devices are registered via OF.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3->v4:
 * No change.
v2->v3:
 * Added Rb tag from Andy.
v1->v2:
 * Arranged variable declaration in reverse xmas tree.
---
 drivers/pinctrl/pinctrl-mcp23s08_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08_i2c.c b/drivers/pinctrl/pinctrl-mcp23s08_i2c.c
index 3dd1bd8e73eb..41ea2650a7e4 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08_i2c.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08_i2c.c
@@ -10,16 +10,16 @@
 
 static int mcp230xx_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct device *dev = &client->dev;
-	unsigned int type = id->driver_data;
 	struct mcp23s08 *mcp;
+	unsigned int type;
 	int ret;
 
 	mcp = devm_kzalloc(dev, sizeof(*mcp), GFP_KERNEL);
 	if (!mcp)
 		return -ENOMEM;
 
+	type = (uintptr_t)i2c_get_match_data(client);
 	switch (type) {
 	case MCP_TYPE_008:
 		mcp->regmap = devm_regmap_init_i2c(client, &mcp23x08_regmap);
-- 
2.25.1

