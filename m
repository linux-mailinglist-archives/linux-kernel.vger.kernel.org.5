Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC257929EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354679AbjIEQ35 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Sep 2023 12:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354527AbjIEMVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:21:17 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7961AE;
        Tue,  5 Sep 2023 05:21:10 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id D68BB80B2;
        Tue,  5 Sep 2023 20:21:07 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 5 Sep
 2023 20:21:07 +0800
Received: from ubuntu.localdomain (113.72.144.73) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 5 Sep
 2023 20:21:06 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andreas Schwab <schwab@suse.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] pinctrl: starfive: jh7110: Add system pm ops to save and restore context
Date:   Tue, 5 Sep 2023 20:21:05 +0800
Message-ID: <20230905122105.117000-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230905122105.117000-1-hal.feng@starfivetech.com>
References: <20230905122105.117000-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.73]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add system pm ops to save and restore pinctrl registers
when suspending and resuming the driver, respectively.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 MAINTAINERS                                   |  1 +
 .../starfive/pinctrl-starfive-jh7110-aon.c    |  4 ++
 .../starfive/pinctrl-starfive-jh7110-sys.c    |  4 ++
 .../starfive/pinctrl-starfive-jh7110.c        | 40 +++++++++++++++++++
 .../starfive/pinctrl-starfive-jh7110.h        |  4 ++
 5 files changed, 53 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4cc6bf79fdd8..6c7eabeef28f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20302,6 +20302,7 @@ F:	include/dt-bindings/clock/starfive?jh71*.h
 STARFIVE JH71X0 PINCTRL DRIVERS
 M:	Emil Renner Berthing <kernel@esmil.dk>
 M:	Jianlong Huang <jianlong.huang@starfivetech.com>
+M:	Hal Feng <hal.feng@starfivetech.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pinctrl/starfive,jh71*.yaml
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-aon.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-aon.c
index 8cf28aaed254..8691fd55594a 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-aon.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-aon.c
@@ -34,6 +34,8 @@
 #define JH7110_AON_NGPIO		4
 #define JH7110_AON_GC_BASE		64
 
+#define JH7110_AON_REGS_NUM		37
+
 /* registers */
 #define JH7110_AON_DOEN			0x0
 #define JH7110_AON_DOUT			0x4
@@ -148,6 +150,7 @@ static const struct jh7110_pinctrl_soc_info jh7110_aon_pinctrl_info = {
 	.gpi_mask	= GENMASK(3, 0),
 	.gpioin_reg_base	   = JH7110_AON_GPIOIN,
 	.irq_reg		   = &jh7110_aon_irq_reg,
+	.nsaved_regs		   = JH7110_AON_REGS_NUM,
 	.jh7110_set_one_pin_mux  = jh7110_aon_set_one_pin_mux,
 	.jh7110_get_padcfg_base  = jh7110_aon_get_padcfg_base,
 	.jh7110_gpio_irq_handler = jh7110_aon_irq_handler,
@@ -168,6 +171,7 @@ static struct platform_driver jh7110_aon_pinctrl_driver = {
 	.driver = {
 		.name = "starfive-jh7110-aon-pinctrl",
 		.of_match_table = jh7110_aon_pinctrl_of_match,
+		.pm = pm_sleep_ptr(&jh7110_pinctrl_pm_ops),
 	},
 };
 module_platform_driver(jh7110_aon_pinctrl_driver);
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c
index bc279a39613f..0654731d5c27 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c
@@ -33,6 +33,8 @@
 #define JH7110_SYS_NGPIO		64
 #define JH7110_SYS_GC_BASE		0
 
+#define JH7110_SYS_REGS_NUM		174
+
 /* registers */
 #define JH7110_SYS_DOEN			0x000
 #define JH7110_SYS_DOUT			0x040
@@ -419,6 +421,7 @@ static const struct jh7110_pinctrl_soc_info jh7110_sys_pinctrl_info = {
 	.gpi_mask	= GENMASK(6, 0),
 	.gpioin_reg_base	   = JH7110_SYS_GPIOIN,
 	.irq_reg		   = &jh7110_sys_irq_reg,
+	.nsaved_regs		   = JH7110_SYS_REGS_NUM,
 	.jh7110_set_one_pin_mux  = jh7110_sys_set_one_pin_mux,
 	.jh7110_get_padcfg_base  = jh7110_sys_get_padcfg_base,
 	.jh7110_gpio_irq_handler = jh7110_sys_irq_handler,
@@ -439,6 +442,7 @@ static struct platform_driver jh7110_sys_pinctrl_driver = {
 	.driver = {
 		.name = "starfive-jh7110-sys-pinctrl",
 		.of_match_table = jh7110_sys_pinctrl_of_match,
+		.pm = pm_sleep_ptr(&jh7110_pinctrl_pm_ops),
 	},
 };
 module_platform_driver(jh7110_sys_pinctrl_driver);
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
index 72747ad497b5..813b5c2f11b6 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
@@ -873,6 +873,13 @@ int jh7110_pinctrl_probe(struct platform_device *pdev)
 	if (!sfp)
 		return -ENOMEM;
 
+#if IS_ENABLED(CONFIG_PM_SLEEP)
+	sfp->saved_regs = devm_kcalloc(dev, info->nsaved_regs,
+				       sizeof(*sfp->saved_regs), GFP_KERNEL);
+	if (!sfp->saved_regs)
+		return -ENOMEM;
+#endif
+
 	sfp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sfp->base))
 		return PTR_ERR(sfp->base);
@@ -974,6 +981,39 @@ int jh7110_pinctrl_probe(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(jh7110_pinctrl_probe);
 
+static int jh7110_pinctrl_suspend(struct device *dev)
+{
+	struct jh7110_pinctrl *sfp = dev_get_drvdata(dev);
+	unsigned long flags;
+	unsigned int i;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	for (i = 0 ; i < sfp->info->nsaved_regs ; i++)
+		sfp->saved_regs[i] = readl_relaxed(sfp->base + 4 * i);
+
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+	return 0;
+}
+
+static int jh7110_pinctrl_resume(struct device *dev)
+{
+	struct jh7110_pinctrl *sfp = dev_get_drvdata(dev);
+	unsigned long flags;
+	unsigned int i;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	for (i = 0 ; i < sfp->info->nsaved_regs ; i++)
+		writel_relaxed(sfp->saved_regs[i], sfp->base + 4 * i);
+
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+	return 0;
+}
+
+const struct dev_pm_ops jh7110_pinctrl_pm_ops = {
+	LATE_SYSTEM_SLEEP_PM_OPS(jh7110_pinctrl_suspend, jh7110_pinctrl_resume)
+};
+EXPORT_SYMBOL_GPL(jh7110_pinctrl_pm_ops);
+
 MODULE_DESCRIPTION("Pinctrl driver for the StarFive JH7110 SoC");
 MODULE_AUTHOR("Emil Renner Berthing <kernel@esmil.dk>");
 MODULE_AUTHOR("Jianlong Huang <jianlong.huang@starfivetech.com>");
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h
index 3f20b7ff96dd..a33d0d4e1382 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h
@@ -21,6 +21,7 @@ struct jh7110_pinctrl {
 	/* register read/write mutex */
 	struct mutex mutex;
 	const struct jh7110_pinctrl_soc_info *info;
+	u32 *saved_regs;
 };
 
 struct jh7110_gpio_irq_reg {
@@ -50,6 +51,8 @@ struct jh7110_pinctrl_soc_info {
 
 	const struct jh7110_gpio_irq_reg *irq_reg;
 
+	unsigned int nsaved_regs;
+
 	/* generic pinmux */
 	int (*jh7110_set_one_pin_mux)(struct jh7110_pinctrl *sfp,
 				      unsigned int pin,
@@ -66,5 +69,6 @@ void jh7110_set_gpiomux(struct jh7110_pinctrl *sfp, unsigned int pin,
 			unsigned int din, u32 dout, u32 doen);
 int jh7110_pinctrl_probe(struct platform_device *pdev);
 struct jh7110_pinctrl *jh7110_from_irq_desc(struct irq_desc *desc);
+extern const struct dev_pm_ops jh7110_pinctrl_pm_ops;
 
 #endif /* __PINCTRL_STARFIVE_JH7110_H__ */
-- 
2.38.1

