Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92DF7E3B7E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjKGMHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbjKGMHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:07:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC6CB0;
        Tue,  7 Nov 2023 04:07:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998DEC433C9;
        Tue,  7 Nov 2023 12:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699358828;
        bh=QGhKnTRMS32ayT2MMhoB62SzaKWb3xt4pGpY0Aw7sHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=llYVfC06fXfdStkUFc/RSDiBTvQruRIlj7Z4a2+N+AXCxo9yKs57TgRQLDSpmvLyy
         2Isso6qkA9vlQSiEPKeZ9AdUGS7hrZZrzP3brZd8eqmqWvpTNLx2IpYHGPSqOoy4A5
         20R5p6oem1bq0dHf+4pJzGyZYc7XGaC3kuzH5j3kQ81l3Y/Y78ORsZKlgjNei+LbYB
         ny4Ps2ADH5S7HC02Y47BIN9y9FI8Z4rIkSB91auQ9nMi8nE0Ej3aUIEEqjHJmm2hvz
         xTHlOg4cvCS9zdm2srPjSUH3q0sB8IaD9dDssL4fB8uNsZTbkZ6RfUvUhy5ud+WAOH
         KEYxQCk7aU28w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Harshitha Prem <quic_hprem@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        quic_jjohnson@quicinc.com, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/31] wifi: ath12k: Ignore fragments from uninitialized peer in  dp
Date:   Tue,  7 Nov 2023 07:05:49 -0500
Message-ID: <20231107120704.3756327-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120704.3756327-1-sashal@kernel.org>
References: <20231107120704.3756327-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
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
index e6e64d437c47a..100390fdc735f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2748,6 +2748,7 @@ int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev
 	}
 
 	peer->tfm_mmic = tfm;
+	peer->dp_setup_done = true;
 	spin_unlock_bh(&ab->base_lock);
 
 	return 0;
@@ -3214,6 +3215,14 @@ static int ath12k_dp_rx_frag_h_mpdu(struct ath12k *ar,
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

