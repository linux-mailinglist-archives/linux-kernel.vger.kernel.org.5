Return-Path: <linux-kernel+bounces-144018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6037B8A40DA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5C01C20CC5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 07:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B727B2E859;
	Sun, 14 Apr 2024 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgBfhiVg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E515F2E631;
	Sun, 14 Apr 2024 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713078948; cv=none; b=jt83FRdOF+BOtPwe3klp02KvZsREEQlu0vhe/zyltsXKnB/sedirEkTIOs0BVWEThXPa7kZu1v+IZIXmb2tcmHKKaNkn5rXin0fygW2xCQUHuTuRV7wPwWqWaqCKyJ2WIW0xE42zcYIM1SFmOhhNebP9Wkq12WwcqKTAPwGZ5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713078948; c=relaxed/simple;
	bh=8d/9E0pz4G5hy6Wtr2AcynVmnL8LOYC286o2KeCuhKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YeMfKDIZuHx56ZGtFGXoH5XXHIfRfU67140rn0DlmbErlQNluEmVB0m4cX9+8v62ABUySzkmBM0NWQGTBluJCmL6/kXPC4zGQPwMtqRizBfTXcTs0Wpqm2xWR/haFxKrSLYL9j4OZNWj6H3daisURFdGI8GLrZO4D6WjKp0UaPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgBfhiVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82739C32783;
	Sun, 14 Apr 2024 07:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713078947;
	bh=8d/9E0pz4G5hy6Wtr2AcynVmnL8LOYC286o2KeCuhKY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fgBfhiVgYW8n3JEijNDA2fJGkn2ISoHMYTRrXFk7wnJBgG17uvTPJYmy96yK4zxFk
	 jV3VDGtlbsU2jtekrdZMtbnHKyFob7JcZ4fYcAt+N4+l1NVmPGdjVdFJQPayiugrKI
	 ulAy7OdbsBMJORs95/8pU+zg+gHqhBUWX1ulIYikWRlnVCF+hkwC6nWulyB7FZF6YI
	 m9KeMr6mN6925yt7HVepjj4X9cMvJAxvQ8dEtKYxbOFeOSFp2Oyn/Weah/vOIBZc/D
	 U3rB3cuGGM5ckwPSoQP2FEZ22IgqMF2XFvaUjt7U+F7I/QKXRULXVIkJvJvzgCbssv
	 f9PdgtXYzv4Cw==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 09:15:18 +0200
Subject: [PATCH 5/5] mmc: sdhci-s3c: Choose sdhci_ops based on variant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-mmc-const-sdhci-ops-v1-5-178539d68093@kernel.org>
References: <20240414-mmc-const-sdhci-ops-v1-0-178539d68093@kernel.org>
In-Reply-To: <20240414-mmc-const-sdhci-ops-v1-0-178539d68093@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3953; i=krzk@kernel.org;
 h=from:subject:message-id; bh=8d/9E0pz4G5hy6Wtr2AcynVmnL8LOYC286o2KeCuhKY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmG4KNEGtWvruYUf6SGR3nHCDUWZtm4j412LE5/
 F82twc6hv6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhuCjQAKCRDBN2bmhouD
 15rBEACGeEZsNqJuS09TnNJYJhcEqxUZYiX4Wr/cSuVS+EYl/fcHj1UgFB0XzsHq7WiiWX9yafm
 CcMHEeNArIde/TftaknbmfZnxYfgczu+108mHMD184WNvBEjBZ3a4WnrodXSintAcffjElTMeTH
 usMLT8tjC1xwCW90LoKnYeEPAlteDRImMlr+yVDeLWdpjT/BIld34gyT7HXcGM7MpZFw3i/Bs2p
 Zoe1EjXUwGrv0adBiv2BVzRe3c4xV4dFA8MsMXa+vvsU1u5XUpSeOAlcNoQ++Yb6NLOneh0W7Y7
 ZREbTKaWsGADx9W8rjlTKUE7N47V0je810fGMsGz8AA9ix3hK2Of2zq9q2Fwji1jnMvzKVHXAtY
 Vmj7d7g4tLMYzGyO4RfwvDFu/5s4lBBkMJkVG7640C63wQWdZW7B8ZCNSxhpMFre3XLIqpHCEXF
 0N1derA/ocC08dG5/VyYLwrlVFO4YPZGS+aKLEOwL4jFvJ/cwJtCgxMCKaLL3mRigSBt07RRY2q
 p0kSnN3vC8c5St6zjlrIpvE0MWHJx0vQ5Ds9pX0BtDwmPOataWBlS/h+am9KLGaAO9rmTLgVNoj
 ua4SL6RS4UGAn22x3vgceQQe49c85ySrpSZ68aKLEesj2DabNcov8b8FuUYTiGbfRiIcjO6A9TY
 Sp2q/NAGXxe2aTw==
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
index 6493b0edba34..6c2a42c1819a 100644
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
 
+static const struct sdhci_ops sdhci_s3c_ops_exynos4 = {
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


