Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EAC7CE133
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjJRP3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjJRP3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:29:47 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E21911C;
        Wed, 18 Oct 2023 08:29:43 -0700 (PDT)
Received: from anderl.fritz.box ([31.220.117.52]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M6DrU-1qvJH9150C-006ipT; Wed, 18 Oct 2023 17:29:23 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sergei Korolev <dssoftsk@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>
Subject: [PATCH] iio: bmp280: fix eoc interrupt usage
Date:   Wed, 18 Oct 2023 17:28:16 +0200
Message-Id: <20231018152816.56589-1-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nVIfArh+ACgV1NyAM+Org8TtE666lV4/Eim/mlj1rKNf9qDhtbe
 uDDWUIn500623kjcT1k8VfMaRh96PF4JqMYueQar2YKbO4dBHB4MASJrgs6ChHZ6Nf77apg
 q7bHS1wTw7L6YLT7OrO6Z9SvhWQi3rkGH2/gdJn7Hw+A4NsBbBbdEHJERN0jwsl3cUioAba
 FuX53Ahl5tYJ4X1BOh3pA==
UI-OutboundReport: notjunk:1;M01:P0:RIzKeBoNxnc=;WtVtJ/V5MjQ226125xic9IEFupG
 KMIILVfmhzy2K6yAjPP+ql/HqFGkPFULubhTxHYN4KgQSWXzZB93A8GWiqp2BW2T0PzgRqIsG
 rSDE3HAN90aCresdy36oBP3UuhKQCPSAlDCx+jz3jvg2z+SimiVGfaLfriw9wCWO4fSi6RKbW
 WD51kD+vYYwy7WdhxsoQkVkczidHo1QoUFxOyh75I12LVnn/DJfUbYe5G3ygVVIlPQs7etbFr
 y+hX7H2IytDha4V0CUmo1fozPn7xpG0d5fJ1vKo4k7DPfenGTAXMIpd5eflet5HAkYzP1Ifob
 vpmPlmCKnvNeNjOAlY6qCm1Ulo0oOGzc3c7av1bU+d508x1XFFzfPmq/nWSOHydkT3mjFAInT
 u0dzkFA7TiM5EjpSI90ZgzvMHwchT6JBQ+UOPbluWQEJBx9tNjuz8uwI7lCCM8YqWNZGzMCOj
 EW6Qvg/xO/dmsVpfkeLpr77ULxaYprhb3kkh6hdvt2MxarrSLk/7hG7ix63DfOA9sJvkEyCyF
 XsK1h60be35n4/buJZBmqz9XhUZVpGxj5EFfkI5/L4eM7CP1TVRInM71vCNVHQpw6V9UV8iLK
 m5FFnepRUwmrfqfYnMCwvAxgO1t7xDCYewUibOEDpsGxNM3J/fzqY3L4mPwH6K9atEnVgS1KB
 NaMIAwwJ/Gg48eDGY8IC3Ecs1Enc4fIGIOfYYfewVfxx4Y8NUiO7aH3D/7XP3zhSLaYEmuIQS
 I6G+TC/R/ASTBhDQRrDXrGVbShCwsrjCwU6V8LK8ce5FMOnVo/IesKmZVuXMqYIoTIFlHe1SW
 WJlUydrygy+Ar3+9+OgecxVxdsdmyZ8FpuYL5FQdGdo6bOWitMFR8ngL4azK1H74ln/dH0guQ
 pzSF3vYBigRA1fA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only the bmp085 can have an End-Of-Conversion (EOC) interrupt. But the
bmp085 and bmp180 share the same chip id. Therefore it's necessary to
distinguish the case in which the interrupt is set.

Fix the if statement so that only when the interrupt is set and the chip
id is recognized the interrupt is requested.

This bug exists since the support of EOC interrupt was introduced.
Fixes: aae953949651 ("iio: pressure: bmp280: add support for BMP085 EOC interrupt")

Also add a link to bmp085 datasheet for reference.

Suggested-by: Sergei Korolev <dssoftsk@gmail.com>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/pressure/bmp280-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6089f3f9d8f4..9b7beeb1c088 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -9,6 +9,7 @@
  * Driver for Bosch Sensortec BMP180 and BMP280 digital pressure sensor.
  *
  * Datasheet:
+ * https://www.sparkfun.com/datasheets/Components/General/BST-BMP085-DS000-05.pdf
  * https://cdn-shop.adafruit.com/datasheets/BST-BMP180-DS000-09.pdf
  * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp280-ds001.pdf
  * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme280-ds002.pdf
@@ -2179,7 +2180,7 @@ int bmp280_common_probe(struct device *dev,
 	 * however as it happens, the BMP085 shares the chip ID of BMP180
 	 * so we look for an IRQ if we have that.
 	 */
-	if (irq > 0 || (chip_id  == BMP180_CHIP_ID)) {
+	if (irq > 0 && (chip_id  == BMP180_CHIP_ID)) {
 		ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
 		if (ret)
 			return ret;
-- 
2.39.2

