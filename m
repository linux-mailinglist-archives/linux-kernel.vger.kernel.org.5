Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4097B09C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjI0QP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjI0QPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:15:16 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41324196
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:15:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qlXBj-0003ta-P5; Wed, 27 Sep 2023 18:14:59 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qlXBh-009Ngb-Oy; Wed, 27 Sep 2023 18:14:57 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qlXBh-000LXL-2H;
        Wed, 27 Sep 2023 18:14:57 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Robin van der Gracht <robin@protonic.nl>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Sili Luo <rootlab@huawei.com>, stable@vger.kernel.org,
        kernel@pengutronix.de, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] can: j1939: Fix UAF in j1939_sk_match_filter during setsockopt(SO_J1939_FILTER)
Date:   Wed, 27 Sep 2023 18:14:56 +0200
Message-Id: <20230927161456.82772-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lock jsk->sk to prevent UAF when setsockopt(..., SO_J1939_FILTER, ...)
modifies jsk->filters while receiving packets.

Following trace was seen on affected system:
 ==================================================================
 BUG: KASAN: slab-use-after-free in j1939_sk_recv_match_one+0x1af/0x2d0 [can_j1939]
 Read of size 4 at addr ffff888012144014 by task j1939/350

 CPU: 0 PID: 350 Comm: j1939 Tainted: G        W  OE      6.5.0-rc5 #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
 Call Trace:
  print_report+0xd3/0x620
  ? kasan_complete_mode_report_info+0x7d/0x200
  ? j1939_sk_recv_match_one+0x1af/0x2d0 [can_j1939]
  kasan_report+0xc2/0x100
  ? j1939_sk_recv_match_one+0x1af/0x2d0 [can_j1939]
  __asan_load4+0x84/0xb0
  j1939_sk_recv_match_one+0x1af/0x2d0 [can_j1939]
  j1939_sk_recv+0x20b/0x320 [can_j1939]
  ? __kasan_check_write+0x18/0x20
  ? __pfx_j1939_sk_recv+0x10/0x10 [can_j1939]
  ? j1939_simple_recv+0x69/0x280 [can_j1939]
  ? j1939_ac_recv+0x5e/0x310 [can_j1939]
  j1939_can_recv+0x43f/0x580 [can_j1939]
  ? __pfx_j1939_can_recv+0x10/0x10 [can_j1939]
  ? raw_rcv+0x42/0x3c0 [can_raw]
  ? __pfx_j1939_can_recv+0x10/0x10 [can_j1939]
  can_rcv_filter+0x11f/0x350 [can]
  can_receive+0x12f/0x190 [can]
  ? __pfx_can_rcv+0x10/0x10 [can]
  can_rcv+0xdd/0x130 [can]
  ? __pfx_can_rcv+0x10/0x10 [can]
  __netif_receive_skb_one_core+0x13d/0x150
  ? __pfx___netif_receive_skb_one_core+0x10/0x10
  ? __kasan_check_write+0x18/0x20
  ? _raw_spin_lock_irq+0x8c/0xe0
  __netif_receive_skb+0x23/0xb0
  process_backlog+0x107/0x260
  __napi_poll+0x69/0x310
  net_rx_action+0x2a1/0x580
  ? __pfx_net_rx_action+0x10/0x10
  ? __pfx__raw_spin_lock+0x10/0x10
  ? handle_irq_event+0x7d/0xa0
  __do_softirq+0xf3/0x3f8
  do_softirq+0x53/0x80
  </IRQ>
  <TASK>
  __local_bh_enable_ip+0x6e/0x70
  netif_rx+0x16b/0x180
  can_send+0x32b/0x520 [can]
  ? __pfx_can_send+0x10/0x10 [can]
  ? __check_object_size+0x299/0x410
  raw_sendmsg+0x572/0x6d0 [can_raw]
  ? __pfx_raw_sendmsg+0x10/0x10 [can_raw]
  ? apparmor_socket_sendmsg+0x2f/0x40
  ? __pfx_raw_sendmsg+0x10/0x10 [can_raw]
  sock_sendmsg+0xef/0x100
  sock_write_iter+0x162/0x220
  ? __pfx_sock_write_iter+0x10/0x10
  ? __rtnl_unlock+0x47/0x80
  ? security_file_permission+0x54/0x320
  vfs_write+0x6ba/0x750
  ? __pfx_vfs_write+0x10/0x10
  ? __fget_light+0x1ca/0x1f0
  ? __rcu_read_unlock+0x5b/0x280
  ksys_write+0x143/0x170
  ? __pfx_ksys_write+0x10/0x10
  ? __kasan_check_read+0x15/0x20
  ? fpregs_assert_state_consistent+0x62/0x70
  __x64_sys_write+0x47/0x60
  do_syscall_64+0x60/0x90
  ? do_syscall_64+0x6d/0x90
  ? irqentry_exit+0x3f/0x50
  ? exc_page_fault+0x79/0xf0
  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

 Allocated by task 348:
  kasan_save_stack+0x2a/0x50
  kasan_set_track+0x29/0x40
  kasan_save_alloc_info+0x1f/0x30
  __kasan_kmalloc+0xb5/0xc0
  __kmalloc_node_track_caller+0x67/0x160
  j1939_sk_setsockopt+0x284/0x450 [can_j1939]
  __sys_setsockopt+0x15c/0x2f0
  __x64_sys_setsockopt+0x6b/0x80
  do_syscall_64+0x60/0x90
  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

 Freed by task 349:
  kasan_save_stack+0x2a/0x50
  kasan_set_track+0x29/0x40
  kasan_save_free_info+0x2f/0x50
  __kasan_slab_free+0x12e/0x1c0
  __kmem_cache_free+0x1b9/0x380
  kfree+0x7a/0x120
  j1939_sk_setsockopt+0x3b2/0x450 [can_j1939]
  __sys_setsockopt+0x15c/0x2f0
  __x64_sys_setsockopt+0x6b/0x80
  do_syscall_64+0x60/0x90
  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Fixes: 9d71dd0c70099 ("can: add support of SAE J1939 protocol")
Reported-by: Sili Luo <rootlab@huawei.com>
Suggested-by: Sili Luo <rootlab@huawei.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: stable@vger.kernel.org
---
 net/can/j1939/socket.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index b28c976f52a0..2ce24bf78c72 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -262,12 +262,17 @@ static bool j1939_sk_match_dst(struct j1939_sock *jsk,
 static bool j1939_sk_match_filter(struct j1939_sock *jsk,
 				  const struct j1939_sk_buff_cb *skcb)
 {
-	const struct j1939_filter *f = jsk->filters;
-	int nfilter = jsk->nfilters;
+	const struct j1939_filter *f;
+	int nfilter;
+
+	lock_sock(&jsk->sk);
+
+	f = jsk->filters;
+	nfilter = jsk->nfilters;
 
 	if (!nfilter)
 		/* receive all when no filters are assigned */
-		return true;
+		goto filter_match_found;
 
 	for (; nfilter; ++f, --nfilter) {
 		if ((skcb->addr.pgn & f->pgn_mask) != f->pgn)
@@ -276,9 +281,15 @@ static bool j1939_sk_match_filter(struct j1939_sock *jsk,
 			continue;
 		if ((skcb->addr.src_name & f->name_mask) != f->name)
 			continue;
-		return true;
+		goto filter_match_found;
 	}
+
+	release_sock(&jsk->sk);
 	return false;
+
+filter_match_found:
+	release_sock(&jsk->sk);
+	return true;
 }
 
 static bool j1939_sk_recv_match_one(struct j1939_sock *jsk,
-- 
2.39.2

