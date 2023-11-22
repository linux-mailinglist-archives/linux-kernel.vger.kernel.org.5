Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFE87F5504
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344386AbjKVXvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344205AbjKVXv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:51:28 -0500
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF511B6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:51:23 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700697081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U3IFgiJgqfQEqTP3mY1EDkfwuWXxEWC3LQrFnM6wwG0=;
        b=o+FIqXusREjfbStC1cNUHTsWvY9kFGJ16jE6s+U1SnGpS1KURukjbI2UyEFeeraRy/pgjh
        kqpIZ3pw+weMnTvISUdoAnJarPlTvRJUXuI4H/CIwl/ypcvB8sloCqYyRFOTjIY2bWc+vL
        aqKGCQ7JkfTgLU58QnyE4VAf/eGizvg=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        peterz@infradead.org
Cc:     boqun.feng@gmail.com, longman@redhat.com, will@kernel.org,
        mingo@redhat.com, Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 1/6] locking/lockdep: lock_class_is_held()
Date:   Wed, 22 Nov 2023 18:51:08 -0500
Message-ID: <20231122235113.180132-2-kent.overstreet@linux.dev>
In-Reply-To: <20231122235113.180132-1-kent.overstreet@linux.dev>
References: <20231122235113.180132-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds lock_class_is_held(), which can be used to assert that a
particular type of lock is not held.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/lockdep.h  |  4 ++++
 kernel/locking/lockdep.c | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index dc2844b071c2..fc86557d2a21 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -344,6 +344,8 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 #define lockdep_repin_lock(l,c)	lock_repin_lock(&(l)->dep_map, (c))
 #define lockdep_unpin_lock(l,c)	lock_unpin_lock(&(l)->dep_map, (c))
 
+int lock_class_is_held(struct lock_class_key *key);
+
 /*
  * Must use lock_map_aquire_try() with override maps to avoid
  * lockdep thinking they participate in the block chain.
@@ -442,6 +444,8 @@ extern int lockdep_is_held(const void *);
 #define lockdep_repin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
 #define lockdep_unpin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
 
+static inline int lock_class_is_held(struct lock_class_key *key) { return 0; }
+
 #define DEFINE_WAIT_OVERRIDE_MAP(_name, _wait_type)	\
 	struct lockdep_map __maybe_unused _name = {}
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e85b5ad3e206..38924d90da85 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6599,6 +6599,26 @@ void debug_check_no_locks_held(void)
 }
 EXPORT_SYMBOL_GPL(debug_check_no_locks_held);
 
+#ifdef CONFIG_LOCKDEP
+int lock_class_is_held(struct lock_class_key *key)
+{
+	struct task_struct *curr = current;
+	struct held_lock *hlock;
+
+	if (unlikely(!debug_locks))
+		return 0;
+
+	for (hlock = curr->held_locks;
+	     hlock < curr->held_locks + curr->lockdep_depth;
+	     hlock++)
+		if (hlock->instance->key == key)
+			return 1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lock_class_is_held);
+#endif
+
 #ifdef __KERNEL__
 void debug_show_all_locks(void)
 {
-- 
2.42.0

