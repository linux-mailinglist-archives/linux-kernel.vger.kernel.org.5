Return-Path: <linux-kernel+bounces-115681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD5E889700
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1C829AA71
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C68A359479;
	Mon, 25 Mar 2024 02:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJFmDp0a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F299115253C;
	Sun, 24 Mar 2024 23:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321619; cv=none; b=ButPRi1YlYlYFvvwLOOf5uU2OO8sIJFVBCq5w3vbIfFy26pSKy5dFQwtoX78HG5+wic5wMUbh3zOq9c0WQnwzCtzVleX/UyxqWv7bMWcdHzqx9Rz/UGKg/yGOo7nrMphzXaAjI+tIeraaIQuBtvpccZxJZ6a2tq0iuVD+Hyz8Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321619; c=relaxed/simple;
	bh=W7L1ScmXSJNPDymey0pC5K6tKjxgdQtHutJObTe7SAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdyK6cAUuvie1WTyYNm4BDFqU6ykSheOUQaRWVhDkysvfeb7ms+W+VyVD8gyi6TDNKgzAMDNgABvtCO/7YOPzlirY1QUPSR623yHdL0HvQwM6KqdnL5jswfOMUAi4l9qW42y/RlhwQQtt1tpl/cQf7aEbzp9VEF+eCAqMx8VCM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJFmDp0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4DAC43399;
	Sun, 24 Mar 2024 23:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321618;
	bh=W7L1ScmXSJNPDymey0pC5K6tKjxgdQtHutJObTe7SAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DJFmDp0a1p9IsarY7Qq9WhE0JhEMLwNr6sL2HaNfrAAXVGVHju2Z3gKlyAbYW/dpZ
	 OXAFw8L73VbiVO/Zq2cdIf07fV/NqXDLHjYorfbxHDrD1HrTPLp37bP9keC9/308bT
	 vEMuBsPBjiaQEONz5Q0uoo1w5iNlJ9suT+qVnVelWbsA+p070YMxeiB29uVIG36AJ9
	 mKPA7MhGSLYGBtzITWxoxiKq8ei6lp8A/2EoE0g1NA15ESyqFtbioj0G4IQ8D3v87R
	 lZRKXFDz/LYGL0W5KxGdxfkqNCot/sL72n6UpP05pBE/APO9V2Hio6CFMbm8UZS7Ye
	 +CeA0138LDUQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 349/638] drm/tegra: rgb: Fix missing clk_put() in the error handling paths of tegra_dc_rgb_probe()
Date: Sun, 24 Mar 2024 18:56:26 -0400
Message-ID: <20240324230116.1348576-350-sashal@kernel.org>
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
index dc138945f3b25..d6424abd3c45d 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -244,7 +244,7 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 		if (IS_ERR(rgb->pll_d2_out0)) {
 			err = PTR_ERR(rgb->pll_d2_out0);
 			dev_err(dc->dev, "failed to get pll_d2_out0: %d\n", err);
-			goto remove;
+			goto put_pll;
 		}
 	}
 
@@ -252,6 +252,8 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 
 	return 0;
 
+put_pll:
+	clk_put(rgb->pll_d_out0);
 remove:
 	tegra_output_remove(&rgb->output);
 	return err;
-- 
2.43.0


