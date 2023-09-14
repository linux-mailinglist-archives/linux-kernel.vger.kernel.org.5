Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4888079F964
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 06:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbjINEGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 00:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbjINEFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 00:05:44 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6AC941FCE;
        Wed, 13 Sep 2023 21:05:36 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 764C1606080E2;
        Thu, 14 Sep 2023 12:05:34 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     kvalo@kernel.org, quic_jjohnson@quicinc.com
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH wireless-next 8/9] wifi: ath11k: remove unnecessary (void*) conversions
Date:   Thu, 14 Sep 2023 12:05:33 +0800
Message-Id: <20230914040533.1170191-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void *) to (struct ath11k_base *),
struct hal_rx_msdu_link *), (struct ath11k_buffer_addr *) or
other types.

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/wireless/ath/ath11k/dp.c       |  2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c    | 13 +++++--------
 drivers/net/wireless/ath/ath11k/hal.c      |  8 +++-----
 drivers/net/wireless/ath/ath11k/hal_rx.c   | 17 +++++++----------
 drivers/net/wireless/ath/ath11k/hal_tx.c   |  2 +-
 drivers/net/wireless/ath/ath11k/mac.c      |  4 ++--
 drivers/net/wireless/ath/ath11k/spectral.c |  2 +-
 drivers/net/wireless/ath/ath11k/wmi.c      |  6 +++---
 8 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index d070bcb3fe24..a7252b52555c 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -1009,7 +1009,7 @@ void ath11k_dp_vdev_tx_attach(struct ath11k *ar, struct ath11k_vif *arvif)
 
 static int ath11k_dp_tx_pending_cleanup(int buf_id, void *skb, void *ctx)
 {
-	struct ath11k_base *ab = (struct ath11k_base *)ctx;
+	struct ath11k_base *ab = ctx;
 	struct sk_buff *msdu = skb;
 
 	dma_unmap_single(ab->dev, ATH11K_SKB_CB(msdu)->paddr, msdu->len,
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 62bc98852f0f..77a1112b4d88 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1256,7 +1256,7 @@ static int ath11k_htt_tlv_ppdu_stats_parse(struct ath11k_base *ab,
 	int cur_user;
 	u16 peer_id;
 
-	ppdu_info = (struct htt_ppdu_stats_info *)data;
+	ppdu_info = data;
 
 	switch (tag) {
 	case HTT_PPDU_STATS_TAG_COMMON:
@@ -4489,8 +4489,7 @@ int ath11k_dp_rx_monitor_link_desc_return(struct ath11k *ar,
 	src_srng_desc = ath11k_hal_srng_src_get_next_entry(ar->ab, hal_srng);
 
 	if (src_srng_desc) {
-		struct ath11k_buffer_addr *src_desc =
-				(struct ath11k_buffer_addr *)src_srng_desc;
+		struct ath11k_buffer_addr *src_desc = src_srng_desc;
 
 		*src_desc = *((struct ath11k_buffer_addr *)p_last_buf_addr_info);
 	} else {
@@ -4509,8 +4508,7 @@ void ath11k_dp_rx_mon_next_link_desc_get(void *rx_msdu_link_desc,
 					 u8 *rbm,
 					 void **pp_buf_addr_info)
 {
-	struct hal_rx_msdu_link *msdu_link =
-			(struct hal_rx_msdu_link *)rx_msdu_link_desc;
+	struct hal_rx_msdu_link *msdu_link = rx_msdu_link_desc;
 	struct ath11k_buffer_addr *buf_addr_info;
 
 	buf_addr_info = (struct ath11k_buffer_addr *)&msdu_link->buf_addr_info;
@@ -4551,7 +4549,7 @@ static void ath11k_hal_rx_msdu_list_get(struct ath11k *ar,
 	u32 first = FIELD_PREP(RX_MSDU_DESC_INFO0_FIRST_MSDU_IN_MPDU, 1);
 	u8  tmp  = 0;
 
-	msdu_link = (struct hal_rx_msdu_link *)msdu_link_desc;
+	msdu_link = msdu_link_desc;
 	msdu_details = &msdu_link->msdu_link[0];
 
 	for (i = 0; i < HAL_RX_NUM_MSDU_DESC; i++) {
@@ -4648,8 +4646,7 @@ ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar, int mac_id,
 	bool is_frag, is_first_msdu;
 	bool drop_mpdu = false;
 	struct ath11k_skb_rxcb *rxcb;
-	struct hal_reo_entrance_ring *ent_desc =
-			(struct hal_reo_entrance_ring *)ring_entry;
+	struct hal_reo_entrance_ring *ent_desc = ring_entry;
 	int buf_id;
 	u32 rx_link_buf_info[2];
 	u8 rbm;
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 0a99aa7ddbf4..23f3af8e372d 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -571,7 +571,7 @@ u32 ath11k_hal_ce_get_desc_size(enum hal_ce_desc type)
 void ath11k_hal_ce_src_set_desc(void *buf, dma_addr_t paddr, u32 len, u32 id,
 				u8 byte_swap_data)
 {
-	struct hal_ce_srng_src_desc *desc = (struct hal_ce_srng_src_desc *)buf;
+	struct hal_ce_srng_src_desc *desc = buf;
 
 	desc->buffer_addr_low = paddr & HAL_ADDR_LSB_REG_MASK;
 	desc->buffer_addr_info =
@@ -586,8 +586,7 @@ void ath11k_hal_ce_src_set_desc(void *buf, dma_addr_t paddr, u32 len, u32 id,
 
 void ath11k_hal_ce_dst_set_desc(void *buf, dma_addr_t paddr)
 {
-	struct hal_ce_srng_dest_desc *desc =
-		(struct hal_ce_srng_dest_desc *)buf;
+	struct hal_ce_srng_dest_desc *desc = buf;
 
 	desc->buffer_addr_low = paddr & HAL_ADDR_LSB_REG_MASK;
 	desc->buffer_addr_info =
@@ -597,8 +596,7 @@ void ath11k_hal_ce_dst_set_desc(void *buf, dma_addr_t paddr)
 
 u32 ath11k_hal_ce_dst_status_get_length(void *buf)
 {
-	struct hal_ce_srng_dst_status_desc *desc =
-		(struct hal_ce_srng_dst_status_desc *)buf;
+	struct hal_ce_srng_dst_status_desc *desc = buf;
 	u32 len;
 
 	len = FIELD_GET(HAL_CE_DST_STATUS_DESC_FLAGS_LEN, desc->flags);
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index e5ed5efb139e..5a6df83c2094 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -265,7 +265,7 @@ int ath11k_hal_reo_cmd_send(struct ath11k_base *ab, struct hal_srng *srng,
 void ath11k_hal_rx_buf_addr_info_set(void *desc, dma_addr_t paddr,
 				     u32 cookie, u8 manager)
 {
-	struct ath11k_buffer_addr *binfo = (struct ath11k_buffer_addr *)desc;
+	struct ath11k_buffer_addr *binfo = desc;
 	u32 paddr_lo, paddr_hi;
 
 	paddr_lo = lower_32_bits(paddr);
@@ -279,7 +279,7 @@ void ath11k_hal_rx_buf_addr_info_set(void *desc, dma_addr_t paddr,
 void ath11k_hal_rx_buf_addr_info_get(void *desc, dma_addr_t *paddr,
 				     u32 *cookie, u8 *rbm)
 {
-	struct ath11k_buffer_addr *binfo = (struct ath11k_buffer_addr *)desc;
+	struct ath11k_buffer_addr *binfo = desc;
 
 	*paddr =
 		(((u64)FIELD_GET(BUFFER_ADDR_INFO1_ADDR, binfo->info1)) << 32) |
@@ -292,7 +292,7 @@ void ath11k_hal_rx_msdu_link_info_get(void *link_desc, u32 *num_msdus,
 				      u32 *msdu_cookies,
 				      enum hal_rx_buf_return_buf_manager *rbm)
 {
-	struct hal_rx_msdu_link *link = (struct hal_rx_msdu_link *)link_desc;
+	struct hal_rx_msdu_link *link = link_desc;
 	struct hal_rx_msdu_details *msdu;
 	int i;
 
@@ -699,7 +699,7 @@ u32 ath11k_hal_reo_qdesc_size(u32 ba_window_size, u8 tid)
 void ath11k_hal_reo_qdesc_setup(void *vaddr, int tid, u32 ba_window_size,
 				u32 start_seq, enum hal_pn_type type)
 {
-	struct hal_rx_reo_queue *qdesc = (struct hal_rx_reo_queue *)vaddr;
+	struct hal_rx_reo_queue *qdesc = vaddr;
 	struct hal_rx_reo_queue_ext *ext_desc;
 
 	memset(qdesc, 0, sizeof(*qdesc));
@@ -809,8 +809,7 @@ static inline void
 ath11k_hal_rx_handle_ofdma_info(void *rx_tlv,
 				struct hal_rx_user_status *rx_user_status)
 {
-	struct hal_rx_ppdu_end_user_stats *ppdu_end_user =
-		(struct hal_rx_ppdu_end_user_stats *)rx_tlv;
+	struct hal_rx_ppdu_end_user_stats *ppdu_end_user = rx_tlv;
 
 	rx_user_status->ul_ofdma_user_v0_word0 = __le32_to_cpu(ppdu_end_user->info6);
 
@@ -821,8 +820,7 @@ static inline void
 ath11k_hal_rx_populate_byte_count(void *rx_tlv, void *ppduinfo,
 				  struct hal_rx_user_status *rx_user_status)
 {
-	struct hal_rx_ppdu_end_user_stats *ppdu_end_user =
-		(struct hal_rx_ppdu_end_user_stats *)rx_tlv;
+	struct hal_rx_ppdu_end_user_stats *ppdu_end_user = rx_tlv;
 
 	rx_user_status->mpdu_ok_byte_count =
 		FIELD_GET(HAL_RX_PPDU_END_USER_STATS_RSVD2_6_MPDU_OK_BYTE_COUNT,
@@ -1540,8 +1538,7 @@ void ath11k_hal_rx_reo_ent_buf_paddr_get(void *rx_desc, dma_addr_t *paddr,
 					 u32 *sw_cookie, void **pp_buf_addr,
 					 u8 *rbm, u32 *msdu_cnt)
 {
-	struct hal_reo_entrance_ring *reo_ent_ring =
-		(struct hal_reo_entrance_ring *)rx_desc;
+	struct hal_reo_entrance_ring *reo_ent_ring = rx_desc;
 	struct ath11k_buffer_addr *buf_addr_info;
 	struct rx_mpdu_desc *rx_mpdu_desc_info_details;
 
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.c b/drivers/net/wireless/ath/ath11k/hal_tx.c
index d1b0e36e04a9..b919df6ce743 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.c
@@ -37,7 +37,7 @@ static const u8 dscp_tid_map[DSCP_TID_MAP_TBL_ENTRY_SIZE] = {
 void ath11k_hal_tx_cmd_desc_setup(struct ath11k_base *ab, void *cmd,
 				  struct hal_tx_info *ti)
 {
-	struct hal_tcl_data_cmd *tcl_cmd = (struct hal_tcl_data_cmd *)cmd;
+	struct hal_tcl_data_cmd *tcl_cmd = cmd;
 
 	tcl_cmd->buf_addr_info.info0 =
 		FIELD_PREP(BUFFER_ADDR_INFO0_ADDR, ti->paddr);
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c071bf5841af..39f673aa4b00 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6967,8 +6967,8 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 
 static int ath11k_mac_vif_unref(int buf_id, void *skb, void *ctx)
 {
-	struct ieee80211_vif *vif = (struct ieee80211_vif *)ctx;
-	struct ath11k_skb_cb *skb_cb = ATH11K_SKB_CB((struct sk_buff *)skb);
+	struct ieee80211_vif *vif = ctx;
+	struct ath11k_skb_cb *skb_cb = ATH11K_SKB_CB(skb);
 
 	if (skb_cb->vif == vif)
 		skb_cb->vif = NULL;
diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
index 705868198df4..3289492cd259 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.c
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -598,7 +598,7 @@ int ath11k_spectral_process_fft(struct ath11k *ar,
 		return -EINVAL;
 	}
 
-	tlv = (struct spectral_tlv *)data;
+	tlv = data;
 	tlv_len = FIELD_GET(SPECTRAL_TLV_HDR_LEN, __le32_to_cpu(tlv->header));
 	/* convert Dword into bytes */
 	tlv_len *= ATH11K_SPECTRAL_DWORD_SIZE;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 23ad6825e5be..01c27c40ba5e 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2281,7 +2281,7 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_UINT32) |
 		      FIELD_PREP(WMI_TLV_LEN, len);
 	ptr += TLV_HDR_SIZE;
-	tmp_ptr = (u32 *)ptr;
+	tmp_ptr = ptr;
 
 	for (i = 0; i < params->num_chan; ++i)
 		tmp_ptr[i] = params->chan_list[i];
@@ -4148,7 +4148,7 @@ static int ath11k_init_cmd_send(struct ath11k_pdev_wmi *wmi,
 	ptr += TLV_HDR_SIZE + len;
 
 	if (param->hw_mode_id != WMI_HOST_HW_MODE_MAX) {
-		hw_mode = (struct wmi_pdev_set_hw_mode_cmd_param *)ptr;
+		hw_mode = ptr;
 		hw_mode->tlv_header = FIELD_PREP(WMI_TLV_TAG,
 						 WMI_TAG_PDEV_SET_HW_MODE_CMD) |
 				      FIELD_PREP(WMI_TLV_LEN,
@@ -4168,7 +4168,7 @@ static int ath11k_init_cmd_send(struct ath11k_pdev_wmi *wmi,
 		len = sizeof(*band_to_mac);
 
 		for (idx = 0; idx < param->num_band_to_mac; idx++) {
-			band_to_mac = (void *)ptr;
+			band_to_mac = ptr;
 
 			band_to_mac->tlv_header = FIELD_PREP(WMI_TLV_TAG,
 							     WMI_TAG_PDEV_BAND_TO_MAC) |
-- 
2.30.2

