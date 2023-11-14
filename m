Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF38B7EAF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjKNLan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjKNL3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:29:50 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFC61984;
        Tue, 14 Nov 2023 03:29:11 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47DF460008;
        Tue, 14 Nov 2023 11:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699961350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gIErH5d4fuafPRZ1oRD3f9Uh+b35aSFdMj2vjIx3tgo=;
        b=AViR/Ta3WgXe1oTzYOBrdqQpF0+TmcGyb/x2XdI6JWNY4T61h3rhpb0/7+JnIRlNu4W76t
        lQxif/0/dxuq0aHyxEth3jO92HY1AIzTmwDWby96n1CyjEpgXx722nCL4y6LDtGaaik2NP
        JxH2d52xUvvJagPgZmQ736Hax1UYsA/tYmymanVGnLnD95592Tyomj9XQ6AjLaXXdQSkKD
        hD4zQNv8uoUeItAbhI21wm5g2ctU1uDYVjIGdZ7iMM+Ns1mD0TuvEms99enDKFcuyVBtGH
        gxDof5MdNb8n8MmPNfmZpfkW0rgc78to85+x591Q+EXXONyHgbIJkAb2GU2pqg==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Tue, 14 Nov 2023 12:28:44 +0100
Subject: [PATCH net-next v7 16/16] netlink: specs: Introduce time stamping
 set command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-feature_ptp_netnext-v7-16-472e77951e40@bootlin.com>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
In-Reply-To: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new commands allowing to set the time stamping.

Example usage :
./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema \
	     --do ts-list-get \
	     --json '{"header":{"dev-name":"eth0"}}'
{'header': {'dev-index': 3, 'dev-name': 'eth0'},
 'ts-list-layer': b'\x02\x00\x00\x00\x01\x00\x00\x00\x05\x00\x00\x00'}

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do ts-set \
	     --json '{"header":{"dev-name":"eth0"}, "ts-layer":5}'
none

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do ts-get \
	     --json '{"header":{"dev-name":"eth0"}}'
{'header': {'dev-index': 3, 'dev-name': 'eth0'}, 'ts-layer': 5}

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 591425f7fa76..06d9120543d3 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1737,3 +1737,12 @@ operations:
           attributes:
             - header
             - ts-list-layer
+    -
+      name: ts-set
+      doc: Set the timestamp device
+
+      attribute-set: ts
+
+      do:
+        request:
+          attributes: *ts

-- 
2.25.1

