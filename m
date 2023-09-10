Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57662799EC0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 17:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346721AbjIJPAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 11:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346713AbjIJPAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 11:00:49 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CB0DCCD;
        Sun, 10 Sep 2023 08:00:45 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,241,1688396400"; 
   d="scan'208";a="179304430"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 11 Sep 2023 00:00:45 +0900
Received: from localhost.localdomain (unknown [10.226.92.9])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id E524E40065C0;
        Mon, 11 Sep 2023 00:00:42 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/2] media: i2c: ov7670: Drop CONFIG_OF ifdeffery
Date:   Sun, 10 Sep 2023 16:00:33 +0100
Message-Id: <20230910150033.50596-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910150033.50596-1-biju.das.jz@bp.renesas.com>
References: <20230910150033.50596-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop of_match_ptr() from ov7670_driver and get rid of ugly CONFIG_OF
if check. This slightly increases the size of ov7670_driver on non-OF
system and shouldn't be an issue.

Add mod_devicetable.h include.

It also allows, in case if needed, to enumerate this device via ACPI with
PRP0001 magic.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/media/i2c/ov7670.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
index 644457e6993d..41032394a464 100644
--- a/drivers/media/i2c/ov7670.c
+++ b/drivers/media/i2c/ov7670.c
@@ -10,6 +10,7 @@
  */
 #include <linux/clk.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
@@ -2013,18 +2014,16 @@ static const struct i2c_device_id ov7670_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ov7670_id);
 
-#if IS_ENABLED(CONFIG_OF)
 static const struct of_device_id ov7670_of_match[] = {
 	{ .compatible = "ovti,ov7670", &ov7670_devdata },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ov7670_of_match);
-#endif
 
 static struct i2c_driver ov7670_driver = {
 	.driver = {
 		.name	= "ov7670",
-		.of_match_table = of_match_ptr(ov7670_of_match),
+		.of_match_table = ov7670_of_match,
 	},
 	.probe		= ov7670_probe,
 	.remove		= ov7670_remove,
-- 
2.25.1

