Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFD078B4E3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjH1P4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjH1P4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:56:25 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 791BBA9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:56:22 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,207,1688396400"; 
   d="scan'208";a="177937725"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Aug 2023 00:56:21 +0900
Received: from localhost.localdomain (unknown [10.226.92.234])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id E557F4009430;
        Tue, 29 Aug 2023 00:56:19 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v2] mfd: arizona-i2c: Simplify probe()
Date:   Mon, 28 Aug 2023 16:56:17 +0100
Message-Id: <20230828155617.87068-1-biju.das.jz@bp.renesas.com>
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

Simplify probe() by replacing device_get_match_data() and ID lookup for
retrieving match data by i2c_get_match_data().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
Note:
 This patch is only compile tested.

v1->v2:
 * Added Ack and Tested-by tag from Charles Keepax
 * Dropped unnecessary blank line before switch statement.
---
 drivers/mfd/arizona-i2c.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
index 9b7183ffc928..5f830907d2e6 100644
--- a/drivers/mfd/arizona-i2c.c
+++ b/drivers/mfd/arizona-i2c.c
@@ -22,19 +22,12 @@
 
 static int arizona_i2c_probe(struct i2c_client *i2c)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
-	const void *match_data;
 	struct arizona *arizona;
 	const struct regmap_config *regmap_config = NULL;
-	unsigned long type = 0;
+	unsigned long type;
 	int ret;
 
-	match_data = device_get_match_data(&i2c->dev);
-	if (match_data)
-		type = (unsigned long)match_data;
-	else if (id)
-		type = id->driver_data;
-
+	type = (unsigned long)i2c_get_match_data(i2c);
 	switch (type) {
 	case WM5102:
 		if (IS_ENABLED(CONFIG_MFD_WM5102))
-- 
2.25.1

