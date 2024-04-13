Return-Path: <linux-kernel+bounces-143913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52148A3F75
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 00:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66511C20E14
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 22:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8386E57310;
	Sat, 13 Apr 2024 22:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XEzRomwM"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFA158135
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 22:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713046492; cv=none; b=B/9GCzjTXQTirJ4iajNKJ4DkGl4sOB+GIak/RVl1nk/dwhtFKlosiY/FnsiA9wyGpcyvCmk8iTECB1nHKZwED0wpCmg2kCPHbvIfwffAhafEsZDgBdh9IGgljJoAKFX1ntOcc+qWPHR9+dArDxgoKeFYjjeNVVbWmM0yWyiqacw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713046492; c=relaxed/simple;
	bh=M0HbViSqIJdpYbmigPx1R2It9w5wm6INS0lndwvsZtA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FShKfe66K0kAB2FgC9YH+Xn/8dgrZMwPAQsqaDdUjXWN4crF/nL634uoVwR9X8gUkxdN/zp+UTWqvhl/eCi4RWF6NNbkkGtdeH5bDdbh4VYAVeiiVNVbPA0D6F81vrXD80MOWlg5dKROER0rA9UsbuyeUxZSvU4wyWh6Bh6Xrwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XEzRomwM; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5200202c1bso238373566b.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 15:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713046487; x=1713651287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWTANOhwt+MSlpwP2S7BNom6jkNUFDJjf/oC5BBrk94=;
        b=XEzRomwMx+653r/J2QLd+SGTM8G9ds5241XY9RGkG9VFn5/DhZ0ipfgi0PoGJH8Ocs
         vcuiOp7mbc7jtw4FG0mMlYsvuKOQp1SH4bV+bBHzPACEBMOa0TB9GEQQK10vv8Uiar8b
         H9TNUJdk2cc8maXVyFefRDi9fc7M1LJYL7b8srCzUh7GBiU3PWLkOftrubfAdDea+GAn
         aHnPvb3Mmnhyz9A5lHRUmMihuKsFKQLupv877uDTWTlPCf4mw15Fv02hRQbccMK7un09
         7P6xufraqDXlRTPFw8231/JKV45jo3/QOZpS+9W086i6uoD8E8iRUDoS/619sEp5Xwr6
         VKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713046487; x=1713651287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWTANOhwt+MSlpwP2S7BNom6jkNUFDJjf/oC5BBrk94=;
        b=vXTG1Tn1+danD+caY2GzbBrcs6kuDQfhQ8ASA86kvCoSk+R+6rgJfQLYCfi8GHKGJh
         DGe/8Bx6aGy4vPDR5uuwJgZCw1aosVwXBg275agFuGOgQhtTq9sg5GMOaAvfw0A4u5mU
         Tz1ii4QBAOTefOYJm/kvRxDlyfiyjiGE5dbqC4Neyixp40JQUtbwkHsxCiecqtnsbdtq
         gMhPGQ+qWDT6ri6mn03RbyiaslpHU/gb1R60eqv02YHjW9fhJQOCNpH53HrNeQZ1hL8a
         SohzuZuged5yJHg9vETdoNBg23mxJJla8Qxhu8p1/ha4sNUN/0cYxjuIrsL5OWYd8FW5
         uhVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNp5mGkSmFFoNYj3GDxUF5q2QEwT3TRJKOvhnBZh1KfModctSslYh2O6BU4Jm+i0MaK/I4hgtkjwP3qT6xxdCmCNCz+sXnEzojQUKg
X-Gm-Message-State: AOJu0YwxkX6XXuB8n3+AfCXNwXr+KqPTbgDDCAQ/cmiUUpXOb+vnFJjv
	yjEZ7XFl5p9hbY9zKklEMnCUt916Dd0GTaqtjTZ1Yak9lZGsbK/Hf2wVrMC3GA4=
X-Google-Smtp-Source: AGHT+IGGACuxkVW15FsJ637ATg0ReSd4myxi07+XaFVDWXDTPQjXO0GYHx/ICzPrtC0Cv2kmv6xxKA==
X-Received: by 2002:a17:906:2c59:b0:a52:5765:4850 with SMTP id f25-20020a1709062c5900b00a5257654850mr736703ejh.58.1713046486861;
        Sat, 13 Apr 2024 15:14:46 -0700 (PDT)
Received: from localhost (host-87-4-160-102.retail.telecomitalia.it. [87.4.160.102])
        by smtp.gmail.com with ESMTPSA id gv15-20020a170906f10f00b00a517995c070sm3453101ejb.33.2024.04.13.15.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 15:14:46 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	della Porta <andrea.porta@suse.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH 5/6] mmc: sdhci-brcmstb: Add BCM2712 support
Date: Sun, 14 Apr 2024 00:14:27 +0200
Message-ID: <7a75876def65f6282b7b3ca17ef8008c305d6c32.1713036964.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713036964.git.andrea.porta@suse.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Broadcom BCM2712 SoC has an SDHCI card controller using the SDIO CFG
register block present on other STB chips. Add support for BCM2712
SD capabilities of this chipset.
The silicon is SD Express capable but this driver port does not currently
include that feature yet.
Based on downstream driver by raspberry foundation maintained kernel.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 130 +++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 9053526fa212..907a4947abe5 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -12,6 +12,8 @@
 #include <linux/of.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/regulator/consumer.h>
 
 #include "sdhci-cqhci.h"
 #include "sdhci-pltfm.h"
@@ -30,15 +32,31 @@
 
 #define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
 
+#define SDIO_CFG_CTRL				0x0
+#define  SDIO_CFG_CTRL_SDCD_N_TEST_EN		BIT(31)
+#define  SDIO_CFG_CTRL_SDCD_N_TEST_LEV		BIT(30)
+
+#define SDIO_CFG_SD_PIN_SEL			0x44
+#define  SDIO_CFG_SD_PIN_SEL_MASK		0x3
+#define  SDIO_CFG_SD_PIN_SEL_SD			BIT(1)
+#define  SDIO_CFG_SD_PIN_SEL_MMC		BIT(0)
+
+#define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
+#define  SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE	BIT(31)
+#define  SDIO_CFG_MAX_50MHZ_MODE_ENABLE		BIT(0)
+
 struct sdhci_brcmstb_priv {
 	void __iomem *cfg_regs;
 	unsigned int flags;
 	struct clk *base_clk;
 	u32 base_freq_hz;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pins_default;
 };
 
 struct brcmstb_match_priv {
 	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
+	void (*cfginit)(struct sdhci_host *host);
 	struct sdhci_ops *ops;
 	const unsigned int flags;
 };
@@ -124,6 +142,42 @@ static void sdhci_brcmstb_hs400es(struct mmc_host *mmc, struct mmc_ios *ios)
 	writel(reg, host->ioaddr + SDHCI_VENDOR);
 }
 
+static void sdhci_bcm2712_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	u16 clk;
+	u32 reg;
+	bool is_emmc_rate = false;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *brcmstb_priv = sdhci_pltfm_priv(pltfm_host);
+
+	host->mmc->actual_clock = 0;
+
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+
+	switch (host->mmc->ios.timing) {
+	case MMC_TIMING_MMC_HS400:
+	case MMC_TIMING_MMC_HS200:
+	case MMC_TIMING_MMC_DDR52:
+	case MMC_TIMING_MMC_HS:
+	is_emmc_rate = true;
+	break;
+	}
+
+	reg = readl(brcmstb_priv->cfg_regs + SDIO_CFG_SD_PIN_SEL);
+	reg &= ~SDIO_CFG_SD_PIN_SEL_MASK;
+	if (is_emmc_rate)
+		reg |= SDIO_CFG_SD_PIN_SEL_MMC;
+	else
+		reg |= SDIO_CFG_SD_PIN_SEL_SD;
+	writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_SD_PIN_SEL);
+
+	if (clock == 0)
+		return;
+
+	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
+	sdhci_enable_clk(host, clk);
+}
+
 static void sdhci_brcmstb_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	u16 clk;
@@ -139,6 +193,17 @@ static void sdhci_brcmstb_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_enable_clk(host, clk);
 }
 
+static void sdhci_brcmstb_set_power(struct sdhci_host *host, unsigned char mode,
+				  unsigned short vdd)
+{
+	if (!IS_ERR(host->mmc->supply.vmmc)) {
+		struct mmc_host *mmc = host->mmc;
+
+		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+	}
+	sdhci_set_power_noreg(host, mode, vdd);
+}
+
 static void sdhci_brcmstb_set_uhs_signaling(struct sdhci_host *host,
 					    unsigned int timing)
 {
@@ -168,6 +233,36 @@ static void sdhci_brcmstb_set_uhs_signaling(struct sdhci_host *host,
 	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 }
 
+static void sdhci_brcmstb_cfginit_2712(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *brcmstb_priv = sdhci_pltfm_priv(pltfm_host);
+	u32 uhs_mask = (MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104);
+	u32 hsemmc_mask = (MMC_CAP2_HS200_1_8V_SDR | MMC_CAP2_HS200_1_2V_SDR |
+			   MMC_CAP2_HS400_1_8V | MMC_CAP2_HS400_1_2V);
+	u32 reg;
+
+	/*
+	* If we support a speed that requires tuning,
+	* then select the delay line PHY as the clock source.
+	*/
+	if ((host->mmc->caps & uhs_mask) || (host->mmc->caps2 & hsemmc_mask)) {
+		reg = readl(brcmstb_priv->cfg_regs + SDIO_CFG_MAX_50MHZ_MODE);
+		reg &= ~SDIO_CFG_MAX_50MHZ_MODE_ENABLE;
+		reg |= SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE;
+		writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_MAX_50MHZ_MODE);
+	}
+
+	if ((host->mmc->caps & MMC_CAP_NONREMOVABLE) ||
+	    (host->mmc->caps & MMC_CAP_NEEDS_POLL)) {
+		/* Force presence */
+		reg = readl(brcmstb_priv->cfg_regs + SDIO_CFG_CTRL);
+		reg &= ~SDIO_CFG_CTRL_SDCD_N_TEST_LEV;
+		reg |= SDIO_CFG_CTRL_SDCD_N_TEST_EN;
+		writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_CTRL);
+	}
+}
+
 static void sdhci_brcmstb_dumpregs(struct mmc_host *mmc)
 {
 	sdhci_dumpregs(mmc_priv(mmc));
@@ -200,6 +295,14 @@ static struct sdhci_ops sdhci_brcmstb_ops = {
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
+static struct sdhci_ops sdhci_brcmstb_ops_2712 = {
+	.set_clock = sdhci_bcm2712_set_clock,
+	.set_power = sdhci_brcmstb_set_power,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+};
+
 static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
 	.set_clock = sdhci_brcmstb_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -237,7 +340,13 @@ static struct brcmstb_match_priv match_priv_74165b0 = {
 	.ops = &sdhci_brcmstb_ops_74165b0,
 };
 
+static const struct brcmstb_match_priv match_priv_2712 = {
+	.cfginit = sdhci_brcmstb_cfginit_2712,
+	.ops = &sdhci_brcmstb_ops_2712,
+};
+
 static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
+	{ .compatible = "brcm,bcm2712-sdhci", .data = &match_priv_2712 },
 	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
 	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
 	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
@@ -314,11 +423,16 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	struct sdhci_brcmstb_priv *priv;
 	u32 actual_clock_mhz;
 	struct sdhci_host *host;
+	bool no_pinctrl = false;
 	struct clk *clk;
 	struct clk *base_clk = NULL;
 	int res;
 
 	match = of_match_node(sdhci_brcm_of_match, pdev->dev.of_node);
+	if (!match) {
+		dev_err(&pdev->dev, "fail to get matching of_match struct\n");
+		return -EINVAL;
+	}
 	match_priv = match->data;
 
 	dev_dbg(&pdev->dev, "Probe found match for %s\n",  match->compatible);
@@ -354,6 +468,19 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	if (res)
 		goto err;
 
+	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (IS_ERR(priv->pinctrl)) {
+			no_pinctrl = true;
+	}
+	priv->pins_default = pinctrl_lookup_state(priv->pinctrl, "default");
+	if (IS_ERR(priv->pins_default)) {
+			dev_dbg(&pdev->dev, "No pinctrl default state\n");
+			no_pinctrl = true;
+	}
+
+	if (no_pinctrl )
+		priv->pinctrl = NULL;
+
 	/*
 	 * Automatic clock gating does not work for SD cards that may
 	 * voltage switch so only enable it for non-removable devices.
@@ -370,6 +497,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	    (host->mmc->caps2 & MMC_CAP2_HS400_ES))
 		host->mmc_host_ops.hs400_enhanced_strobe = match_priv->hs400es;
 
+	if(match_priv->cfginit)
+		match_priv->cfginit(host);
+
 	/*
 	 * Supply the existing CAPS, but clear the UHS modes. This
 	 * will allow these modes to be specified by device tree
-- 
2.35.3


