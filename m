Return-Path: <linux-kernel+bounces-57162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8813184D4A1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB351C22A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B277915836F;
	Wed,  7 Feb 2024 21:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxqQ9W2g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E73158362;
	Wed,  7 Feb 2024 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341133; cv=none; b=kEnCa3EiiHjXxu+q9NNy+onyUcQ9jWaJqRVQR+vQQo/jjCYk4BUgR9QvV+I1qkhlTnYRf7mUBMu6H6Bqi/y58rnFtNSoibcgoegpXgxmPbdYVSJ3TSxcPKm+DoqdCn8tKE2lzuoBIKTtO2o2jvUQW8H56XZhESVlK8NIRQ++JQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341133; c=relaxed/simple;
	bh=09VRC5UMWOCeUD2XAo6R/Emcj6lgXZug47ftIxkJGck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxcjf4BSm8YhZeElwoK1uejEHgpLRiI0IERoaFRlBrAG57m/2nL8L27JPzPwAhM/fNZbSBmiFn2zxik2M8/ZMolvy3DY4pWv+z8NoW7qkGnALkp2vTvz3Xysi6/IqB/Kd0O0TwLPqRMxQPH1Ji8csAAibMoTNgeVlEl7KI6rVDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxqQ9W2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DE6C433F1;
	Wed,  7 Feb 2024 21:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341132;
	bh=09VRC5UMWOCeUD2XAo6R/Emcj6lgXZug47ftIxkJGck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gxqQ9W2gGxqpLmWe5lqBmNgFd0hQLaYT34UXaR5KhW43z27bP1vf8CipfBPGfObQO
	 MBTrX30KlAW8W15VeBJ0pMYTWte7oQzc8js6pm/PX+NSvKliDs6lZdADl3m2/wWWzM
	 nQnlMvzw2ehQbhPc7Ts0aIhICokqKXJzeJmwk9FwZQkxM7tOLM9Pw0OK490uyjBxQ+
	 iqkteqmsm4RkQWMy8NIoe+7jgwH5iDjniCdWsue4LtWq+hfmvlFY62A+T+4FKXCEvG
	 ERa+lEOsZJn/JHjOWI1bIFjUMMoqyfTDCkvLGv/dLETc9x2ppuH00aJNrGHCNF3qER
	 BGpcp3BdS99uA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	David Brazdil <dbrazdil@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 14/29] misc: open-dice: Fix spurious lockdep warning
Date: Wed,  7 Feb 2024 16:24:39 -0500
Message-ID: <20240207212505.3169-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
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
index c61be3404c6f..504b836a7abf 100644
--- a/drivers/misc/open-dice.c
+++ b/drivers/misc/open-dice.c
@@ -142,7 +142,6 @@ static int __init open_dice_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	*drvdata = (struct open_dice_drvdata){
-		.lock = __MUTEX_INITIALIZER(drvdata->lock),
 		.rmem = rmem,
 		.misc = (struct miscdevice){
 			.parent	= dev,
@@ -152,6 +151,7 @@ static int __init open_dice_probe(struct platform_device *pdev)
 			.mode	= 0600,
 		},
 	};
+	mutex_init(&drvdata->lock);
 
 	/* Index overflow check not needed, misc_register() will fail. */
 	snprintf(drvdata->name, sizeof(drvdata->name), DRIVER_NAME"%u", dev_idx++);
-- 
2.43.0


