Return-Path: <linux-kernel+bounces-113472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE7C888498
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFBE01F24671
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D2C13BC30;
	Sun, 24 Mar 2024 22:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7+d03Qb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE8B13BC15;
	Sun, 24 Mar 2024 22:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320273; cv=none; b=AoSjxLoB5cJY9cH+cGCc4TohBnNPMmBipS91o6OHTOmyYhXm8yi3mMAhRFtIWkx08KBJGyJsj2fC9iq+hvaVfFINCGWURVMot9VHC0d2LxfHxRNDuw5OjdJ3H4XXGp/v8KXc1QQXjV8CDP1ryN7vlHZQ+DtXAS2rBjZqJ2jvXb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320273; c=relaxed/simple;
	bh=sxl+ayC5rApzaa/Of515A4BlBq7f+RoQ7f0vJHU1v70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNu6D0bDvtx2edeOhn++XM/ICEbV4ZWsxJu8EJBamq4EVb3AJgzK9VVTjb/0xRosGAhFoDNehYkgdL6cbUvydEEYcYL2GfWQFXGlpkXmnynIQLsexF11q1SKTv8vDg/nv336+zzrztHfZdseK6lP/+IxVuYrqIQayhabK+ywLh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7+d03Qb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517D1C43394;
	Sun, 24 Mar 2024 22:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320273;
	bh=sxl+ayC5rApzaa/Of515A4BlBq7f+RoQ7f0vJHU1v70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E7+d03Qb7NyggebL4eEXogvvv0VUNbs2XIpaB4gbJtUWndKiBrBsJ+Vuzxm0Rm9Bc
	 +xPP0VxGkx/ufXjNCos3HTB+JRyUZeki27Bb4OeUzba7nlAAd7TBSIKgFPGxVIJamV
	 U3FcZaUQfw02PvrqDLVPimaQg5GigoFsnSzm+2ENDnUw54bYEO/dSFzRy/OlVKUYUe
	 6i43KnTdHfp+LaVOvrMvyk2dfntGATLOARGSooOhpU66KlT+FIILf1u0sWLODyosQ2
	 V8g9dN4+Q4q65AbPlOM5ksQqjilm7uVBeN+F0ZmenSQOctUw43WigofUPBBxZtuJXA
	 strKBXN+5GJvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 581/715] watchdog: starfive: Check pm_runtime_enabled() before decrementing usage counter
Date: Sun, 24 Mar 2024 18:32:40 -0400
Message-ID: <20240324223455.1342824-582-sashal@kernel.org>
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
index e28ead24c520e..df68ae4acbd7e 100644
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


