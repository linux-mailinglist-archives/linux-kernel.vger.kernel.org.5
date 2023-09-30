Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42A87B42D4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 19:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjI3R43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 13:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbjI3R42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 13:56:28 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D940D3;
        Sat, 30 Sep 2023 10:56:26 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,190,1694703600"; 
   d="scan'208";a="177759859"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Oct 2023 02:56:25 +0900
Received: from localhost.localdomain (unknown [10.226.92.9])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9BEEE4005B37;
        Sun,  1 Oct 2023 02:56:23 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/2] leds: pca955x: Cleanup OF/ID table terminators
Date:   Sat, 30 Sep 2023 18:56:15 +0100
Message-Id: <20230930175615.13301-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230930175615.13301-1-biju.das.jz@bp.renesas.com>
References: <20230930175615.13301-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cleanups:
 * Remove the trailing comma in the terminator entry for the OF
   table making code robust against (theoretical) misrebases or other
   similar things where the new entry goes _after_ the termination without
   the compiler noticing.
 * Drop a space from terminator entry for ID table.

While at it, move OF/ID table near to the user.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2->v3:
 * Added Rb tag from Andy.
v2:
 * New patch.
---
 drivers/leds/leds-pca955x.c | 40 ++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
index 7a83e84be6db..6720e1c7a8d9 100644
--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -104,16 +104,6 @@ static const struct pca955x_chipdef pca955x_chipdefs[] = {
 	},
 };
 
-static const struct i2c_device_id pca955x_id[] = {
-	{ "pca9550", (kernel_ulong_t)&pca955x_chipdefs[pca9550] },
-	{ "pca9551", (kernel_ulong_t)&pca955x_chipdefs[pca9551] },
-	{ "pca9552", (kernel_ulong_t)&pca955x_chipdefs[pca9552] },
-	{ "ibm-pca9552", (kernel_ulong_t)&pca955x_chipdefs[ibm_pca9552] },
-	{ "pca9553", (kernel_ulong_t)&pca955x_chipdefs[pca9553] },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, pca955x_id);
-
 struct pca955x {
 	struct mutex lock;
 	struct pca955x_led *leds;
@@ -457,16 +447,6 @@ pca955x_get_pdata(struct i2c_client *client, const struct pca955x_chipdef *chip)
 	return pdata;
 }
 
-static const struct of_device_id of_pca955x_match[] = {
-	{ .compatible = "nxp,pca9550", .data = &pca955x_chipdefs[pca9550] },
-	{ .compatible = "nxp,pca9551", .data = &pca955x_chipdefs[pca9551] },
-	{ .compatible = "nxp,pca9552", .data = &pca955x_chipdefs[pca9552] },
-	{ .compatible = "ibm,pca9552", .data = &pca955x_chipdefs[ibm_pca9552] },
-	{ .compatible = "nxp,pca9553", .data = &pca955x_chipdefs[pca9553] },
-	{},
-};
-MODULE_DEVICE_TABLE(of, of_pca955x_match);
-
 static int pca955x_probe(struct i2c_client *client)
 {
 	struct pca955x *pca955x;
@@ -650,6 +630,26 @@ static int pca955x_probe(struct i2c_client *client)
 	return 0;
 }
 
+static const struct i2c_device_id pca955x_id[] = {
+	{ "pca9550", (kernel_ulong_t)&pca955x_chipdefs[pca9550] },
+	{ "pca9551", (kernel_ulong_t)&pca955x_chipdefs[pca9551] },
+	{ "pca9552", (kernel_ulong_t)&pca955x_chipdefs[pca9552] },
+	{ "ibm-pca9552", (kernel_ulong_t)&pca955x_chipdefs[ibm_pca9552] },
+	{ "pca9553", (kernel_ulong_t)&pca955x_chipdefs[pca9553] },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, pca955x_id);
+
+static const struct of_device_id of_pca955x_match[] = {
+	{ .compatible = "nxp,pca9550", .data = &pca955x_chipdefs[pca9550] },
+	{ .compatible = "nxp,pca9551", .data = &pca955x_chipdefs[pca9551] },
+	{ .compatible = "nxp,pca9552", .data = &pca955x_chipdefs[pca9552] },
+	{ .compatible = "ibm,pca9552", .data = &pca955x_chipdefs[ibm_pca9552] },
+	{ .compatible = "nxp,pca9553", .data = &pca955x_chipdefs[pca9553] },
+	{}
+};
+MODULE_DEVICE_TABLE(of, of_pca955x_match);
+
 static struct i2c_driver pca955x_driver = {
 	.driver = {
 		.name	= "leds-pca955x",
-- 
2.25.1

