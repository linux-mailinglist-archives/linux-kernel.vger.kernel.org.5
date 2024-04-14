Return-Path: <linux-kernel+bounces-144015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A738A40D4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023672822A2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 07:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0C7225AE;
	Sun, 14 Apr 2024 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oo7aCOyP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CFB224CC;
	Sun, 14 Apr 2024 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713078938; cv=none; b=KGeYgt0HfU67JMUNwXB7xi5FUxQdxrJ+AzCnG8paGdhf3cTf467lOGZJ+ouNBKFMkiamdjKd8eADvtFYhAAJAI/NgtQsGpHf4jV0iSCMmKy7AzVGK3XAlEE4kJmuv4GTT4wIXII9XewRq0Ebq7pIqy8ygMdpBIhkOnrfUcvifRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713078938; c=relaxed/simple;
	bh=+gq8/HaBFcrh+lOjt/oiQ6thVO5EDI++3a+IpmyHbZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r1S3dXbcZ3t0Ys4yzJPOq9vg5Xagj5LMDKLzfpu5HzXaRP0h0ZkmK9S0Bo3Md9HxDydUO+zIVgFkrdJZbJKRp+vde2AT/0hpFF2M4oiNhb6rP0cQZupImyFSiKAkbwKcLHfMM6ANa+tJGEZ/7s6y9gpbQS+3NNpNNPiKBVUxpkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oo7aCOyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FFAC32781;
	Sun, 14 Apr 2024 07:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713078937;
	bh=+gq8/HaBFcrh+lOjt/oiQ6thVO5EDI++3a+IpmyHbZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Oo7aCOyP84hPcs2MyCNuBa5991sbNIcjbuSd00cBRv+CldmtU4UTYQcwFE2Pk03uz
	 ytYCWZQ9M48xB6E1aFL344MS257zH7UQX0W0fcC67Hz5RKNnQQqVReEg+JrYoNmgI+
	 5ZL4hYABdSYsfGug1tu425m+V6bHywq2zKngOUOlrtMN5UpMGfAajN4bzFEcXWsdqU
	 7VOlh3vvPSOjb7XRDWAc4WuWdJEPOlcdwe4Y3IXioSew9V+S15dJrw/F6ylf3vh/tg
	 hwsogt1Y25ag5UzXPet3X14levyaXa4t5FitjID0vXg44r++uhw5hkHhMCEeYuu6Ky
	 7S8vzNQ6I2mpQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 09:15:15 +0200
Subject: [PATCH 2/5] mmc: sdhci-omap: Constify struct sdhci_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-mmc-const-sdhci-ops-v1-2-178539d68093@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=754; i=krzk@kernel.org;
 h=from:subject:message-id; bh=+gq8/HaBFcrh+lOjt/oiQ6thVO5EDI++3a+IpmyHbZs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmG4KKQcj2jruz3h3KLLPgxt5tSjX239ra1Vpiz
 i9ul6QRxGuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhuCigAKCRDBN2bmhouD
 1xQyD/9eWA74r4OD9QYqR/pDNGT43O1bauOKvWi85I261jiYc12BO/VgRi8GEI5f9TguBIXNAH8
 7fMizm2pux7RpPGqaXrVMFWNgoNE1giSm24xnduIG2Cdky4Oz8i8MmimR5z434HMgCcbCJfp+Oi
 4uGDpUcLuVR48P6OZ9E18TyPDeR3Ppol3/e005RZAEFjvjVZifdBBr3GzQB95akkKQjKvDnE0+B
 sOEkm01UAnW46q/js2EshuiGo3qSqWT3GWtEwnNTC2mDl073YyqoKchJkgBMiPc8ovJwffS/b/M
 nCdr4e9RuW8jdh3nHEmUBIHRATDh8m02gu7zxbBgso8ygkWoSXwp2sTkK694rz7uChgfvgq8xCe
 e23v1+ybfSXgTxJfIt+eRJa6y09rErDBVu4hVgdh+jA/qUBGSOIMtfvfxnn4IM3HcL5aRZC0TG7
 ezOKUInVTBB+4c6hjspBPPcLJHdhR0FfL7+cDGh/ml+AY/3rL9NS+xYKskh0iT/B/hW2PCovYKE
 pRYYgT6WhgT/jdBdTXRcvtuwU9JP0o34jDyHDONvuh4EOZC+vgTXzLB+cr18FmItzotIM/Q+mqj
 YnTj0I3f/MLnIyWRNw0HqgsJIVlS1tWMH9kb1O/JuwC/JR84pEAkCMShSVRV8jn2ntM0NmJDXef
 gCT1n1ALqTOmB9A==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The local struct sdhci_ops can be made const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/sdhci-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 94076b095571..5841a9afeb9f 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -925,7 +925,7 @@ static void sdhci_omap_set_timeout(struct sdhci_host *host,
 	__sdhci_set_timeout(host, cmd);
 }
 
-static struct sdhci_ops sdhci_omap_ops = {
+static const struct sdhci_ops sdhci_omap_ops = {
 	.set_clock = sdhci_omap_set_clock,
 	.set_power = sdhci_omap_set_power,
 	.enable_dma = sdhci_omap_enable_dma,

-- 
2.34.1


