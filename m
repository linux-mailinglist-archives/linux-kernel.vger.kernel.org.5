Return-Path: <linux-kernel+bounces-33377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF3C8368F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F241C21074
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392866EB47;
	Mon, 22 Jan 2024 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zy1CEj6d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6B56E2D7;
	Mon, 22 Jan 2024 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936038; cv=none; b=sMoVHctdMHs3JJh7fixFWg1Hn1Xe4vbvIbBzmcWGmCZA79BwhqrRm5GiWk5p46E+nv7kRzxatdzCXfNjht5nrI9oFOFg6wytu3Mr13men7btleD8CifKF9DvVpgmDl03ahFY55jMHJHXQwmAfXtmKsFnOj6HvloVudiv5YrNgS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936038; c=relaxed/simple;
	bh=9M4Bh447WXbW82Sc6GAht9rq9SrdziELRfSzU927JYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADAkd0cazcG2YObdLieqLM+UIEk/Tgnw0KuirXrjVChyYeOyHf4FV2d/tUTO5Y1yFTDwGea8DgW3Hr/UOhiNTxnaSESRS19W6RghjNGrNcZtJSrn13GWaos8oulVtQVAwJiCNdnmBoJkRHGxV84u2g2RIDJw4i7HJOq6MGRC6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zy1CEj6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF4BC433F1;
	Mon, 22 Jan 2024 15:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936038;
	bh=9M4Bh447WXbW82Sc6GAht9rq9SrdziELRfSzU927JYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zy1CEj6dYLzendRm6SErCIG/ffIbsYdllbdejk5QXBGA0gWwG4oth+wC2R16+ieNr
	 FCQnEAzmt8kC8lfNlpO7ltQN7wCbS9PK3vMVouo2P1kSSjBIzGRZQLcE9esZ1dEuQs
	 l7MTIpephATX/BIuBuUvmVoaZEaEStWFO2qV3gH4A4Xov9U5HMwd+DRyOM7DAokJfd
	 kEoq31wRmnuhcPZiROQhfV0kJ9t0ucXaDptZ9cAKg3c1bV4J3ALu47ku59jr4acFXK
	 G1VFDggc8bAocYS4+G0DRFf+C47yr+a0IyGIeT0TcFwcaktdS/2j+ZoBwyD4QydPYj
	 rL0Yqkp2cXIZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>,
	xingyu.wu@starfivetech.com,
	samin.guo@starfivetech.com,
	linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 53/73] watchdog: starfive: add lock annotations to fix context imbalances
Date: Mon, 22 Jan 2024 10:02:07 -0500
Message-ID: <20240122150432.992458-53-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
Content-Transfer-Encoding: 8bit

From: Ben Dooks <ben.dooks@codethink.co.uk>

[ Upstream commit f77999887235f8c378af343df11a6bcedda5b284 ]

Add the necessary __acquires() and __releases() to the functions
that take and release the wdt lock to avoid the following sparse
warnings:

drivers/watchdog/starfive-wdt.c:204:13: warning: context imbalance in 'starfive_wdt_unlock' - wrong count at exit
drivers/watchdog/starfive-wdt.c:212:9: warning: context imbalance in 'starfive_wdt_lock' - unexpected unlock

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20231122085118.177589-1-ben.dooks@codethink.co.uk
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/starfive-wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 5f501b41faf9..49b38ecc092d 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -202,12 +202,14 @@ static u32 starfive_wdt_ticks_to_sec(struct starfive_wdt *wdt, u32 ticks)
 
 /* Write unlock-key to unlock. Write other value to lock. */
 static void starfive_wdt_unlock(struct starfive_wdt *wdt)
+	__acquires(&wdt->lock)
 {
 	spin_lock(&wdt->lock);
 	writel(wdt->variant->unlock_key, wdt->base + wdt->variant->unlock);
 }
 
 static void starfive_wdt_lock(struct starfive_wdt *wdt)
+	__releases(&wdt->lock)
 {
 	writel(~wdt->variant->unlock_key, wdt->base + wdt->variant->unlock);
 	spin_unlock(&wdt->lock);
-- 
2.43.0


