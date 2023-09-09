Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FF77997E6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 14:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242795AbjIIMT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 08:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345668AbjIIMTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 08:19:22 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFBA1CDE;
        Sat,  9 Sep 2023 05:19:17 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,239,1688396400"; 
   d="scan'208";a="175527310"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 09 Sep 2023 21:19:17 +0900
Received: from localhost.localdomain (unknown [10.226.92.15])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id BB96F41EBFFC;
        Sat,  9 Sep 2023 21:19:15 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/4] pinctrl: mcp23s08_spi: Simplify probe()
Date:   Sat,  9 Sep 2023 13:19:02 +0100
Message-Id: <20230909121903.34062-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230909121903.34062-1-biju.das.jz@bp.renesas.com>
References: <20230909121903.34062-1-biju.das.jz@bp.renesas.com>
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

Simpilfy probe() by replacing device_get_match_data() and ID lookup for
retrieving match data by spi_get_device_match_data().

While at it, replace data type of variable type from 'int'->'unsigned int'
and declare variables following a reverse christmas tree order.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2:
 * New patch.
---
 drivers/pinctrl/pinctrl-mcp23s08_spi.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08_spi.c b/drivers/pinctrl/pinctrl-mcp23s08_spi.c
index ea059b9c5542..caf528284d07 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08_spi.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08_spi.c
@@ -143,22 +143,17 @@ static int mcp23s08_spi_regmap_init(struct mcp23s08 *mcp, struct device *dev,
 
 static int mcp23s08_probe(struct spi_device *spi)
 {
-	struct device *dev = &spi->dev;
 	struct mcp23s08_driver_data *data;
+	struct device *dev = &spi->dev;
 	unsigned long spi_present_mask;
-	const void *match;
-	unsigned int addr;
 	unsigned int ngpio = 0;
+	unsigned int type;
+	unsigned int addr;
 	int chips;
-	int type;
 	int ret;
 	u32 v;
 
-	match = device_get_match_data(dev);
-	if (match)
-		type = (int)(uintptr_t)match;
-	else
-		type = spi_get_device_id(spi)->driver_data;
+	type = (uintptr_t)spi_get_device_match_data(spi);
 
 	ret = device_property_read_u32(dev, "microchip,spi-present-mask", &v);
 	if (ret) {
-- 
2.25.1

