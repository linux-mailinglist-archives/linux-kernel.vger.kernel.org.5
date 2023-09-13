Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5424179EDA8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjIMPvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjIMPvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61F3BE54
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694620252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=mYBRu8ZisVOcVrXjmDw3lj2GZxU9S1CJfHT4uVPGf+o=;
        b=JyO2v3/BSjmcJsR4QKy19uVYfeojdyzXLBBJQ97JVwGfgEdacuKVJjOTNJk00BsB5JP8Bt
        vsQJjX9ktktZ6ITCw8QH+0D8R9TLjwQ+4MAkkpCgWJM+etRn0etT+yWbEzudOJqip2gqm1
        +dMyriybIyw1KXoIXwqIEWpejPaYf/I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-EJ7jLDN_NRCYgLxLCqtGtA-1; Wed, 13 Sep 2023 11:50:49 -0400
X-MC-Unique: EJ7jLDN_NRCYgLxLCqtGtA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4D33816521;
        Wed, 13 Sep 2023 15:50:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2F9351008808;
        Wed, 13 Sep 2023 15:50:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 13 Sep 2023 17:49:56 +0200 (CEST)
Date:   Wed, 13 Sep 2023 17:49:53 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] seqlock: simplify SEQCOUNT_LOCKNAME()
Message-ID: <20230913154953.GA26242@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913154907.GA26210@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Kill the "lockmember" argument. It is always s->lock plus
   __seqprop_##lockname##_sequence() already uses s->lock and
   ignores "lockmember".

2. Kill the "lock_acquire" argument. __seqprop_##lockname##_sequence()
   can use the same "lockbase" prefix for _lock and _unlock.

Apart from line numbers, gcc -E outputs the same code.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/seqlock.h | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 987a59d977c5..ac6631bd5706 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -191,11 +191,9 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  * @lockname:		"LOCKNAME" part of seqcount_LOCKNAME_t
  * @locktype:		LOCKNAME canonical C data type
  * @preemptible:	preemptibility of above locktype
- * @lockmember:		argument for lockdep_assert_held()
- * @lockbase:		associated lock release function (prefix only)
- * @lock_acquire:	associated lock acquisition function (full call)
+ * @lockbase:		prefix for associated lock/unlock
  */
-#define SEQCOUNT_LOCKNAME(lockname, locktype, preemptible, lockmember, lockbase, lock_acquire) \
+#define SEQCOUNT_LOCKNAME(lockname, locktype, preemptible, lockbase)	\
 typedef struct seqcount_##lockname {					\
 	seqcount_t		seqcount;				\
 	__SEQ_LOCK(locktype	*lock);					\
@@ -216,7 +214,7 @@ __seqprop_##lockname##_sequence(const seqcount_##lockname##_t *s)	\
 		return seq;						\
 									\
 	if (preemptible && unlikely(seq & 1)) {				\
-		__SEQ_LOCK(lock_acquire);				\
+		__SEQ_LOCK(lockbase##_lock(s->lock));			\
 		__SEQ_LOCK(lockbase##_unlock(s->lock));			\
 									\
 		/*							\
@@ -242,7 +240,7 @@ __seqprop_##lockname##_preemptible(const seqcount_##lockname##_t *s)	\
 static __always_inline void						\
 __seqprop_##lockname##_assert(const seqcount_##lockname##_t *s)		\
 {									\
-	__SEQ_LOCK(lockdep_assert_held(lockmember));			\
+	__SEQ_LOCK(lockdep_assert_held(s->lock));			\
 }
 
 /*
@@ -271,10 +269,10 @@ static inline void __seqprop_assert(const seqcount_t *s)
 
 #define __SEQ_RT	IS_ENABLED(CONFIG_PREEMPT_RT)
 
-SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    s->lock,        raw_spin, raw_spin_lock(s->lock))
-SEQCOUNT_LOCKNAME(spinlock,     spinlock_t,      __SEQ_RT, s->lock,        spin,     spin_lock(s->lock))
-SEQCOUNT_LOCKNAME(rwlock,       rwlock_t,        __SEQ_RT, s->lock,        read,     read_lock(s->lock))
-SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
+SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    raw_spin)
+SEQCOUNT_LOCKNAME(spinlock,     spinlock_t,      __SEQ_RT, spin)
+SEQCOUNT_LOCKNAME(rwlock,       rwlock_t,        __SEQ_RT, read)
+SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
 
 /*
  * SEQCNT_LOCKNAME_ZERO - static initializer for seqcount_LOCKNAME_t
-- 
2.25.1.362.g51ebf55

