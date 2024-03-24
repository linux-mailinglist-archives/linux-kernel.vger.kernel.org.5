Return-Path: <linux-kernel+bounces-114520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242EE888AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D391C28B506
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B0628ECA1;
	Sun, 24 Mar 2024 23:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZI9jf4d9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E6F15B153;
	Sun, 24 Mar 2024 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322159; cv=none; b=ooMUaBTI9AafKVE4SfLhu54Aynu+Z70G76Zj3qFU6XYZwbGmaaSYY9mq3qXwT5+IYmL24cYD68LChPvj2r95Q4B8hODM89OgkcA4D3etqpXbFXPQolFBHrt7fD8lIDUuZb85NLxU78eScb0GR2BFNhXbRmnNf/JviikpkcMmp3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322159; c=relaxed/simple;
	bh=I5IZLXRovJJX137SJGnoEbJCPVfKKUehgGid1mWVd0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFHStgCk88XNzlQiyRM9pkGACn2Le/IHXc4p9HxRUzqPEtlWh60LkJiSJsffunG6yfuP7zMX1E0hINS+zwX9PVvpJ5LnEijJ8u2rWwVus7KNMXgihShkVyVqfAh8yTf8Bmp9uqKu4cAoU7dtRpHk5iKadM031xrgJnL10jWhbgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZI9jf4d9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC63C433C7;
	Sun, 24 Mar 2024 23:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322158;
	bh=I5IZLXRovJJX137SJGnoEbJCPVfKKUehgGid1mWVd0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZI9jf4d9k+9oqlbU72c+O5IqXpXuxaq49WNB5N2I1LOuZB1jlfubP7GTYhKEMrLxH
	 mEK82p7rgtdWQazZQcDZikjElaHLUnmrbxypJmyHZQHuUxSH/H3DzIxsVLs0CZPA4N
	 T92xGICnyALVjRpFG194BrCRYmqCCLeswp/SiIGmEkpFC5Qqt6/jPjvwI0QvUBmUEq
	 ACdXw6OhBXUCpZQxUAKwjocL0T26Wc3bTE13oLnnF/fLEJhl2BFfYWvvBwlgsxqiSL
	 fhWBRAoCP+RVUsEni7YW6SOx6bevVu8/Mp7F1ssgylG1iWDmTU7wT6XAIeYA5tNiwX
	 99INiwvpcuCVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cai Huoqing <caihuoqing@baidu.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 236/451] drm/tegra: dsi: Make use of the helper function dev_err_probe()
Date: Sun, 24 Mar 2024 19:08:32 -0400
Message-ID: <20240324231207.1351418-237-sashal@kernel.org>
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


