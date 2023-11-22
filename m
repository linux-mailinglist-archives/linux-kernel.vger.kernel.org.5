Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28A97F4134
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbjKVJGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbjKVJGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:06:19 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 73DF947B2;
        Wed, 22 Nov 2023 01:03:28 -0800 (PST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id ACEC660754528;
        Wed, 22 Nov 2023 17:02:59 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     pkshih@realtek.com, kvalo@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com
Cc:     Su Hui <suhui@nfschina.com>, lizetao1@huawei.com,
        linville@tuxdriver.com, Larry.Finger@lwfinger.net,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: [PATCH wireless-next 2/2] rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior
Date:   Wed, 22 Nov 2023 17:02:12 +0800
Message-Id: <20231122090210.951185-2-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231122090210.951185-1-suhui@nfschina.com>
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

Clang staic checker warning:
drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c:184:49:
	The result of the left shift is undefined due to shifting by '32',
	which is greater or equal to the width of type 'u32'.
	[core.UndefinedBinaryOperatorResult]

If the value of the right operand is negative or is greater than or
equal to the width of the promoted left operand, the behavior is
undefined.[1][2]

For example, when using different gcc's compilation optimizaation options
(-O0 or -O2), the result of '(u32)data << 32' is different. One is 0, the
other is old value of data. Adding an u64 cast to fix this problem.

[1]:https://stackoverflow.com/questions/11270492/what-does-the-c-
standard-say-about-bitshifting-more-bits-than-the-width-of-type
[2]:https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf

Fixes: 21e4b0726dc6 ("rtlwifi: rtl8821ae: Move driver from staging to regular tree")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
index 6df270e29e66..89713e0587b5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
@@ -106,7 +106,7 @@ u32 rtl8821ae_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr,
 		regaddr, bitmask);
 	originalvalue = rtl_read_dword(rtlpriv, regaddr);
 	bitshift = _rtl8821ae_phy_calculate_bit_shift(bitmask);
-	returnvalue = (originalvalue & bitmask) >> bitshift;
+	returnvalue = (u64)(originalvalue & bitmask) >> bitshift;
 
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
 		"BBR MASK=0x%x Addr[0x%x]=0x%x\n",
@@ -128,7 +128,7 @@ void rtl8821ae_phy_set_bb_reg(struct ieee80211_hw *hw,
 		originalvalue = rtl_read_dword(rtlpriv, regaddr);
 		bitshift = _rtl8821ae_phy_calculate_bit_shift(bitmask);
 		data = ((originalvalue & (~bitmask)) |
-			((data << bitshift) & bitmask));
+			(((u64)data << bitshift) & bitmask));
 	}
 
 	rtl_write_dword(rtlpriv, regaddr, data);
@@ -153,7 +153,7 @@ u32 rtl8821ae_phy_query_rf_reg(struct ieee80211_hw *hw,
 
 	original_value = _rtl8821ae_phy_rf_serial_read(hw, rfpath, regaddr);
 	bitshift = _rtl8821ae_phy_calculate_bit_shift(bitmask);
-	readback_value = (original_value & bitmask) >> bitshift;
+	readback_value = (u64)(original_value & bitmask) >> bitshift;
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
@@ -181,7 +181,7 @@ void rtl8821ae_phy_set_rf_reg(struct ieee80211_hw *hw,
 		original_value =
 		   _rtl8821ae_phy_rf_serial_read(hw, rfpath, regaddr);
 		bitshift = _rtl8821ae_phy_calculate_bit_shift(bitmask);
-		data = ((original_value & (~bitmask)) | (data << bitshift));
+		data = ((original_value & (~bitmask)) | ((u64)data << bitshift));
 	}
 
 	_rtl8821ae_phy_rf_serial_write(hw, rfpath, regaddr, data);
-- 
2.30.2

