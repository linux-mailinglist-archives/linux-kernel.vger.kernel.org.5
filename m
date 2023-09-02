Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34788790595
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 08:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351649AbjIBGcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 02:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjIBGcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 02:32:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F409D10FA;
        Fri,  1 Sep 2023 23:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693636364; x=1725172364;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3bgN04HCBhGYUCnjps2teOWZvkuLkjNIxGd9f26pwBY=;
  b=xsMNzJNsqkha67b+A1t4QGNDAbIqDpDIwTDBfRbQfe629fuuGxKNBMF6
   +jLJYvkOy/hRETe79Gk3IvFTpaGEEdoLaOGoGxgK/5qb8XDeWMBkTlgZg
   ljMkLY3/f45vt8EZs9PabwIrQ69JrAMAU9gJC2/V0GC4H0VstTXZo9tMX
   E2YjGs1uVtjTjEAAU52MmQzbgSmFKq7xKaaO9W+OFXHyeXtfbn89LRBB8
   AWFtACHY0lrh48X4zWkgcut3SCf03nOM5hVIpO/DNUtX4rzoq1jEC1ou1
   2Rs2Ct8jTo1Qn2jEDDdr5u+e+X0vHqzxaw9/sLBOWgvPiDQoYlMlL40po
   g==;
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="2544931"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2023 23:32:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 1 Sep 2023 23:32:39 -0700
Received: from che-lt-i63539.amer.actel.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 1 Sep 2023 23:32:35 -0700
From:   Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>
CC:     <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
Subject: [PATCH v2] pwm: atmel: add missing clk_disable_unprepare()
Date:   Sat, 2 Sep 2023 12:02:32 +0530
Message-ID: <20230902063232.22620-1-Hari.PrasathGE@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the below smatch warning:

drivers/pwm/pwm-atmel-hlcdc.c:167 atmel_hlcdc_pwm_apply() warn: 'new_clk' from clk_prepare_enable() not released on lines: 112,137,142,149.

'Fixes: 2b4984bef47a5 ("pwm: atmel-hlcdc: Convert to the atomic PWM API")'

Signed-off-by: Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>

changelog of v2:

         - moved the clk_disable_unprepare to single point of return.
         - cur_clk set to NULL before return.
---
 drivers/pwm/pwm-atmel-hlcdc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 96a709a9d49a..4d35b838203f 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -44,7 +44,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 	struct atmel_hlcdc_pwm *chip = to_atmel_hlcdc_pwm(c);
 	struct atmel_hlcdc *hlcdc = chip->hlcdc;
 	unsigned int status;
-	int ret;
+	int ret = 0;
 
 	if (state->enabled) {
 		struct clk *new_clk = hlcdc->slow_clk;
@@ -109,7 +109,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 						 ATMEL_HLCDC_CLKPWMSEL,
 						 gencfg);
 			if (ret)
-				return ret;
+				goto disable_new_clk;
 		}
 
 		do_div(pwmcval, state->period);
@@ -134,18 +134,20 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 					 ATMEL_HLCDC_PWMPOL,
 					 pwmcfg);
 		if (ret)
-			return ret;
+			goto disable_new_clk;
 
 		ret = regmap_write(hlcdc->regmap, ATMEL_HLCDC_EN,
 				   ATMEL_HLCDC_PWM);
 		if (ret)
-			return ret;
+			goto disable_new_clk;
 
 		ret = regmap_read_poll_timeout(hlcdc->regmap, ATMEL_HLCDC_SR,
 					       status,
 					       status & ATMEL_HLCDC_PWM,
 					       10, 0);
-		if (ret)
+disable_new_clk:
+			clk_disable_unprepare(new_clk);
+			chip->cur_clk = NULL;
 			return ret;
 	} else {
 		ret = regmap_write(hlcdc->regmap, ATMEL_HLCDC_DIS,
-- 
2.34.1

