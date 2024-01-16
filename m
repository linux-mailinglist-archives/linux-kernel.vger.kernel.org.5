Return-Path: <linux-kernel+bounces-27942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F9B82F821
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B58288D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E7612CDB5;
	Tue, 16 Jan 2024 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRIIZwp+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1EB12D2AB;
	Tue, 16 Jan 2024 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434630; cv=none; b=ej4MECx/uyimJh8iR8oybRaoUs74zT6Q6qb9TFJbZ1C6qTJoycX76zDBdeKpY7buai4sNlK/wKk5+Aj4fD+7wV36zWIJwQamqh90KoSbLi2/NN8tbyRAUuiipS83NRauACGF7ctPacX2nPIfQWvQEWuI8ctQ+zzUahUp1mmsDy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434630; c=relaxed/simple;
	bh=x9cXzswagpjrB262o9kc4HKMRBSOS+4Jfsvay3PSTek=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=Bq/aMHosVcGXQlXLi08Od22NsLHZueR1pa/b/eYOl6AxtyhOr/k9wM4MKTXK2Yw3m6PeBNxPBPn51ewXjoPndl0udWkqyP5MuqMrLzdZstACtA8z1Y/ccMpqvHyR5sTVlyqMOfV7GHtZSC+ntTnBPG/WozRxkDVgd9fgw9dWgdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRIIZwp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C81C43390;
	Tue, 16 Jan 2024 19:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434630;
	bh=x9cXzswagpjrB262o9kc4HKMRBSOS+4Jfsvay3PSTek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HRIIZwp+Q0bzlWPOdTUCaUOF9tXZ/Bk1Q/qev8OCTh0kqKb7+ZCvLd62xcYMT2mxX
	 1Jdh6WOl9xVKlH9IzHJF+EFba5zIdu/hOpxM6d8zJz2TVMQuz07RiXaYFqhY6Dfgcc
	 hWzDqd8hmymWBOUBPlzJNQwaXI72JirOWYP1LlGNw/TDHOqb79D78GAK+gFSKWV0W2
	 nR2KLkF/v8lM7MY5Go+7PXrbVkPOinmfhby7KUa5dKhQ8zUDLZkfJ6CEkNr10ZWua2
	 7+9oH2Fm9vYrYnJbKxtP/YRusKCGnAz3If6gxp9rrfjOvKeVSTW5lLMvpAgtEEs8Yx
	 shS7bLLngojMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chih-Kang Chang <gary.chang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 034/104] wifi: rtw89: fix misbehavior of TX beacon in concurrent mode
Date: Tue, 16 Jan 2024 14:46:00 -0500
Message-ID: <20240116194908.253437-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Chih-Kang Chang <gary.chang@realtek.com>

[ Upstream commit 756b31203d482d2dd1aa6c208978b0410dc7530f ]

In concurrent mode, when STA interface is scanning, it causes
AP interface TX beacon on wrong channel. We modified it to scan
with the operating channel when one of the interfaces is already
connected. Additionally, STA interface need to stop scan when AP
interface is starting to avoid TX beacon on wrong channel. Finally,
AP interface need to stop TX beacon when STA interface is scanning
and switching to non-OP channel,This prevent other device to get
beacons on wrong channel.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20231129070046.18443-5-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/fw.c       | 17 +++++++++--
 drivers/net/wireless/realtek/rtw89/mac.c      | 29 +++++++++++++++----
 drivers/net/wireless/realtek/rtw89/mac.h      |  1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  3 ++
 4 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index df1dc2f43c86..468cfa43ec04 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3912,6 +3912,7 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	rtw89_core_scan_complete(rtwdev, vif, true);
 	ieee80211_scan_completed(rtwdev->hw, &info);
 	ieee80211_wake_queues(rtwdev->hw);
+	rtw89_mac_enable_beacon_for_ap_vifs(rtwdev, true);
 
 	rtw89_release_pkt_list(rtwdev);
 	rtwvif = (struct rtw89_vif *)vif->drv_priv;
@@ -3929,6 +3930,19 @@ void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
 	rtw89_hw_scan_complete(rtwdev, vif, true);
 }
 
+static bool rtw89_is_any_vif_connected_or_connecting(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_vif *rtwvif;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		/* This variable implies connected or during attempt to connect */
+		if (!is_zero_ether_addr(rtwvif->bssid))
+			return true;
+	}
+
+	return false;
+}
+
 int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			  bool enable)
 {
@@ -3941,8 +3955,7 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	if (!rtwvif)
 		return -EINVAL;
 
-	/* This variable implies connected or during attempt to connect */
-	connected = !is_zero_ether_addr(rtwvif->bssid);
+	connected = rtw89_is_any_vif_connected_or_connecting(rtwdev);
 	opt.enable = enable;
 	opt.target_ch_mode = connected;
 	if (enable) {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index fab9f5004a75..3c818c4b4653 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3833,11 +3833,9 @@ static void rtw89_mac_port_cfg_rx_sync(struct rtw89_dev *rtwdev,
 }
 
 static void rtw89_mac_port_cfg_tx_sw(struct rtw89_dev *rtwdev,
-				     struct rtw89_vif *rtwvif)
+				     struct rtw89_vif *rtwvif, bool en)
 {
 	const struct rtw89_port_reg *p = &rtw_port_base;
-	bool en = rtwvif->net_type == RTW89_NET_TYPE_AP_MODE ||
-		  rtwvif->net_type == RTW89_NET_TYPE_AD_HOC;
 
 	if (en)
 		rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_BCNTX_EN);
@@ -3845,6 +3843,24 @@ static void rtw89_mac_port_cfg_tx_sw(struct rtw89_dev *rtwdev,
 		rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, B_AX_BCNTX_EN);
 }
 
+static void rtw89_mac_port_cfg_tx_sw_by_nettype(struct rtw89_dev *rtwdev,
+						struct rtw89_vif *rtwvif)
+{
+	bool en = rtwvif->net_type == RTW89_NET_TYPE_AP_MODE ||
+		  rtwvif->net_type == RTW89_NET_TYPE_AD_HOC;
+
+	rtw89_mac_port_cfg_tx_sw(rtwdev, rtwvif, en);
+}
+
+void rtw89_mac_enable_beacon_for_ap_vifs(struct rtw89_dev *rtwdev, bool en)
+{
+	struct rtw89_vif *rtwvif;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE)
+			rtw89_mac_port_cfg_tx_sw(rtwdev, rtwvif, en);
+}
+
 static void rtw89_mac_port_cfg_bcn_intv(struct rtw89_dev *rtwdev,
 					struct rtw89_vif *rtwvif)
 {
@@ -4137,7 +4153,7 @@ int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_mac_port_cfg_bcn_prct(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_rx_sw(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_rx_sync(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_tx_sw(rtwdev, rtwvif);
+	rtw89_mac_port_cfg_tx_sw_by_nettype(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_bcn_intv(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_hiq_win(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_hiq_dtim(rtwdev, rtwvif);
@@ -4298,8 +4314,10 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 
 	switch (reason) {
 	case RTW89_SCAN_LEAVE_CH_NOTIFY:
-		if (rtw89_is_op_chan(rtwdev, band, chan))
+		if (rtw89_is_op_chan(rtwdev, band, chan)) {
+			rtw89_mac_enable_beacon_for_ap_vifs(rtwdev, false);
 			ieee80211_stop_queues(rtwdev->hw);
+		}
 		return;
 	case RTW89_SCAN_END_SCAN_NOTIFY:
 		if (rtwvif && rtwvif->scan_req &&
@@ -4317,6 +4335,7 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 		if (rtw89_is_op_chan(rtwdev, band, chan)) {
 			rtw89_assign_entity_chan(rtwdev, rtwvif->sub_entity_idx,
 						 &rtwdev->scan_info.op_chan);
+			rtw89_mac_enable_beacon_for_ap_vifs(rtwdev, true);
 			ieee80211_wake_queues(rtwdev->hw);
 		} else {
 			rtw89_chan_create(&new, chan, chan, band,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 7cf34137c0bc..7c57ab2814c7 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -974,6 +974,7 @@ int rtw89_mac_port_get_tsf(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 					struct ieee80211_vif *vif);
 void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
+void rtw89_mac_enable_beacon_for_ap_vifs(struct rtw89_dev *rtwdev, bool en);
 int rtw89_mac_remove_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
 void rtw89_mac_disable_cpu(struct rtw89_dev *rtwdev);
 int rtw89_mac_enable_cpu(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 5e48618706d9..e70757e4dc2c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -472,6 +472,9 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 		return -EOPNOTSUPP;
 	}
 
+	if (rtwdev->scanning)
+		rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
+
 	ether_addr_copy(rtwvif->bssid, vif->bss_conf.bssid);
 	rtw89_cam_bssid_changed(rtwdev, rtwvif);
 	rtw89_mac_port_update(rtwdev, rtwvif);
-- 
2.43.0


