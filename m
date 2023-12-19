Return-Path: <linux-kernel+bounces-4775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 504C28181E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBEA281CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78504182A3;
	Tue, 19 Dec 2023 06:58:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 981798829;
	Tue, 19 Dec 2023 06:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 2BFBF60F259C3;
	Tue, 19 Dec 2023 14:58:07 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: pkshih@realtek.com,
	kvalo@kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	linville@tuxdriver.com,
	Larry.Finger@lwfinger.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH wireless-next 10/11] wifi: rtlwifi: rtl8723_common: using calculate_bit_shift()
Date: Tue, 19 Dec 2023 14:57:38 +0800
Message-Id: <20231219065739.1895666-11-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231219065739.1895666-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using calculate_bit_shift() to replace rtl8723_phy_calculate_bit_shift().
And fix the undefined bitwise shift behavior problem.

Fixes: 0a168b48cdf7 ("rtlwifi: rtl8723ae: rtl8723-common: Create new driver for common code")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 .../wireless/realtek/rtlwifi/rtl8723com/phy_common.c | 12 ++----------
 .../wireless/realtek/rtlwifi/rtl8723com/phy_common.h |  1 -
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c
index 47b6c1aa36b0..d97c88ebce75 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c
@@ -17,7 +17,7 @@ u32 rtl8723_phy_query_bb_reg(struct ieee80211_hw *hw,
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
 		"regaddr(%#x), bitmask(%#x)\n", regaddr, bitmask);
 	originalvalue = rtl_read_dword(rtlpriv, regaddr);
-	bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
 
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
@@ -39,7 +39,7 @@ void rtl8723_phy_set_bb_reg(struct ieee80211_hw *hw, u32 regaddr,
 
 	if (bitmask != MASKDWORD) {
 		originalvalue = rtl_read_dword(rtlpriv, regaddr);
-		bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+		bitshift = calculate_bit_shift(bitmask);
 		data = ((originalvalue & (~bitmask)) | (data << bitshift));
 	}
 
@@ -51,14 +51,6 @@ void rtl8723_phy_set_bb_reg(struct ieee80211_hw *hw, u32 regaddr,
 }
 EXPORT_SYMBOL_GPL(rtl8723_phy_set_bb_reg);
 
-u32 rtl8723_phy_calculate_bit_shift(u32 bitmask)
-{
-	u32 i = ffs(bitmask);
-
-	return i ? i - 1 : 32;
-}
-EXPORT_SYMBOL_GPL(rtl8723_phy_calculate_bit_shift);
-
 u32 rtl8723_phy_rf_serial_read(struct ieee80211_hw *hw,
 			       enum radio_path rfpath, u32 offset)
 {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.h b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.h
index edf1c52f0ee2..af85c3287507 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.h
@@ -27,7 +27,6 @@ u32 rtl8723_phy_query_bb_reg(struct ieee80211_hw *hw,
 			     u32 regaddr, u32 bitmask);
 void rtl8723_phy_set_bb_reg(struct ieee80211_hw *hw, u32 regaddr,
 			      u32 bitmask, u32 data);
-u32 rtl8723_phy_calculate_bit_shift(u32 bitmask);
 u32 rtl8723_phy_rf_serial_read(struct ieee80211_hw *hw,
 			       enum radio_path rfpath, u32 offset);
 void rtl8723_phy_rf_serial_write(struct ieee80211_hw *hw,
-- 
2.30.2


