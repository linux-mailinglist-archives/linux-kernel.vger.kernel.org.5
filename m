Return-Path: <linux-kernel+bounces-114964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C388892C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574881C2E066
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4972DF1C1;
	Mon, 25 Mar 2024 00:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmzH8sGj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E835282A85;
	Sun, 24 Mar 2024 23:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323742; cv=none; b=ASY4ayErmUQcnTel5yeTzLmc6Srxrkz2XLVhEr0wzj+Gqz2DGOg8VL861eWuhtK9zhbZ380Tjc0WKKC0t9qVlGPQYyeSQ+F4wdoGFu3ZZJ2tGZ5w0oY4VBm9LUM/tO/hLCbqbhQvMCL3V9cAW5jYLU3tuTBZSicHefPs5DWYmNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323742; c=relaxed/simple;
	bh=IwqCgXVVD8OsANwC37VO12HTPFTbTHFU2IzrVP1h6pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RM/fXfu07QSb+73MewFTfCAWGIsm8lRIUgUjmMSXBjJHewz/RwkKcugljr1aM7WdroxHYjmV5oR3wQCO13xhwhm4rmfRM/m19q9RnnbZANkKuOfSTDjcJQCDqVmOkySVCUzkzd616jARfl7+NbWtgM6aH55vmb6sD78QdcNvcrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmzH8sGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25526C43394;
	Sun, 24 Mar 2024 23:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323740;
	bh=IwqCgXVVD8OsANwC37VO12HTPFTbTHFU2IzrVP1h6pE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmzH8sGjIVcGpk2zSFYGnNKMxSHFNBKhPvaQLap/7Nt86MrqCLoHsLouzoWJ48btJ
	 ZRzs1R3tXFcIm/0yQZM4ehWd9/RMpFWJ59wFl/e5hqQ2aUdtPcZoZM3jtIqMRG5xJO
	 YSPZ9nUGn1MnFYj6D+LOaSexw1epWu7jN70g9ATJk2ExAMAfHVvFvky8IF6UBDrtLN
	 la4YQ2dOQVL+XercyZXcx42NW8PTcLXkHNXKv3LbP5TK2UrP6gCV3nk5yrrIzHUpzT
	 w2s1bC7qqRUX7zR7HG9ndPT9dgxP6nAH+cQaSGDEp1N7c9e52IclIArmpxYfrhgTQ6
	 ALzOtdObIV8lg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 115/238] drm/tegra: dsi: Fix some error handling paths in tegra_dsi_probe()
Date: Sun, 24 Mar 2024 19:38:23 -0400
Message-ID: <20240324234027.1354210-116-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 830c1ded356369cd1303e8bb87ce3fea6e744de8 ]

If an error occurs after calling tegra_output_probe(),
tegra_output_remove() should be called as already done in the remove
function.

Fixes: dec727399a4b ("drm/tegra: Add DSI support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/16820073278d031f6c474a08d5f22a255158585e.1693667005.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/dsi.c | 54 ++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index 6cbba2adb6e5a..815e32e05f600 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1586,44 +1586,58 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 
 	if (!pdev->dev.pm_domain) {
 		dsi->rst = devm_reset_control_get(&pdev->dev, "dsi");
-		if (IS_ERR(dsi->rst))
-			return PTR_ERR(dsi->rst);
+		if (IS_ERR(dsi->rst)) {
+			err = PTR_ERR(dsi->rst);
+			goto remove;
+		}
 	}
 
 	dsi->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(dsi->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(dsi->clk),
-				     "cannot get DSI clock\n");
+	if (IS_ERR(dsi->clk)) {
+		err = dev_err_probe(&pdev->dev, PTR_ERR(dsi->clk),
+				    "cannot get DSI clock\n");
+		goto remove;
+	}
 
 	dsi->clk_lp = devm_clk_get(&pdev->dev, "lp");
-	if (IS_ERR(dsi->clk_lp))
-		return dev_err_probe(&pdev->dev, PTR_ERR(dsi->clk_lp),
-				     "cannot get low-power clock\n");
+	if (IS_ERR(dsi->clk_lp)) {
+		err = dev_err_probe(&pdev->dev, PTR_ERR(dsi->clk_lp),
+				    "cannot get low-power clock\n");
+		goto remove;
+	}
 
 	dsi->clk_parent = devm_clk_get(&pdev->dev, "parent");
-	if (IS_ERR(dsi->clk_parent))
-		return dev_err_probe(&pdev->dev, PTR_ERR(dsi->clk_parent),
-				     "cannot get parent clock\n");
+	if (IS_ERR(dsi->clk_parent)) {
+		err = dev_err_probe(&pdev->dev, PTR_ERR(dsi->clk_parent),
+				    "cannot get parent clock\n");
+		goto remove;
+	}
 
 	dsi->vdd = devm_regulator_get(&pdev->dev, "avdd-dsi-csi");
-	if (IS_ERR(dsi->vdd))
-		return dev_err_probe(&pdev->dev, PTR_ERR(dsi->vdd),
-				     "cannot get VDD supply\n");
+	if (IS_ERR(dsi->vdd)) {
+		err = dev_err_probe(&pdev->dev, PTR_ERR(dsi->vdd),
+				    "cannot get VDD supply\n");
+		goto remove;
+	}
 
 	err = tegra_dsi_setup_clocks(dsi);
 	if (err < 0) {
 		dev_err(&pdev->dev, "cannot setup clocks\n");
-		return err;
+		goto remove;
 	}
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dsi->regs = devm_ioremap_resource(&pdev->dev, regs);
-	if (IS_ERR(dsi->regs))
-		return PTR_ERR(dsi->regs);
+	if (IS_ERR(dsi->regs)) {
+		err = PTR_ERR(dsi->regs);
+		goto remove;
+	}
 
 	dsi->mipi = tegra_mipi_request(&pdev->dev, pdev->dev.of_node);
-	if (IS_ERR(dsi->mipi))
-		return PTR_ERR(dsi->mipi);
+	if (IS_ERR(dsi->mipi)) {
+		err = PTR_ERR(dsi->mipi);
+		goto remove;
+	}
 
 	dsi->host.ops = &tegra_dsi_host_ops;
 	dsi->host.dev = &pdev->dev;
@@ -1654,6 +1668,8 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 	mipi_dsi_host_unregister(&dsi->host);
 mipi_free:
 	tegra_mipi_free(dsi->mipi);
+remove:
+	tegra_output_remove(&dsi->output);
 	return err;
 }
 
-- 
2.43.0


