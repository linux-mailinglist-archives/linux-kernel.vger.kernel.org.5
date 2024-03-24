Return-Path: <linux-kernel+bounces-115682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65065889707
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7A71F35ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56285209E81;
	Mon, 25 Mar 2024 02:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEdweW3U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E744F1F5;
	Sun, 24 Mar 2024 23:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321619; cv=none; b=JRu6rrxkZn/yixS1ogjsnBTqkNwWSnIkU8c7s8Rj9FflYke3HsiRKc76PFvkqTuOkdm3HvVASvw9qXg8abrMPLImbM13eGZQiT13HA6XqwpvgGwI++CAYN/0hIfBda+jxsXwaTLkCYC52ziyej2mJHS56MNp3CRPuFW+f0kYnhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321619; c=relaxed/simple;
	bh=9YW6LdzWNOFesOTNdVc3BEUt3zTKv6VZsEl6iMh03C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McE5pacMC+nC2tJ+e0arzzPUvDQCzRUYMHOI3JBZPTnBBYZ7LHaT/gs3g9d4VYOlwsGnQXCtTYfcjiYjNmlle7amybhgti3/An90wzR2eUbPGrlazjJU0RFas5tI1Bc8/1AClA2+wVOBjC1zqE89CpObqYhvBh4kzHW+6La3KsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEdweW3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57003C43394;
	Sun, 24 Mar 2024 23:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321618;
	bh=9YW6LdzWNOFesOTNdVc3BEUt3zTKv6VZsEl6iMh03C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XEdweW3UpFOoTBx9YqVL1Kzs+88BONlRygs9XedxYkcQHaValvaRvXp7vKLE/dKgl
	 2/w0DkCo6hxrIAOd540XwRB05BuANGZ+4wanwd0X0L3CXyO1Y80va+goS2thsB61Eo
	 +SoVWEfm+OiqIRyOaOzmXbZAuerqEQm5oBum6T0nIAMoREJ5vSShoRwPo44SMeF7LA
	 Sl3iVIwnKCf9QCRufGrjcsB0Aa3qQF/fEjNcmojbWbhz4ojW7c+AHClh6T/eKO2AAT
	 +WHt70ilQOphlrb9lKQD7mhcZNXRRcIaEgvDvb8iV4ap2a7vJ+DkqTG0bVsp0Hznp/
	 nU7Uc9trD1W8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 348/638] drm/tegra: rgb: Fix some error handling paths in tegra_dc_rgb_probe()
Date: Sun, 24 Mar 2024 18:56:25 -0400
Message-ID: <20240324230116.1348576-349-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 79566c9ea8ff2..dc138945f3b25 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -215,26 +215,28 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
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
@@ -242,13 +244,17 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
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


