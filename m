Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C4B7C705C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjJLOeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjJLOeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:34:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D4FCC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697121214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kjD/zSOLO+IWRgc+ciy7+kba7RJqZ7Ml7ojDfBUl9Rg=;
        b=fXv98M3IIJS7joIIh7QDd5AQn4bAORIjDCR5JQl3fts3AITH4XciiPCe2i5OF+HsyPHnY0
        03g8+OkeyObpZRWSYdCsXCW4pXmXv3IdBQhTLPSPACDKi91BWUHefrWr/dyeU9vqwQRzsd
        jZEeC0fLYjp9yXJgGZ5GxdQlAd4cW/U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-2YdBp-vTNZaiNHZmPowIJw-1; Thu, 12 Oct 2023 10:33:29 -0400
X-MC-Unique: 2YdBp-vTNZaiNHZmPowIJw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 626538DBAEE;
        Thu, 12 Oct 2023 14:33:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.172])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9D7951C060DF;
        Thu, 12 Oct 2023 14:33:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 12 Oct 2023 16:32:30 +0200 (CEST)
Date:   Thu, 12 Oct 2023 16:32:27 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexey Gladkov <legion@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] seqlock: change __seqprop() to return the function
 pointer
Message-ID: <20231012143227.GA16143@redhat.com>
References: <20231012143158.GA16133@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012143158.GA16133@redhat.com>
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
---
 include/linux/seqlock.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index b9a30c62ffe4..bf1435ffe24f 100644
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
-- 
2.25.1.362.g51ebf55


