Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FF17878FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243362AbjHXT5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243231AbjHXT4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:56:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECAC1BE6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 12:56:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qZGRQ-0003GI-W8; Thu, 24 Aug 2023 21:56:29 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qZGRO-001Loh-03; Thu, 24 Aug 2023 21:56:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qZGRN-00Fptk-CO; Thu, 24 Aug 2023 21:56:25 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Alec Li <like@awinic.com>,
        kernel@pengutronix.de
Subject: [PATCH] regulator: aw37503: Switch back to use struct i2c_driver's .probe()
Date:   Thu, 24 Aug 2023 21:56:17 +0200
Message-Id: <20230824195617.8888-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=KrH8vyghKPickuvH0djIWTv3phvcLK1veIPXqtGufpU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk57XgUyCMYvcNHCQ9YVSi83cA0UzJaHcHoGGTn G8DJQFTLJ2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZOe14AAKCRCPgPtYfRL+ Tlb1B/4i29lFiUu9UI/Ysr+vo+Vhk7nclFAezp+Uc8YgSRUEL2e4/bsflrekYJD8A0A5wDmGqJQ zW0ZEsqxkW9zRu6bnvEfySnDFxp1QWtBGct+NWyJFBA2EcxfFHF+8ChI9KEyH8eCXTf8dKUqmBI Ph4gbWlnyPR1qZyVv7HMLmLkH66wohFj35mRGTb/X3NZPy0zvqpBL8na4IxQAQEeDkJrUg7PBPb hlGG5uh/iz83EhQK0WcqffEldtMY1mJFwkM9HBSgfI2+6x/nZQ6KYcB4qPJjPd14YxWuOrxTlRq a+GdkDiqdETOMesVM/GbUm4+3biMFcwveHy7tgQJQcatVpoC
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct i2c_driver::probe_new is about to go away. Switch the driver to
use the probe callback with the same prototype.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

yet another new regulator driver using .probe_new() introduced in
next-20230823.

Best regards
Uwe

 drivers/regulator/aw37503-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/aw37503-regulator.c b/drivers/regulator/aw37503-regulator.c
index e01ef6ad3eb8..a5ff6dfd29b5 100644
--- a/drivers/regulator/aw37503-regulator.c
+++ b/drivers/regulator/aw37503-regulator.c
@@ -229,7 +229,7 @@ static struct i2c_driver aw37503_i2c_driver = {
 		.name = "aw37503",
 		.of_match_table = aw37503_of_match,
 	},
-	.probe_new = aw37503_probe,
+	.probe = aw37503_probe,
 	.id_table = aw37503_id,
 };
 

base-commit: 2796a01cdf2c639e605088c53a1ac36923ade93c
-- 
2.40.1

