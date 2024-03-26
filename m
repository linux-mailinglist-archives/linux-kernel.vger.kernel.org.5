Return-Path: <linux-kernel+bounces-118672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC2C88BDE7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B2BDB27011
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE67012EBF3;
	Tue, 26 Mar 2024 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9THfPFe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B965A73534;
	Tue, 26 Mar 2024 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444843; cv=none; b=HuJYFl7kJXsrC2aTroaYF9NeYz3eLAWlwNmU/CrO3DynPWQbXus6BPzExNE9VGxjHJt7cie3xZypnmU2QPxDjlf6wnKdH073nyn7EnJxjJ5IXzK45CvbGOEtcYO0gQdgLse79SAiov/zadZ/V1igTs0DidG90oqJMZDFtDF36r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444843; c=relaxed/simple;
	bh=ej941G4SwXEoXOihGj99VwXEy6Zw3bZFrs7RkXckkj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pr9xirOURKHRbU9T9/U7gjTBXYNmCZoos1BS7QoUKa4OMHTVDG0Cm5278+MAmFKAZtGM/Hs+3dzNpHxpfc/vc0U2N2rAZlPY/bi35tu2tB28zM7e+XIRUERaPszZGQep2z7mrb4Kx+QWWlbZFNf5xyz7DLHctc1goiN5FD+G6pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9THfPFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D33AAC4E687;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711444842;
	bh=ej941G4SwXEoXOihGj99VwXEy6Zw3bZFrs7RkXckkj8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q9THfPFe2YXbSu1hZfrcZ3vUXGWnQCkHUCog1X90SIq+KMM1sJ2anmi8br4dWvxk1
	 OPaz++wFL7kw8DdWXvrlafvUjSM4IE0PJEFezDGluNWXRj2oasdwb3pxaJqKN5tl7x
	 rZXR6tyQuQRHckcEyOM//sxUd9sJrd7VebRuYqvbNoKzVLFLHlwkSjlJ8XEQPJBYV6
	 bv7r77xF1IBFqfNVPW0m9nk0GmZTlDSfowXMVA1cVJZrzS6sK7+4zh74WU9r7Fe6wE
	 S6+mByiL6T44ypD3PG3iFaFqb6tfDwiyZPwPQ7D51dBX756MhyOEVyAeOR90DuhcJx
	 THFMDSzkkQruA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23F9C6FD1F;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Tue, 26 Mar 2024 12:19:01 +0300
Subject: [PATCH v9 34/38] ata: pata_ep93xx: remove legacy pinctrl use
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-ep93xx-v9-34-156e2ae5dfc8@maquefel.me>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
In-Reply-To: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
To: Hartley Sweeten <hsweeten@visionengravers.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-ide@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711444837; l=5459;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=qPkB8JbiJNaB7ZMkLQj7fBfz340c+I4CkSEkmdWNtuk=;
 b=bBf4+GrSV74qI6GgOhelXk5KKU/NAKNkXYlswJ6DNux/qq1GDEcWj5RHcirwPEUklatg4YkLh3Bg
 u9MwwLZwAYZJu4QIFTvIixnXXbbbCqfur5zfg07IN6AGmPBCUr27
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Drop legacy acquire/release since we are using pinctrl for this now.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Acked-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/mach-ep93xx/core.c       | 72 ---------------------------------------
 drivers/ata/pata_ep93xx.c         | 25 ++++----------
 include/linux/soc/cirrus/ep93xx.h |  4 ---
 3 files changed, 6 insertions(+), 95 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 4ddf1a4cba33..9c6154bb37b5 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -779,78 +779,6 @@ void __init ep93xx_register_ide(void)
 	platform_device_register(&ep93xx_ide_device);
 }
 
-int ep93xx_ide_acquire_gpio(struct platform_device *pdev)
-{
-	int err;
-	int i;
-
-	err = gpio_request(EP93XX_GPIO_LINE_EGPIO2, dev_name(&pdev->dev));
-	if (err)
-		return err;
-	err = gpio_request(EP93XX_GPIO_LINE_EGPIO15, dev_name(&pdev->dev));
-	if (err)
-		goto fail_egpio15;
-	for (i = 2; i < 8; i++) {
-		err = gpio_request(EP93XX_GPIO_LINE_E(i), dev_name(&pdev->dev));
-		if (err)
-			goto fail_gpio_e;
-	}
-	for (i = 4; i < 8; i++) {
-		err = gpio_request(EP93XX_GPIO_LINE_G(i), dev_name(&pdev->dev));
-		if (err)
-			goto fail_gpio_g;
-	}
-	for (i = 0; i < 8; i++) {
-		err = gpio_request(EP93XX_GPIO_LINE_H(i), dev_name(&pdev->dev));
-		if (err)
-			goto fail_gpio_h;
-	}
-
-	/* GPIO ports E[7:2], G[7:4] and H used by IDE */
-	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_EONIDE |
-				 EP93XX_SYSCON_DEVCFG_GONIDE |
-				 EP93XX_SYSCON_DEVCFG_HONIDE);
-	return 0;
-
-fail_gpio_h:
-	for (--i; i >= 0; --i)
-		gpio_free(EP93XX_GPIO_LINE_H(i));
-	i = 8;
-fail_gpio_g:
-	for (--i; i >= 4; --i)
-		gpio_free(EP93XX_GPIO_LINE_G(i));
-	i = 8;
-fail_gpio_e:
-	for (--i; i >= 2; --i)
-		gpio_free(EP93XX_GPIO_LINE_E(i));
-	gpio_free(EP93XX_GPIO_LINE_EGPIO15);
-fail_egpio15:
-	gpio_free(EP93XX_GPIO_LINE_EGPIO2);
-	return err;
-}
-EXPORT_SYMBOL(ep93xx_ide_acquire_gpio);
-
-void ep93xx_ide_release_gpio(struct platform_device *pdev)
-{
-	int i;
-
-	for (i = 2; i < 8; i++)
-		gpio_free(EP93XX_GPIO_LINE_E(i));
-	for (i = 4; i < 8; i++)
-		gpio_free(EP93XX_GPIO_LINE_G(i));
-	for (i = 0; i < 8; i++)
-		gpio_free(EP93XX_GPIO_LINE_H(i));
-	gpio_free(EP93XX_GPIO_LINE_EGPIO15);
-	gpio_free(EP93XX_GPIO_LINE_EGPIO2);
-
-
-	/* GPIO ports E[7:2], G[7:4] and H used by GPIO */
-	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_EONIDE |
-			       EP93XX_SYSCON_DEVCFG_GONIDE |
-			       EP93XX_SYSCON_DEVCFG_HONIDE);
-}
-EXPORT_SYMBOL(ep93xx_ide_release_gpio);
-
 /*************************************************************************
  * EP93xx ADC
  *************************************************************************/
diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index 13246a92e29f..a8555f630097 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -922,28 +922,18 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
 	void __iomem *ide_base;
 	int err;
 
-	err = ep93xx_ide_acquire_gpio(pdev);
-	if (err)
-		return err;
-
 	/* INT[3] (IRQ_EP93XX_EXT3) line connected as pull down */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		err = irq;
-		goto err_rel_gpio;
-	}
+	if (irq < 0)
+		return irq;
 
 	ide_base = devm_platform_get_and_ioremap_resource(pdev, 0, &mem_res);
-	if (IS_ERR(ide_base)) {
-		err = PTR_ERR(ide_base);
-		goto err_rel_gpio;
-	}
+	if (IS_ERR(ide_base))
+		return PTR_ERR(ide_base);
 
 	drv_data = devm_kzalloc(&pdev->dev, sizeof(*drv_data), GFP_KERNEL);
-	if (!drv_data) {
-		err = -ENOMEM;
-		goto err_rel_gpio;
-	}
+	if (!drv_data)
+		return -ENOMEM;
 
 	drv_data->pdev = pdev;
 	drv_data->ide_base = ide_base;
@@ -1002,8 +992,6 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
 
 err_rel_dma:
 	ep93xx_pata_release_dma(drv_data);
-err_rel_gpio:
-	ep93xx_ide_release_gpio(pdev);
 	return err;
 }
 
@@ -1015,7 +1003,6 @@ static void ep93xx_pata_remove(struct platform_device *pdev)
 	ata_host_detach(host);
 	ep93xx_pata_release_dma(drv_data);
 	ep93xx_pata_clear_regs(drv_data->ide_base);
-	ep93xx_ide_release_gpio(pdev);
 }
 
 static const struct of_device_id ep93xx_pata_of_ids[] = {
diff --git a/include/linux/soc/cirrus/ep93xx.h b/include/linux/soc/cirrus/ep93xx.h
index f6376edc1b33..142c33a2d7db 100644
--- a/include/linux/soc/cirrus/ep93xx.h
+++ b/include/linux/soc/cirrus/ep93xx.h
@@ -37,15 +37,11 @@ struct ep93xx_regmap_adev {
 	container_of((_adev), struct ep93xx_regmap_adev, adev)
 
 #ifdef CONFIG_ARCH_EP93XX
-int ep93xx_ide_acquire_gpio(struct platform_device *pdev);
-void ep93xx_ide_release_gpio(struct platform_device *pdev);
 int ep93xx_i2s_acquire(void);
 void ep93xx_i2s_release(void);
 unsigned int ep93xx_chip_revision(void);
 
 #else
-static inline int ep93xx_ide_acquire_gpio(struct platform_device *pdev) { return 0; }
-static inline void ep93xx_ide_release_gpio(struct platform_device *pdev) {}
 static inline int ep93xx_i2s_acquire(void) { return 0; }
 static inline void ep93xx_i2s_release(void) {}
 static inline unsigned int ep93xx_chip_revision(void) { return 0; }

-- 
2.41.0



