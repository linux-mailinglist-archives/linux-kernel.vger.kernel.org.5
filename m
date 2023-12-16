Return-Path: <linux-kernel+bounces-1931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CBA815605
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17165287838
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA3C29B2;
	Sat, 16 Dec 2023 01:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gstNuOwp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2572923C9
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 01:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702690640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=loZzHfg5cjOtTZMvCdMslIQGPsJFkjb8FLnNRMqhX5E=;
	b=gstNuOwpAGPgfFUhgqjZsbeO8DHdAIc+TA0qa6dyv8OvukFQbgAdgu56Tpf2/wBokodDAM
	dWz6/TD0pIFW37sQ0sy1iGmTbJH1fYZ6a4SI2sRVcrTS/lzmYE0rZG6ujj7ieqyMAVewmK
	OZvLjiUDzEIkEeyNN+bnOjus3hmfQBQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-AiBJfIo7OBykckdORScFAQ-1; Fri, 15 Dec 2023 20:37:17 -0500
X-MC-Unique: AiBJfIo7OBykckdORScFAQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4956185A780;
	Sat, 16 Dec 2023 01:37:16 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.217])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 48D58C15968;
	Sat, 16 Dec 2023 01:37:16 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	George Stark <gnstark@salutedevices.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] locking/mutex: Clean up mutex.h
Date: Fri, 15 Dec 2023 20:36:55 -0500
Message-Id: <20231216013656.1382213-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

CONFIG_DEBUG_MUTEXES and CONFIG_PREEMPT_RT are mutually exclusive. They
can't be both set at the same time.  Move down the mutex_destroy()
function declaration to the bottom of mutex.h to eliminate duplicated
mutex_destroy() declaration.

Also remove the duplicated mutex_trylock() function declaration in the
CONFIG_PREEMPT_RT section.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/mutex.h | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index a33aa9eb9fc3..f3ae911580bf 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -77,18 +77,10 @@ struct mutex {
 };
 
 #ifdef CONFIG_DEBUG_MUTEXES
-
-#define __DEBUG_MUTEX_INITIALIZER(lockname)				\
+# define __DEBUG_MUTEX_INITIALIZER(lockname)				\
 	, .magic = &lockname
-
-extern void mutex_destroy(struct mutex *lock);
-
 #else
-
 # define __DEBUG_MUTEX_INITIALIZER(lockname)
-
-static inline void mutex_destroy(struct mutex *lock) {}
-
 #endif
 
 /**
@@ -151,9 +143,6 @@ struct mutex {
 
 extern void __mutex_rt_init(struct mutex *lock, const char *name,
 			    struct lock_class_key *key);
-extern int mutex_trylock(struct mutex *lock);
-
-static inline void mutex_destroy(struct mutex *lock) { }
 
 #define mutex_is_locked(l)	rt_mutex_base_is_locked(&(l)->rtmutex)
 
@@ -220,6 +209,16 @@ extern void mutex_unlock(struct mutex *lock);
 
 extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
 
+#ifdef CONFIG_DEBUG_MUTEXES
+
+extern void mutex_destroy(struct mutex *lock);
+
+#else
+
+static inline void mutex_destroy(struct mutex *lock) {}
+
+#endif
+
 DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
 DEFINE_FREE(mutex, struct mutex *, if (_T) mutex_unlock(_T))
 
-- 
2.39.3


