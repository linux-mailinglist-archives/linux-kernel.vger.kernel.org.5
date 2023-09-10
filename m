Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B052F799ED0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 17:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346749AbjIJPWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 11:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346740AbjIJPWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 11:22:19 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F38361BD;
        Sun, 10 Sep 2023 08:22:14 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,241,1688396400"; 
   d="scan'208";a="175582261"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 11 Sep 2023 00:22:10 +0900
Received: from localhost.localdomain (unknown [10.226.92.9])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3EBFA4006C6C;
        Mon, 11 Sep 2023 00:22:07 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/2] media: i2c: adv7180: Drop CONFIG_OF ifdeffery
Date:   Sun, 10 Sep 2023 16:22:00 +0100
Message-Id: <20230910152200.56086-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910152200.56086-1-biju.das.jz@bp.renesas.com>
References: <20230910152200.56086-1-biju.das.jz@bp.renesas.com>
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

Drop of_match_ptr() from adv7180_driver and get rid of ugly CONFIG_OF
if check. This slightly increases the size of adv7180_driver on non-OF
system and shouldn't be an issue.

Add mod_devicetable.h include.

It also allows, in case if needed, to enumerate this device via ACPI with
PRP0001 magic.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/media/i2c/adv7180.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
index fc4f29e74e05..54134473186b 100644
--- a/drivers/media/i2c/adv7180.c
+++ b/drivers/media/i2c/adv7180.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2013 Cogent Embedded, Inc.
  * Copyright (C) 2013 Renesas Solutions Corp.
  */
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/errno.h>
@@ -1584,7 +1585,6 @@ static const struct i2c_device_id adv7180_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, adv7180_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id adv7180_of_id[] = {
 	{ .compatible = "adi,adv7180", &adv7180_info },
 	{ .compatible = "adi,adv7180cp", &adv7180_info },
@@ -1600,13 +1600,12 @@ static const struct of_device_id adv7180_of_id[] = {
 	{}
 };
 MODULE_DEVICE_TABLE(of, adv7180_of_id);
-#endif
 
 static struct i2c_driver adv7180_driver = {
 	.driver = {
 		   .name = KBUILD_MODNAME,
 		   .pm = ADV7180_PM_OPS,
-		   .of_match_table = of_match_ptr(adv7180_of_id),
+		   .of_match_table = adv7180_of_id,
 		   },
 	.probe = adv7180_probe,
 	.remove = adv7180_remove,
-- 
2.25.1

