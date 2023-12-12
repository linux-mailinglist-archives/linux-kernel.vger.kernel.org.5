Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903C080EE74
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376433AbjLLOL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjLLOL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:11:57 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD359FF;
        Tue, 12 Dec 2023 06:12:02 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-336356d9092so263881f8f.2;
        Tue, 12 Dec 2023 06:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702390321; x=1702995121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pwano9guwZgppKOMB5aK4J4782C3dg8VANWXqW1Jv/c=;
        b=khkQlVtJs8MSXYRAN5wSrbK8t/Ky9YjqhQgy8B5S6Iw1YsxPhKJmWeocvnNxND9P4y
         geTm6pbrOfexcYtiWx2M+5see8KhTyL5gjt8TPXn/bbh3XtUTszoZTpjcX5FU+ON9Qzv
         CA+/fAYf5JVvQIw4vWBdqwd55DQhnsYnB1YJrduPepJV2a/ckNHOzNcBOuT8dnrTmfsT
         WAEy2XuGniKhqoaxUihBYOVIHw2diTD/77aNeMX9ZfzNY2ONPK+TogcoiKQTOLi8HFaF
         TF/3xz/GETRgop8ZZCZ6CFF99jx/9ZvZXLe5p3Dz26vRWcxFaDxoMcB45yJ924DT/YN3
         cIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702390321; x=1702995121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pwano9guwZgppKOMB5aK4J4782C3dg8VANWXqW1Jv/c=;
        b=vC96whIY0BXCSjQ/8WdtytROVNNnVIou8DWFterfsf0GyWGoTeUK0ys5avlxRNteL0
         QhgmyQudusMpPGwFUmlMrBpktwlMC7LbRHvDfwLHq3zBUVh1bQkY3j/BKZjm9QQPbAtr
         EFmcXXmlY6XCwAJRu1yvY4fjGghbMbMOKUSZSxrffZELx6LLCTtKpQakMljgkD9SlRnF
         1yHYOF2XKsho/3busYsxMKCAXLTq6Fs7jkOTBpaffYTLt21XgcDSHKxN36BmmKqfPd1Q
         vSECA7BZhRE6t7qOgnk/IzS6TZheClCMbY5s0TMJCYBKvokhZCNWTUb09BxOQMh9VfcF
         LiEw==
X-Gm-Message-State: AOJu0YwffVN/XmbJCTzbwFx5Dav2Ywfsb5YH0T9ilgoHhzjjDazW70mN
        fgMEdvaLstuwXl957MPOPxs=
X-Google-Smtp-Source: AGHT+IHU7VRTf2bVnL21KJoSeULrZCVIcNlyZpBJvxAksi4Ci/dj7EQpfx/j7ClSjfOl9OX7jnsOAA==
X-Received: by 2002:adf:ee47:0:b0:333:2fd2:8170 with SMTP id w7-20020adfee47000000b003332fd28170mr3211089wro.141.1702390321048;
        Tue, 12 Dec 2023 06:12:01 -0800 (PST)
Received: from eichest-laptop.. ([178.197.202.123])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d48d0000000b0033616ea5a0fsm7906913wrs.45.2023.12.12.06.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 06:12:00 -0800 (PST)
From:   Stefan Eichenberger <eichest@gmail.com>
To:     maxime.chevallier@bootlin.com, mw@semihalf.com,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: mvpp2: add support for mii
Date:   Tue, 12 Dec 2023 15:12:00 +0100
Message-Id: <20231212141200.62579-1-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
v2:
- Remove PHY_INTERFACE_MODE_100BASEX from supported_interfaces (Maxime)
---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 93137606869e..c5f72a1ef928 100644
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
-- 
2.40.1

