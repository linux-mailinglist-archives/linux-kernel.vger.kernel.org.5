Return-Path: <linux-kernel+bounces-113934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22933888EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B801E1F255D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE5913BAD5;
	Sun, 24 Mar 2024 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmlrELFW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D012C55B;
	Sun, 24 Mar 2024 22:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321031; cv=none; b=aLVXZiKoxwLZU5poo/IsIlRnrDqFd5ysFIBE6H7UjQEfkza+tVXFdFvwNSxoYIdfwVk0wq5NRxbEDiXemR3l8/AFD9K2N7tdB/mT9qTzcRQO+6/HWpCrCdjyikW1WQjzHR3cr4MaBcv/bcnLGRA8Zq0g3E4GxwYtJ+dA4iSqNUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321031; c=relaxed/simple;
	bh=HRP3kp5d/QQUx83KUISyCFGfDCNtJT2pfGqFiM0BbWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ld5WYUdgV3Tvl/dugVnnF4MfayL9J9z3nyExTjh812LrKj+Gz0Jtn/tMm73nVl0Mp1zxvTturgcrhzPX3U46ImitBALl7F9WQHWHeWClcJgK55joZ+dgnA9BGmFbmci1CPl/HSgo6brUkNbl9YqS+jGZ1wHvgSwVShmVmD6afgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmlrELFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EDBC43399;
	Sun, 24 Mar 2024 22:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321030;
	bh=HRP3kp5d/QQUx83KUISyCFGfDCNtJT2pfGqFiM0BbWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cmlrELFWcwS8WXyTFlSvotdPIvRcJpHjldCtS7NJHxUvWzzPwm9Fiqe9Se2EivAaU
	 1ArV7UodxmzRRGDzFzHW7HigJgivvYkAEiAoz2r/RU5JrWJNXPW+VQfkw+4XkcWPg5
	 5P6ChemHxLr3Av+bbMsDJ5gu9iL7QeSHSiiZ1C9GbLtR1z4tXHAZEhkaA3Tmx1TZOo
	 VqZjMtBK71DLhZNA2AxfQIE3JpS4RLGszCW7aA2pds8CsQNa+VOx9xBMypbP9ixfkQ
	 8DQwbUnjImKSK/PT5zQh/BjZoCD6BrFBA0va9y8gG9NDnOW/xIGUNbnKtA7IGzry6m
	 sTrB1c9cSyyfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 593/713] watchdog: starfive: Check pm_runtime_enabled() before decrementing usage counter
Date: Sun, 24 Mar 2024 18:45:19 -0400
Message-ID: <20240324224720.1345309-594-sashal@kernel.org>
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


