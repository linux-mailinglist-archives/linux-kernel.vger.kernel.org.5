Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D821778E467
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345609AbjHaBbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239703AbjHaBbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:31:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320DACD6;
        Wed, 30 Aug 2023 18:31:32 -0700 (PDT)
Date:   Thu, 31 Aug 2023 01:31:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693445490;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSdUeIp4zb+qf55Z3dx9SUYRwucZQ+YbIBsw5eObgCk=;
        b=XNtRKAdbEnnuGCRCjF+8rtkWzJ7iWhglvXR8puW5/pTkDfd+e8xw8fNpc97it91crpjcJi
        cPPNKEpILtLZ67Kl6r4wrFGXtyuRWw7FGpn0f/swlYxhfgsJiIZQ9HX5ldf3MwI6XwN+oA
        QMeZEtjiK58WF5DItVO+4aWH1Bu2nkz8bVRcpAkuoIopt45vcY2bP9CGz93QJ+vyVAmS1t
        qYApNzab5/pFxmA2+mo73E4kcY1zfMyFOU8nFLETLXxbku+3kcKIjThFZvrg3wgASbX2zz
        tNWoeKbGIr8rd3Eg8uYILPwSRlIUXQ20kUqPqHBGNT7ZMVWtcHyYHq2TLx/xDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693445490;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSdUeIp4zb+qf55Z3dx9SUYRwucZQ+YbIBsw5eObgCk=;
        b=ZlOtmaEmqT9tHfpDRaG0l1eLRkVmoWPPDNpG5qs78AwoUFvRwN2W8d6C4ycPhDQ+2vWNvr
        L1ogtmKVlGel5cDw==
From:   "tip-bot2 for Mans Rullgard" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sun5i: Remove duplication of
 code and data
Cc:     Mans Rullgard <mans@mansr.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230630201800.16501-2-mans@mansr.com>
References: <20230630201800.16501-2-mans@mansr.com>
MIME-Version: 1.0
Message-ID: <169344549021.27769.3314639356865529963.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7ded803873162f0edfa8570b28605dfcb67fb486
Gitweb:        https://git.kernel.org/tip/7ded803873162f0edfa8570b28605dfcb67fb486
Author:        Mans Rullgard <mans@mansr.com>
AuthorDate:    Fri, 30 Jun 2023 21:01:26 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 18 Aug 2023 12:15:06 +02:00

clocksource/drivers/sun5i: Remove duplication of code and data

Move the clocksource and clock_event_device structs into the main
struct sun5i_timer, and update the code for the new layout.  This
removes a lot of duplication of both code and data.

Signed-off-by: Mans Rullgard <mans@mansr.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230630201800.16501-2-mans@mansr.com
---
 drivers/clocksource/timer-sun5i.c | 206 ++++++++++-------------------
 1 file changed, 76 insertions(+), 130 deletions(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 7d5fa90..e0ca97c 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -35,31 +35,26 @@
 
 #define TIMER_SYNC_TICKS	3
 
-struct sun5i_timer {
+/* Pointless struct to minimise diff */
+struct _sun5i_timer {
 	void __iomem		*base;
 	struct clk		*clk;
 	struct notifier_block	clk_rate_cb;
 	u32			ticks_per_jiffy;
 };
 
-#define to_sun5i_timer(x) \
-	container_of(x, struct sun5i_timer, clk_rate_cb)
-
-struct sun5i_timer_clksrc {
-	struct sun5i_timer	timer;
+struct sun5i_timer {
+	struct _sun5i_timer	timer;
 	struct clocksource	clksrc;
-};
-
-#define to_sun5i_timer_clksrc(x) \
-	container_of(x, struct sun5i_timer_clksrc, clksrc)
-
-struct sun5i_timer_clkevt {
-	struct sun5i_timer		timer;
 	struct clock_event_device	clkevt;
 };
 
-#define to_sun5i_timer_clkevt(x) \
-	container_of(x, struct sun5i_timer_clkevt, clkevt)
+#define nb_to_sun5i_timer(x) \
+	container_of(x, struct sun5i_timer, timer.clk_rate_cb)
+#define clksrc_to_sun5i_timer(x) \
+	container_of(x, struct sun5i_timer, clksrc)
+#define clkevt_to_sun5i_timer(x) \
+	container_of(x, struct sun5i_timer, clkevt)
 
 /*
  * When we disable a timer, we need to wait at least for 2 cycles of
@@ -67,7 +62,7 @@ struct sun5i_timer_clkevt {
  * that is already setup and runs at the same frequency than the other
  * timers, and we never will be disabled.
  */
-static void sun5i_clkevt_sync(struct sun5i_timer_clkevt *ce)
+static void sun5i_clkevt_sync(struct sun5i_timer *ce)
 {
 	u32 old = readl(ce->timer.base + TIMER_CNTVAL_LO_REG(1));
 
@@ -75,7 +70,7 @@ static void sun5i_clkevt_sync(struct sun5i_timer_clkevt *ce)
 		cpu_relax();
 }
 
-static void sun5i_clkevt_time_stop(struct sun5i_timer_clkevt *ce, u8 timer)
+static void sun5i_clkevt_time_stop(struct sun5i_timer *ce, u8 timer)
 {
 	u32 val = readl(ce->timer.base + TIMER_CTL_REG(timer));
 	writel(val & ~TIMER_CTL_ENABLE, ce->timer.base + TIMER_CTL_REG(timer));
@@ -83,12 +78,12 @@ static void sun5i_clkevt_time_stop(struct sun5i_timer_clkevt *ce, u8 timer)
 	sun5i_clkevt_sync(ce);
 }
 
-static void sun5i_clkevt_time_setup(struct sun5i_timer_clkevt *ce, u8 timer, u32 delay)
+static void sun5i_clkevt_time_setup(struct sun5i_timer *ce, u8 timer, u32 delay)
 {
 	writel(delay, ce->timer.base + TIMER_INTVAL_LO_REG(timer));
 }
 
-static void sun5i_clkevt_time_start(struct sun5i_timer_clkevt *ce, u8 timer, bool periodic)
+static void sun5i_clkevt_time_start(struct sun5i_timer *ce, u8 timer, bool periodic)
 {
 	u32 val = readl(ce->timer.base + TIMER_CTL_REG(timer));
 
@@ -103,7 +98,7 @@ static void sun5i_clkevt_time_start(struct sun5i_timer_clkevt *ce, u8 timer, boo
 
 static int sun5i_clkevt_shutdown(struct clock_event_device *clkevt)
 {
-	struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
+	struct sun5i_timer *ce = clkevt_to_sun5i_timer(clkevt);
 
 	sun5i_clkevt_time_stop(ce, 0);
 	return 0;
@@ -111,7 +106,7 @@ static int sun5i_clkevt_shutdown(struct clock_event_device *clkevt)
 
 static int sun5i_clkevt_set_oneshot(struct clock_event_device *clkevt)
 {
-	struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
+	struct sun5i_timer *ce = clkevt_to_sun5i_timer(clkevt);
 
 	sun5i_clkevt_time_stop(ce, 0);
 	sun5i_clkevt_time_start(ce, 0, false);
@@ -120,7 +115,7 @@ static int sun5i_clkevt_set_oneshot(struct clock_event_device *clkevt)
 
 static int sun5i_clkevt_set_periodic(struct clock_event_device *clkevt)
 {
-	struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
+	struct sun5i_timer *ce = clkevt_to_sun5i_timer(clkevt);
 
 	sun5i_clkevt_time_stop(ce, 0);
 	sun5i_clkevt_time_setup(ce, 0, ce->timer.ticks_per_jiffy);
@@ -131,7 +126,7 @@ static int sun5i_clkevt_set_periodic(struct clock_event_device *clkevt)
 static int sun5i_clkevt_next_event(unsigned long evt,
 				   struct clock_event_device *clkevt)
 {
-	struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
+	struct sun5i_timer *ce = clkevt_to_sun5i_timer(clkevt);
 
 	sun5i_clkevt_time_stop(ce, 0);
 	sun5i_clkevt_time_setup(ce, 0, evt - TIMER_SYNC_TICKS);
@@ -142,7 +137,7 @@ static int sun5i_clkevt_next_event(unsigned long evt,
 
 static irqreturn_t sun5i_timer_interrupt(int irq, void *dev_id)
 {
-	struct sun5i_timer_clkevt *ce = dev_id;
+	struct sun5i_timer *ce = dev_id;
 
 	writel(0x1, ce->timer.base + TIMER_IRQ_ST_REG);
 	ce->clkevt.event_handler(&ce->clkevt);
@@ -152,17 +147,16 @@ static irqreturn_t sun5i_timer_interrupt(int irq, void *dev_id)
 
 static u64 sun5i_clksrc_read(struct clocksource *clksrc)
 {
-	struct sun5i_timer_clksrc *cs = to_sun5i_timer_clksrc(clksrc);
+	struct sun5i_timer *cs = clksrc_to_sun5i_timer(clksrc);
 
 	return ~readl(cs->timer.base + TIMER_CNTVAL_LO_REG(1));
 }
 
-static int sun5i_rate_cb_clksrc(struct notifier_block *nb,
-				unsigned long event, void *data)
+static int sun5i_rate_cb(struct notifier_block *nb,
+			 unsigned long event, void *data)
 {
 	struct clk_notifier_data *ndata = data;
-	struct sun5i_timer *timer = to_sun5i_timer(nb);
-	struct sun5i_timer_clksrc *cs = container_of(timer, struct sun5i_timer_clksrc, timer);
+	struct sun5i_timer *cs = nb_to_sun5i_timer(nb);
 
 	switch (event) {
 	case PRE_RATE_CHANGE:
@@ -171,6 +165,8 @@ static int sun5i_rate_cb_clksrc(struct notifier_block *nb,
 
 	case POST_RATE_CHANGE:
 		clocksource_register_hz(&cs->clksrc, ndata->new_rate);
+		clockevents_update_freq(&cs->clkevt, ndata->new_rate);
+		cs->timer.ticks_per_jiffy = DIV_ROUND_UP(ndata->new_rate, HZ);
 		break;
 
 	default:
@@ -181,41 +177,12 @@ static int sun5i_rate_cb_clksrc(struct notifier_block *nb,
 }
 
 static int __init sun5i_setup_clocksource(struct device_node *node,
-					  void __iomem *base,
-					  struct clk *clk, int irq)
+					  struct sun5i_timer *cs,
+					  unsigned long rate)
 {
-	struct sun5i_timer_clksrc *cs;
-	unsigned long rate;
+	void __iomem *base = cs->timer.base;
 	int ret;
 
-	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
-	if (!cs)
-		return -ENOMEM;
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("Couldn't enable parent clock\n");
-		goto err_free;
-	}
-
-	rate = clk_get_rate(clk);
-	if (!rate) {
-		pr_err("Couldn't get parent clock rate\n");
-		ret = -EINVAL;
-		goto err_disable_clk;
-	}
-
-	cs->timer.base = base;
-	cs->timer.clk = clk;
-	cs->timer.clk_rate_cb.notifier_call = sun5i_rate_cb_clksrc;
-	cs->timer.clk_rate_cb.next = NULL;
-
-	ret = clk_notifier_register(clk, &cs->timer.clk_rate_cb);
-	if (ret) {
-		pr_err("Unable to register clock notifier.\n");
-		goto err_disable_clk;
-	}
-
 	writel(~0, base + TIMER_INTVAL_LO_REG(1));
 	writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
 	       base + TIMER_CTL_REG(1));
@@ -229,72 +196,20 @@ static int __init sun5i_setup_clocksource(struct device_node *node,
 	ret = clocksource_register_hz(&cs->clksrc, rate);
 	if (ret) {
 		pr_err("Couldn't register clock source.\n");
-		goto err_remove_notifier;
+		return ret;
 	}
 
 	return 0;
-
-err_remove_notifier:
-	clk_notifier_unregister(clk, &cs->timer.clk_rate_cb);
-err_disable_clk:
-	clk_disable_unprepare(clk);
-err_free:
-	kfree(cs);
-	return ret;
-}
-
-static int sun5i_rate_cb_clkevt(struct notifier_block *nb,
-				unsigned long event, void *data)
-{
-	struct clk_notifier_data *ndata = data;
-	struct sun5i_timer *timer = to_sun5i_timer(nb);
-	struct sun5i_timer_clkevt *ce = container_of(timer, struct sun5i_timer_clkevt, timer);
-
-	if (event == POST_RATE_CHANGE) {
-		clockevents_update_freq(&ce->clkevt, ndata->new_rate);
-		ce->timer.ticks_per_jiffy = DIV_ROUND_UP(ndata->new_rate, HZ);
-	}
-
-	return NOTIFY_DONE;
 }
 
-static int __init sun5i_setup_clockevent(struct device_node *node, void __iomem *base,
-					 struct clk *clk, int irq)
+static int __init sun5i_setup_clockevent(struct device_node *node,
+					 struct sun5i_timer *ce,
+					 unsigned long rate, int irq)
 {
-	struct sun5i_timer_clkevt *ce;
-	unsigned long rate;
+	void __iomem *base = ce->timer.base;
 	int ret;
 	u32 val;
 
-	ce = kzalloc(sizeof(*ce), GFP_KERNEL);
-	if (!ce)
-		return -ENOMEM;
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("Couldn't enable parent clock\n");
-		goto err_free;
-	}
-
-	rate = clk_get_rate(clk);
-	if (!rate) {
-		pr_err("Couldn't get parent clock rate\n");
-		ret = -EINVAL;
-		goto err_disable_clk;
-	}
-
-	ce->timer.base = base;
-	ce->timer.ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
-	ce->timer.clk = clk;
-	ce->timer.clk_rate_cb.notifier_call = sun5i_rate_cb_clkevt;
-	ce->timer.clk_rate_cb.next = NULL;
-
-	ret = clk_notifier_register(clk, &ce->timer.clk_rate_cb);
-	if (ret) {
-		pr_err("Unable to register clock notifier.\n");
-		goto err_disable_clk;
-	}
-
 	ce->clkevt.name = node->name;
 	ce->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	ce->clkevt.set_next_event = sun5i_clkevt_next_event;
@@ -317,27 +232,25 @@ static int __init sun5i_setup_clockevent(struct device_node *node, void __iomem 
 			  "sun5i_timer0", ce);
 	if (ret) {
 		pr_err("Unable to register interrupt\n");
-		goto err_remove_notifier;
+		return ret;
 	}
 
 	return 0;
-
-err_remove_notifier:
-	clk_notifier_unregister(clk, &ce->timer.clk_rate_cb);
-err_disable_clk:
-	clk_disable_unprepare(clk);
-err_free:
-	kfree(ce);
-	return ret;
 }
 
 static int __init sun5i_timer_init(struct device_node *node)
 {
+	struct sun5i_timer *st;
 	struct reset_control *rstc;
 	void __iomem *timer_base;
 	struct clk *clk;
+	unsigned long rate;
 	int irq, ret;
 
+	st = kzalloc(sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
 	timer_base = of_io_request_and_map(node, 0, of_node_full_name(node));
 	if (IS_ERR(timer_base)) {
 		pr_err("Can't map registers\n");
@@ -356,15 +269,48 @@ static int __init sun5i_timer_init(struct device_node *node)
 		return PTR_ERR(clk);
 	}
 
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("Couldn't enable parent clock\n");
+		goto err_free;
+	}
+
+	rate = clk_get_rate(clk);
+	if (!rate) {
+		pr_err("Couldn't get parent clock rate\n");
+		ret = -EINVAL;
+		goto err_disable_clk;
+	}
+
+	st->timer.base = timer_base;
+	st->timer.ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
+	st->timer.clk = clk;
+	st->timer.clk_rate_cb.notifier_call = sun5i_rate_cb;
+	st->timer.clk_rate_cb.next = NULL;
+
+	ret = clk_notifier_register(clk, &st->timer.clk_rate_cb);
+	if (ret) {
+		pr_err("Unable to register clock notifier.\n");
+		goto err_disable_clk;
+	}
+
 	rstc = of_reset_control_get(node, NULL);
 	if (!IS_ERR(rstc))
 		reset_control_deassert(rstc);
 
-	ret = sun5i_setup_clocksource(node, timer_base, clk, irq);
+	ret = sun5i_setup_clocksource(node, st, rate);
 	if (ret)
-		return ret;
+		goto err_remove_notifier;
 
-	return sun5i_setup_clockevent(node, timer_base, clk, irq);
+	return sun5i_setup_clockevent(node, st, rate, irq);
+
+err_remove_notifier:
+	clk_notifier_unregister(clk, &st->timer.clk_rate_cb);
+err_disable_clk:
+	clk_disable_unprepare(clk);
+err_free:
+	kfree(st);
+	return ret;
 }
 TIMER_OF_DECLARE(sun5i_a13, "allwinner,sun5i-a13-hstimer",
 			   sun5i_timer_init);
