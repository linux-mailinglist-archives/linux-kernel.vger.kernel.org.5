Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E53578B65B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjH1RYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjH1RY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:24:29 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14B9D103
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:24:26 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,208,1688396400"; 
   d="scan'208";a="177943381"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 29 Aug 2023 02:24:26 +0900
Received: from localhost.localdomain (unknown [10.226.92.234])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 34B01402D0BB;
        Tue, 29 Aug 2023 02:24:24 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] regulator: pv880x0: Drop CONFIG_OF ifdeffery
Date:   Mon, 28 Aug 2023 18:24:17 +0100
Message-Id: <20230828172417.113631-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230828172417.113631-1-biju.das.jz@bp.renesas.com>
References: <20230828172417.113631-1-biju.das.jz@bp.renesas.com>
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

Get rid of ugly CONFIG_OF ifdeffery by adding mod_devicetable.h include.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2:
 * New patch.
---
 drivers/regulator/pv88080-regulator.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/pv88080-regulator.c b/drivers/regulator/pv88080-regulator.c
index 4009239b6784..2404df78d639 100644
--- a/drivers/regulator/pv88080-regulator.c
+++ b/drivers/regulator/pv88080-regulator.c
@@ -5,6 +5,7 @@
 
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/init.h>
@@ -513,7 +514,6 @@ static int pv88080_i2c_probe(struct i2c_client *i2c)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id pv88080_dt_ids[] = {
 	{ .compatible = "pvs,pv88080",    .data = &pv88080_aa_regs },
 	{ .compatible = "pvs,pv88080-aa", .data = &pv88080_aa_regs  },
@@ -521,7 +521,6 @@ static const struct of_device_id pv88080_dt_ids[] = {
 	{}
 };
 MODULE_DEVICE_TABLE(of, pv88080_dt_ids);
-#endif
 
 static const struct i2c_device_id pv88080_i2c_id[] = {
 	{ "pv88080",    (kernel_ulong_t)&pv88080_aa_regs },
@@ -535,7 +534,7 @@ static struct i2c_driver pv88080_regulator_driver = {
 	.driver = {
 		.name = "pv88080",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.of_match_table = of_match_ptr(pv88080_dt_ids),
+		.of_match_table = pv88080_dt_ids,
 	},
 	.probe = pv88080_i2c_probe,
 	.id_table = pv88080_i2c_id,
-- 
2.25.1

