Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099657A1861
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjIOINh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjIOIMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:12:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44B0273A;
        Fri, 15 Sep 2023 01:12:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15F5EC4AF76;
        Fri, 15 Sep 2023 08:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694765530;
        bh=yKUblyNTN6kwmF+RWX1aVXoY+wU5AIa2upmTHQZr7yI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=nvop3p146lwUG2JZ7e6Dp6IYLCZn76HZrmqm++0RCL2vOeEmh5z34Yx3vCo/paF2T
         z6gMwZiGpGjx59tu2dzOiUR4DhKKaym+GWtGibT1EJxg52vIC5grPWTnAsmGBanf23
         k4e36q2aOGh2MAt+EBXDb1+O+++JHFMTx193QDRYTFhxurpV2IbyFTOCwDpppOMQ1t
         w6BcFfFn1LzY55nXrfOyJDtFycvXr0tKZ+eupFgjhClmFxOZQQGnqn0tLTNacABxx4
         lfV6PpM+8pnbOAyca2sIuAOkjcBbu4DKKzXZ+pUmwZpwmT7FwbkoMYMLyE5yMSJx9d
         aAzO5ezsSKt5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 03115EE6442;
        Fri, 15 Sep 2023 08:12:10 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Fri, 15 Sep 2023 11:11:15 +0300
Subject: [PATCH v4 33/42] gpio: ep93xx: add DT support for gpio-ep93xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-ep93xx-v4-33-a1d779dcec10@maquefel.me>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
In-Reply-To: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694765525; l=993;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=7aghjn0T8vOwVoAvLNTsUFeOUJ29//nTopj4QzfsLDY=; =?utf-8?q?b=3DAGYuLmPootuN?=
 =?utf-8?q?hLbbH2svn6HFna04C+gkHGzYfYza0zy7TRRPpO8KQq2+wKKIvIFlk9J6DHB/UP/o?=
 07r5mctyA2ydriJwLu52ZlLPUgMWYiKQKtCAZT825+XpCHJqxfJC
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add OF ID match table.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/gpio/gpio-ep93xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index a55f635585f4..70997232257a 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -359,9 +359,15 @@ static int ep93xx_gpio_probe(struct platform_device *pdev)
 	return devm_gpiochip_add_data(&pdev->dev, gc, egc);
 }
 
+static const struct of_device_id ep93xx_gpio_match[] = {
+	{ .compatible = "cirrus,ep9301-gpio" },
+	{ /* sentinel */ }
+};
+
 static struct platform_driver ep93xx_gpio_driver = {
 	.driver		= {
 		.name	= "gpio-ep93xx",
+		.of_match_table = ep93xx_gpio_match,
 	},
 	.probe		= ep93xx_gpio_probe,
 };

-- 
2.39.2

