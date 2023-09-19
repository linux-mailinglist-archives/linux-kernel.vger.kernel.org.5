Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3371E7A58F6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 06:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjISEwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 00:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjISEwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:52:14 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CF79C187;
        Mon, 18 Sep 2023 21:51:46 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 55F0E602F96CC;
        Tue, 19 Sep 2023 12:51:43 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     kvalo@kernel.org, quic_jjohnson@quicinc.com
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH v2 wireless-next 7/9] wifi: ath12k: Remove unnecessary (void*) conversions
Date:   Tue, 19 Sep 2023 12:51:42 +0800
Message-Id: <20230919045142.524226-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void*) to (struct hal_rx_ppdu_end_user_stats *),
(struct ath12k_rx_desc_info *) or (struct hal_tx_msdu_ext_desc *).
Change the prototype to remove the local variable.

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 9 +++------
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 2 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c  | 5 ++---
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index f1e57e98bdc6..86aa397c074f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -13,8 +13,7 @@
 static void ath12k_dp_mon_rx_handle_ofdma_info(void *rx_tlv,
 					       struct hal_rx_user_status *rx_user_status)
 {
-	struct hal_rx_ppdu_end_user_stats *ppdu_end_user =
-				(struct hal_rx_ppdu_end_user_stats *)rx_tlv;
+	struct hal_rx_ppdu_end_user_stats *ppdu_end_user = rx_tlv;
 
 	rx_user_status->ul_ofdma_user_v0_word0 =
 		__le32_to_cpu(ppdu_end_user->usr_resp_ref);
@@ -23,11 +22,9 @@ static void ath12k_dp_mon_rx_handle_ofdma_info(void *rx_tlv,
 }
 
 static void
-ath12k_dp_mon_rx_populate_byte_count(void *rx_tlv, void *ppduinfo,
-				     struct hal_rx_user_status *rx_user_status)
+ath12k_dp_mon_rx_populate_byte_count(const struct hal_rx_ppdu_end_user_stats *ppdu_end_user,
+				     void *ppduinfo, struct hal_rx_user_status *rx_user_status)
 {
-	struct hal_rx_ppdu_end_user_stats *ppdu_end_user =
-		(struct hal_rx_ppdu_end_user_stats *)rx_tlv;
 	u32 mpdu_ok_byte_count = __le32_to_cpu(ppdu_end_user->mpdu_ok_cnt);
 	u32 mpdu_err_byte_count = __le32_to_cpu(ppdu_end_user->mpdu_err_cnt);
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index e6e64d437c47..ff5f66ca7783 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -3730,7 +3730,7 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 			continue;
 		}
 
-		desc_info = (struct ath12k_rx_desc_info *)err_info.rx_desc;
+		desc_info = err_info.rx_desc;
 
 		/* retry manual desc retrieval if hw cc is not done */
 		if (!desc_info) {
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 8874c815d7fa..41a93320b036 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -106,11 +106,10 @@ static struct ath12k_tx_desc_info *ath12k_dp_tx_assign_buffer(struct ath12k_dp *
 	return desc;
 }
 
-static void ath12k_hal_tx_cmd_ext_desc_setup(struct ath12k_base *ab, void *cmd,
+static void ath12k_hal_tx_cmd_ext_desc_setup(struct ath12k_base *ab,
+					     struct hal_tx_msdu_ext_desc *tcl_ext_cmd,
 					     struct hal_tx_info *ti)
 {
-	struct hal_tx_msdu_ext_desc *tcl_ext_cmd = (struct hal_tx_msdu_ext_desc *)cmd;
-
 	tcl_ext_cmd->info0 = le32_encode_bits(ti->paddr,
 					      HAL_TX_MSDU_EXT_INFO0_BUF_PTR_LO);
 	tcl_ext_cmd->info1 = le32_encode_bits(0x0,
-- 
2.30.2

