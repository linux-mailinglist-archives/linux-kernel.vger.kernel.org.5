Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4967C7059
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjJLOdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjJLOdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:33:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B169A9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697121185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=dEigp1+IVvbV3HsL5vf6dh/kMBqJisFQ+4N2B09Iu7A=;
        b=RMOPXIMWbsGvfGzjqNIDbPmIWSC1GRqsoRXU357IftiIx8EERJ/z16vf29dOzz6eGJPKPq
        huYBNSR7Pv5Ie5AFpxIeLhS2akBrH6GhR22tK3p4ugK9nIDhWtH+9mEEC32TvbzAFGESxi
        6WUW61Xqm2j3JnMa1H0/rix3OG+g1qc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-65IOoLAJN6OwML0JWpkZ9w-1; Thu, 12 Oct 2023 10:32:59 -0400
X-MC-Unique: 65IOoLAJN6OwML0JWpkZ9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62B03280C297;
        Thu, 12 Oct 2023 14:32:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.172])
        by smtp.corp.redhat.com (Postfix) with SMTP id B61B01C060DF;
        Thu, 12 Oct 2023 14:32:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 12 Oct 2023 16:32:00 +0200 (CEST)
Date:   Thu, 12 Oct 2023 16:31:58 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexey Gladkov <legion@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] seqlock: simplify SEQCOUNT_LOCKNAME()
Message-ID: <20231012143158.GA16133@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index e9bd2f65d7f4..b9a30c62ffe4 100644
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


