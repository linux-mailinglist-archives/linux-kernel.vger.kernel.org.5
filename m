Return-Path: <linux-kernel+bounces-136471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D3489D468
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0420B1F27223
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5347F487;
	Tue,  9 Apr 2024 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RurPN5K3"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183DB12CD9C;
	Tue,  9 Apr 2024 08:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651242; cv=none; b=r3ANFeNYiX7Pb388OrDgSsRhRmZq6QLw6/f7jQXa1n6z+QQcNytTWtdQizqwXcQUauZMaESwpkzuLG1Omq1KUjovWkWOXzhYKVbDrbHEcWkD5GWeNKGXJlwGq0B53BsH7SHDoE3TtJ47LeyjRMwdpnKwvjRlHtm65QQr0sZIfTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651242; c=relaxed/simple;
	bh=Ccu6UJMGFols9hejHCvUU8L02LM1jWMbMXDbUMzT0KI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z66gqn7hFffRBbf/mOCi9OjzWGFaJLpb9k+foBtqj8P9O6G8Tk+B2AFp1B+fivw17W+c0eZmbCthb9MNscHG0P0X98v4wTws66dfavF4ct/xvcGlq10Wforr0RxuCUdD1SGxg8WsJ/JxSuwv0rBUkD9ul69SwlJjCFcgiahA1d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RurPN5K3; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 773D4FF814;
	Tue,  9 Apr 2024 08:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712651238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TK/W9hOQzfI0Ad3qbfJjWhiLglJoRwsqcdnqi9uaq3o=;
	b=RurPN5K3L34qfRsKY5KdvkQmhXNM+g+wDEc3LzlSLKK1ProrUoeDax5U8GME09klMw7aYA
	dUQ2DpkqQB9ALSQnc+s+qOi2QAeCRfWZRDCoAq8UR1G7g3xrPv/JreqgJ12K4WZ7w72suo
	6ro8ItQzUs/EIViPq+c6EuXflGXKg5I/BWBA9I4q0iVRCR3BVEswUA0+KA6t1MM9NP8h+B
	E+A+QhqrieZZGtVPOC2bAAYtWgjudbNjbK+6XqLv9Ytg4IW167P9gPY3WF0sm3vrg0Qnp3
	p3rPcgpYJHLMV5+3CO75lHFaJAZ+gOoD0R+/jpm0SgfRYQh4L21Uz3BUxqHU1A==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 09 Apr 2024 10:26:33 +0200
Subject: [PATCH net-next v10 11/13] net: macb: Convert to
 netdev_ptp_clock_register
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-feature_ptp_netnext-v10-11-0fa2ea5c89a9@bootlin.com>
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

The hardware registration clock for net device is now using
netdev_ptp_clock_register to save the net_device pointer within the ptp
clock xarray. Convert the macb driver to the new API.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v8:
- New patch
---
 drivers/net/ethernet/cadence/macb_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index a63bf29c4fa8..50fa62a0ddc5 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -332,7 +332,7 @@ void gem_ptp_init(struct net_device *dev)
 	bp->tsu_rate = bp->ptp_info->get_tsu_rate(bp);
 	bp->ptp_clock_info.max_adj = bp->ptp_info->get_ptp_max_adj();
 	gem_ptp_init_timer(bp);
-	bp->ptp_clock = ptp_clock_register(&bp->ptp_clock_info, &dev->dev);
+	bp->ptp_clock = netdev_ptp_clock_register(&bp->ptp_clock_info, dev);
 	if (IS_ERR(bp->ptp_clock)) {
 		pr_err("ptp clock register failed: %ld\n",
 			PTR_ERR(bp->ptp_clock));

-- 
2.34.1


