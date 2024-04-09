Return-Path: <linux-kernel+bounces-136464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED5189D44D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DAB51F263F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA6086130;
	Tue,  9 Apr 2024 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fMz/t1K6"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D0C8173B;
	Tue,  9 Apr 2024 08:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651236; cv=none; b=e3leRwUafE+t/PyaiP9vUsfMtecbQZwMJim4bPPJPTHvtK9Kzlc2qrXfodnTXM28YkSbdeSKq1YIL09LsYlr/LGJ9jLFocAZpOVGI2cGs7uJH8bi3uSmNUT/jKxMqqTBr02BoAoUfiCze7b8Qyumn/zAorGL3V4yMZMkOvNx3sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651236; c=relaxed/simple;
	bh=Qc9y9gWCMYXbIRGYxDOn9KPiL5+xiwpK3cNBzhn7RKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WAHYPLyd3qQgZYh/L22ChkbS5t1ek+XomgRMXCTAWKeIQHcFguPtFwhUDa2GuMoHV61ZOPsgWU0wZuKuQD5IEEE9UcaL6vB6OFgkpo+xqhJUWQOqczX+qlGt+/8yDMHGA+FNnOW6TSRgxNm95gqGoEPlTgD34YPTubB6Q7fMv1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fMz/t1K6; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B7141FF80B;
	Tue,  9 Apr 2024 08:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712651227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G959hpynK4hhvxSMI29ATuJkbcQfTcQfzdFWCYXcEjs=;
	b=fMz/t1K6Cp8DJE/pvVrtLvPoRJXcVlHfr7UWlHECZyS1XeeplP5FU2bFQr/a6abt03Ubl8
	J3PYvmxhbfFiJCdEcOVP0HWC21lnGBgScUTmhz87tG2+Gpc20vLSeEVBpca5cY5uvC9NpP
	eU4PTSC0OtkWfqR/mOsmXsS4/ENqkUpVBnRj6GAdR5oNkFhbSr5kIgs8husCigcbNBDZKL
	ttOaFZNE8pzejSoKp8AaySFS7nGlQuJ2kY5S/x7D2FTR2t3tnkXDrB/gx/Kehv9TkTPFHo
	jM/AMnYRCMxpxGS7JFkVzGyqWK4GJaXi1lbZloNkWDck+2xajaJMfjEpXNqAuA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 09 Apr 2024 10:26:25 +0200
Subject: [PATCH net-next v10 03/13] net: Make dev_get_hwtstamp_phylib
 accessible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-feature_ptp_netnext-v10-3-0fa2ea5c89a9@bootlin.com>
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


