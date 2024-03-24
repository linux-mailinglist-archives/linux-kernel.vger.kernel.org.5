Return-Path: <linux-kernel+bounces-116035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73D788957C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86AF1C2FA62
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF75A180B7F;
	Mon, 25 Mar 2024 03:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9DnIyab"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF652779F4;
	Sun, 24 Mar 2024 23:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323420; cv=none; b=XBI7URaO0HjXOjFl8cW86jQg+b7fozrocVPbN/+jbAHsCxW8WR/INeRZWMSqXGYtiNhUoxC26eNPEk09eap0wso2chXiKdGncII/xm/UqXDsf66jlt6cC6FzozO5bpduVDi7Lb4NfLNKPQY8BZUh0R+O8BL+hq80sXnX5QFhmI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323420; c=relaxed/simple;
	bh=KUcareWsI1VAdK+DJxxdVOXWGUo+3jqHf8bnKxBeUQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWZL95v39Unb/YwE3LL4Cngo1AT9u3pQMzpeQHkX4Z/WKOWqfBCs0+MBqO87nli95nWNuqs0ltj0mJeNssNOR4PdzORjc5Y4M0Wb21gjOFvNrq4fyhGTsDsTOk4i85GTFbTs+1I03FDixzLp/l+K2+jCgPZxCbT/VCoOa1Z60n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9DnIyab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B09C43394;
	Sun, 24 Mar 2024 23:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323419;
	bh=KUcareWsI1VAdK+DJxxdVOXWGUo+3jqHf8bnKxBeUQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9DnIyabhLQDCpc+0PoLAF+YyzK3tS5PHPMEq9rPG46FQUfVLJg+eJSsGXNNWd4Id
	 O+lfUrdoBZqxy2IMc6lie6ZJDBUp5X+MRa9Rt4LJ2xoHAgJPbl0WUEp0V0aVWaOAlc
	 MUtFpR8OWe3c85JqrYvdNxR+E9yHwjChQUoyMQvv5krC7ADSY+spazNbnNOj4jAKhI
	 5TphNZFxQfRjThSRz92yiPGZUV2JYSEBrRqnsB4ny+8vXJMas1q8XVtv8dWaGYEzEq
	 xOxHewMykIb4viDQkHo1rFisMDdN+zEfCaZbU3f7lNiSLQ9R5nM8/SJnV2M1nHtEHq
	 6uh/2hZgEM2YA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 122/317] mmc: wmt-sdmmc: remove an incorrect release_mem_region() call in the .remove function
Date: Sun, 24 Mar 2024 19:31:42 -0400
Message-ID: <20240324233458.1352854-123-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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


