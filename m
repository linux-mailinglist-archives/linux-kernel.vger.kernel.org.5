Return-Path: <linux-kernel+bounces-143914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE358A3F78
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 00:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84EE4281FBB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 22:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2964F59B5A;
	Sat, 13 Apr 2024 22:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dpal4iUP"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7D65822D
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 22:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713046493; cv=none; b=BHw6NTON5KJ3MubUYn0QSeeuGpV88B76Jr2FURTqLrK8BaYc5nioLClKsH55Z7Wq199c5dVin5fMNOF4WG24V0drZTrX+GmaoaphESL9bZ7jWKRXIi3TyClNjWc0B3tFt3TkJ14Y9eqISG+YWyC/vYpeXXoj/r5onmw3To5MDNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713046493; c=relaxed/simple;
	bh=t/v4SvTBVOvlXHo6bj57OEcR10VBicqPtIAF3xVo6vM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c48OPUJHZH0T4SYlkRt/UwJ0mP8jfmK9UYylT+7qlXfF3mpmAG2aB+QwlLJcEVRppQeasvFWJ0wsxDr+BjVSCOM+wh8mgEi6ZWjiWcSI1YtEV3RQ8hN5OgqcF3jIJX1ggG939MbQR4Ire0N5kWyC2o7tfhMoRTgAl94r16NmXv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dpal4iUP; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e1f3462caso2314081a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 15:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713046488; x=1713651288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fA771kt8hCcPGr1GpkOeIojExofGpM8CM3U7EP817/I=;
        b=dpal4iUP81hb16Gp8563IVHU/nfjcwv4cxml+tE/8dCZ3Er43HZfblKd5p6ZtphsLX
         maTuSVVTkwPODVxlEa5JC5Sx6oDG6T+O+osmXLcenfqP5l46MjP0Me5BP+VSqiL4ULlz
         wonxguh3qRw+LLL59p45cdjPkK3Ls9lYRgOkhRO1KOEkROJZJAhgrSuIothT6Cbwwxkd
         IIJz0f6LLazTbl1gwVi666cjSzazlCK5iOb2/NsQOjlkAgVVYmL5lkVKw0rKOJBCWPjN
         B+S+lX+KeOYllCcZ0q23jML6Np5HeTHBnnDQkln9zNaV/c2+XLITrW33+I6Xr/SBOdGC
         KR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713046488; x=1713651288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fA771kt8hCcPGr1GpkOeIojExofGpM8CM3U7EP817/I=;
        b=WTT8Dbdu0hYGguSzFJfd7VCZYWWcSaxzHo5+0GMj1YsZ4BgP1r7zippv3txBWHAg4J
         zzJ1mNeLHLLf32AlbQL4QPXXvwvm/MLgyH2zwj5viHqefNxe7gXMJ7cC3xVFuCAzoq2Z
         G6Do4HNrg4cekGfvfBvIn2uLeI7mmAJ2CDvTlyjFyzv6mJxvNSquiz+1krzmq2KVkmqC
         Rc8BHq1t6/3qCvRN+VWIQYuClR23NLT/f5qSg0d8Q8u04EJhXgMFdl+KzryFVg+eZDXy
         TV23LbO/412ZSqrzbcTBmosAD4eKtyhHpf4YNnfgH8BZOmsKfk20WOIRgYAb1frlGcgt
         /XsA==
X-Forwarded-Encrypted: i=1; AJvYcCUO+F+JoBe5xYEN47sKDzSbFSUVUekF2KBMzlTkekKhBf1IREPh0T19x+4PKwaJAVFTEc1CH7GB9X0v3BvUNBc1ZhBAd2CYc+IlkQ58
X-Gm-Message-State: AOJu0YxbdMlYl1z8km/AJX87D4uAC6od8jRx3d4vp/LFFWhqBMW7ZDhO
	39cSKPvho6QpiQaKVJaw0OrcnY8/ozzxEFbWzQ60Wb5ail5iefxNbqdB3mumUaw=
X-Google-Smtp-Source: AGHT+IG4pV2iupNKwc9AXTwfekLEitklh80izzkdQaN8cJUcuNLMD11nslYzgxDNp/Za6/jUupDQgw==
X-Received: by 2002:a50:9315:0:b0:570:1e3e:a019 with SMTP id m21-20020a509315000000b005701e3ea019mr468802eda.11.1713046488044;
        Sat, 13 Apr 2024 15:14:48 -0700 (PDT)
Received: from localhost (host-87-4-160-102.retail.telecomitalia.it. [87.4.160.102])
        by smtp.gmail.com with ESMTPSA id p4-20020a05640243c400b0056fe7c5475bsm2880991edc.10.2024.04.13.15.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 15:14:47 -0700 (PDT)
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
Subject: [PATCH 6/6] mmc: sdhci-brcmstb: Add BCM2712 SD Express support
Date: Sun, 14 Apr 2024 00:14:28 +0200
Message-ID: <a3d82e5a28fe53f1f61621d37d1695b0cd7655d2.1713036964.git.andrea.porta@suse.com>
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

Broadcom BCM2712 SDHCI controller is SD Express capable. Add support
for sde capability where the implementation is based on downstream driver,
diverging from it in the way that init_sd_express callback is invoked:
in downstream the sdhci_ops structure has been augmented with a new
function ptr 'init_sd_express' that just propagate the call to the
driver specific callback so that the callstack from a structure
standpoint is mmc_host_ops -> sdhci_ops. The drawback here is in the
added level of indirection (the newly added init_sd_express is
redundant) and the sdhci_ops structure declaration has to be changed.
To overcome this the presented approach consist in patching the mmc_host_ops
init_sd_express callback to point directly to the custom function defined in
this driver (see struct brcmstb_match_priv).

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/mmc/host/Kconfig         |   1 +
 drivers/mmc/host/sdhci-brcmstb.c | 147 ++++++++++++++++++++++++++++++-
 2 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index aebc587f77a7..343ccac1a4e4 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1018,6 +1018,7 @@ config MMC_SDHCI_BRCMSTB
 	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	select MMC_CQHCI
+	select OF_DYNAMIC
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	help
 	  This selects support for the SDIO/SD/MMC Host Controller on
diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 907a4947abe5..56fb34a75ec2 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -29,6 +29,7 @@
 
 #define BRCMSTB_PRIV_FLAGS_HAS_CQE		BIT(0)
 #define BRCMSTB_PRIV_FLAGS_GATE_CLOCK		BIT(1)
+#define BRCMSTB_PRIV_FLAGS_HAS_SD_EXPRESS	BIT(2)
 
 #define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
 
@@ -50,13 +51,19 @@ struct sdhci_brcmstb_priv {
 	unsigned int flags;
 	struct clk *base_clk;
 	u32 base_freq_hz;
+	struct regulator *sde_1v8;
+	struct device_node *sde_pcie;
+	void *__iomem sde_ioaddr;
+	void *__iomem sde_ioaddr2;
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pins_default;
+	struct pinctrl_state *pins_sdex;
 };
 
 struct brcmstb_match_priv {
 	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
 	void (*cfginit)(struct sdhci_host *host);
+	int (*init_sd_express)(struct mmc_host *mmc, struct mmc_ios *ios);
 	struct sdhci_ops *ops;
 	const unsigned int flags;
 };
@@ -263,6 +270,105 @@ static void sdhci_brcmstb_cfginit_2712(struct sdhci_host *host)
 	}
 }
 
+static int bcm2712_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *brcmstb_priv = sdhci_pltfm_priv(pltfm_host);
+	struct device *dev = host->mmc->parent;
+	u32 ctrl_val;
+	u32 present_state;
+	int ret;
+
+	if (!brcmstb_priv->sde_ioaddr || !brcmstb_priv->sde_ioaddr2)
+		return -EINVAL;
+
+	if (!brcmstb_priv->pinctrl)
+		return -EINVAL;
+
+	/* Turn off the SD clock first */
+	sdhci_set_clock(host, 0);
+
+	/* Disable SD DAT0-3 pulls */
+	pinctrl_select_state(brcmstb_priv->pinctrl, brcmstb_priv->pins_sdex);
+
+	ctrl_val = readl(brcmstb_priv->sde_ioaddr);
+	dev_dbg(dev, "ctrl_val 1 %08x\n", ctrl_val);
+
+	/* Tri-state the SD pins */
+	ctrl_val |= 0x1ff8;
+	writel(ctrl_val, brcmstb_priv->sde_ioaddr);
+	dev_dbg(dev, "ctrl_val 1->%08x (%08x)\n", ctrl_val, readl(brcmstb_priv->sde_ioaddr));
+	/* Let voltages settle */
+	udelay(100);
+
+	/* Enable the PCIe sideband pins */
+	ctrl_val &= ~0x6000;
+	writel(ctrl_val, brcmstb_priv->sde_ioaddr);
+	dev_dbg(dev, "ctrl_val 1->%08x (%08x)\n", ctrl_val, readl(brcmstb_priv->sde_ioaddr));
+	/* Let voltages settle */
+	udelay(100);
+
+	/* Turn on the 1v8 VDD2 regulator */
+	ret = regulator_enable(brcmstb_priv->sde_1v8);
+	if (ret)
+		return ret;
+
+	/* Wait for Tpvcrl */
+	msleep(1);
+
+	/* Sample DAT2 (CLKREQ#) - if low, card is in PCIe mode */
+	present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
+	present_state = (present_state & SDHCI_DATA_LVL_MASK) >> SDHCI_DATA_LVL_SHIFT;
+	dev_dbg(dev, "state = 0x%08x\n", present_state);
+
+	if (present_state & BIT(2)) {
+		dev_err(dev, "DAT2 still high, abandoning SDex switch\n");
+		return -ENODEV;
+	}
+
+	/* Turn on the LCPLL PTEST mux */
+	ctrl_val = readl(brcmstb_priv->sde_ioaddr2 + 20); // misc5
+	ctrl_val &= ~(0x7 << 7);
+	ctrl_val |= 3 << 7;
+	writel(ctrl_val, brcmstb_priv->sde_ioaddr2 + 20);
+	dev_dbg(dev, "misc 5->%08x (%08x)\n", ctrl_val, readl(brcmstb_priv->sde_ioaddr2 + 20));
+
+	/* PTEST diff driver enable */
+	ctrl_val = readl(brcmstb_priv->sde_ioaddr2);
+	ctrl_val |= BIT(21);
+	writel(ctrl_val, brcmstb_priv->sde_ioaddr2);
+
+	dev_dbg(dev, "misc 0->%08x (%08x)\n", ctrl_val, readl(brcmstb_priv->sde_ioaddr2));
+
+	/* Wait for more than the minimum Tpvpgl time */
+	msleep(100);
+
+	if (brcmstb_priv->sde_pcie) {
+		struct of_changeset changeset;
+		static struct property okay_property = {
+			.name = "status",
+			.value = "okay",
+			.length = 5,
+		};
+
+		/* Enable the pcie controller */
+		of_changeset_init(&changeset);
+		ret = of_changeset_update_property(&changeset,
+						   brcmstb_priv->sde_pcie,
+						   &okay_property);
+		if (ret) {
+			dev_err(dev, "%s: failed to update property - %d\n", __func__,
+			       ret);
+			return -ENODEV;
+		}
+		ret = of_changeset_apply(&changeset);
+	}
+
+	dev_dbg(dev, "%s -> %d\n", __func__, ret);
+	return ret;
+}
+
 static void sdhci_brcmstb_dumpregs(struct mmc_host *mmc)
 {
 	sdhci_dumpregs(mmc_priv(mmc));
@@ -342,6 +448,7 @@ static struct brcmstb_match_priv match_priv_74165b0 = {
 
 static const struct brcmstb_match_priv match_priv_2712 = {
 	.cfginit = sdhci_brcmstb_cfginit_2712,
+	.init_sd_express = bcm2712_init_sd_express,
 	.ops = &sdhci_brcmstb_ops_2712,
 };
 
@@ -423,6 +530,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	struct sdhci_brcmstb_priv *priv;
 	u32 actual_clock_mhz;
 	struct sdhci_host *host;
+	struct resource *iomem;
 	bool no_pinctrl = false;
 	struct clk *clk;
 	struct clk *base_clk = NULL;
@@ -456,6 +564,11 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 		match_priv->ops->irq = sdhci_brcmstb_cqhci_irq;
 	}
 
+	priv->sde_pcie = of_parse_phandle(pdev->dev.of_node,
+					  "sde-pcie", 0);
+	if (priv->sde_pcie)
+		priv->flags |= BRCMSTB_PRIV_FLAGS_HAS_SD_EXPRESS;
+
 	/* Map in the non-standard CFG registers */
 	priv->cfg_regs = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
 	if (IS_ERR(priv->cfg_regs)) {
@@ -468,6 +581,24 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	if (res)
 		goto err;
 
+	priv->sde_1v8 = devm_regulator_get_optional(&pdev->dev, "sde-1v8");
+	if (IS_ERR(priv->sde_1v8))
+		priv->flags &= ~BRCMSTB_PRIV_FLAGS_HAS_SD_EXPRESS;
+
+	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	if (iomem) {
+		priv->sde_ioaddr = devm_ioremap_resource(&pdev->dev, iomem);
+		if (IS_ERR(priv->sde_ioaddr))
+			priv->sde_ioaddr = NULL;
+	}
+
+	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 3);
+	if (iomem) {
+		priv->sde_ioaddr2 = devm_ioremap_resource(&pdev->dev, iomem);
+		if (IS_ERR(priv->sde_ioaddr2))
+			priv->sde_ioaddr = NULL;
+	}
+
 	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (IS_ERR(priv->pinctrl)) {
 			no_pinctrl = true;
@@ -478,8 +609,16 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 			no_pinctrl = true;
 	}
 
-	if (no_pinctrl )
+	priv->pins_sdex = pinctrl_lookup_state(priv->pinctrl, "sd-express");
+	if (IS_ERR(priv->pins_sdex)) {
+			dev_dbg(&pdev->dev, "No pinctrl sd-express state\n");
+			no_pinctrl = true;
+	}
+
+	if (no_pinctrl || !priv->sde_ioaddr || !priv->sde_ioaddr2) {
 		priv->pinctrl = NULL;
+		priv->flags &= ~BRCMSTB_PRIV_FLAGS_HAS_SD_EXPRESS;
+	}
 
 	/*
 	 * Automatic clock gating does not work for SD cards that may
@@ -497,6 +636,12 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	    (host->mmc->caps2 & MMC_CAP2_HS400_ES))
 		host->mmc_host_ops.hs400_enhanced_strobe = match_priv->hs400es;
 
+	if (match_priv->init_sd_express &&
+	    (priv->flags & BRCMSTB_PRIV_FLAGS_HAS_SD_EXPRESS)) {
+		host->mmc->caps2 |= MMC_CAP2_SD_EXP;
+		host->mmc_host_ops.init_sd_express = match_priv->init_sd_express;
+	}
+
 	if(match_priv->cfginit)
 		match_priv->cfginit(host);
 
-- 
2.35.3


