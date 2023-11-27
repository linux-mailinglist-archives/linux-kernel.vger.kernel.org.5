Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67027FA872
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjK0R6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjK0R6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:58:06 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFA412C;
        Mon, 27 Nov 2023 09:58:09 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3ARHvofU71479205, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3ARHvofU71479205
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 01:57:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 28 Nov 2023 01:57:50 +0800
Received: from Test06-PC.realtek.com.tw (172.22.228.55) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 28 Nov 2023 01:57:49 +0800
From:   ChunHao Lin <hau@realtek.com>
To:     <hkallweit1@gmail.com>
CC:     <nic_swsd@realtek.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grundler@chromium.org>, ChunHao Lin <hau@realtek.com>,
        <stable@vger.kernel.org>
Subject: [PATCH net 2/2] r8169: fix deadlock in "r8169_phylink_handler"
Date:   Tue, 28 Nov 2023 01:57:36 +0800
Message-ID: <20231127175736.5738-3-hau@realtek.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127175736.5738-1-hau@realtek.com>
References: <20231127175736.5738-1-hau@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.22.228.55]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In "r8169_phylink_handler", for rtl8125, it will call "rtl_reset_work"->
"rtl_hw_start"->"rtl_jumbo_config"->"phy_start_aneg". When call
"r8169_phylink_handler", PHY lock is acquired. But "phy_start_aneg"
will also try to acquire PHY lock. That will cause deadlock.

In this path, use "_phy_start_aneg", unlocked version "phy_start_aneg",
to prevent deadlock in "r8169_phylink_handler".

Fixes: 453a77894efa ("r8169: don't advertise pause in jumbo mode")
Cc: stable@vger.kernel.org
Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 473b3245754f..2e3e42a98edd 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2415,11 +2415,22 @@ static void rtl_jumbo_config(struct rtl8169_private *tp)
 
 	/* Chip doesn't support pause in jumbo mode */
 	if (jumbo) {
+		int lock;
+
 		linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT,
 				   tp->phydev->advertising);
 		linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
 				   tp->phydev->advertising);
-		phy_start_aneg(tp->phydev);
+
+		if (!mutex_trylock(&tp->phydev->lock))
+			lock = 0;
+		else
+			lock = 1;
+
+		_phy_start_aneg(tp->phydev);
+
+		if (lock)
+			mutex_unlock(&tp->phydev->lock);
 	}
 }
 
-- 
2.39.2

