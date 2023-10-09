Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4927E7BE6B2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377728AbjJIQjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377660AbjJIQjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:39:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D36BAF;
        Mon,  9 Oct 2023 09:39:51 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399CmUN6020781;
        Mon, 9 Oct 2023 16:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=Xmyppk5/viY7nifckWgVhQklOnvWpW9990tdMTqTkTc=;
 b=A1FDebOwESAN+BUoD0pRNO3wWEkFfbimfX6fstQjpglR1bNg0hZ7R8XoJJ8BAH0scTu2
 tREje75hm6koftFbxtuWBz+qB150Do1NHRUcHU90nGYSkOxdBofYvHf1M1qJP4/cyLkm
 BeME3vJL5RnogeXG1/8NWlk58CCT4Sn71X5fHg3JcQSD4TnVDomhbbRvM5Xhx7kBA2v0
 yle3adLt8hckhsofG1fiMIuImMoGOOyUzm0N0ZumfrQvRbEyghKQw/Omhcfo3L5OsTUW
 HvKLHzLbJChGlMc1WYN0V2OiJhUNi0gQgTv4njtGqA+QWdHjeIsjDG9Ys+KBT1nrKwKO 3w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkh8d32dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 16:39:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 399GdinI017318
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Oct 2023 16:39:44 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 9 Oct 2023 09:39:44 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Mon, 9 Oct 2023 09:39:42 -0700
Subject: [PATCH] wifi: ath11k: Introduce and use ath11k_sta_to_arsta()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231009-ath11k_sta_to_arsta-v1-1-1563e3a307e8@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAM0sJGUC/43NwQ6CMAyA4VchOzuzDhjEk+9hDBmjk8bIdJuLh
 vDuDm5ejLf+Tfp1ZgE9YWCHYmYeEwVyUw7YFcyMerogpyE3k0KWIETNdRwBrl2Iuouu0z4PvDd
 VraGpEXvF8uXdo6XXpp7OuUcK0fn39iTBuv3tJeDAy9aAVSLLtj0+nmRoMnvjbmwVk/xDkVmBS
 mklNQ7SNt/Ksiwf1b4xGv4AAAA=
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
X-Proofpoint-GUID: RAFJip5oxc6hR55d0TfpAckjLi_f-gG4
X-Proofpoint-ORIG-GUID: RAFJip5oxc6hR55d0TfpAckjLi_f-gG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_14,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=849 lowpriorityscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310090136
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the logic to return an ath11k_sta pointer, given a
ieee80211_sta pointer, uses typecasting throughout the driver. In
general, conversion functions are preferable to typecasting since
using a conversion function allows the compiler to validate the types
of both the input and output parameters.

ath11k already defines a conversion function ath11k_vif_to_arvif() for
a similar conversion. So introduce ath11k_sta_to_arsta() for this use
case, and convert all of the existing typecasting to use this
function.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h        |  5 +++++
 drivers/net/wireless/ath/ath11k/debugfs.c     |  4 ++--
 drivers/net/wireless/ath/ath11k/debugfs_sta.c | 30 +++++++++++++--------------
 drivers/net/wireless/ath/ath11k/dp_rx.c       |  8 +++----
 drivers/net/wireless/ath/ath11k/dp_tx.c       |  4 ++--
 drivers/net/wireless/ath/ath11k/mac.c         | 18 ++++++++--------
 drivers/net/wireless/ath/ath11k/peer.c        |  2 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |  6 +++---
 8 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 650972f9d146..489c863215a4 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1223,6 +1223,11 @@ static inline struct ath11k_vif *ath11k_vif_to_arvif(struct ieee80211_vif *vif)
 	return (struct ath11k_vif *)vif->drv_priv;
 }
 
+static inline struct ath11k_sta *ath11k_sta_to_arsta(struct ieee80211_sta *sta)
+{
+	return (struct ath11k_sta *)sta->drv_priv;
+}
+
 static inline struct ath11k *ath11k_ab_to_ar(struct ath11k_base *ab,
 					     int mac_id)
 {
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 5bb6fd17fdf6..9f1a2569aaed 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -1459,7 +1459,7 @@ static void ath11k_reset_peer_ps_duration(void *data,
 					  struct ieee80211_sta *sta)
 {
 	struct ath11k *ar = data;
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 
 	spin_lock_bh(&ar->data_lock);
 	arsta->ps_total_duration = 0;
@@ -1510,7 +1510,7 @@ static void ath11k_peer_ps_state_disable(void *data,
 					 struct ieee80211_sta *sta)
 {
 	struct ath11k *ar = data;
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 
 	spin_lock_bh(&ar->data_lock);
 	arsta->peer_ps_state = WMI_PEER_PS_STATE_DISABLED;
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index 9cc4ef28e751..8c177fba6f14 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -136,7 +136,7 @@ static ssize_t ath11k_dbg_sta_dump_tx_stats(struct file *file,
 					    size_t count, loff_t *ppos)
 {
 	struct ieee80211_sta *sta = file->private_data;
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	struct ath11k_htt_data_stats *stats;
 	static const char *str_name[ATH11K_STATS_TYPE_MAX] = {"succ", "fail",
@@ -243,7 +243,7 @@ static ssize_t ath11k_dbg_sta_dump_rx_stats(struct file *file,
 					    size_t count, loff_t *ppos)
 {
 	struct ieee80211_sta *sta = file->private_data;
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	struct ath11k_rx_peer_stats *rx_stats = arsta->rx_stats;
 	int len = 0, i, retval = 0;
@@ -340,7 +340,7 @@ static int
 ath11k_dbg_sta_open_htt_peer_stats(struct inode *inode, struct file *file)
 {
 	struct ieee80211_sta *sta = inode->i_private;
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	struct debug_htt_stats_req *stats_req;
 	int type = ar->debug.htt_stats.type;
@@ -376,7 +376,7 @@ static int
 ath11k_dbg_sta_release_htt_peer_stats(struct inode *inode, struct file *file)
 {
 	struct ieee80211_sta *sta = inode->i_private;
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 
 	mutex_lock(&ar->conf_mutex);
@@ -413,7 +413,7 @@ static ssize_t ath11k_dbg_sta_write_peer_pktlog(struct file *file,
 						size_t count, loff_t *ppos)
 {
 	struct ieee80211_sta *sta = file->private_data;
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	int ret, enable;
 
@@ -453,7 +453,7 @@ static ssize_t ath11k_dbg_sta_read_peer_pktlog(struct file *file,
 					       size_t count, loff_t *ppos)
 {
 	struct ieee80211_sta *sta = file->private_data;
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	char buf[32] = {0};
 	int len;
@@ -480,7 +480,7 @@ static ssize_t ath11k_dbg_sta_write_delba(struct file *file,
 					  size_t count, loff_t *ppos)
 {
 	struct ieee80211_sta *sta = file->private_data;
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	u32 tid, initiator, reason;
 	int ret;
@@ -531,7 +531,7 @@ static ssize_t ath11k_dbg_sta_write_addba_resp(struct file *file,
 					       size_t count, loff_t *ppos)
 {
 	struct ieee80211_sta *sta = file->private_data;
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	u32 tid, status;
 	int ret;
@@ -581,7 +581,7 @@ static ssize_t ath11k_dbg_sta_write_addba(struct file *file,
 					  size_t count, loff_t *ppos)
 {
 	struct ieee80211_sta *sta = file->private_data;
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	u32 tid, buf_size;
 	int ret;
@@ -632,7 +632,7 @@ static ssize_t ath11k_dbg_sta_read_aggr_mode(struct file *file,
 					     size_t count, loff_t *ppos)
 {
 	struct ieee80211_sta *sta = file->private_data;
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	char buf[64];
 	int len = 0;
@@ -652,7 +652,7 @@ static ssize_t ath11k_dbg_sta_write_aggr_mode(struct file *file,
 					      size_t count, loff_t *ppos)
 {
 	struct ieee80211_sta *sta = file->private_data;
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	u32 aggr_mode;
 	int ret;
@@ -697,7 +697,7 @@ ath11k_write_htt_peer_stats_reset(struct file *file,
 				  size_t count, loff_t *ppos)
 {
 	struct ieee80211_sta *sta = file->private_data;
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	struct htt_ext_stats_cfg_params cfg_params = { 0 };
 	int ret;
@@ -756,7 +756,7 @@ static ssize_t ath11k_dbg_sta_read_peer_ps_state(struct file *file,
 						 size_t count, loff_t *ppos)
 {
 	struct ieee80211_sta *sta = file->private_data;
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	char buf[20];
 	int len;
@@ -783,7 +783,7 @@ static ssize_t ath11k_dbg_sta_read_current_ps_duration(struct file *file,
 						       loff_t *ppos)
 {
 	struct ieee80211_sta *sta = file->private_data;
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	u64 time_since_station_in_power_save;
 	char buf[20];
@@ -817,7 +817,7 @@ static ssize_t ath11k_dbg_sta_read_total_ps_duration(struct file *file,
 						     size_t count, loff_t *ppos)
 {
 	struct ieee80211_sta *sta = file->private_data;
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	char buf[20];
 	u64 power_save_duration;
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 9de849f09620..96a60bfd1b16 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1099,7 +1099,7 @@ int ath11k_dp_rx_ampdu_start(struct ath11k *ar,
 			     struct ieee80211_ampdu_params *params)
 {
 	struct ath11k_base *ab = ar->ab;
-	struct ath11k_sta *arsta = (void *)params->sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(params->sta);
 	int vdev_id = arsta->arvif->vdev_id;
 	int ret;
 
@@ -1117,7 +1117,7 @@ int ath11k_dp_rx_ampdu_stop(struct ath11k *ar,
 {
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_peer *peer;
-	struct ath11k_sta *arsta = (void *)params->sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(params->sta);
 	int vdev_id = arsta->arvif->vdev_id;
 	dma_addr_t paddr;
 	bool active;
@@ -1456,7 +1456,7 @@ ath11k_update_per_peer_tx_stats(struct ath11k *ar,
 	}
 
 	sta = peer->sta;
-	arsta = (struct ath11k_sta *)sta->drv_priv;
+	arsta = ath11k_sta_to_arsta(sta);
 
 	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
 
@@ -5242,7 +5242,7 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 			goto next_skb;
 		}
 
-		arsta = (struct ath11k_sta *)peer->sta->drv_priv;
+		arsta = ath11k_sta_to_arsta(peer->sta);
 		ath11k_dp_rx_update_peer_stats(arsta, ppdu_info);
 
 		if (ath11k_debugfs_is_pktlog_peer_valid(ar, peer->addr))
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 0dda76f7a4b5..a5fa08bc623b 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -467,7 +467,7 @@ void ath11k_dp_tx_update_txcompl(struct ath11k *ar, struct hal_tx_status *ts)
 	}
 
 	sta = peer->sta;
-	arsta = (struct ath11k_sta *)sta->drv_priv;
+	arsta = ath11k_sta_to_arsta(sta);
 
 	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
 	pkt_type = FIELD_GET(HAL_TX_RATE_STATS_INFO0_PKT_TYPE,
@@ -627,7 +627,7 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 		ieee80211_free_txskb(ar->hw, msdu);
 		return;
 	}
-	arsta = (struct ath11k_sta *)peer->sta->drv_priv;
+	arsta = ath11k_sta_to_arsta(peer->sta);
 	status.sta = peer->sta;
 	status.skb = msdu;
 	status.info = info;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index a36208a0aab5..7f7b39817773 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2832,7 +2832,7 @@ static void ath11k_peer_assoc_prepare(struct ath11k *ar,
 
 	lockdep_assert_held(&ar->conf_mutex);
 
-	arsta = (struct ath11k_sta *)sta->drv_priv;
+	arsta = ath11k_sta_to_arsta(sta);
 
 	memset(arg, 0, sizeof(*arg));
 
@@ -4315,7 +4315,7 @@ static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		ath11k_warn(ab, "peer %pM disappeared!\n", peer_addr);
 
 	if (sta) {
-		arsta = (struct ath11k_sta *)sta->drv_priv;
+		arsta = ath11k_sta_to_arsta(sta);
 
 		switch (key->cipher) {
 		case WLAN_CIPHER_SUITE_TKIP:
@@ -4906,7 +4906,7 @@ static int ath11k_mac_station_add(struct ath11k *ar,
 {
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct peer_create_params peer_param;
 	int ret;
 
@@ -5030,7 +5030,7 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 {
 	struct ath11k *ar = hw->priv;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k_peer *peer;
 	int ret = 0;
 
@@ -5196,7 +5196,7 @@ static void ath11k_mac_op_sta_set_4addr(struct ieee80211_hw *hw,
 					struct ieee80211_sta *sta, bool enabled)
 {
 	struct ath11k *ar = hw->priv;
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 
 	if (enabled && !arsta->use_4addr_set) {
 		ieee80211_queue_work(ar->hw, &arsta->set_4addr_wk);
@@ -5210,7 +5210,7 @@ static void ath11k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 					u32 changed)
 {
 	struct ath11k *ar = hw->priv;
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ath11k_peer *peer;
 	u32 bw, smps;
@@ -6203,7 +6203,7 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
 	}
 
 	if (control->sta)
-		arsta = (struct ath11k_sta *)control->sta->drv_priv;
+		arsta = ath11k_sta_to_arsta(control->sta);
 
 	ret = ath11k_dp_tx(ar, arvif, arsta, skb);
 	if (unlikely(ret)) {
@@ -8235,7 +8235,7 @@ static void ath11k_mac_set_bitrate_mask_iter(void *data,
 					     struct ieee80211_sta *sta)
 {
 	struct ath11k_vif *arvif = data;
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arvif->ar;
 
 	spin_lock_bh(&ar->data_lock);
@@ -8639,7 +8639,7 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 					 struct ieee80211_sta *sta,
 					 struct station_info *sinfo)
 {
-	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	s8 signal;
 	bool db2dbm = test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
index 114aa3a9a339..1c79a932d17f 100644
--- a/drivers/net/wireless/ath/ath11k/peer.c
+++ b/drivers/net/wireless/ath/ath11k/peer.c
@@ -446,7 +446,7 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 	peer->sec_type_grp = HAL_ENCRYPT_TYPE_OPEN;
 
 	if (sta) {
-		arsta = (struct ath11k_sta *)sta->drv_priv;
+		arsta = ath11k_sta_to_arsta(sta);
 		arsta->tcl_metadata |= FIELD_PREP(HTT_TCL_META_DATA_TYPE, 0) |
 				       FIELD_PREP(HTT_TCL_META_DATA_PEER_ID,
 						  peer->peer_id);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index e93601fe7bcb..9282ecb57380 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -6452,7 +6452,7 @@ static int ath11k_wmi_tlv_rssi_chain_parse(struct ath11k_base *ab,
 		goto exit;
 	}
 
-	arsta = (struct ath11k_sta *)sta->drv_priv;
+	arsta = ath11k_sta_to_arsta(sta);
 
 	BUILD_BUG_ON(ARRAY_SIZE(arsta->chain_signal) >
 		     ARRAY_SIZE(stats_rssi->rssi_avg_beacon));
@@ -6540,7 +6540,7 @@ static int ath11k_wmi_tlv_fw_stats_data_parse(struct ath11k_base *ab,
 							   arvif->bssid,
 							   NULL);
 			if (sta) {
-				arsta = (struct ath11k_sta *)sta->drv_priv;
+				arsta = ath11k_sta_to_arsta(sta);
 				arsta->rssi_beacon = src->beacon_snr;
 				ath11k_dbg(ab, ATH11K_DBG_WMI,
 					   "stats vdev id %d snr %d\n",
@@ -7467,7 +7467,7 @@ static void ath11k_wmi_event_peer_sta_ps_state_chg(struct ath11k_base *ab,
 		goto exit;
 	}
 
-	arsta = (struct ath11k_sta *)sta->drv_priv;
+	arsta = ath11k_sta_to_arsta(sta);
 
 	spin_lock_bh(&ar->data_lock);
 

---
base-commit: 453a62a3ee65aeba6e69bfd09227fc2f19290bea
change-id: 20231005-ath11k_sta_to_arsta-bc45a175eeb6

