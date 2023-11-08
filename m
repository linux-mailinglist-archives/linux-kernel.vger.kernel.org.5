Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1277E5D7A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 19:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjKHSvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 13:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjKHSu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 13:50:58 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FA4210A;
        Wed,  8 Nov 2023 10:50:55 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A8Io8Oq91018641, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A8Io8Oq91018641
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Nov 2023 02:50:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 9 Nov 2023 02:50:07 +0800
Received: from Test06-PC.realtek.com.tw (172.22.228.55) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 9 Nov 2023 02:50:06 +0800
From:   ChunHao Lin <hau@realtek.com>
To:     <hkallweit1@gmail.com>
CC:     <nic_swsd@realtek.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin <hau@realtek.com>, <stable@vger.kernel.org>
Subject: [PATCH net v2 1/2] r8169: add handling DASH when DASH is disabled
Date:   Thu, 9 Nov 2023 02:48:48 +0800
Message-ID: <20231108184849.2925-2-hau@realtek.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231108184849.2925-1-hau@realtek.com>
References: <20231108184849.2925-1-hau@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.22.228.55]
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
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

For devices that support DASH, even DASH is disabled, there may still
exist a default firmware that will influence device behavior.
So driver needs to handle DASH for devices that support DASH, no
matter the DASH status is.

This patch also prepare for "fix DASH deviceis network lost issue".

Signed-off-by: ChunHao Lin <hau@realtek.com>
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/realtek/r8169_main.c | 35 ++++++++++++++++-------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 0c76c162b8a9..108dc75050ba 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -624,6 +624,7 @@ struct rtl8169_private {
 
 	unsigned supports_gmii:1;
 	unsigned aspm_manageable:1;
+	unsigned dash_enabled:1;
 	dma_addr_t counters_phys_addr;
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
@@ -1253,14 +1254,26 @@ static bool r8168ep_check_dash(struct rtl8169_private *tp)
 	return r8168ep_ocp_read(tp, 0x128) & BIT(0);
 }
 
-static enum rtl_dash_type rtl_check_dash(struct rtl8169_private *tp)
+static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
+{
+	switch (tp->dash_type) {
+	case RTL_DASH_DP:
+		return r8168dp_check_dash(tp);
+	case RTL_DASH_EP:
+		return r8168ep_check_dash(tp);
+	default:
+		return false;
+	}
+}
+
+static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
 {
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_28:
 	case RTL_GIGA_MAC_VER_31:
-		return r8168dp_check_dash(tp) ? RTL_DASH_DP : RTL_DASH_NONE;
+		return RTL_DASH_DP;
 	case RTL_GIGA_MAC_VER_51 ... RTL_GIGA_MAC_VER_53:
-		return r8168ep_check_dash(tp) ? RTL_DASH_EP : RTL_DASH_NONE;
+		return RTL_DASH_EP;
 	default:
 		return RTL_DASH_NONE;
 	}
@@ -1453,7 +1466,7 @@ static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
 
 	device_set_wakeup_enable(tp_to_dev(tp), wolopts);
 
-	if (tp->dash_type == RTL_DASH_NONE) {
+	if (!tp->dash_enabled) {
 		rtl_set_d3_pll_down(tp, !wolopts);
 		tp->dev->wol_enabled = wolopts ? 1 : 0;
 	}
@@ -2512,7 +2525,7 @@ static void rtl_wol_enable_rx(struct rtl8169_private *tp)
 
 static void rtl_prepare_power_down(struct rtl8169_private *tp)
 {
-	if (tp->dash_type != RTL_DASH_NONE)
+	if (tp->dash_enabled)
 		return;
 
 	if (tp->mac_version == RTL_GIGA_MAC_VER_32 ||
@@ -4869,7 +4882,7 @@ static int rtl8169_runtime_idle(struct device *device)
 {
 	struct rtl8169_private *tp = dev_get_drvdata(device);
 
-	if (tp->dash_type != RTL_DASH_NONE)
+	if (tp->dash_enabled)
 		return -EBUSY;
 
 	if (!netif_running(tp->dev) || !netif_carrier_ok(tp->dev))
@@ -4896,7 +4909,7 @@ static void rtl_shutdown(struct pci_dev *pdev)
 	rtl_rar_set(tp, tp->dev->perm_addr);
 
 	if (system_state == SYSTEM_POWER_OFF &&
-	    tp->dash_type == RTL_DASH_NONE) {
+		!tp->dash_enabled) {
 		pci_wake_from_d3(pdev, tp->saved_wolopts);
 		pci_set_power_state(pdev, PCI_D3hot);
 	}
@@ -5254,7 +5267,8 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1);
 	tp->aspm_manageable = !rc;
 
-	tp->dash_type = rtl_check_dash(tp);
+	tp->dash_type = rtl_get_dash_type(tp);
+	tp->dash_enabled = rtl_dash_is_enabled(tp);
 
 	tp->cp_cmd = RTL_R16(tp, CPlusCmd) & CPCMD_MASK;
 
@@ -5325,7 +5339,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* configure chip for default features */
 	rtl8169_set_features(dev, dev->features);
 
-	if (tp->dash_type == RTL_DASH_NONE) {
+	if (!tp->dash_enabled) {
 		rtl_set_d3_pll_down(tp, true);
 	} else {
 		rtl_set_d3_pll_down(tp, false);
@@ -5365,7 +5379,8 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			    "ok" : "ko");
 
 	if (tp->dash_type != RTL_DASH_NONE) {
-		netdev_info(dev, "DASH enabled\n");
+		netdev_info(dev, "DASH %s\n",
+			    tp->dash_enabled ? "enabled" : "disabled");
 		rtl8168_driver_start(tp);
 	}
 
-- 
2.39.2

