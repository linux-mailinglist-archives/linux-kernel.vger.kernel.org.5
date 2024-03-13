Return-Path: <linux-kernel+bounces-101870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DAE87AC4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C21F28311C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F43A60DF3;
	Wed, 13 Mar 2024 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQ38A+KG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A72F60DDD;
	Wed, 13 Mar 2024 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348003; cv=none; b=TS6zmp2a4+IOVXvSWb9vkjdjBItQVVy3k+/q31QRIqMl7RS/4+CWDE3lGq+jOY6nNylNTli2l8nX2h2abw39Nl+JH2nupUdZ1U9oikP5qwKEFtu/HV3qWjANOiWtPEtSCZc8l7DT3A39kcVBsBv5/OiTZ8y+AE04iyAZcxszFzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348003; c=relaxed/simple;
	bh=fVWToBkXWAeA59ugkjTBnT6KwGoWThF4V9Yoewx6yFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0bnN7761izk9mPnMiTIOlSeYLrBsdZLW5aFrWW3oMV0/jc1KL70eYzgkwi9jfR0GtHajKeHqgfkvZx8k0uXMGnFt3mfIcz3wGvsZdnkqQlKF7hufLoq+Du1TM7qTihaGslJA1mcKycn5WR3ShTmYNbgmZAy9y2MsYQlEXd0tPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQ38A+KG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06484C433F1;
	Wed, 13 Mar 2024 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348002;
	bh=fVWToBkXWAeA59ugkjTBnT6KwGoWThF4V9Yoewx6yFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQ38A+KG6RMNOZNND8Fg8TNn5JVgzJLzMsgSpuH0SlZJYRlPZ6RHJOiuDMDBWL76b
	 8DNQMPifL6BdmxlFn9Ma7EWWqM3mdJoGELnyfksO4RbY51N3tck9qBkbvP7HlTQGl5
	 nJ6uw/oo7lV700IhXxT40S8yhdm2DRjGZ+MwMfDSjJA2SJAiswqkZFrHMCjIIUrqAu
	 mt/XIO61ehmVoN1qtVS4PIrFLFxjchysx6mp86f+y+ziZXBSHBtsobn+SQqu/Mvpn3
	 osSDbNjI0BYK60Zj1AJ5UBEFHjOEqALelZ8MbNccHUUZ9mY2m1rZK94T5lwas1YpmN
	 BGK9JlCKqiqdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 02/71] net: lan78xx: fix runtime PM count underflow on link stop
Date: Wed, 13 Mar 2024 12:38:48 -0400
Message-ID: <20240313163957.615276-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit 1eecc7ab82c42133b748e1895275942a054a7f67 ]

Current driver has some asymmetry in the runtime PM calls. On lan78xx_open()
it will call usb_autopm_get() and unconditionally usb_autopm_put(). And
on lan78xx_stop() it will call only usb_autopm_put(). So far, it was
working only because this driver do not activate autosuspend by default,
so it was visible only by warning "Runtime PM usage count underflow!".

Since, with current driver, we can't use runtime PM with active link,
execute lan78xx_open()->usb_autopm_put() only in error case. Otherwise,
keep ref counting high as long as interface is open.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 4fd4563811299..366e83ed0a973 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3137,7 +3137,8 @@ static int lan78xx_open(struct net_device *net)
 done:
 	mutex_unlock(&dev->dev_mutex);
 
-	usb_autopm_put_interface(dev->intf);
+	if (ret < 0)
+		usb_autopm_put_interface(dev->intf);
 
 	return ret;
 }
-- 
2.43.0


