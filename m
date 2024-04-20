Return-Path: <linux-kernel+bounces-152089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FC48AB8AF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D81E1F2150A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155266FB0;
	Sat, 20 Apr 2024 02:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsVti900"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECE5A48;
	Sat, 20 Apr 2024 02:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713580092; cv=none; b=Yg+JOBtY5VVvSSd/koNSjmcktJtSas7xkA3d367XoT3mE6kTfWTnfD4m4UH9PuzVrIguFV9lucW3dmottrcS5gHfpN2WpfAG0aDeelBt3seABS82cYYw6SygRjfbvea37GrCni4h7eLe2Laf4679nA31VBSCbdhsGsq30XkejJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713580092; c=relaxed/simple;
	bh=atRv+zO/mRRsiO7tIIVfGQHQTa/K+esm4/iPRWLJy/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qld6bPRP1NuIeP8EINaqt2bLy4PBXnF0uQmXO9wxljBYLZnnIvbMM2TQx7kSS07dbRlex/jGv3LZlHpwQTM2eqXWbfsePYIuPIBhokXWSbgK/mnrjAE1rXy0WPcPEQXxcQO6BcIG1q/H7lfac/x9hvuX2KyrKtNbSnz8L2vysqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsVti900; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC479C072AA;
	Sat, 20 Apr 2024 02:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713580091;
	bh=atRv+zO/mRRsiO7tIIVfGQHQTa/K+esm4/iPRWLJy/w=;
	h=From:To:Cc:Subject:Date:From;
	b=rsVti900ZclvH0L02kj+OMVKhDTtPkXgCQ02JSPaOPheBectKrUbaRJwBcesHuYXS
	 neDVeHhBV7zZcVL9om6r+D9+F5w8zqBfbs2FRUtODnXIcHf9oOO8/BPYlPPMSYJ0HB
	 ZJl+hS7raFOrwuYi/j7UAvY70Nh5d1nxpVdKK8hSC3vHPRWr2rU1rO68P69Uj1NSq2
	 /sgA4tF6g85KDp4RVOyWCSg30JL3Q/wL8O2HugcK792zoUg/fNtzcxpWY4evXF4jZf
	 c8qKtFFk5ZvIwLaONuiFpUyOiEEcHo5+rUQ2R53pER13iiCpvwEbQlzez3h8Ur6OaV
	 MUA7o5OVhI5wA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci-of-dwcmshc: Add tuning support for Sophgo CV1800B and SG200X
Date: Sat, 20 Apr 2024 10:14:29 +0800
Message-ID: <20240420021429.454-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the .platform_execute_tuning for Sophgo CV1800B and SG200X.
Some code is borrowed from sdhci-esdhc-imx.c. The tuning result is
similar as the one of SoC vendor's SDK.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Since v1:
 - use usleep_range() instead of mdelay() as suggested by Adrian

 drivers/mmc/host/sdhci-of-dwcmshc.c | 112 ++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index ab4b964d4058..7b55acd9830c 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -66,6 +66,10 @@
 #define CV18XX_SDHCI_PHY_CONFIG			0x4c
 #define  CV18XX_PHY_TX_BPS			BIT(0)
 
+#define CV18XX_TUNE_MAX				128
+#define CV18XX_TUNE_STEP			1
+#define CV18XX_RETRY_TUNING_MAX			50
+
 /* Rockchip specific Registers */
 #define DWCMSHC_EMMC_DLL_CTRL		0x800
 #define DWCMSHC_EMMC_DLL_RXCLK		0x804
@@ -685,6 +689,113 @@ static void cv18xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 	sdhci_writel(host, val, priv->vendor_specific_area1 + CV18XX_SDHCI_PHY_TX_RX_DLY);
 }
 
+static void cv18xx_sdhci_set_tap(struct sdhci_host *host, int tap)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u16 clk;
+	u32 val;
+
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	val = sdhci_readl(host, priv->vendor_specific_area1 + CV18XX_SDHCI_MSHC_CTRL);
+	val &= ~CV18XX_LATANCY_1T;
+	sdhci_writel(host, val, priv->vendor_specific_area1 + CV18XX_SDHCI_MSHC_CTRL);
+
+	val =  (FIELD_PREP(CV18XX_PHY_TX_DLY_MSK, 0) |
+		FIELD_PREP(CV18XX_PHY_TX_SRC_MSK, CV18XX_PHY_TX_SRC_INVERT_CLK_TX) |
+		FIELD_PREP(CV18XX_PHY_RX_DLY_MSK, tap));
+	sdhci_writel(host, val, priv->vendor_specific_area1 + CV18XX_SDHCI_PHY_TX_RX_DLY);
+
+	sdhci_writel(host, 0, priv->vendor_specific_area1 + CV18XX_SDHCI_PHY_CONFIG);
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+	usleep_range(1000, 2000);
+}
+
+static int cv18xx_retry_tuning(struct mmc_host *mmc, u32 opcode, int *cmd_error)
+{
+	int ret, retry = 0;
+
+	while (retry < CV18XX_RETRY_TUNING_MAX) {
+		ret = mmc_send_tuning(mmc, opcode, NULL);
+		if (ret)
+			return ret;
+		retry++;
+	}
+
+	return 0;
+}
+
+static void cv18xx_sdhci_post_tuning(struct sdhci_host *host)
+{
+	u32 val;
+
+	val = sdhci_readl(host, SDHCI_INT_STATUS);
+	val |= SDHCI_INT_DATA_AVAIL;
+	sdhci_writel(host, val, SDHCI_INT_STATUS);
+
+	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+}
+
+static int cv18xx_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
+{
+	int min, max, avg, ret;
+	int win_length, target_min, target_max, target_win_length;
+
+	min = max = 0;
+	target_win_length = 0;
+
+	sdhci_reset_tuning(host);
+
+	while (max < CV18XX_TUNE_MAX) {
+		/* find the mininum delay first which can pass tuning */
+		while (min < CV18XX_TUNE_MAX) {
+			cv18xx_sdhci_set_tap(host, min);
+			if (!cv18xx_retry_tuning(host->mmc, opcode, NULL))
+				break;
+			min += CV18XX_TUNE_STEP;
+		}
+
+		/* find the maxinum delay which can not pass tuning */
+		max = min + CV18XX_TUNE_STEP;
+		while (max < CV18XX_TUNE_MAX) {
+			cv18xx_sdhci_set_tap(host, max);
+			if (cv18xx_retry_tuning(host->mmc, opcode, NULL)) {
+				max -= CV18XX_TUNE_STEP;
+				break;
+			}
+			max += CV18XX_TUNE_STEP;
+		}
+
+		win_length = max - min + 1;
+		/* get the largest pass window */
+		if (win_length > target_win_length) {
+			target_win_length = win_length;
+			target_min = min;
+			target_max = max;
+		}
+
+		/* continue to find the next pass window */
+		min = max + CV18XX_TUNE_STEP;
+	}
+
+	cv18xx_sdhci_post_tuning(host);
+
+	/* use average delay to get the best timing */
+	avg = (target_min + target_max) / 2;
+	cv18xx_sdhci_set_tap(host, avg);
+	ret = mmc_send_tuning(host->mmc, opcode, NULL);
+
+	dev_dbg(mmc_dev(host->mmc), "tuning %s at 0x%x ret %d\n",
+		ret ? "failed" : "passed", avg, ret);
+
+	return ret;
+}
+
 static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.set_clock		= sdhci_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
@@ -721,6 +832,7 @@ static const struct sdhci_ops sdhci_dwcmshc_cv18xx_ops = {
 	.get_max_clock		= dwcmshc_get_max_clock,
 	.reset			= cv18xx_sdhci_reset,
 	.adma_write_desc	= dwcmshc_adma_write_desc,
+	.platform_execute_tuning = cv18xx_sdhci_execute_tuning,
 };
 
 static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
-- 
2.43.0


