Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869707C75FD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbjJLSgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbjJLSgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:36:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9CFDA;
        Thu, 12 Oct 2023 11:35:56 -0700 (PDT)
Date:   Thu, 12 Oct 2023 18:35:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697135755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2nIrcLmRRoEjLnrmI7Wbsm+A7PZaXBdayO8FQILJ/I=;
        b=fMAhcxBE9/b3hrvmpSlWE4U3Z/g/aUU99fiadOpPOnxwH8idfeUQgIU8bqzazxrSeFRGNG
        alf4378AeoG+OcW9NVJGuq1GHLwmWRJxMgzLAfittocF2/0iblL8p0RuFob72caiAgWzTe
        vljv8HvdmF0P8ai+ks8xDe3Uen3MkR+Rqvjt4n2eaW02JfrravfS1oXYfhW34OLTBAW1qh
        n9MVEkTbCO32xle2hYumBa4MG5pKASUcwx4zlQVFiwQl9CPP1W3yYx3YGpTzLIN2Mbpdku
        nMDooxFYl7/osza6cciV7bHmRz77AjznV9QML/dtzP8trnkRuHj1SyvfKLiUdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697135755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2nIrcLmRRoEjLnrmI7Wbsm+A7PZaXBdayO8FQILJ/I=;
        b=ZbQ8yM0JkoLuCuwKcVBbqPLSM1sxlTALMnKV+PBDIm/MFWrHZswaM4q4jOatxxeCiaRcIY
        YDVCunJsb/Zs9/AA==
From:   "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/seqlock: Change __seqprop() to return the
 function pointer
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231012143227.GA16143@redhat.com>
References: <20231012143227.GA16143@redhat.com>
MIME-Version: 1.0
Message-ID: <169713575405.3135.4365014722583581048.tip-bot2@tip-bot2>
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

Commit-ID:     e6115c6f7a0ce3388cc60b69a284facf78b5dbfd
Gitweb:        https://git.kernel.org/tip/e6115c6f7a0ce3388cc60b69a284facf78b5dbfd
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Thu, 12 Oct 2023 16:32:27 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 12 Oct 2023 20:18:21 +02:00

locking/seqlock: Change __seqprop() to return the function pointer

This simplifies the macro and makes it easy to add the new seqprop's
with 2 or more args.

Plus this way we do not lose the type info, the (void*) type cast is
no longer needed.

And the latter reveals the problem: a lot of seqcount_t helpers pass
the "const seqcount_t *s" argument to __seqprop_ptr(seqcount_t *s)
but (before this patch) "(void *)(s)" masked the problem.

So this patch changes __seqprop_ptr() and __seqprop_##lockname##_ptr()
to accept the "const LOCKNAME *s" argument. This is not nice either,
they need to drop the constness on return because these helpers are used
by both the readers and writers, but at least it is clear what's going on.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20231012143227.GA16143@redhat.com
---
 include/linux/seqlock.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 7e7109d..4b8dcd3 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -200,9 +200,9 @@ typedef struct seqcount_##lockname {					\
 } seqcount_##lockname##_t;						\
 									\
 static __always_inline seqcount_t *					\
-__seqprop_##lockname##_ptr(seqcount_##lockname##_t *s)			\
+__seqprop_##lockname##_ptr(const seqcount_##lockname##_t *s)		\
 {									\
-	return &s->seqcount;						\
+	return (void *)&s->seqcount; /* drop const */			\
 }									\
 									\
 static __always_inline unsigned						\
@@ -247,9 +247,9 @@ __seqprop_##lockname##_assert(const seqcount_##lockname##_t *s)		\
  * __seqprop() for seqcount_t
  */
 
-static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
+static inline seqcount_t *__seqprop_ptr(const seqcount_t *s)
 {
-	return s;
+	return (void *)s; /* drop const */
 }
 
 static inline unsigned __seqprop_sequence(const seqcount_t *s)
@@ -292,19 +292,19 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
 #define SEQCNT_WW_MUTEX_ZERO(name, lock) 	SEQCOUNT_LOCKNAME_ZERO(name, lock)
 
 #define __seqprop_case(s, lockname, prop)				\
-	seqcount_##lockname##_t: __seqprop_##lockname##_##prop((void *)(s))
+	seqcount_##lockname##_t: __seqprop_##lockname##_##prop
 
 #define __seqprop(s, prop) _Generic(*(s),				\
-	seqcount_t:		__seqprop_##prop((void *)(s)),		\
+	seqcount_t:		__seqprop_##prop,			\
 	__seqprop_case((s),	raw_spinlock,	prop),			\
 	__seqprop_case((s),	spinlock,	prop),			\
 	__seqprop_case((s),	rwlock,		prop),			\
 	__seqprop_case((s),	mutex,		prop))
 
-#define seqprop_ptr(s)			__seqprop(s, ptr)
-#define seqprop_sequence(s)		__seqprop(s, sequence)
-#define seqprop_preemptible(s)		__seqprop(s, preemptible)
-#define seqprop_assert(s)		__seqprop(s, assert)
+#define seqprop_ptr(s)			__seqprop(s, ptr)(s)
+#define seqprop_sequence(s)		__seqprop(s, sequence)(s)
+#define seqprop_preemptible(s)		__seqprop(s, preemptible)(s)
+#define seqprop_assert(s)		__seqprop(s, assert)(s)
 
 /**
  * __read_seqcount_begin() - begin a seqcount_t read section w/o barrier
