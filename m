Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B036178E462
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345584AbjHaBbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238107AbjHaBbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:31:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED849CC9;
        Wed, 30 Aug 2023 18:31:31 -0700 (PDT)
Date:   Thu, 31 Aug 2023 01:31:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693445489;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xRN44fMksxAydgdcP62P7opSGfW66a4FkW/NtbSw/KA=;
        b=ozvEaufVuOvnqaUdj22mgj4/k4a7AlA2q9fYS1W7wIfO2UMJ0dTEGwBpDjwmjhEjgiRv6l
        PH1HG9YHk/XRNJVOMKStF3ApHpQe/hQsbaQbswmwGJ22TWMkfoiSb/Ia4NQ9019mwfv4ws
        /y2kSINmoHRXalRhGOeOLID/NzLZ8ljjYhVglzeIAb88CBJ9/DIIBq9g1yDYxLuk3LYmrK
        g2lm9BQEQ9s5T996EQXIWxhSaA19qUxGs2eG/K3cd419s7OJ0dHuFuSCe7RKc5UCpUkeOM
        8HtMK+hJZsMSaCtUv/Xc5b3onwGRUjbVSlqkTKZCmmd4lKv5jGptqgg6KaOPkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693445489;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xRN44fMksxAydgdcP62P7opSGfW66a4FkW/NtbSw/KA=;
        b=egu2OwU3Jpe/7gkO87KoWk7ZhbwI5Qaa0Sci6YUpoxG8scJ07AGF5IF3+we1hSYNGuZT5P
        LuytOWT4S9SFTEAA==
From:   "tip-bot2 for Mans Rullgard" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sun5i: Convert to platform
 device driver
Cc:     Mans Rullgard <mans@mansr.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230630201800.16501-4-mans@mansr.com>
References: <20230630201800.16501-4-mans@mansr.com>
MIME-Version: 1.0
Message-ID: <169344548923.27769.18272995599299715403.tip-bot2@tip-bot2>
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

Commit-ID:     7e5bac610d2fd4d270adfd2d70ce766df1711bf8
Gitweb:        https://git.kernel.org/tip/7e5bac610d2fd4d270adfd2d70ce766df1711bf8
Author:        Mans Rullgard <mans@mansr.com>
AuthorDate:    Fri, 30 Jun 2023 21:01:28 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 18 Aug 2023 12:15:22 +02:00

clocksource/drivers/sun5i: Convert to platform device driver

Convert the sun5i hstimer driver to a platform device driver.
This makes it work again on A20 and other systems where the
clock is provided by a platform device driver.

Fixes: 7ec03b588d22 ("clk: sunxi-ng: Convert early providers to platform drivers")
Signed-off-by: Mans Rullgard <mans@mansr.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230630201800.16501-4-mans@mansr.com
---
 drivers/clocksource/timer-sun5i.c | 121 ++++++++++++++++-------------
 1 file changed, 69 insertions(+), 52 deletions(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 3ca427e..69fee35 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -16,9 +16,7 @@
 #include <linux/irqreturn.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
+#include <linux/platform_device.h>
 
 #define TIMER_IRQ_EN_REG		0x00
 #define TIMER_IRQ_EN(val)			BIT(val)
@@ -171,10 +169,10 @@ static int sun5i_rate_cb(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
-static int __init sun5i_setup_clocksource(struct device_node *node,
-					  struct sun5i_timer *cs,
-					  unsigned long rate)
+static int sun5i_setup_clocksource(struct platform_device *pdev,
+				   unsigned long rate)
 {
+	struct sun5i_timer *cs = platform_get_drvdata(pdev);
 	void __iomem *base = cs->base;
 	int ret;
 
@@ -182,7 +180,7 @@ static int __init sun5i_setup_clocksource(struct device_node *node,
 	writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
 	       base + TIMER_CTL_REG(1));
 
-	cs->clksrc.name = node->name;
+	cs->clksrc.name = pdev->dev.of_node->name;
 	cs->clksrc.rating = 340;
 	cs->clksrc.read = sun5i_clksrc_read;
 	cs->clksrc.mask = CLOCKSOURCE_MASK(32);
@@ -190,22 +188,23 @@ static int __init sun5i_setup_clocksource(struct device_node *node,
 
 	ret = clocksource_register_hz(&cs->clksrc, rate);
 	if (ret) {
-		pr_err("Couldn't register clock source.\n");
+		dev_err(&pdev->dev, "Couldn't register clock source.\n");
 		return ret;
 	}
 
 	return 0;
 }
 
-static int __init sun5i_setup_clockevent(struct device_node *node,
-					 struct sun5i_timer *ce,
-					 unsigned long rate, int irq)
+static int sun5i_setup_clockevent(struct platform_device *pdev,
+				  unsigned long rate, int irq)
 {
+	struct device *dev = &pdev->dev;
+	struct sun5i_timer *ce = platform_get_drvdata(pdev);
 	void __iomem *base = ce->base;
 	int ret;
 	u32 val;
 
-	ce->clkevt.name = node->name;
+	ce->clkevt.name = dev->of_node->name;
 	ce->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	ce->clkevt.set_next_event = sun5i_clkevt_next_event;
 	ce->clkevt.set_state_shutdown = sun5i_clkevt_shutdown;
@@ -223,18 +222,20 @@ static int __init sun5i_setup_clockevent(struct device_node *node,
 	clockevents_config_and_register(&ce->clkevt, rate,
 					TIMER_SYNC_TICKS, 0xffffffff);
 
-	ret = request_irq(irq, sun5i_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
-			  "sun5i_timer0", ce);
+	ret = devm_request_irq(dev, irq, sun5i_timer_interrupt,
+			       IRQF_TIMER | IRQF_IRQPOLL,
+			       "sun5i_timer0", ce);
 	if (ret) {
-		pr_err("Unable to register interrupt\n");
+		dev_err(dev, "Unable to register interrupt\n");
 		return ret;
 	}
 
 	return 0;
 }
 
-static int __init sun5i_timer_init(struct device_node *node)
+static int sun5i_timer_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct sun5i_timer *st;
 	struct reset_control *rstc;
 	void __iomem *timer_base;
@@ -242,39 +243,34 @@ static int __init sun5i_timer_init(struct device_node *node)
 	unsigned long rate;
 	int irq, ret;
 
-	st = kzalloc(sizeof(*st), GFP_KERNEL);
+	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
 	if (!st)
 		return -ENOMEM;
 
-	timer_base = of_io_request_and_map(node, 0, of_node_full_name(node));
+	platform_set_drvdata(pdev, st);
+
+	timer_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(timer_base)) {
-		pr_err("Can't map registers\n");
+		dev_err(dev, "Can't map registers\n");
 		return PTR_ERR(timer_base);
 	}
 
-	irq = irq_of_parse_and_map(node, 0);
-	if (irq <= 0) {
-		pr_err("Can't parse IRQ\n");
-		return -EINVAL;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "Can't get IRQ\n");
+		return irq;
 	}
 
-	clk = of_clk_get(node, 0);
+	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk)) {
-		pr_err("Can't get timer clock\n");
+		dev_err(dev, "Can't get timer clock\n");
 		return PTR_ERR(clk);
 	}
 
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("Couldn't enable parent clock\n");
-		goto err_free;
-	}
-
 	rate = clk_get_rate(clk);
 	if (!rate) {
-		pr_err("Couldn't get parent clock rate\n");
-		ret = -EINVAL;
-		goto err_disable_clk;
+		dev_err(dev, "Couldn't get parent clock rate\n");
+		return -EINVAL;
 	}
 
 	st->base = timer_base;
@@ -283,31 +279,52 @@ static int __init sun5i_timer_init(struct device_node *node)
 	st->clk_rate_cb.notifier_call = sun5i_rate_cb;
 	st->clk_rate_cb.next = NULL;
 
-	ret = clk_notifier_register(clk, &st->clk_rate_cb);
+	ret = devm_clk_notifier_register(dev, clk, &st->clk_rate_cb);
 	if (ret) {
-		pr_err("Unable to register clock notifier.\n");
-		goto err_disable_clk;
+		dev_err(dev, "Unable to register clock notifier.\n");
+		return ret;
 	}
 
-	rstc = of_reset_control_get(node, NULL);
-	if (!IS_ERR(rstc))
+	rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (rstc)
 		reset_control_deassert(rstc);
 
-	ret = sun5i_setup_clocksource(node, st, rate);
+	ret = sun5i_setup_clocksource(pdev, rate);
+	if (ret)
+		return ret;
+
+	ret = sun5i_setup_clockevent(pdev, rate, irq);
 	if (ret)
-		goto err_remove_notifier;
+		goto err_unreg_clocksource;
 
-	return sun5i_setup_clockevent(node, st, rate, irq);
+	return 0;
 
-err_remove_notifier:
-	clk_notifier_unregister(clk, &st->clk_rate_cb);
-err_disable_clk:
-	clk_disable_unprepare(clk);
-err_free:
-	kfree(st);
+err_unreg_clocksource:
+	clocksource_unregister(&st->clksrc);
 	return ret;
 }
-TIMER_OF_DECLARE(sun5i_a13, "allwinner,sun5i-a13-hstimer",
-			   sun5i_timer_init);
-TIMER_OF_DECLARE(sun7i_a20, "allwinner,sun7i-a20-hstimer",
-			   sun5i_timer_init);
+
+static void sun5i_timer_remove(struct platform_device *pdev)
+{
+	struct sun5i_timer *st = platform_get_drvdata(pdev);
+
+	clocksource_unregister(&st->clksrc);
+}
+
+static const struct of_device_id sun5i_timer_of_match[] = {
+	{ .compatible = "allwinner,sun5i-a13-hstimer" },
+	{ .compatible = "allwinner,sun7i-a20-hstimer" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sun5i_timer_of_match);
+
+static struct platform_driver sun5i_timer_driver = {
+	.probe		= sun5i_timer_probe,
+	.remove_new	= sun5i_timer_remove,
+	.driver	= {
+		.name	= "sun5i-timer",
+		.of_match_table = sun5i_timer_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+module_platform_driver(sun5i_timer_driver);
