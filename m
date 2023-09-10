Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6FC799F0E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 18:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjIJQyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 12:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjIJQys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 12:54:48 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CBB4CC5;
        Sun, 10 Sep 2023 09:54:44 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,242,1688396400"; 
   d="scan'208";a="179309134"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 11 Sep 2023 01:54:44 +0900
Received: from localhost.localdomain (unknown [10.226.92.9])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A38A840062B6;
        Mon, 11 Sep 2023 01:54:41 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/2] media: i2c: mt9v032: Drop CONFIG_OF ifdeffery
Date:   Sun, 10 Sep 2023 17:54:32 +0100
Message-Id: <20230910165432.76378-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910165432.76378-1-biju.das.jz@bp.renesas.com>
References: <20230910165432.76378-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop of_match_ptr() from mt9v032_driver and get rid of ugly CONFIG_OF
if check. This slightly increases the size of mt9v032_driver on non-OF
system and shouldn't be an issue.

Add mod_devicetable.h include.

It also allows, in case if needed, to enumerate this device via ACPI with
PRP0001 magic.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/media/i2c/mt9v032.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/mt9v032.c b/drivers/media/i2c/mt9v032.c
index 0f448aa27e53..1c6f6cea1204 100644
--- a/drivers/media/i2c/mt9v032.c
+++ b/drivers/media/i2c/mt9v032.c
@@ -14,6 +14,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/log2.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
@@ -1275,7 +1276,6 @@ static const struct i2c_device_id mt9v032_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mt9v032_id);
 
-#if IS_ENABLED(CONFIG_OF)
 static const struct of_device_id mt9v032_of_match[] = {
 	{ .compatible = "aptina,mt9v022", .data = &mt9v032_models[MT9V032_MODEL_V022_COLOR] },
 	{ .compatible = "aptina,mt9v022m", .data = &mt9v032_models[MT9V032_MODEL_V022_MONO] },
@@ -1288,12 +1288,11 @@ static const struct of_device_id mt9v032_of_match[] = {
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mt9v032_of_match);
-#endif
 
 static struct i2c_driver mt9v032_driver = {
 	.driver = {
 		.name = "mt9v032",
-		.of_match_table = of_match_ptr(mt9v032_of_match),
+		.of_match_table = mt9v032_of_match,
 	},
 	.probe		= mt9v032_probe,
 	.remove		= mt9v032_remove,
-- 
2.25.1

