Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9897C9421
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 12:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjJNK3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 06:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjJNK3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 06:29:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEB5A2;
        Sat, 14 Oct 2023 03:29:13 -0700 (PDT)
Date:   Sat, 14 Oct 2023 10:29:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697279350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=eE+poOiRRwrdwN/fZ4h4/pg7LGMoOCv7Xn+HsYY3yV8=;
        b=ivZ5MQYSWP776eH5qHrKWywfAcZ4TtnO4uYjOqTjm6Sli8kWy+km8oIA5LD9JK6lIv1z1m
        gCwXamLA8Ft6YqhHDMIOAuRF3z6bC+DaD45IiW5OjgYRYcjZmhy2WWfjKiXM93xgenAVpT
        yFaoPydvGS4am/0LIeV4//WCoq+AShfJIzffEoRH9rS9uy0C0s/rLeHUl5aJI43l0pxIXg
        pZwy92G/V9erHDQqzvHnakzIs7uUxw2rk2Jo+0H3gVQIebk1ZMhfECHi701s+GUDCRrTrf
        7qaA8S1uDwfWAKPMQ+o0PjzHyGdzvkhNG44KvpFzbNJBkWDbPEg9vEM9QJe9Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697279350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=eE+poOiRRwrdwN/fZ4h4/pg7LGMoOCv7Xn+HsYY3yV8=;
        b=wMqTVbvoq6zLujsaJLS9kvlnyQrgXsWgg+tytMQiyan8viXSVsxKCY0+jyhy4J4vAPctp8
        jYE0nKj/eFr/plCw==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/seqlock: Propagate 'const' pointers
 within read-only methods, remove forced type casts
Cc:     Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169727934984.3135.3212674170316933544.tip-bot2@tip-bot2>
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

Commit-ID:     886ee55eabac0d46faf8bc0b22207ca2740847ba
Gitweb:        https://git.kernel.org/tip/886ee55eabac0d46faf8bc0b22207ca2740847ba
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 13 Oct 2023 10:15:46 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 14 Oct 2023 11:06:15 +02:00

locking/seqlock: Propagate 'const' pointers within read-only methods, remove forced type casts

Currently __seqprop_ptr() is an inline function that must chose to either
use 'const' or non-const seqcount related pointers - but this results in
the undesirable loss of 'const' propagation, via a forced type cast.

The easiest solution would be to turn the pointer wrappers into macros that
pass through whatever type is passed to them - but the clever maze of
seqlock API instantiation macros relies on the GCC CPP '##' macro
extension, which isn't recursive, so inline functions must be used here.

So create two wrapper variants instead: 'ptr' and 'const_ptr', and pick the
right one for the codepaths that are const: read_seqcount_begin() and
read_seqcount_retry().

This cleans up type handling and allows the removal of all type forcing.

No change in functionality.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/seqlock.h | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 4b8dcd3..80f21d2 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -200,9 +200,15 @@ typedef struct seqcount_##lockname {					\
 } seqcount_##lockname##_t;						\
 									\
 static __always_inline seqcount_t *					\
-__seqprop_##lockname##_ptr(const seqcount_##lockname##_t *s)		\
+__seqprop_##lockname##_ptr(seqcount_##lockname##_t *s)			\
 {									\
-	return (void *)&s->seqcount; /* drop const */			\
+	return &s->seqcount;						\
+}									\
+									\
+static __always_inline const seqcount_t *				\
+__seqprop_##lockname##_const_ptr(const seqcount_##lockname##_t *s)	\
+{									\
+	return &s->seqcount;						\
 }									\
 									\
 static __always_inline unsigned						\
@@ -247,9 +253,14 @@ __seqprop_##lockname##_assert(const seqcount_##lockname##_t *s)		\
  * __seqprop() for seqcount_t
  */
 
-static inline seqcount_t *__seqprop_ptr(const seqcount_t *s)
+static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
+{
+	return s;
+}
+
+static inline const seqcount_t *__seqprop_const_ptr(const seqcount_t *s)
 {
-	return (void *)s; /* drop const */
+	return s;
 }
 
 static inline unsigned __seqprop_sequence(const seqcount_t *s)
@@ -302,6 +313,7 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
 	__seqprop_case((s),	mutex,		prop))
 
 #define seqprop_ptr(s)			__seqprop(s, ptr)(s)
+#define seqprop_const_ptr(s)		__seqprop(s, const_ptr)(s)
 #define seqprop_sequence(s)		__seqprop(s, sequence)(s)
 #define seqprop_preemptible(s)		__seqprop(s, preemptible)(s)
 #define seqprop_assert(s)		__seqprop(s, assert)(s)
@@ -353,7 +365,7 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
  */
 #define read_seqcount_begin(s)						\
 ({									\
-	seqcount_lockdep_reader_access(seqprop_ptr(s));			\
+	seqcount_lockdep_reader_access(seqprop_const_ptr(s));		\
 	raw_read_seqcount_begin(s);					\
 })
 
@@ -419,7 +431,7 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
  * Return: true if a read section retry is required, else false
  */
 #define __read_seqcount_retry(s, start)					\
-	do___read_seqcount_retry(seqprop_ptr(s), start)
+	do___read_seqcount_retry(seqprop_const_ptr(s), start)
 
 static inline int do___read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
@@ -439,7 +451,7 @@ static inline int do___read_seqcount_retry(const seqcount_t *s, unsigned start)
  * Return: true if a read section retry is required, else false
  */
 #define read_seqcount_retry(s, start)					\
-	do_read_seqcount_retry(seqprop_ptr(s), start)
+	do_read_seqcount_retry(seqprop_const_ptr(s), start)
 
 static inline int do_read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
