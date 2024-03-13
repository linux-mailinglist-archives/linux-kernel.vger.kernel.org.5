Return-Path: <linux-kernel+bounces-101813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BD087ABD3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342A11F2148C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962165F460;
	Wed, 13 Mar 2024 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrRNcVkm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4825EE69;
	Wed, 13 Mar 2024 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347844; cv=none; b=XlT78yNTyb+mvPzWXGnrQR4yBKu+JVVgIV2qxuU+9yvbfDZcRuttePx8pDDHhybNwmSpvp5hIiKRBLSkM/N47E3IUSc8WwTntFBqygDAGbkUuzxdPkZRdQJ9Oac4CcTOy60XzE8+kGoiM0GCBa9pTZ3nOlOab48vuKIzCRnzUlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347844; c=relaxed/simple;
	bh=/XxBwg6gz3r1mMORyGr5xbaCyD2blV6a+6Ffh+orcgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPOanlF6539Q6yGYl1dkPm7uH8OfEIt5ZFVP+4kJqyoNrNhEEA+/+B0qDBEgYwQEY7B/YPhpKSjxrrF7gabbfhJF+5gf+p+kCM4YrZ1crdNJ8bjLaHFAZrD7IP/KgBu5MXNm1UvEe+usBTlPGXTjtxzihHOxpwJAXKCBm4JluqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrRNcVkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA4AC43390;
	Wed, 13 Mar 2024 16:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347843;
	bh=/XxBwg6gz3r1mMORyGr5xbaCyD2blV6a+6Ffh+orcgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IrRNcVkmsizEjgzgDaG3MoqTnchrqBc2EY1NhHG6kFFZLn1ool+bi7qsT6xO/cg5D
	 dUHpE2tLVrq1iFsFFfwau/9mEdDG8eyaMks+NH2/uRY+vNeg5ywI9T/V/ukCIiU7yd
	 GNn4oh1CcpO8AGvzlY3WfsmGoVY2J/HA+XU6YBk3MytDo1BjcLOfR9vGuM/O3/MHfM
	 H5R3Mw4nf0LKv947bvwT/I1X/8e5QE5NMMfGzIkbL5vjWSte40oMr2ti8AwJtGoDHN
	 R/5Zbno4+dve9fR0aYXmjO++2tpw7H/5pjUnNeNtva/zfJmeDHKDCPmE8DWfEMvmFc
	 D7ERZulSk5KZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 10/60] net: lan78xx: fix runtime PM count underflow on link stop
Date: Wed, 13 Mar 2024 12:36:17 -0400
Message-ID: <20240313163707.615000-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
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
index 8b1e1e1c8d5be..921ae046f8604 100644
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


