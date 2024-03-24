Return-Path: <linux-kernel+bounces-114813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660A788916D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4671F2D428
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DB4272EDD;
	Mon, 25 Mar 2024 00:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+Jha7h9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB42176FA2;
	Sun, 24 Mar 2024 23:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323461; cv=none; b=dPkGkGnYe4bKJ6EXVujBa0IFmi9Cc3ecqYtTf8Z+tvYd/pMM0tOFfyaGzPI4mPqG95h1K3AInS/91cMyPTc2bY8Wm6tojcjg2IVHxvHMQEXq22n8SAKuYOj5/cQlXDtkmSZSampqJ6M/SNQouS+J3uRtQPNowodZVMABPQfjGtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323461; c=relaxed/simple;
	bh=novvVt+pPZ8rajFosPV9cqEMRBRNxEmT12M7Vj+80tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYbtpkujuZwvlQ5RbzKidgREs4vaURQE4lLrMkmJC/50GL9jTK5IIKdIr+hsNlQPR4irWKFIWEyQ2+tG0vgeJv0cDPKKD2g1Mh2/i3xb//YunKjjST0tcL7EXckdQLN6srWNJrKrYuSWqWVclzncb+C/bChUtKcIx8N3Xn1mS0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+Jha7h9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67449C43390;
	Sun, 24 Mar 2024 23:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323460;
	bh=novvVt+pPZ8rajFosPV9cqEMRBRNxEmT12M7Vj+80tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I+Jha7h9ZBNtNhGy8RNjIcnyc1RScpfcQ+SVWGdirrEXC6Hz6VC2cUHWDHYKs689C
	 y/I0SjOm0NdHAwEQaujW8QmQy7X9lhSTajXuVTVU9gECDAyKjEDQ+AOrCFt+b5KUza
	 qin0IS1agOkYwoqL+kAQ6U+NXEi7wj0YzekYQaU0T+ZzhFhO6O8XI3xvxst+2MKaNY
	 XyyWWPNmDYdcU0no3YRFhZaXAFiKwglr3ymPz+1GBwFY3hesJs8QEY03W6uLhPnsnV
	 tdFEsI89TLidZhtPy9eqQrbQNU/yyETFeAW0brOJTzYwmPF8kgtwzTmrZCWUPERxOU
	 sUZTHZ9TyjEAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 164/317] drm/tegra: rgb: Fix missing clk_put() in the error handling paths of tegra_dc_rgb_probe()
Date: Sun, 24 Mar 2024 19:32:24 -0400
Message-ID: <20240324233458.1352854-165-sashal@kernel.org>
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
index 51144faa70f7c..761cfd49c4876 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -247,7 +247,7 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 		if (IS_ERR(rgb->pll_d2_out0)) {
 			err = PTR_ERR(rgb->pll_d2_out0);
 			dev_err(dc->dev, "failed to get pll_d2_out0: %d\n", err);
-			goto remove;
+			goto put_pll;
 		}
 	}
 
@@ -255,6 +255,8 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 
 	return 0;
 
+put_pll:
+	clk_put(rgb->pll_d_out0);
 remove:
 	tegra_output_remove(&rgb->output);
 	return err;
-- 
2.43.0


