Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA489779E7D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 11:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbjHLJSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 05:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbjHLJSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 05:18:12 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCFA2D79;
        Sat, 12 Aug 2023 02:17:50 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2644E1BF206;
        Sat, 12 Aug 2023 09:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1691831869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nM1ZFvnilyS/G7EEYijFjzJbjPNmckCw5XEVt7NtpBM=;
        b=M4LDCttven4/mL4MjnPQuo743z5iornYXnvRxiUnGVZocjSnNA+CppF4S0xPXmg2sPM7x+
        ItaVc7rMbi2HOmaNuT+HKtnYvgr+5IBEYWDh3OVmx7E//mx5oTt7DiNeSjjO9ozovrI/wz
        9/GTRfOmKH7QxJTv4e4WfgFhl2DJIpHHZymY5sVN7R7F+/1uMao4IOeidWj482wAn89qJx
        t3taZ4B7D8UKkJc0UpFLT61rIFgi+t0/VNzZxFcoFZk9f5X27nzpEi+k8Pg4mNo0TCVI0H
        HZPVb9RNO7Ob51Ra1mK8fcIwU6GOoi4LeQJvpyt8NQrG0WQuXVP0hXGUlKaLrQ==
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
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
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     David Bauer <mail@david-bauer.net>, mithat.guner@xeront.com,
        erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 4/4] net: dsa: mt7530: register OF node for internal MDIO bus
Date:   Sat, 12 Aug 2023 12:17:08 +0300
Message-Id: <20230812091708.34665-5-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230812091708.34665-1-arinc.unal@arinc9.com>
References: <20230812091708.34665-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 8fbda739c1b3..9bb805de397a 100644
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
2.39.2

