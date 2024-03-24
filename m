Return-Path: <linux-kernel+bounces-116167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C61518899FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0291F1C32CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A28A3B507B;
	Mon, 25 Mar 2024 03:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULl0YH6c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04DD282A73;
	Sun, 24 Mar 2024 23:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323741; cv=none; b=PfWgr/bE2/ul3hkWtjj467muVSkPsPnoANve8YpWVtESbuacqPZWOCU5RgNFlBdhcDkADLoly6M+i+itNbFAOJZY6NDAW/Ko8l7R6mHbjRcAJkd85cdbuShN3Lm7he15SaBSR9PghJBNVIELhK7yD3GPgM3+ecejLav0VOUrExg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323741; c=relaxed/simple;
	bh=+ZUl4XWyX2TC41ftSNhfrfsALGaw+PtYVx7wA53zQtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWP/cVuh1QHOKorZbeSvqlF847n1C6NWFvD1VBOMXziixCkMO7OBcQrFiRt7lLWKsTa0za1iG0dDwSPXqEJtfZQ/ApeBO4p8oMA5yJUItsgv2FaR2jxUSHkbM3qpbrXWyjK5CrbYJRMQIKgEQTVt3/hFji9Jq9I4VwFIZFK3tlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULl0YH6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD48C43390;
	Sun, 24 Mar 2024 23:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323741;
	bh=+ZUl4XWyX2TC41ftSNhfrfsALGaw+PtYVx7wA53zQtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ULl0YH6crH9JuJ+mzicjUUkhtWX1ZbZa3NQjRI2ustjjWNucs6n8f89xIQTn8kaiV
	 /LU1HAS4kT/D1yc7iPLTjh7uiJG/34UOy80CFV/YSIblxEOgcd5H5hbfLkvhqvzyix
	 pbGVDR2jWtpXvyYoWJYBntYBqbfUMbwSijqDq2mIVWMzkKb7FtnnyVaz1cxia/e7j/
	 wmPg6ybrXAjf+hex8e9YK2m1+BnrVykK2ECzHMnVC9mFK9+VTMz4t76qdb/TvH4KZm
	 EQ/6+PnHD7lykQFKEB7/NAYGo29EAV51J7G7mGpvFgKvp8zItEuR1ARw731Fs6gjm8
	 df814pepgPYDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 116/238] drm/tegra: dsi: Fix missing pm_runtime_disable() in the error handling path of tegra_dsi_probe()
Date: Sun, 24 Mar 2024 19:38:24 -0400
Message-ID: <20240324234027.1354210-117-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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


