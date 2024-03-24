Return-Path: <linux-kernel+bounces-113175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B25CF88820E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEB41F20ECA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838A9130A49;
	Sun, 24 Mar 2024 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNTPBYQM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5A1175CBC;
	Sun, 24 Mar 2024 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319977; cv=none; b=nV+DqY/HIq2zLPKlYNatOTOJQ9SohYPqAADBoC451qe8nROlNLtSGPpLgY2iymGpvcs0X0iIJzpzJk2+zmlp5B1+t3NhtX3xh3rXCLefS6Lb/zG0+RLnplWXDAWLLdXZAEqU/5hSBjiWDOwOPqccBGrvhxkiztxLvvimpguxgJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319977; c=relaxed/simple;
	bh=bu/cLGl0Ou6FdE2ZToeEYLdGrXcfFHwS3SKibvwNMpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEWJ9f4qtqUpb9UHXoVu5Yc/p4TaTulWaN5DW1IfDb2IXPKIq9gEMSmouoZz/JiOG597sq5qWuUXqLyXVX/te2iHBkCNWsRmA7GHsBKGEhgvdPXJ60PJ1KD0gFJ/W1SgPptOSPn1qAA6bJXb9KH8lsqzHo9XG2nmlm2giBU7WWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNTPBYQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0F5C433F1;
	Sun, 24 Mar 2024 22:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319977;
	bh=bu/cLGl0Ou6FdE2ZToeEYLdGrXcfFHwS3SKibvwNMpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FNTPBYQMTlnFkH71PR6uywpdHkuifORpILvMJSvyWm3jthso0eZ87Ar3zfq55Vbuy
	 4VbdO0FXrmai3SKLaXcVVUacvw0cr8dDFSUP+Rgnb/+Wu+KLucbPub5IP1wwGCyaXi
	 awPCK/z0EolrhL8F1YPNW/EcU7sT3YrB+ueUuWIBZPBH6fDRykTU0RNV3SVhNVt99k
	 YVlEz9RFqb5qryU/quBpI5RqfLFKGUC8x4CrJE9bGvcvegCupSE4ERmSxAU5GjoM5J
	 mxTuTnDub25SuWPwjp9bIGMRpGyIsRxPk1oL2ThTM5CqmqjywG9entiYCDd9/Z5bvL
	 qkzWZnkpMBw+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 284/715] mmc: wmt-sdmmc: remove an incorrect release_mem_region() call in the .remove function
Date: Sun, 24 Mar 2024 18:27:43 -0400
Message-ID: <20240324223455.1342824-285-sashal@kernel.org>
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


