Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E377D1193
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377574AbjJTO1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377496AbjJTO1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:27:05 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0614C19E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tQiuhQrJ8ggo4FBxFW6ZKQfCGt5PUIz5lmq5edpww0o=; b=jeGUr4pu7mYokLopgNibLUhvYP
        07tPURncISwq5m+nYCcghK5Ta+K6EMPO4cxG/KdBMPSrNOaxdmtYMIFFIgS1EA164iiOv0Ed3DAZ8
        99oXxnAeeoMk9/RQslBt1mgKYOnPIBe4lgujORjW4+u0S4Owa1sHGmJSYd0RsIG1dKsFBwBGd3J42
        J2U7T3oZRgzqIax22N15HRU05bfDcpRHKnmw2lHwDQTwfJiw7i+Pg4mUbCOl2j/FGpYkQ3V2wcr+n
        7DZHmF4ixw4RopxMvWKHWz1KTBTd+17+Ikq4cKxpvtzUwCuintsocjG6lino+94sYukF2gKuJbFgc
        0e5fUP/g==;
Received: from [192.168.1.4] (port=55476 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qtqR6-00076N-1Y;
        Fri, 20 Oct 2023 16:25:12 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 20 Oct 2023 16:25:11 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <netdev@vger.kernel.org>
CC:     <woojung.huh@microchip.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <marex@denx.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <o.rempel@pengutronix.de>,
        Ante Knezic <ante.knezic@helmholz.de>
Subject: [PATCH net-next v4 2/2] net: dsa: microchip: add property to select internal RMII reference clock
Date:   Fri, 20 Oct 2023 16:25:04 +0200
Message-ID: <492ba34018bd5035bcc33402746df121df172f73.1697811160.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1697811160.git.ante.knezic@helmholz.de>
References: <cover.1697811160.git.ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/net/dsa/microchip/ksz8795.c     | 28 ++++++++++++++++++++++------
 drivers/net/dsa/microchip/ksz8795_reg.h |  3 +++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 4bf4d67557dc..b0a305b7c37e 100644
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
@@ -1391,18 +1394,28 @@ void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
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
+	bool rmii_clk_internal;
+
+	if (!ksz_is_ksz88x3(dev))
+		return;
+
+	rmii_clk_internal = of_property_read_bool(dev->dev->of_node,
+						  "microchip,rmii-clk-internal");
+
+	ksz_cfg(dev, KSZ88X3_REG_FVID_AND_HOST_MODE,
+		KSZ88X3_PORT3_RMII_CLK_INTERNAL, rmii_clk_internal);
+}
+
 void ksz8_config_cpu_port(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
@@ -1419,6 +1432,9 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 
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

