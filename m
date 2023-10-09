Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504967BE598
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377906AbjJIPx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377908AbjJIPxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:53:00 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387DD12A;
        Mon,  9 Oct 2023 08:52:44 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB4AA1C0006;
        Mon,  9 Oct 2023 15:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696866763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4AMtsZa6zVIHzUbCNgP42uJl6NOiPb2XmqHr6qtSOk8=;
        b=OUAu5uUl10rdXK/kSRABGinxUBYAX0tqKnedXwm6mighiWm1QSlQlqoTxYxvz4VoRNw+X6
        +GC7juiFx+TR0VYScrXq/97Q2dv2Dzl9MF/B81611FPWxuQop/2wQoGEy7cLG4YzjYs78C
        gvGGfgZ0baXDziXYNRk3AxftqLciQ1kGrZ1zNnCv4avWMHoe76zMvmBxM/LjLNuPabjnM4
        3sFM1LUimU7s0KTrX4FS9I52co5M/5DapRRJ6xDLXYp8YCbkxrCl7myWEwnO+X8Z6enWT+
        WCooxd5IdXTV/d903kMGVk1Go2Hiqo/puV7fndPWmtKHteGy2i8inv7xPysBCA==
From:   =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v5 16/16] netlink: specs: Introduce time stamping set command
Date:   Mon,  9 Oct 2023 17:51:38 +0200
Message-Id: <20231009155138.86458-17-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231009155138.86458-1-kory.maincent@bootlin.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

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
index 81ed8e5f2f55..cfee4bf32128 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1740,3 +1740,12 @@ operations:
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

