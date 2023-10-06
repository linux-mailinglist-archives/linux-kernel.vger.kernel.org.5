Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67B47BB058
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 04:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjJFCrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 22:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjJFCrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 22:47:45 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4ECD6;
        Thu,  5 Oct 2023 19:47:42 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3962lCOb91244999, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3962lCOb91244999
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Oct 2023 10:47:15 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 6 Oct 2023 10:47:12 +0800
Received: from localhost.localhost (172.21.132.123) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 6 Oct 2023 10:47:11 +0800
From:   <max.chou@realtek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alex_lu@realsil.com.cn>, <hildawu@realtek.com>,
        <max.chou@realtek.com>, <regressions@lists.linux.dev>,
        <kirill@shutemov.name>, <bagasdotme@gmail.com>,
        <linux@leemhuis.info>
Subject: [PATCH] Bluetooth: btrtl: Ignore error return for hci_devcd_register()
Date:   Fri, 6 Oct 2023 10:47:07 +0800
Message-ID: <20231006024707.413349-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.132.123]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Chou <max.chou@realtek.com>

If CONFIG_DEV_COREDUMP was not set, it would return -EOPNOTSUPP for
hci_devcd_register().
In this commit, ignore error return for hci_devcd_register().
Otherwise Bluetooth initialization will be failed.

Fixes: 044014ce85a1 ("Bluetooth: btrtl: Add Realtek devcoredump support")
Cc: stable@vger.kernel.org
Reported-by: Kirill A. Shutemov <kirill@shutemov.name>
Closes: https://lore.kernel.org/all/ZRyqIn0_qqEFBPdy@debian.me/T/
Signed-off-by: Max Chou <max.chou@realtek.com>
---
 drivers/bluetooth/btrtl.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 84c2c2e1122f..277d039ecbb4 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -962,13 +962,10 @@ static void btrtl_dmp_hdr(struct hci_dev *hdev, struct sk_buff *skb)
 	skb_put_data(skb, buf, strlen(buf));
 }
 
-static int btrtl_register_devcoredump_support(struct hci_dev *hdev)
+static void btrtl_register_devcoredump_support(struct hci_dev *hdev)
 {
-	int err;
+	hci_devcd_register(hdev, btrtl_coredump, btrtl_dmp_hdr, NULL);
 
-	err = hci_devcd_register(hdev, btrtl_coredump, btrtl_dmp_hdr, NULL);
-
-	return err;
 }
 
 void btrtl_set_driver_name(struct hci_dev *hdev, const char *driver_name)
@@ -1255,8 +1252,7 @@ int btrtl_download_firmware(struct hci_dev *hdev,
 	}
 
 done:
-	if (!err)
-		err = btrtl_register_devcoredump_support(hdev);
+	btrtl_register_devcoredump_support(hdev);
 
 	return err;
 }
-- 
2.34.1

