Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77240788499
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244117AbjHYKRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244096AbjHYKRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:17:21 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C243826B9;
        Fri, 25 Aug 2023 03:16:39 -0700 (PDT)
Received: from tundra.lovozera (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id B430F40F1DC6;
        Fri, 25 Aug 2023 10:15:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B430F40F1DC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1692958549;
        bh=kKznDWybMt3pUOgS2VaRpyBJI19OwHraJWYAQXNusOI=;
        h=From:To:Cc:Subject:Date:From;
        b=bYKgv83lcUXnxg3+5kf0gJvjUt7di+rlvBPNGeVcErEiI43n5nO4jrxM3vAJhegNT
         zpw1lX1wr4DfqWf+uAthxCu36FfNwo7hHIBlU+L/2S8J68NHhIIKF+Gke+/MolNmlk
         zAJVFnQyJPcUeCf+T1Pkb+J0U+OEyvDMFAy0W2bw=
From:   Mikhail Kobuk <m.kobuk@ispras.ru>
To:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Mikhail Kobuk <m.kobuk@ispras.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] pinctrl: nuvoton: wpcm450: fix out of bounds write
Date:   Fri, 25 Aug 2023 13:15:28 +0300
Message-ID: <20230825101532.6624-1-m.kobuk@ispras.ru>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Write into 'pctrl->gpio_bank' happens before the check for GPIO index
validity, so out of bounds write may happen.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a1d1e0e3d80a ("pinctrl: nuvoton: Add driver for WPCM450")
Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
Reviewed-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
index 2d1c1652cfd9..8a9961ac8712 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
@@ -1062,13 +1062,13 @@ static int wpcm450_gpio_register(struct platform_device *pdev,
 		if (ret < 0)
 			return ret;
 
-		gpio = &pctrl->gpio_bank[reg];
-		gpio->pctrl = pctrl;
-
 		if (reg >= WPCM450_NUM_BANKS)
 			return dev_err_probe(dev, -EINVAL,
 					     "GPIO index %d out of range!\n", reg);
 
+		gpio = &pctrl->gpio_bank[reg];
+		gpio->pctrl = pctrl;
+
 		bank = &wpcm450_banks[reg];
 		gpio->bank = bank;
 
-- 
2.42.0

