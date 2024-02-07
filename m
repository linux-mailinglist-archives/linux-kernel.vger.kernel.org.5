Return-Path: <linux-kernel+bounces-57087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3420684D3E9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8ADAB283B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C249712A14B;
	Wed,  7 Feb 2024 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBfTEsk8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A71369B8;
	Wed,  7 Feb 2024 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340946; cv=none; b=ei4lPsLzC+24/ToxMJOZj7nKIyjQQDDJwQ+PydtvRmeqEnI3qjCKmps61C5nsIBr+SMM2k9qAEEdn3oYXq1boGiNvD+DZaQpYcBbnps092CqRCoauP7/b/9yapBvgDtBn230aezmJVMWJmoQcYLMNwK4PjBHqiK6+wrNp+9r8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340946; c=relaxed/simple;
	bh=iRmMvfCdMNSvbGxyO9wNi/xoe4+RBnCWHEuawGQAhkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yiar41eM1jnvWzuRcwgjnl6gy03/8w86WqxFrAbkol4bC2Pr2bU3ZXqLN84q6Y54jiLwWd94zzo+gaQyLIT8mIe/ebeSiz3E4Rp2QPoCXGBbKG4uempLmlZH5wwHsx0xw7SkM6B1kKrWxOi8vlS+2GVgEd2ykqAd+V7S4nHPUe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBfTEsk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00526C43394;
	Wed,  7 Feb 2024 21:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340945;
	bh=iRmMvfCdMNSvbGxyO9wNi/xoe4+RBnCWHEuawGQAhkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DBfTEsk83hC9pYvoM/sFIq35wXf5wFkB5xpuC2etTmqearTLYaqGe9vnqXUJf5h/z
	 iP9SN8QvEgnMJV/8k4gU6/vx0EAy/zkBx0xSDrs2fMCd8Ihf0lY0nQGNTOgATgeCyb
	 H2txTjtxIYeuwtO+MeAe632EmmHvPJbhDrBFT5TiT0uMgqg1Epl6HQFiJdoSQfFr7t
	 gsCOuq7E4Z6BYc2BqZ/M+h6R7vvn35zRVy9YRBoCMpoYz8RPTAMhpIQvBKb6VmrzAM
	 wTFafIo18kCZ4FoBC9rIn8xZDdbnCzYU126JkLypvPz4MAIetRT/7YcCcMdlExOcFY
	 e8EM5TWrMUG8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	David Brazdil <dbrazdil@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.7 22/44] misc: open-dice: Fix spurious lockdep warning
Date: Wed,  7 Feb 2024 16:20:49 -0500
Message-ID: <20240207212142.1399-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Will Deacon <will@kernel.org>

[ Upstream commit ac9762a74c7ca7cbfcb4c65f5871373653a046ac ]

When probing the open-dice driver with PROVE_LOCKING=y, lockdep
complains that the mutex in 'drvdata->lock' has a non-static key:

 | INFO: trying to register non-static key.
 | The code is fine but needs lockdep annotation, or maybe
 | you didn't initialize this object before use?
 | turning off the locking correctness validator.

Fix the problem by initialising the mutex memory with mutex_init()
instead of __MUTEX_INITIALIZER().

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Brazdil <dbrazdil@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20240126152410.10148-1-will@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/open-dice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/open-dice.c b/drivers/misc/open-dice.c
index 8aea2d070a40..d279a4f195e2 100644
--- a/drivers/misc/open-dice.c
+++ b/drivers/misc/open-dice.c
@@ -140,7 +140,6 @@ static int __init open_dice_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	*drvdata = (struct open_dice_drvdata){
-		.lock = __MUTEX_INITIALIZER(drvdata->lock),
 		.rmem = rmem,
 		.misc = (struct miscdevice){
 			.parent	= dev,
@@ -150,6 +149,7 @@ static int __init open_dice_probe(struct platform_device *pdev)
 			.mode	= 0600,
 		},
 	};
+	mutex_init(&drvdata->lock);
 
 	/* Index overflow check not needed, misc_register() will fail. */
 	snprintf(drvdata->name, sizeof(drvdata->name), DRIVER_NAME"%u", dev_idx++);
-- 
2.43.0


