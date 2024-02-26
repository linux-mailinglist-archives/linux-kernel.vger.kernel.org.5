Return-Path: <linux-kernel+bounces-81512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 880138676EB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4801F287B5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A86C12CD9C;
	Mon, 26 Feb 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G7dMoR2q"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF4F12C7E4;
	Mon, 26 Feb 2024 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954829; cv=none; b=aGTlVeBnbS3PIiEkvxSIcM2v3sbg5MhrLFtydjK1I0qFwnooSnCU2rXB6nP8usSPyAeUua9lKfE/PaItv0uTi1mWW7/+Z6l5JVcbInsA7T+H/CHx2FVvUcw7qyI7x22NxOxE4M8lNK75blaxq5frd4V2Y6l2al9DpS2C6W0APZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954829; c=relaxed/simple;
	bh=Qcp2uc+UUo36BOh1LCqqElt85kVpuM5XT+lI8HhHyio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H7STlbK39D49cNWT2aZO9GO64UOhyrUpyQIveJ7YkAcuifsfaLZbJXIZ+EkNiFC4iA0+PPG+xgAWB9/7LVKcbs/3SU53SE58pcoVOcX59s3/U8n5UHwGUG/qDfipeg6Q28sHQBsEEm3BK2wjNUtBLAHho+C6INQFKZ2iNb0F1Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G7dMoR2q; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 05B4540014;
	Mon, 26 Feb 2024 13:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708954826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fcclx+P2VRL5YyMqc19FLMrEZY/bn8QqcU/6ryhVROM=;
	b=G7dMoR2qBwS63OahwRkXlqHYdLodOK7yjI+jcyHar8mBDZi/O0lhyWSXmsvYgt/B2wG6L+
	e5EkDYebvjB0GDiG7TCexvbpenahpUeNRmXEhen0Ggb4eLHz/1f6AMLZrNOTBNRbOIx2rv
	rqK2qy4YR5+HZo7+A6e+6Cwat4dv2aZmmpd2jJzuAG2iLbGMYP4yWH2eBFtDc2SskyO5JE
	2LhtfDxAyHWLonvEqYjAskaXRAZsite7gFZP88CF2Blti9gMqntFnT2yGdvOq4RKV0vuQO
	JqEMx8952Vmj3kInv6uNgwYG1yAH8V8rAT+DjZUh7lao1tBHHmflYTHzS3zvXg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 26 Feb 2024 14:40:02 +0100
Subject: [PATCH net-next v9 11/13] net: macb: Convert to
 netdev_ptp_clock_register
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-feature_ptp_netnext-v9-11-455611549f21@bootlin.com>
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
2.25.1


