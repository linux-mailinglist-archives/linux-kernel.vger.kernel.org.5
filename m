Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469B0804FB9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344919AbjLEKEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjLEKEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:04:05 -0500
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B04AA9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mBG79ySu9+IXUdtJ397io8YOO6SGj6GBD/LPhT5sWXs=; b=yElEAEQ6GInNZi3WnPqptXA3df
        e3JVEG5zBt2FcMu1sFwwRNKFhjzg72kNmGQJQSDpStnPLMorkKWVmg6rTOa4uHktgknJUBM1Ru8Rs
        eDqtvA8dV0ar1Bn6Ip0iccZ6PJ/mKmk+cZgbWsKnwmFLBqy+85FKxc0YK4Y9cp8n/syNQ0BZfgI7t
        L84sDtli8+7E6P4SGFMG5carIyiJ2dAdd41DezNoowhVlPBVEqJ32Guo8Ocqd7DHLMZcslaeZUut1
        3ieCmjdYXHhzrTK46vQGjrwJ46+FXmTaqF+8KjjIEcTzyxAsW7rIMok/FBWwy0BWmoI07ljhMV0Ff
        Qsr6+hwg==;
Received: from [192.168.1.4] (port=29475 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1rASHQ-0005Tl-1P;
        Tue, 05 Dec 2023 11:03:52 +0100
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 5 Dec 2023 11:03:51 +0100
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <netdev@vger.kernel.org>
CC:     <woojung.huh@microchip.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <marex@denx.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>,
        Ante Knezic <ante.knezic@helmholz.de>
Subject: [PATCH net-next v7 2/2] net: dsa: microchip: add property to select internal RMII reference clock
Date:   Tue, 5 Dec 2023 11:03:39 +0100
Message-ID: <c309c907d7e1dd34dcc782e23ec0344aeadf2955.1701770394.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1701770394.git.ante.knezic@helmholz.de>
References: <cover.1701770394.git.ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microchip KSZ8863/KSZ8873 have the ability to select between internal
and external RMII reference clock. By default, reference clock
needs to be provided via REFCLKI_3 pin. If required, device can be
setup to provide RMII clock internally so that REFCLKI_3 pin can be
left unconnected.
Add a new "microchip,rmii-clk-internal" property which will set
RMII clock reference to internal. If property is not set, reference
clock needs to be provided externally.

While at it, move the ksz8795_cpu_interface_select() to
ksz8_config_cpu_port() to get a cleaner call path for cpu port.

Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
 drivers/net/dsa/microchip/ksz8795.c     | 29 +++++++++++++++++++++++------
 drivers/net/dsa/microchip/ksz8795_reg.h |  3 +++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index ec1ddfcf7473..61b71bcfe396 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -1358,6 +1358,9 @@ static void ksz8795_cpu_interface_select(struct ksz_device *dev, int port)
 {
 	struct ksz_port *p = &dev->ports[port];
 
+	if (!ksz_is_ksz87xx(dev))
+		return;
+
 	if (!p->interface && dev->compat_interface) {
 		dev_warn(dev->dev,
 			 "Using legacy switch \"phy-mode\" property, because it is missing on port %d node. "
@@ -1391,18 +1394,29 @@ void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 	/* enable 802.1p priority */
 	ksz_port_cfg(dev, port, P_PRIO_CTRL, PORT_802_1P_ENABLE, true);
 
-	if (cpu_port) {
-		if (!ksz_is_ksz88x3(dev))
-			ksz8795_cpu_interface_select(dev, port);
-
+	if (cpu_port)
 		member = dsa_user_ports(ds);
-	} else {
+	else
 		member = BIT(dsa_upstream_port(ds, port));
-	}
 
 	ksz8_cfg_port_member(dev, port, member);
 }
 
+static void ksz88x3_config_rmii_clk(struct ksz_device *dev)
+{
+	struct dsa_port *cpu_dp = dsa_to_port(dev->ds, dev->cpu_port);
+	bool rmii_clk_internal;
+
+	if (!ksz_is_ksz88x3(dev))
+		return;
+
+	rmii_clk_internal = of_property_read_bool(cpu_dp->dn,
+						  "microchip,rmii-clk-internal");
+
+	ksz_cfg(dev, KSZ88X3_REG_FVID_AND_HOST_MODE,
+		KSZ88X3_PORT3_RMII_CLK_INTERNAL, rmii_clk_internal);
+}
+
 void ksz8_config_cpu_port(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
@@ -1419,6 +1433,9 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 
 	ksz8_port_setup(dev, dev->cpu_port, true);
 
+	ksz8795_cpu_interface_select(dev, dev->cpu_port);
+	ksz88x3_config_rmii_clk(dev);
+
 	for (i = 0; i < dev->phy_port_cnt; i++) {
 		ksz_port_stp_state_set(ds, i, BR_STATE_DISABLED);
 	}
diff --git a/drivers/net/dsa/microchip/ksz8795_reg.h b/drivers/net/dsa/microchip/ksz8795_reg.h
index 3c9dae53e4d8..beca974e0171 100644
--- a/drivers/net/dsa/microchip/ksz8795_reg.h
+++ b/drivers/net/dsa/microchip/ksz8795_reg.h
@@ -22,6 +22,9 @@
 #define KSZ8863_GLOBAL_SOFTWARE_RESET	BIT(4)
 #define KSZ8863_PCS_RESET		BIT(0)
 
+#define KSZ88X3_REG_FVID_AND_HOST_MODE  0xC6
+#define KSZ88X3_PORT3_RMII_CLK_INTERNAL BIT(3)
+
 #define REG_SW_CTRL_0			0x02
 
 #define SW_NEW_BACKOFF			BIT(7)
-- 
2.11.0

