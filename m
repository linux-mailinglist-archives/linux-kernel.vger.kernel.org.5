Return-Path: <linux-kernel+bounces-81514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B2E8676F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46666B20FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2AF12DDA0;
	Mon, 26 Feb 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JZXjSWLU"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787BD12CD96;
	Mon, 26 Feb 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954832; cv=none; b=hqKt+VG59oVeb4zq0zQ8Nfskv/hbihCaWxUrFshYyaxLE58SL6amulGZ67J6JC9egauK0Ga2COJCiDasO3MEj5ym9mdRHa7ZbOZkkebSSMmZpQkjBxVBTuzpHcVh8RIIFoLkypVrWDakhjS+kRE5Nk0aD3pTkAZbS9fCrDb/wLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954832; c=relaxed/simple;
	bh=mxBFK4Fb71lyE8xT3cEVQg0kPCMLh4VSthxx6LrQ+zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=etwhFUX6K4YwlEYLiIUDd2rDc/5cAdvIZ/l6h6EnjhdKmENbi98v30JT/t7EKBqvtkZSAIb1wBhFRPxyOx1EhzHn8Xqa0p8Xkgbzs2jtiXHtqM7CfJEx2DQDCx4uXnFt9chXGOPCwN+AmvJxzsVrHAVWse6vX6KoPbgfCb34efY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JZXjSWLU; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CBD8940013;
	Mon, 26 Feb 2024 13:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708954829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrBO2wzt0J4arvEYzmCu+K7sTUcd+qHj9mVz8SibBag=;
	b=JZXjSWLUrESjvPrFd6EacFInYe+qO37RXCU5SMvm+LcRYIuU5HzGg/Kn4TnEvuACtuF4jR
	PFlcnvboWwlgl+VOvLKZAoUauutf3cG40+3N3uUfuZBTIHaKhU4FIp3yf8m//RYjcgBiwY
	xjQHJUFWAPSdg7qydXEiqStxh4cI3NB/4wOZebJeN3vBN4U6BBqLIAhtkypbci+5KVsegF
	P5M14iCwWo9p6bNPZjE9nD9BEHZWQ3/sXYlJUSprVBEfyBV2VXi6Bf/x5qCDkgQoC9fAIs
	wBSmYCeKb44VcAtbcHr/oB55AOaCJ3l9ZDrXScvvRf+6H9fsDiOQRAdSHRKkQA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 26 Feb 2024 14:40:04 +0100
Subject: [PATCH net-next v9 13/13] netlink: specs: tsinfo: Enhance netlink
 attributes and add a set command
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-feature_ptp_netnext-v9-13-455611549f21@bootlin.com>
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


