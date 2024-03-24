Return-Path: <linux-kernel+bounces-115916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C40088898A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00AB41C3128B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19F538A95F;
	Mon, 25 Mar 2024 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jET9BDOG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBC11487E5;
	Sun, 24 Mar 2024 23:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322113; cv=none; b=KG40Gm2La6NnDWnsN/JKfrFSs9u7RsspnDX13ats+w3uhJdYkeQNiqOXlKnfKgflhXC1GHXuXpEnoP89y9joE3Z8jc/vsDhle0XTg0lwdI7r2orykB4iPJUnFuW5/K4odLCyOb1VMuwoKItYSAPgCBhOObcvgdfzIQbubu/0Ujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322113; c=relaxed/simple;
	bh=tIcxQzNmFWHotMJD6l4C8jJZ1FEs83u8EzsH84cKWSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhBUFFeY7Hw5wsq0ZZ5XtCp+ERCxzAXtcuNiRWhRk9T+p4lxFX4H/0PCgle200v40kAAHLCBJZz8/5c87IFx1yoqMDZ47Vs/MeDBMpWnM5rmyhrt2Zye6aaTsFLU1luyNFCUsilSKL4nXMkTBe4FuSxq88VHzivvRzBb0AUJChM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jET9BDOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC84C43390;
	Sun, 24 Mar 2024 23:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322112;
	bh=tIcxQzNmFWHotMJD6l4C8jJZ1FEs83u8EzsH84cKWSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jET9BDOGuqMrfOpa/zEqxGPj5/vnBHm+U4OKrk70RwOaiExc/T2t6Nr8fOZ3JlnhJ
	 jGqrgZf8gOrLW0ac9lA0hrQ7JPfSEsndBhHXDPZ56euRhjKc7qWNOsFmhEBQ5YorUV
	 QR3oa+ym0XzL7jgbQCTB5mzgL9kGiWzpW3NYtE8nETSXdANNbe1BTV+3s9hbB0Cw9l
	 OfYkswP/Azz/9C3n9eE9jxuHVhhI8TK8kBvpQuK0VNOQLUlIFHZvSNtQW75fNe+mX8
	 EFWcxYmD2tnQ9O7j2UVA7ZatFi+9bqekxyHiW26IZilknZ+PnLgH+CmjyONwpoxtI1
	 lxQS4aaYDrShQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 187/451] mmc: wmt-sdmmc: remove an incorrect release_mem_region() call in the .remove function
Date: Sun, 24 Mar 2024 19:07:43 -0400
Message-ID: <20240324231207.1351418-188-sashal@kernel.org>
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
index 9aa3027ca25e4..f2abebb2d8574 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -886,7 +886,6 @@ static int wmt_mci_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
 	struct wmt_mci_priv *priv;
-	struct resource *res;
 	u32 reg_tmp;
 
 	mmc = platform_get_drvdata(pdev);
@@ -914,9 +913,6 @@ static int wmt_mci_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->clk_sdmmc);
 	clk_put(priv->clk_sdmmc);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
 	mmc_free_host(mmc);
 
 	dev_info(&pdev->dev, "WMT MCI device removed\n");
-- 
2.43.0


