Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0A27EFF8B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 13:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjKRMdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 07:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjKRMdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 07:33:09 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B563D61;
        Sat, 18 Nov 2023 04:33:05 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 17AF3E0005;
        Sat, 18 Nov 2023 12:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1700310784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4UChF1BUauN6W28Ee+oXUFPu4N8R5M4US5PAgnczs4=;
        b=TA2qB8QuA710htbz4O+4ZVHGiqJRarLSXwaFP6VonUbPqFGxug1I3vIVoYnE0FFb+RQjeY
        yEGQu6us+mrL/TDiFHy6oxEhFjEh2F6eXa8RZ/80WzTYi7+uwpJFuAuiZxM0Oycgiyg7fj
        XUcI4Z8SUCUFgTgYTm5wDDxmnddh3/3HGIMFTbvZGqYHHxcDAx0LeiPX5VmzYBFTx72X+j
        u/7tC1ITqjyip38Vx7JT768QVGbJIib4n+umsDXE2gkVwcc0HZnQcFEatskE4l+Py04PPg
        rG5LdurPtA5EPLWrxMIQyo6D8YTLGOTKdET1tHTp98O3ymMoCEdgjdOd+HsJwQ==
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
Subject: [PATCH net-next 02/15] net: dsa: mt7530: use p5_interface_select as data type for p5_intf_sel
Date:   Sat, 18 Nov 2023 15:31:52 +0300
Message-Id: <20231118123205.266819-3-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118123205.266819-1-arinc.unal@arinc9.com>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the p5_interface_select enumeration as the data type for the
p5_intf_sel field. This ensures p5_intf_sel can only take the values
defined in the p5_interface_select enumeration.

Remove the explicit assignment of 0 to P5_DISABLED as the first enum item
is automatically assigned 0.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mt7530.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 96d610f5bcf9..1b10b70c1508 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -683,7 +683,7 @@ struct mt7530_port {
 
 /* Port 5 interface select definitions */
 enum p5_interface_select {
-	P5_DISABLED = 0,
+	P5_DISABLED,
 	P5_INTF_SEL_PHY_P0,
 	P5_INTF_SEL_PHY_P4,
 	P5_INTF_SEL_GMAC5,
@@ -776,7 +776,7 @@ struct mt7530_priv {
 	bool			mcm;
 	phy_interface_t		p6_interface;
 	phy_interface_t		p5_interface;
-	unsigned int		p5_intf_sel;
+	enum p5_interface_select p5_intf_sel;
 	u8			mirror_rx;
 	u8			mirror_tx;
 	struct mt7530_port	ports[MT7530_NUM_PORTS];
-- 
2.40.1

