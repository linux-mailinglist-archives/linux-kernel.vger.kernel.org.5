Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004507CB5A4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjJPVul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJPVuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:50:37 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A780A1;
        Mon, 16 Oct 2023 14:50:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 236EF60189;
        Mon, 16 Oct 2023 23:50:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1697493034; bh=MkTKwT3XbZTNx3TBlsKMazhufubh4WJ4GiMjhavGK1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wLIjutS3QJYWnA+6V5swDjX05i9hWbzILtlJV3QXPDd5+JwvyezLN1FUDD0kTF5By
         PZJDD+f7HmfSnVOK+7IaqYeJzuAEU+PVPZwduPCPqcXN2embBy9krUvA8A7aJ04WLq
         BxhAR5GRDvau5QIEn+UIWVWdfd7uHSivBz69tlD4H9P4ZrPxUueHrog5kL2zafRL9B
         L446oo3j4fvoV2x2OIqE5YGDo+GwBeYo9i9SOrQ9ECCASPg6EWyhtZVYi1TVb1Sbll
         fke9jl/50BX6Iru9LVrcKAM381UCoIcBInQqr0CPXm6r4CSmHVFhhOnzomqjIcs1TE
         DVoxjJJim2iOw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UWUC3CrxUqC0; Mon, 16 Oct 2023 23:50:30 +0200 (CEST)
Received: from defiant.home (78-3-40-223.adsl.net.t-com.hr [78.3.40.223])
        by domac.alu.hr (Postfix) with ESMTPSA id 46B2360186;
        Mon, 16 Oct 2023 23:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1697493030; bh=MkTKwT3XbZTNx3TBlsKMazhufubh4WJ4GiMjhavGK1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=goi5huGDl+O2IH8TvN7BOPycFyKB3kvMF/W/7sp85KKw+AhgifcC5X07VYlr+fLyo
         RNzDjZSpNr2G6JgDz58YxcNuV1sOLMUQgKgkRoVXCJRPzbl8cbpU/lbv0Ad0nTzrrW
         VdbJRXcT57Jphr4ar7BN3QnhFBe/6D/q1xoUwTtgg2j8n0krWshi4fAhYj0RpdbCRm
         e2+SfFW+Orn9ETaaeeCDaUf80uP/ogxc2gviAOg0saw1yPeP6DpPaPaTJz/tsxux5a
         yXzetmaSLMGKeWYnb6bI5p2pLuY4+DKHc95Skel/CkaoR9pxX7vsVJHmYDyX2445D5
         XQqPNRC7P0WlQ==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     nic_swsd@realtek.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Marco Elver <elver@google.com>
Subject: [PATCH v2 2/3] r8169: fix the KCSAN reported data race in rtl_rx while reading desc->opts1
Date:   Mon, 16 Oct 2023 23:47:54 +0200
Message-Id: <20231016214753.175097-2-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016214753.175097-1-mirsad.todorovac@alu.unizg.hr>
References: <20231016214753.175097-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCSAN reported the following data-race bug:

==================================================================
BUG: KCSAN: data-race in rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4430 drivers/net/ethernet/realtek/r8169_main.c:4583) r8169

race at unknown origin, with read to 0xffff888117e43510 of 4 bytes by interrupt on cpu 21:
rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4430 drivers/net/ethernet/realtek/r8169_main.c:4583) r8169
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

value changed: 0x80003fff -> 0x3402805f

Reported by Kernel Concurrency Sanitizer on:
CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
==================================================================

drivers/net/ethernet/realtek/r8169_main.c:
==========================================
   4429
 → 4430                 status = le32_to_cpu(desc->opts1);
   4431                 if (status & DescOwn)
   4432                         break;
   4433
   4434                 /* This barrier is needed to keep us from reading
   4435                  * any other fields out of the Rx descriptor until
   4436                  * we know the status of DescOwn
   4437                  */
   4438                 dma_rmb();
   4439
   4440                 if (unlikely(status & RxRES)) {
   4441                         if (net_ratelimit())
   4442                                 netdev_warn(dev, "Rx ERROR. status = %08x\n",

Marco Elver explained that dma_rmb() doesn't prevent the compiler to tear up the access to
desc->opts1 which can be written to concurrently. READ_ONCE() should prevent that from
happening:

   4429
 → 4430                 status = le32_to_cpu(READ_ONCE(desc->opts1));
   4431                 if (status & DescOwn)
   4432                         break;
   4433

As the consequence of this fix, this KCSAN warning was eliminated.

Fixes: 6202806e7c03a ("r8169: drop member opts1_mask from struct rtl8169_private")
Suggested-by: Marco Elver <elver@google.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Link: https://lore.kernel.org/lkml/dc7fc8fa-4ea4-e9a9-30a6-7c83e6b53188@alu.unizg.hr/
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Acked-by: Marco Elver <elver@google.com>
---
v2:
 fixed erroneous double Signed-off-by: tag

 drivers/net/ethernet/realtek/r8169_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 7e14a1d958c8..361b90007148 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4427,7 +4427,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		dma_addr_t addr;
 		u32 status;
 
-		status = le32_to_cpu(desc->opts1);
+		status = le32_to_cpu(READ_ONCE(desc->opts1));
 		if (status & DescOwn)
 			break;
 
-- 
2.34.1

