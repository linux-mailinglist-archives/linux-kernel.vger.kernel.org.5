Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429867C926E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 05:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjJNDP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 23:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNDPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 23:15:54 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1445B7;
        Fri, 13 Oct 2023 20:15:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id F20BF60152;
        Sat, 14 Oct 2023 05:15:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1697253349; bh=0LkZfwzKwKNgRkuMZX6TvvfAt9PdEsq166wj+rMJcYM=;
        h=From:To:Cc:Subject:Date:From;
        b=h3MFNTe76sFuHATOndIfAp6M/7bcwOt1hfxXKwn5qQKushdcJtyFzhELV25p9kN+6
         LGBeg3GgBY8NBIjyaUJKv2IIqUzXouRaWWk4VOm8fGSQA7VCiGzFpmVKa+HgzLykV3
         Eyespw1tyTj1+IAZHjs+NgH30XsQGHafm+JUptcOrpPKChRXJv2BFMKdrvytRuqees
         w53DY9PjMPfSc9b8rmO8BsMoJ9hAhj/hvJh8qYoq212UD8KTsph/3BZd01NhEwJ6T2
         zAEuTvuvihhsi2TZQ7UVtIdUrH25ZERS96VgRK4pI+a2AexGD3e6eFyMQcbDIT/8Cf
         BjTP8XsXeq2gA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i1tZRJxgq527; Sat, 14 Oct 2023 05:15:46 +0200 (CEST)
Received: from defiant.home (78-2-88-84.adsl.net.t-com.hr [78.2.88.84])
        by domac.alu.hr (Postfix) with ESMTPSA id 1AC166013C;
        Sat, 14 Oct 2023 05:15:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1697253346; bh=0LkZfwzKwKNgRkuMZX6TvvfAt9PdEsq166wj+rMJcYM=;
        h=From:To:Cc:Subject:Date:From;
        b=qTCFjXWlEBL4aCEnQqO4cSIsk7/5xLyOfLN12S6rnSAPYLz65IaOGrqjdnZO900a+
         rAQ7Nn7kPchBuBLDbduodGysBk7wsgXjy3uDoE6lY/wubLSvgY89uDGlm8Bs8Nqalt
         f7RTTtK2o0u+rqkmO6rl9zUNs0sMd7HKdBw68WxBd2QNCoDGK9b9jJjydjCvjiths5
         fCcs6gDCXGkSnC2UaPn4jAgUCXo/T5iKzR7cdQkQQ4dEUeQ+mcZWXy4t3ZNXaH4vlK
         jrsHvGRxMu8dgqTX118jQlyrxOsB7S0iQgEUkZ4jziS1agusuCsRAbXs7rgccjL2qM
         f1rEEMzuEO+KQ==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     nic_swsd@realtek.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Marco Elver <elver@google.com>
Subject: [PATCH v1 1/3] r8169: fix the KCSAN reported data-race in rtl_tx() while reading tp->cur_tx
Date:   Sat, 14 Oct 2023 05:12:56 +0200
Message-Id: <20231014031257.178630-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCSAN reported the following data-race:

==================================================================
BUG: KCSAN: data-race in rtl8169_poll [r8169] / rtl8169_start_xmit [r8169]

write (marked) to 0xffff888102474b74 of 4 bytes by task 5358 on cpu 29:
rtl8169_start_xmit (drivers/net/ethernet/realtek/r8169_main.c:4254) r8169
dev_hard_start_xmit (./include/linux/netdevice.h:4889 ./include/linux/netdevice.h:4903 net/core/dev.c:3544 net/core/dev.c:3560)
sch_direct_xmit (net/sched/sch_generic.c:342)
__dev_queue_xmit (net/core/dev.c:3817 net/core/dev.c:4306)
ip_finish_output2 (./include/linux/netdevice.h:3082 ./include/net/neighbour.h:526 ./include/net/neighbour.h:540 net/ipv4/ip_output.c:233)
__ip_finish_output (net/ipv4/ip_output.c:311 net/ipv4/ip_output.c:293)
ip_finish_output (net/ipv4/ip_output.c:328)
ip_output (net/ipv4/ip_output.c:435)
ip_send_skb (./include/net/dst.h:458 net/ipv4/ip_output.c:127 net/ipv4/ip_output.c:1486)
udp_send_skb (net/ipv4/udp.c:963)
udp_sendmsg (net/ipv4/udp.c:1246)
inet_sendmsg (net/ipv4/af_inet.c:840 (discriminator 4))
sock_sendmsg (net/socket.c:730 net/socket.c:753)
__sys_sendto (net/socket.c:2177)
__x64_sys_sendto (net/socket.c:2185)
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

read to 0xffff888102474b74 of 4 bytes by interrupt on cpu 21:
rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4397 drivers/net/ethernet/realtek/r8169_main.c:4581) r8169
__napi_poll (net/core/dev.c:6527)
net_rx_action (net/core/dev.c:6596 net/core/dev.c:6727)
__do_softirq (kernel/softirq.c:553)
__irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632)
irq_exit_rcu (kernel/softirq.c:647)
common_interrupt (arch/x86/kernel/irq.c:247 (discriminator 14))
asm_common_interrupt (./arch/x86/include/asm/idtentry.h:636)
cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
call_cpuidle (kernel/sched/idle.c:135)
do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:282)
cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/kernel/smpboot.c:294)
secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433)

value changed: 0x002f4815 -> 0x002f4816

Reported by Kernel Concurrency Sanitizer on:
CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
==================================================================

The write side of drivers/net/ethernet/realtek/r8169_main.c is:
==================
   4251         /* rtl_tx needs to see descriptor changes before updated tp->cur_tx */
   4252         smp_wmb();
   4253
 → 4254         WRITE_ONCE(tp->cur_tx, tp->cur_tx + frags + 1);
   4255
   4256         stop_queue = !netif_subqueue_maybe_stop(dev, 0, rtl_tx_slots_avail(tp),
   4257                                                 R8169_TX_STOP_THRS,
   4258                                                 R8169_TX_START_THRS);

The read side is the function rtl_tx():

   4355 static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
   4356                    int budget)
   4357 {
   4358         unsigned int dirty_tx, bytes_compl = 0, pkts_compl = 0;
   4359         struct sk_buff *skb;
   4360
   4361         dirty_tx = tp->dirty_tx;
   4362
   4363         while (READ_ONCE(tp->cur_tx) != dirty_tx) {
   4364                 unsigned int entry = dirty_tx % NUM_TX_DESC;
   4365                 u32 status;
   4366
   4367                 status = le32_to_cpu(tp->TxDescArray[entry].opts1);
   4368                 if (status & DescOwn)
   4369                         break;
   4370
   4371                 skb = tp->tx_skb[entry].skb;
   4372                 rtl8169_unmap_tx_skb(tp, entry);
   4373
   4374                 if (skb) {
   4375                         pkts_compl++;
   4376                         bytes_compl += skb->len;
   4377                         napi_consume_skb(skb, budget);
   4378                 }
   4379                 dirty_tx++;
   4380         }
   4381
   4382         if (tp->dirty_tx != dirty_tx) {
   4383                 dev_sw_netstats_tx_add(dev, pkts_compl, bytes_compl);
   4384                 WRITE_ONCE(tp->dirty_tx, dirty_tx);
   4385
   4386                 netif_subqueue_completed_wake(dev, 0, pkts_compl, bytes_compl,
   4387                                               rtl_tx_slots_avail(tp),
   4388                                               R8169_TX_START_THRS);
   4389                 /*
   4390                  * 8168 hack: TxPoll requests are lost when the Tx packets are
   4391                  * too close. Let's kick an extra TxPoll request when a burst
   4392                  * of start_xmit activity is detected (if it is not detected,
   4393                  * it is slow enough). -- FR
   4394                  * If skb is NULL then we come here again once a tx irq is
   4395                  * triggered after the last fragment is marked transmitted.
   4396                  */
 → 4397                 if (tp->cur_tx != dirty_tx && skb)
   4398                         rtl8169_doorbell(tp);
   4399         }
   4400 }

Obviously from the code, an earlier detected data-race for tp->cur_tx was fixed in the
line 4363:

   4363         while (READ_ONCE(tp->cur_tx) != dirty_tx) {

but the same solution is required for protecting the other access to tp->cur_tx:

 → 4397                 if (READ_ONCE(tp->cur_tx) != dirty_tx && skb)
   4398                         rtl8169_doorbell(tp);

The write in the line 4254 is protected with WRITE_ONCE(), but the read in the line 4397
might have suffered read tearing under some compiler optimisations.

The fix eliminated the KCSAN data-race report for this bug.

It is yet to be evaluated what happens if tp->cur_tx changes between the test in line 4363
and line 4397. This test should certainly not be cached by the compiler in some register
for such a long time, while asynchronous writes to tp->cur_tx might have occurred in line
4254 in the meantime.

Fixes: 94d8a98e6235c ("r8169: reduce number of workaround doorbell rings")
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Marco Elver <elver@google.com>
Cc: netdev@vger.kernel.org
Link: https://lore.kernel.org/lkml/dc7fc8fa-4ea4-e9a9-30a6-7c83e6b53188@alu.unizg.hr/
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Acked-by: Marco Elver <elver@google.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 6351a2dc13bc..281aaa851847 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4394,7 +4394,7 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 		 * If skb is NULL then we come here again once a tx irq is
 		 * triggered after the last fragment is marked transmitted.
 		 */
-		if (tp->cur_tx != dirty_tx && skb)
+		if (READ_ONCE(tp->cur_tx) != dirty_tx && skb)
 			rtl8169_doorbell(tp);
 	}
 }
-- 
2.34.1

