Return-Path: <linux-kernel+bounces-115197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E15888DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C456F2963C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAE01CAC9B;
	Mon, 25 Mar 2024 01:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb3Qejsa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942B1184413;
	Sun, 24 Mar 2024 23:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324271; cv=none; b=ZPu1ECxOm0wPJa6HO3l7F6B1DzZRR2/4zXLbNgmSq9rANdAeRV9nuo7rl8OVOercB9Zk2tnlv/p1iU6VmBwOuOZWCrjSxSDCWx7S8JR4dfTSHwEMp66l7/ajsV0VmOTkE+8GC6jA+4X6JKAe2X26N3Z6fo868r5u0KvqJMu5FPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324271; c=relaxed/simple;
	bh=l485m+fXhDkUqfuTzwl2ig3RmXGGE0NcaQlA0aG6S9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6N28gBUEXVL6Jnv8d3zV9fwLvu6Kl1Yx2Faz8fHxcvyOIMmalAOoFSJeuLgW4ry/J/8QJpThcbWNy6JUGjpGql5RDohr9Zi80lupKHxtTXI0R5i0peile7nJUh9x+J5DScgqZ9/0dJqohXcYjsVQwIi3OFWKxpqVeaOjuS5Z7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb3Qejsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246E4C433F1;
	Sun, 24 Mar 2024 23:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324270;
	bh=l485m+fXhDkUqfuTzwl2ig3RmXGGE0NcaQlA0aG6S9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tb3Qejsa95dADAMb10dLLs1zfAa59nc7MXJT/ooUOIuxFKHZF+wgnb0VMsQP4AdvT
	 4W+Y+r2imPhIzA5cFyEWLQvu4D9ymGM7hreWP5Opv5eBfq0IOnT1h3sV0g9UNrX04P
	 kZvmtmcAUtzFgGZ1ACQqA1QHg0qS0myUcPvpiwamX/RT9X4cyjB8/QXNHs3eVGNtpc
	 Ru3EHZD1IONGG/FsIWSTKNEnVfpT+dRiqRrjrM7zZDkm3WMYeUEwC1yVnfzsuI7qnB
	 fQXV7GLk7anmVtq8s7qxI+r/xd1HN+Sy4yv0macp/Al4ZqfAeLRdtCyrSxVbuhiUN+
	 Ne94rP3dRz5Bg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 049/148] mmc: wmt-sdmmc: remove an incorrect release_mem_region() call in the .remove function
Date: Sun, 24 Mar 2024 19:48:33 -0400
Message-ID: <20240324235012.1356413-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index a132bc822b5c6..b6369bfd64fd5 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -893,7 +893,6 @@ static int wmt_mci_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
 	struct wmt_mci_priv *priv;
-	struct resource *res;
 	u32 reg_tmp;
 
 	mmc = platform_get_drvdata(pdev);
@@ -921,9 +920,6 @@ static int wmt_mci_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->clk_sdmmc);
 	clk_put(priv->clk_sdmmc);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
 	mmc_free_host(mmc);
 
 	dev_info(&pdev->dev, "WMT MCI device removed\n");
-- 
2.43.0


