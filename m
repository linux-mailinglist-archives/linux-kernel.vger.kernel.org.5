Return-Path: <linux-kernel+bounces-102125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0170987AEA1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB851F2B809
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FE76CDA6;
	Wed, 13 Mar 2024 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZqZtbMR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164336BFCE;
	Wed, 13 Mar 2024 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349341; cv=none; b=qamypcGOMtjJ4TOmYlz2L11agUdM1dT69swTUYeqpklBSmpjy43s9EOs8GBCC10/Dur4sXprEfReJv5oQIqUXGHZ0mcEs/gkII481UZXh5MoYIphLp/aw2YqIVr4dS1Ji9lxQ34Fxb74A0f7huYjDZDipxwvsSA0YUNa415vQOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349341; c=relaxed/simple;
	bh=1PzYjJECdyxJFAvQj2oALN2vIBxJLj4yYEea3o4T+TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGf49zIuGBXep/ilctBk+tvsyYg6p8ECloO/Dzmc0JzO+TQqPAnNZ6obyGuN7P8iul37Ozcc3LnsNmUj/RtWU/EO4CrduLb2tMyUc8WnTt141NFeYuzMw8qiW2iPm2RICeLbNd3WSgBNb6i279YzpVhgmRmJHbcfepGaA+aGLxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZqZtbMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0E2C43394;
	Wed, 13 Mar 2024 17:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349340;
	bh=1PzYjJECdyxJFAvQj2oALN2vIBxJLj4yYEea3o4T+TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZqZtbMRDYMO/LX0YVIGcSvujNAT8uyDGnM85ZR/lfHVsq/vgmGf2+O41fiqZtcB9
	 IfbbkFYMzq3jsHo6q0lYMK88eWOZfhjuSrk3RoQ9jruJYCBSmxgmbddKVsYjaYhfOR
	 AyVDS4dA1pgx5IclCcL+s760TNyiMtiFcC4mR2Q7YQpaQaUtdyTtnQIYpVy2Jw5d+3
	 5pgHb+dmOXWm0VGEofRHRZEI0hQaxYM7+gHxS8/J21abjBMClirbQ6GSutMWbGL5Lb
	 L5yg/sZ8lhazOA0QkzpRD80Zbef/zNae+Rs3A1zUiU/5BggoJ0Y6LWo50k4fU60vQM
	 nFeDdICoejoIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 05/51] net: lan78xx: fix runtime PM count underflow on link stop
Date: Wed, 13 Mar 2024 13:01:26 -0400
Message-ID: <20240313170212.616443-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
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
index 42fe7753ff76d..b0efaf56d78f3 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2905,7 +2905,8 @@ static int lan78xx_open(struct net_device *net)
 done:
 	mutex_unlock(&dev->dev_mutex);
 
-	usb_autopm_put_interface(dev->intf);
+	if (ret < 0)
+		usb_autopm_put_interface(dev->intf);
 
 	return ret;
 }
-- 
2.43.0


