Return-Path: <linux-kernel+bounces-76745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D34885FBDB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44DAA288403
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B7514E2CA;
	Thu, 22 Feb 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HI7DptFb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC4B14AD11
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614364; cv=none; b=LV2VKvmMXmWGffj4KcPO4hiaZAjCm9bsFBm3czk19hu2UZFmnw0JHXvkxQXeYfBa9N8Ra9wlmnLqNnbNS3jx4CfF+nmwsCHw60z6VBmCECPq7e/JkdqZqtSVYLM0eI1JkimKyrZezbaDfsNCs8qDWa0NyDUZS9qyRvgeSPa5LPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614364; c=relaxed/simple;
	bh=jmNJZxpioD2ev6CzuLGJoXoioGPNxz85LSb8buJEQ6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MUhpMv4YzdUugyVTBBiqYcC5B+AGpPFSvixG1bb683Ij3YkBla+88hSUggAfS0LYSMSEmk0Kro9exaDN171VwhTs42P4HX3n3PU0hw8rH1bgxK/omjb/jmhKgDgmN4AzujVWtOmkM2GP0wyt6Q+SzVRPUtlapYGUzP760DqBbWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HI7DptFb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708614360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FbM+mRMvNwlvXjAUfTOnQe38QADdr2GSal9VUe0AgiQ=;
	b=HI7DptFb+ethCiHlrmhJksYHq/H9qn/NttII1VOipXpW1FppMVFX9Zr4z3s/NFfFtnNE1J
	LxIn/v3XNzz+zvO6/5EbyHEnqMLalMmgIOhydCu0P/V0K/gq9LfiKiyEdgilZ1YQLFCQ5C
	GOz8AGDoVtZOtJHncv5EB8Y/LacY06I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-Em10oE56NmmLMvffq-YPhw-1; Thu, 22 Feb 2024 10:05:58 -0500
X-MC-Unique: Em10oE56NmmLMvffq-YPhw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C1D785A58A;
	Thu, 22 Feb 2024 15:05:57 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 87B5B112131D;
	Thu, 22 Feb 2024 15:05:56 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	George Stark <gnstark@salutedevices.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 3/4] locking/rwsem: Clarify that RWSEM_READER_OWNED is just a hint
Date: Thu, 22 Feb 2024 10:05:39 -0500
Message-Id: <20240222150540.79981-4-longman@redhat.com>
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

Clarify in the comments that the RWSEM_READER_OWNED bit in the owner
field is just a hint, not an authoritative state of the rwsem.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
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


