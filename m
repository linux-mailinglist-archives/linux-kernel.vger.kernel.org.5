Return-Path: <linux-kernel+bounces-115942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F23889CD3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F90BB363B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E335438EF59;
	Mon, 25 Mar 2024 03:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEMDe3NF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAFB15B54D;
	Sun, 24 Mar 2024 23:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322161; cv=none; b=dylrF/M3I/6sD5Rbllv4XPoFXLzLhaKbRk+dzSGcC4RUJxU6Ppfy93wWOIrP+bXgA7rHeVHoZSO3LOB93rbkjIcOTdhb/WYSM7cPqZT+g02DtqvpAmh880A5tALjFsUhg9Ek99DjZkz/7d40GfsadR6hMNKc6z8S+z1sYP7I4iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322161; c=relaxed/simple;
	bh=+ZUl4XWyX2TC41ftSNhfrfsALGaw+PtYVx7wA53zQtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usMN10OyYpr3su+/hAHfySSbI4kEe/oOANqnehFuDHOHhKsgyoyoIRYy8DwKQWCOJrFMpFZfAVdm/BtFRsArFdjGNEhwREaOqWU/MtqFrBiZi5bl9N3NoY9eYt3WW/PSDpBRQ8YbJxLGXR/0VIsKkWKgFHXSqzqGTMv4+bwqFnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEMDe3NF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBACAC433F1;
	Sun, 24 Mar 2024 23:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322160;
	bh=+ZUl4XWyX2TC41ftSNhfrfsALGaw+PtYVx7wA53zQtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gEMDe3NFK33Ebmv4j7CYms3gSESiPoRC4WT8G4S+nupsq34vimJPNzX6GLsMfSCiY
	 ty0jLHjlGm6L0hg74g4THf4jK2xPCSVf9TClYh4DjhEVi9Mlz6bCQnwPYbgax/Krpd
	 SKWpaVFF7ygF52t2EFF2e1wBiH5jPjeViV1K1PhAsFQTfKj+fP+iiSlxDZyer5bnRr
	 y2Moa+3iGsJBUsTbtuEZrBZp+OvjlGZ5XgR7S2BE2mMmMVgkDgk7Pz/nzQ44u92xGi
	 I71vdJHPSE/oHtjdaIo8DQ4qQRQuj/Cjc9Z5V4/74PGPSvcim50oiwcxVgZiUZGnbz
	 bkGcel4LgzM6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 238/451] drm/tegra: dsi: Fix missing pm_runtime_disable() in the error handling path of tegra_dsi_probe()
Date: Sun, 24 Mar 2024 19:08:34 -0400
Message-ID: <20240324231207.1351418-239-sashal@kernel.org>
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

[ Upstream commit 5286a9fc280c45b6b307ee1b07f7a997e042252c ]

If an error occurs after calling pm_runtime_enable(), pm_runtime_disable()
should be called as already done in the remove function.

Fixes: ef8187d75265 ("drm/tegra: dsi: Implement runtime PM")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/ee4a15c9cd4b574a55cd67c30d2411239ba2cee9.1693667005.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index 815e32e05f600..7bb26655cb3cc 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1665,6 +1665,7 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 	return 0;
 
 unregister:
+	pm_runtime_disable(&pdev->dev);
 	mipi_dsi_host_unregister(&dsi->host);
 mipi_free:
 	tegra_mipi_free(dsi->mipi);
-- 
2.43.0


