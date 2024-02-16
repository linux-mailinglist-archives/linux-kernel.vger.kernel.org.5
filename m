Return-Path: <linux-kernel+bounces-68922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2138C8581F6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C168B254E4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A5D1369A1;
	Fri, 16 Feb 2024 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U72O1Mzd"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896411350CC;
	Fri, 16 Feb 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098795; cv=none; b=MV/oj3X6EkswvswqKAgFSzufZMt+wzmMoUSktqTPFRbY2F0RTbWzNS3AW38o5k58+YQM84QCliB4E3vfCoQWKvB250Zg05heomzpjSv+MCvksykEUIOLX2Rf0RO5ma4/WG7w3qhiZiyn7PHJhLX5vkZ/NZyQJbiBIWmmyJXX8UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098795; c=relaxed/simple;
	bh=mxBFK4Fb71lyE8xT3cEVQg0kPCMLh4VSthxx6LrQ+zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EcYcDAHoIza8vTGxN9oAiT/G5C7lX3leUmfMvACwNXZzmM51rtfKspojuOfxYhydOebXpytlqLT4jNGEDhF0c80ddrAY8mHU5AugEHqaEAeHcNSidXBT1z8zA2UoN1+KCdz3H9Z2tyof7/J5i87RNLhSWUPhZgK+ESeErzYvI2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U72O1Mzd; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D1B35240014;
	Fri, 16 Feb 2024 15:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708098791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrBO2wzt0J4arvEYzmCu+K7sTUcd+qHj9mVz8SibBag=;
	b=U72O1MzdaaSHoWqTPgTIH721SmoYlSoYg2d9SFUS6k6i6ZfPCN/QdxB6fxw2Zzj2UXCeen
	IzaF3/1jgZ7eeULzsawMjo2jaT2mzNyCTGjN0kEQrIdmOnb7VaHiE/No0KjFwXVqUlAXWm
	j9JQSZ44jnJ8Zax7vUOsO7yosbeLOs4i4j0kRV8PnvI0OUuykB/vXwCqlViK30nR778S9m
	yNOne0ScrADlRW8lbt3iRkiln+mRu/j0orwYpJTpd+VIlMbyM2XHsg4F41L9Vhnzmlgg4G
	pMGR9PgdQ41HifmBIaXzY233i3/Wm1NU1ynQo8HRtUlOmMQU8p+df2bZDPrHcQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 16 Feb 2024 16:52:31 +0100
Subject: [PATCH RFC net-next v8 13/13] netlink: specs: tsinfo: Enhance
 netlink attributes and add a set command
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-feature_ptp_netnext-v8-13-510f42f444fb@bootlin.com>
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

Add new attributed to tsinfo allowing to get the tsinfo and the hwtstamp
from a phc provider (composed by a phc index and a phc qualifier) on a
netdevice's link.
Add simultaneously a set command to be able to set hwtstamp configuration
for a specified phc provider.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v8:
- New patch
---
 Documentation/netlink/specs/ethtool.yaml | 35 +++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 197208f419dc..cfe48f8d6283 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -559,6 +559,15 @@ attribute-sets:
       -
         name: tx-lpi-timer
         type: u32
+  -
+    name: tsinfo-hwtst-provider
+    attributes:
+      -
+        name: index
+        type: u32
+      -
+        name: qualifier
+        type: u32
   -
     name: tsinfo
     attributes:
@@ -581,6 +590,13 @@ attribute-sets:
       -
         name: phc-index
         type: u32
+      -
+        name: hwtst-provider
+        type: nest
+        nested-attributes: tsinfo-hwtst-provider
+      -
+        name: hwtst-flags
+        type: u32
   -
     name: cable-result
     attributes:
@@ -1373,7 +1389,7 @@ operations:
       notify: eee-get
     -
       name: tsinfo-get
-      doc: Get tsinfo params.
+      doc: Get tsinfo params or hwtstamp config.
 
       attribute-set: tsinfo
 
@@ -1381,6 +1397,7 @@ operations:
         request:
           attributes:
             - header
+            - hwtst-provider
         reply:
           attributes:
             - header
@@ -1388,6 +1405,8 @@ operations:
             - tx-types
             - rx-filters
             - phc-index
+            - hwtst-provider
+            - hwtst-flags
       dump: *tsinfo-get-op
     -
       name: cable-test-act
@@ -1693,3 +1712,17 @@ operations:
       name: mm-ntf
       doc: Notification for change in MAC Merge configuration.
       notify: mm-get
+    -
+      name: tsinfo-set
+      doc: Set hwtstamp.
+
+      attribute-set: tsinfo
+
+      do:
+        request:
+          attributes:
+            - header
+            - tx-types
+            - rx-filters
+            - hwtst-provider
+            - hwtst-flags

-- 
2.25.1


