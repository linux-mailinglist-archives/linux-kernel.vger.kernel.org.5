Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4576C7E6F98
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344340AbjKIQp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjKIQpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:45:39 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72805BAA;
        Thu,  9 Nov 2023 08:43:51 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A9GhXptD1672698, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A9GhXptD1672698
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 00:43:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 10 Nov 2023 00:43:34 +0800
Received: from Test06-PC.realtek.com.tw (172.22.228.55) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 10 Nov 2023 00:43:33 +0800
From:   ChunHao Lin <hau@realtek.com>
To:     <hkallweit1@gmail.com>
CC:     <nic_swsd@realtek.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin <hau@realtek.com>, <stable@vger.kernel.org>
Subject: [PATCH net v3 2/2] r8169: fix network lost after resume on DASH systems
Date:   Fri, 10 Nov 2023 00:43:27 +0800
Message-ID: <20231109164327.3577-3-hau@realtek.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231109164327.3577-1-hau@realtek.com>
References: <20231109164327.3577-1-hau@realtek.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device that support DASH may be reseted or powered off during suspend.
So driver needs to handle DASH during system suspend and resume. Or
DASH firmware will influence device behavior and causes network lost.

Fixes: b646d90053f8 ("r8169: magic.")
Cc: stable@vger.kernel.org
Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 4954ff0f72b1..7e90dac2d97d 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4661,10 +4661,16 @@ static void rtl8169_down(struct rtl8169_private *tp)
 	rtl8169_cleanup(tp);
 	rtl_disable_exit_l1(tp);
 	rtl_prepare_power_down(tp);
+
+	if (tp->dash_type != RTL_DASH_NONE)
+		rtl8168_driver_stop(tp);
 }
 
 static void rtl8169_up(struct rtl8169_private *tp)
 {
+	if (tp->dash_type != RTL_DASH_NONE)
+		rtl8168_driver_start(tp);
+
 	pci_set_master(tp->pci_dev);
 	phy_init_hw(tp->phydev);
 	phy_resume(tp->phydev);
-- 
2.39.2

