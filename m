Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E5F7BE8AB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377995AbjJIRtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377976AbjJIRtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:49:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FA8CC;
        Mon,  9 Oct 2023 10:49:09 -0700 (PDT)
Date:   Mon, 09 Oct 2023 17:49:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696873748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PbsKPCrGLp//NWnC934vWGHzzWfrPxMe6zPNAPbsNRc=;
        b=bkCmsVTqKfbcML0UCN4uLY3QbFochbywPeu4P5Shaa7DRXjFZ2pKCRp1dyMGWCpMwb6FdP
        byull2QiF+a5CEj8KaihoHLBREQy7KbpBRqVzJlzvZRoyM3538UjheXJWws5B+LThXFfcU
        L/RmHzDEgbLQF1WnZ51BBuYNiP4OpcGOTK4JvmV3MUgkzIshiCyWeGmI14HJ2GAPspwmt+
        dXRlUpBrmTsjBxE/vLBUELvRoNNg7650qukLbGL58wV9FNIaHLIZfYHkAC8fbhIQzFJfdy
        hsk1J46EipGjGZHK0aiNsxL/P3osWm7Dcv2zPpp5DNuNTINSlwbb/QzBYAbOtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696873748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PbsKPCrGLp//NWnC934vWGHzzWfrPxMe6zPNAPbsNRc=;
        b=GBOUG/64USpbcusFPR48TcWbsO+8YI4b277wV+Lt9vmrnSK1t11ZIA0hHKsCb/QmyFUVQ7
        Pld/y9t7pTG2MGBg==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic, xen: Use sync_try_cmpxchg()
 instead of sync_cmpxchg()
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <169687374726.3135.10624349103335300582.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ad0a2e4c2f20510d7e3f2bc110cf74f8578547f0
Gitweb:        https://git.kernel.org/tip/ad0a2e4c2f20510d7e3f2bc110cf74f8578547f0
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 10 Jul 2023 21:01:27 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Oct 2023 18:14:34 +02:00

locking/atomic, xen: Use sync_try_cmpxchg() instead of sync_cmpxchg()

Use sync_try_cmpxchg() instead of sync_cmpxchg(*ptr, old, new) == old
in clear_masked_cond(), clear_linked() and
gnttab_end_foreign_access_ref_v1(). x86 CMPXCHG instruction returns
success in ZF flag, so this change saves a compare after cmpxchg
(and related move instruction in front of cmpxchg), improving the
cmpxchg loop in gnttab_end_foreign_access_ref_v1() from:

     174:	eb 0e                	jmp    184 <...>
     176:	89 d0                	mov    %edx,%eax
     178:	f0 66 0f b1 31       	lock cmpxchg %si,(%rcx)
     17d:	66 39 c2             	cmp    %ax,%dx
     180:	74 11                	je     193 <...>
     182:	89 c2                	mov    %eax,%edx
     184:	89 d6                	mov    %edx,%esi
     186:	66 83 e6 18          	and    $0x18,%si
     18a:	74 ea                	je     176 <...>

to:

     614:	89 c1                	mov    %eax,%ecx
     616:	66 83 e1 18          	and    $0x18,%cx
     61a:	75 11                	jne    62d <...>
     61c:	f0 66 0f b1 0a       	lock cmpxchg %cx,(%rdx)
     621:	75 f1                	jne    614 <...>

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
---
 drivers/xen/events/events_fifo.c | 26 ++++++++++++--------------
 drivers/xen/grant-table.c        | 10 ++++------
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/xen/events/events_fifo.c b/drivers/xen/events/events_fifo.c
index ad9fe51..655775d 100644
--- a/drivers/xen/events/events_fifo.c
+++ b/drivers/xen/events/events_fifo.c
@@ -226,21 +226,20 @@ static bool evtchn_fifo_is_masked(evtchn_port_t port)
  */
 static bool clear_masked_cond(volatile event_word_t *word)
 {
-	event_word_t new, old, w;
+	event_word_t new, old;
 
-	w = *word;
+	old = *word;
 
 	do {
-		if (!(w & (1 << EVTCHN_FIFO_MASKED)))
+		if (!(old & (1 << EVTCHN_FIFO_MASKED)))
 			return true;
 
-		if (w & (1 << EVTCHN_FIFO_PENDING))
+		if (old & (1 << EVTCHN_FIFO_PENDING))
 			return false;
 
-		old = w & ~(1 << EVTCHN_FIFO_BUSY);
+		old = old & ~(1 << EVTCHN_FIFO_BUSY);
 		new = old & ~(1 << EVTCHN_FIFO_MASKED);
-		w = sync_cmpxchg(word, old, new);
-	} while (w != old);
+	} while (!sync_try_cmpxchg(word, &old, new));
 
 	return true;
 }
@@ -259,17 +258,16 @@ static void evtchn_fifo_unmask(evtchn_port_t port)
 
 static uint32_t clear_linked(volatile event_word_t *word)
 {
-	event_word_t new, old, w;
+	event_word_t new, old;
 
-	w = *word;
+	old = *word;
 
 	do {
-		old = w;
-		new = (w & ~((1 << EVTCHN_FIFO_LINKED)
-			     | EVTCHN_FIFO_LINK_MASK));
-	} while ((w = sync_cmpxchg(word, old, new)) != old);
+		new = (old & ~((1 << EVTCHN_FIFO_LINKED)
+			       | EVTCHN_FIFO_LINK_MASK));
+	} while (!sync_try_cmpxchg(word, &old, new));
 
-	return w & EVTCHN_FIFO_LINK_MASK;
+	return old & EVTCHN_FIFO_LINK_MASK;
 }
 
 static void consume_one_event(unsigned cpu, struct evtchn_loop_ctrl *ctrl,
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 35659bf..04a6b47 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -427,16 +427,14 @@ EXPORT_SYMBOL_GPL(gnttab_grant_foreign_access);
 
 static int gnttab_end_foreign_access_ref_v1(grant_ref_t ref)
 {
-	u16 flags, nflags;
-	u16 *pflags;
+	u16 *pflags = &gnttab_shared.v1[ref].flags;
+	u16 flags;
 
-	pflags = &gnttab_shared.v1[ref].flags;
-	nflags = *pflags;
+	flags = *pflags;
 	do {
-		flags = nflags;
 		if (flags & (GTF_reading|GTF_writing))
 			return 0;
-	} while ((nflags = sync_cmpxchg(pflags, flags, 0)) != flags);
+	} while (!sync_try_cmpxchg(pflags, &flags, 0));
 
 	return 1;
 }
