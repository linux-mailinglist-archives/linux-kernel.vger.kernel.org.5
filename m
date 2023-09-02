Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602E37908CC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 19:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbjIBRFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 13:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjIBRFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 13:05:38 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F454E5B;
        Sat,  2 Sep 2023 10:05:35 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,222,1688396400"; 
   d="scan'208";a="178507164"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2023 02:05:34 +0900
Received: from localhost.localdomain (unknown [10.226.92.16])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6F6D5402F022;
        Sun,  3 Sep 2023 02:05:32 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] iio: adc: ltc2497: Simplify probe()
Date:   Sat,  2 Sep 2023 18:05:29 +0100
Message-Id: <20230902170529.62297-1-biju.das.jz@bp.renesas.com>
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
 drivers/iio/adc/ltc2497.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index 5bdd40729611..6401a7727c31 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -95,7 +95,6 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
 
 static int ltc2497_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	const struct ltc2497_chip_info *chip_info;
 	struct iio_dev *indio_dev;
 	struct ltc2497_driverdata *st;
@@ -115,9 +114,7 @@ static int ltc2497_probe(struct i2c_client *client)
 	st->client = client;
 	st->common_ddata.result_and_measure = ltc2497_result_and_measure;
 
-	chip_info = device_get_match_data(dev);
-	if (!chip_info)
-		chip_info = (const struct ltc2497_chip_info *)id->driver_data;
+	chip_info = i2c_get_match_data(client);
 	st->common_ddata.chip_info = chip_info;
 
 	resolution = chip_info->resolution;
-- 
2.25.1

