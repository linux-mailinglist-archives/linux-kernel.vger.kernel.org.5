Return-Path: <linux-kernel+bounces-27804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3A882F627
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA54F1F21162
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C72577B;
	Tue, 16 Jan 2024 19:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G140mh/M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7019B25635;
	Tue, 16 Jan 2024 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434234; cv=none; b=nvqS08/6rTXoCyroIRvWhduZ47dcesP7gZaQJVCDf3hMxJNtki0w2j4qv2XkeBc78JNlR+gudIzlyHhID74/MHxuZqc6xtxm/krtV7Ky55ugtzgQ39yOgB8hs2YjmbJI/gsIlCWJII8WlyKk+BNtnA4BsOtfvIpTvBDoPC+SdI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434234; c=relaxed/simple;
	bh=ZKC8ms1i+d2dZ8our2gZBBT5SSEmPwis4UMsyljwKQg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=lAO/x+daeYYczhlFtOi15wX3d7AXMWCQyZGu32VjrOEfW9bXdA2AhoyPwNaEjVwHNhHqytSfVO5+5++2YHbH3ipbarHJI6wMqg/TBaYpzkQHHYJUSo6eY3V2kqMmovyYcdzmx5+6IxRquDr6GZ99/PvGotJRgY9ugxOmhK2VaiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G140mh/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE39C433C7;
	Tue, 16 Jan 2024 19:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434234;
	bh=ZKC8ms1i+d2dZ8our2gZBBT5SSEmPwis4UMsyljwKQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G140mh/My++q58HCI3yAQ8UdnO4MGGg9ggtKAcc6WFXH/9gFSFMyVHLeG0ZBuVih7
	 JvC5YjjLYqIoYrd4S53xJKx8s+UD4JZBA3IyIRM3VowAPK4hh+mn6+dsEVUe9xUDx2
	 g5CMtmVojXCRVHviEhWUYCOBVfHMxsIYI/Mhsfjn7LtZbu5frDJHVmL22J79UIW5/7
	 a7+pnbvfwLecIOxi01j60PFtcm8yawQBIvVYb8GcuzofbxeyihSqgu6l42L2cokFVW
	 FEawQfGmnvbzGKYykhnBFc0dxSOUCmll8W5DmV/oARl/4IyNlK7YVRkek/Mm0nkAed
	 qGdBs2S8ZKAkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Po-Hao Huang <phhuang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 034/108] wifi: rtw89: fix not entering PS mode after AP stops
Date: Tue, 16 Jan 2024 14:39:00 -0500
Message-ID: <20240116194225.250921-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Po-Hao Huang <phhuang@realtek.com>

[ Upstream commit 0052b3c401cdf39d3c3d12a0c3852175bc9a39c7 ]

The attempt to enter power save mode might fail if there are still
beacons pending in the queue. This sometimes happens after stopping
P2P GO or AP mode. Extend stop AP function and flush all beacons to
resolve this.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20231129070046.18443-2-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 71 ++++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/reg.h | 17 ++++++
 2 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 0c5768f41d55..add8a7ff01a5 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3747,6 +3747,50 @@ static const struct rtw89_port_reg rtw89_port_base_ax = {
 		    R_AX_PORT_HGQ_WINDOW_CFG + 3},
 };
 
+static void rtw89_mac_check_packet_ctrl(struct rtw89_dev *rtwdev,
+					struct rtw89_vif *rtwvif, u8 type)
+{
+	u8 mask = B_AX_PTCL_DBG_INFO_MASK_BY_PORT(rtwvif->port);
+	u32 reg_info, reg_ctrl;
+	u32 val;
+	int ret;
+
+	reg_info = rtw89_mac_reg_by_idx(rtwdev, R_AX_PTCL_DBG_INFO, rtwvif->mac_idx);
+	reg_ctrl = rtw89_mac_reg_by_idx(rtwdev, R_AX_PTCL_DBG, rtwvif->mac_idx);
+
+	rtw89_write32_mask(rtwdev, reg_ctrl, B_AX_PTCL_DBG_SEL_MASK, type);
+	rtw89_write32_set(rtwdev, reg_ctrl, B_AX_PTCL_DBG_EN);
+	fsleep(100);
+
+	ret = read_poll_timeout(rtw89_read32_mask, val, val == 0, 1000, 100000,
+				true, rtwdev, reg_info, mask);
+	if (ret)
+		rtw89_warn(rtwdev, "Polling beacon packet empty fail\n");
+}
+
+static void rtw89_mac_bcn_drop(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
+
+	rtw89_write32_set(rtwdev, R_AX_BCN_DROP_ALL0, BIT(rtwvif->port));
+	rtw89_write32_port_mask(rtwdev, rtwvif, p->tbtt_prohib, B_AX_TBTT_SETUP_MASK, 1);
+	rtw89_write32_port_mask(rtwdev, rtwvif, p->bcn_area, B_AX_BCN_MSK_AREA_MASK, 0);
+	rtw89_write32_port_mask(rtwdev, rtwvif, p->tbtt_prohib, B_AX_TBTT_HOLD_MASK, 0);
+	rtw89_write32_port_mask(rtwdev, rtwvif, p->bcn_early, B_AX_BCNERLY_MASK, 2);
+	rtw89_write16_port_mask(rtwdev, rtwvif, p->tbtt_early, B_AX_TBTTERLY_MASK, 1);
+	rtw89_write32_port_mask(rtwdev, rtwvif, p->bcn_space, B_AX_BCN_SPACE_MASK, 1);
+	rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_BCNTX_EN);
+
+	rtw89_mac_check_packet_ctrl(rtwdev, rtwvif, AX_PTCL_DBG_BCNQ_NUM0);
+	if (rtwvif->port == RTW89_PORT_0)
+		rtw89_mac_check_packet_ctrl(rtwdev, rtwvif, AX_PTCL_DBG_BCNQ_NUM1);
+
+	rtw89_write32_clr(rtwdev, R_AX_BCN_DROP_ALL0, BIT(rtwvif->port));
+	rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, B_AX_TBTT_PROHIB_EN);
+	fsleep(2);
+}
+
 #define BCN_INTERVAL 100
 #define BCN_ERLY_DEF 160
 #define BCN_SETUP_DEF 2
@@ -3762,21 +3806,36 @@ static void rtw89_mac_port_cfg_func_sw(struct rtw89_dev *rtwdev,
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	bool need_backup = false;
+	u32 backup_val;
 
 	if (!rtw89_read32_port_mask(rtwdev, rtwvif, p->port_cfg, B_AX_PORT_FUNC_EN))
 		return;
 
-	rtw89_write32_port_clr(rtwdev, rtwvif, p->tbtt_prohib, B_AX_TBTT_SETUP_MASK);
-	rtw89_write32_port_mask(rtwdev, rtwvif, p->tbtt_prohib, B_AX_TBTT_HOLD_MASK, 1);
-	rtw89_write16_port_clr(rtwdev, rtwvif, p->tbtt_early, B_AX_TBTTERLY_MASK);
-	rtw89_write16_port_clr(rtwdev, rtwvif, p->bcn_early, B_AX_BCNERLY_MASK);
+	if (chip->chip_id == RTL8852A && rtwvif->port != RTW89_PORT_0) {
+		need_backup = true;
+		backup_val = rtw89_read32_port(rtwdev, rtwvif, p->tbtt_prohib);
+	}
 
-	msleep(vif->bss_conf.beacon_int + 1);
+	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE)
+		rtw89_mac_bcn_drop(rtwdev, rtwvif);
+
+	if (chip->chip_id == RTL8852A) {
+		rtw89_write32_port_clr(rtwdev, rtwvif, p->tbtt_prohib, B_AX_TBTT_SETUP_MASK);
+		rtw89_write32_port_mask(rtwdev, rtwvif, p->tbtt_prohib, B_AX_TBTT_HOLD_MASK, 1);
+		rtw89_write16_port_clr(rtwdev, rtwvif, p->tbtt_early, B_AX_TBTTERLY_MASK);
+		rtw89_write16_port_clr(rtwdev, rtwvif, p->bcn_early, B_AX_BCNERLY_MASK);
+	}
 
+	msleep(vif->bss_conf.beacon_int + 1);
 	rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, B_AX_PORT_FUNC_EN |
 							    B_AX_BRK_SETUP);
 	rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_TSFTR_RST);
 	rtw89_write32_port(rtwdev, rtwvif, p->bcn_cnt_tmr, 0);
+
+	if (need_backup)
+		rtw89_write32_port(rtwdev, rtwvif, p->tbtt_prohib, backup_val);
 }
 
 static void rtw89_mac_port_cfg_tx_rpt(struct rtw89_dev *rtwdev,
@@ -4261,7 +4320,7 @@ void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 
 void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
-	rtw89_mac_port_cfg_func_en(rtwdev, rtwvif, false);
+	rtw89_mac_port_cfg_func_sw(rtwdev, rtwvif);
 }
 
 int rtw89_mac_add_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index ccd5481e8a3d..672010b9e026 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -2375,6 +2375,14 @@
 #define R_AX_TSFTR_HIGH_P4 0xC53C
 #define B_AX_TSFTR_HIGH_MASK GENMASK(31, 0)
 
+#define R_AX_BCN_DROP_ALL0 0xC560
+#define R_AX_BCN_DROP_ALL0_C1 0xE560
+#define B_AX_BCN_DROP_ALL_P4 BIT(4)
+#define B_AX_BCN_DROP_ALL_P3 BIT(3)
+#define B_AX_BCN_DROP_ALL_P2 BIT(2)
+#define B_AX_BCN_DROP_ALL_P1 BIT(1)
+#define B_AX_BCN_DROP_ALL_P0 BIT(0)
+
 #define R_AX_MBSSID_CTRL 0xC568
 #define R_AX_MBSSID_CTRL_C1 0xE568
 #define B_AX_P0MB_ALL_MASK GENMASK(23, 1)
@@ -2554,11 +2562,20 @@
 
 #define R_AX_PTCL_DBG_INFO 0xC6F0
 #define R_AX_PTCL_DBG_INFO_C1 0xE6F0
+#define B_AX_PTCL_DBG_INFO_MASK_BY_PORT(port) \
+({\
+	typeof(port) _port = (port); \
+	GENMASK((_port) * 2 + 1, (_port) * 2); \
+})
+
 #define B_AX_PTCL_DBG_INFO_MASK GENMASK(31, 0)
 #define R_AX_PTCL_DBG 0xC6F4
 #define R_AX_PTCL_DBG_C1 0xE6F4
 #define B_AX_PTCL_DBG_EN BIT(8)
 #define B_AX_PTCL_DBG_SEL_MASK GENMASK(7, 0)
+#define AX_PTCL_DBG_BCNQ_NUM0 8
+#define AX_PTCL_DBG_BCNQ_NUM1 9
+
 
 #define R_AX_DLE_CTRL 0xC800
 #define R_AX_DLE_CTRL_C1 0xE800
-- 
2.43.0


