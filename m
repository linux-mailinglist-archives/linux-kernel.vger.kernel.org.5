Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ECB802111
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 06:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbjLCFV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 00:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCFV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 00:21:57 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1161FA
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 21:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=v5VLYo1m6rroXNWaOj
        aGYahbcfUp99xMm3CUVwkBPak=; b=VKQiaUVWMdS910eFG5Ykei/8lzGL0+vBOZ
        vuI94WvtzFM7g2BX1OfgXl9rHLURMZ3xVXvA+WMPXXJl67CvU/vhztpEdJ4GWmwG
        mar6lTlIjmnyV54NHr9LSv9BLZhM9jWObMya2xWCjNhsKFOKDp836abdI2LCCJ+t
        wHVxuNu0w=
Received: from localhost.localdomain (unknown [39.144.190.5])
        by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wDnjw5gEGxlXxYvCw--.4698S2;
        Sun, 03 Dec 2023 13:21:38 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     support.opensource@diasemi.com
Cc:     lee@kernel.org, linux-kernel@vger.kernel.org,
        Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [mfd] da9052: Add error handling for spi_setup in da9052_spi_probe
Date:   Sat,  2 Dec 2023 21:21:25 -0800
Message-Id: <20231203052125.37334-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wDnjw5gEGxlXxYvCw--.4698S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww47Xw1kGr18Aw4DtF4kCrg_yoW8Cr43pF
        WUG3Z8CFWkJw4rCw47JF4xZF1YkayrWrWUGrsrK392y3Z8ZFyDAryIqryUZ3s8GFZrAa17
        Zw1qvryrua1UAaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRn2-nUUUUU=
X-Originating-IP: [39.144.190.5]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/xtbBcgA7gletj-7cGAAAsE
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds error handling for the spi_setup call. The need for this
error handling was identified through static analysis, which highlighted
the lack of proper handling for potential failures of spi_setup.
Previously, a failure in spi_setup could lead to unstable behavior of
the DA9052 device.

Although the error addressed by this patch may not occur in the current
environment, I still suggest implementing these error handling routines
if the function is not highly time-sensitive. As the environment evolves
or the code gets reused in different contexts, there's a possibility that
these errors might occur. In case you find this addition unnecessary, I
completely understand and respect your perspective. My intention was to
enhance the robustness of the code, but I acknowledge that practical
considerations and current functionality might not warrant this change
at this point.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/mfd/da9052-spi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/da9052-spi.c b/drivers/mfd/da9052-spi.c
index be5f2b34e18a..c32d5025a18f 100644
--- a/drivers/mfd/da9052-spi.c
+++ b/drivers/mfd/da9052-spi.c
@@ -22,6 +22,7 @@ static int da9052_spi_probe(struct spi_device *spi)
 	int ret;
 	const struct spi_device_id *id = spi_get_device_id(spi);
 	struct da9052 *da9052;
+	int ret;
 
 	da9052 = devm_kzalloc(&spi->dev, sizeof(struct da9052), GFP_KERNEL);
 	if (!da9052)
@@ -29,7 +30,11 @@ static int da9052_spi_probe(struct spi_device *spi)
 
 	spi->mode = SPI_MODE_0;
 	spi->bits_per_word = 8;
-	spi_setup(spi);
+	ret = spi_setup(spi);
+	if (ret) {
+		dev_err(&spi->dev, "spi_setup failed: %d\n", ret);
+		return ret;
+	}
 
 	da9052->dev = &spi->dev;
 	da9052->chip_irq = spi->irq;
-- 
2.17.1

