Return-Path: <linux-kernel+bounces-98586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87523877C55
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F6E6B20B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC70A18B15;
	Mon, 11 Mar 2024 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I+lmVv4d"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A961426D;
	Mon, 11 Mar 2024 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148358; cv=none; b=aZG8XBdSzGiUZVv7ZdAaMzPQzMddGB3YRZr1u8V5TB8QFQVZnGNTQ7yprcAbGjBiJ7qQsIHbtN2dkpu9SFRV9wEdrWuveGh9N/ZbjqtR/rL6CG6opm2u0Hl2vA0ut2FAY6Ihrok1UB3iv+iD6i/uLkL1/2C0wfdqSWO7nvUgt+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148358; c=relaxed/simple;
	bh=SAc/EnxQvVa1nAkHB7jbIyuOAeTu3YjIhhYZtAjcfac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UC6TMepTMj+77wML6Cls3ksFMwLHkU9sfg2GG52PWq7LTHHYmqPbd6YljTrZsnXzL6XoCGHwQ09qwf6oPlNNvs482b8wV83HG+14fPp/4YAKfyzFAL4VyDdw8ptGKd3pdIJfxS9XeCkEnB0QqL4MKHGrADXCTIFJJ7X3aUnQSIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I+lmVv4d; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3301D1BF209;
	Mon, 11 Mar 2024 09:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710148347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gU39HWmt7vQXPoC0F5cGz/jFZZTEQpLyvJ+SBbbV034=;
	b=I+lmVv4dqnKFMorHIQ/de1PkYy3gyiQGebRJHgckf+cIS8/q9V4Pgt5GycAVOGbc1BlcSo
	vovg2yXNxnGdTeWHxLupcCuHiLX5A1XYPDbdN86jbK7hiursA75Mw+NDtsl1rgmM8DJKQd
	QspGuTVnF0YwXd4ZFIwGFVRw9F+J4dREpEKUe1vjzELnHH5vk+yQxe5IGboDrXmZKvqOww
	xVYeQPZWnD1rjOXSv2T2CgW+myhBoBPBpNQFak5Q1xGb9jWY6/9R1wthZHntmbaUb7atLG
	Dfihf7XeNe0buevzjlT9R1MNpA/544kUhJaNW/lsEoDLgIdn1+tFQWQogoBvwA==
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
Subject: [PATCH v2] net: macb: remove change_mtu callback
Date: Mon, 11 Mar 2024 10:12:11 +0100
Message-ID: <20240311091211.720789-1-thomas.perrot@bootlin.com>
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

With this patch the core will set the MTU, regardless of if the interface
is up or not.

[1] commit a5898ea09aad ("net: macb: Add change_mtu callback with
    jumbo support")
[2] commit 44770e1180de ("ethernet: use core min/max MTU checking")

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---

Changes since v2:
 - Update the commit message.

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

