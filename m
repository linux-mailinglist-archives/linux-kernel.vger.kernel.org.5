Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D067CF702
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345403AbjJSLh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345348AbjJSLhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:37:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F81BBE;
        Thu, 19 Oct 2023 04:37:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AC8C433CC;
        Thu, 19 Oct 2023 11:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697715441;
        bh=AlrEZPik1jxL6sdyw6sk2fh7vSfCW6AGj33Rbxfwiss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oxUv1OUW44Gy2DI6jjcgUUKlurn88h9liKBHyTR8b2U+XPsosnOfQ+S3t8uh9jOlZ
         +cFpbWANwm8rsYP5on73ULXaczg4UxnvN1vLyIaJpUKen2unUKqGEt45X1dBD2MBWk
         znEzlvO0qjoPpDuQj/l+i8JM6medNMFkAjWadX6EopLqSOv0jSqnqTmcyOWoZ8gS0X
         r1s5u/ZkvhlWc0qXoHPNr11M24QGsLsyxpnEj/tl/FTd6hVFb72CHLrYFfdt0lua4R
         4VwiXJ+yTNAxO30U52+xcqRAseMeIMeZgn6CiZ8nOSKssNstHLskSIZNEcBpAK3IQC
         gdXEE5ZZHUjeQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qtRLB-0002Mi-0N;
        Thu, 19 Oct 2023 13:37:25 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 2/2] wifi: ath12k: fix htt mlo-offset event locking
Date:   Thu, 19 Oct 2023 13:36:50 +0200
Message-ID: <20231019113650.9060-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019113650.9060-1-johan+linaro@kernel.org>
References: <20231019113650.9060-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ath12k active pdevs are protected by RCU but the htt mlo-offset
event handling code calling ath12k_mac_get_ar_by_pdev_id() was not
marked as a read-side critical section.

Mark the code in question as an RCU read-side critical section to avoid
any potential use-after-free issues.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Cc: stable@vger.kernel.org      # v6.2
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index e6e64d437c47..3294625650dc 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1641,11 +1641,12 @@ static void ath12k_htt_mlo_offset_event_handler(struct ath12k_base *ab,
 	msg = (struct ath12k_htt_mlo_offset_msg *)skb->data;
 	pdev_id = u32_get_bits(__le32_to_cpu(msg->info),
 			       HTT_T2H_MLO_OFFSET_INFO_PDEV_ID);
-	ar = ath12k_mac_get_ar_by_pdev_id(ab, pdev_id);
 
+	rcu_read_lock();
+	ar = ath12k_mac_get_ar_by_pdev_id(ab, pdev_id);
 	if (!ar) {
 		ath12k_warn(ab, "invalid pdev id %d on htt mlo offset\n", pdev_id);
-		return;
+		goto exit;
 	}
 
 	spin_lock_bh(&ar->data_lock);
@@ -1661,6 +1662,8 @@ static void ath12k_htt_mlo_offset_event_handler(struct ath12k_base *ab,
 	pdev->timestamp.mlo_comp_timer = __le32_to_cpu(msg->mlo_comp_timer);
 
 	spin_unlock_bh(&ar->data_lock);
+exit:
+	rcu_read_unlock();
 }
 
 void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
-- 
2.41.0

