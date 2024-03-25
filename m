Return-Path: <linux-kernel+bounces-116450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 047DA889F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8040B1F38348
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CE45A7B9;
	Mon, 25 Mar 2024 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSq2i7Ie"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537EA1EEF0A;
	Mon, 25 Mar 2024 03:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711336329; cv=none; b=bVpe3aZzLgma8LR+chj7C/FuUymycAzn9PKnbL9oQol3uWsOcdk01YTmEXleoR4WbNjC5wFVthqOwBgeHwrtF5Z9Guy2Lr/GHXTjAIKfbvtaxxGbt8YooqT/20nPI8X/rkS9/nkxCaMr4CLsM6Wphl+bp1aXEuNOXHq/RawafiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711336329; c=relaxed/simple;
	bh=n9V7RxkqYkelng1F7mXM7l6doDmXk8Zx1mddg40wVNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NpTWW1Mdfv39aOcchfh1UXZjqPN7W3wSU6/GBIp2Aa60XdhjxfcqdRFxbgwHSbQrOGCD5gRt9zgFpl2pkKcYgEzbS41s9+kirPy7o7Vp/+B4vTl+6Ya4AKjszo0ass5AqouyujcdfXGAPdC5gUe/Lvjh3v6c7erGs5Md58RWpH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSq2i7Ie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EA7C433C7;
	Mon, 25 Mar 2024 03:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711336328;
	bh=n9V7RxkqYkelng1F7mXM7l6doDmXk8Zx1mddg40wVNQ=;
	h=Date:From:To:Cc:Subject:From;
	b=DSq2i7IekgMufyJBUQLqtXyI63VpOEv3TUGRFYAw69MDHyZfdbpbr+tgHS3JKImr3
	 KTolQdwOGshf8yZjeXvNcKOwxYUwAnPkrh6i9z8D4b2H7Cbbemonvl+lGxRzb19J+r
	 f7jzTtajCQrj2Ka44UxrhbRR8uTO3NcWD41FRyJI4v+7HvRVq5GEuufZikpKYb1+Tr
	 ot6VVObePK0ezpvno3joZ8/b//+LBiztUC1JA6/TMFyQfOE6/DN5u2WN4BkNc/2DgO
	 5Rr0w+kuyT92Q4U3qDf61OFSPVbAqmJn3Ix4fCiEniYBFV45A8vgeNksnbWTrDtXa3
	 S45a89a59rDrg==
Date: Sun, 24 Mar 2024 21:12:05 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: mwl8k: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <ZgDrhe5pbV/WvDiZ@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

There is currently an object (`header`), at the beginning of multiple
structures, that contains a flexible structure (`struct mwl8k_cmd_pkt`),
for example:

struct mwl8k_cmd_get_hw_spec_sta {
        struct mwl8k_cmd_pkt header;

	...

	__le32 num_tx_desc_per_queue;
        __le32 total_rxd;
} __packed;

So, in order to avoid ending up with flexible-array members in the
middle of multiple other structs, we use the `__struct_group()` helper
to separate the flexible array from the rest of the members in the
flexible structure:

struct mwl8k_cmd_pkt {
        __struct_group(mwl8k_cmd_pkt_hdr, hdr, __packed,

	... the rest of the members

        );
        char payload[];
} __packed;

With the change described above, we now declare objects of the type of
the tagged struct, in this case `struct mwl8k_cmd_pkt_hdr`, without
embedding flexible arrays in the middle of another struct:

struct mwl8k_cmd_get_hw_spec_sta {
        struct mwl8k_cmd_pkt_hdr header;

        ...

        __le32 num_tx_desc_per_queue;
        __le32 total_rxd;
} __packed;

Also, update the type of a couple of variables and function parameters
from `struct mwl8k_cmd_pkt` to `struct mwl8k_cmd_pkt_hdr`.

So, with these changes, fix 33 of the following warnings[1]:
drivers/net/wireless/marvell/mwl8k.c:2353:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Link: https://gist.github.com/GustavoARSilva/7a841a92c0f24e5efdb30ce02b601eb8 [1]
Link: https://github.com/KSPP/linux/issues/202
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/marvell/mwl8k.c | 92 ++++++++++++++--------------
 1 file changed, 47 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index ce8fea76dbb2..9e534e0a324a 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -587,12 +587,14 @@ static int mwl8k_request_firmware(struct mwl8k_priv *priv, char *fw_image,
 }
 
 struct mwl8k_cmd_pkt {
-	__le16	code;
-	__le16	length;
-	__u8	seq_num;
-	__u8	macid;
-	__le16	result;
-	char	payload[];
+	__struct_group(mwl8k_cmd_pkt_hdr, hdr, __packed,
+		__le16	code;
+		__le16	length;
+		__u8	seq_num;
+		__u8	macid;
+		__le16	result;
+	);
+	char payload[];
 } __packed;
 
 /*
@@ -2201,7 +2203,7 @@ static void mwl8k_enable_bsses(struct ieee80211_hw *hw, bool enable,
 /* Timeout firmware commands after 10s */
 #define MWL8K_CMD_TIMEOUT_MS	10000
 
-static int mwl8k_post_cmd(struct ieee80211_hw *hw, struct mwl8k_cmd_pkt *cmd)
+static int mwl8k_post_cmd(struct ieee80211_hw *hw, struct mwl8k_cmd_pkt_hdr *cmd)
 {
 	DECLARE_COMPLETION_ONSTACK(cmd_wait);
 	struct mwl8k_priv *priv = hw->priv;
@@ -2298,7 +2300,7 @@ static int mwl8k_post_cmd(struct ieee80211_hw *hw, struct mwl8k_cmd_pkt *cmd)
 
 static int mwl8k_post_pervif_cmd(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
-				 struct mwl8k_cmd_pkt *cmd)
+				 struct mwl8k_cmd_pkt_hdr *cmd)
 {
 	if (vif != NULL)
 		cmd->macid = MWL8K_VIF(vif)->macid;
@@ -2350,7 +2352,7 @@ static void mwl8k_setup_5ghz_band(struct ieee80211_hw *hw)
  * CMD_GET_HW_SPEC (STA version).
  */
 struct mwl8k_cmd_get_hw_spec_sta {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__u8 hw_rev;
 	__u8 host_interface;
 	__le16 num_mcaddrs;
@@ -2499,7 +2501,7 @@ static int mwl8k_cmd_get_hw_spec_sta(struct ieee80211_hw *hw)
  * CMD_GET_HW_SPEC (AP version).
  */
 struct mwl8k_cmd_get_hw_spec_ap {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__u8 hw_rev;
 	__u8 host_interface;
 	__le16 num_wcb;
@@ -2593,7 +2595,7 @@ static int mwl8k_cmd_get_hw_spec_ap(struct ieee80211_hw *hw)
  * CMD_SET_HW_SPEC.
  */
 struct mwl8k_cmd_set_hw_spec {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__u8 hw_rev;
 	__u8 host_interface;
 	__le16 num_mcaddrs;
@@ -2670,7 +2672,7 @@ static int mwl8k_cmd_set_hw_spec(struct ieee80211_hw *hw)
  * CMD_MAC_MULTICAST_ADR.
  */
 struct mwl8k_cmd_mac_multicast_adr {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 action;
 	__le16 numaddr;
 	__u8 addr[][ETH_ALEN];
@@ -2681,7 +2683,7 @@ struct mwl8k_cmd_mac_multicast_adr {
 #define MWL8K_ENABLE_RX_ALL_MULTICAST	0x0004
 #define MWL8K_ENABLE_RX_BROADCAST	0x0008
 
-static struct mwl8k_cmd_pkt *
+static struct mwl8k_cmd_pkt_hdr *
 __mwl8k_cmd_mac_multicast_adr(struct ieee80211_hw *hw, int allmulti,
 			      struct netdev_hw_addr_list *mc_list)
 {
@@ -2729,7 +2731,7 @@ __mwl8k_cmd_mac_multicast_adr(struct ieee80211_hw *hw, int allmulti,
  * CMD_GET_STAT.
  */
 struct mwl8k_cmd_get_stat {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le32 stats[64];
 } __packed;
 
@@ -2771,7 +2773,7 @@ static int mwl8k_cmd_get_stat(struct ieee80211_hw *hw,
  * CMD_RADIO_CONTROL.
  */
 struct mwl8k_cmd_radio_control {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 action;
 	__le16 control;
 	__le16 radio_on;
@@ -2832,7 +2834,7 @@ mwl8k_set_radio_preamble(struct ieee80211_hw *hw, bool short_preamble)
 #define MWL8K_RF_TX_POWER_LEVEL_TOTAL	8
 
 struct mwl8k_cmd_rf_tx_power {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 action;
 	__le16 support_level;
 	__le16 current_level;
@@ -2866,7 +2868,7 @@ static int mwl8k_cmd_rf_tx_power(struct ieee80211_hw *hw, int dBm)
 #define MWL8K_TX_POWER_LEVEL_TOTAL      12
 
 struct mwl8k_cmd_tx_power {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 action;
 	__le16 band;
 	__le16 channel;
@@ -2925,7 +2927,7 @@ static int mwl8k_cmd_tx_power(struct ieee80211_hw *hw,
  * CMD_RF_ANTENNA.
  */
 struct mwl8k_cmd_rf_antenna {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 antenna;
 	__le16 mode;
 } __packed;
@@ -2958,7 +2960,7 @@ mwl8k_cmd_rf_antenna(struct ieee80211_hw *hw, int antenna, int mask)
  * CMD_SET_BEACON.
  */
 struct mwl8k_cmd_set_beacon {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 beacon_len;
 	__u8 beacon[];
 };
@@ -2988,7 +2990,7 @@ static int mwl8k_cmd_set_beacon(struct ieee80211_hw *hw,
  * CMD_SET_PRE_SCAN.
  */
 struct mwl8k_cmd_set_pre_scan {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 } __packed;
 
 static int mwl8k_cmd_set_pre_scan(struct ieee80211_hw *hw)
@@ -3013,7 +3015,7 @@ static int mwl8k_cmd_set_pre_scan(struct ieee80211_hw *hw)
  * CMD_BBP_REG_ACCESS.
  */
 struct mwl8k_cmd_bbp_reg_access {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 action;
 	__le16 offset;
 	u8 value;
@@ -3054,7 +3056,7 @@ mwl8k_cmd_bbp_reg_access(struct ieee80211_hw *hw,
  * CMD_SET_POST_SCAN.
  */
 struct mwl8k_cmd_set_post_scan {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le32 isibss;
 	__u8 bssid[ETH_ALEN];
 } __packed;
@@ -3142,7 +3144,7 @@ static void mwl8k_update_survey(struct mwl8k_priv *priv,
  * CMD_SET_RF_CHANNEL.
  */
 struct mwl8k_cmd_set_rf_channel {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 action;
 	__u8 current_channel;
 	__le32 channel_flags;
@@ -3211,7 +3213,7 @@ static int mwl8k_cmd_set_rf_channel(struct ieee80211_hw *hw,
 #define MWL8K_FRAME_PROT_11N_HT_ALL			0x06
 
 struct mwl8k_cmd_update_set_aid {
-	struct	mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16	aid;
 
 	 /* AP's MAC address (BSSID) */
@@ -3283,7 +3285,7 @@ mwl8k_cmd_set_aid(struct ieee80211_hw *hw,
  * CMD_SET_RATE.
  */
 struct mwl8k_cmd_set_rate {
-	struct	mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__u8	legacy_rates[14];
 
 	/* Bitmap for supported MCS codes.  */
@@ -3319,7 +3321,7 @@ mwl8k_cmd_set_rate(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 #define MWL8K_FJ_BEACON_MAXLEN	128
 
 struct mwl8k_cmd_finalize_join {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le32 sleep_interval;	/* Number of beacon periods to sleep */
 	__u8 beacon_data[MWL8K_FJ_BEACON_MAXLEN];
 } __packed;
@@ -3358,7 +3360,7 @@ static int mwl8k_cmd_finalize_join(struct ieee80211_hw *hw, void *frame,
  * CMD_SET_RTS_THRESHOLD.
  */
 struct mwl8k_cmd_set_rts_threshold {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 action;
 	__le16 threshold;
 } __packed;
@@ -3388,7 +3390,7 @@ mwl8k_cmd_set_rts_threshold(struct ieee80211_hw *hw, int rts_thresh)
  * CMD_SET_SLOT.
  */
 struct mwl8k_cmd_set_slot {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 action;
 	__u8 short_slot;
 } __packed;
@@ -3417,7 +3419,7 @@ static int mwl8k_cmd_set_slot(struct ieee80211_hw *hw, bool short_slot_time)
  * CMD_SET_EDCA_PARAMS.
  */
 struct mwl8k_cmd_set_edca_params {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 
 	/* See MWL8K_SET_EDCA_XXX below */
 	__le16 action;
@@ -3502,7 +3504,7 @@ mwl8k_cmd_set_edca_params(struct ieee80211_hw *hw, __u8 qnum,
  * CMD_SET_WMM_MODE.
  */
 struct mwl8k_cmd_set_wmm_mode {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 action;
 } __packed;
 
@@ -3533,7 +3535,7 @@ static int mwl8k_cmd_set_wmm_mode(struct ieee80211_hw *hw, bool enable)
  * CMD_MIMO_CONFIG.
  */
 struct mwl8k_cmd_mimo_config {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le32 action;
 	__u8 rx_antenna_map;
 	__u8 tx_antenna_map;
@@ -3564,7 +3566,7 @@ static int mwl8k_cmd_mimo_config(struct ieee80211_hw *hw, __u8 rx, __u8 tx)
  * CMD_USE_FIXED_RATE (STA version).
  */
 struct mwl8k_cmd_use_fixed_rate_sta {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le32 action;
 	__le32 allow_rate_drop;
 	__le32 num_rates;
@@ -3606,7 +3608,7 @@ static int mwl8k_cmd_use_fixed_rate_sta(struct ieee80211_hw *hw)
  * CMD_USE_FIXED_RATE (AP version).
  */
 struct mwl8k_cmd_use_fixed_rate_ap {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le32 action;
 	__le32 allow_rate_drop;
 	__le32 num_rates;
@@ -3647,7 +3649,7 @@ mwl8k_cmd_use_fixed_rate_ap(struct ieee80211_hw *hw, int mcast, int mgmt)
  * CMD_ENABLE_SNIFFER.
  */
 struct mwl8k_cmd_enable_sniffer {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le32 action;
 } __packed;
 
@@ -3671,7 +3673,7 @@ static int mwl8k_cmd_enable_sniffer(struct ieee80211_hw *hw, bool enable)
 }
 
 struct mwl8k_cmd_update_mac_addr {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	union {
 		struct {
 			__le16 mac_type;
@@ -3756,7 +3758,7 @@ static inline int mwl8k_cmd_del_mac_addr(struct ieee80211_hw *hw,
  * CMD_SET_RATEADAPT_MODE.
  */
 struct mwl8k_cmd_set_rate_adapt_mode {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 action;
 	__le16 mode;
 } __packed;
@@ -3785,7 +3787,7 @@ static int mwl8k_cmd_set_rateadapt_mode(struct ieee80211_hw *hw, __u16 mode)
  * CMD_GET_WATCHDOG_BITMAP.
  */
 struct mwl8k_cmd_get_watchdog_bitmap {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	u8	bitmap;
 } __packed;
 
@@ -3865,7 +3867,7 @@ static void mwl8k_watchdog_ba_events(struct work_struct *work)
  * CMD_BSS_START.
  */
 struct mwl8k_cmd_bss_start {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le32 enable;
 } __packed;
 
@@ -3960,7 +3962,7 @@ struct mwl8k_destroy_ba_stream {
 } __packed;
 
 struct mwl8k_cmd_bastream {
-	struct mwl8k_cmd_pkt	header;
+	struct mwl8k_cmd_pkt_hdr	header;
 	__le32	action;
 	union {
 		struct mwl8k_create_ba_stream	create_params;
@@ -4070,7 +4072,7 @@ static void mwl8k_destroy_ba(struct ieee80211_hw *hw,
  * CMD_SET_NEW_STN.
  */
 struct mwl8k_cmd_set_new_stn {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 aid;
 	__u8 mac_addr[6];
 	__le16 stn_id;
@@ -4206,7 +4208,7 @@ static int mwl8k_cmd_set_new_stn_del(struct ieee80211_hw *hw,
 #define MIC_KEY_LENGTH		8
 
 struct mwl8k_cmd_update_encryption {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 
 	__le32 action;
 	__le32 reserved;
@@ -4216,7 +4218,7 @@ struct mwl8k_cmd_update_encryption {
 } __packed;
 
 struct mwl8k_cmd_set_key {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 
 	__le32 action;
 	__le32 reserved;
@@ -4504,7 +4506,7 @@ struct peer_capability_info {
 } __packed;
 
 struct mwl8k_cmd_update_stadb {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 
 	/* See STADB_ACTION_TYPE */
 	__le32	action;
@@ -5174,7 +5176,7 @@ mwl8k_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 static u64 mwl8k_prepare_multicast(struct ieee80211_hw *hw,
 				   struct netdev_hw_addr_list *mc_list)
 {
-	struct mwl8k_cmd_pkt *cmd;
+	struct mwl8k_cmd_pkt_hdr *cmd;
 
 	/*
 	 * Synthesize and return a command packet that programs the
@@ -5234,7 +5236,7 @@ static void mwl8k_configure_filter(struct ieee80211_hw *hw,
 				   u64 multicast)
 {
 	struct mwl8k_priv *priv = hw->priv;
-	struct mwl8k_cmd_pkt *cmd = (void *)(unsigned long)multicast;
+	struct mwl8k_cmd_pkt_hdr *cmd = (void *)(unsigned long)multicast;
 
 	/*
 	 * AP firmware doesn't allow fine-grained control over
-- 
2.34.1


