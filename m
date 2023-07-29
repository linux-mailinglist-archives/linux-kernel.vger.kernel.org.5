Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55AE767F1B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 14:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjG2M04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 08:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjG2M0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 08:26:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29975CE;
        Sat, 29 Jul 2023 05:26:53 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RCkHj11h0zrRxY;
        Sat, 29 Jul 2023 20:25:53 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 29 Jul
 2023 20:26:50 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <edumazet@google.com>, <davem@davemloft.net>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] tcp: Remove unused function declarations
Date:   Sat, 29 Jul 2023 20:26:44 +0800
Message-ID: <20230729122644.10648-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 8a59f9d1e3d4 ("sock: Introduce sk->sk_prot->psock_update_sk_prot()")
left behind tcp_bpf_get_proto() declaration. And tcp_v4_tw_remember_stamp()
function is remove in ccb7c410ddc0 ("timewait_sock: Create and use getpeer op.").
Since commit 686989700cab ("tcp: simplify tcp_mark_skb_lost")
tcp_skb_mark_lost_uncond_verify() declaration is not used anymore.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/tcp.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index cb0d9f4f4fa0..e0ea9b6083bd 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -322,7 +322,6 @@ int tcp_v4_early_demux(struct sk_buff *skb);
 int tcp_v4_rcv(struct sk_buff *skb);
 
 void tcp_remove_empty_skb(struct sock *sk);
-int tcp_v4_tw_remember_stamp(struct inet_timewait_sock *tw);
 int tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size);
 int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
@@ -621,7 +620,6 @@ void tcp_skb_collapse_tstamp(struct sk_buff *skb,
 void tcp_rearm_rto(struct sock *sk);
 void tcp_synack_rtt_meas(struct sock *sk, struct request_sock *req);
 void tcp_reset(struct sock *sk, struct sk_buff *skb);
-void tcp_skb_mark_lost_uncond_verify(struct tcp_sock *tp, struct sk_buff *skb);
 void tcp_fin(struct sock *sk);
 void tcp_check_space(struct sock *sk);
 void tcp_sack_compress_send_ack(struct sock *sk);
@@ -2359,7 +2357,6 @@ struct sk_msg;
 struct sk_psock;
 
 #ifdef CONFIG_BPF_SYSCALL
-struct proto *tcp_bpf_get_proto(struct sock *sk, struct sk_psock *psock);
 int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
 void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
 #endif /* CONFIG_BPF_SYSCALL */
-- 
2.34.1

