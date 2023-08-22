Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA371783A45
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjHVHFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjHVHFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:05:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D970130;
        Tue, 22 Aug 2023 00:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692687901; x=1724223901;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mbSEUKxzfd+NdbCyXSlyZygqZr+zo6Ad1ijqItVCU3c=;
  b=dOS7gX/8JgxcK1Wv/yuQChxxSEVKJbnPHvzWLNkX3lilgkj4zvz1tR1q
   m1kfZJFAHW4Cg/Yf1WfjC3GFa5c2NmloQCukeprYM20IZQIc/BYyoqlv3
   pOhTtq1uRjmtaWIULuqJdkXBT/WGV2daTH298C2Rm3NISjaehI6Q8EtM+
   XofkDcUcHRR07WlN9cDec0T5AanYvqbsN58A5BJZrdtMo5huLExJfbho/
   kMv9siqw6hbEjpMrF7BQmgH7V602pSI0Kaq19Kyt1Ird9sb9hpKw8oRu6
   Wla8M8AcccFu6ve01pENjl99ggSNzUrSWSqF6ZFBKA+28Aa7jcdgsS0g9
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="608536"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Aug 2023 00:04:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 22 Aug 2023 00:04:54 -0700
Received: from che-lt-i63539.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 22 Aug 2023 00:04:50 -0700
From:   Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>
CC:     <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
Subject: [PATCH] pwm: atmel: add missing clk_disable_unprepare()
Date:   Tue, 22 Aug 2023 12:34:41 +0530
Message-ID: <20230822070441.22170-1-Hari.PrasathGE@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the below smatch warning:

drivers/pwm/pwm-atmel-hlcdc.c:167 atmel_hlcdc_pwm_apply() warn: 'new_clk' from clk_prepare_enable() not released on lines: 112,137,142,149.

Signed-off-by: Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 96a709a9d49a..ce46f6c74a14 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -108,8 +108,10 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 						 ATMEL_HLCDC_CFG(0),
 						 ATMEL_HLCDC_CLKPWMSEL,
 						 gencfg);
-			if (ret)
+			if (ret) {
+				clk_disable_unprepare(new_clk);
 				return ret;
+			}
 		}
 
 		do_div(pwmcval, state->period);
@@ -133,20 +135,27 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 					 ATMEL_HLCDC_PWMPS_MASK |
 					 ATMEL_HLCDC_PWMPOL,
 					 pwmcfg);
-		if (ret)
+		if (ret) {
+			clk_disable_unprepare(new_clk);
 			return ret;
+		}
 
 		ret = regmap_write(hlcdc->regmap, ATMEL_HLCDC_EN,
 				   ATMEL_HLCDC_PWM);
-		if (ret)
+		if (ret) {
+			clk_disable_unprepare(new_clk);
 			return ret;
+		}
 
 		ret = regmap_read_poll_timeout(hlcdc->regmap, ATMEL_HLCDC_SR,
 					       status,
 					       status & ATMEL_HLCDC_PWM,
 					       10, 0);
-		if (ret)
+		if (ret) {
+			clk_disable_unprepare(new_clk);
 			return ret;
+		}
+
 	} else {
 		ret = regmap_write(hlcdc->regmap, ATMEL_HLCDC_DIS,
 				   ATMEL_HLCDC_PWM);
-- 
2.34.1

