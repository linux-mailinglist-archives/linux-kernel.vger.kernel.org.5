Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F4777A60E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 12:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjHMK7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 06:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjHMK7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 06:59:36 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DA6170D;
        Sun, 13 Aug 2023 03:59:37 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 86DE21BF203;
        Sun, 13 Aug 2023 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1691924375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mdVpG6KrBclrQ0ouLiBkLwF9mOH3uxISN3uLBX1IcqM=;
        b=U6RxFQzLHDJ2hTlJRDh5d1aBt7SPPoIHKaPO0i5YdVDSOK6o58k2WrckL3SwuINAtbYRj+
        ACto8MENZ9NEdu+Vf2sqTcJa/TcUsAfw/fCrq7dkopbE4ch1lHdY4ErmB2Sb4RZt+h4H15
        ZlkNPt7lhXA7kKgWfgDVGV8fn6z2as683LFElvkd/ZQGdH6BLcMoEPW2MpThGmXoccrc5j
        PT+n/hWtjh8KixMUTVWxC5Jfvc7ivpZY3ZlBExUiqcPjol+9HJdF7spSRunFI7m+sRNHL0
        XYn4BsY9pA2pPTTkiIjVfbU1mUbmxAvTbtCB2JJ3OChtqllsMGEs2ZUoQbZ56g==
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
        <angelogioacchino.delregno@collabora.com>
Cc:     Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net] net: dsa: mt7530: fix handling of 802.1X PAE frames
Date:   Sun, 13 Aug 2023 13:59:17 +0300
Message-Id: <20230813105917.32102-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

802.1X PAE frames are link-local frames, therefore they must be trapped to
the CPU port. Currently, the MT753X switches treat 802.1X PAE frames as
regular multicast frames, therefore flooding them to user ports. To fix
this, set 802.1X PAE frames to be trapped to the CPU port(s).

Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 4 ++++
 drivers/net/dsa/mt7530.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 38b3c6dda386..b8bb9f3b3609 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1006,6 +1006,10 @@ mt753x_trap_frames(struct mt7530_priv *priv)
 	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
 		   MT753X_BPDU_CPU_ONLY);
 
+	/* Trap 802.1X PAE frames to the CPU port(s) */
+	mt7530_rmw(priv, MT753X_BPC, MT753X_PAE_PORT_FW_MASK,
+		   MT753X_PAE_PORT_FW(MT753X_BPDU_CPU_ONLY));
+
 	/* Trap LLDP frames with :0E MAC DA to the CPU port(s) */
 	mt7530_rmw(priv, MT753X_RGAC2, MT753X_R0E_PORT_FW_MASK,
 		   MT753X_R0E_PORT_FW(MT753X_BPDU_CPU_ONLY));
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 08045b035e6a..17e42d30fff4 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -66,6 +66,8 @@ enum mt753x_id {
 /* Registers for BPDU and PAE frame control*/
 #define MT753X_BPC			0x24
 #define  MT753X_BPDU_PORT_FW_MASK	GENMASK(2, 0)
+#define  MT753X_PAE_PORT_FW_MASK	GENMASK(18, 16)
+#define  MT753X_PAE_PORT_FW(x)		FIELD_PREP(MT753X_PAE_PORT_FW_MASK, x)
 
 /* Register for :03 and :0E MAC DA frame control */
 #define MT753X_RGAC2			0x2c
-- 
2.39.2

