Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4047DA05A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346497AbjJ0S0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346523AbjJ0S0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:26:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461F11BFD;
        Fri, 27 Oct 2023 11:23:44 -0700 (PDT)
Date:   Fri, 27 Oct 2023 18:23:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698430993;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLnvTHnblx5b8QiEPiT3MDUvMMwbN6aVHzpgMo0/s3k=;
        b=IbjhEi0jotWY6SQWbBD+J6Xd5mCSwZ8xetZZk45JhZBF/uOSJGSjfZB3L4pXWSHEI+hh31
        xOEOufSsnAfc6M47bqLMWiCyMvBd7KsdhZo1e9VeW7mc9AwPS6HHnG699eO0MqUAGix/bq
        2A9mykbD3+FOJg6Xi+S7iKNJjS7o+DsU9GpslSGnSBhfC3wQb/NI45irHPXiQQkUeQAVQu
        1akKgMx1N8Zl6+SGyXPafP7AEya64A13XMeMrFsaqF5rlg3bC6L4KpACLWAyIjFR81mWqO
        uVg3RkWVU+Hm8wGRKV7uUJXRdBCWffOl0MrF70lgOAc5/2zoktweDuIWBwSTcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698430993;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLnvTHnblx5b8QiEPiT3MDUvMMwbN6aVHzpgMo0/s3k=;
        b=ZSI0EOj0iiz4ZbG8pdi6tdnUgnvjO2X9l3CPsi56sPdx7lMjpBZJPfV/gKffn6sCfEimpH
        Ud4930lYKFRjS0Bw==
From:   "tip-bot2 for Ivaylo Dimitrov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] drivers/clocksource/timer-ti-dm: Don't call
 clk_get_rate() in stop function
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1696312220-11550-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1696312220-11550-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
MIME-Version: 1.0
Message-ID: <169843099238.3135.4893694588353125382.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     12590d4d0e331d3cb9e6b3494515cd61c8a6624e
Gitweb:        https://git.kernel.org/tip/12590d4d0e331d3cb9e6b3494515cd61c8a6624e
Author:        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
AuthorDate:    Tue, 03 Oct 2023 08:50:20 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 11 Oct 2023 10:14:53 +02:00

drivers/clocksource/timer-ti-dm: Don't call clk_get_rate() in stop function

clk_get_rate() might sleep, and that prevents dm-timer based PWM from being
used from atomic context.

Fix that by getting fclk rate in probe() and using a notifier in case rate
changes.

Fixes: af04aa856e93 ("ARM: OMAP: Move dmtimer driver out of plat-omap to drivers under clocksource")
Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1696312220-11550-1-git-send-email-ivo.g.dimitrov.75@gmail.com
---
 drivers/clocksource/timer-ti-dm.c | 36 +++++++++++++++++++++++-------
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
