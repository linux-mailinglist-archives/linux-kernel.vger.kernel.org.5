Return-Path: <linux-kernel+bounces-114399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6305F888FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB5428BB56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A135275514;
	Sun, 24 Mar 2024 23:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbiXk4Xn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EFB2197B1;
	Sun, 24 Mar 2024 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321807; cv=none; b=b2bLvKeBHss0w7PY0R8jEhxegdVlupXeK7ypz/sJFLwzPH0EFbjSDnvMcCfs+jkGMLovUexmv7MsKAbTkb/hC1jcAPKBztZUMFayHotKyQD0ANrfILxxt7oKudB+R0+/qB8/5neOflAMMJkdw6kSbSxIXDtVQECl6rb9yHnMh3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321807; c=relaxed/simple;
	bh=HRP3kp5d/QQUx83KUISyCFGfDCNtJT2pfGqFiM0BbWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuSt53Et0ebftVBW+y8khr7w4Iy245quy1rVBOlf8aAUeQ5cmtX/dt9aCcxuK0v7wfbpxH5K7zRmJIenbm8HJQUG+/S0RUVERqCsK8G/Xs68gu8b0IvYcD720z9tvfYAHCXUxyMvdoGKqG0PSoejx9kgifn0b4eU3THDkmAl/FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbiXk4Xn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75071C43390;
	Sun, 24 Mar 2024 23:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321807;
	bh=HRP3kp5d/QQUx83KUISyCFGfDCNtJT2pfGqFiM0BbWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AbiXk4XnT0dMtAZz5skhPnvopq9GY0gFjrDo7GPV8mJF6Bd+9hD+AW6akWr2alpJ2
	 4uynH8/6xZGhFA+BMaH4o/ok985azpCAuSMrOoOtiL688wDLylul69RrksVqHOWM4k
	 PJbxNVYyIp6c6MJSXqP9Kw1nfERTkShhEsq6c263kICZvNyyyoMholq6egD0B8wDYZ
	 z+oa/pTm2bIEd+TxME7ajNxeH1qd18Uu8VCFqI7+GctQM8Ws3TlRjfhPB01AHdrt0D
	 MEWy4vQy4pL0chCdW6piQCsJ/Bupy1suUNwM/NFb1AiYWbinBcwE0rHexanuem577Q
	 UNY6vkaUWwhFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 535/638] watchdog: starfive: Check pm_runtime_enabled() before decrementing usage counter
Date: Sun, 24 Mar 2024 18:59:32 -0400
Message-ID: <20240324230116.1348576-536-sashal@kernel.org>
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

From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>

[ Upstream commit 8bc22a2f1bf0f402029087fcb53130233a544fed ]

In the probe function, pm_runtime_put_sync() will fail on platform with
runtime PM disabled.
Check if runtime PM is enabled before calling pm_runtime_put_sync() to
fix it.

Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240119082722.1133024-1-jisheng.teoh@starfivetech.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/starfive-wdt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 49b38ecc092dd..e4b344db38030 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -494,8 +494,13 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_exit;
 
-	if (!early_enable)
-		pm_runtime_put_sync(&pdev->dev);
+	if (!early_enable) {
+		if (pm_runtime_enabled(&pdev->dev)) {
+			ret = pm_runtime_put_sync(&pdev->dev);
+			if (ret)
+				goto err_exit;
+		}
+	}
 
 	return 0;
 
-- 
2.43.0


