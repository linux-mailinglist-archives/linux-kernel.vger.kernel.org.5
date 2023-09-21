Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11097A9D37
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjIUT3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjIUT3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:29:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ACC72BA;
        Thu, 21 Sep 2023 10:10:10 -0700 (PDT)
Date:   Thu, 21 Sep 2023 07:43:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695282186;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bsjysVzURheAf6GJ2EjLUVnFxyqQ+3pm+FArm8UVtFc=;
        b=ovejVn/ntq+H77sRf+Idb7wq1Kke+/kMhMdslWBV33lBg5HjglzXZRl+WhIA2GnVHwSGQN
        4zPLfo9qdkG1dCYQTefuO1pYhtH26WWwKI8uBZZqer8awtq1Wyzh3upc1jmrvzu9vZayMx
        Od8roZLZfs2pV3JegiiXpQ2tYfwSOEW2fCKlgq/aUsaWVXDtXANBEUPhUXSs577dhaYndw
        q1CeyksCdlOEqF0y+nkaoTdS71qlK2UIgdZRyRbK8e2ODtdYy8HcDTBW44fKqpFZNoHhQk
        P4aeAN/p4UjGJmmPrdX4Y6AMkK/pr4BlWYshUYoeyz1bWWbuCZY/hUqdzKld9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695282186;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bsjysVzURheAf6GJ2EjLUVnFxyqQ+3pm+FArm8UVtFc=;
        b=23v1i2C+5mC7Dz2KVXJfsWAqy4yaKx73w7l9q9Vo9N7zKGsWr0/6TcVubz5jOmsPWcSmoI
        UEH0atg1gg8g/pCg==
From:   "tip-bot2 for Finn Thain" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Optimize in_task() and in_interrupt() a bit
Cc:     Finn Thain <fthain@linux-m68k.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C0a403120a682a525e6db2d81d1a3ffcc137c3742=2E16947?=
 =?utf-8?q?56831=2Egit=2Efthain=40linux-m68k=2Eorg=3E?=
References: =?utf-8?q?=3C0a403120a682a525e6db2d81d1a3ffcc137c3742=2E169475?=
 =?utf-8?q?6831=2Egit=2Efthain=40linux-m68k=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <169528218521.27769.16373979341489585519.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     87c3a5893e865739ce78aa7192d36011022e0af7
Gitweb:        https://git.kernel.org/tip/87c3a5893e865739ce78aa7192d36011022e0af7
Author:        Finn Thain <fthain@linux-m68k.org>
AuthorDate:    Fri, 15 Sep 2023 15:47:11 +10:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Sep 2023 09:40:30 +02:00

sched/core: Optimize in_task() and in_interrupt() a bit

Except on x86, preempt_count is always accessed with READ_ONCE().
Repeated invocations in macros like irq_count() produce repeated loads.
These redundant instructions appear in various fast paths. In the one
shown below, for example, irq_count() is evaluated during kernel entry
if !tick_nohz_full_cpu(smp_processor_id()).

0001ed0a <irq_enter_rcu>:
   1ed0a:       4e56 0000       linkw %fp,#0
   1ed0e:       200f            movel %sp,%d0
   1ed10:       0280 ffff e000  andil #-8192,%d0
   1ed16:       2040            moveal %d0,%a0
   1ed18:       2028 0008       movel %a0@(8),%d0
   1ed1c:       0680 0001 0000  addil #65536,%d0
   1ed22:       2140 0008       movel %d0,%a0@(8)
   1ed26:       082a 0001 000f  btst #1,%a2@(15)
   1ed2c:       670c            beqs 1ed3a <irq_enter_rcu+0x30>
   1ed2e:       2028 0008       movel %a0@(8),%d0
   1ed32:       2028 0008       movel %a0@(8),%d0
   1ed36:       2028 0008       movel %a0@(8),%d0
   1ed3a:       4e5e            unlk %fp
   1ed3c:       4e75            rts

This patch doesn't prevent the pointless btst and beqs instructions
above, but it does eliminate 2 of the 3 pointless move instructions
here and elsewhere.

On x86, preempt_count is per-cpu data and the problem does not arise
presumably because the compiler is free to optimize more effectively.

This patch was tested on m68k and x86. I was expecting no changes
to object code for x86 and mostly that's what I saw. However, there
were a few places where code generation was perturbed for some reason.

The performance issue addressed here is minor on uniprocessor m68k. I
got a 0.01% improvement from this patch for a simple "find /sys -false"
benchmark. For architectures and workloads susceptible to cache line bounce
the improvement is expected to be larger. The only SMP architecture I have
is x86, and as x86 unaffected I have not done any further measurements.

Fixes: 15115830c887 ("preempt: Cleanup the macro maze a bit")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/0a403120a682a525e6db2d81d1a3ffcc137c3742.1694756831.git.fthain@linux-m68k.org
---
 include/linux/preempt.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 1424670..9aa6358 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -99,14 +99,21 @@ static __always_inline unsigned char interrupt_context_level(void)
 	return level;
 }
 
+/*
+ * These macro definitions avoid redundant invocations of preempt_count()
+ * because such invocations would result in redundant loads given that
+ * preempt_count() is commonly implemented with READ_ONCE().
+ */
+
 #define nmi_count()	(preempt_count() & NMI_MASK)
 #define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
 #ifdef CONFIG_PREEMPT_RT
 # define softirq_count()	(current->softirq_disable_cnt & SOFTIRQ_MASK)
+# define irq_count()		((preempt_count() & (NMI_MASK | HARDIRQ_MASK)) | softirq_count())
 #else
 # define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
+# define irq_count()		(preempt_count() & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_MASK))
 #endif
-#define irq_count()	(nmi_count() | hardirq_count() | softirq_count())
 
 /*
  * Macros to retrieve the current execution context:
@@ -119,7 +126,11 @@ static __always_inline unsigned char interrupt_context_level(void)
 #define in_nmi()		(nmi_count())
 #define in_hardirq()		(hardirq_count())
 #define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
-#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
+#ifdef CONFIG_PREEMPT_RT
+# define in_task()		(!((preempt_count() & (NMI_MASK | HARDIRQ_MASK)) | in_serving_softirq()))
+#else
+# define in_task()		(!(preempt_count() & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
+#endif
 
 /*
  * The following macros are deprecated and should not be used in new code:
