Return-Path: <linux-kernel+bounces-62902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD298527B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C281B1F236AB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D0610A1D;
	Tue, 13 Feb 2024 03:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0yr4g1C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F264AD4B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707794238; cv=none; b=SAxH0k2vbauNqyPds1GbOOgV0/RH0FNBXaTU2SlAsWLdkENV6He8MIF/2zhDe9s1JuCjfGEexzYq78lHxP4ai5LD7rMMTtvnJ2jv5KdC6nNrHgEbNpQwFpqRv3I4mBbSoUwohcspFFqxHK4ge64b6nSUy5VHE3oK0OnrswVf+EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707794238; c=relaxed/simple;
	bh=MANijGulv75x4C4ug9+yfGSrwL6bUaWQqE7f9b4Kc/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a/WYNMlMDscydc5bPs0ygMSofiHoBkhdlCjKHUzQec9ONZOnyQMx/PG4sqbyCOaiKGA7N4ME3HQ17OG15n2zB7zZFPky75s/MsEg899RSDmNG0+nM+F1heYBVLI+PcMaQ4uQsfDujMIcSR9ZyXvQ8q+rwql1svtA+X6HVydgcnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0yr4g1C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707794235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+mW6S3E9PxzlJ59KYM6a9lo9aW4LQzFCn0v6EM+0/M=;
	b=O0yr4g1Cc/HbKi184Bvb9E2ZhMF+HGOqMl9XDz8a2dSHx/SH1d6SOeFNEl1mWSM4/e4HAD
	LS7nVBckVw/Sxpg3YK1FN5sv89/DHu6JxW4UqX9RHcOiuoZtxu8UxDCkulzhHn5BWEXzly
	vRdEeotpUD/MiXLkP9ABBuiNJnXkRFw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-vH9Kdgq5OdyB4buqj1ei4A-1; Mon,
 12 Feb 2024 22:17:11 -0500
X-MC-Unique: vH9Kdgq5OdyB4buqj1ei4A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 958DA3C02744;
	Tue, 13 Feb 2024 03:17:10 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EB8A6AC17;
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
Subject: [PATCH 3/4] locking/rwsem: Clarify that RWSEM_READER_OWNED is just a hint
Date: Mon, 12 Feb 2024 22:16:55 -0500
Message-Id: <20240213031656.1375951-4-longman@redhat.com>
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

Clarify in the comments that the RWSEM_READER_OWNED bit in the owner
field is just a hint, not an authoritative state of the rwsem.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 2340b6d90ec6..c6d17aee4209 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -35,7 +35,7 @@
 /*
  * The least significant 2 bits of the owner value has the following
  * meanings when set.
- *  - Bit 0: RWSEM_READER_OWNED - The rwsem is owned by readers
+ *  - Bit 0: RWSEM_READER_OWNED - rwsem may be owned by readers (just a hint)
  *  - Bit 1: RWSEM_NONSPINNABLE - Cannot spin on a reader-owned lock
  *
  * When the rwsem is reader-owned and a spinning writer has timed out,
@@ -1002,8 +1002,8 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 
 	/*
 	 * To prevent a constant stream of readers from starving a sleeping
-	 * waiter, don't attempt optimistic lock stealing if the lock is
-	 * currently owned by readers.
+	 * writer, don't attempt optimistic lock stealing if the lock is
+	 * very likely owned by readers.
 	 */
 	if ((atomic_long_read(&sem->owner) & RWSEM_READER_OWNED) &&
 	    (rcnt > 1) && !(count & RWSEM_WRITER_LOCKED))
-- 
2.39.3


