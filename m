Return-Path: <linux-kernel+bounces-99146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB05987840C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A121C217C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B205E446AF;
	Mon, 11 Mar 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Twxo87P6"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C89E446AC;
	Mon, 11 Mar 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171807; cv=none; b=o1Kn1pFy/wgB0yPtU3Xd8sx5JYJp0esghoDhXC1SggK/zuQWripAg0EBGJSIHn1Fk4C4v2iwpS4bXASbNNJrgFoeYc5NFD3vijp9lkMLU+YlUr5N3bVOS5Gtfk17TyyTqJ3teVCPGMLtfrauPil0HbXKkEkcW82x0rCCdtuwa8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171807; c=relaxed/simple;
	bh=bQ7XkdqNEZiiCFA5h3YPo1Z/piOhwZZNNUUv3sDmZRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GgkCgT3r2zDtIFqthpCC7Jgb45OTybh8BFPDBc6w0n96IupqxlxJAODMXOMKDmnRJTLJZ807hOvm9aCf058cNuW0DTPyZmm9ORwWq4XDMjp9/NjcML6j0Kk1u2AvPRHmlgj+GS0pQl1y/ujXUZCvIUbiMrLFk92iwvA3UglDdFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Twxo87P6; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8860E1C0009;
	Mon, 11 Mar 2024 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710171802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Js1lYw4p1FIj5w+IaLEMzbqeNXg7/oWcjchrh2IjI3Q=;
	b=Twxo87P6mOwHRgf6hYQHft7XNBlt1NMdN2IWwTeNCOyIw67QunjHn7uRI/9Nit0xIHsmtL
	/H/xxuJpRcxB0+P80fvzgsdzp9Cj/1ertUP7Uzw3UiZmOZhPOcdj25jl/nY3K6okcnEAzo
	KU3KXw7FJaKfJmJZz9QznCQNMklrO+WJZ6VmTDfQGlWFQO5R5W+wEI/VsBAh1Ezvc9MUzj
	9qQq9j1KbSwPCxRih7Q7q6p0zL/tBt6tcog4va54oLTJFiXd9cCLB5f28d9sXJOZxjOt5f
	CUp6hEalxzsDe4yLmpPagBkZ6t7tzwIWegwtWeu41bSedrHyLA3R3T9tNHKOIA==
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
Subject: [PATCH net v3] net: macb: remove change_mtu callback
Date: Mon, 11 Mar 2024 16:43:15 +0100
Message-ID: <20240311154315.2575297-1-thomas.perrot@bootlin.com>
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

Fixes: 44770e1180de ("ethernet: use core min/max MTU checking")
Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---

Changes since v3:
 - Update prefix
 - Rebase on net
 - Add tag Fixes

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

