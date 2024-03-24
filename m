Return-Path: <linux-kernel+bounces-114532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BA5888ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8060028AC03
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69741836D3;
	Sun, 24 Mar 2024 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nlt3EDal"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498C215B567;
	Sun, 24 Mar 2024 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322164; cv=none; b=PpD+/H+vSWt79uWA9QxuJJMLjL5a8wZpUYTqhsfo24ne4GdJ/e7KczE1sEkvygX/zOcpkcDStfeWWFqIgGh9vVWdUscNFurnGBnRN1ef1gmfOv17IiOgjEUUOVRTnmaP/LvxgWaNqLBjRDuMDCtpDRk4fcme/uo/MYbBeX9Af8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322164; c=relaxed/simple;
	bh=3opSvBIeb9sIu0hGV9D/utEk2BVxGOEe3UbDszWGy9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3iLpLefBG+jjl20qPIdzuukfyiTBB4MQrir5dAl7tUiT99hxbQP9G8eS34uvZZcRx/uobtp2RXSEVDU6D7PFDgzmIfDkRSTgsM0p4LJO2f77rsEihz2mlfFPtAkWCaLdketaZWSPa1bhSENxmffzPBoEQptYZKGAagqONHbOt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nlt3EDal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8916FC433F1;
	Sun, 24 Mar 2024 23:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322163;
	bh=3opSvBIeb9sIu0hGV9D/utEk2BVxGOEe3UbDszWGy9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nlt3EDalp0CrukMmwHGvuCIT+20jmxwQQ6Ej9kgBdg0Adw/KxUzeX0p7WJnPnP+jk
	 YpwkdsVI2+yjUXsA53KYVxwQhcd36X0qe3+av8ZQgPvp9kX1qw0iWcUwI3/7P9TbB/
	 y9bg8SRU6j/w0difyXfW4VmWJwc4QLF9xi6lzjMV9+0/YlVWKNXoXQ0MHq9BtD+QA4
	 195OZRq9/PBzmuoddrzvuwIJtsuwekyBDCXfxBPmp85E/TivDjHpieRY2MfqcW6rEl
	 hFEsgHBMcQpsaCBHFKXcjhgCkwHPCO6ZW6ccR8Yp6gTnSTVE1i6jnYqor+CkpQk44k
	 /omn1+Q5MubWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 241/451] drm/tegra: rgb: Fix some error handling paths in tegra_dc_rgb_probe()
Date: Sun, 24 Mar 2024 19:08:37 -0400
Message-ID: <20240324231207.1351418-242-sashal@kernel.org>
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
index ff8fce36d2aa1..5e95943021887 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -214,26 +214,28 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
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
@@ -241,13 +243,17 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
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
 
 int tegra_dc_rgb_remove(struct tegra_dc *dc)
-- 
2.43.0


