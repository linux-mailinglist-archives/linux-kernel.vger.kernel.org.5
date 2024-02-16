Return-Path: <linux-kernel+bounces-68911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85328581D1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A272848AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AC6130E2D;
	Fri, 16 Feb 2024 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QISedQ2q"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BF212F361;
	Fri, 16 Feb 2024 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098787; cv=none; b=bNivhShLqJMQRklkZvlWr7dJeyB4A00ZsRXxZ2tIJBOXAIkjLPfPuqj5zxWwDRUTGQD1R7c3fMKr/Xk0FUh7s94ZwopZ2KZfHMW3Zdi9iSUJfG0pG0ZnNuPL83bskKb3GETTsu0Oa7IeCC9cB6Wln2fnxp+/FrZLGKRJAt9LdFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098787; c=relaxed/simple;
	bh=/eZVwRgt2j1BXqRGlnyzPhAuRD9XUH7xvoTcScbOTyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IK6T8ecT4o3Tm7yPgs0zNR8TSOaCdW0KHVaRvGlmU2QWrG3kvZj4uABvvHL7z9XzvFHVGihto1o2n3JujBSB0kUwM4XUdGaKq5raKPjbdTdTFVHyH7dWVcqL3jXzmgRjXVrNul3QtaC2mE41fj5ZFAlQc+BwrkKdCYugI9AUlCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QISedQ2q; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 535DE240010;
	Fri, 16 Feb 2024 15:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708098778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u126WbGtnDgFCy3tvttwAlHJg1ScL3beIrXWK0ZN9vY=;
	b=QISedQ2q4l18bCK7EgHlLflrB/UFRhtKWpXB+HNpOy43V1jqngPNlgZ6qje4kobyNJNQVX
	OAZqYsMk6vOl8qsoqrkgwDJyCVb1uoHGZKI2tUtivMwcEpzgZlHat4MnasIkallCxhYiTm
	kwHEsG5+6HYG58TjFiYi5V2Ypy+le4aPjRqzkzIUZTyP2pKDms/gk4NMov/83120nOku8N
	5ffIqReDf/AhltmKqnIVwwio05VyFUZiIaygJdWnsrlhACvk/kybm7vlQ0ohFDA0Wtbq2T
	mFwlCAQuyfTkanVrsHpOH5oJjPaMR0d8k8f6VwWFkaxgW3XQ7lbGfZAC6LJ0Ow==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 16 Feb 2024 16:52:20 +0100
Subject: [PATCH RFC net-next v8 02/13] net: Make dev_get_hwtstamp_phylib
 accessible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-feature_ptp_netnext-v8-2-510f42f444fb@bootlin.com>
References: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
In-Reply-To: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
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
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Make the dev_get_hwtstamp_phylib function accessible in prevision to use
it from ethtool to read the hwtstamp current configuration.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v8:
- New patch
---
 include/linux/netdevice.h | 2 ++
 net/core/dev_ioctl.c      | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c541550b0e6e..fa92085c29a8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4005,6 +4005,8 @@ int generic_hwtstamp_set_lower(struct net_device *dev,
 int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg,
 			    struct netlink_ext_ack *extack);
+int dev_get_hwtstamp_phylib(struct net_device *dev,
+			    struct kernel_hwtstamp_config *cfg);
 int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *userdata);
 unsigned int dev_get_flags(const struct net_device *);
 int __dev_change_flags(struct net_device *dev, unsigned int flags,
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 9a66cf5015f2..5d3b169d8f18 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -268,14 +268,15 @@ static int dev_eth_ioctl(struct net_device *dev,
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
 
 	return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
 }
+EXPORT_SYMBOL_GPL(dev_get_hwtstamp_phylib);
 
 static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 {

-- 
2.25.1


