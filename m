Return-Path: <linux-kernel+bounces-113246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF79888829B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F96282B07
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6484F18636A;
	Sun, 24 Mar 2024 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyyJcj0E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DC713C9D0;
	Sun, 24 Mar 2024 22:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320046; cv=none; b=QXnHaTGaYPCnUlsT3v0u9fVtCBs14ITxpAwyxnrCYcfGAYfFekDpV25TXNRUcT9htEm8E6L/0jB4zq0Jm2dXnmhl9fzSGiS9K7tsIriMAtsJ8mq9QVE0kqOC3MXAgf1AJZOQzKFVU8nOj8fIcXdilE1kxgyuQHp3fkimWMTeW4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320046; c=relaxed/simple;
	bh=+vKf/AD+EU5ShwD9w5bCge7Hc87d+rNN8o9xeCJe6BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lP5PyN0nDNQepbkracX/si1tEO/WLQkh3BjLLRtbAdv3isVs3yVhQRm1nMWpX1LtAQ/0uG8N96ACjhsbQ/Tvj81l1PaV/Muj9A9Vo0yTlxPy2RfGGrPRpzMG1FgBYB+/V/DT/APT7oM952SqVzVeniMKHJlHotdhBY5YcvA0mQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyyJcj0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE58C433C7;
	Sun, 24 Mar 2024 22:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320046;
	bh=+vKf/AD+EU5ShwD9w5bCge7Hc87d+rNN8o9xeCJe6BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jyyJcj0E3jCPCdvdCnzFmTJ8rmf1rLKX7r7SdFRXcif3esiDtcP77n47APsczLFRZ
	 KboKzx5ZV/pyMjzZHDytmLGOJY5TeOI5cbte9/ZZ3u7l6UvxQUUSuISlXwnJ7igjwI
	 0y1SCmeyzvlH1hQawzRl2/s7mhhBDdhv/80eouEKFM3TpNlu6KWnwEPenjBEOuuB/e
	 ixuQI/UMh5v+YsWzIdn+oHPJuslIK8pjrQztnXfaWd1fu4B7NoOU4pjxXx51LNtn1R
	 aaMusXO+vS1uyeLSl9egaMKOvD+KyY2L+t+XUkCCi09Awob5mhMJv3bcV3MK9KfZfP
	 2OyhBqhU71OEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 355/715] drm/tegra: rgb: Fix some error handling paths in tegra_dc_rgb_probe()
Date: Sun, 24 Mar 2024 18:28:54 -0400
Message-ID: <20240324223455.1342824-356-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


