Return-Path: <linux-kernel+bounces-164311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BFE8B7C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7663B1F21C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD17180A62;
	Tue, 30 Apr 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RkZnoud1"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE92174ED7;
	Tue, 30 Apr 2024 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492243; cv=none; b=eFEoasysiUzG4IJj2O/Ljf2K2SwbvgaxDD8VvZ9pUlhaz59K2KTEtrHyEMzhAid8TGmsWapdRQWmV7ensYUZbgfyGx+JurrwC5SypYRWKs1/slFJbPtEUpDsOTwsZ11UIZl167t+4ahnBAvRIAd5Acuks6bHNbmAuPJlDsV19k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492243; c=relaxed/simple;
	bh=Qc9y9gWCMYXbIRGYxDOn9KPiL5+xiwpK3cNBzhn7RKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E4Rw3xvN6jMa7uXH5som/vILSZ90VaOcKJrRb32o/xo0FXchImNPBaXHmW0mkUTjcj/O2IuL/6hgP3BuuRIlOyZF1tJTG+MkuANd566HblhOyPhiVTqeJhq7/XADSXTIWoEgGoNW9DClXScri4MktWgGoCuEK4MKxPL7zufLSh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RkZnoud1; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ABE4720003;
	Tue, 30 Apr 2024 15:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714492229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G959hpynK4hhvxSMI29ATuJkbcQfTcQfzdFWCYXcEjs=;
	b=RkZnoud1dd2UjXssRR4bhWzYybKvVRtonlA8b7H06KaB4/Q39FR+ZxAWBB2GTFWLqESpC9
	uUSfAt2ZIMTHx6QGdQYJz2NSZjMwpFdg5AW7HmmfpYBor47bKVLpAv9eh2883HnAhAwXdy
	fcrfpuLcHq6qBmswTuWNKdbXAqA8cnsOg5rd//a30CrEAXaO/Sqx13a5YYcPdR+8k0IZdU
	jiNP5r5h07ObHxcBFbu+NstC8zifocwoSqwl2rpGwX350SYMsa+iVGsLY4GxYzonpKKDk0
	iExk+zgUiCUPRecetzIJMcYypguecRBspJ0nDNxDQvX6qyHI7JRFpsQgwsGl8A==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 30 Apr 2024 17:49:46 +0200
Subject: [PATCH net-next v12 03/13] net: Make dev_get_hwtstamp_phylib
 accessible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-feature_ptp_netnext-v12-3-2c5f24b6a914@bootlin.com>
References: <20240430-feature_ptp_netnext-v12-0-2c5f24b6a914@bootlin.com>
In-Reply-To: <20240430-feature_ptp_netnext-v12-0-2c5f24b6a914@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

Make the dev_get_hwtstamp_phylib function accessible in prevision to use
it from ethtool to read the hwtstamp current configuration.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v8:
- New patch

Change in v10:
- Remove export symbol as ethtool can't be built as a module.
- Move the declaration to net/core/dev.h instead of netdevice.h
---
 net/core/dev.h       | 2 ++
 net/core/dev_ioctl.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.h b/net/core/dev.h
index 39819fffece7..2236b14b798f 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -170,5 +170,7 @@ static inline void dev_xmit_recursion_dec(void)
 int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg,
 			    struct netlink_ext_ack *extack);
+int dev_get_hwtstamp_phylib(struct net_device *dev,
+			    struct kernel_hwtstamp_config *cfg);
 
 #endif
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index b9719ed3c3fd..b8cf8c55fa2d 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -268,8 +268,8 @@ static int dev_eth_ioctl(struct net_device *dev,
  * -EOPNOTSUPP for phylib for now, which is still more accurate than letting
  * the netdev handle the GET request.
  */
-static int dev_get_hwtstamp_phylib(struct net_device *dev,
-				   struct kernel_hwtstamp_config *cfg)
+int dev_get_hwtstamp_phylib(struct net_device *dev,
+			    struct kernel_hwtstamp_config *cfg)
 {
 	if (phy_has_hwtstamp(dev->phydev))
 		return phy_hwtstamp_get(dev->phydev, cfg);

-- 
2.34.1


