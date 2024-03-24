Return-Path: <linux-kernel+bounces-115662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C46E889D20
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEE21C34BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AE3353BD6;
	Mon, 25 Mar 2024 02:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WM5ecH68"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3D02092F3;
	Sun, 24 Mar 2024 23:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321558; cv=none; b=VODCXHvGDpdo2AdNYn+fgFupfR+bqJFHkwmhs0r0xYoat+1NBYHk15yGLBmnbSUVEpgOFlj6YofCzfTVl9Ht/ipFmylNjUGhTagrUr1jGc2m25N/iegZd3wqugaOoGVl5hOR+mLGQWdg3N5e5ge8c7sRG34Ojs30MZWYPPdC1ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321558; c=relaxed/simple;
	bh=bu/cLGl0Ou6FdE2ZToeEYLdGrXcfFHwS3SKibvwNMpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+fdq+xbgnibbqaAvywRJTWgrI56z9D9nZZckkEk5vp0/g0Q0gRKj9gGSxgiJ+Pn3yQOxwbWcauArbWb7peh8ABLA3E8xyhZykK4Dy/8CHUrsQPhfUpg6tGQDDYc+0AyOQrEvLg0zKN/jCrFZJtOLN2udJhlxYn6PT+/CPvl1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WM5ecH68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D15DC43399;
	Sun, 24 Mar 2024 23:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321558;
	bh=bu/cLGl0Ou6FdE2ZToeEYLdGrXcfFHwS3SKibvwNMpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WM5ecH68BA8uuta57TM/JFlw1zrtXDDDBruDBj6tEkmfSemwu3j0zFl+uweYuha+6
	 gMO1J1LbhJqXY1lLSP1P7S87OF5ilg20+9SDP6gYHSm4KVYgBu/pQYAxTDMh6cUj8v
	 OoqCg5h1lHErsVsY50dmfUoNO+d8A3SKZm/9WUGB4tDtJYXvq3eEQvzUibQ01wn9n/
	 Gl3yMmUsVN952SNRoMYwLmjmMEKMHKUwfSxpWtzR5tib6YVUXBJ7lKTqHiCVtwDxR+
	 BBIP6x1pkQbQjxUnEcRRe02JhUxHXqQKQ7bWlG7l/uLIg3Y6hBYb3wb1lIMlb2Lv+y
	 glXQojJuvMTrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 287/638] mmc: wmt-sdmmc: remove an incorrect release_mem_region() call in the .remove function
Date: Sun, 24 Mar 2024 18:55:24 -0400
Message-ID: <20240324230116.1348576-288-sashal@kernel.org>
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
index 77d5f1d244899..860380931b6cd 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -883,7 +883,6 @@ static void wmt_mci_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
 	struct wmt_mci_priv *priv;
-	struct resource *res;
 	u32 reg_tmp;
 
 	mmc = platform_get_drvdata(pdev);
@@ -911,9 +910,6 @@ static void wmt_mci_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->clk_sdmmc);
 	clk_put(priv->clk_sdmmc);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
 	mmc_free_host(mmc);
 
 	dev_info(&pdev->dev, "WMT MCI device removed\n");
-- 
2.43.0


