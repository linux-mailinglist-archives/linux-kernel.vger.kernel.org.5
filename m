Return-Path: <linux-kernel+bounces-4768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EA78181C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536C61F24213
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D556614276;
	Tue, 19 Dec 2023 06:58:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6F9CB107B7;
	Tue, 19 Dec 2023 06:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 1BDF360F259C0;
	Tue, 19 Dec 2023 14:57:56 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: pkshih@realtek.com,
	kvalo@kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH wireless-next 02/11] wifi: rtlwifi: rtl8821ae: phy: using calculate_bit_shift()
Date: Tue, 19 Dec 2023 14:57:30 +0800
Message-Id: <20231219065739.1895666-3-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231219065739.1895666-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

using calculate_bit_shift() to replace
_rtl8821ae_phy_calculate_bit_shift().

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 .../net/wireless/realtek/rtlwifi/rtl8821ae/phy.c  | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
index 68c3fb0395ce..1be51ea3f3c8 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
@@ -27,13 +27,6 @@ static u32 _rtl8821ae_phy_rf_serial_read(struct ieee80211_hw *hw,
 static void _rtl8821ae_phy_rf_serial_write(struct ieee80211_hw *hw,
 					   enum radio_path rfpath, u32 offset,
 					   u32 data);
-static u32 _rtl8821ae_phy_calculate_bit_shift(u32 bitmask)
-{
-	if (WARN_ON_ONCE(!bitmask))
-		return 0;
-
-	return __ffs(bitmask);
-}
 static bool _rtl8821ae_phy_bb8821a_config_parafile(struct ieee80211_hw *hw);
 /*static bool _rtl8812ae_phy_config_mac_with_headerfile(struct ieee80211_hw *hw);*/
 static bool _rtl8821ae_phy_config_mac_with_headerfile(struct ieee80211_hw *hw);
@@ -106,7 +99,7 @@ u32 rtl8821ae_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr,
 		"regaddr(%#x), bitmask(%#x)\n",
 		regaddr, bitmask);
 	originalvalue = rtl_read_dword(rtlpriv, regaddr);
-	bitshift = _rtl8821ae_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
 
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
@@ -127,7 +120,7 @@ void rtl8821ae_phy_set_bb_reg(struct ieee80211_hw *hw,
 
 	if (bitmask != MASKDWORD) {
 		originalvalue = rtl_read_dword(rtlpriv, regaddr);
-		bitshift = _rtl8821ae_phy_calculate_bit_shift(bitmask);
+		bitshift = calculate_bit_shift(bitmask);
 		data = ((originalvalue & (~bitmask)) |
 			((data << bitshift) & bitmask));
 	}
@@ -153,7 +146,7 @@ u32 rtl8821ae_phy_query_rf_reg(struct ieee80211_hw *hw,
 	spin_lock(&rtlpriv->locks.rf_lock);
 
 	original_value = _rtl8821ae_phy_rf_serial_read(hw, rfpath, regaddr);
-	bitshift = _rtl8821ae_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
@@ -181,7 +174,7 @@ void rtl8821ae_phy_set_rf_reg(struct ieee80211_hw *hw,
 	if (bitmask != RFREG_OFFSET_MASK) {
 		original_value =
 		   _rtl8821ae_phy_rf_serial_read(hw, rfpath, regaddr);
-		bitshift = _rtl8821ae_phy_calculate_bit_shift(bitmask);
+		bitshift = calculate_bit_shift(bitmask);
 		data = ((original_value & (~bitmask)) | (data << bitshift));
 	}
 
-- 
2.30.2


