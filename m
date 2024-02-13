Return-Path: <linux-kernel+bounces-62901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3B88527AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B511F230DD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1429CC13C;
	Tue, 13 Feb 2024 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SoIbIFy0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C899D8F45
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707794237; cv=none; b=TIEOl+eQEZjGTdLHbJLT3Km5ctV6B8gQWl7+Ygzw7+/ciFLC9svbingvQBWnatlFpLRvnq5CIulO1fy9sSo3dkDxh8wVsL6EO+C7XiXNchiJacm8GjlJl1xw1ScPn+7yDx7zOte8gEKuBPa5tgHZ+BbhndwwWzEBEOQ1ybcHR5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707794237; c=relaxed/simple;
	bh=HXgAfo4uLv8GHveOmo7cI+pvGtWKUeM5tq7f0Ae9cDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ue6m6bgCNRse0Sr2ozvvUxqK2NxZKMhuQY0DX13KRq36mlzi/lK/72EUlKkdm1avU9C/d5scREVfurSZPjOJ+2qMdmjXM36BET/VYYXXZZ4M+ukItS0UK195dVL813a9b41h95g0mmqT3X5dRvDMjRTYrcfRAO3NrnfocEsYTCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SoIbIFy0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707794234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZLAjPV7sebbsvd3xDxbWzhrfTLokZC3AjL5a7aPY+Y=;
	b=SoIbIFy00MRExQf/nTtuyp/eySoduL8ezkRRpBHQeGfvwg7qUpwmHq5m4Wwf4XNQC/PqA8
	EkUPMrxIorc1bn08kPAeKvKm8QcEvGQ1Q0Ye/A+zpyd/TDQY+kMSqpdroYAMynMTBVFLXQ
	IodDounHEI5CD5Sr0nCGSHWMYD0vlTo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-24-9Ov5uO6qJIF2hSkLm6A-1; Mon,
 12 Feb 2024 22:17:10 -0500
X-MC-Unique: 24-9Ov5uO6qJIF2hSkLm6A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA4F7383CCE4;
	Tue, 13 Feb 2024 03:17:09 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 37B60AD69;
	Tue, 13 Feb 2024 03:17:09 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	George Stark <gnstark@salutedevices.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 2/4] locking/mutex: Clean up mutex.h
Date: Mon, 12 Feb 2024 22:16:54 -0500
Message-Id: <20240213031656.1375951-3-longman@redhat.com>
In-Reply-To: <20240213031656.1375951-1-longman@redhat.com>
References: <20240213031656.1375951-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

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
index 7e208d46ba5b..bad383713db2 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -35,18 +35,10 @@
 #ifndef CONFIG_PREEMPT_RT
 
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
@@ -101,9 +93,6 @@ extern bool mutex_is_locked(struct mutex *lock);
 
 extern void __mutex_rt_init(struct mutex *lock, const char *name,
 			    struct lock_class_key *key);
-extern int mutex_trylock(struct mutex *lock);
-
-static inline void mutex_destroy(struct mutex *lock) { }
 
 #define mutex_is_locked(l)	rt_mutex_base_is_locked(&(l)->rtmutex)
 
@@ -170,6 +159,16 @@ extern void mutex_unlock(struct mutex *lock);
 
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
 DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
 DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
-- 
2.39.3


