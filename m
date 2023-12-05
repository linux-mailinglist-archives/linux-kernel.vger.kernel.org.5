Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512A880506D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346707AbjLEKgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376509AbjLEKgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:36:31 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3751410C2;
        Tue,  5 Dec 2023 02:36:24 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bf898c43cso1911603e87.1;
        Tue, 05 Dec 2023 02:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701772583; x=1702377383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIQUz6kTrVuZdOXLZo+ge/Lp9pWSfj/oMDcXilwbtBU=;
        b=WnV/f3onP8/30wP4P9dVebUf5Fpw65Cn37stmcLQHJX0xG8zmEOalAdONJSika55/v
         B8LV6eBCROoM6/Tqm2yXZitri1dUKJwoiNvZzJth2r3ZQbgCUhNtriM52pTm80CMyfbI
         rbIQOEbY8IfZNtcjVLY5ucXBlTSN0nkVZopEbioZHmJq/E9PKisIxuvuSKz7FsWz/UYZ
         ZAm7cwVUUZCgVJnMIxSSZ1HyNNPCunqoJOW53+U1jspX27p7Fls4Qz6br203F0S1Guhd
         +T425g1uRQhUK1EdcBUTsiGC6D+78VGmCVw1lM/X3bS1SBQqVQPlQCH3EUQvpeKysPcH
         UkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701772583; x=1702377383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIQUz6kTrVuZdOXLZo+ge/Lp9pWSfj/oMDcXilwbtBU=;
        b=SXUnqDtLgtSU2K3to0dGSW0FqEPzBxVpYKFJP5f3e2tVek15TIiI5ns9ULQ4pcy6RV
         itRsebqVQITzB1SpsbtrHVFyoK5/1hpAzpYuedmZfjJZOHPaMB055gNoqhbz9zZe4KuU
         Vu0e2vgKEX/aT6jPcFxaCPN1DA60CfNrTGHXYcqgTpyL7PLm4djRytuKUqJH2TdUgzBY
         8qSPGicNE2h97G+pI45/+2ykJEXRykrJAN6N+kXvCDesbtHiOSK0U8KinACvsxcxAu6g
         1S6T8omr3/xXDacCppaAkDcITdD8H9ykt4UEODXBAD1XDuCEMwQ5RJKR/YM/0YUMf66L
         W+iQ==
X-Gm-Message-State: AOJu0Yx4M0U1NZK5sP7nxZR0RrAqNzW69ki2osUP0JFOxpTFnf06U3d8
        LiiVfQ0U9J7f3swVxlMvEXM=
X-Google-Smtp-Source: AGHT+IGX6hxolloUWCXauP85aEGl4KFj8FADRPvac0Qo990dFIzZotJOwEw2Nm39AzLMj98ISD+EcQ==
X-Received: by 2002:ac2:5a50:0:b0:50b:fea2:4cdc with SMTP id r16-20020ac25a50000000b0050bfea24cdcmr583327lfn.172.1701772582731;
        Tue, 05 Dec 2023 02:36:22 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id c10-20020ac25f6a000000b0050c0514fdf4sm146106lfc.127.2023.12.05.02.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:36:22 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 11/16] net: pcs: xpcs: Change xpcs_create_mdiodev() suffix to "byaddr"
Date:   Tue,  5 Dec 2023 13:35:32 +0300
Message-ID: <20231205103559.9605-12-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231205103559.9605-1-fancer.lancer@gmail.com>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
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

The fwnode-based way of creating XPCS descriptor is about to be added. In
order to have a function name distinguishable from the already implemented
xpcs_create_mdiodev() method convert the later name to be
xpcs_create_byaddr() which BTW better describes the method semantic in
anyway.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/dsa/sja1105/sja1105_mdio.c            | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 2 +-
 drivers/net/pcs/pcs-xpcs.c                        | 6 +++---
 include/linux/pcs/pcs-xpcs.h                      | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_mdio.c b/drivers/net/dsa/sja1105/sja1105_mdio.c
index 833e55e4b961..9101079e365d 100644
--- a/drivers/net/dsa/sja1105/sja1105_mdio.c
+++ b/drivers/net/dsa/sja1105/sja1105_mdio.c
@@ -409,7 +409,7 @@ static int sja1105_mdiobus_pcs_register(struct sja1105_private *priv)
 		    priv->phy_mode[port] != PHY_INTERFACE_MODE_2500BASEX)
 			continue;
 
-		xpcs = xpcs_create_mdiodev(bus, port, priv->phy_mode[port]);
+		xpcs = xpcs_create_byaddr(bus, port, priv->phy_mode[port]);
 		if (IS_ERR(xpcs)) {
 			rc = PTR_ERR(xpcs);
 			goto out_pcs_free;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index fa9e7e7040b9..aa75e4f1e212 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -507,7 +507,7 @@ int stmmac_xpcs_setup(struct mii_bus *bus)
 
 	/* Try to probe the XPCS by scanning all addresses. */
 	for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
-		xpcs = xpcs_create_mdiodev(bus, addr, mode);
+		xpcs = xpcs_create_byaddr(bus, addr, mode);
 		if (IS_ERR(xpcs))
 			continue;
 
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 183a37929b60..e376e255f1d3 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1511,8 +1511,8 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
 	return ERR_PTR(ret);
 }
 
-struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
-				    phy_interface_t interface)
+struct dw_xpcs *xpcs_create_byaddr(struct mii_bus *bus, int addr,
+				   phy_interface_t interface)
 {
 	struct mdio_device *mdiodev;
 	struct dw_xpcs *xpcs;
@@ -1535,7 +1535,7 @@ struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
 
 	return xpcs;
 }
-EXPORT_SYMBOL_GPL(xpcs_create_mdiodev);
+EXPORT_SYMBOL_GPL(xpcs_create_byaddr);
 
 void xpcs_destroy(struct dw_xpcs *xpcs)
 {
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index 53adbffb4c0a..b11bbb5e820a 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -73,8 +73,8 @@ int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces);
 int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns,
 		    int enable);
-struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
-				    phy_interface_t interface);
+struct dw_xpcs *xpcs_create_byaddr(struct mii_bus *bus, int addr,
+				   phy_interface_t interface);
 void xpcs_destroy(struct dw_xpcs *xpcs);
 
 #endif /* __LINUX_PCS_XPCS_H */
-- 
2.42.1

