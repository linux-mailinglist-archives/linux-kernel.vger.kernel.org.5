Return-Path: <linux-kernel+bounces-115061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82B2888CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457A51F282E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D421C32B6;
	Mon, 25 Mar 2024 01:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcPt0JHL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDEE224A23;
	Sun, 24 Mar 2024 23:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324037; cv=none; b=kN0MAPvnd+02nSC/yiW0eA0f92YoIyfxhmv3/DfbiwoptIR47+Ofn6g8s+IrAdUtRxzTMyPWMAo8sL7vscT/RxecCFIisPYU3G4TBQOm59fHI3l1buboK/KarGEZ3OZxM+wscfkbZOEBkb7DkvlgpnkmZkB7XD/jxSCL8iGFtb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324037; c=relaxed/simple;
	bh=7maQi5aK9NGVnIgohlxBT5F5r5LlybeGvHB2DotLJnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=niWHvldVI33d3BEQcOVMX5vKVDba7hM36zgygm+wujucJDSAHnG7Ifej1/alJgV226mnHw343sdB8veB6++P0RXnEeADUlbuUkg0OCXt2G9muXITx5GPqqTiEnda3H1wCBEjJR4dJlryP/ZD6Kjo4iGNfpy3gJvMeM88I7sWfBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcPt0JHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE74C43390;
	Sun, 24 Mar 2024 23:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324036;
	bh=7maQi5aK9NGVnIgohlxBT5F5r5LlybeGvHB2DotLJnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BcPt0JHL5j5V3M8bn9cKjJOA++yX3/r4reHZn03dkyGP7Pe/m+JzetaUU7BAAFlxS
	 Z8Dx7V9BKeF/z5Qb7rf8NFhmLp+vzBArTjVe6Ydc/MxveTAa4nFnQsOmXx98JefiIR
	 eqz+L7RKajv02Qcvk3zlYmix5dyVKCGlwh0K+QQ2RRtbs0k+KTDP4fCYcc5iJNr5eG
	 /AomP7P+U7mQpSbUh/9K6ybTt+9dwh81oh9xmvSza8GxPtEySJA2Hu7D/sSwfpbqYn
	 vRE575bnwKlTjjTK/slpGaYKiIPT7AUtqIUXt/HdADc2cPcP61l1vOjYiequFIC7E/
	 3VUDNFVhj9M2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 037/183] wifi: wilc1000: fix RCU usage in connect path
Date: Sun, 24 Mar 2024 19:44:10 -0400
Message-ID: <20240324234638.1355609-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Alexis Lothoré <alexis.lothore@bootlin.com>

[ Upstream commit 205c50306acf58a335eb19fa84e40140f4fe814f ]

With lockdep enabled, calls to the connect function from cfg802.11 layer
lead to the following warning:

=============================
WARNING: suspicious RCU usage
6.7.0-rc1-wt+ #333 Not tainted
-----------------------------
drivers/net/wireless/microchip/wilc1000/hif.c:386
suspicious rcu_dereference_check() usage!
[...]
stack backtrace:
CPU: 0 PID: 100 Comm: wpa_supplicant Not tainted 6.7.0-rc1-wt+ #333
Hardware name: Atmel SAMA5
 unwind_backtrace from show_stack+0x18/0x1c
 show_stack from dump_stack_lvl+0x34/0x48
 dump_stack_lvl from wilc_parse_join_bss_param+0x7dc/0x7f4
 wilc_parse_join_bss_param from connect+0x2c4/0x648
 connect from cfg80211_connect+0x30c/0xb74
 cfg80211_connect from nl80211_connect+0x860/0xa94
 nl80211_connect from genl_rcv_msg+0x3fc/0x59c
 genl_rcv_msg from netlink_rcv_skb+0xd0/0x1f8
 netlink_rcv_skb from genl_rcv+0x2c/0x3c
 genl_rcv from netlink_unicast+0x3b0/0x550
 netlink_unicast from netlink_sendmsg+0x368/0x688
 netlink_sendmsg from ____sys_sendmsg+0x190/0x430
 ____sys_sendmsg from ___sys_sendmsg+0x110/0x158
 ___sys_sendmsg from sys_sendmsg+0xe8/0x150
 sys_sendmsg from ret_fast_syscall+0x0/0x1c

This warning is emitted because in the connect path, when trying to parse
target BSS parameters, we dereference a RCU pointer whithout being in RCU
critical section.
Fix RCU dereference usage by moving it to a RCU read critical section. To
avoid wrapping the whole wilc_parse_join_bss_param under the critical
section, just use the critical section to copy ies data

Fixes: c460495ee072 ("staging: wilc1000: fix incorrent type in initializer")
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240105075733.36331-3-alexis.lothore@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/wilc1000/wilc_hif.c | 36 +++++++++++++++++++----------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_hif.c b/drivers/staging/wilc1000/wilc_hif.c
index b9c21315a403a..22e02fd068b4d 100644
--- a/drivers/staging/wilc1000/wilc_hif.c
+++ b/drivers/staging/wilc1000/wilc_hif.c
@@ -441,38 +441,49 @@ static void handle_connect_timeout(struct work_struct *work)
 void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 				struct cfg80211_crypto_settings *crypto)
 {
-	const struct cfg80211_bss_ies *ies = rcu_dereference(bss->ies);
-	const u8 *tim_elm, *ssid_elm, *rates_ie, *supp_rates_ie;
+	const u8 *ies_data, *tim_elm, *ssid_elm, *rates_ie, *supp_rates_ie;
 	const u8 *ht_ie, *wpa_ie, *wmm_ie, *rsn_ie;
 	struct ieee80211_p2p_noa_attr noa_attr;
+	const struct cfg80211_bss_ies *ies;
 	struct wilc_join_bss_param *param;
-	u8 rates_len = 0;
+	u8 rates_len = 0, ies_len;
 	int ret;
 
 	param = kzalloc(sizeof(*param), GFP_KERNEL);
 	if (!param)
 		return NULL;
 
+	rcu_read_lock();
+	ies = rcu_dereference(bss->ies);
+	ies_data = kmemdup(ies->data, ies->len, GFP_ATOMIC);
+	if (!ies_data) {
+		rcu_read_unlock();
+		kfree(param);
+		return NULL;
+	}
+	ies_len = ies->len;
+	rcu_read_unlock();
+
 	param->beacon_period = cpu_to_le16(bss->beacon_interval);
 	param->cap_info = cpu_to_le16(bss->capability);
 	param->bss_type = WILC_FW_BSS_TYPE_INFRA;
 	param->ch = ieee80211_frequency_to_channel(bss->channel->center_freq);
 	ether_addr_copy(param->bssid, bss->bssid);
 
-	ssid_elm = cfg80211_find_ie(WLAN_EID_SSID, ies->data, ies->len);
+	ssid_elm = cfg80211_find_ie(WLAN_EID_SSID, ies_data, ies_len);
 	if (ssid_elm) {
 		if (ssid_elm[1] <= IEEE80211_MAX_SSID_LEN)
 			memcpy(param->ssid, ssid_elm + 2, ssid_elm[1]);
 	}
 
-	tim_elm = cfg80211_find_ie(WLAN_EID_TIM, ies->data, ies->len);
+	tim_elm = cfg80211_find_ie(WLAN_EID_TIM, ies_data, ies_len);
 	if (tim_elm && tim_elm[1] >= 2)
 		param->dtim_period = tim_elm[3];
 
 	memset(param->p_suites, 0xFF, 3);
 	memset(param->akm_suites, 0xFF, 3);
 
-	rates_ie = cfg80211_find_ie(WLAN_EID_SUPP_RATES, ies->data, ies->len);
+	rates_ie = cfg80211_find_ie(WLAN_EID_SUPP_RATES, ies_data, ies_len);
 	if (rates_ie) {
 		rates_len = rates_ie[1];
 		if (rates_len > WILC_MAX_RATES_SUPPORTED)
@@ -483,7 +494,7 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 
 	if (rates_len < WILC_MAX_RATES_SUPPORTED) {
 		supp_rates_ie = cfg80211_find_ie(WLAN_EID_EXT_SUPP_RATES,
-						 ies->data, ies->len);
+						 ies_data, ies_len);
 		if (supp_rates_ie) {
 			u8 ext_rates = supp_rates_ie[1];
 
@@ -498,11 +509,11 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 		}
 	}
 
-	ht_ie = cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, ies->data, ies->len);
+	ht_ie = cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, ies_data, ies_len);
 	if (ht_ie)
 		param->ht_capable = true;
 
-	ret = cfg80211_get_p2p_attr(ies->data, ies->len,
+	ret = cfg80211_get_p2p_attr(ies_data, ies_len,
 				    IEEE80211_P2P_ATTR_ABSENCE_NOTICE,
 				    (u8 *)&noa_attr, sizeof(noa_attr));
 	if (ret > 0) {
@@ -526,7 +537,7 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 	}
 	wmm_ie = cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
 					 WLAN_OUI_TYPE_MICROSOFT_WMM,
-					 ies->data, ies->len);
+					 ies_data, ies_len);
 	if (wmm_ie) {
 		struct ieee80211_wmm_param_ie *ie;
 
@@ -541,13 +552,13 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 
 	wpa_ie = cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
 					 WLAN_OUI_TYPE_MICROSOFT_WPA,
-					 ies->data, ies->len);
+					 ies_data, ies_len);
 	if (wpa_ie) {
 		param->mode_802_11i = 1;
 		param->rsn_found = true;
 	}
 
-	rsn_ie = cfg80211_find_ie(WLAN_EID_RSN, ies->data, ies->len);
+	rsn_ie = cfg80211_find_ie(WLAN_EID_RSN, ies_data, ies_len);
 	if (rsn_ie) {
 		int offset = 8;
 
@@ -570,6 +581,7 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 			param->akm_suites[i] = crypto->akm_suites[i] & 0xFF;
 	}
 
+	kfree(ies_data);
 	return (void *)param;
 }
 
-- 
2.43.0


