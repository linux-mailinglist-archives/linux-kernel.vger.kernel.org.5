Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D947A58A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 06:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjISEvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 00:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjISEvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:51:43 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id E6EBE116;
        Mon, 18 Sep 2023 21:51:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 3E1BD602F96CC;
        Tue, 19 Sep 2023 12:51:32 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     kvalo@kernel.org, quic_jjohnson@quicinc.com
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH v2 wireless-next 6/9] wifi: ath10k: Remove unnecessary (void*) conversions
Date:   Tue, 19 Sep 2023 12:50:56 +0800
Message-Id: <20230919045056.523958-1-yunchuan@nfschina.com>
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

No need cast (void*) to (struct htt_rx_ring_setup_ring32 *),
(struct htt_rx_ring_setup_ring64 *). Change the prototype to
remove the local variable.

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/htt_tx.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index bd603feb7953..be4d4536aaa8 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -796,20 +796,16 @@ static int ath10k_htt_send_frag_desc_bank_cfg_64(struct ath10k_htt *htt)
 	return 0;
 }
 
-static void ath10k_htt_fill_rx_desc_offset_32(struct ath10k_hw_params *hw, void *rx_ring)
+static void ath10k_htt_fill_rx_desc_offset_32(struct ath10k_hw_params *hw,
+					      struct htt_rx_ring_setup_ring32 *rx_ring)
 {
-	struct htt_rx_ring_setup_ring32 *ring =
-			(struct htt_rx_ring_setup_ring32 *)rx_ring;
-
-	ath10k_htt_rx_desc_get_offsets(hw, &ring->offsets);
+	ath10k_htt_rx_desc_get_offsets(hw, &rx_ring->offsets);
 }
 
-static void ath10k_htt_fill_rx_desc_offset_64(struct ath10k_hw_params *hw, void *rx_ring)
+static void ath10k_htt_fill_rx_desc_offset_64(struct ath10k_hw_params *hw,
+					      struct htt_rx_ring_setup_ring64 *rx_ring)
 {
-	struct htt_rx_ring_setup_ring64 *ring =
-			(struct htt_rx_ring_setup_ring64 *)rx_ring;
-
-	ath10k_htt_rx_desc_get_offsets(hw, &ring->offsets);
+	ath10k_htt_rx_desc_get_offsets(hw, &rx_ring->offsets);
 }
 
 static int ath10k_htt_send_rx_ring_cfg_32(struct ath10k_htt *htt)
-- 
2.30.2

