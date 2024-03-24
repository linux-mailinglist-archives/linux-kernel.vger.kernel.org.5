Return-Path: <linux-kernel+bounces-114533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E226888ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1879A283A73
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB381836EA;
	Sun, 24 Mar 2024 23:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fi3tue/m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3205915B570;
	Sun, 24 Mar 2024 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322165; cv=none; b=noHklylFeR7dvazbZuIWbkruGuhegrJZnaVsexba/4D1MvBkKNNQO2/E9+/7R+tj+KkdG0NOF83wsgOri5yy95VaXIghh2m+UJJe3vhYN5wcJC4YePf3TCvcqXulK9lkvOYhfJQdnryg4IdfWPNbUvrWkhjSMKUPDhKsloitSrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322165; c=relaxed/simple;
	bh=/hySMTje0KdM8jrGPtDtH45UETmUw/LTri087z+nxv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l77xH00lLU18zA368GEy9vVwiZWJXxLcd6ObeX6lOig10BsaZvp9hIIieMHoWnFDXBweiMnteRbs+1oKbtFU6IWSLWN/CBOyFEn7/7Lc1PagT03MctdO9O45d29u9RGVumMDd1E6Zh6Bhf8ZOBAi07bzS8qUBpLEM+cv0YOetRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fi3tue/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3D7C43390;
	Sun, 24 Mar 2024 23:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322164;
	bh=/hySMTje0KdM8jrGPtDtH45UETmUw/LTri087z+nxv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fi3tue/mVMBI+vuBw+f/vkyb6+ANVNt5+GLOP+Ja+CxPkNmZErQozsexuio5Mm3hS
	 oySFa8ocUqWLCezTsVlW1jXvUXx9C01DOLvF0F7O8Q86Ckh0kLhwpWsDTTwytgy3Cf
	 sff3bRGwk7lM3f1k7vq2p1s5k1gXZZ6gb9HuucPnFrHQ+27aMetrjvqKoqKqn/sG09
	 9aOs2cLtf8OqNuJOdJ1wV2T2xs2oiM//TlQkFV+LWUvEC806gsOHixfiLk32ehM9L7
	 7VrdDiNOHrvCGFTXO4KRg15cOaSeH+rTWz78+JbF+aCjxfxobDnCcAKNOZPxyUh3+U
	 tE/tzl8HLhl4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 242/451] drm/tegra: rgb: Fix missing clk_put() in the error handling paths of tegra_dc_rgb_probe()
Date: Sun, 24 Mar 2024 19:08:38 -0400
Message-ID: <20240324231207.1351418-243-sashal@kernel.org>
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

[ Upstream commit 45c8034db47842b25a3ab6139d71e13b4e67b9b3 ]

If clk_get_sys(..., "pll_d2_out0") fails, the clk_get_sys() call must be
undone.

Add the missing clk_put and a new 'put_pll_d_out0' label in the error
handling path, and use it.

Fixes: 0c921b6d4ba0 ("drm/tegra: dc: rgb: Allow changing PLLD rate on Tegra30+")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/0182895ead4e4730426616b0d9995954c960b634.1693667005.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/rgb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index 5e95943021887..86e55e5d12b39 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -243,7 +243,7 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 		if (IS_ERR(rgb->pll_d2_out0)) {
 			err = PTR_ERR(rgb->pll_d2_out0);
 			dev_err(dc->dev, "failed to get pll_d2_out0: %d\n", err);
-			goto remove;
+			goto put_pll;
 		}
 	}
 
@@ -251,6 +251,8 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 
 	return 0;
 
+put_pll:
+	clk_put(rgb->pll_d_out0);
 remove:
 	tegra_output_remove(&rgb->output);
 	return err;
-- 
2.43.0


