Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7887AEA63
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbjIZK3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbjIZK31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:29:27 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96526FB;
        Tue, 26 Sep 2023 03:29:20 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso6251990b3a.0;
        Tue, 26 Sep 2023 03:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695724160; x=1696328960; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qonb/48NxgSMrYoPiUlqmSZTRy7YmQA9LcOLKLZ8KWY=;
        b=eyXBqnBSkZyMv5NPK6XFVn/U+ly2Zy8Rjxok5C9KWaN25tDrIUpNNnWDWfzCvwB//6
         d9iXkIi3Ta501ToDZo5/hTuVOHfkPyTzQNJG1j0XOHJI3Bso+5zXOmC72reNyXD2PHrw
         9JAVeO1Tlh+NWVSs+EOqq6kz2wHtS2cuNDHP0vnJgSvH9sHz5FSCwicNTD+Ukx3KtTnF
         Avi7Zr6dqPATtg43531BAjRO5AjPF/9QTF9DIr0lHQIpjEYnJ74kQZ8DTeoCA7b9vkDh
         3kwcXiEyyvdB8X4YJLr8DS3fr5WqD1rBG2lv6hvIbr3FQD+bRb+SgRH8NB9TuWD0fMg5
         b4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695724160; x=1696328960;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qonb/48NxgSMrYoPiUlqmSZTRy7YmQA9LcOLKLZ8KWY=;
        b=nI7JtKni6CJaB75z3NSQgkDf7ASli+X1vy53kohoomXPDRSlue51dc5eRAUTOTD9yA
         QbVerkHNefa3PjON0oFExBwg3lpRhZrTvnjG5c0YMqsDefQ9+jiHddgVPJpXqwq+Q3XG
         wr08dQobxTkj7mqHtHb47PzuDudH0gDgKnXZ+ZbXYpPiAEbI9j4Emp7V3hpw+ZD9TeC2
         bhkQxv5qvtPwR1iekwuoVpXT1maWtHEbioh2H4a948IBIHuI/Ff6v9ocCNcyWfKGpGXB
         dHRc0to7FZ7fpc81mIMuiuxUFCpeTEQWQSOd5qXvjlYHi8R4TjUmBfi44K9jrUioYgns
         7+/A==
X-Gm-Message-State: AOJu0YyaOSBrfs2eSOIf9d5rKpTCpKmEdnV7YUHvqF5fGnV9TtvNj1x+
        8SStSXGGxLdmjNe05ToXStw=
X-Google-Smtp-Source: AGHT+IHXy98IULbI9MEELFASDJhU2Ctpv78t0HJ0G6bCOilqE3OS5LasbnvVvrJmltc3mePrXdm5lA==
X-Received: by 2002:a05:6a00:2e9f:b0:692:6417:728a with SMTP id fd31-20020a056a002e9f00b006926417728amr3627838pfb.14.1695724159838;
        Tue, 26 Sep 2023 03:29:19 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id m18-20020aa78a12000000b0068a2d78890csm9612667pfa.68.2023.09.26.03.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 03:29:19 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        alex@shruggie.ro, aboutphysycs@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] gpio: timberdale: Fix potential deadlock on &tgpio->lock
Date:   Tue, 26 Sep 2023 10:29:14 +0000
Message-Id: <20230926102914.6145-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/gpio/gpio-timberdale.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-timberdale.c b/drivers/gpio/gpio-timberdale.c
index bbd9e9191199..fad979797486 100644
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
2.17.1

