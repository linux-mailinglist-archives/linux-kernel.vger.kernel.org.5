Return-Path: <linux-kernel+bounces-168500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 599198BB94F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 04:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E816E1F22930
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEEBDDBD;
	Sat,  4 May 2024 02:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsBXRvFb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F890800
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 02:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714790487; cv=none; b=tlPyt9UDRDxBnfRORBcj7eguRbCP4/OpuqzoxOdDFffX36sEvqmKXMsaYcL0kHl3219bXxUYS8ov6LjNbo2UInohjb1CfRKMbiw+fG3yxtGTZyd+L6IlSZ3SSAetvRfPxCJxpgnpwqAqE4Z4Lw4UnhAm1FkZFUGMHuFqoEYMVrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714790487; c=relaxed/simple;
	bh=88aSH8UKZ+oL6fRMxDzNmWphr1Yok04vGnfaLMMXDWE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R4T9WnFVZaUDdI6gOiiv/JQpkflSSxs+gGIRM5r7xRviKrnJVyTbsmgDqax75iZrNyc36qdLQfri15KfEhjnl88VvFB3DYm10RPuYW1Yh6qwDVXp8423cFOXlzM9vmYB0GQnIBk1V+rI42ZJdcXs9ZBLnyUMmKpKva7/FaJ+4RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VsBXRvFb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714790484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Azdpb/tVe/GmjV0sQ+hMb85pe6gM1L0HYDRX17QqCkQ=;
	b=VsBXRvFbJcN4FMAnkWCIXOTHG0xJl6UgxKsYlOPeZ9OfKrgfOjaUMhFiZ4N+5g+pnmn4j1
	pNz25N/N02IW4mjR4WzZHoKaY4YblmHUELyoQxQ38GF4W/mllQ8vRx9nfHuzujur7RQ0AP
	JhXBKulCeYZYPeTHT7kHCpm9VvmrZps=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-iDoBQxZbMO-NKgQrCZv9nw-1; Fri,
 03 May 2024 22:41:20 -0400
X-MC-Unique: iDoBQxZbMO-NKgQrCZv9nw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16B941C07F20;
	Sat,  4 May 2024 02:41:20 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.156])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6A96B40C140B;
	Sat,  4 May 2024 02:41:19 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Vernon Lovejoy <vlovejoy@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] locking/qspinlock: Save previous node & owner CPU into mcs_spinlock
Date: Fri,  3 May 2024 22:41:06 -0400
Message-Id: <20240504024106.654319-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

When examining a contended spinlock in a crash dump, we can only find
out the tail CPU in the MCS wait queue. There is no simple way to find
out what other CPUs are waiting for the spinlock and which CPU is the
lock owner.

Make it easier to figure out these information by saving previous node
data into the mcs_spinlock structure. This will allow us to reconstruct
the MCS wait queue from tail to head. In order not to expand the size
of mcs_spinlock, the original count field is split into two 16-bit
chunks. The first chunk is for count and the second one is the new
prev_node value.

  bits 0-1 : qnode index
  bits 2-15: CPU number + 1

This prev_node value may be truncated if there are 16k or more CPUs in
the system.

The locked value in the queue head is also repurposed to hold an encoded
qspinlock owner CPU number when acquiring the lock in the qspinlock
slowpath of an contended lock.

This lock owner information will not be available when the lock is
acquired directly in the fast path or in the pending code path. There
is no easy way around that.

These changes should make analysis of a contended spinlock in a crash
dump easier.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/mcs_spinlock.h | 13 ++++++++++---
 kernel/locking/qspinlock.c    |  8 ++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index 85251d8771d9..cbe6f07dff2e 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -13,12 +13,19 @@
 #ifndef __LINUX_MCS_SPINLOCK_H
 #define __LINUX_MCS_SPINLOCK_H
 
+/*
+ * Save an encoded version of the current MCS lock owner CPU to the
+ * mcs_spinlock structure of the next lock owner.
+ */
+#define MCS_LOCKED	(smp_processor_id() + 1)
+
 #include <asm/mcs_spinlock.h>
 
 struct mcs_spinlock {
 	struct mcs_spinlock *next;
-	int locked; /* 1 if lock acquired */
-	int count;  /* nesting count, see qspinlock.c */
+	int locked;	 /* non-zero if lock acquired */
+	short count;	 /* nesting count, see qspinlock.c */
+	short prev_node; /* encoded previous node value */
 };
 
 #ifndef arch_mcs_spin_lock_contended
@@ -42,7 +49,7 @@ do {									\
  * unlocking.
  */
 #define arch_mcs_spin_unlock_contended(l)				\
-	smp_store_release((l), 1)
+	smp_store_release((l), MCS_LOCKED)
 #endif
 
 /*
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index ebe6b8ec7cb3..df78d13efa3d 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -436,6 +436,7 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 
 	node->locked = 0;
 	node->next = NULL;
+	node->prev_node = 0;
 	pv_init_node(node);
 
 	/*
@@ -463,6 +464,13 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	old = xchg_tail(lock, tail);
 	next = NULL;
 
+	/*
+	 * The prev_node value is saved for crash dump analysis purpose only,
+	 * it is not used within the qspinlock code. The encoded node value
+	 * may be truncated if there are 16k or more CPUs in the system.
+	 */
+	node->prev_node = old >> _Q_TAIL_IDX_OFFSET;
+
 	/*
 	 * if there was a previous node; link it and wait until reaching the
 	 * head of the waitqueue.
-- 
2.39.3


