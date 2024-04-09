Return-Path: <linux-kernel+bounces-136472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E766889D46E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0611282856
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5720C12F36C;
	Tue,  9 Apr 2024 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GU1+2ygD"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DC612EBCC;
	Tue,  9 Apr 2024 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651245; cv=none; b=WJK1CgIcrZUi7ikVboqlVQC1jWydTRHjz9ZEO3LUCKNVrB8vYNao32dzDb4WSQa5KrPWHf9T2RRGLenTQPLvgOHkwc8q43WWxP9Reu7r1kLkXqyjKXpBlz1xPyNwjjqAF918ThuygSogtOBf6tgYSzFSAdOEf8EQbeybot8Qv+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651245; c=relaxed/simple;
	bh=lVKdy+zL61P8enGhACiE9sR/DJgbSrt7UuNC0MvCIWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SKIUqbt6EbncYKhrP4fSOgnFrfWHG2QTL8zpLJlg8ZjjqTNtDRfjGaC8PagTL5ywQ0/Lnb/rLbi1ZjMdObsRSYcuyc9HGDW+ivZ7Qe0KgSlr5Y9TOGTL/HHsMy4igZRTOvck1gHDp1NOhRZMtcTDj8PpedF7xsdv4N7FuLMhKIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GU1+2ygD; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59509FF817;
	Tue,  9 Apr 2024 08:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712651241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjZRi8Zkv66lwdYQr99nMh1oJn0CswxTAnZJcH9dKfc=;
	b=GU1+2ygDSQFUFlNbw3x8ub+BWB5Nj4ib2GewbXkRK4ohQH8DtaEkAw9rRKLyUCt4Lp560F
	Au1ft1kffQhnCSK67+h4VVX37Ghy0vcwfBl6JLrWmprwJKRu+G2zUpfQo2fcewdi29nP9y
	y5E2Hw4EGaUcAiLLXS1FPuTBw9FZ9/q7Mfk0Y6M4M72GkFPKs6u9DROpPNzAdOSdkn4Bjd
	Gh58zQEDcKn7PcCdgnd8+wc1l0rFyUfM4vBBMmmdX9/syVhLp6Jx4hI17iTqqKupGsiqKb
	XmsZN02Fd5fyc64r50eLu/xY6ZnuaQdPIeuii+IA6S4b108snumSt1lYEGM7kQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 09 Apr 2024 10:26:35 +0200
Subject: [PATCH net-next v10 13/13] netlink: specs: tsinfo: Enhance netlink
 attributes and add a set command
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-feature_ptp_netnext-v10-13-0fa2ea5c89a9@bootlin.com>
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

Add new attributed to tsinfo allowing to get the tsinfo and the hwtstamp
from a phc provider (composed by a phc index and a phc qualifier) on a
netdevice's link.
Add simultaneously a set command to be able to set hwtstamp configuration
for a specified phc provider.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v8:
- New patch

Changes in v10:
- Add ghwtstamp attributes
- Add tsinfo ntf command
---
 Documentation/netlink/specs/ethtool.yaml | 43 +++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 87ae7b397984..fcdedab4607c 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -576,6 +576,15 @@ attribute-sets:
       -
         name: tx-err
         type: uint
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
@@ -602,6 +611,16 @@ attribute-sets:
         name: stats
         type: nest
         nested-attributes: ts-stat
+      -
+        name: ghwtstamp
+        type: u8
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
@@ -1394,7 +1413,7 @@ operations:
       notify: eee-get
     -
       name: tsinfo-get
-      doc: Get tsinfo params.
+      doc: Get tsinfo params or hwtstamp config.
 
       attribute-set: tsinfo
 
@@ -1402,6 +1421,8 @@ operations:
         request:
           attributes:
             - header
+            - ghwtstamp
+            - hwtst-provider
         reply:
           attributes:
             - header
@@ -1410,6 +1431,8 @@ operations:
             - rx-filters
             - phc-index
             - stats
+            - hwtst-provider
+            - hwtst-flags
       dump: *tsinfo-get-op
     -
       name: cable-test-act
@@ -1715,3 +1738,21 @@ operations:
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
+    -
+      name: tsinfo-ntf
+      doc: Notification for change in tsinfo configuration.
+      notify: tsinfo-get

-- 
2.34.1


