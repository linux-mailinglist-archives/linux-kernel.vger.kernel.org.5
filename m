Return-Path: <linux-kernel+bounces-138926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2190189FC12
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D761F24884
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D91616FF32;
	Wed, 10 Apr 2024 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vELJBzOB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCED16F0EF;
	Wed, 10 Apr 2024 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764467; cv=none; b=O4AkYaZ1CUI5pKl5zwqmkPhd9Nq4L480WGCQ7jOYjl/93Z6TfjROqOwa7Mr72p9Z3XSGIAVoWwEdjXBSUutnx7/eutfqUKuTMWccCA2kK9xu8GOJxiXj+59Q34NjEk8N9glEbcnjE0XIUyAWf8fiBVuy5mUB/veJkMq1za4aug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764467; c=relaxed/simple;
	bh=t39f7eLFC7bPkJPUbKKNMDcy78yid1G8KUgumlAm3gU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GTH5JTg6ni5KbjDziB7HNTOTc9pIgwzXDUqxLLeBRToYLDAF8UlNNiABwXuGOngAzKJIGt0bIUA+JgDgCSby53fGxCSHVM9esdkX/23HM0pdfz1+xwpq+09lF1bwFEqpvuEwppN7nzEGTu35ySc+yzG0RSO9vlCk2RThaxBFMog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vELJBzOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23480C433C7;
	Wed, 10 Apr 2024 15:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712764467;
	bh=t39f7eLFC7bPkJPUbKKNMDcy78yid1G8KUgumlAm3gU=;
	h=From:To:Cc:Subject:Date:From;
	b=vELJBzOBnPTe29+cw7SsazoNy67wFX3Y9ir5GjG+qv2pkwVe6HzeHuJGuIB2vHmax
	 Yzi4I1j2pBeBDXW4xWymX1oF8PMvd/yJaVWyGkbwgzyts7uEcJ5Dc9/8Fofdm73mtg
	 k+ryuTKceKP3rIDyP7nyrXl2sy5utTJUXKfwj2KNyZIOwVJREElT3rEcpEkiZOXa4i
	 FoD7wGyLhJ+OhIKTN0eeq6T/61GAiHI2pXz1h5FvHS51PnlHtrFDQ9pHq4NRrzP9Hf
	 KZ+rXJfZe6sF7Gxngvjcaap6cYK3bpx/zi/w68bOhgln+w5cMDY+E+N0LDFp7wxG9D
	 RJolproTtGsZA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] clk: sunxi-ng: fix module autoloading
Date: Wed, 10 Apr 2024 17:54:20 +0200
Message-Id: <20240410155420.224157-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.  Clocks are considered core
components, so usually they are built-in, however these can be built and
used as modules on some generic kernel.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c   | 1 +
 drivers/clk/sunxi-ng/ccu-sun20i-d1.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c | 1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c   | 1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c    | 1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c   | 1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c   | 1 +
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c    | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c      | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-r.c       | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c  | 1 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c | 1 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c     | 1 +
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c | 1 +
 23 files changed, 23 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c b/drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c
index 9d3ffd3fb2c1..0736f6c81269 100644
--- a/drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c
@@ -125,6 +125,7 @@ static const struct of_device_id sun20i_d1_r_ccu_ids[] = {
 	{ .compatible = "allwinner,sun20i-d1-r-ccu" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sun20i_d1_r_ccu_ids);
 
 static struct platform_driver sun20i_d1_r_ccu_driver = {
 	.probe	= sun20i_d1_r_ccu_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-sun20i-d1.c b/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
index 48a8fb2c43b7..60756aadfad6 100644
--- a/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
+++ b/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
@@ -1394,6 +1394,7 @@ static const struct of_device_id sun20i_d1_ccu_ids[] = {
 	{ .compatible = "allwinner,sun20i-d1-ccu" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sun20i_d1_ccu_ids);
 
 static struct platform_driver sun20i_d1_ccu_driver = {
 	.probe	= sun20i_d1_ccu_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
index 451ebb7c99a3..14f5c3da652b 100644
--- a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
+++ b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
@@ -1481,6 +1481,7 @@ static const struct of_device_id sun4i_a10_ccu_ids[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sun4i_a10_ccu_ids);
 
 static struct platform_driver sun4i_a10_ccu_driver = {
 	.probe	= sun4i_a10_ccu_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
index fddd6c877cec..3b983bb59bd9 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
@@ -202,6 +202,7 @@ static const struct of_device_id sun50i_a100_r_ccu_ids[] = {
 	{ .compatible = "allwinner,sun50i-a100-r-ccu" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sun50i_a100_r_ccu_ids);
 
 static struct platform_driver sun50i_a100_r_ccu_driver = {
 	.probe	= sun50i_a100_r_ccu_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c b/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
index 5f93b5526e13..38aa6e5f298e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
@@ -1264,6 +1264,7 @@ static const struct of_device_id sun50i_a100_ccu_ids[] = {
 	{ .compatible = "allwinner,sun50i-a100-ccu" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sun50i_a100_ccu_ids);
 
 static struct platform_driver sun50i_a100_ccu_driver = {
 	.probe	= sun50i_a100_ccu_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 8951ffc14ff5..6edd6e90007e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -978,6 +978,7 @@ static const struct of_device_id sun50i_a64_ccu_ids[] = {
 	{ .compatible = "allwinner,sun50i-a64-ccu" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sun50i_a64_ccu_ids);
 
 static struct platform_driver sun50i_a64_ccu_driver = {
 	.probe	= sun50i_a64_ccu_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
index 02b28cfc5525..e2dc29fa99e7 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
@@ -244,6 +244,7 @@ static const struct of_device_id sun50i_h6_r_ccu_ids[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sun50i_h6_r_ccu_ids);
 
 static struct platform_driver sun50i_h6_r_ccu_driver = {
 	.probe	= sun50i_h6_r_ccu_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index 42568c616181..fa483bc2437a 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -1259,6 +1259,7 @@ static const struct of_device_id sun50i_h6_ccu_ids[] = {
 	{ .compatible = "allwinner,sun50i-h6-ccu" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sun50i_h6_ccu_ids);
 
 static struct platform_driver sun50i_h6_ccu_driver = {
 	.probe	= sun50i_h6_ccu_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
index 21e918582aa5..45aae1ae5178 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
@@ -1154,6 +1154,7 @@ static const struct of_device_id sun50i_h616_ccu_ids[] = {
 	{ .compatible = "allwinner,sun50i-h616-ccu" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sun50i_h616_ccu_ids);
 
 static struct platform_driver sun50i_h616_ccu_driver = {
 	.probe	= sun50i_h616_ccu_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index 0762deffb33c..8cb8cbbdbafb 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -1271,6 +1271,7 @@ static const struct of_device_id sun6i_a31_ccu_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-ccu" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sun6i_a31_ccu_ids);
 
 static struct platform_driver sun6i_a31_ccu_driver = {
 	.probe	= sun6i_a31_ccu_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
index fdc8ccc586c9..5a98c4e9e667 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
@@ -336,6 +336,7 @@ static const struct of_device_id sun6i_rtc_ccu_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, sun6i_rtc_ccu_match);
 
 int sun6i_rtc_ccu_probe(struct device *dev, void __iomem *reg)
 {
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
index e80cc3864e44..e748ad612b8f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
@@ -751,6 +751,7 @@ static const struct of_device_id sun8i_a23_ccu_ids[] = {
 	{ .compatible = "allwinner,sun8i-a23-ccu" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sun8i_a23_ccu_ids);
 
 static struct platform_driver sun8i_a23_ccu_driver = {
 	.probe	= sun8i_a23_ccu_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
index d12878a1ba9e..8a27a1777600 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
@@ -823,6 +823,7 @@ static const struct of_device_id sun8i_a33_ccu_ids[] = {
 	{ .compatible = "allwinner,sun8i-a33-ccu" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sun8i_a33_ccu_ids);
 
 static struct platform_driver sun8i_a33_ccu_driver = {
 	.probe	= sun8i_a33_ccu_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
index 76cbd9e9e89f..93eca47935cf 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -911,6 +911,7 @@ static const struct of_device_id sun8i_a83t_ccu_ids[] = {
 	{ .compatible = "allwinner,sun8i-a83t-ccu" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sun8i_a83t_ccu_ids);
 
 static struct platform_driver sun8i_a83t_ccu_driver = {
 	.probe	= sun8i_a83t_ccu_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
index 6a043a0a9dd6..b0b8dba239ae 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -337,6 +337,7 @@ static const struct of_device_id sunxi_de2_clk_ids[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sunxi_de2_clk_ids);
 
 static struct platform_driver sunxi_de2_clk_driver = {
 	.probe	= sunxi_de2_clk_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index 74274c17efb3..ca5739fa04f7 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -1082,6 +1082,7 @@ static const struct of_device_id sun8i_h3_ccu_ids[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sun8i_h3_ccu_ids);
 
 static struct platform_driver sun8i_h3_ccu_driver = {
 	.probe	= sun8i_h3_ccu_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r.c b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
index 4890a976b1a0..bac7e737db98 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
@@ -262,6 +262,7 @@ static const struct of_device_id sun8i_r_ccu_ids[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sun8i_r_ccu_ids);
 
 static struct platform_driver sun8i_r_ccu_driver = {
 	.probe	= sun8i_r_ccu_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
index 31eca0d3bc1e..3774b293e74c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
@@ -1363,6 +1363,7 @@ static const struct of_device_id sun8i_r40_ccu_ids[] = {
 	{ .compatible = "allwinner,sun8i-r40-ccu" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sun8i_r40_ccu_ids);
 
 static struct platform_driver sun8i_r40_ccu_driver = {
 	.probe	= sun8i_r40_ccu_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
index f3ce8664b288..994258a3ad2e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
@@ -768,6 +768,7 @@ static const struct of_device_id sun8i_v3s_ccu_ids[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sun8i_v3s_ccu_ids);
 
 static struct platform_driver sun8i_v3s_ccu_driver = {
 	.probe	= sun8i_v3s_ccu_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
index 1d8b1ae1619d..ae7939d3f502 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
@@ -254,6 +254,7 @@ static const struct of_device_id sun9i_a80_de_clk_ids[] = {
 	{ .compatible = "allwinner,sun9i-a80-de-clks" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sun9i_a80_de_clk_ids);
 
 static struct platform_driver sun9i_a80_de_clk_driver = {
 	.probe	= sun9i_a80_de_clk_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
index a0fb0da8f356..bfa2ff9d52a4 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
@@ -127,6 +127,7 @@ static const struct of_device_id sun9i_a80_usb_clk_ids[] = {
 	{ .compatible = "allwinner,sun9i-a80-usb-clks" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sun9i_a80_usb_clk_ids);
 
 static struct platform_driver sun9i_a80_usb_clk_driver = {
 	.probe	= sun9i_a80_usb_clk_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
index 730fd8e28014..c05805e4ad22 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
@@ -1236,6 +1236,7 @@ static const struct of_device_id sun9i_a80_ccu_ids[] = {
 	{ .compatible = "allwinner,sun9i-a80-ccu" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sun9i_a80_ccu_ids);
 
 static struct platform_driver sun9i_a80_ccu_driver = {
 	.probe	= sun9i_a80_ccu_probe,
diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
index 0d5b60b123b7..76d3d070b2a7 100644
--- a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
+++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
@@ -565,6 +565,7 @@ static const struct of_device_id suniv_f1c100s_ccu_ids[] = {
 	{ .compatible = "allwinner,suniv-f1c100s-ccu" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, suniv_f1c100s_ccu_ids);
 
 static struct platform_driver suniv_f1c100s_ccu_driver = {
 	.probe	= suniv_f1c100s_ccu_probe,
-- 
2.34.1


