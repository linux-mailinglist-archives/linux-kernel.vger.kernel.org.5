Return-Path: <linux-kernel+bounces-144186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9B38A42DA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863B41C20899
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8A156471;
	Sun, 14 Apr 2024 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kct0spDp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D872524BA;
	Sun, 14 Apr 2024 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713103696; cv=none; b=bIgCCgwk0kmCrjn2h4r2dmLHFJ5NlqGmC4IF3z/IfQWYOgc0mN5DDfQEtKuxP3MSp4NzCyAVWLjaZeiwOC6gMc9mVrfRSExf0igQntl5Je1DZ8wS4/iXHFJqpjeO2vEEursMp13St8I4u4BgjUwVYp0oL0ngcDrB6i/s8ZLSOvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713103696; c=relaxed/simple;
	bh=P6C2uaZWdzkaxUS/4whafeWniP5J9sza+c4EUKItEQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NS1MSkt2uAhl6OGPsiRPKDIMATtm81xYIoC/qbyNR0gZEVQsR9BzQQPiUQimBsfncYz+1Q8g5CL1kp7kglybhM45a6FPwTA1g0SIERAe/fPYdNmR+INoVjAHjmp9UhHxbgVjLVIF9OxtAgxhP5lFFZr7rbU9d51eXVp6sgA5k2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kct0spDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA64C072AA;
	Sun, 14 Apr 2024 14:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713103695;
	bh=P6C2uaZWdzkaxUS/4whafeWniP5J9sza+c4EUKItEQ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kct0spDpdnU+Oef1efVYeGuX1xs7cslj0SveDcqa/6NQjCikhXkAI5Vpg/Wf5NvFR
	 E3IY6hlSiEcE88JrPAH1K81YnpFWBYcuxb80gK1oymF8ME3pqnUX88g8DcRDmEaTX+
	 wQ+Fx3q8jIBmFhM5/bUE/UYSnkWBWcraOTaezFBHZ1kfHddWa3M9mKHw16QQhmQ+jl
	 Wl0o5XcYxt7W06fqiBp/GoKzyk/YvMIjIl3cRlvVCtbob2edABcDlO7qWZglqhRTP8
	 SWcn/juxtG3VcXJRvbZcByeliZX+NR0knteaKUL1jd7YE69HV7Bgj2dMEfYlO5uBm9
	 H+jpOmx3BdZ+w==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 16:07:35 +0200
Subject: [PATCH v2 5/5] mmc: sdhci-s3c: Choose sdhci_ops based on variant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-mmc-const-sdhci-ops-v2-5-262f81faadac@kernel.org>
References: <20240414-mmc-const-sdhci-ops-v2-0-262f81faadac@kernel.org>
In-Reply-To: <20240414-mmc-const-sdhci-ops-v2-0-262f81faadac@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Ben Dooks <ben-linux@fluff.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3968; i=krzk@kernel.org;
 h=from:subject:message-id; bh=P6C2uaZWdzkaxUS/4whafeWniP5J9sza+c4EUKItEQ4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmG+M3tp0WY1HbY6u/BNP3jUZnARS+VLivgrLfQ
 xZoFJE26eaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhvjNwAKCRDBN2bmhouD
 1+K3D/9tSh2DQGQf+DmCy04xDvumNPYmDIpDPVyW4wfJgw7T9zk5EIXLCiUwH9ANA2lbc/6lyOr
 V935AQHhWr/vTg0YcxydmTIlMPvFbDPKVfDor5P5RBGgqfFVJkUkAUYzISrEs/XtJ4aWIQPltnq
 8NhPi4xuuQhBds5/EPgJhmi3gms0Rn/eGLNDYveal+Khc+AEStzrRT+/GUhe/WqFhkVa6IwfUE5
 lUVPOb0a137J9ZkwdVj73AklRdpqoLd2HvpPq9WOhH/GPxdcdy8mjI8v9i6UtMuokzJiodl0q9I
 0/uj+V7prdUhUirtynRhczYanYjkJpAjSpOPp0wXJ/xach5T9CvVtu8xFgdETC+R119di1ErMCR
 +6rgliO5WZIfSsJhs91HSsXAHX5CXx4JhGbKkschwKTse5RR1/t9d9dDfXNyWAgcijxGhL3GS4P
 ORDf4QUXEM40foi5F5L8YU2YXIQnUPmHDMXdlAeP/I03kbc2OXS0om+wC06SgkU70I9Fi3IXSKg
 QpOcYzaJ/29d4wTavSK9NoYGm7Yg5dDHpezgZa32mgqOeqONaKCxcYben8zrrGL68aw7Ez7jGq2
 UkYlJLcWz9wIMlvfD94A+D/X/r8E1m/i+DV6sw4JbzEXrJnT8fgo3vAfMYf2ytEuPSwXwDQIBr/
 FOP/AfYmPt+mF4Q==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The difference between old S3C64xx and newer Exynos4 SDHCI controller
variants is in clock handling (the "no_divider" field in drvdata).
Choose the proper sdhci_ops based on the variant instead of patching
ops in probe, if Exynos4 is used.

This allows making struct sdhci_ops const for code safety and probably
opens further options in the future, as the dynamic pointer ops table is
not anymore that dynamic.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/sdhci-s3c.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 6493b0edba34..a71d56c7031f 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -130,14 +130,16 @@ struct sdhci_s3c {
  * struct sdhci_s3c_drv_data - S3C SDHCI platform specific driver data
  * @sdhci_quirks: sdhci host specific quirks.
  * @no_divider: no or non-standard internal clock divider.
+ * @ops: sdhci_ops to use for this variant
  *
  * Specifies platform specific configuration of sdhci controller.
  * Note: A structure for driver specific platform data is used for future
  * expansion of its usage.
  */
 struct sdhci_s3c_drv_data {
-	unsigned int	sdhci_quirks;
-	bool		no_divider;
+	unsigned int		sdhci_quirks;
+	bool			no_divider;
+	const struct sdhci_ops	*ops;
 };
 
 static inline struct sdhci_s3c *to_s3c(struct sdhci_host *host)
@@ -412,7 +414,7 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 }
 
-static struct sdhci_ops sdhci_s3c_ops = {
+static const struct sdhci_ops sdhci_s3c_ops_s3c6410 = {
 	.get_max_clock		= sdhci_s3c_get_max_clk,
 	.set_clock		= sdhci_s3c_set_clock,
 	.get_min_clock		= sdhci_s3c_get_min_clock,
@@ -421,6 +423,15 @@ static struct sdhci_ops sdhci_s3c_ops = {
 	.set_uhs_signaling	= sdhci_set_uhs_signaling,
 };
 
+static const struct sdhci_ops sdhci_s3c_ops_exynos4 __maybe_unused = {
+	.get_max_clock		= sdhci_cmu_get_max_clock,
+	.set_clock		= sdhci_cmu_set_clock,
+	.get_min_clock		= sdhci_cmu_get_min_clock,
+	.set_bus_width		= sdhci_set_bus_width,
+	.reset			= sdhci_reset,
+	.set_uhs_signaling	= sdhci_set_uhs_signaling,
+};
+
 #ifdef CONFIG_OF
 static int sdhci_s3c_parse_dt(struct device *dev,
 		struct sdhci_host *host, struct s3c_sdhci_platdata *pdata)
@@ -560,7 +571,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 		pdata->cfg_gpio(pdev, pdata->max_width);
 
 	host->hw_name = "samsung-hsmmc";
-	host->ops = &sdhci_s3c_ops;
+	host->ops = &sdhci_s3c_ops_s3c6410;
 	host->quirks = 0;
 	host->quirks2 = 0;
 	host->irq = irq;
@@ -570,6 +581,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
 	if (drv_data) {
 		host->quirks |= drv_data->sdhci_quirks;
+		host->ops = drv_data->ops;
 		sc->no_divider = drv_data->no_divider;
 	}
 
@@ -617,16 +629,6 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	/* HSMMC on Samsung SoCs uses SDCLK as timeout clock */
 	host->quirks |= SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK;
 
-	/*
-	 * If controller does not have internal clock divider,
-	 * we can use overriding functions instead of default.
-	 */
-	if (sc->no_divider) {
-		sdhci_s3c_ops.set_clock = sdhci_cmu_set_clock;
-		sdhci_s3c_ops.get_min_clock = sdhci_cmu_get_min_clock;
-		sdhci_s3c_ops.get_max_clock = sdhci_cmu_get_max_clock;
-	}
-
 	/* It supports additional host capabilities if needed */
 	if (pdata->host_caps)
 		host->mmc->caps |= pdata->host_caps;
@@ -758,6 +760,7 @@ MODULE_DEVICE_TABLE(platform, sdhci_s3c_driver_ids);
 #ifdef CONFIG_OF
 static const struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
 	.no_divider = true,
+	.ops = &sdhci_s3c_ops_exynos4,
 };
 
 static const struct of_device_id sdhci_s3c_dt_match[] = {

-- 
2.34.1


