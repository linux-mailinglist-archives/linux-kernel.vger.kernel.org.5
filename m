Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A4C7CE820
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjJRTtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjJRTtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:49:01 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0752F12A;
        Wed, 18 Oct 2023 12:48:57 -0700 (PDT)
Received: from smtp.gmail.com (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6FFC841667;
        Wed, 18 Oct 2023 19:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697658533;
        bh=q/gI4PcKUTSkZEO2X7cx1o5TMd8FkYNBDk5OQzXeztw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=U34gL95E19+hPs4CUFk2ZWiCQKMKSxu4Rp+Kq5hmE6LgNO2Afspz4YBbB1jq4Nx6C
         v6E9dVAiy5qhR5JEE1tPdscJJPB7BjY5Y1djPfuJYZfQINWjjl3xcfM+JvzdU6JlBQ
         VgUEfFfV3Wtlx2Kz/zMuQKTrRqxZhv9IP/4dzmHdXe7RWJCj7J+QZ6M10yGA9JwGPV
         rzerVR6frjNZfJjjGTqcBetYs2sdBO2MftlyZhMWLmq9viIvvHsIy5FQQC+ZWi+Tu8
         dOYp4x2NFWtAngH7k3o0NycUadFgWywSLAOk4o1zok8GI9ieOe7eAJwXQSXQAt9dMu
         dZKLhkl219FxQ==
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>,
        Joseph Salisbury <joseph.salisbury@canonical.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH RT 08/12] mm/page_alloc: Use write_seqlock_irqsave() instead write_seqlock() + local_irq_save().
Date:   Wed, 18 Oct 2023 15:48:29 -0400
Message-Id: <20231018194833.651674-9-joseph.salisbury@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018194833.651674-1-joseph.salisbury@canonical.com>
References: <20231018194833.651674-1-joseph.salisbury@canonical.com>
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

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v5.15.133-rt70-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


__build_all_zonelists() acquires zonelist_update_seq by first disabling
interrupts via local_irq_save() and then acquiring the seqlock with
write_seqlock(). This is troublesome and leads to problems on
PREEMPT_RT. The problem is that the inner spinlock_t becomes a sleeping
lock on PREEMPT_RT and must not be acquired with disabled interrupts.

The API provides write_seqlock_irqsave() which does the right thing in
one step.
printk_deferred_enter() has to be invoked in non-migrate-able context to
ensure that deferred printing is enabled and disabled on the same CPU.
This is the case after zonelist_update_seq has been acquired.

There was discussion on the first submission that the order should be:
	local_irq_disable();
	printk_deferred_enter();
	write_seqlock();

to avoid pitfalls like having an unaccounted printk() coming from
write_seqlock_irqsave() before printk_deferred_enter() is invoked. The
only origin of such a printk() can be a lockdep splat because the
lockdep annotation happens after the sequence count is incremented.
This is exceptional and subject to change.

It was also pointed that PREEMPT_RT can be affected by the printk
problem since its write_seqlock_irqsave() does not really disable
interrupts. This isn't the case because PREEMPT_RT's printk
implementation differs from the mainline implementation in two important
aspects:
- Printing happens in a dedicated threads and not at during the
  invocation of printk().
- In emergency cases where synchronous printing is used, a different
  driver is used which does not use tty_port::lock.

Acquire zonelist_update_seq with write_seqlock_irqsave() and then defer
printk output.

Fixes: 1007843a91909 ("mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock")
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20230623201517.yw286Knb@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit 4d1139baae8bc4fff3728d1d204bdb04c13dbe10)
Signed-off-by: Joseph Salisbury <joseph.salisbury@canonical.com>
---
 mm/page_alloc.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 33355028122a..174bcc23d5fd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6419,19 +6419,17 @@ static void __build_all_zonelists(void *data)
 	unsigned long flags;
 
 	/*
-	 * Explicitly disable this CPU's interrupts before taking seqlock
-	 * to prevent any IRQ handler from calling into the page allocator
-	 * (e.g. GFP_ATOMIC) that could hit zonelist_iter_begin and livelock.
+	 * The zonelist_update_seq must be acquired with irqsave because the
+	 * reader can be invoked from IRQ with GFP_ATOMIC.
 	 */
-	local_irq_save(flags);
+	write_seqlock_irqsave(&zonelist_update_seq, flags);
 	/*
-	 * Explicitly disable this CPU's synchronous printk() before taking
-	 * seqlock to prevent any printk() from trying to hold port->lock, for
+	 * Also disable synchronous printk() to prevent any printk() from
+	 * trying to hold port->lock, for
 	 * tty_insert_flip_string_and_push_buffer() on other CPU might be
 	 * calling kmalloc(GFP_ATOMIC | __GFP_NOWARN) with port->lock held.
 	 */
 	printk_deferred_enter();
-	write_seqlock(&zonelist_update_seq);
 
 #ifdef CONFIG_NUMA
 	memset(node_load, 0, sizeof(node_load));
@@ -6464,9 +6462,8 @@ static void __build_all_zonelists(void *data)
 #endif
 	}
 
-	write_sequnlock(&zonelist_update_seq);
 	printk_deferred_exit();
-	local_irq_restore(flags);
+	write_sequnlock_irqrestore(&zonelist_update_seq, flags);
 }
 
 static noinline void __init
-- 
2.34.1

