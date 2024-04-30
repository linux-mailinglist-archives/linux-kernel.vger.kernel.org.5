Return-Path: <linux-kernel+bounces-164312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E11568B7C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFBB2855F6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1364180A9B;
	Tue, 30 Apr 2024 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mkk/wbPn"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE6C176FB2;
	Tue, 30 Apr 2024 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492245; cv=none; b=jCRKy4ACXTs63gRhYb9lG040H6Jw/8IvFjw3YA38wV7jJmzexKo421CvKZ9Uv8B+927zOlRQhcF/LxwwKZdpWBMbIhlbYuzj6qYLju/lwZSjhOmANJ836BbSGQr3D1QVmUu/qswluZPINw6OFLdgxiZ52MFSiwHAthIMAm/a/lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492245; c=relaxed/simple;
	bh=fAoFXYYkIkdenvWHNgGiSslpve99mgAMustoo4fOjKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HoqMpsBxZaNdFhu9n/4t6tbF727wunq2/1sDcrBEfqdxkK4WbQZ13DiKM4rmnCNRtrWxZuQdIlm6p6yLCDcXowfXSfX80k8MKMJUIU1PmeahmCaLWKmpZeBibbnnkiwHAjfPBBoWHqo6yUSao6TXPYgRU/lyDYXc7uuj4Qi/soY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mkk/wbPn; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AFB9120005;
	Tue, 30 Apr 2024 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714492226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fA411foyqLMzZ1hKOUW4fEs/FNUN6uX3elekeFZ7ooQ=;
	b=mkk/wbPnbXS+d1OeGcBbLV07AhUNugjgD24Fc63usL+pcQk0qKUZHIV84XD2p5xvlciOKn
	e6roHX+XxBT9RBzOOGWhxtH5IM/F2a7+wfJ1GY6kI9rcXbfX1qzX40zfcXlO/lssAiaqme
	tfK9n4UgCPInCjJIf0mkoFqqG/KaMZTjmo6vx6MgC+2Ju6fT3BhErLP27EI+AHmypwf/2w
	o2J+7s6348bxG0M2tEwaEAsTiOgYSV6sEHex97viQsZSgmQ//9ghD22Qv3g/A8Bm4BWQaZ
	Rbp0kHwSg9x3d33GHlhY7XvWICHiguqlUI1luMfRxgsvUQ9oWR2jRb6KHwqMUg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 30 Apr 2024 17:49:44 +0200
Subject: [PATCH net-next v12 01/13] net_tstamp: Add TIMESTAMPING SOFTWARE
 and HARDWARE mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-feature_ptp_netnext-v12-1-2c5f24b6a914@bootlin.com>
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
 Kory Maincent <kory.maincent@bootlin.com>, 
 Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.13.0
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
2.34.1


