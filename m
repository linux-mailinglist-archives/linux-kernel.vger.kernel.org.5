Return-Path: <linux-kernel+bounces-153387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065F18ACD81
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8812B1F212F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F4215359F;
	Mon, 22 Apr 2024 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BGucrOyS"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A6A153505;
	Mon, 22 Apr 2024 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790257; cv=none; b=OwQfwENF1hRrRalgB4bDz+uZGFfiCSmismI/32zLRpsdUgwvrZq6OoAu/YOMgkgPj/wCbgVnc9OVIA7NklxlH6OTz9RnPXcOO/nx3mWxaxeh4qzQU2U070UE2ZEt6XAF1IQYbuXFU9BBUWpTKs3BOnPa6kllSVH9rWX7pDx6qKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790257; c=relaxed/simple;
	bh=qEI9+iVInmUdwyvWghwzJ9fnt6+ljZGyhGys6iPhASw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RX2nyoIjn/jcOVK2wH5DpaX+q+dhexv5PoaZUyHbe1FPIMMiizCKOLUeQkKiPGQRIiGZZ8DnnWLVhv+gdrmvYK3UXAaKFTO4c91i8gvdo0KeTPxpkNXoxxEYhFm0dDsGQA5BBUJ216022XtRC3ULyqMdAa/xphseOQCodikU1mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BGucrOyS; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AFB36E0012;
	Mon, 22 Apr 2024 12:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713790253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oDau1UUzArQJMoURWAmjHOpV0hahq4KJ+hmHXZTqIiI=;
	b=BGucrOySF9plLBcf7u4olowRVyxMMaAxZnXimsqlgJ7Sequoh/eDM+jIHibl4AghAKWKDG
	WIdVVBsfFfABTF1MwobQQwXqSBBbeM2tmEU2w4iKOuJSqmxIgkFtxiopvH4p/x6CYYUQCU
	bRxGQ1SjV+4p5RNEmhOIdaBqJXzUCFVCFhR3DMOsHh3UF+vRSJ4dOd2XsFzYjEq0K2xhCW
	8Z9levYQz2x/zQn6r7SPAOQwcmI4CtcQEbbpouvVVzZ2mHJv5dVzY6h6o/ZQBZJ8YNKEPm
	AvCowSP+OmSlo/aMk/x4KchDHr3yKcVsUnAqlxuRp4sNy6xu1vq2SWPWrslbNg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 22 Apr 2024 14:50:28 +0200
Subject: [PATCH net-next v11 13/13] netlink: specs: tsinfo: Enhance netlink
 attributes and add a set command
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-feature_ptp_netnext-v11-13-f14441f2a1d8@bootlin.com>
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

Add new attributed to tsinfo allowing to get the tsinfo and the hwtstamp
from a phc provider (composed by a phc index and a phc qualifier) on a
netdevice's link.
Add simultaneously a set command to be able to set hwtstamp configuration
for a specified phc provider.

Here is few examples:
/ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --dump tsinfo-get
             --json '{"header":{"dev-name":"eth0"}}'
[{'header': {'dev-index': 3, 'dev-name': 'eth0'},
  'hwtst-provider': {'index': 0, 'qualifier': 0},
  'phc-index': 0,
  'rx-filters': {'bits': {'bit': [{'index': 0, 'name': 'none'},
                                  {'index': 2, 'name': 'some'}]},
                 'nomask': True,
                 'size': 16},
  'timestamping': {'bits': {'bit': [{'index': 0, 'name': 'hardware-transmit'},
                                    {'index': 2, 'name': 'hardware-receive'},
                                    {'index': 6,
                                     'name': 'hardware-raw-clock'}]},
                   'nomask': True,
                   'size': 17},
  'tx-types': {'bits': {'bit': [{'index': 0, 'name': 'off'},
                                {'index': 1, 'name': 'on'}]},
               'nomask': True,
               'size': 4}},
 {'header': {'dev-index': 3, 'dev-name': 'eth0'},
  'hwtst-provider': {'index': 2, 'qualifier': 0},
  'phc-index': 2,
  'rx-filters': {'bits': {'bit': [{'index': 0, 'name': 'none'},
                                  {'index': 1, 'name': 'all'}]},
                 'nomask': True,
                 'size': 16},
  'timestamping': {'bits': {'bit': [{'index': 0, 'name': 'hardware-transmit'},
                                    {'index': 1, 'name': 'software-transmit'},
                                    {'index': 2, 'name': 'hardware-receive'},
                                    {'index': 3, 'name': 'software-receive'},
                                    {'index': 4,
                                     'name': 'software-system-clock'},
                                    {'index': 6,
                                     'name': 'hardware-raw-clock'}]},
                   'nomask': True,
                   'size': 17},
  'tx-types': {'bits': {'bit': [{'index': 0, 'name': 'off'},
                                {'index': 1, 'name': 'on'},
                                {'index': 2, 'name': 'onestep-sync'}]},
               'nomask': True,
               'size': 4}}]

/ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do tsinfo-get
             --json '{"header":{"dev-name":"eth0"},
                      "hwtst-provider":{"index":0, "qualifier":0 }
}'
{'header': {'dev-index': 3, 'dev-name': 'eth0'},
 'hwtst-provider': {'index': 0, 'qualifier': 0},
 'phc-index': 0,
 'rx-filters': {'bits': {'bit': [{'index': 0, 'name': 'none'},
                                 {'index': 2, 'name': 'some'}]},
                'nomask': True,
                'size': 16},
 'timestamping': {'bits': {'bit': [{'index': 0, 'name': 'hardware-transmit'},
                                   {'index': 2, 'name': 'hardware-receive'},
                                   {'index': 6, 'name': 'hardware-raw-clock'}]},
                  'nomask': True,
                  'size': 17},
 'tx-types': {'bits': {'bit': [{'index': 0, 'name': 'off'},
                               {'index': 1, 'name': 'on'}]},
              'nomask': True,
              'size': 4}}

/ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do tsinfo-set
             --json '{"header":{"dev-name":"eth0"},
                      "hwtst-provider":{"index":2, "qualifier":0}}'
None

/ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do tsinfo-get
             --json '{"header":{"dev-name":"eth0"}, "ghwtstamp":1}'
{'header': {'dev-index': 3, 'dev-name': 'eth0'},
 'hwtst-flags': 1,
 'rx-filters': {'bits': {'bit': [{'index': 0, 'name': 'none'}]},
                'nomask': True,
                'size': 16},
 'tx-types': {'bits': {'bit': [{'index': 0, 'name': 'off'}]},
              'nomask': True,
              'size': 4}}

/ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do tsinfo-set
             --json '{"header":{"dev-name":"eth0"},
                      "rx-filters":{"bits": {"bit": {"name":"ptpv2-l4-event"}},
                                    "nomask": 1},
                      "tx-types":{"bits": {"bit": {"name":"on"}},
                                  "nomask": 1}}'
None

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v8:
- New patch

Changes in v10:
- Add ghwtstamp attributes
- Add tsinfo ntf command

Changes in v11:
- Add examples in the commit message.
---
 Documentation/netlink/specs/ethtool.yaml | 43 +++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 00dc61358be8..c25f78fd3893 100644
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
@@ -1406,7 +1425,7 @@ operations:
       notify: eee-get
     -
       name: tsinfo-get
-      doc: Get tsinfo params.
+      doc: Get tsinfo params or hwtstamp config.
 
       attribute-set: tsinfo
 
@@ -1414,6 +1433,8 @@ operations:
         request:
           attributes:
             - header
+            - ghwtstamp
+            - hwtst-provider
         reply:
           attributes:
             - header
@@ -1422,6 +1443,8 @@ operations:
             - rx-filters
             - phc-index
             - stats
+            - hwtst-provider
+            - hwtst-flags
       dump: *tsinfo-get-op
     -
       name: cable-test-act
@@ -1730,3 +1753,21 @@ operations:
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


