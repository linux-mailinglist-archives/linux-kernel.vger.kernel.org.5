Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4050A7E591D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjKHOeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjKHOeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:34:04 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC441FC4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:34:01 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50949b7d7ffso9335094e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 06:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699454040; x=1700058840; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+oAJ5h0iCYT/XiQuEoEbc72vTkOvqIZdMfvjIyq8PY0=;
        b=J4v/lYiv43AA7dDx8Jj2zFvcLETxIFidUCx4LeGxFz7n4rcgsdj/k2ofXUAE4v6ixa
         u4HHxewjkErpPnzPUyM+6hMI7D1eMxBe7HEF1Ez8s+de8flA3edh2Zuo7PwGTWXSLI3I
         MGN/pUR5gKdXqK/Vri5Uff6PUcTIaMXusLicYG0SwGnV5hhirTchFF1PemkKYHJWnmX9
         koexDLyY+Ut9S338ml0RjSNOp2fZYhtmFVJU7nlA7o2zx/8gcgJBB5fHREy0qDNiDEKr
         WwAR5H5IjIok3tr+hXXyGfQuXLKCo+oeaRC52n44Ikr8svrM5uOru3ait8saJdGSUcFB
         Zqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699454040; x=1700058840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oAJ5h0iCYT/XiQuEoEbc72vTkOvqIZdMfvjIyq8PY0=;
        b=tX5gXOXAvIN4Wby7bO2m7VPcUdfMkWBqohUHdhSOAy1vLz08Dji0sjRDc85yP5GPee
         OU4c2xs2ZYOqpdVcjld15DaCl9jKHFpqHr9mqEeeXw2h+32/2V2+dhx53qOXkbO3N/Y8
         XWfZEbQSSS+xYZxu5ahz8Z1NTByGLIERYtna4Gl5I0HvpkZsZSQGcWA3uIbI0AfukGUD
         hqJPRgBbI1N660/hgQS+QWsVEeyYXkXeBWGPMausIL3izKLBpOQHhopK2h3G5uoICOEs
         mvg+oaM8lv0ab+oGhxjbsEaH2L+eB8Smj8CidE8m/3QixWB4sv5NOLeHfJhB0lzhohI2
         fAvw==
X-Gm-Message-State: AOJu0Yz+8AjkU4TwRVMfHin6CKUKDQDWGYGrjEonyy4PpkubW9qyLgeX
        gmIlIfvw6+2mTDGFBw0zR1LBww==
X-Google-Smtp-Source: AGHT+IGSpoq6bysGssnDl5wEZaN1gk2Q3WjefhpADT75fAnEikYjHNfsLUVEUxLoA08b+0hSPIrNHA==
X-Received: by 2002:a05:6512:b8d:b0:509:46ff:6e57 with SMTP id b13-20020a0565120b8d00b0050946ff6e57mr1807100lfv.8.1699454038182;
        Wed, 08 Nov 2023 06:33:58 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q10-20020ac24a6a000000b00507a3b8b007sm686773lfp.110.2023.11.08.06.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 06:33:57 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 08 Nov 2023 15:33:49 +0100
Subject: [PATCH 1/6] mtd: rawnand: ams-delta/gpio: Unify polarity
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231108-fix-mips-nand-v1-1-5fc5586d04de@linaro.org>
References: <20231108-fix-mips-nand-v1-0-5fc5586d04de@linaro.org>
In-Reply-To: <20231108-fix-mips-nand-v1-0-5fc5586d04de@linaro.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD Delta and GPIO RAW NAND drivers share the same platform
data file and pass GPIO descriptors for the same type of signals
from a board file.

Fix the following problems:

- NCE (negative active chip enable) should be just CE (chip enable)
  and flagged as active low. Rename it in both drivers to just "CE".

- NWP (negative active write protect) should be just WP (write protect)
  and flagged as active low. Rename it in both drivers to just "WP".

- NRE (negative active read enable) should be just RE (read enable)
  and flagged as active low. Rename it in the AMD Delta driver to "RE".
  The GPIO driver does not have this.

- NWE (negative active write enable) should be just WE (write enable)
  and flagged as active low. Rename it in the AMD Delta driver to "WE".
  The GPIO driver does not have this.

- The generic GPIO NAND driver is not expecting the GPIO polarity on
  CE and WP to be correct and will instead invert the polarity in
  the usage of the lines (such as setting the CE GPIO descriptor to
  0 to activate the chip enable). Fix this by altering the semantics
  in the generic GPIO driver to assume it is flagged active low
  properly where the GPIO line is defined.

- Fix up the arch/arm/mach-omap1/board-ams-delta.c to use the
  non-prefixed line names. (The polarity is right in this board.)

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-omap1/board-ams-delta.c |  8 ++---
 drivers/mtd/nand/raw/ams-delta.c      | 60 +++++++++++++++++------------------
 drivers/mtd/nand/raw/gpio.c           | 40 +++++++++++------------
 3 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 0daf6c5b5c1c..3a6ab4e27e3e 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -336,13 +336,13 @@ static struct gpiod_lookup_table ams_delta_nand_gpio_table = {
 	.table = {
 		GPIO_LOOKUP(OMAP_GPIO_LABEL, AMS_DELTA_GPIO_PIN_NAND_RB, "rdy",
 			    0),
-		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_NCE, "nce",
+		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_NCE, "ce",
 			    GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_NRE, "nre",
+		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_NRE, "re",
 			    GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_NWP, "nwp",
+		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_NWP, "wp",
 			    GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_NWE, "nwe",
+		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_NWE, "we",
 			    GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_ALE, "ale", 0),
 		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_CLE, "cle", 0),
diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 919816a7aca7..ab3c8d3da41d 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -33,10 +33,10 @@ struct gpio_nand {
 	struct nand_controller	base;
 	struct nand_chip	nand_chip;
 	struct gpio_desc	*gpiod_rdy;
-	struct gpio_desc	*gpiod_nce;
-	struct gpio_desc	*gpiod_nre;
-	struct gpio_desc	*gpiod_nwp;
-	struct gpio_desc	*gpiod_nwe;
+	struct gpio_desc	*gpiod_ce;
+	struct gpio_desc	*gpiod_re;
+	struct gpio_desc	*gpiod_wp;
+	struct gpio_desc	*gpiod_we;
 	struct gpio_desc	*gpiod_ale;
 	struct gpio_desc	*gpiod_cle;
 	struct gpio_descs	*data_gpiods;
@@ -49,9 +49,9 @@ struct gpio_nand {
 
 static void gpio_nand_write_commit(struct gpio_nand *priv)
 {
-	gpiod_set_value(priv->gpiod_nwe, 1);
+	gpiod_set_value(priv->gpiod_we, 1);
 	ndelay(priv->tWP);
-	gpiod_set_value(priv->gpiod_nwe, 0);
+	gpiod_set_value(priv->gpiod_we, 0);
 }
 
 static void gpio_nand_io_write(struct gpio_nand *priv, u8 byte)
@@ -86,13 +86,13 @@ static u8 gpio_nand_io_read(struct gpio_nand *priv)
 	struct gpio_descs *data_gpiods = priv->data_gpiods;
 	DECLARE_BITMAP(values, BITS_PER_TYPE(res)) = { 0, };
 
-	gpiod_set_value(priv->gpiod_nre, 1);
+	gpiod_set_value(priv->gpiod_re, 1);
 	ndelay(priv->tRP);
 
 	gpiod_get_raw_array_value(data_gpiods->ndescs, data_gpiods->desc,
 				  data_gpiods->info, values);
 
-	gpiod_set_value(priv->gpiod_nre, 0);
+	gpiod_set_value(priv->gpiod_re, 0);
 
 	res = values[0];
 	return res;
@@ -133,7 +133,7 @@ static void gpio_nand_read_buf(struct gpio_nand *priv, u8 *buf, int len)
 
 static void gpio_nand_ctrl_cs(struct gpio_nand *priv, bool assert)
 {
-	gpiod_set_value(priv->gpiod_nce, assert);
+	gpiod_set_value(priv->gpiod_ce, assert);
 }
 
 static int gpio_nand_exec_op(struct nand_chip *this,
@@ -204,7 +204,7 @@ static int gpio_nand_setup_interface(struct nand_chip *this, int csline,
 	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
 		return 0;
 
-	if (priv->gpiod_nre) {
+	if (priv->gpiod_re) {
 		priv->tRP = DIV_ROUND_UP(sdr->tRP_min, 1000);
 		dev_dbg(dev, "using %u ns read pulse width\n", priv->tRP);
 	}
@@ -273,35 +273,35 @@ static int gpio_nand_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 
 	/* Set chip enabled but write protected */
-	priv->gpiod_nwp = devm_gpiod_get_optional(&pdev->dev, "nwp",
+	priv->gpiod_wp = devm_gpiod_get_optional(&pdev->dev, "wp",
 						  GPIOD_OUT_HIGH);
-	if (IS_ERR(priv->gpiod_nwp)) {
-		err = PTR_ERR(priv->gpiod_nwp);
-		dev_err(&pdev->dev, "NWP GPIO request failed (%d)\n", err);
+	if (IS_ERR(priv->gpiod_wp)) {
+		err = PTR_ERR(priv->gpiod_wp);
+		dev_err(&pdev->dev, "WP GPIO request failed (%d)\n", err);
 		return err;
 	}
 
-	priv->gpiod_nce = devm_gpiod_get_optional(&pdev->dev, "nce",
+	priv->gpiod_ce = devm_gpiod_get_optional(&pdev->dev, "ce",
 						  GPIOD_OUT_LOW);
-	if (IS_ERR(priv->gpiod_nce)) {
-		err = PTR_ERR(priv->gpiod_nce);
-		dev_err(&pdev->dev, "NCE GPIO request failed (%d)\n", err);
+	if (IS_ERR(priv->gpiod_ce)) {
+		err = PTR_ERR(priv->gpiod_ce);
+		dev_err(&pdev->dev, "CE GPIO request failed (%d)\n", err);
 		return err;
 	}
 
-	priv->gpiod_nre = devm_gpiod_get_optional(&pdev->dev, "nre",
+	priv->gpiod_re = devm_gpiod_get_optional(&pdev->dev, "re",
 						  GPIOD_OUT_LOW);
-	if (IS_ERR(priv->gpiod_nre)) {
-		err = PTR_ERR(priv->gpiod_nre);
-		dev_err(&pdev->dev, "NRE GPIO request failed (%d)\n", err);
+	if (IS_ERR(priv->gpiod_re)) {
+		err = PTR_ERR(priv->gpiod_re);
+		dev_err(&pdev->dev, "RE GPIO request failed (%d)\n", err);
 		return err;
 	}
 
-	priv->gpiod_nwe = devm_gpiod_get_optional(&pdev->dev, "nwe",
+	priv->gpiod_we = devm_gpiod_get_optional(&pdev->dev, "we",
 						  GPIOD_OUT_LOW);
-	if (IS_ERR(priv->gpiod_nwe)) {
-		err = PTR_ERR(priv->gpiod_nwe);
-		dev_err(&pdev->dev, "NWE GPIO request failed (%d)\n", err);
+	if (IS_ERR(priv->gpiod_we)) {
+		err = PTR_ERR(priv->gpiod_we);
+		dev_err(&pdev->dev, "WE GPIO request failed (%d)\n", err);
 		return err;
 	}
 
@@ -328,9 +328,9 @@ static int gpio_nand_probe(struct platform_device *pdev)
 		return err;
 	}
 	if (priv->data_gpiods) {
-		if (!priv->gpiod_nwe) {
+		if (!priv->gpiod_we) {
 			dev_err(&pdev->dev,
-				"mandatory NWE pin not provided by platform\n");
+				"mandatory WE pin not provided by platform\n");
 			return -ENODEV;
 		}
 
@@ -367,7 +367,7 @@ static int gpio_nand_probe(struct platform_device *pdev)
 	 * chip detection/initialization.
 	 */
 	/* Release write protection */
-	gpiod_set_value(priv->gpiod_nwp, 0);
+	gpiod_set_value(priv->gpiod_wp, 0);
 
 	/*
 	 * This driver assumes that the default ECC engine should be TYPE_SOFT.
@@ -404,7 +404,7 @@ static void gpio_nand_remove(struct platform_device *pdev)
 	int ret;
 
 	/* Apply write protection */
-	gpiod_set_value(priv->gpiod_nwp, 1);
+	gpiod_set_value(priv->gpiod_wp, 1);
 
 	/* Unregister device */
 	ret = mtd_device_unregister(mtd);
diff --git a/drivers/mtd/nand/raw/gpio.c b/drivers/mtd/nand/raw/gpio.c
index d6cc2cb65214..df6facf0ec9a 100644
--- a/drivers/mtd/nand/raw/gpio.c
+++ b/drivers/mtd/nand/raw/gpio.c
@@ -33,11 +33,11 @@ struct gpiomtd {
 	void __iomem		*io_sync;
 	struct nand_chip	nand_chip;
 	struct gpio_nand_platdata plat;
-	struct gpio_desc *nce; /* Optional chip enable */
+	struct gpio_desc *ce; /* Optional chip enable */
 	struct gpio_desc *cle;
 	struct gpio_desc *ale;
 	struct gpio_desc *rdy;
-	struct gpio_desc *nwp; /* Optional write protection */
+	struct gpio_desc *wp; /* Optional write protection */
 };
 
 static inline struct gpiomtd *gpio_nand_getpriv(struct mtd_info *mtd)
@@ -146,7 +146,7 @@ static int gpio_nand_exec_op(struct nand_chip *chip,
 		return 0;
 
 	gpio_nand_dosync(gpiomtd);
-	gpiod_set_value(gpiomtd->nce, 0);
+	gpiod_set_value(gpiomtd->ce, 1);
 	for (i = 0; i < op->ninstrs; i++) {
 		ret = gpio_nand_exec_instr(chip, &op->instrs[i]);
 		if (ret)
@@ -156,7 +156,7 @@ static int gpio_nand_exec_op(struct nand_chip *chip,
 			ndelay(op->instrs[i].delay_ns);
 	}
 	gpio_nand_dosync(gpiomtd);
-	gpiod_set_value(gpiomtd->nce, 1);
+	gpiod_set_value(gpiomtd->ce, 0);
 
 	return ret;
 }
@@ -276,10 +276,10 @@ static void gpio_nand_remove(struct platform_device *pdev)
 	nand_cleanup(chip);
 
 	/* Enable write protection and disable the chip */
-	if (gpiomtd->nwp && !IS_ERR(gpiomtd->nwp))
-		gpiod_set_value(gpiomtd->nwp, 0);
-	if (gpiomtd->nce && !IS_ERR(gpiomtd->nce))
-		gpiod_set_value(gpiomtd->nce, 0);
+	if (gpiomtd->wp && !IS_ERR(gpiomtd->wp))
+		gpiod_set_value(gpiomtd->wp, 1);
+	if (gpiomtd->ce && !IS_ERR(gpiomtd->ce))
+		gpiod_set_value(gpiomtd->ce, 0);
 }
 
 static int gpio_nand_probe(struct platform_device *pdev)
@@ -316,14 +316,14 @@ static int gpio_nand_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Just enable the chip */
-	gpiomtd->nce = devm_gpiod_get_optional(dev, "nce", GPIOD_OUT_HIGH);
-	if (IS_ERR(gpiomtd->nce))
-		return PTR_ERR(gpiomtd->nce);
+	gpiomtd->ce = devm_gpiod_get_optional(dev, "ce", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiomtd->ce))
+		return PTR_ERR(gpiomtd->ce);
 
 	/* We disable write protection once we know probe() will succeed */
-	gpiomtd->nwp = devm_gpiod_get_optional(dev, "nwp", GPIOD_OUT_LOW);
-	if (IS_ERR(gpiomtd->nwp)) {
-		ret = PTR_ERR(gpiomtd->nwp);
+	gpiomtd->wp = devm_gpiod_get_optional(dev, "wp", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiomtd->wp)) {
+		ret = PTR_ERR(gpiomtd->wp);
 		goto out_ce;
 	}
 
@@ -358,8 +358,8 @@ static int gpio_nand_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, gpiomtd);
 
 	/* Disable write protection, if wired up */
-	if (gpiomtd->nwp && !IS_ERR(gpiomtd->nwp))
-		gpiod_direction_output(gpiomtd->nwp, 1);
+	if (gpiomtd->wp && !IS_ERR(gpiomtd->wp))
+		gpiod_direction_output(gpiomtd->wp, 0);
 
 	/*
 	 * This driver assumes that the default ECC engine should be TYPE_SOFT.
@@ -381,11 +381,11 @@ static int gpio_nand_probe(struct platform_device *pdev)
 		return 0;
 
 err_wp:
-	if (gpiomtd->nwp && !IS_ERR(gpiomtd->nwp))
-		gpiod_set_value(gpiomtd->nwp, 0);
+	if (gpiomtd->wp && !IS_ERR(gpiomtd->wp))
+		gpiod_set_value(gpiomtd->wp, 1);
 out_ce:
-	if (gpiomtd->nce && !IS_ERR(gpiomtd->nce))
-		gpiod_set_value(gpiomtd->nce, 0);
+	if (gpiomtd->ce && !IS_ERR(gpiomtd->ce))
+		gpiod_set_value(gpiomtd->ce, 0);
 
 	return ret;
 }

-- 
2.34.1

