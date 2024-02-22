Return-Path: <linux-kernel+bounces-76744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A1685FBDA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BFC1F2143D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F1C14D42B;
	Thu, 22 Feb 2024 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZTIuq7l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF4F14A4E5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614363; cv=none; b=s8AEYHGJ5r1qAyIT0OTBCLov3rOQDZw9iSQgfBzva4sSEhreVFGW9VY/o8tV3ILmOitl7yQ2WB2y4uqphOAaKVRNLGzelPqHEJBbumDNhR4+HMqfS6oov1sPOpXaeW9Jls40DkdTEzVyw5GOQpt+XrIrAlL/spOebm2qXe/4KHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614363; c=relaxed/simple;
	bh=RTHbRgi+bBhmJDsk8kqG9ZoJRZNpKRFGxYgrgpT/juI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TRgE203QCW5EoRrR4H3Q4rRoC+4v0kCJeOF2QQt4Au/urrjl9iSWGU2eKMaasBONGesxSJUi7s5yjiYKfdPfKRUp9fPbSrDXj3L5JsLwUirNpHAJ9qGAKMwxFdPjBc6H3YnNINxRQtcCSgsLH0i7eee5GaHGRE0huM83i0PQ26A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZTIuq7l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708614360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/g3EhhfkwV+ucAnH60NhMP9M6t2hq0UZAW1GW7z7sHY=;
	b=UZTIuq7l/cc5h1vEiuNPuIDj3QEXtPfDTna6rGHl1vTCmOY+X6rWeTzxz7XG3SETjaXepm
	IgBU3KE3ZlvZK0Jj/eoqBcfoPD3kZkBjtdrIYtdk7CjVEPvDNk0Pw35N029rml5XjEI7Uz
	897VwfQKUAd+dl0zm5O0vlgCm7QYpxw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-CHC9rYMrPeCQuXkqIvx8EQ-1; Thu, 22 Feb 2024 10:05:57 -0500
X-MC-Unique: CHC9rYMrPeCQuXkqIvx8EQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78064185A783;
	Thu, 22 Feb 2024 15:05:56 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D5B2C111D3D9;
	Thu, 22 Feb 2024 15:05:55 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	George Stark <gnstark@salutedevices.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/4] locking/mutex: Clean up mutex.h
Date: Thu, 22 Feb 2024 10:05:38 -0500
Message-Id: <20240222150540.79981-3-longman@redhat.com>
In-Reply-To: <20240222150540.79981-1-longman@redhat.com>
References: <20240222150540.79981-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

CONFIG_DEBUG_MUTEXES and CONFIG_PREEMPT_RT are mutually exclusive. They
can't be both set at the same time.  Move up the mutex_destroy() function
declaration and the __DEBUG_MUTEX_INITIALIZER() macro above the "#ifndef
CONFIG_PREEMPT_RT" section to eliminate duplicated mutex_destroy()
declaration.

Also remove the duplicated mutex_trylock() function declaration in the
CONFIG_PREEMPT_RT section.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/mutex.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 7e208d46ba5b..67edc4ca2bee 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -32,11 +32,9 @@
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)
 #endif
 
-#ifndef CONFIG_PREEMPT_RT
-
 #ifdef CONFIG_DEBUG_MUTEXES
 
-#define __DEBUG_MUTEX_INITIALIZER(lockname)				\
+# define __DEBUG_MUTEX_INITIALIZER(lockname)				\
 	, .magic = &lockname
 
 extern void mutex_destroy(struct mutex *lock);
@@ -49,6 +47,7 @@ static inline void mutex_destroy(struct mutex *lock) {}
 
 #endif
 
+#ifndef CONFIG_PREEMPT_RT
 /**
  * mutex_init - initialize the mutex
  * @mutex: the mutex to be initialized
@@ -101,9 +100,6 @@ extern bool mutex_is_locked(struct mutex *lock);
 
 extern void __mutex_rt_init(struct mutex *lock, const char *name,
 			    struct lock_class_key *key);
-extern int mutex_trylock(struct mutex *lock);
-
-static inline void mutex_destroy(struct mutex *lock) { }
 
 #define mutex_is_locked(l)	rt_mutex_base_is_locked(&(l)->rtmutex)
 
-- 
2.39.3


