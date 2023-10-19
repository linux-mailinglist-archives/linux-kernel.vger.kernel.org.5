Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0891A7D001B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbjJSQ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbjJSQ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:58:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0777B12A;
        Thu, 19 Oct 2023 09:57:57 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JGK4pa025592;
        Thu, 19 Oct 2023 16:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=tR4P2i779nsa9la0a1oQcjUVlyZDjWN0SOTtc95npQY=;
 b=LNw+n11ENLwhTidLjHPsy6zf2IQitcis9u+q5Ri/jSoLfsmAtI08PnfwGm+Y6m/0x8om
 af4QhFU/33wvOegxueAAnteNK5q0REe+WPbVPUz//sMRZvHo2HsxjnwmgbptDpZmYk81
 Nv4uHBUrCT6IcfnT+2EdqO9xXWoxjjhFosJcu2AJL8QqEZLRhLSvFCwmWVK+qpGnWKhH
 bvwLyGje1uaDGXtaIDNsTWjwUzE9yHwV47sT83sGWqVoeLur1Qik97PcM1AJAVsFHQxw
 F5eMTP8IggWKScXxNLbaZxKOQOq7wBeb8u60cAa2OtuDywxuPqY4+D5KpobQ8AvjexNE YQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ttgw3u4s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 16:57:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39JGvp2m013559
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 16:57:51 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 19 Oct 2023 09:57:50 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Thu, 19 Oct 2023 09:57:50 -0700
Subject: [PATCH] wifi: ath12k: Introduce and use ath12k_sta_to_arsta()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231019-upstream-ath12k_sta_to_arsta-v1-1-06f06f693338@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAA1gMWUC/x3MQQqEMAxA0atI1lNoqwv1KsNQok01yKgknUEQ7
 25x99/mn6AkTAp9dYLQn5W3tcC9KhhnXCcyHIvBW1876zrz2zUL4ddgnp1fgmYMeQsoJQw1qUu
 2jS0NEcpiF0p8PPv357puMbs+NG4AAAA=
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
X-Proofpoint-ORIG-GUID: QOfkKJB6CH5rWAuetTmXJRU8CO4iYf13
X-Proofpoint-GUID: QOfkKJB6CH5rWAuetTmXJRU8CO4iYf13
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_15,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 mlxlogscore=694
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the logic to return an ath12k_sta pointer, given a
ieee80211_sta pointer, uses typecasting throughout the driver. In
general, conversion functions are preferable to typecasting since
using a conversion function allows the compiler to validate the types
of both the input and output parameters.

ath12k already defines a conversion function ath12k_vif_to_arvif() for
a similar conversion. So introduce ath12k_sta_to_arsta() for this use
case, and convert all of the existing typecasting to use this
function.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h   |  5 +++++
 drivers/net/wireless/ath/ath12k/dp_mon.c |  4 ++--
 drivers/net/wireless/ath/ath12k/dp_rx.c  |  6 +++---
 drivers/net/wireless/ath/ath12k/mac.c    | 12 ++++++------
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index fafb2a5b9350..68c42ca44fcb 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -852,6 +852,11 @@ static inline struct ath12k_vif *ath12k_vif_to_arvif(struct ieee80211_vif *vif)
 	return (struct ath12k_vif *)vif->drv_priv;
 }
 
+static inline struct ath12k_sta *ath12k_sta_to_arsta(struct ieee80211_sta *sta)
+{
+	return (struct ath12k_sta *)sta->drv_priv;
+}
+
 static inline struct ath12k *ath12k_ab_to_ar(struct ath12k_base *ab,
 					     int mac_id)
 {
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 1698a7712494..f44bc5494ce7 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2374,7 +2374,7 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k *ar,
 		return;
 	}
 
-	arsta = (struct ath12k_sta *)peer->sta->drv_priv;
+	arsta = ath12k_sta_to_arsta(peer->sta);
 	rx_stats = arsta->rx_stats;
 
 	if (!rx_stats)
@@ -2550,7 +2550,7 @@ int ath12k_dp_mon_rx_process_stats(struct ath12k *ar, int mac_id,
 			}
 
 			if (ppdu_info->reception_type == HAL_RX_RECEPTION_TYPE_SU) {
-				arsta = (struct ath12k_sta *)peer->sta->drv_priv;
+				arsta = ath12k_sta_to_arsta(peer->sta);
 				ath12k_dp_mon_rx_update_peer_su_stats(ar, arsta,
 								      ppdu_info);
 			} else if ((ppdu_info->fc_valid) &&
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 54e0a09bf8dd..670901437cb6 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1054,7 +1054,7 @@ int ath12k_dp_rx_ampdu_start(struct ath12k *ar,
 			     struct ieee80211_ampdu_params *params)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_sta *arsta = (void *)params->sta->drv_priv;
+	struct ath12k_sta *arsta = ath12k_sta_to_arsta(params->sta);
 	int vdev_id = arsta->arvif->vdev_id;
 	int ret;
 
@@ -1072,7 +1072,7 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_peer *peer;
-	struct ath12k_sta *arsta = (void *)params->sta->drv_priv;
+	struct ath12k_sta *arsta = ath12k_sta_to_arsta(params->sta);
 	int vdev_id = arsta->arvif->vdev_id;
 	bool active;
 	int ret;
@@ -1410,7 +1410,7 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 	}
 
 	sta = peer->sta;
-	arsta = (struct ath12k_sta *)sta->drv_priv;
+	arsta = ath12k_sta_to_arsta(sta);
 
 	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index aebbb762dcfb..fc0d14ea328e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3247,7 +3247,7 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		ath12k_warn(ab, "peer %pM disappeared!\n", peer_addr);
 
 	if (sta) {
-		arsta = (struct ath12k_sta *)sta->drv_priv;
+		arsta = ath12k_sta_to_arsta(sta);
 
 		switch (key->cipher) {
 		case WLAN_CIPHER_SUITE_TKIP:
@@ -3637,7 +3637,7 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
-	struct ath12k_sta *arsta = (struct ath12k_sta *)sta->drv_priv;
+	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 	struct ath12k_wmi_peer_create_arg peer_param;
 	int ret;
 
@@ -3744,7 +3744,7 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 {
 	struct ath12k *ar = hw->priv;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
-	struct ath12k_sta *arsta = (struct ath12k_sta *)sta->drv_priv;
+	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 	struct ath12k_peer *peer;
 	int ret = 0;
 
@@ -3892,7 +3892,7 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 					u32 changed)
 {
 	struct ath12k *ar = hw->priv;
-	struct ath12k_sta *arsta = (struct ath12k_sta *)sta->drv_priv;
+	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_peer *peer;
 	u32 bw, smps;
@@ -6762,7 +6762,7 @@ static void ath12k_mac_set_bitrate_mask_iter(void *data,
 					     struct ieee80211_sta *sta)
 {
 	struct ath12k_vif *arvif = data;
-	struct ath12k_sta *arsta = (struct ath12k_sta *)sta->drv_priv;
+	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 	struct ath12k *ar = arvif->ar;
 
 	spin_lock_bh(&ar->data_lock);
@@ -7051,7 +7051,7 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 					 struct ieee80211_sta *sta,
 					 struct station_info *sinfo)
 {
-	struct ath12k_sta *arsta = (struct ath12k_sta *)sta->drv_priv;
+	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 
 	sinfo->rx_duration = arsta->rx_duration;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);

---
base-commit: 2e66190e0d87a7266c89728565e0681b22e68f30
change-id: 20231019-upstream-ath12k_sta_to_arsta-e4f9f08d8ebd

