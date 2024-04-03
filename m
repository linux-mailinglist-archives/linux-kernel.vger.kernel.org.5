Return-Path: <linux-kernel+bounces-129312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5588E89686B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05AD01F217C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD0E71B3C;
	Wed,  3 Apr 2024 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOePu4Gv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E685D8EB;
	Wed,  3 Apr 2024 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131982; cv=none; b=Jop4eVgEw8TwDolDOPlr179vUVKk7+KrcNJ/wM4Lbmuy9aOAEEVyy6M5mYi9j/NJBMOnRhOlPXoDQ9n+qNwj2DX8b6qGxhxBwRvFVYPFD0c6f7jMIcachO9uivBxxU2CCUfXGbwxDWUEGFCiekoQd1ygw1Ek7tITOFhe6iTwy2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131982; c=relaxed/simple;
	bh=s7PKCgenwuMtIpkuH0lS5FpL9JoQE1cUgYCVfEquDcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H9oN3D0/ArWPixfTUvLksd4Ld8a2mG3/PKW04CfYx5i3oKEUnKk5nXhueURAEhyKCnpyxbS3uqaaIi4LDAlkE8MAhuFnctRB+6qi/wcD1/oViN2c43VqFHbC+F9qSykIgYZKS0pGAC4VlecWGDhgcWL/ISm6tTgDIrb5MmF3HYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOePu4Gv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7A0C433F1;
	Wed,  3 Apr 2024 08:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131981;
	bh=s7PKCgenwuMtIpkuH0lS5FpL9JoQE1cUgYCVfEquDcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rOePu4Gvd7V3cltnm48rPPfQ5ofmjX+GDSCSetysHutysgHNuJEoCnupPctS10Bsx
	 hqL8FluMuszm1Ww6kb2h9ndFt365zDSvm6q8QOk8LfTZwHcp0TTPbaVrlYNfKzSw44
	 1HmQwSAT6JhsiowgaDGcCaCcN9Lqe74+k6UwvwN2vvCBl2r4ITMuQq5eC9xknbHo18
	 Hyl3qSWl0EnJ36XlcsH7dgjLTWiKdg3Onx0lbmBzqIb4hEtGcFA/lYHz0hbWMK4PJq
	 bzXtcLMqXrxY3tCTLsDSVBCkO0fbJbEv3ftmza4uIhbkbREWWxom0wMjjHtPFDcx4I
	 DTrsllQrFjW/A==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Li Zetao <lizetao1@huawei.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Rob Herring <robh@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis de Arquer <luis.dearquer@inertim.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Jaewon Kim <jaewon02.kim@samsung.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 31/34] spi: remove incorrect of_match_ptr annotations
Date: Wed,  3 Apr 2024 10:06:49 +0200
Message-Id: <20240403080702.3509288-32-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When building with CONFIG_OF  disabled but W=1 extra warnings enabled,
a couple of driver cause a warning about an unused ID table:

drivers/spi/spi-armada-3700.c:806:34: error: unused variable 'a3700_spi_dt_ids' [-Werror,-Wunused-const-variable]
drivers/spi/spi-orion.c:614:34: error: unused variable 'orion_spi_of_match_table' [-Werror,-Wunused-const-variable]
drivers/spi/spi-pic32-sqi.c:673:34: error: unused variable 'pic32_sqi_of_ids' [-Werror,-Wunused-const-variable]
drivers/spi/spi-pic32.c:850:34: error: unused variable 'pic32_spi_of_match' [-Werror,-Wunused-const-variable]
drivers/spi/spi-rockchip.c:1020:34: error: unused variable 'rockchip_spi_dt_match' [-Werror,-Wunused-const-variable]
drivers/spi/spi-s3c64xx.c:1642:34: error: unused variable 's3c64xx_spi_dt_match' [-Werror,-Wunused-const-variable]
drivers/spi/spi-st-ssc4.c:439:34: error: unused variable 'stm_spi_match' [-Werror,-Wunused-const-variable]

These appear to all be copied from the same original driver, so fix them at the
same time by removing the unnecessary of_match_ptr() annotation. As far as I
can tell, all these drivers are only actually used on configurations that
have CONFIG_OF enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/spi-armada-3700.c | 2 +-
 drivers/spi/spi-img-spfi.c    | 2 +-
 drivers/spi/spi-meson-spicc.c | 2 +-
 drivers/spi/spi-meson-spifc.c | 2 +-
 drivers/spi/spi-orion.c       | 2 +-
 drivers/spi/spi-pic32-sqi.c   | 2 +-
 drivers/spi/spi-pic32.c       | 2 +-
 drivers/spi/spi-rockchip.c    | 2 +-
 drivers/spi/spi-s3c64xx.c     | 2 +-
 drivers/spi/spi-st-ssc4.c     | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 3c9ed412932f..2fc2e7c0daf2 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -902,7 +902,7 @@ static int a3700_spi_probe(struct platform_device *pdev)
 static struct platform_driver a3700_spi_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
-		.of_match_table = of_match_ptr(a3700_spi_dt_ids),
+		.of_match_table = a3700_spi_dt_ids,
 	},
 	.probe		= a3700_spi_probe,
 };
diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index d8360f94d3b7..0d7f89301f8d 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -753,7 +753,7 @@ static struct platform_driver img_spfi_driver = {
 	.driver = {
 		.name = "img-spfi",
 		.pm = &img_spfi_pm_ops,
-		.of_match_table = of_match_ptr(img_spfi_of_match),
+		.of_match_table = img_spfi_of_match,
 	},
 	.probe = img_spfi_probe,
 	.remove_new = img_spfi_remove,
diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index fc75492e50ff..4189d4434e37 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -946,7 +946,7 @@ static struct platform_driver meson_spicc_driver = {
 	.remove_new = meson_spicc_remove,
 	.driver  = {
 		.name = "meson-spicc",
-		.of_match_table = of_match_ptr(meson_spicc_of_match),
+		.of_match_table = meson_spicc_of_match,
 	},
 };
 
diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index fd8b26dd4a79..0c39d59d0af8 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -432,7 +432,7 @@ static struct platform_driver meson_spifc_driver = {
 	.remove_new = meson_spifc_remove,
 	.driver	= {
 		.name		= "meson-spifc",
-		.of_match_table	= of_match_ptr(meson_spifc_dt_match),
+		.of_match_table	= meson_spifc_dt_match,
 		.pm		= &meson_spifc_pm_ops,
 	},
 };
diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index eee9ff4bfa5b..a0029e8dc0be 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -843,7 +843,7 @@ static struct platform_driver orion_spi_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
 		.pm	= &orion_spi_pm_ops,
-		.of_match_table = of_match_ptr(orion_spi_of_match_table),
+		.of_match_table = orion_spi_of_match_table,
 	},
 	.probe		= orion_spi_probe,
 	.remove_new	= orion_spi_remove,
diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index 3f1e5b27776b..458c1a8d5719 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -679,7 +679,7 @@ MODULE_DEVICE_TABLE(of, pic32_sqi_of_ids);
 static struct platform_driver pic32_sqi_driver = {
 	.driver = {
 		.name = "sqi-pic32",
-		.of_match_table = of_match_ptr(pic32_sqi_of_ids),
+		.of_match_table = pic32_sqi_of_ids,
 	},
 	.probe = pic32_sqi_probe,
 	.remove_new = pic32_sqi_remove,
diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 709edb70ad7d..e8bd32c1fc7c 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -856,7 +856,7 @@ MODULE_DEVICE_TABLE(of, pic32_spi_of_match);
 static struct platform_driver pic32_spi_driver = {
 	.driver = {
 		.name = "spi-pic32",
-		.of_match_table = of_match_ptr(pic32_spi_of_match),
+		.of_match_table = pic32_spi_of_match,
 	},
 	.probe = pic32_spi_probe,
 	.remove_new = pic32_spi_remove,
diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index e1ecd96c7858..4dbb5127a9e5 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -1042,7 +1042,7 @@ static struct platform_driver rockchip_spi_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
 		.pm = &rockchip_spi_pm,
-		.of_match_table = of_match_ptr(rockchip_spi_dt_match),
+		.of_match_table = rockchip_spi_dt_match,
 	},
 	.probe = rockchip_spi_probe,
 	.remove_new = rockchip_spi_remove,
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index f726d8670428..dbb89f6cb3dd 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1677,7 +1677,7 @@ static struct platform_driver s3c64xx_spi_driver = {
 	.driver = {
 		.name	= "s3c64xx-spi",
 		.pm = &s3c64xx_spi_pm,
-		.of_match_table = of_match_ptr(s3c64xx_spi_dt_match),
+		.of_match_table = s3c64xx_spi_dt_match,
 	},
 	.probe = s3c64xx_spi_probe,
 	.remove_new = s3c64xx_spi_remove,
diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index e064025e2fd6..6d288497c500 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -446,7 +446,7 @@ static struct platform_driver spi_st_driver = {
 	.driver = {
 		.name = "spi-st",
 		.pm = &spi_st_pm,
-		.of_match_table = of_match_ptr(stm_spi_match),
+		.of_match_table = stm_spi_match,
 	},
 	.probe = spi_st_probe,
 	.remove_new = spi_st_remove,
-- 
2.39.2


