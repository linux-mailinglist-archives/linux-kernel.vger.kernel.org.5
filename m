Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E244779EDAB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjIMPvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjIMPvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0AFECCD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694620261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=iABk60dwatWobxRjc3Fair6PpujlXQNgr6XGkMBYTOU=;
        b=dA22QlWSDsjKlU1e1MJ5CdNu1aTK12NJ/aAIyJy+ZcKpFUFYs29D0oWr+VHLP9guZST684
        o3AeYann9ipLbmVOT0QOMzfM0zzs4I9j1NvOJ/m6U8xTK6UiZZ0J6mh/7rzFKXIWKSVeWF
        oyn1p9CzHQouGBzdbvzNlXwyLLg2zKs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-X13l6M4sMwm8QOibNTuw-A-1; Wed, 13 Sep 2023 11:50:57 -0400
X-MC-Unique: X13l6M4sMwm8QOibNTuw-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D423981652F;
        Wed, 13 Sep 2023 15:50:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5E22810F1BE7;
        Wed, 13 Sep 2023 15:50:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 13 Sep 2023 17:50:04 +0200 (CEST)
Date:   Wed, 13 Sep 2023 17:50:00 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] seqlock: introduce seqprop_lock/unlock
Message-ID: <20230913155000.GA26248@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913154907.GA26210@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

which can be used to take/release the corresponding lock.

Thanks to the previous patch, it is trivial to pass 2 arguments to
the new __seqprop_##lockname##_lock/unlock "methods", plus we do not
loose the type info and thus the new seqprop's are "type safe".

So for example

	void func(seqcount_rwlock_t *s, rwlock_t *l)
	{
		seqprop_lock(s, l);
	}

happily compiles, but this one

	void func(seqcount_rwlock_t *s, spinlock_t *l)
	{
		seqprop_lock(s, l);
	}

doesn't.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/seqlock.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 41e36f8afad4..9831683a0102 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -241,6 +241,21 @@ static __always_inline void						\
 __seqprop_##lockname##_assert(const seqcount_##lockname##_t *s)		\
 {									\
 	__SEQ_LOCK(lockdep_assert_held(s->lock));			\
+}									\
+									\
+static __always_inline void						\
+__seqprop_##lockname##_lock(seqcount_##lockname##_t *s,			\
+				locktype *lock)				\
+{									\
+	__SEQ_LOCK(WARN_ON_ONCE(s->lock != lock));			\
+	lockbase##_lock(lock);						\
+}									\
+									\
+static __always_inline void						\
+__seqprop_##lockname##_unlock(seqcount_##lockname##_t *s,		\
+				locktype *lock)				\
+{									\
+	lockbase##_unlock(lock); 					\
 }
 
 /*
@@ -306,6 +321,12 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
 #define seqprop_preemptible(s)		__seqprop(s, preemptible)(s)
 #define seqprop_assert(s)		__seqprop(s, assert)(s)
 
+/* seqcount_t doesn't have these methods */
+static inline void __seqprop_lock   (seqcount_t *s, void *l) { BUILD_BUG(); }
+static inline void __seqprop_unlock (seqcount_t *s, void *l) { BUILD_BUG(); }
+#define seqprop_lock(s, l)		__seqprop(s, lock)(s, l)
+#define seqprop_unlock(s, l)		__seqprop(s, unlock)(s, l)
+
 /**
  * __read_seqcount_begin() - begin a seqcount_t read section w/o barrier
  * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
-- 
2.25.1.362.g51ebf55

