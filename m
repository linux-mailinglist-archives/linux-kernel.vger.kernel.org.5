Return-Path: <linux-kernel+bounces-69916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB47859032
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21CF282B78
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F17B7CF3C;
	Sat, 17 Feb 2024 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJT39okk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38457CF1D;
	Sat, 17 Feb 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708181705; cv=none; b=G9ldsHhD/PGDiz6SNCYEigVnR2ONnxtNjvj1zfm6CCrtQx/L1zBfRfKh2uHrdF7fP5JW0SK7J/ibhvUlaPQwMUe6pJ5ulqqEIjU631L5Lp8F+gsMREdHzInWmDqjy3brCl9N+Y6EK6iBJxUIg9CkDPWazqQEJj/eepffMgqE3Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708181705; c=relaxed/simple;
	bh=ys4TWpRFySfLoe5m+6WVvOTSYfT8WMPoyAdTVT2ja0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkirlzgBNj92mgH7jAIZog88TsUTeiWpeAwGOSCtX+vZGF9RSMVS6ZQIsNUpH+33AjDo8B1cc9CFWzprI6tYUkpfuGB0uDE93w4J8CagaW1UgGjvaBBy1B7573z1ZbQ6vWJ560PWx4Upv3mZQh60CAyGzgJVVG/Ft7A+9E507bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJT39okk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97691C43390;
	Sat, 17 Feb 2024 14:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708181705;
	bh=ys4TWpRFySfLoe5m+6WVvOTSYfT8WMPoyAdTVT2ja0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJT39okkBvRkB1/rfvHLipvVVJ0i1wilmBrRd93A11ax8hXVitJc+PYS7CRKvMvt1
	 c/77ZMqL6wZjxQvyPQ3WiRt7y3R6MFkguN3SxokHm4ERsj+1GYOgxtw5jB2zLyWvGE
	 8n5uwkVlM/ubCBZcsIarjoEGsUj9qxxINnz1XIRuOxEt4SkXr6Kv01CbzLcqByc242
	 IvspNiJL+QoWyWjxEzQKDLhWAJXW5edfp40Qw66cGc2mVjRynYg2trkzyYtUIUPt+X
	 TMsOFESG+D+IJAfA1CMUfbPxaGXhSthdasfx3yLSCLsvRm72e0Fhw2dv6yeaK0SyPO
	 EntMh0Cl77qUA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 2/2] mmc: sdhci-of-dwcmshc: Add support for Sophgo CV1800B and SG2002
Date: Sat, 17 Feb 2024 22:42:02 +0800
Message-ID: <20240217144202.3808-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217144202.3808-1-jszhang@kernel.org>
References: <20240217144202.3808-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the mmc controller in the Sophgo CV1800B and SG2002
with corresponding new compatible strings. Implement custom sdhci_ops.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 66 +++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index a1f57af6acfb..ab4b964d4058 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -52,6 +52,20 @@
 #define AT_CTRL_SWIN_TH_VAL_MASK	GENMASK(31, 24) /* bits [31:24] */
 #define AT_CTRL_SWIN_TH_VAL		0x9  /* sampling window threshold */
 
+/* Sophgo CV18XX specific Registers */
+#define CV18XX_SDHCI_MSHC_CTRL			0x00
+#define  CV18XX_EMMC_FUNC_EN			BIT(0)
+#define  CV18XX_LATANCY_1T			BIT(1)
+#define CV18XX_SDHCI_PHY_TX_RX_DLY		0x40
+#define  CV18XX_PHY_TX_DLY_MSK			GENMASK(6, 0)
+#define  CV18XX_PHY_TX_SRC_MSK			GENMASK(9, 8)
+#define  CV18XX_PHY_TX_SRC_INVERT_CLK_TX	0x1
+#define  CV18XX_PHY_RX_DLY_MSK			GENMASK(22, 16)
+#define  CV18XX_PHY_RX_SRC_MSK			GENMASK(25, 24)
+#define  CV18XX_PHY_RX_SRC_INVERT_RX_CLK	0x1
+#define CV18XX_SDHCI_PHY_CONFIG			0x4c
+#define  CV18XX_PHY_TX_BPS			BIT(0)
+
 /* Rockchip specific Registers */
 #define DWCMSHC_EMMC_DLL_CTRL		0x800
 #define DWCMSHC_EMMC_DLL_RXCLK		0x804
@@ -642,6 +656,35 @@ static void th1520_sdhci_reset(struct sdhci_host *host, u8 mask)
 	}
 }
 
+static void cv18xx_sdhci_reset(struct sdhci_host *host, u8 mask)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u32 val, emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
+
+	sdhci_reset(host, mask);
+
+	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
+		val = sdhci_readl(host, priv->vendor_specific_area1 + CV18XX_SDHCI_MSHC_CTRL);
+		val |= CV18XX_EMMC_FUNC_EN;
+		sdhci_writel(host, val, priv->vendor_specific_area1 + CV18XX_SDHCI_MSHC_CTRL);
+	}
+
+	val = sdhci_readl(host, priv->vendor_specific_area1 + CV18XX_SDHCI_MSHC_CTRL);
+	val |= CV18XX_LATANCY_1T;
+	sdhci_writel(host, val, priv->vendor_specific_area1 + CV18XX_SDHCI_MSHC_CTRL);
+
+	val = sdhci_readl(host, priv->vendor_specific_area1 + CV18XX_SDHCI_PHY_CONFIG);
+	val |= CV18XX_PHY_TX_BPS;
+	sdhci_writel(host, val, priv->vendor_specific_area1 + CV18XX_SDHCI_PHY_CONFIG);
+
+	val =  (FIELD_PREP(CV18XX_PHY_TX_DLY_MSK, 0) |
+		FIELD_PREP(CV18XX_PHY_TX_SRC_MSK, CV18XX_PHY_TX_SRC_INVERT_CLK_TX) |
+		FIELD_PREP(CV18XX_PHY_RX_DLY_MSK, 0) |
+		FIELD_PREP(CV18XX_PHY_RX_SRC_MSK, CV18XX_PHY_RX_SRC_INVERT_RX_CLK));
+	sdhci_writel(host, val, priv->vendor_specific_area1 + CV18XX_SDHCI_PHY_TX_RX_DLY);
+}
+
 static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.set_clock		= sdhci_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
@@ -671,6 +714,15 @@ static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
 	.platform_execute_tuning = &th1520_execute_tuning,
 };
 
+static const struct sdhci_ops sdhci_dwcmshc_cv18xx_ops = {
+	.set_clock		= sdhci_set_clock,
+	.set_bus_width		= sdhci_set_bus_width,
+	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
+	.get_max_clock		= dwcmshc_get_max_clock,
+	.reset			= cv18xx_sdhci_reset,
+	.adma_write_desc	= dwcmshc_adma_write_desc,
+};
+
 static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
 	.ops = &sdhci_dwcmshc_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
@@ -700,6 +752,12 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_th1520_pdata = {
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
+static const struct sdhci_pltfm_data sdhci_dwcmshc_cv18xx_pdata = {
+	.ops = &sdhci_dwcmshc_cv18xx_ops,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+};
+
 static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
 {
 	int err;
@@ -768,6 +826,14 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
 		.compatible = "snps,dwcmshc-sdhci",
 		.data = &sdhci_dwcmshc_pdata,
 	},
+	{
+		.compatible = "sophgo,cv1800b-dwcmshc",
+		.data = &sdhci_dwcmshc_cv18xx_pdata,
+	},
+	{
+		.compatible = "sophgo,sg2002-dwcmshc",
+		.data = &sdhci_dwcmshc_cv18xx_pdata,
+	},
 	{
 		.compatible = "thead,th1520-dwcmshc",
 		.data = &sdhci_dwcmshc_th1520_pdata,
-- 
2.43.0


