Return-Path: <linux-kernel+bounces-97258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7078C8767CD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBF028316A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D19F24B21;
	Fri,  8 Mar 2024 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W/C3unvi"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8CC1DDEA;
	Fri,  8 Mar 2024 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709913217; cv=none; b=cvT78UUSnT5XHTeHtI+WK7yTyiSzI2YGBO0BY93xnhgQ6hEyhwdG7WgPqIldpnIHPG5pDQ/FXdgFd9uei0juuPGTPNeoRVdDQtOA7y01/vx00q7hBS1DlCmNG6FPATl52ZUVKij/dhk+w7FaT/sjpJWqiIIRic14KbIh79y5PnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709913217; c=relaxed/simple;
	bh=9kAAhRqLMcrr+9tK5hG3rSo+G/V409qzT0sY2Wbs5UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P0m5e4/osvsE2Zt+m+lZ0o8w1Evsq5Wr+RAVm7Tm8mPhNnpD1YJPCqdO2VGeLyW8BDA7abz+YntPe0JAUn5+t6Yqsb5seUBW+jfTMCSqBZv+VVGPCCANvuk10GAO5wP6S1slu16HORGp+f2FhM/Uw/YYVLdZgCsdPYKTuAHPaCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W/C3unvi; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB7B14000C;
	Fri,  8 Mar 2024 15:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709913212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h7W6BFf6l9QjXDA+QpEkgFe1Y6FIQH4Amx5REeeID6o=;
	b=W/C3unvijSCZ/FzEysXHcVv2ziKW4sX7FWV+BvIkbTU3jx12EQgZqK3B7Z7AFchOejxVle
	lmw1qV5Tfe5xMVMIkhRMKd9+OF6VUyW53Yg3MZita4xnCgyfnzTBu10Glh2wgODfed/810
	U+TgauQBkZo7oFWVmpyQsD0P5+DQOQzTDyn7PkVIOjcyho3D0gBC2rKfhX5eFtipf+xMx8
	htx31PGb+CiKE9LCzHwqMDIuAGhQOtBbQhenqvtxHaY/pfJ1xe5P24P16DrCrC4eExu7OX
	NgxsmJRL2q76w9Dn5dKsyjQTRWsLvj/eI7GAiymecA5SkHCcCZaxX0jfH1xcbw==
From: thomas.perrot@bootlin.com
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Perrot <thomas.perrot@bootlin.com>
Subject: [PATCH] net: macb: remove change_mtu callback
Date: Fri,  8 Mar 2024 16:53:30 +0100
Message-ID: <20240308155330.1610616-1-thomas.perrot@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.perrot@bootlin.com

From: Thomas Perrot <thomas.perrot@bootlin.com>

Because it doesn't allow MTU changes when the interface is up, although
it is not necessary.

This callback has been added to add in a first implementation of the Jumbo
support [1],since it has been reworked and moved to the probe [2].

[1] commit a5898ea09aad ("net: macb: Add change_mtu callback with
    jumbo support")
[2] commit 44770e1180de ("ethernet: use core min/max MTU checking")

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 898debfd4db3..0532215e5236 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3017,16 +3017,6 @@ static int macb_close(struct net_device *dev)
 	return 0;
 }
 
-static int macb_change_mtu(struct net_device *dev, int new_mtu)
-{
-	if (netif_running(dev))
-		return -EBUSY;
-
-	dev->mtu = new_mtu;
-
-	return 0;
-}
-
 static int macb_set_mac_addr(struct net_device *dev, void *addr)
 {
 	int err;
@@ -3897,7 +3887,6 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_get_stats		= macb_get_stats,
 	.ndo_eth_ioctl		= macb_ioctl,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_change_mtu		= macb_change_mtu,
 	.ndo_set_mac_address	= macb_set_mac_addr,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= macb_poll_controller,
-- 
2.44.0


