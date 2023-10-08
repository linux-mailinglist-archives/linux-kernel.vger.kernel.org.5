Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EE77BCB2F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 02:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjJHAxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 20:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjJHAxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 20:53:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BA02D64;
        Sat,  7 Oct 2023 17:51:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB24C43140;
        Sun,  8 Oct 2023 00:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726262;
        bh=Dhp40pBNB2ucCb+P1yiF8uzZMj2aodKJXYogWqXroCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MVaISciGppl7EtXYtGmJlVkjtImvnk8d4xtBcty4GaB7Nwt8X9IzU5Ek2z7q4pbYe
         UxYzuKfbSmx3JaD+g0VgMTzpX+H9AUukq3n336lT+ETZ+lztFCVEf11PXLQvWGFSkq
         6zePvBDh88OXo/5bGIjzNBKHpPeWBDEhXOn+tqf/rd5J99bMlUcdqghsAxgnGY7YF7
         +WZUQOMK8LO4vatHnHGiwbsjhM3CZz8XF6YfXvhnqLjl2vwY6ngNBx84T75f8DOiSM
         tZIqC9ZVo904PAYKQbZmIueDilZL5+k5qJt79l13J0RXJ8tdxXS5vMaRMk7cTRQzfo
         DK3rrVbYEVVJA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chengfeng Ye <dg573847474@gmail.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 5/7] gpio: timberdale: Fix potential deadlock on &tgpio->lock
Date:   Sat,  7 Oct 2023 20:50:51 -0400
Message-Id: <20231008005053.3768625-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008005053.3768625-1-sashal@kernel.org>
References: <20231008005053.3768625-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.326
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
index 181f86ce00cd4..639c8daaeb310 100644
--- a/drivers/gpio/gpio-timberdale.c
+++ b/drivers/gpio/gpio-timberdale.c
@@ -55,9 +55,10 @@ static int timbgpio_update_bit(struct gpio_chip *gpio, unsigned index,
 	unsigned offset, bool enabled)
 {
 	struct timbgpio *tgpio = gpiochip_get_data(gpio);
+	unsigned long flags;
 	u32 reg;
 
-	spin_lock(&tgpio->lock);
+	spin_lock_irqsave(&tgpio->lock, flags);
 	reg = ioread32(tgpio->membase + offset);
 
 	if (enabled)
@@ -66,7 +67,7 @@ static int timbgpio_update_bit(struct gpio_chip *gpio, unsigned index,
 		reg &= ~(1 << index);
 
 	iowrite32(reg, tgpio->membase + offset);
-	spin_unlock(&tgpio->lock);
+	spin_unlock_irqrestore(&tgpio->lock, flags);
 
 	return 0;
 }
-- 
2.40.1

