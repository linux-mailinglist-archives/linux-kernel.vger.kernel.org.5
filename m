Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BBE7B873B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbjJDSDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243711AbjJDSDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:03:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F970A6;
        Wed,  4 Oct 2023 11:02:59 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394FBX7G013070;
        Wed, 4 Oct 2023 18:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=OvZUuyZPmdXb7F8qQXaNslpqNBSL7LH3Mp9t06dauGI=;
 b=hPIfPbd5JY5GXYbW9cAX5q2faKWSlVkQ/7kHdJ+Ku6Sl8tMgAkbjvBlOLaipzBKlIcOl
 DEUg/790oRzykvT++Pyrrt1eHT/Ewm224m5qF31wXJH+Ip6+/PbptZ6/o5vaA7uAzAFc
 S/vmgkbj3Bc+PI+2WhYpZp6sntO6vA+pp3R1V1awosCEaDnvBjhBF/0TRGJLx8JGorwC
 yP1TvCIRwmKDJ/kMyNLNA3QVgiNklRumRUeGzwwBRJbfEeH8hwx2tWTR4KiMNdd6eyCF
 32ckheAwggbNC1yorxgBGPUccT9sFS0su0yNb6UzgvjQJ8UE0RftmKEZORGNV2IIm+R4 rQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3th8ck0vgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 18:02:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 394I2Odg030308
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 18:02:24 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 4 Oct 2023 11:02:24 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Wed, 4 Oct 2023 11:02:21 -0700
Subject: [PATCH] wifi: ath12k: Consistently use ath12k_vif_to_arvif()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231004-ath12k_vif_to_arvif-v1-1-3f38f6882d33@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKyoHWUC/32NQQ7CIBREr9L8tRgoJG1deQ/TEISP/TGWCpVoG
 u4u9gDu5k0ybzZIGAkTnJoNImZKFOYK4tCAncx8Q0auMrS8lXwQipl1Eu1dZ/J6DdrEGpjvrly
 qzkjjHdTlEtHTe7dexsoTpTXEz36Sxa/978uCCcYHKXunsHeozs8XWZrt0YYHjKWULzSv5wW4A
 AAA
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sMR7HTtbE3oGH2DaZ9PiA5m1z3_zxyph
X-Proofpoint-ORIG-GUID: sMR7HTtbE3oGH2DaZ9PiA5m1z3_zxyph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_10,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310040131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helper function ath12k_vif_to_arvif() exists to retrieve a struct
ath12k_vif from a struct ieee80211_vif. However, in multiple places
this logic is open-coded with inline typecasting. Since the
typecasting prevents the compiler from type-checking the source and
destination, update the driver to consistently use the helper
function.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 44 +++++++++++++++++------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index c092451f8580..59d8fff78e6d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -523,7 +523,7 @@ static void ath12k_get_arvif_iter(void *data, u8 *mac,
 				  struct ieee80211_vif *vif)
 {
 	struct ath12k_vif_iter *arvif_iter = data;
-	struct ath12k_vif *arvif = (void *)vif->drv_priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 
 	if (arvif->vdev_id == arvif_iter->vdev_id)
 		arvif_iter->arvif = arvif;
@@ -1208,7 +1208,7 @@ static void ath12k_peer_assoc_h_basic(struct ath12k *ar,
 				      struct ieee80211_sta *sta,
 				      struct ath12k_wmi_peer_assoc_arg *arg)
 {
-	struct ath12k_vif *arvif = (void *)vif->drv_priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	u32 aid;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -1236,7 +1236,7 @@ static void ath12k_peer_assoc_h_crypto(struct ath12k *ar,
 	struct ieee80211_bss_conf *info = &vif->bss_conf;
 	struct cfg80211_chan_def def;
 	struct cfg80211_bss *bss;
-	struct ath12k_vif *arvif = (struct ath12k_vif *)vif->drv_priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	const u8 *rsnie = NULL;
 	const u8 *wpaie = NULL;
 
@@ -1294,7 +1294,7 @@ static void ath12k_peer_assoc_h_rates(struct ath12k *ar,
 				      struct ieee80211_sta *sta,
 				      struct ath12k_wmi_peer_assoc_arg *arg)
 {
-	struct ath12k_vif *arvif = (void *)vif->drv_priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct wmi_rate_set_arg *rateset = &arg->peer_legacy_rates;
 	struct cfg80211_chan_def def;
 	const struct ieee80211_supported_band *sband;
@@ -1357,7 +1357,7 @@ static void ath12k_peer_assoc_h_ht(struct ath12k *ar,
 				   struct ath12k_wmi_peer_assoc_arg *arg)
 {
 	const struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
-	struct ath12k_vif *arvif = (void *)vif->drv_priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
@@ -1518,7 +1518,7 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 				    struct ath12k_wmi_peer_assoc_arg *arg)
 {
 	const struct ieee80211_sta_vht_cap *vht_cap = &sta->deflink.vht_cap;
-	struct ath12k_vif *arvif = (void *)vif->drv_priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	const u16 *vht_mcs_mask;
@@ -1793,7 +1793,7 @@ static void ath12k_peer_assoc_h_qos(struct ath12k *ar,
 				    struct ieee80211_sta *sta,
 				    struct ath12k_wmi_peer_assoc_arg *arg)
 {
-	struct ath12k_vif *arvif = (void *)vif->drv_priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 
 	switch (arvif->vdev_type) {
 	case WMI_VDEV_TYPE_AP:
@@ -1991,7 +1991,7 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 					struct ieee80211_sta *sta,
 					struct ath12k_wmi_peer_assoc_arg *arg)
 {
-	struct ath12k_vif *arvif = (void *)vif->drv_priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
@@ -2140,7 +2140,7 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 	const struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
 	const struct ieee80211_eht_mcs_nss_supp_20mhz_only *bw_20;
 	const struct ieee80211_eht_mcs_nss_supp_bw *bw;
-	struct ath12k_vif *arvif = (struct ath12k_vif *)vif->drv_priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	u32 *rx_mcs, *tx_mcs;
 
 	if (!sta->deflink.he_cap.has_he || !eht_cap->has_eht)
@@ -2266,7 +2266,7 @@ static void ath12k_bss_assoc(struct ieee80211_hw *hw,
 			     struct ieee80211_bss_conf *bss_conf)
 {
 	struct ath12k *ar = hw->priv;
-	struct ath12k_vif *arvif = (void *)vif->drv_priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_wmi_peer_assoc_arg peer_arg;
 	struct ieee80211_sta *ap_sta;
 	struct ath12k_peer *peer;
@@ -2360,7 +2360,7 @@ static void ath12k_bss_disassoc(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif)
 {
 	struct ath12k *ar = hw->priv;
-	struct ath12k_vif *arvif = (void *)vif->drv_priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -2407,7 +2407,7 @@ static void ath12k_recalculate_mgmt_rate(struct ath12k *ar,
 					 struct ieee80211_vif *vif,
 					 struct cfg80211_chan_def *def)
 {
-	struct ath12k_vif *arvif = (void *)vif->drv_priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	const struct ieee80211_supported_band *sband;
 	u8 basic_rate_idx;
 	int hw_rate_code;
@@ -3420,7 +3420,7 @@ static int ath12k_station_disassoc(struct ath12k *ar,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta)
 {
-	struct ath12k_vif *arvif = (void *)vif->drv_priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -3856,7 +3856,7 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 				       struct ieee80211_sta *sta)
 {
 	struct ath12k *ar = hw->priv;
-	struct ath12k_vif *arvif = (void *)vif->drv_priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 	s16 txpwr;
 
@@ -3893,7 +3893,7 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 {
 	struct ath12k *ar = hw->priv;
 	struct ath12k_sta *arsta = (struct ath12k_sta *)sta->drv_priv;
-	struct ath12k_vif *arvif = (void *)vif->drv_priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_peer *peer;
 	u32 bw, smps;
 
@@ -4019,7 +4019,7 @@ static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
 				 const struct ieee80211_tx_queue_params *params)
 {
 	struct ath12k *ar = hw->priv;
-	struct ath12k_vif *arvif = (void *)vif->drv_priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct wmi_wmm_params_arg *p = NULL;
 	int ret;
 
@@ -6123,7 +6123,7 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 	lockdep_assert_held(&ar->conf_mutex);
 
 	for (i = 0; i < n_vifs; i++) {
-		arvif = (void *)vifs[i].vif->drv_priv;
+		arvif = ath12k_vif_to_arvif(vifs[i].vif);
 
 		if (vifs[i].vif->type == NL80211_IFTYPE_MONITOR)
 			monitor_vif = true;
@@ -6157,7 +6157,7 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 	/* TODO: Update ar->rx_channel */
 
 	for (i = 0; i < n_vifs; i++) {
-		arvif = (void *)vifs[i].vif->drv_priv;
+		arvif = ath12k_vif_to_arvif(vifs[i].vif);
 
 		if (WARN_ON(!arvif->is_started))
 			continue;
@@ -6271,7 +6271,7 @@ static int ath12k_start_vdev_delay(struct ieee80211_hw *hw,
 {
 	struct ath12k *ar = hw->priv;
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_vif *arvif = (void *)vif->drv_priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 
 	if (WARN_ON(arvif->is_started))
@@ -6307,7 +6307,7 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 {
 	struct ath12k *ar = hw->priv;
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_vif *arvif = (void *)vif->drv_priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 	struct ath12k_wmi_peer_create_arg param;
 
@@ -6386,7 +6386,7 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 {
 	struct ath12k *ar = hw->priv;
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_vif *arvif = (void *)vif->drv_priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 
 	mutex_lock(&ar->conf_mutex);
@@ -6749,7 +6749,7 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			       struct ieee80211_vif *vif,
 			       const struct cfg80211_bitrate_mask *mask)
 {
-	struct ath12k_vif *arvif = (void *)vif->drv_priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct cfg80211_chan_def def;
 	struct ath12k *ar = arvif->ar;
 	enum nl80211_band band;

---
base-commit: da88574f60df34727f5bf9ed4c56cf418d1d2551
change-id: 20230914-ath12k_vif_to_arvif-f7b0347a3afd

