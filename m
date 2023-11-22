Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2627E7F412F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjKVJGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjKVJGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:06:03 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2C183421F;
        Wed, 22 Nov 2023 01:03:01 -0800 (PST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id CC8F86075452A;
        Wed, 22 Nov 2023 17:02:52 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     pkshih@realtek.com, kvalo@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com
Cc:     Su Hui <suhui@nfschina.com>, lizetao1@huawei.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: [PATCH wireless-next 1/2] rtlwifi: rtl8821ae: phy: remove some useless code
Date:   Wed, 22 Nov 2023 17:02:10 +0800
Message-Id: <20231122090210.951185-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang static checker warning:
Value stored to 'v1' is never read [deadcode.DeadStores]
Value stored to 'channel' is never read [deadcode.DeadStores]

Remove them to save some place.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
index 5323ead30db0..6df270e29e66 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
@@ -2038,15 +2038,9 @@ static bool _rtl8821ae_phy_config_bb_with_pgheaderfile(struct ieee80211_hw *hw,
 			 /*don't need the hw_body*/
 			if (!_rtl8821ae_check_condition(hw, v1)) {
 				i += 2; /* skip the pair of expression*/
-				v1 = array[i];
 				v2 = array[i+1];
-				v3 = array[i+2];
-				while (v2 != 0xDEAD) {
+				while (v2 != 0xDEAD)
 					i += 3;
-					v1 = array[i];
-					v2 = array[i+1];
-					v3 = array[i+2];
-				}
 			}
 		}
 	}
@@ -3543,7 +3537,6 @@ u8 rtl8821ae_phy_sw_chnl(struct ieee80211_hw *hw)
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	u32 timeout = 1000, timecount = 0;
-	u8 channel = rtlphy->current_channel;
 
 	if (rtlphy->sw_chnl_inprogress)
 		return 0;
@@ -3566,8 +3559,6 @@ u8 rtl8821ae_phy_sw_chnl(struct ieee80211_hw *hw)
 		rtl8821ae_phy_switch_wirelessband(hw, BAND_ON_2_4G);
 
 	rtlphy->sw_chnl_inprogress = true;
-	if (channel == 0)
-		channel = 1;
 
 	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE,
 		"switch to channel%d, band type is %d\n",
-- 
2.30.2

