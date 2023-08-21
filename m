Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F53782B45
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbjHUON7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjHUON5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:13:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AA7E3;
        Mon, 21 Aug 2023 07:13:55 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LALMmj027900;
        Mon, 21 Aug 2023 14:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=pBf5rfOuZnk0fZM7AWeGe7l0NsKwLyxeWi7K67R7t04=;
 b=EQ9bJGbZWct8XkdFCC5lvI+q46c25y1aiXOctLu1AXbiyhgtWq9IPNHh+MRN6usppRcT
 BH6kaFC53+StzwdhxKSdUrSO5UGbLvF/vBD/h0T9GUrgzXkPMmpenaJKDNT9bTTITfZp
 +cppUnGLVxzy1sReQiTPEkE5OdLFZ3A4rLNiZSwBeq68FyTADnKFbFp82PaXBXqhSeRD
 hs7cUO/QdluMTcnLp8Cgw1eBZoLLSVlprIeO5aJLXjANNEL9gN8BKnDSaJt5+6vLYmAC
 J++WPxJCETvTMkWyZtaC+RvUvXbEb7JKVJB8GAU4e9CSGDiH8Eca8r7rOzxALgc5d88C qA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sm3xv8wm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 14:13:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37LEDhA0024199
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 14:13:43 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 21 Aug 2023 07:13:42 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Mon, 21 Aug 2023 07:13:36 -0700
Subject: [PATCH] wifi: ath11k: Consistently use ath11k_vif_to_arvif()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230821-ath11k_vif_to_arvif-v1-1-fa2c3b60b5cf@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAA9x42QC/32NUQrCMBBEr1L228hui2j88h5SSky3ZhETTWJQS
 u9u7AH8mzcwb2ZIHIUTHJsZIhdJEnwF2jRgnfFXVjJWhhbbDg+EymRHdBuKTEMOg4k1KNRoL4T
 IuttDXT4iT/Jeree+spOUQ/ysJ4V+7X9fIUVK7xg7nEZCxtPzJVa83dpwh35Zli9n9aFfuAAAA
 A==
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: po6G8UgkJll4s1spkrHzoYLQQyV-chuI
X-Proofpoint-ORIG-GUID: po6G8UgkJll4s1spkrHzoYLQQyV-chuI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helper function ath11k_vif_to_arvif() exists to retrieve a struct
ath11k_vif from a struct ieee80211_vif. However, in multiple places
this logic is open-coded with inline typecasting. Since the
typecasting prevents the compiler from type-checking the source and
destination, update the driver to consistently use the helper
function.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c      | 64 +++++++++++++++---------------
 drivers/net/wireless/ath/ath11k/testmode.c |  2 +-
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 2aadf2c387b6..c071bf5841af 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -566,7 +566,7 @@ static void ath11k_get_arvif_iter(void *data, u8 *mac,
 				  struct ieee80211_vif *vif)
 {
 	struct ath11k_vif_iter *arvif_iter = data;
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 
 	if (arvif->vdev_id == arvif_iter->vdev_id)
 		arvif_iter->arvif = arvif;
@@ -1464,7 +1464,7 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
 	u32 params = 0;
 	u8 i = 0;
 
-	tx_arvif = (void *)arvif->vif->mbssid_tx_vif->drv_priv;
+	tx_arvif = ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
 
 	beacons = ieee80211_beacon_get_template_ema_list(tx_arvif->ar->hw,
 							 tx_arvif->vif, 0);
@@ -1520,8 +1520,8 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif)
 	struct sk_buff *bcn;
 	int ret;
 
-	if (arvif->vif->mbssid_tx_vif) {
-		tx_arvif = (void *)arvif->vif->mbssid_tx_vif->drv_priv;
+	if (vif->mbssid_tx_vif) {
+		tx_arvif = ath11k_vif_to_arvif(vif->mbssid_tx_vif);
 		if (tx_arvif != arvif) {
 			ar = tx_arvif->ar;
 			ab = ar->ab;
@@ -1562,7 +1562,7 @@ static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
 	 * non-transmitting interfaces, and results in a crash if sent.
 	 */
 	if (vif->mbssid_tx_vif &&
-	    arvif != (void *)vif->mbssid_tx_vif->drv_priv && arvif->is_up)
+	    arvif != ath11k_vif_to_arvif(vif->mbssid_tx_vif) && arvif->is_up)
 		return 0;
 
 	if (vif->bss_conf.ema_ap && vif->mbssid_tx_vif)
@@ -1626,7 +1626,7 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 	ether_addr_copy(arvif->bssid, info->bssid);
 
 	if (arvif->vif->mbssid_tx_vif)
-		tx_arvif = (struct ath11k_vif *)arvif->vif->mbssid_tx_vif->drv_priv;
+		tx_arvif = ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
 
 	ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
 				 arvif->bssid,
@@ -1649,7 +1649,7 @@ static void ath11k_mac_handle_beacon_iter(void *data, u8 *mac,
 {
 	struct sk_buff *skb = data;
 	struct ieee80211_mgmt *mgmt = (void *)skb->data;
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return;
@@ -1672,7 +1672,7 @@ static void ath11k_mac_handle_beacon_miss_iter(void *data, u8 *mac,
 					       struct ieee80211_vif *vif)
 {
 	u32 *vdev_id = data;
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ath11k *ar = arvif->ar;
 	struct ieee80211_hw *hw = ar->hw;
 
@@ -1718,7 +1718,7 @@ static void ath11k_peer_assoc_h_basic(struct ath11k *ar,
 				      struct ieee80211_sta *sta,
 				      struct peer_assoc_params *arg)
 {
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	u32 aid;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -1746,7 +1746,7 @@ static void ath11k_peer_assoc_h_crypto(struct ath11k *ar,
 	struct ieee80211_bss_conf *info = &vif->bss_conf;
 	struct cfg80211_chan_def def;
 	struct cfg80211_bss *bss;
-	struct ath11k_vif *arvif = (struct ath11k_vif *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	const u8 *rsnie = NULL;
 	const u8 *wpaie = NULL;
 
@@ -1804,7 +1804,7 @@ static void ath11k_peer_assoc_h_rates(struct ath11k *ar,
 				      struct ieee80211_sta *sta,
 				      struct peer_assoc_params *arg)
 {
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct wmi_rate_set_arg *rateset = &arg->peer_legacy_rates;
 	struct cfg80211_chan_def def;
 	const struct ieee80211_supported_band *sband;
@@ -1867,7 +1867,7 @@ static void ath11k_peer_assoc_h_ht(struct ath11k *ar,
 				   struct peer_assoc_params *arg)
 {
 	const struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
@@ -2064,7 +2064,7 @@ static void ath11k_peer_assoc_h_vht(struct ath11k *ar,
 				    struct peer_assoc_params *arg)
 {
 	const struct ieee80211_sta_vht_cap *vht_cap = &sta->deflink.vht_cap;
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	u16 *vht_mcs_mask;
@@ -2261,7 +2261,7 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 				   struct ieee80211_sta *sta,
 				   struct peer_assoc_params *arg)
 {
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct cfg80211_chan_def def;
 	const struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
 	enum nl80211_band band;
@@ -2584,7 +2584,7 @@ static void ath11k_peer_assoc_h_qos(struct ath11k *ar,
 				    struct ieee80211_sta *sta,
 				    struct peer_assoc_params *arg)
 {
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 
 	switch (arvif->vdev_type) {
 	case WMI_VDEV_TYPE_AP:
@@ -2747,7 +2747,7 @@ static void ath11k_peer_assoc_h_phymode(struct ath11k *ar,
 					struct ieee80211_sta *sta,
 					struct peer_assoc_params *arg)
 {
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
@@ -2933,7 +2933,7 @@ static bool ath11k_mac_vif_recalc_sta_he_txbf(struct ath11k *ar,
 					      struct ieee80211_vif *vif,
 					      struct ieee80211_sta_he_cap *he_cap)
 {
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ieee80211_he_cap_elem he_cap_elem = {0};
 	struct ieee80211_sta_he_cap *cap_band = NULL;
 	struct cfg80211_chan_def def;
@@ -2995,7 +2995,7 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 			     struct ieee80211_bss_conf *bss_conf)
 {
 	struct ath11k *ar = hw->priv;
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct peer_assoc_params peer_arg;
 	struct ieee80211_sta *ap_sta;
 	struct ath11k_peer *peer;
@@ -3111,7 +3111,7 @@ static void ath11k_bss_disassoc(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif)
 {
 	struct ath11k *ar = hw->priv;
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -3160,7 +3160,7 @@ static void ath11k_recalculate_mgmt_rate(struct ath11k *ar,
 					 struct ieee80211_vif *vif,
 					 struct cfg80211_chan_def *def)
 {
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	const struct ieee80211_supported_band *sband;
 	u8 basic_rate_idx;
 	int hw_rate_code;
@@ -4632,7 +4632,7 @@ static int ath11k_station_disassoc(struct ath11k *ar,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta)
 {
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	int ret = 0;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -5160,7 +5160,7 @@ static int ath11k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 				       struct ieee80211_sta *sta)
 {
 	struct ath11k *ar = hw->priv;
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	int ret = 0;
 	s16 txpwr;
 
@@ -5210,7 +5210,7 @@ static void ath11k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 {
 	struct ath11k *ar = hw->priv;
 	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ath11k_peer *peer;
 	u32 bw, smps;
 
@@ -5337,7 +5337,7 @@ static int ath11k_mac_op_conf_tx(struct ieee80211_hw *hw,
 				 const struct ieee80211_tx_queue_params *params)
 {
 	struct ath11k *ar = hw->priv;
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct wmi_wmm_params_arg *p = NULL;
 	int ret;
 
@@ -6455,7 +6455,7 @@ static int ath11k_mac_setup_vdev_params_mbssid(struct ath11k_vif *arvif,
 		return 0;
 	}
 
-	tx_arvif = (void *)tx_vif->drv_priv;
+	tx_arvif = ath11k_vif_to_arvif(tx_vif);
 
 	if (arvif->vif->bss_conf.nontransmitted) {
 		if (ar->hw->wiphy != ieee80211_vif_to_wdev(tx_vif)->wiphy)
@@ -7408,7 +7408,7 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 	/* TODO: Update ar->rx_channel */
 
 	for (i = 0; i < n_vifs; i++) {
-		arvif = (void *)vifs[i].vif->drv_priv;
+		arvif = ath11k_vif_to_arvif(vifs[i].vif);
 
 		if (WARN_ON(!arvif->is_started))
 			continue;
@@ -7450,7 +7450,7 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 
 		mbssid_tx_vif = arvif->vif->mbssid_tx_vif;
 		if (mbssid_tx_vif)
-			tx_arvif = (struct ath11k_vif *)mbssid_tx_vif->drv_priv;
+			tx_arvif = ath11k_vif_to_arvif(mbssid_tx_vif);
 
 		ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
 					 arvif->bssid,
@@ -7546,7 +7546,7 @@ static int ath11k_start_vdev_delay(struct ieee80211_hw *hw,
 {
 	struct ath11k *ar = hw->priv;
 	struct ath11k_base *ab = ar->ab;
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	int ret;
 
 	if (WARN_ON(arvif->is_started))
@@ -7596,7 +7596,7 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 {
 	struct ath11k *ar = hw->priv;
 	struct ath11k_base *ab = ar->ab;
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	int ret;
 	struct peer_create_params param;
 
@@ -7686,7 +7686,7 @@ ath11k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 {
 	struct ath11k *ar = hw->priv;
 	struct ath11k_base *ab = ar->ab;
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ath11k_peer *peer;
 	int ret;
 
@@ -8307,7 +8307,7 @@ ath11k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			       struct ieee80211_vif *vif,
 			       const struct cfg80211_bitrate_mask *mask)
 {
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct cfg80211_chan_def def;
 	struct ath11k_pdev_cap *cap;
 	struct ath11k *ar = arvif->ar;
@@ -8904,7 +8904,7 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 					   enum ieee80211_roc_type type)
 {
 	struct ath11k *ar = hw->priv;
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct scan_req_params arg;
 	int ret;
 	u32 scan_time_msec;
diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
index 8fc5cddb28bd..43bb23265d34 100644
--- a/drivers/net/wireless/ath/ath11k/testmode.c
+++ b/drivers/net/wireless/ath/ath11k/testmode.c
@@ -350,7 +350,7 @@ static int ath11k_tm_cmd_wmi(struct ath11k *ar, struct nlattr *tb[],
 	if (ar->ab->fw_mode != ATH11K_FIRMWARE_MODE_FTM &&
 	    (tag == WMI_TAG_VDEV_SET_PARAM_CMD || tag == WMI_TAG_UNIT_TEST_CMD)) {
 		if (vif) {
-			arvif = (struct ath11k_vif *)vif->drv_priv;
+			arvif = ath11k_vif_to_arvif(vif);
 			*ptr = arvif->vdev_id;
 		} else {
 			ret = -EINVAL;

---
base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e
change-id: 20230810-ath11k_vif_to_arvif-090cb100e937

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>

