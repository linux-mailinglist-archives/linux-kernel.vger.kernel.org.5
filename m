Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CD37B188F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjI1KuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjI1KuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:50:02 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB55D19C;
        Thu, 28 Sep 2023 03:50:00 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38SAnfn173692468, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38SAnfn173692468
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 18:49:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 28 Sep 2023 18:49:37 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 28 Sep
 2023 18:49:36 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     <kuba@kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next v9 09/13] net:ethernet:realtek:rtase: Implement pci_driver suspend and resume function
Date:   Thu, 28 Sep 2023 18:49:16 +0800
Message-ID: <20230928104920.113511-10-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928104920.113511-1-justinlai0215@realtek.com>
References: <20230928104920.113511-1-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.210.160]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the pci_driver suspend function to enable the device
to sleep, and implement the resume function to enable the device
to resume operation.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index c9e1c4ef2cdf..4f91c3f3a986 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -2274,12 +2274,73 @@ static void rtase_shutdown(struct pci_dev *pdev)
 	rtase_reset_interrupt(pdev, tp);
 }
 
+#ifdef CONFIG_PM
+static int rtase_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+
+	if (!netif_running(dev))
+		goto out;
+
+	netif_stop_queue(dev);
+	netif_carrier_off(dev);
+	netif_device_detach(dev);
+	rtase_hw_reset(dev);
+
+out:
+	pci_save_state(pdev);
+
+	return 0;
+}
+
+static int rtase_resume(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct rtase_private *tp = netdev_priv(dev);
+	int ret;
+
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	pci_enable_wake(pdev, PCI_D0, 0);
+
+	/* restore last modified mac address */
+	rtase_rar_set(tp, dev->dev_addr);
+
+	if (!netif_running(dev))
+		goto out;
+
+	rtase_wait_for_quiescence(dev);
+	netif_device_attach(dev);
+
+	rtase_tx_clear(tp);
+	rtase_rx_clear(tp);
+
+	ret = rtase_init_ring(dev);
+	if (ret)
+		netdev_alert(dev, "unable to init ring\n");
+
+	rtase_hw_config(dev);
+	/* always link, so start to transmit & receive */
+	rtase_hw_start(dev);
+
+	netif_carrier_on(dev);
+	netif_wake_queue(dev);
+
+out:
+	return 0;
+}
+#endif /* CONFIG_PM */
+
 static struct pci_driver rtase_pci_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = rtase_pci_tbl,
 	.probe = rtase_init_one,
 	.remove = rtase_remove_one,
 	.shutdown = rtase_shutdown,
+#ifdef CONFIG_PM
+	.suspend = rtase_suspend,
+	.resume = rtase_resume,
+#endif
 };
 
 module_pci_driver(rtase_pci_driver);
-- 
2.34.1

