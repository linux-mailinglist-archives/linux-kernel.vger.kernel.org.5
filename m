Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8162B797917
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbjIGRBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238540AbjIGRBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:01:02 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5F62109
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:00:38 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qe9FQ-0000ZU-O2; Thu, 07 Sep 2023 09:16:16 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qe9FP-004bJn-BK; Thu, 07 Sep 2023 09:16:15 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qe9FO-008Wiy-D4; Thu, 07 Sep 2023 09:16:14 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Yanik Fuchs <Yanik.fuchs@mbv.ch>
Subject: [PATCH] wifi: rtw88: rtw8723d: Fix MAC address offset in EEPROM
Date:   Thu,  7 Sep 2023 09:16:14 +0200
Message-Id: <20230907071614.2032404-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAC address is stored at offset 0x107 in the EEPROM, like correctly
stated in the comment. Add a two bytes reserved field right before the
MAC address to shift it from offset 0x105 to 0x107.

With this the MAC address returned from my RTL8723du wifi stick can be
correctly decoded as "Shenzhen Four Seas Global Link Network Technology
Co., Ltd."

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reported-by: Yanik Fuchs <Yanik.fuchs@mbv.ch>
Cc: stable@vger.kernel.org
---
 drivers/net/wireless/realtek/rtw88/rtw8723d.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
index 3642a2c7f80c9..2434e2480cbe2 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
@@ -46,6 +46,7 @@ struct rtw8723du_efuse {
 	u8 vender_id[2];                /* 0x100 */
 	u8 product_id[2];               /* 0x102 */
 	u8 usb_option;                  /* 0x104 */
+	u8 res5[2];			/* 0x105 */
 	u8 mac_addr[ETH_ALEN];          /* 0x107 */
 };
 
-- 
2.39.2

