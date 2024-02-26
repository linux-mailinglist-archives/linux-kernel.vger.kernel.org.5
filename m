Return-Path: <linux-kernel+bounces-81504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABC98676D2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD261C24DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D626B1292EB;
	Mon, 26 Feb 2024 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TD0Nn/oZ"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20B01292D6;
	Mon, 26 Feb 2024 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954819; cv=none; b=BhX3w9XCmHCsQFJiDVv1yqLei7xbNj7qg8h4jEG+cFb3QRpMZ16nj4hN+/T9e1wxZVIeX91rkjI6QRk4f3xghG9oxnpH9NRw6nypaaz7R9lT2lZjYpPpstDQ6FPARcEFgfgE3gdyEbotbOYnBMLkl7dey3JmDK/85y4kNOePf8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954819; c=relaxed/simple;
	bh=AIHy2PbWgD6DBaz3RhgM2aHcbFX0GQl90IKpo1PIZyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AV12vJfnpYstyiOfgMITYFFb30PYxSYe4MiXHw3yhw6XctnXVSm9RU/3Bp3fOfRgS/6IOK3SMEpZFaD5D4bzEVOoZmwiCrNrPfCNoIs/Gr/uo6G+seEitRwvb7DVpZ06e1XdF3RyYF4IuOcXZqs9IaJY3hocQVPm/K67W+pcOgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TD0Nn/oZ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0DADB40004;
	Mon, 26 Feb 2024 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708954815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IpR0OX8g3mUdqmLj9Ra+ZNABQoZh/usOEdOlFuKrx/s=;
	b=TD0Nn/oZow2NuGpCEyoTL9e0Z5w3qYq7/vzO/Euqv2jAeCIeE5RDcTRoNdVO6VkbcPISrF
	nQuRyOllfmxM5uKXq311RJHx4TW8J0S8lYTpWHwAkO/AopQ7RbMWQ4DXifIAeDnRRybbje
	KWG5RvdFLwqZ8PEPS4KBHh2FAUTkJjyWPMfw5Txrcv2XRMFU9SJJdV9GpAEqfpzGcyL/Sl
	sNaTkZutASFwiv7aKYlPAXuP5zqSO0g9jUxEDK6MAvPOkBReahwdXI/+h3AvIAA6zNeLcG
	jhUS3Rv1xRI9G64B6xNcX/Wx4OXuHcx0mbi0MX3oXBnqmPf8KlqvSfg60l5J+Q==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 26 Feb 2024 14:39:54 +0100
Subject: [PATCH net-next v9 03/13] net: Make net_hwtstamp_validate
 accessible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-feature_ptp_netnext-v9-3-455611549f21@bootlin.com>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
In-Reply-To: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
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

Make the net_hwtstamp_validate function accessible in prevision to use
it from ethtool to validate the hwtstamp configuration before setting it.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v8:
- New patch
---
 include/linux/netdevice.h | 1 +
 net/core/dev_ioctl.c      | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7f78aef73fe1..b67727c0dc58 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4002,6 +4002,7 @@ int generic_hwtstamp_get_lower(struct net_device *dev,
 int generic_hwtstamp_set_lower(struct net_device *dev,
 			       struct kernel_hwtstamp_config *kernel_cfg,
 			       struct netlink_ext_ack *extack);
+int net_hwtstamp_validate(const struct kernel_hwtstamp_config *cfg);
 int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg,
 			    struct netlink_ext_ack *extack);
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 5d3b169d8f18..847254fd7f13 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -184,7 +184,7 @@ static int dev_ifsioc_locked(struct net *net, struct ifreq *ifr, unsigned int cm
 	return err;
 }
 
-static int net_hwtstamp_validate(const struct kernel_hwtstamp_config *cfg)
+int net_hwtstamp_validate(const struct kernel_hwtstamp_config *cfg)
 {
 	enum hwtstamp_tx_types tx_type;
 	enum hwtstamp_rx_filters rx_filter;
@@ -238,6 +238,7 @@ static int net_hwtstamp_validate(const struct kernel_hwtstamp_config *cfg)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(net_hwtstamp_validate);
 
 static int dev_eth_ioctl(struct net_device *dev,
 			 struct ifreq *ifr, unsigned int cmd)

-- 
2.25.1


