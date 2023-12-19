Return-Path: <linux-kernel+bounces-4765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794278181B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF6B1C21E08
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E287EC150;
	Tue, 19 Dec 2023 06:58:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id D5F4BF9E8;
	Tue, 19 Dec 2023 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 2610F60F259C0;
	Tue, 19 Dec 2023 14:58:02 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: pkshih@realtek.com,
	kvalo@kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	linville@tuxdriver.com,
	chaoming_li@realsil.com.cn,
	Larry.Finger@lwfinger.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH wireless-next 07/11] wifi: rtlwifi: rtl8192de: using calculate_bit_shift()
Date: Tue, 19 Dec 2023 14:57:35 +0800
Message-Id: <20231219065739.1895666-8-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231219065739.1895666-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using calculate_bit_shift() to replace _rtl92d_phy_calculate_bit_shift().
And fix the undefined bitwise shift behavior problem.

Fixes: 7274a8c22980 ("rtlwifi: rtl8192de: Merge phy routines")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.c  | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index d18c092b6142..d835a27429f0 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -169,13 +169,6 @@ static const u8 channel_all[59] = {
 	157, 159, 161, 163, 165
 };
 
-static u32 _rtl92d_phy_calculate_bit_shift(u32 bitmask)
-{
-	u32 i = ffs(bitmask);
-
-	return i ? i - 1 : 32;
-}
-
 u32 rtl92d_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
@@ -198,7 +191,7 @@ u32 rtl92d_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 	} else {
 		originalvalue = rtl_read_dword(rtlpriv, regaddr);
 	}
-	bitshift = _rtl92d_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
 		"BBR MASK=0x%x Addr[0x%x]=0x%x\n",
@@ -230,7 +223,7 @@ void rtl92d_phy_set_bb_reg(struct ieee80211_hw *hw,
 					dbi_direct);
 		else
 			originalvalue = rtl_read_dword(rtlpriv, regaddr);
-		bitshift = _rtl92d_phy_calculate_bit_shift(bitmask);
+		bitshift = calculate_bit_shift(bitmask);
 		data = ((originalvalue & (~bitmask)) | (data << bitshift));
 	}
 	if (rtlhal->during_mac1init_radioa || rtlhal->during_mac0init_radiob)
@@ -317,7 +310,7 @@ u32 rtl92d_phy_query_rf_reg(struct ieee80211_hw *hw,
 		regaddr, rfpath, bitmask);
 	spin_lock(&rtlpriv->locks.rf_lock);
 	original_value = _rtl92d_phy_rf_serial_read(hw, rfpath, regaddr);
-	bitshift = _rtl92d_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 	spin_unlock(&rtlpriv->locks.rf_lock);
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
@@ -343,7 +336,7 @@ void rtl92d_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 		if (bitmask != RFREG_OFFSET_MASK) {
 			original_value = _rtl92d_phy_rf_serial_read(hw,
 				rfpath, regaddr);
-			bitshift = _rtl92d_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data = ((original_value & (~bitmask)) |
 				(data << bitshift));
 		}
-- 
2.30.2


