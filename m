Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E207B6086
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 07:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjJCFu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 01:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjJCFu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 01:50:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E609B8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 22:50:53 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bf3f59905so80744466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 22:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696312252; x=1696917052; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sWvUIyND0HCDU8OZGMQLwzLFIpQw7QMWwwvBYPky4c=;
        b=kyRW2dBv5Dk8hsOphlGDKwhsLOKGHfYBETgvTG7ZdLzZ8X9eCRfch9zLc6gb8qyRLI
         ZZaqMi7eItSWCpzzt75eU7u71RtYBYf5xvWOOY+IBfNywAqtzVV7FS7ldrODwsbFldBN
         GvA31RmwooXYCtTjGyt4UyXN4NmhwITDlN3+z9B5IZiP2E23MPCQW5ExebTIq0IPObg4
         ipetdvRlNMSHK35ZdwyUPgca/R3Qo2Gr8jSspl+5lJGp1N6t5fOhvx/T+mTeFG173xrD
         s2/hTo6IYFFJqP21aITiwW5LaOVfft8UHl9NS4nOv+4Bnu03mRyknv7ehjWZdeVNdHH/
         PYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696312252; x=1696917052;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sWvUIyND0HCDU8OZGMQLwzLFIpQw7QMWwwvBYPky4c=;
        b=TDC9ytZJEJXdE9x7J/3u/nNSSHwK6O8yybHklyvsiYWTrnguGt1XqeefdSrO1n2G0q
         yhd9X61t8BUg7Dn13r2sphqZROCciVJ8Q0dRYvuRUvbe1Os4NWNY0jfposYQwoFZWn1a
         +5dtBq6yHP5hvLRn4dl2YNjDjh1btkBANTyY35sFK/w5qB4K0X/RtBuyqwp42Daz7ISB
         OdMdCwmwmO6gaAlMx6FqPv2qO8Z2gWREL7S8xf1GqG4EiWOkB7oYx7i6s3R5loiJ9+wN
         lwr4wnoqtP48TuWbz8QY7CSYGmy9gsC3tbsPHZxuPHnWEqWa4WLb7D2vKTkDYgLM+jRe
         m+pA==
X-Gm-Message-State: AOJu0YyBbxgGOlj0nkvEKTcbRJOYRvsJXQcMABeJ3NX7ewH+W9odInWT
        QBZ/QscQd6CJAmkaC8LRfPA=
X-Google-Smtp-Source: AGHT+IEJpzQKuJnMxwVfMYNj0wbtWnCHpVww0VaY8cLi4FAsB17jAMdiN90/mks0QrfBECy50a/5wA==
X-Received: by 2002:a17:907:1dcc:b0:9ae:406c:3425 with SMTP id og12-20020a1709071dcc00b009ae406c3425mr13112083ejc.0.1696312251468;
        Mon, 02 Oct 2023 22:50:51 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id kj6-20020a170907764600b009ad88839665sm441309ejc.70.2023.10.02.22.50.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Oct 2023 22:50:51 -0700 (PDT)
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     tony@atomide.com, sean@mess.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] drivers/clocksource/timer-ti-dm: Don't call clk_get_rate() in stop function
Date:   Tue,  3 Oct 2023 08:50:20 +0300
Message-Id: <1696312220-11550-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_get_rate() might sleep, and that prevents dm-timer based PWM from being
used from atomic context.

Fix that by getting fclk rate in probe() and using a notifier in case rate
changes.

Fixes: af04aa856e93 ("ARM: OMAP: Move dmtimer driver out of plat-omap to drivers under clocksource")
Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/clocksource/timer-ti-dm.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 09ab29c..5f60f6b 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -140,6 +140,8 @@ struct dmtimer {
 	struct platform_device *pdev;
 	struct list_head node;
 	struct notifier_block nb;
+	struct notifier_block fclk_nb;
+	unsigned long fclk_rate;
 };
 
 static u32 omap_reserved_systimers;
@@ -253,8 +255,7 @@ static inline void __omap_dm_timer_enable_posted(struct dmtimer *timer)
 	timer->posted = OMAP_TIMER_POSTED;
 }
 
-static inline void __omap_dm_timer_stop(struct dmtimer *timer,
-					unsigned long rate)
+static inline void __omap_dm_timer_stop(struct dmtimer *timer)
 {
 	u32 l;
 
@@ -269,7 +270,7 @@ static inline void __omap_dm_timer_stop(struct dmtimer *timer,
 		 * Wait for functional clock period x 3.5 to make sure that
 		 * timer is stopped
 		 */
-		udelay(3500000 / rate + 1);
+		udelay(3500000 / timer->fclk_rate + 1);
 #endif
 	}
 
@@ -348,6 +349,21 @@ static int omap_timer_context_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static int omap_timer_fclk_notifier(struct notifier_block *nb,
+				    unsigned long event, void *data)
+{
+	struct clk_notifier_data *clk_data = data;
+	struct dmtimer *timer = container_of(nb, struct dmtimer, fclk_nb);
+
+	switch (event) {
+	case POST_RATE_CHANGE:
+		timer->fclk_rate = clk_data->new_rate;
+		return NOTIFY_OK;
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
 static int omap_dm_timer_reset(struct dmtimer *timer)
 {
 	u32 l, timeout = 100000;
@@ -754,7 +770,6 @@ static int omap_dm_timer_stop(struct omap_dm_timer *cookie)
 {
 	struct dmtimer *timer;
 	struct device *dev;
-	unsigned long rate = 0;
 
 	timer = to_dmtimer(cookie);
 	if (unlikely(!timer))
@@ -762,10 +777,7 @@ static int omap_dm_timer_stop(struct omap_dm_timer *cookie)
 
 	dev = &timer->pdev->dev;
 
-	if (!timer->omap1)
-		rate = clk_get_rate(timer->fclk);
-
-	__omap_dm_timer_stop(timer, rate);
+	__omap_dm_timer_stop(timer);
 
 	pm_runtime_put_sync(dev);
 
@@ -1124,6 +1136,14 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		timer->fclk = devm_clk_get(dev, "fck");
 		if (IS_ERR(timer->fclk))
 			return PTR_ERR(timer->fclk);
+
+		timer->fclk_nb.notifier_call = omap_timer_fclk_notifier;
+		ret = devm_clk_notifier_register(dev, timer->fclk,
+						 &timer->fclk_nb);
+		if (ret)
+			return ret;
+
+		timer->fclk_rate = clk_get_rate(timer->fclk);
 	} else {
 		timer->fclk = ERR_PTR(-ENODEV);
 	}
-- 
1.9.1

