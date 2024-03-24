Return-Path: <linux-kernel+bounces-114523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971E1889042
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C853B1C2C209
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57615182EF4;
	Sun, 24 Mar 2024 23:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHulbNd3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0615815B546;
	Sun, 24 Mar 2024 23:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322161; cv=none; b=O+feteILn3tnRO5CLYFQyrRllOIjM19oTQ6aQ0WwSNtbTDYiDiNf9Y1kqoobmfHOjwc9ATKSSLwXhCNuBXtrZ3/P7n2OS6TcnsZ8JGNouLLAJmK4F+wk9u1lbXs9J968IBY7eF49I2Pp+VwQmdAL9yEFx/jkt9UQi3OowGoagwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322161; c=relaxed/simple;
	bh=IwqCgXVVD8OsANwC37VO12HTPFTbTHFU2IzrVP1h6pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0gWCOum6uQrr7EHv229q7pFbN1/pPOrO2IPTYose5L6W8/RlgtUR1JBoAkY6iWlsQ4+90BDQBnSdJy9zH+lMXqCkqszQroSp/jks4A9C9qGp/cUHDZk8pRYXcPExdaocESGy0sG2AxwrbnM1XxHIgpJJMYdb/BFw8XKa88JEDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHulbNd3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035FDC43390;
	Sun, 24 Mar 2024 23:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322159;
	bh=IwqCgXVVD8OsANwC37VO12HTPFTbTHFU2IzrVP1h6pE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rHulbNd3FtwgCywICO7eyGYFoWgZm9099Gvakpu2v8wYOC1EQjU8yaiMwcDoP5t2e
	 3az9G9ruVL55MddjgLAtA939h6omymoT1JjpBMj3KfXH56SzYT+ByQU3vWbAYD0gKV
	 Ne4Xnrld84TnYA73mS6clQM64dNLqYgr00PnJxMidUJ2f4kw0VobY0Fz9soTQgklg1
	 a1qTy5Z93+DQRSAZTiAKEV5o7YEwqAoyfI2NUkhsdSaxBsulNQlVISmaGL7Dfey19Z
	 rnSwjjoeS7b6J+Kgpjz4QQPEmoLPggQ3KxEMx9xEGucXaXaPU/Ax+15e0inDcU6FDT
	 9xUnZSz8howEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 237/451] drm/tegra: dsi: Fix some error handling paths in tegra_dsi_probe()
Date: Sun, 24 Mar 2024 19:08:33 -0400
Message-ID: <20240324231207.1351418-238-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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


