Return-Path: <linux-kernel+bounces-74714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E51F85D829
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82F51F22A03
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C450469D36;
	Wed, 21 Feb 2024 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrHNRFpE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C0055E5E;
	Wed, 21 Feb 2024 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519547; cv=none; b=SmLpuRhxjt0+/R0GcmmH9w5+4zH9cYLNKgMVTXEty6vKEynVOR8VQ32rPITack763M0GQg1ASec2F9+e+YJ59JWK/BjyfvqIVpWvvTP6woGitnW7xB+fp5YRe426+dG2EF1JpFMidXR394YrlE4uwTUO1K6u73bAtybvZSHZDLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519547; c=relaxed/simple;
	bh=heYg83dxzIz5cujo+bOCWW+22F7pnM8vLF2xYH8yigk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j7nvO8MFNbKNpyOf9wDQ5VKwRcOYT268yt2243AMCj7+BQJzPHZcLXRysUc4kxEfWrROawNgrKaQ/ErNcXdpi/UOi8Jld0M7/waO2m4lECb3H/rkWtNYkmEbE7+TP+HhwCpDETpvYlK13fOO6uyOdxO3tTxibqYxuspTqy+ZaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrHNRFpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B128C43390;
	Wed, 21 Feb 2024 12:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708519546;
	bh=heYg83dxzIz5cujo+bOCWW+22F7pnM8vLF2xYH8yigk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FrHNRFpErUixwSTv1op26ZQBpnMLFQ3fP3nig0ibjLRpIEDogQnSN7hECIozbXSWZ
	 T5aZQpJ/Culk89pTNwqKjZALPhX0liwcbzhEnGnTWSWNOrcqP5jDoZrdPuBIEuMUG7
	 TQT/Bz/X4HLAze5iqNUxyvS/tFv8GWKtoYgkNNBwtClkHtkfQyO1HW9zana5iovB6P
	 eXbhktZ2cpnXtbnym2bCcwZsSJ/xzxMhodohOZfjUWcsFwsWd9UY/5W30eQPwXn+GN
	 f5nTTL8QPsQxd1bL3sEQRFG1MDwVgn2y8tpvrhNxOm+u7OC39zgcmByRhRReN8/nRt
	 yXF6GiW8cEsYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC5CC54787;
	Wed, 21 Feb 2024 12:45:46 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Wed, 21 Feb 2024 20:45:03 +0800
Subject: [PATCH v6 1/5] mmc: host: mmc_of_parse_clk_phase(): Pass struct
 device * instead of mmc_host *
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-b4-mmc-hi3798mv200-v6-1-bc41bf6a9769@outlook.com>
References: <20240221-b4-mmc-hi3798mv200-v6-0-bc41bf6a9769@outlook.com>
In-Reply-To: <20240221-b4-mmc-hi3798mv200-v6-0-bc41bf6a9769@outlook.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 Yang Xiwen <forbidden405@outlook.com>, Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708519512; l=2509;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=JGOc4wQUSQd78IPQsA2tfrngj58AF1LgtdpM/cwsBoQ=;
 b=c4GmQZZ3Slqtar2uJ1DMwVC7+FRQXQaD2Zw5JwLUYyAjLFGVbDWeNinqCrhzsB2uMK801vC0j
 /Q6fsXVsB2xCmGcV+GUV/rrg5GBFyPVGfx2E2Ym9eNMkdJ44u9iAVkX
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Parsing dt usually happens very early, sometimes even before struct
mmc_host is allocated (e.g. dw_mci_probe() and dw_mci_parse_dt() in
dw_mmc.c). Looking at the source of mmc_of_parse_clk_phase(), it's
actually not mandatory to have an initialized mmc_host first, instead we
can pass struct device * to it directly.

Also fix the only current user (sdhci-of-aspeed.c).

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/mmc/core/host.c            | 4 +---
 drivers/mmc/host/sdhci-of-aspeed.c | 2 +-
 include/linux/mmc/host.h           | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index cf396e8f34e9..8b2844ac5dc5 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -234,10 +234,8 @@ static void mmc_of_parse_timing_phase(struct device *dev, const char *prop,
 }
 
 void
-mmc_of_parse_clk_phase(struct mmc_host *host, struct mmc_clk_phase_map *map)
+mmc_of_parse_clk_phase(struct device *dev, struct mmc_clk_phase_map *map)
 {
-	struct device *dev = host->parent;
-
 	mmc_of_parse_timing_phase(dev, "clk-phase-legacy",
 				  &map->phase[MMC_TIMING_LEGACY]);
 	mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs",
diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 42d54532cabe..430c1f90037b 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -435,7 +435,7 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 		goto err_sdhci_add;
 
 	if (dev->phase_desc)
-		mmc_of_parse_clk_phase(host->mmc, &dev->phase_map);
+		mmc_of_parse_clk_phase(&pdev->dev, &dev->phase_map);
 
 	ret = sdhci_add_host(host);
 	if (ret)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 2f445c651742..5894bf912f7b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -539,7 +539,7 @@ struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra);
 int mmc_add_host(struct mmc_host *);
 void mmc_remove_host(struct mmc_host *);
 void mmc_free_host(struct mmc_host *);
-void mmc_of_parse_clk_phase(struct mmc_host *host,
+void mmc_of_parse_clk_phase(struct device *dev,
 			    struct mmc_clk_phase_map *map);
 int mmc_of_parse(struct mmc_host *host);
 int mmc_of_parse_voltage(struct mmc_host *host, u32 *mask);

-- 
2.43.0


