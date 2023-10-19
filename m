Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D022A7CF700
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345409AbjJSLh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345381AbjJSLhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:37:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52047131;
        Thu, 19 Oct 2023 04:37:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28DEC433C8;
        Thu, 19 Oct 2023 11:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697715441;
        bh=Fl3AWQhRpM38FD8RxKjmnV0l3qxACyYQ/7kTZ5GaoTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QHLwYH8IyxMBa7gIp3HRiTFnlCMEWvzafAS97eM+kJu2uAfpF5pO+X4jo/yFxSzjj
         6TUvRsAAtVX9ClOg2wiXBI2Iv0fQE85XmtzjGqlR3Eon3SNbZJGkmlxQ0ss4eEtFgq
         mdp4Iew5tgDMMzZSHijCxWhATPJ+3qvTnD/lsfy89a2g2eBckQg9xfJYKODEhVQc+5
         SOH30zBw/W5Qe7f0MpHPP8JfCtbGQnmMesZJMSm4sMKE4J30syVf1/HPic4Hh0hZ0s
         PqTJG3l4Mdd8cbhUvsXlaymPHJZSbeq1nSnKsl3SIupX2Uj+fi/HnNmQ6B/cCwECgX
         sNeAkiBiRiy1w==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qtRLB-0002Mg-07;
        Thu, 19 Oct 2023 13:37:25 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 1/2] wifi: ath12k: fix dfs-radar and temperature event locking
Date:   Thu, 19 Oct 2023 13:36:49 +0200
Message-ID: <20231019113650.9060-2-johan+linaro@kernel.org>
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

The ath12k active pdevs are protected by RCU but the DFS-radar and
temperature event handling code calling ath12k_mac_get_ar_by_pdev_id()
was not marked as a read-side critical section.

Mark the code in question as RCU read-side critical sections to avoid
any potential use-after-free issues.

Note that the temperature event handler looks like a place holder
currently but would still trigger an RCU lockdep splat.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Cc: stable@vger.kernel.org	# v6.2
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ef0f3cf35cfd..1a1f57c7ac7e 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6476,6 +6476,7 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
 		   ev->detector_id, ev->segment_id, ev->timestamp, ev->is_chirp,
 		   ev->freq_offset, ev->sidx);
 
+	rcu_read_lock();
 	ar = ath12k_mac_get_ar_by_pdev_id(ab, le32_to_cpu(ev->pdev_id));
 
 	if (!ar) {
@@ -6493,6 +6494,8 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
 		ieee80211_radar_detected(ar->hw);
 
 exit:
+	rcu_read_unlock();
+
 	kfree(tb);
 }
 
@@ -6511,11 +6514,14 @@ ath12k_wmi_pdev_temperature_event(struct ath12k_base *ab,
 	ath12k_dbg(ab, ATH12K_DBG_WMI,
 		   "pdev temperature ev temp %d pdev_id %d\n", ev.temp, ev.pdev_id);
 
+	rcu_read_lock();
 	ar = ath12k_mac_get_ar_by_pdev_id(ab, le32_to_cpu(ev.pdev_id));
 	if (!ar) {
 		ath12k_warn(ab, "invalid pdev id in pdev temperature ev %d", ev.pdev_id);
-		return;
+		goto exit;
 	}
+exit:
+	rcu_read_unlock();
 }
 
 static void ath12k_fils_discovery_event(struct ath12k_base *ab,
-- 
2.41.0

