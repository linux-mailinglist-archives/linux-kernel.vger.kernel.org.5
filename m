Return-Path: <linux-kernel+bounces-115198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C69C888DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4EB1C27797
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D078E1CAC95;
	Mon, 25 Mar 2024 01:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FK+tQPKs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D55F294E0B;
	Sun, 24 Mar 2024 23:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324293; cv=none; b=lw0IVc2T5v1K1+zKVcaFx77vZ6OnpNrBmd5tmToZgT8nVCsNcpPWsjn/SfUyhBVr3Cqe7TtJ4uwzlCNEJ9cabAsnACspigYUdnC5Rj7q/jdano5XgmYct2qXS64kOYP29l/btbd6kPRb6ROs/Q/icjdHBRNT2cJJ4wn+FPz0Afc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324293; c=relaxed/simple;
	bh=jlytCQnOmqtIWrua3+DJqrL72f/zZ/tYkRgyQ7+DaiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkXu4fISPIIGzo8iEzTT9vEPpXbyppe41K12eTLHV/jYDUDQ+9vzpKTf62B8vYw8D8BCUdax2+fnBeFGcvmO+cpod/i0bAr7KkzI2kq02Fej+d3oH+0huoP6PK50Oza3vOqlqZr8ioOi7j0ti6S/ebGubPC5LfUtWXhnv9mdrnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FK+tQPKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8F7C43390;
	Sun, 24 Mar 2024 23:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324292;
	bh=jlytCQnOmqtIWrua3+DJqrL72f/zZ/tYkRgyQ7+DaiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FK+tQPKsKD7D+CXdF67tN+LjUnrJ+rz+1/8lBzOzwuqVZCYlWKfXWZAiRMyXfZ9C0
	 aDFHRplqqoKLYNAs0lV/3A7RMivQW9vUjFmHxygAKTUX0PWwAPr9TjPqL11fyGx2fw
	 AVLbt4+haPCGLzuZNMlH46cCep+KwIAdyyY9ArMkbr+r4EXSNZ0ihWzlQW+41Jc5Au
	 NN1hegginnbCC3W2FDkuk+Gj6no7RjE22zGo4LYn3hfKJqzbXnfbbypndZsUOL0kRK
	 qy3axjMzmXFdVaWPwA7v3zWvtogcD7gOtM5xVl3ZC2b5AaDqKhLWYBjQ/mdBiccGBW
	 2VsgOKXCn+NBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cai Huoqing <caihuoqing@baidu.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 068/148] drm/tegra: dsi: Make use of the helper function dev_err_probe()
Date: Sun, 24 Mar 2024 19:48:52 -0400
Message-ID: <20240324235012.1356413-69-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Cai Huoqing <caihuoqing@baidu.com>

[ Upstream commit fc75e4fcbd1e4252a0481ebb23cd4516c127a8e2 ]

When possible use dev_err_probe help to properly deal with the
PROBE_DEFER error, the benefit is that DEFER issue will be logged
in the devices_deferred debugfs file.
And using dev_err_probe() can reduce code size, the error value
gets printed.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Stable-dep-of: 830c1ded3563 ("drm/tegra: dsi: Fix some error handling paths in tegra_dsi_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/dsi.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index 7033ab28f7716..04bf4c89d870e 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1509,28 +1509,24 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 	}
 
 	dsi->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(dsi->clk)) {
-		dev_err(&pdev->dev, "cannot get DSI clock\n");
-		return PTR_ERR(dsi->clk);
-	}
+	if (IS_ERR(dsi->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dsi->clk),
+				     "cannot get DSI clock\n");
 
 	dsi->clk_lp = devm_clk_get(&pdev->dev, "lp");
-	if (IS_ERR(dsi->clk_lp)) {
-		dev_err(&pdev->dev, "cannot get low-power clock\n");
-		return PTR_ERR(dsi->clk_lp);
-	}
+	if (IS_ERR(dsi->clk_lp))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dsi->clk_lp),
+				     "cannot get low-power clock\n");
 
 	dsi->clk_parent = devm_clk_get(&pdev->dev, "parent");
-	if (IS_ERR(dsi->clk_parent)) {
-		dev_err(&pdev->dev, "cannot get parent clock\n");
-		return PTR_ERR(dsi->clk_parent);
-	}
+	if (IS_ERR(dsi->clk_parent))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dsi->clk_parent),
+				     "cannot get parent clock\n");
 
 	dsi->vdd = devm_regulator_get(&pdev->dev, "avdd-dsi-csi");
-	if (IS_ERR(dsi->vdd)) {
-		dev_err(&pdev->dev, "cannot get VDD supply\n");
-		return PTR_ERR(dsi->vdd);
-	}
+	if (IS_ERR(dsi->vdd))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dsi->vdd),
+				     "cannot get VDD supply\n");
 
 	err = tegra_dsi_setup_clocks(dsi);
 	if (err < 0) {
-- 
2.43.0


