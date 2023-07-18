Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8683E7585F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGRUPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGRUPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:15:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1034B6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:15:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLr64-0006QK-Eo; Tue, 18 Jul 2023 22:15:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLr62-000RwL-8V; Tue, 18 Jul 2023 22:14:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLr61-005w3S-HG; Tue, 18 Jul 2023 22:14:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Okan Sahin <okan.sahin@analog.com>
Subject: [PATCH] regulator: max77857: Switch back to use struct i2c_driver's .probe()
Date:   Tue, 18 Jul 2023 22:14:53 +0200
Message-Id: <20230718201453.3953602-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=rYLwMHPLHmBaiJ+tsc7QaZqhCDqzQziryzOKvm6BYpI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBktvK8rQ4KslLbe7lIW2m8Iqdyxgi01atkm6Ia0 ZXZoJz3Y8CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLbyvAAKCRCPgPtYfRL+ ToA4B/9ObQ4DVqp4CVXJY3P6PckOUAQ7rONEqjywbBp/TQFsicGgFLlhfsMlh+mJYXt+Hr1a/mb S8gpkniPa7sb6Xq6ijWHxwouvezeDRvdJ5KTfzzKo8Y0+8SpINr2aNTxRrOee0bbVCI/xfdq6ya qH6Nggab83DmEdXQHBr63S8cFby6uMyQK/d9ifMfIEYeA5i3Num6o3N3SiEVgJFVz1rzIoq1feF 0n3DjuxMu2eOk44cppM5+Z+kGNBCf1SC/pqCOjjBFiFMihs3JwOiZMCBKu10dS6r4N0tdmcoy+E YmOuBfVvu3pRICchw2trTbnLotlAOmz0jZcY+RPKNCKzz4Es
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
call-back type"), all drivers being converted to .probe_new() and then
commit 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
convert back to (the new) .probe() to be able to eventually drop
.probe_new() from struct i2c_driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this driver is currently added in next and introduces a new usage of
.probe_new which I intend to remove after the next -rc1.

To reduce the amount of patches that are necessary to apply together
with the patch that drops .probe_new() it would be great if you make
sure that this patch makes it in before v6.6-rc1.

Thanks
Uwe

 drivers/regulator/max77857-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max77857-regulator.c b/drivers/regulator/max77857-regulator.c
index c5482ffd606e..d0fcb080f825 100644
--- a/drivers/regulator/max77857-regulator.c
+++ b/drivers/regulator/max77857-regulator.c
@@ -449,7 +449,7 @@ struct i2c_driver max77857_driver = {
 		.of_match_table = max77857_of_id,
 	},
 	.id_table = max77857_id,
-	.probe_new = max77857_probe,
+	.probe = max77857_probe,
 };
 module_i2c_driver(max77857_driver);
 

base-commit: af71cccadecedad3484c2208e2c4fc8eff927d4a
-- 
2.39.2

