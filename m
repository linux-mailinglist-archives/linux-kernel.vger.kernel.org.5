Return-Path: <linux-kernel+bounces-101749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE0387AB42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376C82898C2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C9359B64;
	Wed, 13 Mar 2024 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4jKOea2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260475917C;
	Wed, 13 Mar 2024 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347571; cv=none; b=lWdRSmME5NnBFdXTYuZAqCePO3b4Du7hn5cyD/RAgn/lTwRU6Mf7lqz7RUOuASRwuWoE+lUBhkeryA8KgmVTRXmjql03oNyWASWi/JxZJHWoB/8k7IdTTbhVrH/LfWuJG5El57bCtQypryPlp7YHukKmV8qeIv8RlLVBKcWD1z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347571; c=relaxed/simple;
	bh=oot0yLFZ/cSpMIaV7o+cb5pLc+I+X2NT5B3fpxJtVmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IM396lpvu3sBulr52UDoEOnS4eP1TGrUTrtm0dIpQIqcAKL2eC0FAaHIXay4Dvt5Ru3WmK9P+e16tzK8c2Kp2hFD4CgJuxYel/MuGTYKrfliEQVzxn7Q05uMrNfXzDUHDDifBevtFaNv8kBuTuM4kNoNrPo5/FYhipCYyIEmH30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4jKOea2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D6AC433A6;
	Wed, 13 Mar 2024 16:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347571;
	bh=oot0yLFZ/cSpMIaV7o+cb5pLc+I+X2NT5B3fpxJtVmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T4jKOea26BLQDDhL9Zn1tQAIjXavkYM8z8dcIGAoQxh52Fte12kpUqvN6ylkSl2f5
	 myoedHlBRi1uDVokWQm8oseubLYovMb5jlU2i9vlUYLsT2k6tq2Qw8MSliSMiYJKUY
	 nicFPbnCUax8b2aoOBAshDpv/39RRgVHNMaHP7KQpfOAyefKl7T2FsBIfxvqAJ1bKA
	 AnIf9vJSjP07Q7SsnXh23yB5E55+m6wepPPkCxa5l/20GlDNgk+G6gG08ct1H90RVY
	 penNc0ubzVUwmqgTQqnq4nWg/fnscdHtawuya3MJdcIJSrj96jE1fOKTuh8aejC9X3
	 HENBFFJ/yeIEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 10/61] net: lan78xx: fix runtime PM count underflow on link stop
Date: Wed, 13 Mar 2024 12:31:45 -0400
Message-ID: <20240313163236.613880-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
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
index a2dde84499fdd..f0fb9cd1ff56c 100644
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


