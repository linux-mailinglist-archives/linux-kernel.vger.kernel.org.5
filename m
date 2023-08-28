Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107ED78B4C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjH1PuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjH1Ptt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:49:49 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93B3EC9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:49:46 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,207,1688396400"; 
   d="scan'208";a="174229477"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 29 Aug 2023 00:49:46 +0900
Received: from localhost.localdomain (unknown [10.226.92.234])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7D41D400D4B8;
        Tue, 29 Aug 2023 00:49:43 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] mfd: madera-i2c: Simplify probe()
Date:   Mon, 28 Aug 2023 16:49:41 +0100
Message-Id: <20230828154941.79780-1-biju.das.jz@bp.renesas.com>
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

Simplify probe() by replacing of_device_get_match_data() and ID lookup for
retrieving match data by i2c_get_match_data().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
Note:
 This patch is only compile tested.

v1->v2:
 * Added Ack tag from Charles Keepax.
 * Dropped blank line before switch statement.
---
 drivers/mfd/madera-i2c.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mfd/madera-i2c.c b/drivers/mfd/madera-i2c.c
index a404ea26bc79..33781c631345 100644
--- a/drivers/mfd/madera-i2c.c
+++ b/drivers/mfd/madera-i2c.c
@@ -18,21 +18,14 @@
 
 static int madera_i2c_probe(struct i2c_client *i2c)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
 	struct madera *madera;
 	const struct regmap_config *regmap_16bit_config = NULL;
 	const struct regmap_config *regmap_32bit_config = NULL;
-	const void *of_data;
 	unsigned long type;
 	const char *name;
 	int ret;
 
-	of_data = of_device_get_match_data(&i2c->dev);
-	if (of_data)
-		type = (unsigned long)of_data;
-	else
-		type = id->driver_data;
-
+	type = (unsigned long)i2c_get_match_data(i2c);
 	switch (type) {
 	case CS47L15:
 		if (IS_ENABLED(CONFIG_MFD_CS47L15)) {
-- 
2.25.1

