Return-Path: <linux-kernel+bounces-146567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FA28A6757
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5011C20FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32C486243;
	Tue, 16 Apr 2024 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQgAJx+O"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E699185953;
	Tue, 16 Apr 2024 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713260656; cv=none; b=LRa02rqkwEcorND7vNxmu8eeiJBuHAD4JgLUIeNZTWTcL9VFtl/iTjocFLoAm8uDBMsrRObhW7srUtH2V0Fv5/W6RiWUM+RAz1A66z02nqBmWkRjpti6tI5WWfT7i6C2ci6z8tA7cJI5vRnF+xqOpHTcO/yWp1DtuBjXpBVwmtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713260656; c=relaxed/simple;
	bh=fNikXJuYg5SG5QpCHG7YDyuIaciRXUnjGkOWdoioi10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mdKgj1pDJwFAfkV8RHTLzsrXPzUrJPdOSSXiV2OoeHX1RI/ZKviDaZZiUjWSh37fK3cYDfmfsd+NMGzNbXFeoUCjA/BFkPKwBUE9tevwfBb7gCNuXN6uNqp4zi/sDu6/UD0pAlv6gGe72k7jP5DMuD/8mLopmg8b3FpOP3WGx5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQgAJx+O; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5aa2a74c238so3159649eaf.3;
        Tue, 16 Apr 2024 02:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713260654; x=1713865454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dEljCr7NV7JzTHbmyGC+LjJmna98i2xthF5OsFqHKw=;
        b=dQgAJx+Oaf1U0M8SIia9yRLssi9pVSQ4E8afyOmN/5JXR71EpGKQjMf+6LSopGGeCq
         falDiAeI0fMZobkE1jpl6YvcUUw159Wdky1tGGPDPOXjafoAWYMhRQQDrvE0U249fMT/
         cXskZqx6SWxKBfr6HJGBvKlB1ayjSdVo3b4/GTd9SBXI7dHQ5LkgB41VHWyVOboNvD5f
         VYUnknOBhfTi+3e6EnIDNJ6UyyEDffDbvW2fYdHVch0tfpKhGgDh0ppTE9QBXb/br7Tr
         dYqSRfK6n6If2/FB3s5rskMAIyYgP9DfQbXg74pSps5Gsff5+Buz3mEfy/EfoBO+6s2Y
         hseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713260654; x=1713865454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dEljCr7NV7JzTHbmyGC+LjJmna98i2xthF5OsFqHKw=;
        b=E9IL71M+1R6p2rg8A57SJC6NUJPaHK9yDF7mn84iDyuulRQhA5gj8WayGA78JRljsm
         to1ib7y/kYT6jey23ZXBwXQkU7Vg13EtOnQV04QxI6HXYE1nZPzwmwknR2wgD6LcVMlI
         sIcfvQcVTRJDLa4J1xJ9yuakyR5AsSIeSJFXykU2kSJNTtA2FMrsZt85DUl1kYS6pXaz
         dTPgiga2wG0BJxUBsvgB7eZIDF8wW8Dd+qFijZfsy08/bFI3/LWto+WZBWy1kXbytl+G
         hMKsTokGNKof6Hdv93Q7shWFMFG7aOYdzREpAC8+/Q39tLlPDZzx9xKa4GFlulc03rKn
         piAg==
X-Forwarded-Encrypted: i=1; AJvYcCWtesemFpvMrKdVqyl8VXUuAoEQBT8zxPhyG+ECVfeRC4vwk/bzWv7OGuwjRp7QghnPjbjvoyjPGJRzww/SimtWbuhQKCFZWzwGnlvp+FmQnmac4duGBNkIY0uIq0AzK84/iu3Yd7fz
X-Gm-Message-State: AOJu0YyVEip5T147UK8RA9Ki7bTzAclBwIUjFybch08UeiostHvDfZKo
	boBgeYlu+jhOBctqAcVyIWzUF5Cab5aPtTeFKB/g9jUEObUsnFsC
X-Google-Smtp-Source: AGHT+IGFM62z1NFha0fX4zYN6GFjLfHep5ryQJDeYEhpfe8pHot69hbg5j5Fof76jV+RJ+a0vvpTdg==
X-Received: by 2002:a4a:8c2a:0:b0:5ac:bdbe:33f5 with SMTP id u39-20020a4a8c2a000000b005acbdbe33f5mr3776546ooj.3.1713260653971;
        Tue, 16 Apr 2024 02:44:13 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id m5-20020a4abc85000000b005a4b2172e48sm2443103oop.41.2024.04.16.02.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 02:44:12 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jszhang@kernel.org,
	dfustini@baylibre.com,
	yifeng.zhao@rock-chips.com,
	shawn.lin@rock-chips.com,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	tingzhu.wang@sophgo.com,
	guoren@kernel.org,
	inochiama@outlook.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH 1/1] mmc: sdhci-of-dwcmshc: add callback framework for expansion
Date: Tue, 16 Apr 2024 17:44:04 +0800
Message-Id: <c35752345c542cc34c9029902b5a39280bb36857.1713257181.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713257181.git.unicorn_wang@outlook.com>
References: <cover.1713257181.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

The current framework is not easily extended to support new SOCs.
For example, in the current code we see that the SOC-level
structure `rk35xx_priv` and related logic are distributed in
functions such as dwcmshc_probe/dwcmshc_remove/dwcmshc_suspend/......,
which is inappropriate.

The solution is to abstract some possible common operations of soc
into virtual members of `dwcmshc_priv`. Each soc implements its own
corresponding callback function and registers it in init function.
dwcmshc framework is responsible for calling these callback functions
in those dwcmshc_xxx functions.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 185 ++++++++++++++++------------
 1 file changed, 107 insertions(+), 78 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index ab4b964d4058..1ac8537361de 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -200,6 +200,10 @@ struct dwcmshc_priv {
 	void *priv; /* pointer to SoC private stuff */
 	u16 delay_line;
 	u16 flags;
+
+	void (*soc_postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
+	int (*soc_clks_enable)(struct dwcmshc_priv *dwc_priv);
+	void (*soc_clks_disable)(struct dwcmshc_priv *dwc_priv);
 };
 
 /*
@@ -758,37 +762,81 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_cv18xx_pdata = {
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
-static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
+static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
+{
+	/*
+	 * Don't support highspeed bus mode with low clk speed as we
+	 * cannot use DLL for this condition.
+	 */
+	if (host->mmc->f_max <= 52000000) {
+		dev_info(mmc_dev(host->mmc), "Disabling HS200/HS400, frequency too low (%d)\n",
+			 host->mmc->f_max);
+		host->mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400);
+		host->mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR);
+	}
+}
+
+static int dwcmshc_rk35xx_clks_enable(struct dwcmshc_priv *dwc_priv)
+{
+	struct rk35xx_priv *soc = dwc_priv->priv;
+	int ret = 0;
+
+	if (soc)
+		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS, soc->rockchip_clks);
+	return ret;
+}
+
+static void dwcmshc_rk35xx_clks_disable(struct dwcmshc_priv *dwc_priv)
+{
+	struct rk35xx_priv *rk_priv = dwc_priv->priv;
+
+	if (rk_priv)
+		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
+					   rk_priv->rockchip_clks);
+}
+
+static int dwcmshc_rk35xx_init(struct device *dev,
+			       struct sdhci_host *host,
+			       struct dwcmshc_priv *dwc_priv)
 {
 	int err;
-	struct rk35xx_priv *priv = dwc_priv->priv;
+	struct rk35xx_priv *rk_priv;
 
-	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
-	if (IS_ERR(priv->reset)) {
-		err = PTR_ERR(priv->reset);
+	rk_priv = devm_kzalloc(dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
+	if (!rk_priv)
+		return -ENOMEM;
+
+	if (of_device_is_compatible(dev->of_node, "rockchip,rk3588-dwcmshc"))
+		rk_priv->devtype = DWCMSHC_RK3588;
+	else
+		rk_priv->devtype = DWCMSHC_RK3568;
+
+	rk_priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
+	if (IS_ERR(rk_priv->reset)) {
+		err = PTR_ERR(rk_priv->reset);
 		dev_err(mmc_dev(host->mmc), "failed to get reset control %d\n", err);
 		return err;
 	}
 
-	priv->rockchip_clks[0].id = "axi";
-	priv->rockchip_clks[1].id = "block";
-	priv->rockchip_clks[2].id = "timer";
+	rk_priv->rockchip_clks[0].id = "axi";
+	rk_priv->rockchip_clks[1].id = "block";
+	rk_priv->rockchip_clks[2].id = "timer";
 	err = devm_clk_bulk_get_optional(mmc_dev(host->mmc), RK35xx_MAX_CLKS,
-					 priv->rockchip_clks);
+					 rk_priv->rockchip_clks);
 	if (err) {
 		dev_err(mmc_dev(host->mmc), "failed to get clocks %d\n", err);
 		return err;
 	}
 
-	err = clk_bulk_prepare_enable(RK35xx_MAX_CLKS, priv->rockchip_clks);
+	err = clk_bulk_prepare_enable(RK35xx_MAX_CLKS, rk_priv->rockchip_clks);
 	if (err) {
 		dev_err(mmc_dev(host->mmc), "failed to enable clocks %d\n", err);
 		return err;
 	}
 
 	if (of_property_read_u8(mmc_dev(host->mmc)->of_node, "rockchip,txclk-tapnum",
-				&priv->txclk_tapnum))
-		priv->txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
+				&rk_priv->txclk_tapnum))
+		rk_priv->txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
 
 	/* Disable cmd conflict check */
 	sdhci_writel(host, 0x0, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
@@ -796,21 +844,41 @@ static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
 	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
 	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
 
+	dwc_priv->priv = rk_priv;
+	dwc_priv->soc_postinit = dwcmshc_rk35xx_postinit;
+	dwc_priv->soc_clks_enable = dwcmshc_rk35xx_clks_enable;
+	dwc_priv->soc_clks_disable = dwcmshc_rk35xx_clks_disable;
+
 	return 0;
 }
 
-static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
+static int dwcmshc_th1520_init(struct device *dev,
+			       struct sdhci_host *host,
+			       struct dwcmshc_priv *dwc_priv)
 {
+	dwc_priv->delay_line = PHY_SDCLKDL_DC_DEFAULT;
+
+	if (device_property_read_bool(dev, "mmc-ddr-1_8v") ||
+	    device_property_read_bool(dev, "mmc-hs200-1_8v") ||
+	    device_property_read_bool(dev, "mmc-hs400-1_8v"))
+		dwc_priv->flags |= FLAG_IO_FIXED_1V8;
+	else
+		dwc_priv->flags &= ~FLAG_IO_FIXED_1V8;
+
 	/*
-	 * Don't support highspeed bus mode with low clk speed as we
-	 * cannot use DLL for this condition.
+	 * start_signal_voltage_switch() will try 3.3V first
+	 * then 1.8V. Use SDHCI_SIGNALING_180 rather than
+	 * SDHCI_SIGNALING_330 to avoid setting voltage to 3.3V
+	 * in sdhci_start_signal_voltage_switch().
 	 */
-	if (host->mmc->f_max <= 52000000) {
-		dev_info(mmc_dev(host->mmc), "Disabling HS200/HS400, frequency too low (%d)\n",
-			 host->mmc->f_max);
-		host->mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400);
-		host->mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR);
+	if (dwc_priv->flags & FLAG_IO_FIXED_1V8) {
+		host->flags &= ~SDHCI_SIGNALING_330;
+		host->flags |=  SDHCI_SIGNALING_180;
 	}
+
+	sdhci_enable_v4_mode(host);
+
+	return 0;
 }
 
 static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
@@ -859,7 +927,6 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_host *host;
 	struct dwcmshc_priv *priv;
-	struct rk35xx_priv *rk_priv = NULL;
 	const struct sdhci_pltfm_data *pltfm_data;
 	int err;
 	u32 extra;
@@ -915,46 +982,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	host->mmc_host_ops.hs400_enhanced_strobe = dwcmshc_hs400_enhanced_strobe;
 
 	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
-		rk_priv = devm_kzalloc(&pdev->dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
-		if (!rk_priv) {
-			err = -ENOMEM;
-			goto err_clk;
-		}
-
-		if (of_device_is_compatible(pdev->dev.of_node, "rockchip,rk3588-dwcmshc"))
-			rk_priv->devtype = DWCMSHC_RK3588;
-		else
-			rk_priv->devtype = DWCMSHC_RK3568;
-
-		priv->priv = rk_priv;
-
-		err = dwcmshc_rk35xx_init(host, priv);
+		err = dwcmshc_rk35xx_init(dev, host, priv);
 		if (err)
 			goto err_clk;
 	}
 
 	if (pltfm_data == &sdhci_dwcmshc_th1520_pdata) {
-		priv->delay_line = PHY_SDCLKDL_DC_DEFAULT;
-
-		if (device_property_read_bool(dev, "mmc-ddr-1_8v") ||
-		    device_property_read_bool(dev, "mmc-hs200-1_8v") ||
-		    device_property_read_bool(dev, "mmc-hs400-1_8v"))
-			priv->flags |= FLAG_IO_FIXED_1V8;
-		else
-			priv->flags &= ~FLAG_IO_FIXED_1V8;
-
-		/*
-		 * start_signal_voltage_switch() will try 3.3V first
-		 * then 1.8V. Use SDHCI_SIGNALING_180 rather than
-		 * SDHCI_SIGNALING_330 to avoid setting voltage to 3.3V
-		 * in sdhci_start_signal_voltage_switch().
-		 */
-		if (priv->flags & FLAG_IO_FIXED_1V8) {
-			host->flags &= ~SDHCI_SIGNALING_330;
-			host->flags |=  SDHCI_SIGNALING_180;
-		}
-
-		sdhci_enable_v4_mode(host);
+		err = dwcmshc_th1520_init(dev, host, priv);
+		if (err)
+			goto err_clk;
 	}
 
 #ifdef CONFIG_ACPI
@@ -972,8 +1008,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	if (err)
 		goto err_rpm;
 
-	if (rk_priv)
-		dwcmshc_rk35xx_postinit(host, priv);
+	if (priv->soc_postinit)
+		priv->soc_postinit(host, priv);
 
 	err = __sdhci_add_host(host);
 	if (err)
@@ -991,9 +1027,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
 err_clk:
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(priv->bus_clk);
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+	if (priv->soc_clks_disable)
+		priv->soc_clks_disable(priv);
 free_pltfm:
 	sdhci_pltfm_free(pdev);
 	return err;
@@ -1004,15 +1039,13 @@ static void dwcmshc_remove(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	struct rk35xx_priv *rk_priv = priv->priv;
 
 	sdhci_remove_host(host, 0);
 
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(priv->bus_clk);
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+	if (priv->soc_clks_disable)
+		priv->soc_clks_disable(priv);
 	sdhci_pltfm_free(pdev);
 }
 
@@ -1022,7 +1055,6 @@ static int dwcmshc_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	struct rk35xx_priv *rk_priv = priv->priv;
 	int ret;
 
 	pm_runtime_resume(dev);
@@ -1035,9 +1067,8 @@ static int dwcmshc_suspend(struct device *dev)
 	if (!IS_ERR(priv->bus_clk))
 		clk_disable_unprepare(priv->bus_clk);
 
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+	if (priv->soc_clks_disable)
+		priv->soc_clks_disable(priv);
 
 	return ret;
 }
@@ -1047,7 +1078,6 @@ static int dwcmshc_resume(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	struct rk35xx_priv *rk_priv = priv->priv;
 	int ret;
 
 	ret = clk_prepare_enable(pltfm_host->clk);
@@ -1060,23 +1090,22 @@ static int dwcmshc_resume(struct device *dev)
 			goto disable_clk;
 	}
 
-	if (rk_priv) {
-		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS,
-					      rk_priv->rockchip_clks);
+	if (priv->soc_clks_enable) {
+		ret = priv->soc_clks_enable(priv);
 		if (ret)
 			goto disable_bus_clk;
 	}
 
 	ret = sdhci_resume_host(host);
 	if (ret)
-		goto disable_rockchip_clks;
+		goto disable_soc_clks;
 
 	return 0;
 
-disable_rockchip_clks:
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+disable_soc_clks:
+	if (priv->soc_clks_disable)
+		priv->soc_clks_disable(priv);
+
 disable_bus_clk:
 	if (!IS_ERR(priv->bus_clk))
 		clk_disable_unprepare(priv->bus_clk);
-- 
2.25.1


