Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F2E7E3BEF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbjKGMLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbjKGMKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:10:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F38D172B;
        Tue,  7 Nov 2023 04:09:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD209C433C9;
        Tue,  7 Nov 2023 12:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699358966;
        bh=ARiyr5i0rFzS8xaQzuJMYUcVgVowdkPZZVISaegU4nQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UdegUBg9zzUDVVK+7APDAABsciXG/31Qxf+eCjmaOIqH4Bgc0EGKQ1/Yl8enqPvPS
         cbiAM8JIF6yL+Ma4t7u466Q8dr+olQwYRyN2DlHOyS3ZbtKrV1Fj0+trxLRMfMdORp
         D3ykG8PixSIgo3eROVJNS3o6bHr0vpuAkuz1XhwT0U6yQLTs7pFj8FQJpVMnK30Plz
         f5BsR4S0cPzj7nD78tnMyBQ74ZmUCnvVkdI2dbId79fYUQsnUAKSnJQmKyAHwWzCfK
         m2ACR3b8tNAAG9I/Ys74Ee0/I/A92puUW8GhbXpXAvA54ZvVnB5Nf/0A1Qe+M+3Lm5
         GmWuTrs/WyK1g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Harshitha Prem <quic_hprem@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        quic_jjohnson@quicinc.com, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 02/30] wifi: ath12k: Ignore fragments from uninitialized peer in  dp
Date:   Tue,  7 Nov 2023 07:08:17 -0500
Message-ID: <20231107120922.3757126-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120922.3757126-1-sashal@kernel.org>
References: <20231107120922.3757126-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harshitha Prem <quic_hprem@quicinc.com>

[ Upstream commit bbc86757ca62423c3b6bd8f7176da1ff43450769 ]

When max virtual ap interfaces are configured in all the bands with
ACS and hostapd restart is done every 60s, a crash is observed at
random times.

In the above scenario, a fragmented packet is received for self peer,
for which rx_tid and rx_frags are not initialized in datapath.
While handling this fragment, crash is observed as the rx_frag list
is uninitialized and when we walk in ath12k_dp_rx_h_sort_frags,
skb null leads to exception.

To address this, before processing received fragments we check
dp_setup_done flag is set to ensure that peer has completed its
dp peer setup for fragment queue, else ignore processing the
fragments.

Call trace:
    PC points to "ath12k_dp_process_rx_err+0x4e8/0xfcc [ath12k]"
    LR points to "ath12k_dp_process_rx_err+0x480/0xfcc [ath12k]".
    The Backtrace obtained is as follows:
    ath12k_dp_process_rx_err+0x4e8/0xfcc [ath12k]
    ath12k_dp_service_srng+0x78/0x260 [ath12k]
    ath12k_pci_write32+0x990/0xb0c [ath12k]
    __napi_poll+0x30/0xa4
    net_rx_action+0x118/0x270
    __do_softirq+0x10c/0x244
    irq_exit+0x64/0xb4
    __handle_domain_irq+0x88/0xac
    gic_handle_irq+0x74/0xbc
    el1_irq+0xf0/0x1c0
    arch_cpu_idle+0x10/0x18
    do_idle+0x104/0x248
    cpu_startup_entry+0x20/0x64
    rest_init+0xd0/0xdc
    arch_call_rest_init+0xc/0x14

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230821130343.29495-2-quic_hprem@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp.c    | 1 +
 drivers/net/wireless/ath/ath12k/dp_rx.c | 9 +++++++++
 drivers/net/wireless/ath/ath12k/peer.h  | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index f933896f2a68d..6893466f61f04 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -38,6 +38,7 @@ void ath12k_dp_peer_cleanup(struct ath12k *ar, int vdev_id, const u8 *addr)
 
 	ath12k_dp_rx_peer_tid_cleanup(ar, peer);
 	crypto_free_shash(peer->tfm_mmic);
+	peer->dp_setup_done = false;
 	spin_unlock_bh(&ab->base_lock);
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index ffd9a2018610f..5ad59f2d6bf2e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2747,6 +2747,7 @@ int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev
 	}
 
 	peer->tfm_mmic = tfm;
+	peer->dp_setup_done = true;
 	spin_unlock_bh(&ab->base_lock);
 
 	return 0;
@@ -3213,6 +3214,14 @@ static int ath12k_dp_rx_frag_h_mpdu(struct ath12k *ar,
 		ret = -ENOENT;
 		goto out_unlock;
 	}
+
+	if (!peer->dp_setup_done) {
+		ath12k_warn(ab, "The peer %pM [%d] has uninitialized datapath\n",
+			    peer->addr, peer_id);
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
 	rx_tid = &peer->rx_tid[tid];
 
 	if ((!skb_queue_empty(&rx_tid->rx_frags) && seqno != rx_tid->cur_sn) ||
diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
index b296dc0e2f671..c6edb24cbedd8 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -44,6 +44,9 @@ struct ath12k_peer {
 	struct ppdu_user_delayba ppdu_stats_delayba;
 	bool delayba_flag;
 	bool is_authorized;
+
+	/* protected by ab->data_lock */
+	bool dp_setup_done;
 };
 
 void ath12k_peer_unmap_event(struct ath12k_base *ab, u16 peer_id);
-- 
2.42.0

