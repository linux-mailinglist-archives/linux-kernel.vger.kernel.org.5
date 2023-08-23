Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349427851FA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbjHWHu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjHWHu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:50:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DC1CE6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:50:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qYidD-0003sv-Lu; Wed, 23 Aug 2023 09:50:23 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qYidC-000zf6-4f; Wed, 23 Aug 2023 09:50:22 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qYidB-002T7g-Dw; Wed, 23 Aug 2023 09:50:21 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>,
        =?UTF-8?q?Ilgaz=20=C3=96cal?= <ilgaz@ilgaz.gen.tr>,
        kernel@pengutronix.de
Subject: [PATCH] wifi: rtw88: usb: kill and free rx urbs on probe failure
Date:   Wed, 23 Aug 2023 09:50:21 +0200
Message-Id: <20230823075021.588596-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After rtw_usb_alloc_rx_bufs() has been called rx urbs have been
allocated and must be freed in the error path. After rtw_usb_init_rx()
has been called they are submitted, so they also must be killed.

Add these forgotten steps to the probe error path.

Besides the lost memory this also fixes a problem when the driver
fails to download the firmware in rtw_chip_info_setup(). In this
case it can happen that the completion of the rx urbs handler runs
at a time when we already freed our data structures resulting in
a kernel crash.

fixes: a82dfd33d1237 ("wifi: rtw88: Add common USB chip support")
Cc: stable@vger.kernel.org
Reported-by: Ilgaz Öcal <ilgaz@ilgaz.gen.tr>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 4a57efdba97bb..875a61c9c80d4 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -844,7 +844,7 @@ int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 
 	ret = rtw_core_init(rtwdev);
 	if (ret)
-		goto err_release_hw;
+		goto err_free_rx_bufs;
 
 	ret = rtw_usb_intf_init(rtwdev, intf);
 	if (ret) {
@@ -890,6 +890,9 @@ int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 err_deinit_core:
 	rtw_core_deinit(rtwdev);
 
+err_free_rx_bufs:
+	rtw_usb_free_rx_bufs(rtwusb);
+
 err_release_hw:
 	ieee80211_free_hw(hw);
 
-- 
2.39.2

