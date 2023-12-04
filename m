Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701B6802C0E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbjLDHaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjLDHaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:30:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFEAF3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 23:30:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFE3C433C7;
        Mon,  4 Dec 2023 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701675026;
        bh=UXHIbSEXNeT4NOlOwMLwRYUsh1rg0DBD7QbaAh9KxAU=;
        h=From:To:Cc:Subject:Date:From;
        b=W8nfxDmRpeEwPLmtg/wG9eP4VA9cp8hQ+6hIXWHSf+UPEzlsebyFvHC6QAwvxwJR8
         9iToyOU65x9LDh4uXJooLpqDAgyga7w/tDHVFE48tYOGJ2f6WsM8oOVICgtbZjTnCI
         fD3Cr5KQQmyBfype4t5lvNALAWm//Y51o38ID/zyfKev9PkYszdbeY2Z5ahmVRsOLX
         bdmX+EqMY1ucCVmZdJ+jpf3G10J3BZ33xO2irE9uJKQ2WtO50JekjfTlSFeTFr73gT
         V0favpOb0zVMtJvazYS7dJYg1v/W2r6HklbCBj3R1pa2Fn25Q3kuapp1ULz3qk2lrJ
         UXpSDWJolgPoA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ching-Te Ku <ku920601@realtek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtw89: avoid stringop-overflow warning
Date:   Mon,  4 Dec 2023 08:30:13 +0100
Message-Id: <20231204073020.1105416-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

After -Wstringop-overflow got enabled, the rtw89 driver produced
two odd warnings with gcc-13:

drivers/net/wireless/realtek/rtw89/coex.c: In function 'rtw89_btc_ntfy_scan_start':
drivers/net/wireless/realtek/rtw89/coex.c:5362:50: error: writing 1 byte into a region of size 0 [-Werror=stringop-overflow=]
 5362 |                 wl->dbcc_info.scan_band[phy_idx] = band;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
In file included from drivers/net/wireless/realtek/rtw89/coex.h:8,
                 from drivers/net/wireless/realtek/rtw89/coex.c:5:
drivers/net/wireless/realtek/rtw89/core.h:1441:12: note: at offset [64, 255] into destination object 'scan_band' of size 2
 1441 |         u8 scan_band[RTW89_PHY_MAX]; /* scan band in  each phy */
      |            ^~~~~~~~~
drivers/net/wireless/realtek/rtw89/coex.c: In function 'rtw89_btc_ntfy_switch_band':
drivers/net/wireless/realtek/rtw89/coex.c:5406:50: error: writing 1 byte into a region of size 0 [-Werror=stringop-overflow=]
 5406 |                 wl->dbcc_info.scan_band[phy_idx] = band;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
drivers/net/wireless/realtek/rtw89/core.h:1441:12: note: at offset [64, 255] into destination object 'scan_band' of size 2
 1441 |         u8 scan_band[RTW89_PHY_MAX]; /* scan band in  each phy */
      |            ^~~~~~~~~

I don't know what happened here, but adding an explicit range check
shuts up the output.

Fixes: 89741e7e42f6 ("Makefile: Enable -Wstringop-overflow globally")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index b842cd9a86f8..9c0db35d3e13 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -5352,6 +5352,10 @@ void rtw89_btc_ntfy_scan_start(struct rtw89_dev *rtwdev, u8 phy_idx, u8 band)
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): phy_idx=%d, band=%d\n",
 		    __func__, phy_idx, band);
+
+	if (phy_idx >= RTW89_PHY_MAX)
+		return;
+
 	btc->dm.cnt_notify[BTC_NCNT_SCAN_START]++;
 	wl->status.map.scan = true;
 	wl->scan_info.band[phy_idx] = band;
@@ -5396,6 +5400,10 @@ void rtw89_btc_ntfy_switch_band(struct rtw89_dev *rtwdev, u8 phy_idx, u8 band)
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): phy_idx=%d, band=%d\n",
 		    __func__, phy_idx, band);
+
+	if (phy_idx >= RTW89_PHY_MAX)
+		return;
+
 	btc->dm.cnt_notify[BTC_NCNT_SWITCH_BAND]++;
 
 	wl->scan_info.band[phy_idx] = band;
-- 
2.39.2

