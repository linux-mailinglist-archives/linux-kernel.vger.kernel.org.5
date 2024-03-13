Return-Path: <linux-kernel+bounces-102191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A91287AF47
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 522C2B2662D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA5C19C3F6;
	Wed, 13 Mar 2024 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITk4BccH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3458576C6C;
	Wed, 13 Mar 2024 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349485; cv=none; b=BCsnLb/yAvivxlajdE+IXlQNK+jGXu0SsqfotZtmi1aUDEBvstMEhwwEK/PoRAnL+V37WfJrt+QXIDLGwVwc2IaKzoHwterZvzqyMT+n+P4SOd+I7et032DjRnHtHQsamSdD7fh8OHYrluJwIV7wN3xAvZG/0jFgM64byWEPDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349485; c=relaxed/simple;
	bh=HUQ+MXANH31cbahW+pHKvOFfXu4pCED0Yv4yOw25CTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFhIg0KQbGE5XxEoSSmWj+cT4yvlHWALQzxjFtKbXKFr897wiaUVd9ZiFEutJ0IosSiYtxSuf9G/OgMKcS7oBfrHDxYQHrzRke35aHbfd0o5eNw7G5xA9SEAdna1eAAChCme6c5lnkq80fzXpN+9wPp7IdzdabY3fOLru5Nx6VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITk4BccH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B53C43390;
	Wed, 13 Mar 2024 17:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349485;
	bh=HUQ+MXANH31cbahW+pHKvOFfXu4pCED0Yv4yOw25CTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ITk4BccHO8rucsDEqnF0erq0RsFF2wWh5JIiv99vDojjMkFf8mAaYCojwOpVC6eFe
	 0oyWZ+29QQ5In2VK4gQuhazDXno/ZRuC4ZRbf2UM8HvNY0wS/d15EZy1UOMdh8si7Y
	 CBk3vfM4nx+Q1UnAV0TvHRkQoHMpsM9kTIBJq8yQgWXbpXu/m4zp03j+SoqLDSIRYr
	 N6xBvK9IVaxPGI57ZBc0TcJUEcqyTpikvZ+4sLqFxLNMRezOF9vGnXT5cH4ZV4oPIQ
	 yzrZvdZsWq8sQiJr+V/uxWpx0IpkgsK5bqIRbt7WUja0Ja8D1znrlwAp6l59DIOYww
	 p+dbjP4R3aPUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 06/41] net: lan78xx: fix runtime PM count underflow on link stop
Date: Wed, 13 Mar 2024 13:04:00 -0400
Message-ID: <20240313170435.616724-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
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
index 52d1d922f6c5e..f56f45c924de0 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2940,7 +2940,8 @@ static int lan78xx_open(struct net_device *net)
 done:
 	mutex_unlock(&dev->dev_mutex);
 
-	usb_autopm_put_interface(dev->intf);
+	if (ret < 0)
+		usb_autopm_put_interface(dev->intf);
 
 	return ret;
 }
-- 
2.43.0


