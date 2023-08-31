Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFCE78F2AC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347059AbjHaScM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347047AbjHaScL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:32:11 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 367BCE76;
        Thu, 31 Aug 2023 11:32:08 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,217,1688396400"; 
   d="scan'208";a="174628379"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2023 03:32:07 +0900
Received: from localhost.localdomain (unknown [10.226.92.179])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 040DF400CEF1;
        Fri,  1 Sep 2023 03:32:05 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 4/4] mfd: palmas: Make similar OF and ID table
Date:   Thu, 31 Aug 2023 19:31:53 +0100
Message-Id: <20230831183153.63750-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831183153.63750-1-biju.das.jz@bp.renesas.com>
References: <20230831183153.63750-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make similar OF and ID table to extend support for ID match using
i2c_match_data(). Currently it works only for OF match tables as the
driver_data is wrong for ID match.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Updated commit description.
v1->v2:
 * No change.
---
 drivers/mfd/palmas.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 3ac9dec2b117..7fc886f4f80e 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -513,7 +513,7 @@ static int palmas_i2c_probe(struct i2c_client *i2c)
 	palmas->dev = &i2c->dev;
 	palmas->irq = i2c->irq;
 
-	driver_data = device_get_match_data(&i2c->dev);
+	driver_data = i2c_get_match_data(i2c);
 	palmas->features = driver_data->features;
 
 	for (i = 0; i < PALMAS_NUM_CLIENTS; i++) {
@@ -699,10 +699,10 @@ static const struct of_device_id of_palmas_match_tbl[] = {
 MODULE_DEVICE_TABLE(of, of_palmas_match_tbl);
 
 static const struct i2c_device_id palmas_i2c_id[] = {
-	{ "palmas", },
-	{ "twl6035", },
-	{ "twl6037", },
-	{ "tps65913", },
+	{ "palmas", (kernel_ulong_t)&palmas_data },
+	{ "twl6035", (kernel_ulong_t)&palmas_data },
+	{ "twl6037", (kernel_ulong_t)&palmas_data },
+	{ "tps65913", (kernel_ulong_t)&palmas_data },
 	{ /* end */ }
 };
 MODULE_DEVICE_TABLE(i2c, palmas_i2c_id);
-- 
2.25.1

