Return-Path: <linux-kernel+bounces-168330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E998BB6D2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5241F241F2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4025915A;
	Fri,  3 May 2024 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAzJeiXl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9724C57333
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714773683; cv=none; b=LKW8X/Md4/JZ9ZcfokOwWR/6qfubntKxcnD5r//BNsXdXf4h9vS8fPApQzBSf57eC4lkm2fWGxcro/UMZ9A1Z0yX4kDzDQygLhzaxfmtEAe7wtZ3/YaCjB71qvnjm3DO5UGpIiK0Po7MTK8S8Q28tSprmU9zDRuwiSrQsSRbP6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714773683; c=relaxed/simple;
	bh=pUxq7jUksP4Q+cMJXZOkqnA/K+QpYMgfwqOUdO4C2e0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D91a+pogRDj+qf+P1OzDMJHhq6N4elx5ELhDYA2v0X9cm2lF450oazHGc1ePDYwgIyisWkz7e2PbA2wgBnDvghv+0rNlCPCr88bigbqXCsrPysU/Q6S4/FjiZEjVmhb/CldQs46LXjC8JFmobzKRDPofbbf+56yUrxQOq3MtR6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HAzJeiXl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714773680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0sjv9T+egk2i7mbNVwnFuef2h+PLNLCnFrs/sJ5ral0=;
	b=HAzJeiXlLy2R/Clb4B2WvYd2TcvYdl/reDnVPcmDDNknteMF3Bo7oa63Ili4m8EfGHc4Oq
	807ZK25bce04BiPt6OBSLtAX1XVROanc6fA6wGia1u7xlIb7jddxcp3aZOptzVZzu+I9sJ
	ktmX7kax8q9guN73GI7HM5IOpx5y9xQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-48_ZKH75MNSAPskrKHvgoA-1; Fri,
 03 May 2024 18:01:17 -0400
X-MC-Unique: 48_ZKH75MNSAPskrKHvgoA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14C713C000B5;
	Fri,  3 May 2024 22:01:17 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.156])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 757C340C6CC0;
	Fri,  3 May 2024 22:01:16 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Vernon Lovejoy <vlovejoy@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/qspinlock: Save qspinlock owner CPU into mcs_spinlock
Date: Fri,  3 May 2024 17:59:18 -0400
Message-Id: <20240503215918.639519-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

When examining a contended spinlock in a crash dump, we can trace out the
list of lock waiter CPUs waiting for the lock by following the linked
list of mcs_spinlock structures. However, the actual owner of the lock
is not there making it hard to figure out who the current lock owner is.

Make it easier to figure out this information by saving the lock owner
CPU into the mcs_spinlock structure of new MCS lock owner, if available,
when acquiring the lock in the qspinlock slowpath. We can then follow
the linked list of mcs_spinlock structures to the end to get an encoded
CPU number of the lock owner, if set.

This owner information is still not available when the lock is acquired
directly in the fast path or in the pending code path. There is no easy
way around that.

The additional cost to get the current CPU number in the slowpath should
be minimal as it should be in a hot cacheline.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/mcs_spinlock.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index 85251d8771d9..ac0ed0a8f028 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -13,11 +13,17 @@
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
+	int locked; /* non-zero if lock acquired */
 	int count;  /* nesting count, see qspinlock.c */
 };
 
@@ -42,7 +48,7 @@ do {									\
  * unlocking.
  */
 #define arch_mcs_spin_unlock_contended(l)				\
-	smp_store_release((l), 1)
+	smp_store_release((l), MCS_LOCKED)
 #endif
 
 /*
-- 
2.39.3


