Return-Path: <linux-kernel+bounces-116149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B83C98899A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9DB91C32A71
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE662822C8;
	Mon, 25 Mar 2024 03:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGk4JSE6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84401311AC;
	Sun, 24 Mar 2024 23:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323707; cv=none; b=Js4uBBwhOoI9JzwVSiWAGy6ZdR4pO70alZ8MOd3wSR7pH8pYmtZulaH53mR7CvHjIvxKS4CZY8JkRSTZh27RiykuldXA6F7ETiJVJCFgvUxjku6NMixVo9+EDeyYUbQjt6odVGd9cFMdm5Qox5nqepxbXISTMSDNRFNASPsJ1b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323707; c=relaxed/simple;
	bh=KUcareWsI1VAdK+DJxxdVOXWGUo+3jqHf8bnKxBeUQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VU+gZUMlvdZ9rQKXeMXx6qzQ6VtJGg+aarG+lIJxBng2YyTeZZLmJUcFgQ9nvjSpYfP+wuOsHlVN45oVKR3n/F5u8QkOtCw/UCna5w4j9rxrQf2cVwjRup5DDGo21jMa9DBeXB3lO9hF0DMeCmqMaOYIidm3EiV1avjJhU2lyqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGk4JSE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331F7C43390;
	Sun, 24 Mar 2024 23:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323706;
	bh=KUcareWsI1VAdK+DJxxdVOXWGUo+3jqHf8bnKxBeUQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jGk4JSE6t7kdHOsqtrN/mMucydP3Lip1ZycXFd/v3kS+TlyC7z20GPN8VBkP8g+xM
	 17ySZ3rz9l16TJhlWa0SZ3AgF8GdKcs6DlgYRTxoH+fToL4kjzCFCcX/DSW2WUzxil
	 atd+U0OJQIGjsLLs6QJCNwga5YDOhdXSgPPWcBQ3Gz7IfOF+9iEDt4ikFDa4Ac/9px
	 DhOi3pWTCpAN03tRlwk05LQaW5Ty69q5I8McXHy7y7d/92oI4AWwSNQuOcxfP6arBt
	 E+3ifZg3FyotihDSSxFfAhKhtooomGF8KwkHRD57/qrseTXAC+iFwdCdAlnFK+mrVF
	 jDTN8XvK/H6dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 080/238] mmc: wmt-sdmmc: remove an incorrect release_mem_region() call in the .remove function
Date: Sun, 24 Mar 2024 19:37:48 -0400
Message-ID: <20240324234027.1354210-81-sashal@kernel.org>
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
index 3933195488575..3fcc81e48ad66 100644
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


