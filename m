Return-Path: <linux-kernel+bounces-153378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB158ACD63
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2928C2827B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8AB1509A2;
	Mon, 22 Apr 2024 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MKwCKHCe"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8596B14F108;
	Mon, 22 Apr 2024 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790246; cv=none; b=KFt4KjjE3H/q9ZJ2RDiMl1b3trEs47PkNeqgZAk1OXw20lxQjrvD24mZc0hyzdYclw7i5zODr61REZjaC6V3Oxsvw43HfFDroweESChJxGZSPJyhKSj1y2Lz1n5jqiEwyDFKFZPqpyx1urgO1dVrRcHW0vjvWmJryO74aqeOQ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790246; c=relaxed/simple;
	bh=IjMflVvqVRERvYARWe4LKlkVuXmMgcYCDaoitd2X9iQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=udYF/6sJNhTQeeL9FZeOdRVhqHtrekqh4r+0o1966T4+ID7bIWQKMdKaCzcmliBQqNj4chUxmSvTaGWsjQ5YiBaRm2sFn6vqyYDPA54W4uL1NknePNF0fHww0vy+dihCwr4M9xuw5Eei1W2tklXPwkRrSjHhis01et8FcMOkRoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MKwCKHCe; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 93D8EE0013;
	Mon, 22 Apr 2024 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713790242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrY8w0IMosIqtvCpNeKN+wcauJqxms1gGg8T+SvT1J8=;
	b=MKwCKHCe8cg1oY0alXw9UkshmBhJ+3zzG24lToO0V4TOPu7D35PVfvW7CB1DTPNBGa+fvE
	+Fo8s3WdgBqlOAqW5/cP/tcptGSeqfoOtkYg7MST03CyJEAKIZZBIubM5bR6qpFp1Ni43K
	ji795ZJbiZO9zqKSVLISi8ZB0rBF0IRnxMtmdsTnPP8zZY49Z0XBfVLmjVMMUSeLx6kJeZ
	PuzseVBzel9oRLla02RRMwUrMyePn6BeuyqD6QkpMLGMjs0sEMkWAnacnmLQudnc1BjtxY
	qwCbruvjFhpBuUm2B7pUpesehFfg/TIBe0i3DLSsKXNnzm+JVZj2hReqO/oU+w==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 22 Apr 2024 14:50:21 +0200
Subject: [PATCH net-next v11 06/13] net: net_tstamp: Add unspec field to
 hwtstamp_source enumeration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-feature_ptp_netnext-v11-6-f14441f2a1d8@bootlin.com>
References: <20240422-feature_ptp_netnext-v11-0-f14441f2a1d8@bootlin.com>
In-Reply-To: <20240422-feature_ptp_netnext-v11-0-f14441f2a1d8@bootlin.com>
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

Prepare for future support of saving hwtstamp source in PTP xarray by
introducing HWTSTAMP_SOURCE_UNSPEC to hwtstamp_source enum, setting it
to 0 to match old behavior of no source defined.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v8:
- New patch
---
 include/linux/net_tstamp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index 3799c79b6c83..662074b08c94 100644
--- a/include/linux/net_tstamp.h
+++ b/include/linux/net_tstamp.h
@@ -14,6 +14,7 @@
 					 SOF_TIMESTAMPING_RAW_HARDWARE)
 
 enum hwtstamp_source {
+	HWTSTAMP_SOURCE_UNSPEC,
 	HWTSTAMP_SOURCE_NETDEV,
 	HWTSTAMP_SOURCE_PHYLIB,
 };

-- 
2.34.1


