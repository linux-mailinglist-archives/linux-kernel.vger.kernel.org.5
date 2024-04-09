Return-Path: <linux-kernel+bounces-136465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4E689D452
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D330282B22
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA08128833;
	Tue,  9 Apr 2024 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MYfgoCBc"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E4082D9C;
	Tue,  9 Apr 2024 08:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651237; cv=none; b=GeWHU8bEDOTHEUON5r60XDOgvQfCEt8iOedhsPMkhdJRZigXZwjn+IakDvEhT0Buenar4xsjPpR1yxMP+/LEqhyA+1TsH0oOLBOjKLGdD+6XgKSGqdpnNdkN3Dp0jSuX51ZCQdlpZf3kEYJxQVqwQlaUZKMVy9SgWeMLq+gjVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651237; c=relaxed/simple;
	bh=+7AuBfrkVfvvlqBbnWwiB4WC75JvgZX/iPRvTxQaD3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EIiySrdyn5QD/o+4evH6RasEzPJjwrBv9VAgSdEmrMMyDyvLv4XJlIYZwGi5a3ro/9INTakeA7zWOXA6vz6UWTS5GWJqsVJRaqOsmJXpMPNPjpn/GeYKjsVwJjMVBsb3IrVsFpSLwKKOZNk+wnLi0ZXL8hbkaRTJxQJPeOb6jzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MYfgoCBc; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23D32FF806;
	Tue,  9 Apr 2024 08:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712651228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OvSPqbTravq+uXV8NX6wI95ClFv5FR4JYxaALnEYaFI=;
	b=MYfgoCBcxp5aHjwldcMjIz+rznCXTfmbtfjaER6D2Sp3uJZDyGHe7IHVRd5b1jRnXCWWi3
	uggSNdPjhHFPLaaQo6cAm6ldlBfqLOyn1uVhK8uZrl2rfIAF/Jg7NvegCSrqpPH3TE1L+P
	oqZHuNf6kklcJ0Y30HqS1zSKLa75XVHXywbpmyboLDda4zMMxGGmXw6dCK858sFHmYzy+V
	0799rCBQbcAuNmMTZ3VLe2H3Ib46od2gDmRGElm8cQsbR5eXAaYZSCdRc1lGc5dntS1mFr
	tt3R5dp47PF747G2g357lpkpLbWc+4LRdeC+WKsPmvhbIxzl7EsGpxh6bQgB9w==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 09 Apr 2024 10:26:26 +0200
Subject: [PATCH net-next v10 04/13] net: Make net_hwtstamp_validate
 accessible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-feature_ptp_netnext-v10-4-0fa2ea5c89a9@bootlin.com>
References: <20240409-feature_ptp_netnext-v10-0-0fa2ea5c89a9@bootlin.com>
In-Reply-To: <20240409-feature_ptp_netnext-v10-0-0fa2ea5c89a9@bootlin.com>
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

Make the net_hwtstamp_validate function accessible in prevision to use
it from ethtool to validate the hwtstamp configuration before setting it.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v8:
- New patch

Change in v10:
- Remove export symbol as ethtool can't be built as a module.
- Move the declaration to net/core/dev.h instead of netdevice.h
---
 net/core/dev.h       | 1 +
 net/core/dev_ioctl.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.h b/net/core/dev.h
index 2236b14b798f..44004f17b32b 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -172,5 +172,6 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct netlink_ext_ack *extack);
 int dev_get_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg);
+int net_hwtstamp_validate(const struct kernel_hwtstamp_config *cfg);
 
 #endif
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index b8cf8c55fa2d..6aaa8326bf8f 100644
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

-- 
2.34.1


