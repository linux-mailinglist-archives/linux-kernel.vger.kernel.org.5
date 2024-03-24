Return-Path: <linux-kernel+bounces-116265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEF5889DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE18296D25
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D37294E2B;
	Mon, 25 Mar 2024 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRe29KFx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAF928A5B1;
	Sun, 24 Mar 2024 23:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324066; cv=none; b=E9UARtYUfrQAwx5cCXA2l6kOIPwltMzebOQxpkuxWKLEWWV4OMueY8WSOwFNq3Z/6CxIV6vEvRSYkK2hYoUY5QHOxUjZrxFMkXIsmcDr/SPA1bjAlA0Ou4htepB6ySmW5B2bIETuaPwH6k4+zNd5XKF2eaDeonabaBAmJ8gsIqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324066; c=relaxed/simple;
	bh=q4FQbdmsrgd2cVAnEuk372EhOMMJ2c0RE9ooJVL7GqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4dcEmfipiAubc5Cu6UmGzH2yhvyg7L5P0q68vBlCqtBOwTcM3rGDJrBvf9+hn3kAIhzGAno+GcSU/jQ6gNMQbrX8ymq6FumI/y4Y1x1tE6q9wWcScPjEdc8X3A05cN9VbBhG5RzUyr1d4k5SZjJEQmKAymY9hMw7hCYb7xq0Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRe29KFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9887EC433C7;
	Sun, 24 Mar 2024 23:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324065;
	bh=q4FQbdmsrgd2cVAnEuk372EhOMMJ2c0RE9ooJVL7GqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iRe29KFxOM8jxyK9DjB6QFl49+369nkQy68+Wq03TPtSQ0AfkAeVi6AesZLA97sGo
	 1kK+dFLnkFIb9IlSPH0CgqxbAxgYtK5kQn9VjM8tjBeVFJUc9qKg2o5G6dva5kyZm5
	 SqZ40FyvoHnuXzFpRh1W03cqGOFWmeokCOz49eyitqIYNRzKz0fZlDfZENDr/rMGR/
	 uDMh5GnabwBMrgr6a0IO2S4Z7korwQIzaLBQJNO4EbnJrexroZivwP9eOkHij0XgKs
	 +Sdzg9HiBnb7DFY34fbZEG2r19C8tLeto2TQIzn/Qogm8N9iU6cQKq+7nlQIA4yeDZ
	 aGGVAjZ027mIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 066/183] mmc: wmt-sdmmc: remove an incorrect release_mem_region() call in the .remove function
Date: Sun, 24 Mar 2024 19:44:39 -0400
Message-ID: <20240324234638.1355609-67-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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

[ Upstream commit ae5004a40a262d329039b99b62bd3fe7645b66ad ]

This looks strange to call release_mem_region() in a remove function
without any request_mem_region() in the probe or "struct resource"
somewhere.

So remove the corresponding code.

Fixes: 3a96dff0f828 ("mmc: SD/MMC Host Controller for Wondermedia WM8505/WM8650")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/bb0bb1ed1e18de55e8c0547625bde271e64b8c31.1708983064.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/wmt-sdmmc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index b1e4199f82920..345b3c50f27dd 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -889,7 +889,6 @@ static int wmt_mci_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
 	struct wmt_mci_priv *priv;
-	struct resource *res;
 	u32 reg_tmp;
 
 	mmc = platform_get_drvdata(pdev);
@@ -917,9 +916,6 @@ static int wmt_mci_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->clk_sdmmc);
 	clk_put(priv->clk_sdmmc);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
 	mmc_free_host(mmc);
 
 	dev_info(&pdev->dev, "WMT MCI device removed\n");
-- 
2.43.0


