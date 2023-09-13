Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E2479EDAA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjIMPvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjIMPvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDA0A1724
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694620258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=VnG66QyFsTzARJUHVO8Khm4VR1nzFPa/6kCMVpwGaPA=;
        b=Ne1CD3Dgx+v/N0NdG4UBEiEYODQubnpQFAGrUvYAiq8VdzqyivzrEeHlzm+u1V3xOd+2Xt
        C9jCqjVaIjnOopyVWC6kLA6SScG401QZoQTosMpxHi7sGVZ5lob7Lh0Dbva46xucHo1h25
        af3gKAuUUNkzVZ9zFhw6gfraKGPQCDI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-8fcwpHowNhq13iRSFKUVLg-1; Wed, 13 Sep 2023 11:50:52 -0400
X-MC-Unique: 8fcwpHowNhq13iRSFKUVLg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F876857A9A;
        Wed, 13 Sep 2023 15:50:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id BE2A940C6EBF;
        Wed, 13 Sep 2023 15:50:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 13 Sep 2023 17:49:59 +0200 (CEST)
Date:   Wed, 13 Sep 2023 17:49:56 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] seqlock: change __seqprop() to return the function
 pointer
Message-ID: <20230913154956.GA26245@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913154907.GA26210@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preparation, see the next patch.

This way it is trivial to add the new seqprop's with 2 or more args,
and we do not loose the type info.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/seqlock.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index ac6631bd5706..41e36f8afad4 100644
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

