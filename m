Return-Path: <linux-kernel+bounces-102031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C0787ADC0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37AF1C221E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D882A65BCD;
	Wed, 13 Mar 2024 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU5tHiUj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9DC67754;
	Wed, 13 Mar 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348411; cv=none; b=co4Wq3qfuuN6apaVomvn7p7tbtRRFOwYGc3kUBr/6SEjS4mrBNJ8QgkxWdGE1M9NghCBSUNFelpIikDo1tmycoFW16Gou4zji3sxgSUq34hqplbXjg2hWzRURSB13THy7e2Wh0gzW3FUAUBmLH2SyjoxPdwQ8f4CCy3QT6o75qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348411; c=relaxed/simple;
	bh=A0GB0o0Zf7AF2xnffGhuanuAWjWaPkc81sGoJGnWE0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hoyyBiOLSYAdnwLBGxNKrFg8SEBpZcfPM7uiWLsPqTFk9ViziTTf0bDbyfyZRlWDsTyZd6bT3giRQgMf2/UfMlA2keOu0plEs4G2BjAi9B8FsmDwUZUtF6YyuIZ5lCko1ImMLlpb3iYtY3RGP5r7oDTd1gxPhVpZYYXqQIQYAvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RU5tHiUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF052C43390;
	Wed, 13 Mar 2024 16:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348410;
	bh=A0GB0o0Zf7AF2xnffGhuanuAWjWaPkc81sGoJGnWE0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RU5tHiUjhYKphBotvRW28ZURzm/I6AIWieQuJ29gnpRfbUAZxz5zlGGV6+yUy+sbO
	 z+xyYCDfliQQaWMOsTeA3CHcdVSQyeUrvq66THTymvJbHK+TyvXgoyAfeVa67SkxX5
	 hNLW+qRBCSAEQPfoQFhgF0J0Ngk7F2JbG/Hg9yJ/jFR/B726FkD7rmzwolg4SOdWsz
	 olpkRNrDV0h4eZzGGvjbqPNSVX4qi4odJFXaYv9R7n7gMhwyx8PeBBd8sDBNHc3nn7
	 7Z/tvi/kzSWP29QjksZjAjJZk9bL+flSyHUTDFAgSAH4L9+u4S0yoLe3e6PqkOuOHr
	 1H0I3cq7qog9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 07/73] net: lan78xx: fix runtime PM count underflow on link stop
Date: Wed, 13 Mar 2024 12:45:34 -0400
Message-ID: <20240313164640.616049-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
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
index c177a8676199a..96d3d0bd248bc 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2897,7 +2897,8 @@ static int lan78xx_open(struct net_device *net)
 done:
 	mutex_unlock(&dev->dev_mutex);
 
-	usb_autopm_put_interface(dev->intf);
+	if (ret < 0)
+		usb_autopm_put_interface(dev->intf);
 
 	return ret;
 }
-- 
2.43.0


