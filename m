Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09987CE7DD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjJRTio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjJRTin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:38:43 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B401295;
        Wed, 18 Oct 2023 12:38:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 6E7396017F;
        Wed, 18 Oct 2023 21:38:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1697657920; bh=iNVr9y16p7gMqjvxGWT5RJitpyKhZMLfuTLhxHG7Y6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eZAGDQgAN8tryLy/FbQwbshgMTDjqgUPgPc2goAQX1UP1Jvu+xf+zNahwa5FjIlS3
         V1EObg0bbBuImiITDYJSUJQp9Qltt2J7yh/cmiV+y4dg2vC+8V+C4asVXWNV8KcNgw
         RnoLq5r3c7aUy4dCW0kosOw9MXeDMQ4QbJudzBCzSdmQC+t08QVvoX0B6Ch538GIXy
         1E9FqtNKugHj6DLCe+opbFlaHKo2MupXyH9RXRKQZPm00Ntntg5zbmwKTFuOGMjFNW
         us2NmCVhsGm33MsFNXsxQPQT39/tVdgm1/g/R7tv1YndKpDuaH3iOgI4x//srb+fDl
         wLSGVM/6s1ThA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RzrchXTX35UN; Wed, 18 Oct 2023 21:38:37 +0200 (CEST)
Received: from defiant.home (78-2-200-105.adsl.net.t-com.hr [78.2.200.105])
        by domac.alu.hr (Postfix) with ESMTPSA id DEE486017E;
        Wed, 18 Oct 2023 21:38:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1697657917; bh=iNVr9y16p7gMqjvxGWT5RJitpyKhZMLfuTLhxHG7Y6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KAjmb4VfbvWBVJMZNlms/aLuN2a1xKmndkzGRsgvCfCLNqi4FIT/dcId3JyOy6bZA
         nXgWpd3CPhhga/b1TkTJ92X+lzoUF+aF3S6Vg3tK7t/BSy5v9e3PVr6C/kAMOnSXJa
         dyZgSo2/xNSSWc5cBvuETDDrYvXbgGaA39IrB+i2w2SZPE+UTuJ6UV43zk6Y6VXZ8C
         eXSM3Goj+b6TBm4nZMhyivc4K3ZmCQrTmhP8VhODQH9eFqDRtqfwwoL2pGmW/xex7f
         /NlhFasDiZV0rc1lHnf0c9m2n5E7zNqkHmSQFj47vmFKZ2XV3TPvHqhZG8gSaZQoWl
         7QRj7vQxmb5DQ==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     nic_swsd@realtek.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Marco Elver <elver@google.com>
Subject: [PATCH v4 2/3] r8169: fix the KCSAN reported data-race in rtl_tx while reading TxDescArray[entry].opts1
Date:   Wed, 18 Oct 2023 21:34:36 +0200
Message-Id: <20231018193434.344176-2-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018193434.344176-1-mirsad.todorovac@alu.unizg.hr>
References: <20231018193434.344176-1-mirsad.todorovac@alu.unizg.hr>
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
BUG: KCSAN: data-race in rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4368 drivers/net/ethernet/realtek/r8169_main.c:4581) r8169

race at unknown origin, with read to 0xffff888140d37570 of 4 bytes by interrupt on cpu 21:
rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4368 drivers/net/ethernet/realtek/r8169_main.c:4581) r8169
__napi_poll (net/core/dev.c:6527)
net_rx_action (net/core/dev.c:6596 net/core/dev.c:6727)
__do_softirq (kernel/softirq.c:553)
__irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632)
irq_exit_rcu (kernel/softirq.c:647)
sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1074 (discriminator 14))
asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:645)
cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
call_cpuidle (kernel/sched/idle.c:135)
do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:282)
cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/kernel/smpboot.c:294)
secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433)

value changed: 0xb0000042 -> 0x00000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
==================================================================

The read side is in

drivers/net/ethernet/realtek/r8169_main.c
=========================================
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
 → 4367                 status = le32_to_cpu(tp->TxDescArray[entry].opts1);
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
   4397                 if (READ_ONCE(tp->cur_tx) != dirty_tx && skb)
   4398                         rtl8169_doorbell(tp);
   4399         }
   4400 }

tp->TxDescArray[entry].opts1 is reported to have a data-race and READ_ONCE() fixes
this KCSAN warning.

   4366
 → 4367                 status = le32_to_cpu(READ_ONCE(tp->TxDescArray[entry].opts1));
   4368                 if (status & DescOwn)
   4369                         break;
   4370

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
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
v4:
 fixed the Fixes: tag for 2/3.

v3:
 fixed the Fixes: tag for 3/3.

v2:
 fixed double Signed-off-by: tag
 
 drivers/net/ethernet/realtek/r8169_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 81be6085a480..361b90007148 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4364,7 +4364,7 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 		unsigned int entry = dirty_tx % NUM_TX_DESC;
 		u32 status;
 
-		status = le32_to_cpu(tp->TxDescArray[entry].opts1);
+		status = le32_to_cpu(READ_ONCE(tp->TxDescArray[entry].opts1));
 		if (status & DescOwn)
 			break;
 
-- 
2.34.1

