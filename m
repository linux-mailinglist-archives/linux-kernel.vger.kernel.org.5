Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36367908B1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 18:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjIBQcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 12:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjIBQcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 12:32:42 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BABCCC5;
        Sat,  2 Sep 2023 09:32:38 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,222,1688396400"; 
   d="scan'208";a="174798428"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Sep 2023 01:32:38 +0900
Received: from localhost.localdomain (unknown [10.226.92.16])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id E6A52401D15B;
        Sun,  3 Sep 2023 01:32:35 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: [PATCH] iio: adc: ti-ads1015: Simplify probe()
Date:   Sat,  2 Sep 2023 17:32:33 +0100
Message-Id: <20230902163233.56449-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simpilfy probe() by replacing device_get_match_data() and id lookup for
retrieving match data by using i2c_get_match_data().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/iio/adc/ti-ads1015.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 075c75a87544..9984515bfdea 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -976,16 +976,13 @@ static int ads1015_set_conv_mode(struct ads1015_data *data, int mode)
 
 static int ads1015_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	const struct ads1015_chip_data *chip;
 	struct iio_dev *indio_dev;
 	struct ads1015_data *data;
 	int ret;
 	int i;
 
-	chip = device_get_match_data(&client->dev);
-	if (!chip)
-		chip = (const struct ads1015_chip_data *)id->driver_data;
+	chip = i2c_get_match_data(client);
 	if (!chip)
 		return dev_err_probe(&client->dev, -EINVAL, "Unknown chip\n");
 
-- 
2.25.1

