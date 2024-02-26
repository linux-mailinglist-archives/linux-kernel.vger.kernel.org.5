Return-Path: <linux-kernel+bounces-81502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3BD8676CA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5598428A793
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221CB129A72;
	Mon, 26 Feb 2024 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jyWDgClZ"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316D47FBAA;
	Mon, 26 Feb 2024 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954816; cv=none; b=STo3lIML/daSBq3lmgvOrrp74cZYENig6qoNtytsBw/QkkKlf/IZ2A6jR1w/jJ2FmdRMfMjdmfvvdPFOw9BjWEr/BO0K5UgXJoe+EtVVjIlhQvZ4aqg6teTsQED4WyqMrSBvPIcIl8oPwlc6YICRn3qmTmI0STSzMPrnefBuXFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954816; c=relaxed/simple;
	bh=eb+a/Xv56Ez5octPTC/7XpVC8dSgZhMGBPcbfj0ToJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=atdz5Ymw35Lblxcmy+mOUv0FweynT2chuHzOBDCnGNLJjvU1Ik0B2fo5f1ERyPPJx3B142N/A1YSPP1mX3My4xv8CHIbHsnfOCJjAQAafgoE8Rg3/KisnNXtBFVBCcpWSVYAn6nYg47cbb2a3q3zq+hwVpjvx5h8a3QdmePOKwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jyWDgClZ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 406E64000E;
	Mon, 26 Feb 2024 13:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708954812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zlphYMCGiuWzG6g1KZ1t25I7yaE6iY157kAjD3oGCXs=;
	b=jyWDgClZP97L8VV3isb8dRqNzyL64pE/CU3EgXwMCj3DMio8YdM7RIOtf1Tc+Mn9JvlyEO
	MNqRSYzmv3XQ5JbxVgZL2L9+UQ7zRLdTQkMWNhMyEqm1OkjxjJnoVTg2H5NP4qdvHElrvk
	qAv9BWn9qU/bB8JZrpcZvo/DAa5Ei6w355IRpwWk6ZKM0T53xaYnApe9M4CuhhaSKTZ4IB
	SEiPafQUi57iFYhSsiaNH2+qi/1v+itMECtdlnm04YRm4VoBLmoPzxtn6Cct587azi4SCp
	03zgtbJ/u7IJnb5XGRG54XZKjkMBIildFeIVdpMT9oaR4p8PCpFxh+2RoxuwOg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 26 Feb 2024 14:39:52 +0100
Subject: [PATCH net-next v9 01/13] net_tstamp: Add TIMESTAMPING SOFTWARE
 and HARDWARE mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-feature_ptp_netnext-v9-1-455611549f21@bootlin.com>
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
 Kory Maincent <kory.maincent@bootlin.com>, 
 Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Timestamping software or hardware flags are often used as a group,
therefore adding these masks will ease future use.

I did not use SOF_TIMESTAMPING_SYS_HARDWARE flag as it is deprecated and
not used at all.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v7:
- Move the masks out of uapi to include/linux/net_tstamp.h

Changes in v9:
- Fix commit message typos
---
 include/linux/net_tstamp.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index eb01c37e71e0..3799c79b6c83 100644
--- a/include/linux/net_tstamp.h
+++ b/include/linux/net_tstamp.h
@@ -5,6 +5,14 @@
 
 #include <uapi/linux/net_tstamp.h>
 
+#define SOF_TIMESTAMPING_SOFTWARE_MASK	(SOF_TIMESTAMPING_RX_SOFTWARE | \
+					 SOF_TIMESTAMPING_TX_SOFTWARE | \
+					 SOF_TIMESTAMPING_SOFTWARE)
+
+#define SOF_TIMESTAMPING_HARDWARE_MASK	(SOF_TIMESTAMPING_RX_HARDWARE | \
+					 SOF_TIMESTAMPING_TX_HARDWARE | \
+					 SOF_TIMESTAMPING_RAW_HARDWARE)
+
 enum hwtstamp_source {
 	HWTSTAMP_SOURCE_NETDEV,
 	HWTSTAMP_SOURCE_PHYLIB,

-- 
2.25.1


