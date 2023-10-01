Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2827B46FB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbjJAKlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbjJAKlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:41:15 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77490DA
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 03:41:12 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 501)
        id 97BBC1007F8; Sun,  1 Oct 2023 11:41:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1696156867; bh=QUpPxWxeUoEKvELBUi/IX9COhqNB9pdiwdqfum1gprc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fSmlNLxnPwzFmfM5x1vpKboHQoHITBFTp/Mnkwhd5M1LVaczypyL8sT1EuycLQo1g
         CxPl9W2ldnzxCIr7bJCPkcCyQGpQDgehwNW2nw6IuJN38mrnoj4TBtdoxyhW989wTr
         8Yo9Ma7NmejmUwaWht7xqRfoSyqhjiByvkNGN/xi/qMmCVcUp2ZW9/lMU3GTN7l6Qe
         8/CINHXWlpeVvk5KfNvebLWsKfi3dDA8I3GCjro8XLDoUGzo3PQPMUWQkOrR1pHY7P
         N4QZj6vRcL8bkPH0r6ekdxD2KsqqR5N4HZK84g75Pdjpy4+b3fdvlHVGdCjfX4cvgG
         qkd0Y2hlbNV9Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
Received: from bigcore.mess.org (unknown [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by gofer.mess.org (Postfix) with ESMTPSA id 9327F100092;
        Sun,  1 Oct 2023 11:41:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1696156860; bh=QUpPxWxeUoEKvELBUi/IX9COhqNB9pdiwdqfum1gprc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N7DMIwLEPGNJ4j3Mlm37lK0bu/RIEdqBcVsT5mlv+uBvddxIYkMuMdiYJeL5iQ1Wx
         TC5O07MYh01KnJ8C00ZAuEiW3TbnV86urCSxyURHUi8H9weBMiJfGVmvMxUZ3NjEOZ
         k0cjm6PuwbBnW3J3EUrc6qtPFOYuGCaJmSV5UYdMQO4YKZQJjDobZsKBt6SeH6LdgF
         U4VkZYf1Z4pOUR1ciHtzBlXtiQrHxWJfPgcDwc9J6LjA2EsTVjOcsZciG5nNk1cca6
         fzPKfpm8rNoWN5z4Fj8hX6iAEH3RQX7I31wj0SOGUK8VLMpW8ncg47bmaMG+diL0RU
         Q4AfqATfS0ctg==
From:   Sean Young <sean@mess.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Sean Young <sean@mess.org>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/2] pwm: make it possible to apply pwm changes in atomic context
Date:   Sun,  1 Oct 2023 11:40:29 +0100
Message-ID: <1bd5241d584ceb4d6b731c4dc3203fb9686ee1d1.1696156485.git.sean@mess.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696156485.git.sean@mess.org>
References: <cover.1696156485.git.sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers require sleeping, for example if the pwm device is connected
over i2c. The pwm-ir-tx requires precise timing, and sleeping causes havoc
with the generated IR signal when sleeping occurs.

This patch makes it possible to use pwm when the driver does not sleep,
by introducing the pwm_can_sleep() function.

Signed-off-by: Sean Young <sean@mess.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/pwm/core.c               |  2 +-
 drivers/pwm/pwm-fsl-ftm.c        |  1 +
 drivers/pwm/pwm-imx-tpm.c        |  1 +
 drivers/pwm/pwm-iqs620a.c        |  1 +
 drivers/pwm/pwm-lpc18xx-sct.c    |  1 +
 drivers/pwm/pwm-microchip-core.c |  1 +
 drivers/pwm/pwm-omap-dmtimer.c   |  1 +
 drivers/pwm/pwm-pca9685.c        |  1 +
 drivers/pwm/pwm-renesas-tpu.c    |  1 -
 drivers/pwm/pwm-rz-mtu3.c        |  1 +
 drivers/pwm/pwm-sifive.c         |  1 +
 drivers/pwm/pwm-sti.c            |  1 +
 drivers/pwm/pwm-stm32.c          |  1 +
 drivers/pwm/pwm-twl-led.c        |  1 +
 drivers/pwm/pwm-twl.c            |  1 +
 include/linux/pwm.h              | 27 +++++++++++++++++++++++----
 16 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index dc66e3405bf5..d9679ae5b2be 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -505,7 +505,7 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 	 * is a bad idea. So make it explicit that calling this function might
 	 * sleep.
 	 */
-	might_sleep();
+	might_sleep_if(pwm_can_sleep(pwm));
 
 	if (!pwm || !state || !state->period ||
 	    state->duty_cycle > state->period)
diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index b7c6045c5d08..b8b9392844e9 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -405,6 +405,7 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 
 	fpc->soc = of_device_get_match_data(&pdev->dev);
 	fpc->chip.dev = &pdev->dev;
+	fpc->chip.can_sleep = true;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 98ab65c89685..6fd579089240 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -365,6 +365,7 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 
 	tpm->chip.dev = &pdev->dev;
 	tpm->chip.ops = &imx_tpm_pwm_ops;
+	tpm->chip.can_sleep = true;
 
 	/* get number of channels */
 	val = readl(tpm->base + PWM_IMX_TPM_PARAM);
diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 47b3141135f3..ebce9e06b32e 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -209,6 +209,7 @@ static int iqs620_pwm_probe(struct platform_device *pdev)
 	iqs620_pwm->chip.dev = &pdev->dev;
 	iqs620_pwm->chip.ops = &iqs620_pwm_ops;
 	iqs620_pwm->chip.npwm = 1;
+	iqs620_pwm->chip.can_sleep = true;
 
 	mutex_init(&iqs620_pwm->lock);
 
diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 7a19a840bca5..e26fc18b5304 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -395,6 +395,7 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	lpc18xx_pwm->chip.dev = &pdev->dev;
 	lpc18xx_pwm->chip.ops = &lpc18xx_pwm_ops;
 	lpc18xx_pwm->chip.npwm = LPC18XX_NUM_PWMS;
+	lpc18xx_pwm->chip.can_sleep = true;
 
 	/* SCT counter must be in unify (32 bit) mode */
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CONFIG,
diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microchip-core.c
index e7525c98105e..503b5b427d69 100644
--- a/drivers/pwm/pwm-microchip-core.c
+++ b/drivers/pwm/pwm-microchip-core.c
@@ -474,6 +474,7 @@ static int mchp_core_pwm_probe(struct platform_device *pdev)
 	mchp_core_pwm->chip.dev = &pdev->dev;
 	mchp_core_pwm->chip.ops = &mchp_core_pwm_ops;
 	mchp_core_pwm->chip.npwm = 16;
+	mchp_core_pwm->chip.can_sleep = true;
 
 	mchp_core_pwm->channel_enabled = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_EN(0));
 	mchp_core_pwm->channel_enabled |=
diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 4889fbd8a431..438abbb80daf 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -404,6 +404,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	omap->chip.dev = &pdev->dev;
 	omap->chip.ops = &pwm_omap_dmtimer_ops;
 	omap->chip.npwm = 1;
+	omap->chip.can_sleep = true;
 
 	mutex_init(&omap->mutex);
 
diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 3038a68412a7..a47e21977e49 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -571,6 +571,7 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 	pca->chip.npwm = PCA9685_MAXCHAN + 1;
 
 	pca->chip.dev = &client->dev;
+	pca->chip.can_sleep = true;
 
 	ret = pwmchip_add(&pca->chip);
 	if (ret < 0)
diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index d7311614c846..96797a33d8c6 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
index a56cecb0e46e..6d874a2a8785 100644
--- a/drivers/pwm/pwm-rz-mtu3.c
+++ b/drivers/pwm/pwm-rz-mtu3.c
@@ -516,6 +516,7 @@ static int rz_mtu3_pwm_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	rz_mtu3_pwm->chip.dev = &pdev->dev;
+	rz_mtu3_pwm->chip.can_sleep = true;
 	ret = devm_add_action_or_reset(&pdev->dev, rz_mtu3_pwm_pm_disable,
 				       rz_mtu3_pwm);
 	if (ret < 0)
diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index eabddb7c7820..5677ed6eb4d5 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -240,6 +240,7 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 	chip->dev = dev;
 	chip->ops = &pwm_sifive_ops;
 	chip->npwm = 4;
+	chip->can_sleep = true;
 
 	ddata->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ddata->regs))
diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index b1d1373648a3..de9fbd570104 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -643,6 +643,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	pc->chip.dev = dev;
 	pc->chip.ops = &sti_pwm_ops;
 	pc->chip.npwm = pc->cdata->pwm_num_devs;
+	pc->chip.can_sleep = true;
 
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 3d6be7749e23..cd408158e55b 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -636,6 +636,7 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	priv->chip.dev = dev;
 	priv->chip.ops = &stm32pwm_ops;
 	priv->chip.npwm = stm32_pwm_detect_channels(priv);
+	priv->chip.can_sleep = true;
 
 	ret = devm_pwmchip_add(dev, &priv->chip);
 	if (ret < 0)
diff --git a/drivers/pwm/pwm-twl-led.c b/drivers/pwm/pwm-twl-led.c
index 8fb84b441853..9e71429ecaed 100644
--- a/drivers/pwm/pwm-twl-led.c
+++ b/drivers/pwm/pwm-twl-led.c
@@ -362,6 +362,7 @@ static int twl_pwmled_probe(struct platform_device *pdev)
 	}
 
 	twl->chip.dev = &pdev->dev;
+	twl->chip.can_sleep = true;
 
 	mutex_init(&twl->mutex);
 
diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
index 86567add79db..bd08014fec44 100644
--- a/drivers/pwm/pwm-twl.c
+++ b/drivers/pwm/pwm-twl.c
@@ -356,6 +356,7 @@ static int twl_pwm_probe(struct platform_device *pdev)
 
 	twl->chip.dev = &pdev->dev;
 	twl->chip.npwm = 2;
+	twl->chip.can_sleep = true;
 
 	mutex_init(&twl->mutex);
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index d2f9f690a9c1..c94894ffa4c4 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -287,6 +287,7 @@ struct pwm_ops {
  * @ops: callbacks for this PWM controller
  * @base: number of first PWM controlled by this chip
  * @npwm: number of PWMs controlled by this chip
+ * @can_sleep: can the driver sleep in pwm_apply_state
  * @of_xlate: request a PWM device given a device tree PWM specifier
  * @of_pwm_n_cells: number of cells expected in the device tree PWM specifier
  * @list: list node for internal use
@@ -297,6 +298,7 @@ struct pwm_chip {
 	const struct pwm_ops *ops;
 	int base;
 	unsigned int npwm;
+	bool can_sleep;
 
 	struct pwm_device * (*of_xlate)(struct pwm_chip *chip,
 					const struct of_phandle_args *args);
@@ -380,6 +382,18 @@ static inline void pwm_disable(struct pwm_device *pwm)
 	pwm_apply_state(pwm, &state);
 }
 
+/**
+ * pwm_can_sleep() - can a pwm driver sleep in pwm_apply_state()
+ * @pwm: PWM device
+ *
+ * Returns: true if the driver may sleep, false if pwm_apply_state()
+ * can be called from atomic context.
+ */
+static inline bool pwm_can_sleep(struct pwm_device *pwm)
+{
+	return pwm->chip->can_sleep;
+}
+
 /* PWM provider APIs */
 int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 		unsigned long timeout);
@@ -411,7 +425,7 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
 static inline int pwm_apply_state(struct pwm_device *pwm,
 				  const struct pwm_state *state)
 {
-	might_sleep();
+	might_sleep_if(pwm_can_sleep(pwm));
 	return -ENOTSUPP;
 }
 
@@ -423,19 +437,24 @@ static inline int pwm_adjust_config(struct pwm_device *pwm)
 static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
 			     int period_ns)
 {
-	might_sleep();
+	might_sleep_if(pwm_can_sleep(pwm));
 	return -EINVAL;
 }
 
 static inline int pwm_enable(struct pwm_device *pwm)
 {
-	might_sleep();
+	might_sleep_if(pwm_can_sleep(pwm));
 	return -EINVAL;
 }
 
 static inline void pwm_disable(struct pwm_device *pwm)
 {
-	might_sleep();
+	might_sleep_if(pwm_can_sleep(pwm));
+}
+
+static inline bool pwm_can_sleep(struct pwm_device *pwm)
+{
+	return true;
 }
 
 static inline int pwm_capture(struct pwm_device *pwm,
-- 
2.42.0

