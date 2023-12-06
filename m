Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC269807461
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442569AbjLFQCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379475AbjLFQCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:02:21 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB243D53;
        Wed,  6 Dec 2023 08:02:26 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-33340c50af9so951581f8f.3;
        Wed, 06 Dec 2023 08:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701878545; x=1702483345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zG7SQ3nt22s7aPB9I3TG8nIZ5jLLvdFyo6G2GgEBMKU=;
        b=jsbd0kZhk9+GOfzIG4LhH+dpydtjK/DhNYslk7aMUAdVU6lYrGNCbVIeYIRxqMXgx4
         De09L9aGXBl0XXE8VcFjYj/uhRiKQr8rEGxrp8ZphG5t/EY0s3Yx6p54t/GTjIGHceQS
         da3rv+CxHkmE/rZ5B181ymGWMTgUU1FuwYYlpQ0KzqyQA4kqkxOzyzRcaQ5KVlSCR8gy
         NF56fuO2ewK2QzdTRDKzO2bHTpiRxZJgTRgc1s5BoZFBT//Rxzb5fQ6TpSRiGwvw/AUl
         Md63W5zzHAaKdk8Gx1hXIJBhoey6XxzuDCS33Y0OqoVIFs6ZvftBfizNJ/l7GwI4UufC
         +6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701878545; x=1702483345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zG7SQ3nt22s7aPB9I3TG8nIZ5jLLvdFyo6G2GgEBMKU=;
        b=wJPxy1CTrExTaBnwgSzWP9IXu3Hs3zGQkcO1IVh0OsvBkB6a8eFPZM84O1frllLoVx
         Ay1Iq2Ns13dpv1VDk2MFSH6/FUsTIontpQqyyxkzMqxjtLuNcob+SmOFD//2K8W50h13
         o52+xZ19FHlAUFDA05gLKS7hg0SVn2nx10zRAYht+K4rzOuV7VgJ0eRhuWPisvMBS3wi
         gQHPo1aCNIXcg+tyXWxz1g1kvXY+sj+8PZ3s5y5BjLwmR5Kw/E7S7S6eDyQar6QHCf4n
         4f9q7u/Kr2i3wHGYJ6E8ms8l+jNhkRu9Km4KfTGfjdjQvbDRbQSx9PyPPX7uD+JLA7G0
         Ys1A==
X-Gm-Message-State: AOJu0YwfTtZ4Ydj2PAp8x8xR6anxQ/IfO0f30qooY5NaneXrJExqGRUM
        QNd20HHibVuAH1/ZMgTcls4=
X-Google-Smtp-Source: AGHT+IGItrE9PTrIyQAyk02JCAiMje/3NlEVAFnS4K9GDLMSGhFGo97sS86ETnmWMbt/4ll9z0vCcA==
X-Received: by 2002:a05:600c:5494:b0:40b:5e1e:fb99 with SMTP id iv20-20020a05600c549400b0040b5e1efb99mr506982wmb.78.1701878544799;
        Wed, 06 Dec 2023 08:02:24 -0800 (PST)
Received: from eichest-laptop.lan ([2a02:168:af72:0:9e58:15cf:2287:e06c])
        by smtp.gmail.com with ESMTPSA id fj5-20020a05600c0c8500b0040b2b38a1fasm52124wmb.4.2023.12.06.08.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:01:56 -0800 (PST)
From:   Stefan Eichenberger <eichest@gmail.com>
To:     mw@semihalf.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: mvpp2: add support for mii
Date:   Wed,  6 Dec 2023 17:01:25 +0100
Message-Id: <20231206160125.2383281-1-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, mvpp2 only supports RGMII. This commit adds support for MII.
The description in Marvell's functional specification seems to be wrong.
To enable MII, we need to set GENCONF_CTRL0_PORT3_RGMII, while for RGMII
we need to clear it. This is also how U-Boot handles it.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 93137606869e..6f136f42e2bf 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -1513,10 +1513,21 @@ static void mvpp22_gop_init_rgmii(struct mvpp2_port *port)
 	regmap_write(priv->sysctrl_base, GENCONF_PORT_CTRL0, val);
 
 	regmap_read(priv->sysctrl_base, GENCONF_CTRL0, &val);
-	if (port->gop_id == 2)
+	if (port->gop_id == 2) {
 		val |= GENCONF_CTRL0_PORT2_RGMII;
-	else if (port->gop_id == 3)
+	} else if (port->gop_id == 3) {
 		val |= GENCONF_CTRL0_PORT3_RGMII_MII;
+
+		/* According to the specification, GENCONF_CTRL0_PORT3_RGMII
+		 * should be set to 1 for RGMII and 0 for MII. However, tests
+		 * show that it is the other way around. This is also what
+		 * U-Boot does for mvpp2, so it is assumed to be correct.
+		 */
+		if (port->phy_interface == PHY_INTERFACE_MODE_MII)
+			val |= GENCONF_CTRL0_PORT3_RGMII;
+		else
+			val &= ~GENCONF_CTRL0_PORT3_RGMII;
+	}
 	regmap_write(priv->sysctrl_base, GENCONF_CTRL0, val);
 }
 
@@ -1615,6 +1626,7 @@ static int mvpp22_gop_init(struct mvpp2_port *port, phy_interface_t interface)
 		return 0;
 
 	switch (interface) {
+	case PHY_INTERFACE_MODE_MII:
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
@@ -6948,8 +6960,11 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 					MAC_10000FD;
 		}
 
-		if (mvpp2_port_supports_rgmii(port))
+		if (mvpp2_port_supports_rgmii(port)) {
 			phy_interface_set_rgmii(port->phylink_config.supported_interfaces);
+			__set_bit(PHY_INTERFACE_MODE_MII,
+				  port->phylink_config.supported_interfaces);
+		}
 
 		if (comphy) {
 			/* If a COMPHY is present, we can support any of the
@@ -6973,6 +6988,9 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 				  port->phylink_config.supported_interfaces);
 			__set_bit(PHY_INTERFACE_MODE_SGMII,
 				  port->phylink_config.supported_interfaces);
+		} else if (phy_mode == PHY_INTERFACE_MODE_MII) {
+			__set_bit(PHY_INTERFACE_MODE_100BASEX,
+				  port->phylink_config.supported_interfaces);
 		}
 
 		phylink = phylink_create(&port->phylink_config, port_fwnode,
-- 
2.40.1

