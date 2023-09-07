Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0997973D0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343492AbjIGPaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245465AbjIGP3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:29:35 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32769CC;
        Thu,  7 Sep 2023 08:29:07 -0700 (PDT)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id C6D36D67E2;
        Thu,  7 Sep 2023 09:24:45 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 85E5140033;
        Thu,  7 Sep 2023 09:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694078664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PP4qFU6v/2wbsuMME7GJXKWzRSZTU8obLf77vj2Y764=;
        b=KqPlFH8SpLqr71N8Xu1HKLtjul2/9Zjh9V+XSbwUv+4bkMcaaxQgyK/zWNqrQmmEC1U31r
        oTwSSBadbMkgeIe6Kh6NIuP0EFiQEAqDyCltAn3BwaSw6PBeTspPkn8PGURCXoMaOiA8LY
        Ey0h4PsgDjnehE0cddYMXLOMwq0aTr+ww4YJCBh3LGcjm5vZy2WuHidQqEPKoFkYmVV+v1
        Lu1VVhJWMBweukhP35zrcRzSzg7vhzDJGnbTy64T/Ugz4GPp6kgBAJg807ss4BF8njg8MV
        M5DC0oH9L1hZlu/AgD8wbrRYn/cOwCWlG19EAEQ+uygoee5FhVGexPNyEXVh9w==
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
        thomas.petazzoni@bootlin.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH net-next 7/7] netlink: specs: add command to show individual phy information
Date:   Thu,  7 Sep 2023 11:24:05 +0200
Message-ID: <20230907092407.647139-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the ETHTOOL_CMD_PHY_LIST_GET command, we can obtain a list of PHYs
on a link, addressable through their phyindex. This index can be used to
issue PHY-specific commands. The phy_get command allows querying per-PHY
information. The information reported so-far is minimal (driver name,
phy id (for C22), upstream PHY type (real PHY, SFP phy), but we can
imagine extending this in the future to report PHY offloading
capabilities, status, and much more.

Example usage :

./cli.py --spec specs/ethtool.yaml --schema genetlink-legacy.yaml \
         --do phy-list-get --json '{"header" : {"dev-name" : "eth0"}}'
{'header': {'dev-index': 2, 'dev-name': 'eth0'},
 'phy-count': 2,
 'phy-indices': b'\x02\x00\x00\x00\x01\x00\x00\x00'}

./cli.py --spec specs/ethtool.yaml --schema genetlink-legacy.yaml \
         --do phy-get \
	 --json '{"header" : {"dev-name" : "eth0"}, "phy-index" : 1}'
{'drvname': 'mv88x3310',
 'header': {'dev-index': 2, 'dev-name': 'eth0'},
 'phy-id': 0,
 'phy-index': 1,
 'phy-upstream-type': 0}

./cli.py --spec specs/ethtool.yaml --schema genetlink-legacy.yaml \
	 --do phy-get \
	 --json '{"header" : {"dev-name" : "eth0"}, "phy-index" : 2}'
{'drvname': 'Marvell 88E1111',
 'header': {'dev-index': 2, 'dev-name': 'eth0'},
 'phy-id': 21040322,
 'phy-index': 2,
 'phy-upstream-type': 2}

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 1139c88ed65c..708a77423286 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -955,6 +955,25 @@ attribute-sets:
       -
         name: phy-indices
         type: binary
+  -
+    name: phy
+    attributes:
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: phy-index
+        type: u32
+      -
+        name: drvname
+        type: string
+      -
+        name: phy-upstream-type
+        type: u8
+      -
+        name: phy-id
+        type: u32
 
 operations:
   enum-model: directional
@@ -1720,3 +1739,21 @@ operations:
             - header
             - phy-count
             - phy-indices
+    -
+      name: phy-get
+      doc: Get a PHY's information
+
+      attribute-set: phy
+
+      do: &phy-get-op
+        request:
+          attributes:
+            - header
+            - phy-index
+        reply:
+          attributes:
+            - header
+            - phy-index
+            - drvname
+            - phy-upstream-type
+            - phy-id
-- 
2.41.0

