Return-Path: <linux-kernel+bounces-113247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB19088829E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287351C22C8A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29780186389;
	Sun, 24 Mar 2024 22:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daOJDXd1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C50186369;
	Sun, 24 Mar 2024 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320047; cv=none; b=l9FWXMq1WxodpiH7QNnsfAPk6gY6heTrWsqcIo4NcNEwuTcYgtYvTKkUJIsKMY20WEZsa63VfDKmmcXRtOI80vYj017W2dp7VaiW7/IzPP3Bxsz3TKfy1GDO4U30J7NlNndT1/ymUZuUdt3EXCvocdW7KieGJ8YsHldq64DtHro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320047; c=relaxed/simple;
	bh=xx4kwvzAxT8EfZAIHWdVzcLqTUvuj8Q6VMgCYvPhFCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9TXAYAWdzaDo1HRJKgCDd8Y5oK/AA7PK7wvJtmNSHnvqFNBZctXOCZw/pvXdAF66suU3ZknHd+t9U/KiPwmSECJxCOPTX9LixIw+XavsWxsKlbSEfYha8k6eMvfrSk11ZLmDo4eiUuLF/QwP+GmBFsuogJzRZh83UBOTyu3L1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daOJDXd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92386C43399;
	Sun, 24 Mar 2024 22:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320047;
	bh=xx4kwvzAxT8EfZAIHWdVzcLqTUvuj8Q6VMgCYvPhFCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=daOJDXd1iuIFaWsMejSfVa/IHTgpxF/5N+zjT6E20WQ2uWh2SCDQmRisy9n6FL+ae
	 MSYoyXiJsS0NNOlETu3aZpV+tiOOi7AaQvMAvY+3ggMau8xgNqWBND4BjkjGxnsHej
	 3AMC2GcW972quryjLnUpzAG3s9VsdfnZtgsTflRNuIRnEqHUEo8F/fXnIcpgHyqEvW
	 fbjxzl4crwdESLms9zqHi9K0fvqjcU5bj07gb/mtDWxQowrl7jP/OvYzad3dk4DgkV
	 3UwW1PfyHI2VE9OyxtxpKCSwBANA+lk1HOeadydH6O6XKYdxkRN2gYs6cG/aLej9Kv
	 YGwKWHFBkUrwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 356/715] drm/tegra: rgb: Fix missing clk_put() in the error handling paths of tegra_dc_rgb_probe()
Date: Sun, 24 Mar 2024 18:28:55 -0400
Message-ID: <20240324223455.1342824-357-sashal@kernel.org>
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
index 53c492b13d129..1e8ec50b759e4 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -254,7 +254,7 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 		if (IS_ERR(rgb->pll_d2_out0)) {
 			err = PTR_ERR(rgb->pll_d2_out0);
 			dev_err(dc->dev, "failed to get pll_d2_out0: %d\n", err);
-			goto remove;
+			goto put_pll;
 		}
 	}
 
@@ -262,6 +262,8 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 
 	return 0;
 
+put_pll:
+	clk_put(rgb->pll_d_out0);
 remove:
 	tegra_output_remove(&rgb->output);
 	return err;
-- 
2.43.0


