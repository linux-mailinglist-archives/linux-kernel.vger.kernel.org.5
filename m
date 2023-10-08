Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2616F7BCB76
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 03:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344351AbjJHBRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 21:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjJHBRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 21:17:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27003212A;
        Sat,  7 Oct 2023 17:50:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E648C433BD;
        Sun,  8 Oct 2023 00:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726220;
        bh=ZxLTp2cbLb9eo1xQ5FrKJgFWIe79ItBd51kd3aNbBl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQuKEsGHSsO8tMKT3uikQV86LHSy8rSrbi/vc239cz8MErKnvkELNfQJCDC6CLPcX
         Bmmc2d4Legka0dlI8Rlk5R6PbQm5dFuDmxsLJnqa3gi+hz6iqAKRVixsUdZW+Obctn
         AoV9IWCATxcPBljITmfLloi7NF6EhCDJBtQ/vEhpFZxGDzcvQOd+IhepsXTeCMeDP5
         x+dC9nfGoT7e7KtLSSAzoYSmiw7Xs/HyrmDkNh35eHab/AoFtuTUXLPm3ccL5ORKsM
         Wuw6qiYGp6fvG8CiRW8NzPo8B0pQ/1K0vFI2HNITeQn1wAHqAzEgDkdMg+AAI3gnf9
         4G+HyWQKktpoA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chengfeng Ye <dg573847474@gmail.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 6/8] gpio: timberdale: Fix potential deadlock on &tgpio->lock
Date:   Sat,  7 Oct 2023 20:50:07 -0400
Message-Id: <20231008005009.3768314-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008005009.3768314-1-sashal@kernel.org>
References: <20231008005009.3768314-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.197
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengfeng Ye <dg573847474@gmail.com>

[ Upstream commit 9e8bc2dda5a7a8e2babc9975f4b11c9a6196e490 ]

As timbgpio_irq_enable()/timbgpio_irq_disable() callback could be
executed under irq context, it could introduce double locks on
&tgpio->lock if it preempts other execution units requiring
the same locks.

timbgpio_gpio_set()
--> timbgpio_update_bit()
--> spin_lock(&tgpio->lock)
<interrupt>
   --> timbgpio_irq_disable()
   --> spin_lock_irqsave(&tgpio->lock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential deadlock, the patch uses spin_lock_irqsave()
on &tgpio->lock inside timbgpio_gpio_set() to prevent the possible
deadlock scenario.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-timberdale.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-timberdale.c b/drivers/gpio/gpio-timberdale.c
index de14949a3fe5a..92c1f2baa4bff 100644
--- a/drivers/gpio/gpio-timberdale.c
+++ b/drivers/gpio/gpio-timberdale.c
@@ -43,9 +43,10 @@ static int timbgpio_update_bit(struct gpio_chip *gpio, unsigned index,
 	unsigned offset, bool enabled)
 {
 	struct timbgpio *tgpio = gpiochip_get_data(gpio);
+	unsigned long flags;
 	u32 reg;
 
-	spin_lock(&tgpio->lock);
+	spin_lock_irqsave(&tgpio->lock, flags);
 	reg = ioread32(tgpio->membase + offset);
 
 	if (enabled)
@@ -54,7 +55,7 @@ static int timbgpio_update_bit(struct gpio_chip *gpio, unsigned index,
 		reg &= ~(1 << index);
 
 	iowrite32(reg, tgpio->membase + offset);
-	spin_unlock(&tgpio->lock);
+	spin_unlock_irqrestore(&tgpio->lock, flags);
 
 	return 0;
 }
-- 
2.40.1

