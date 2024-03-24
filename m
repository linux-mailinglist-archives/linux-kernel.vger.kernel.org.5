Return-Path: <linux-kernel+bounces-113762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B8E888676
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4301C25872
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B64F12D1E4;
	Sun, 24 Mar 2024 22:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZeE0Esa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D761E0E4C;
	Sun, 24 Mar 2024 22:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320769; cv=none; b=WXOGMuY0aDUxzin82MmXGCgv6a5OdIgOS/jE78dnsYSzcB1SCW7hYbmmDaGt2Pd0XbSzTtk8kMOkW57WP5bW6tZfu/4nGEFTiq8yrpQ8n2j3YToCQ/FAlz2TI39Q25uXYUNoFZUF92DhHCDI15yTHvLUiKzLYPBr3QwJNMoCk+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320769; c=relaxed/simple;
	bh=bu/cLGl0Ou6FdE2ZToeEYLdGrXcfFHwS3SKibvwNMpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9KcsYdeIwM2mEnX0wtkxVhaSfr911TMF/gvS9SsQRWltPhFWtpvQ9dLEJ4HT7CS1+ndIG29gQckuKV36Za+GEYK/bwxq54iBZSp+Heb8m+Rtaqo07VPyo04XZfkhW0OLNjxrDB4aYMtXh4jIHikk1dUjvLClfbhiGVCXTYD4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZeE0Esa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C8EC433C7;
	Sun, 24 Mar 2024 22:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320768;
	bh=bu/cLGl0Ou6FdE2ZToeEYLdGrXcfFHwS3SKibvwNMpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WZeE0Esam30q83VhVPet4u2JrRWJEdrBDQ44jQfpzX9luzq0pDGWtR+QxI1nVSYK4
	 56WtL/VkoXspyKvB2AxJN86JVg8Ai2DdWclDv4ktDDpJGeqwA+5tVs7VHFBT68hSRn
	 irV2op3JeyXnQvgOnbzNcNmuwedYV8PVIhj1BRMMjNmFSjeev42CPF+CkVq67bWWjq
	 07Syogbt0J9ql/Thwgo8lUuy04zwMAwB9XyonvWJzKOgiuf9VAfmHjKKrnyvhR4m6S
	 /bUgvXHIWQ05CTx6iwBkVr2tfqvNNmH4DhGETbbIL8N8kU//j/82IQ4YTAst8fW2Yq
	 v5Jz4AlBd/szw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 332/713] mmc: wmt-sdmmc: remove an incorrect release_mem_region() call in the .remove function
Date: Sun, 24 Mar 2024 18:40:58 -0400
Message-ID: <20240324224720.1345309-333-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


