Return-Path: <linux-kernel+bounces-114812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C9788916F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032F81F2D1AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD25272EE5;
	Mon, 25 Mar 2024 00:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8MUZN29"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42624176A05;
	Sun, 24 Mar 2024 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323460; cv=none; b=VTST10euaBNfxB+dPa8eucWmFYEX9qSJ2fQUz3XfpH4jeSFyjad4gUr9AHPKV+aozcYJ4hPrzLhRIPcqDXRgch3jDdfnmaQv+ltYswRlDuGp27UO9bpfW4t+ZKgS0H5iCWp3CpnHkiNW2ynuiwdRe8dc/oIoQdHiroAmmEkhLmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323460; c=relaxed/simple;
	bh=nmiQo8635M06RUm0k8y5Xa3XkmqRvGP+aSZCULyn0uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCMfx8vOsZD9AfIoFttBEhaVjyRno2Lkg5fVCwNruHPhA8FXHpJ0aaXuyD3SVxBXnF1j3IbxYTsnwCYrPoCXwHMPaEyUAwnFucc8ksKSS/TXAieKXzgOUxYx24N76YuxauofqNytKVKbR/71YLe3h3ZzFfU1dH0MsrvR4vfzND8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8MUZN29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868D0C433C7;
	Sun, 24 Mar 2024 23:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323459;
	bh=nmiQo8635M06RUm0k8y5Xa3XkmqRvGP+aSZCULyn0uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F8MUZN29FLTlcE8/LD8VUxOxEHd/LepQiuV3JCxn+5s7afOZkAgfHHmwQ92DftEik
	 9Hbn8qgpNT/vohIa79ue0nppi9oaz/jH0cO6poMEKiYDjQhQRm8OTnQyKJC0Tnd+fh
	 4CV9Ck7kWZnu04fh4RgPULYdL8CNVwDGrlHDFxsYSLVZD/2y/y0uqsIp2r9kpT+3Xg
	 Ld0yNL4xAe80P0YASCOkifugHe1BdWp2ZA9Vwt7fY9Os0sRCwyzFPuXEeBssQ+IKmN
	 CJvVtKn1Qq8bJl1znz1UWIcBASZ6jAiBHSnn1KOneevp099BHohCHW1JRi/DN3ukka
	 G4OjoX7u9znjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 163/317] drm/tegra: rgb: Fix some error handling paths in tegra_dc_rgb_probe()
Date: Sun, 24 Mar 2024 19:32:23 -0400
Message-ID: <20240324233458.1352854-164-sashal@kernel.org>
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
index a84aee2f4acd0..51144faa70f7c 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -218,26 +218,28 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
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
@@ -245,13 +247,17 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
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


