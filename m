Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEC6771032
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 16:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjHEOnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 10:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHEOnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 10:43:41 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A4B1FE6;
        Sat,  5 Aug 2023 07:43:38 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qSIUq-0000N9-0A;
        Sat, 05 Aug 2023 14:43:12 +0000
Date:   Sat, 5 Aug 2023 15:42:58 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH RESEND net-next 1/2] net: dsa: mt7530: register OF node for
 internal MDIO bus
Message-ID: <6eb1b7b8dbc3a4b14becad15f0707d4f624ee18b.1691246461.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Bauer <mail@david-bauer.net>

The MT753x switches provide a switch-internal MDIO bus for the embedded
PHYs.

Register a OF sub-node on the switch OF-node for this internal MDIO bus.
This allows to configure the embedded PHYs using device-tree.

Signed-off-by: David Bauer <mail@david-bauer.net>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mt7530.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 8fbda739c1b35..9bb805de397a9 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2152,10 +2152,13 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
 {
 	struct dsa_switch *ds = priv->ds;
 	struct device *dev = priv->dev;
+	struct device_node *np, *mnp;
 	struct mii_bus *bus;
 	static int idx;
 	int ret;
 
+	np = priv->dev->of_node;
+
 	bus = devm_mdiobus_alloc(dev);
 	if (!bus)
 		return -ENOMEM;
@@ -2174,7 +2177,9 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
 	if (priv->irq)
 		mt7530_setup_mdio_irq(priv);
 
-	ret = devm_mdiobus_register(dev, bus);
+	mnp = of_get_child_by_name(np, "mdio");
+	ret = devm_of_mdiobus_register(dev, bus, mnp);
+	of_node_put(mnp);
 	if (ret) {
 		dev_err(dev, "failed to register MDIO bus: %d\n", ret);
 		if (priv->irq)
-- 
2.41.0
