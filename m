Return-Path: <linux-kernel+bounces-116057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 996BD889537
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A3D2972B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD552261B9;
	Mon, 25 Mar 2024 03:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtapN0J5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB0A2789BD;
	Sun, 24 Mar 2024 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323456; cv=none; b=BfJpw1U80ddRTkg4dQwLa3OregxC5HOmz31v3nDHxK6aFp5pWkdbdbkK2uUK0ifz1eH3XN1l1eR9W0DkPk4D+cQn7ZJL/ELetQAJv9ibx2g2ymJw+dSzqh9ZGN05LGZMByeOByEOqzpC5esmT24CfSW8hWNX9wovYnhycQTnumo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323456; c=relaxed/simple;
	bh=I5IZLXRovJJX137SJGnoEbJCPVfKKUehgGid1mWVd0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ix17dkZjxcISLEVXma7OCjWhyb3D9h6L3ZCLOsxsU2Yufz4llV2B87UB03NCQLFPtrF1uJ7JC9/Noc5iXjkXBI+3MS8H5aKQR8XK4J0lDWFk7F7o/a3JuxULnpuSwjkXgr03hP1m8H5pe9CooQfcSle+j5KHpPOQUZaQtWmFMTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtapN0J5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F10C43390;
	Sun, 24 Mar 2024 23:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323455;
	bh=I5IZLXRovJJX137SJGnoEbJCPVfKKUehgGid1mWVd0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jtapN0J5jWghDr0SEnLlYX53mYDQM/SJv+Xpt1TW70lu1hLU/4qW1eFm295V7FdOP
	 i/yB2AlzjUqMvzd+DnXrfIXF7Sw/qfMsozwosVX2rWSGSjtzhZsS1sEh59gap8hV9y
	 s2hZNuBm8mFSX/lms53BxKF5oH9YzDqliLunfEJADxovxoWolASzgiUdz06KywR1hX
	 IZCS4fOZ3dU5jUHF7zwnVoQlEp/V3tP+OXjunxTVByE1xuiXFQwG77bzpSSrjl7OA3
	 Jm+Rmbkqxcxb6b3DDbEqmLZafB/HX50hWpDoMpEFZSyd6iVkkCQsSDGACR8TuHJl1a
	 A5WV5cdNDnlbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cai Huoqing <caihuoqing@baidu.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 159/317] drm/tegra: dsi: Make use of the helper function dev_err_probe()
Date: Sun, 24 Mar 2024 19:32:19 -0400
Message-ID: <20240324233458.1352854-160-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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


