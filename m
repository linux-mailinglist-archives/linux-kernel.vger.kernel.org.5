Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAEE7743EC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbjHHSMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbjHHSL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:11:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FFF168B44;
        Tue,  8 Aug 2023 10:15:49 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKr654QSJz1hwFW;
        Tue,  8 Aug 2023 19:08:45 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 19:11:34 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next] leds: remove redundant of_match_ptr()
Date:   Tue, 8 Aug 2023 19:11:08 +0800
Message-ID: <20230808111108.24262-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver depends on CONFIG_OF, so it is not necessary to use
of_match_ptr() here. We remove both CONFIG_OF and of_match_ptr() here.

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 drivers/leds/leds-an30259a.c | 2 +-
 drivers/leds/leds-aw2013.c   | 2 +-
 drivers/leds/leds-lp5521.c   | 5 ++---
 drivers/leds/leds-lp5523.c   | 4 +---
 drivers/leds/leds-lp5562.c   | 4 +---
 drivers/leds/leds-lp8501.c   | 4 +---
 6 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/leds/leds-an30259a.c b/drivers/leds/leds-an30259a.c
index 24b1041213c2..0216afed3b6e 100644
--- a/drivers/leds/leds-an30259a.c
+++ b/drivers/leds/leds-an30259a.c
@@ -344,7 +344,7 @@ MODULE_DEVICE_TABLE(i2c, an30259a_id);
 static struct i2c_driver an30259a_driver = {
 	.driver = {
 		.name = "leds-an30259a",
-		.of_match_table = of_match_ptr(an30259a_match_table),
+		.of_match_table = an30259a_match_table,
 	},
 	.probe = an30259a_probe,
 	.remove = an30259a_remove,
diff --git a/drivers/leds/leds-aw2013.c b/drivers/leds/leds-aw2013.c
index 59765640b70f..a562c01c9775 100644
--- a/drivers/leds/leds-aw2013.c
+++ b/drivers/leds/leds-aw2013.c
@@ -420,7 +420,7 @@ MODULE_DEVICE_TABLE(of, aw2013_match_table);
 static struct i2c_driver aw2013_driver = {
 	.driver = {
 		.name = "leds-aw2013",
-		.of_match_table = of_match_ptr(aw2013_match_table),
+		.of_match_table = aw2013_match_table,
 	},
 	.probe = aw2013_probe,
 	.remove = aw2013_remove,
diff --git a/drivers/leds/leds-lp5521.c b/drivers/leds/leds-lp5521.c
index 030c040fdf6d..2ef19ad23b1d 100644
--- a/drivers/leds/leds-lp5521.c
+++ b/drivers/leds/leds-lp5521.c
@@ -594,18 +594,17 @@ static const struct i2c_device_id lp5521_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, lp5521_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id of_lp5521_leds_match[] = {
 	{ .compatible = "national,lp5521", },
 	{},
 };
 
 MODULE_DEVICE_TABLE(of, of_lp5521_leds_match);
-#endif
+
 static struct i2c_driver lp5521_driver = {
 	.driver = {
 		.name	= "lp5521",
-		.of_match_table = of_match_ptr(of_lp5521_leds_match),
+		.of_match_table = of_lp5521_leds_match,
 	},
 	.probe		= lp5521_probe,
 	.remove		= lp5521_remove,
diff --git a/drivers/leds/leds-lp5523.c b/drivers/leds/leds-lp5523.c
index daa6a165fba6..38de853f9939 100644
--- a/drivers/leds/leds-lp5523.c
+++ b/drivers/leds/leds-lp5523.c
@@ -972,7 +972,6 @@ static const struct i2c_device_id lp5523_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, lp5523_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id of_lp5523_leds_match[] = {
 	{ .compatible = "national,lp5523", },
 	{ .compatible = "ti,lp55231", },
@@ -980,12 +979,11 @@ static const struct of_device_id of_lp5523_leds_match[] = {
 };
 
 MODULE_DEVICE_TABLE(of, of_lp5523_leds_match);
-#endif
 
 static struct i2c_driver lp5523_driver = {
 	.driver = {
 		.name	= "lp5523x",
-		.of_match_table = of_match_ptr(of_lp5523_leds_match),
+		.of_match_table = of_lp5523_leds_match,
 	},
 	.probe		= lp5523_probe,
 	.remove		= lp5523_remove,
diff --git a/drivers/leds/leds-lp5562.c b/drivers/leds/leds-lp5562.c
index 4565cc12cea8..39db9aeb67c5 100644
--- a/drivers/leds/leds-lp5562.c
+++ b/drivers/leds/leds-lp5562.c
@@ -589,19 +589,17 @@ static const struct i2c_device_id lp5562_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, lp5562_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id of_lp5562_leds_match[] = {
 	{ .compatible = "ti,lp5562", },
 	{},
 };
 
 MODULE_DEVICE_TABLE(of, of_lp5562_leds_match);
-#endif
 
 static struct i2c_driver lp5562_driver = {
 	.driver = {
 		.name	= "lp5562",
-		.of_match_table = of_match_ptr(of_lp5562_leds_match),
+		.of_match_table = of_lp5562_leds_match,
 	},
 	.probe		= lp5562_probe,
 	.remove		= lp5562_remove,
diff --git a/drivers/leds/leds-lp8501.c b/drivers/leds/leds-lp8501.c
index f11886aa8965..ac50aa88939a 100644
--- a/drivers/leds/leds-lp8501.c
+++ b/drivers/leds/leds-lp8501.c
@@ -380,19 +380,17 @@ static const struct i2c_device_id lp8501_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, lp8501_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id of_lp8501_leds_match[] = {
 	{ .compatible = "ti,lp8501", },
 	{},
 };
 
 MODULE_DEVICE_TABLE(of, of_lp8501_leds_match);
-#endif
 
 static struct i2c_driver lp8501_driver = {
 	.driver = {
 		.name	= "lp8501",
-		.of_match_table = of_match_ptr(of_lp8501_leds_match),
+		.of_match_table = of_lp8501_leds_match,
 	},
 	.probe		= lp8501_probe,
 	.remove		= lp8501_remove,
-- 
2.17.1

