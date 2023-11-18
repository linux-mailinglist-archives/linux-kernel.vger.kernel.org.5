Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EA67EFFCA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 14:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjKRNPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 08:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjKRNPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 08:15:04 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7051ED76;
        Sat, 18 Nov 2023 05:14:59 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D183920004;
        Sat, 18 Nov 2023 13:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1700313298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QHMSEER/SBEH4IqK5yT4ZrjQxH8VpFrbj9NbOVlG2+g=;
        b=WaKbZMD90W3n3aSXSb3a0ZAU/mvWWrOzYmu/OX+FjY2U++BzndNh1VYokHs8s9NcqXZBQO
        HjEAkUBwmEAut1Au+7mXn76E7pg4Fvyc9hZYocLl8hf7ondvoS0S/SKOtlHiUzcdSmNQkX
        wLJNarbKsxYgD8Pod5XGAnzQ6QJ8YK3mRXIe/gI/LxOzODeOHgLAJ0FJ3/4EsT/dY+5pnw
        0ank40KApmUlWos2qsif/6/gW7SE8P7aW/Co7YVTgZY5baXpE1j3a5NAH8O+yqto4/L3iY
        jdYgq6gdqTWVF+RkZF7NRQtgANtLpKvumYvDotECsgxItT2b9J+RS+EAKAVOWQ==
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com
Subject: [PATCH net-next 15/15] net: dsa: mt7530: do not clear config->supported_interfaces
Date:   Sat, 18 Nov 2023 16:13:17 +0300
Message-Id: <20231118131317.295591-5-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118123205.266819-1-arinc.unal@arinc9.com>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to clear the config->supported_interfaces bitmap before
reporting the supported interfaces as all bits in the bitmap will already
be initialized to zero when the phylink_config structure is allocated.
There's no code that would change the bitmap beforehand. Remove it.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mt7530.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index ca42005ff3a9..20ae147b823e 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2558,8 +2558,6 @@ static void mt7531_mac_port_get_caps(struct dsa_switch *ds, int port,
 static void mt7988_mac_port_get_caps(struct dsa_switch *ds, int port,
 				     struct phylink_config *config)
 {
-	phy_interface_zero(config->supported_interfaces);
-
 	switch (port) {
 	/* Internal PHY */
 	case 0 ... 3:
-- 
2.40.1

