Return-Path: <linux-kernel+bounces-7717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B78481AC14
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDEF1F23D21
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7531C0F;
	Thu, 21 Dec 2023 01:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XN5NDvce"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C65A1843
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 01:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703121620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=05/gGXwu4G9G5CVMcyqF1teUWZJnFEE29xJF1dhhZkM=;
	b=XN5NDvceoqovRgrqtQYs4n2HxQMZ5uwf5BSO0L3QUHrZgIeYMwaAdkCEJDTG6KZ5qwkaIS
	PzgwpFvkgo5vALXlThmW+yHjO+7WyjJlZbGdB15U8p5mZblEsJ0xKkXrUYAYIsOQR77MnO
	juAFQX1yawmuQn2BzN+Mof/xyL/Xj9c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-91vIO2hwOo-TLWRpjIb-GQ-1; Wed,
 20 Dec 2023 20:20:17 -0500
X-MC-Unique: 91vIO2hwOo-TLWRpjIb-GQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 083021C18CC2;
	Thu, 21 Dec 2023 01:20:17 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.206])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DE3D21121306;
	Thu, 21 Dec 2023 01:20:15 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Zeng Heng <zengheng4@huawei.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/osq_lock: Minimize access to node->prev's cacheline
Date: Wed, 20 Dec 2023 20:19:53 -0500
Message-Id: <20231221011953.1611615-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

When CONFIG_PARAVIRT_SPINLOCKS is on, osq_lock() will spin on both
node's and node->prev's cachelines while waiting for its node->locked
value to be set.  That can cause cacheline contention with another
CPU modifying the node->prev's cacheline. The reason for accessing
node->prev's cacheline is to read the node->prev->cpu value as a
parameter value for the vcpu_is_preempted() call. However this value
is a constant as long as node->prev doesn't change.

Minimize that contention by caching the node->prev and node->prev->cpu
values and updating the cached values and accessing node->prev's
cacheline iff node->prev changes.

By running an osq_lock/unlock microbenchmark which repeatedly calls
osq_lock/unlock in a loop with 96 locking threads running on a 2-socket
96-CPU machine, the locking rates before and after this patch were:

  Before patch: 1701 kops/s
  After patch:  3052 kops/s
  % Change:     +79.4%

It can be seen that this patch enables a rather significant performance
boost to the OSQ lock.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/osq_lock.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index d5610ad52b92..6d7218f4b6e4 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -87,12 +87,29 @@ osq_wait_next(struct optimistic_spin_queue *lock,
 	return next;
 }
 
+#ifndef vcpu_is_preempted
+#define prev_vcpu_is_preempted(n, p, c)	false
+#else
+static inline bool prev_vcpu_is_preempted(struct optimistic_spin_node *node,
+					  struct optimistic_spin_node **pprev,
+					  int *ppvcpu)
+{
+	struct optimistic_spin_node *prev = READ_ONCE(node->prev);
+
+	if (prev != *pprev) {
+		*pprev = prev;
+		*ppvcpu = node_cpu(prev);
+	}
+	return vcpu_is_preempted(*ppvcpu);
+}
+#endif
+
 bool osq_lock(struct optimistic_spin_queue *lock)
 {
 	struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
 	struct optimistic_spin_node *prev, *next;
 	int curr = encode_cpu(smp_processor_id());
-	int old;
+	int old, pvcpu;
 
 	node->locked = 0;
 	node->next = NULL;
@@ -110,6 +127,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 
 	prev = decode_cpu(old);
 	node->prev = prev;
+	pvcpu = node_cpu(prev);
 
 	/*
 	 * osq_lock()			unqueue
@@ -141,7 +159,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	 * polling, be careful.
 	 */
 	if (smp_cond_load_relaxed(&node->locked, VAL || need_resched() ||
-				  vcpu_is_preempted(node_cpu(node->prev))))
+				  prev_vcpu_is_preempted(node, &prev, &pvcpu)))
 		return true;
 
 	/* unqueue */
-- 
2.39.3


