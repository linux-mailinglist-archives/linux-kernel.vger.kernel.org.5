Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5335777C217
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjHNVIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjHNVIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:08:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6E3DD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:08:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qVenG-00043Z-VW; Mon, 14 Aug 2023 23:08:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qVenF-000ewN-7y; Mon, 14 Aug 2023 23:08:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qVenE-00D65c-Gc; Mon, 14 Aug 2023 23:08:04 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Alina Yu <alina_yu@richtek.com>
Subject: [PATCH] regulator: rtq2208: Switch back to use struct i2c_driver's .probe()
Date:   Mon, 14 Aug 2023 23:07:59 +0200
Message-Id: <20230814210759.26395-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1016; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hj0jpXzzMDeK6ffOJ76OGAbT2k0hMjBX4TsPAPOg/Zc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk2peu8jyctpUk/fZ1awXYMRmWdnEbW3XvljJ6X uiAFCaVfuWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNqXrgAKCRCPgPtYfRL+ Th+/B/oCnEu6x1EacCUpXkaLKc0tGP6H3mAxX9LdhVrqMvgc19bJJIkftDs6T7JZ4oAyaDOqyyc 6tJU9I1hu3ZSSOp6W+LtvfJekzXSb2Ie0uCiKrHmyuGYVKGrPu5ix8Qcm3CtwMPG2sKZ35yGwNE Pn8vDdRP/51ZswlFuQAYhKpJDt8raqv0KGokYakoqmuRMpk+tfWOS8kMLD0BS2fNZ/bMO4IKCVa PyVXavRJNcMP3Sa/7dqzF18Qlcmilm5qw/xSAru2vwFgwZ6SdcbnloDLIR2Q87i+xI9oQ8RLji4 8/UmHZYX1LxZI7n1JUityoO5aJM9GzmtX9/7qm0Evt2fEj1P
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

would be great if this was the last regulator driver I had to switch.
It's the fifth driver I had to fixup as it was added with .probe_new
after 964e186547b2.

Thanks
Uwe

 drivers/regulator/rtq2208-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rtq2208-regulator.c b/drivers/regulator/rtq2208-regulator.c
index 2463aea4192c..2d54844c4226 100644
--- a/drivers/regulator/rtq2208-regulator.c
+++ b/drivers/regulator/rtq2208-regulator.c
@@ -574,7 +574,7 @@ static struct i2c_driver rtq2208_driver = {
 		.name = "rtq2208",
 		.of_match_table = rtq2208_device_tables,
 	},
-	.probe_new = rtq2208_probe,
+	.probe = rtq2208_probe,
 };
 module_i2c_driver(rtq2208_driver);
 

base-commit: 85a11f55621a0c18b22b43ab4219450ac1d19386
-- 
2.40.1

