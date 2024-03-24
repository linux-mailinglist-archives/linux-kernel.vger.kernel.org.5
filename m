Return-Path: <linux-kernel+bounces-115453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F285788A137
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5F95B3527D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B60218520;
	Mon, 25 Mar 2024 02:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmFuq9WS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525541E5866;
	Sun, 24 Mar 2024 22:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320829; cv=none; b=Bic71f6+jXtuVSW88U0NDDiKt49ZhmKrnqEHHp1xVDiPAxAqzoiWi7Y2Na+D5GHBLEOFbwCM19mCVxFqNRJ4gp9ymPUVK2C3C0fR27W6Dc0Yhudrx5g94s0Zuui/FRe4oBuxyYk7SdaQP2YwDlvxsJlk071z1vdY85fLFnIYOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320829; c=relaxed/simple;
	bh=+vKf/AD+EU5ShwD9w5bCge7Hc87d+rNN8o9xeCJe6BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOMm1wN9r3YgzrzjooUf6d22QYRYX5FPaV4mXqKkvlxgNwV7kXwaVlduXnFC54yWnfWVq93YcYpXUpqDWdFdnJs+6kWb1R+fFm9RvOZVjAP0uQBa2uh5K3UOKEvR025OIx80nydt289OMiX6v4qc06KUcZumc5A0xiTwRg39CZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmFuq9WS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B68EC43390;
	Sun, 24 Mar 2024 22:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320829;
	bh=+vKf/AD+EU5ShwD9w5bCge7Hc87d+rNN8o9xeCJe6BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WmFuq9WSaAZ1clZgm/acDvKyC+9ISbUwVx9doA7IuNW0+y41yaRnWwr+8jk22MbSV
	 KtsfDKiqEznCbkteE71/tF6hJKWO7wwl+6Gtaz3n7BKR40cIuK/SsFo39FTScOSi8W
	 lnDnO89JDf3xeL7H8BVXOjgfrDXIo8aomPaQsGnLM0zrBTn0UehBJVK146RlsMAunN
	 bYIEFwo871abyupC/T000QTzOLePdhjagRpnMaYhdOX6LQ0TxAYDYKZOdEht1v4kNY
	 LDFsUEMRbAXQ/TjXluRL6t9AmShItlAbuMdS2UYyqs8WVO/ibAf9NSGVdAoaYGmCLo
	 3QeOUFV+jiC1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 394/713] drm/tegra: rgb: Fix some error handling paths in tegra_dc_rgb_probe()
Date: Sun, 24 Mar 2024 18:42:00 -0400
Message-ID: <20240324224720.1345309-395-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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

[ Upstream commit bc456b5d93dbfdbd89f2a036f4f3d8026595f9e4 ]

If an error occurs after calling tegra_output_probe(),
tegra_output_remove() should be called as already done in the remove
function.

Fixes: 59d29c0ec93f ("drm/tegra: Allocate resources at probe time")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/0001f61eb89048bc36241629b564195689cf54b6.1693667005.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/rgb.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index fc66bbd913b24..53c492b13d129 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -225,26 +225,28 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 	rgb->clk = devm_clk_get(dc->dev, NULL);
 	if (IS_ERR(rgb->clk)) {
 		dev_err(dc->dev, "failed to get clock\n");
-		return PTR_ERR(rgb->clk);
+		err = PTR_ERR(rgb->clk);
+		goto remove;
 	}
 
 	rgb->clk_parent = devm_clk_get(dc->dev, "parent");
 	if (IS_ERR(rgb->clk_parent)) {
 		dev_err(dc->dev, "failed to get parent clock\n");
-		return PTR_ERR(rgb->clk_parent);
+		err = PTR_ERR(rgb->clk_parent);
+		goto remove;
 	}
 
 	err = clk_set_parent(rgb->clk, rgb->clk_parent);
 	if (err < 0) {
 		dev_err(dc->dev, "failed to set parent clock: %d\n", err);
-		return err;
+		goto remove;
 	}
 
 	rgb->pll_d_out0 = clk_get_sys(NULL, "pll_d_out0");
 	if (IS_ERR(rgb->pll_d_out0)) {
 		err = PTR_ERR(rgb->pll_d_out0);
 		dev_err(dc->dev, "failed to get pll_d_out0: %d\n", err);
-		return err;
+		goto remove;
 	}
 
 	if (dc->soc->has_pll_d2_out0) {
@@ -252,13 +254,17 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 		if (IS_ERR(rgb->pll_d2_out0)) {
 			err = PTR_ERR(rgb->pll_d2_out0);
 			dev_err(dc->dev, "failed to get pll_d2_out0: %d\n", err);
-			return err;
+			goto remove;
 		}
 	}
 
 	dc->rgb = &rgb->output;
 
 	return 0;
+
+remove:
+	tegra_output_remove(&rgb->output);
+	return err;
 }
 
 void tegra_dc_rgb_remove(struct tegra_dc *dc)
-- 
2.43.0


