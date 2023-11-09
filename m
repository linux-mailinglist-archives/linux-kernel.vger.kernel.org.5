Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3D17E73F8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345325AbjKIVwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbjKIVvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:51:51 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6581B44B3;
        Thu,  9 Nov 2023 13:51:49 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1r1Cw6-0003XH-0Q;
        Thu, 09 Nov 2023 21:51:38 +0000
Date:   Thu, 9 Nov 2023 21:51:34 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Couzens <lynxis@fe80.eu>,
        Daniel Golle <daniel@makrotopia.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: [RFC PATCH 4/8] net: pcs: pcs-mtk-lynxi: allow calling with NULL
 advertising
Message-ID: <0dcc5efc480b640d184046ba405a44bada88f88b.1699565880.git.daniel@makrotopia.org>
References: <cover.1699565880.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699565880.git.daniel@makrotopia.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow calling pcs_config with advertising set to NULL and in this case
keep the previously assigned advertisement.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/pcs/pcs-mtk-lynxi.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index 6204448d8eac6..1372653c3d422 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -81,6 +81,7 @@ struct mtk_pcs_lynxi {
 	phy_interface_t		interface;
 	struct			phylink_pcs pcs;
 	u32			flags;
+	int			advertise;
 };
 
 static struct mtk_pcs_lynxi *pcs_to_mtk_pcs_lynxi(struct phylink_pcs *pcs)
@@ -121,11 +122,19 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	unsigned int rgc3, sgm_mode, bmcr;
 	int advertise, link_timer;
 
-	advertise = phylink_mii_c22_pcs_encode_advertisement(interface,
-							     advertising);
-	if (advertise < 0)
-		return advertise;
+	if (advertising) {
+		advertise = phylink_mii_c22_pcs_encode_advertisement(interface,
+								     advertising);
+		if (advertise < 0)
+			return advertise;
 
+		mpcs->advertise = advertise;
+	} else {
+		if (mpcs->advertise < 0)
+			return -EINVAL;
+
+		advertise = mpcs->advertise;
+	}
 	/* Clearing IF_MODE_BIT0 switches the PCS to BASE-X mode, and
 	 * we assume that fixes it's speed at bitrate = line rate (in
 	 * other words, 1000Mbps or 2500Mbps).
@@ -299,6 +308,7 @@ struct phylink_pcs *mtk_pcs_lynxi_create(struct device *dev,
 	mpcs->pcs.neg_mode = true;
 	mpcs->pcs.poll = true;
 	mpcs->interface = PHY_INTERFACE_MODE_NA;
+	mpcs->advertise = -1;
 
 	return &mpcs->pcs;
 }
-- 
2.42.1
