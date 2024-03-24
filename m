Return-Path: <linux-kernel+bounces-114967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ED5888C43
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794A81C29F54
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4415B2DF983;
	Mon, 25 Mar 2024 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpjWn1He"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08472282A7E;
	Sun, 24 Mar 2024 23:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323741; cv=none; b=A9OxDF9sDTFvFUkY7Fpl32xkI0h9DNI771Jf115WHz8RMIll/tkHLlq0HiaYIBGsIwy0Jgj8Cj4thlrZ9lxUNrYMorAV2UsGnY7y2ymOZRT+G2vOqPRLHtQga/9bFrflGHSSJ7+gFnCF6BTwbRDYGceaLlSkv9/oIN005ZdN1vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323741; c=relaxed/simple;
	bh=I5IZLXRovJJX137SJGnoEbJCPVfKKUehgGid1mWVd0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PR0ERkfl6R3mdNc9wJwIGKDu/9DUbpWWyY9dXf7jplY83/fBNb8/kK5C8pngU9goRXOFnQ0aPU8+Mt5P+X01NflR+UO9iTlXg5u+mEAvA9kAZejE6X+QvvW9mYcDWR/bh3y7F2JYrVg/0Ze7svBDa57ZIK2ePYMxE8EAJPYHKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpjWn1He; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4021DC433F1;
	Sun, 24 Mar 2024 23:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323739;
	bh=I5IZLXRovJJX137SJGnoEbJCPVfKKUehgGid1mWVd0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fpjWn1HeBpRT2Xa3SrDwriHklg+50ND2hjK3SCvw7tNPjaDszT87zMm4oA0DIWDhQ
	 9/d2tucCOdMVfjTnpIwZk7g9YTExrG1kJX8l+wyTyS2B23McfViRYzBIVwsljOIYnP
	 KZImFvD3ZIea4IqOX95rpmzH5CgEEFpHCrNvzyMxGUPgwgaKx3HHL58Gu75H48bFdt
	 G7T7096P2VOViH31A9Ghr6ZdQdKJ0jTUxkiJqMfNvHWPUcn9QY0gPOb0siR36OnsKt
	 Tm1m47Xr+zXmliFLBU6uahHu84YZJbKN7BWoZ25AQNsgd7AB7Lg1zRE7vUXdbv6T3c
	 hLiezGhbxWL6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cai Huoqing <caihuoqing@baidu.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 114/238] drm/tegra: dsi: Make use of the helper function dev_err_probe()
Date: Sun, 24 Mar 2024 19:38:22 -0400
Message-ID: <20240324234027.1354210-115-sashal@kernel.org>
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
index 0adce882f157b..6cbba2adb6e5a 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1591,28 +1591,24 @@ static int tegra_dsi_probe(struct platform_device *pdev)
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


