Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB0A80349F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjLDNZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344427AbjLDNYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:24:21 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712781713
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:24:15 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b35199f94so99485e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701696254; x=1702301054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aE8zXsPfBda9t8ARvJASQplTCIl3JgGGRAv+RnvEkNI=;
        b=dkCiX5j4VedIXUGMPgFjNzqzaalfuq4+dGeNs0z3vnA+C/+bW2NpQvD8tFSWTu1NeJ
         t0wJlPFrnGXT0EudcEaHQ/t6i3Sxko396VSUZewhG0GZF3/l9isn8tKe7zbMyE28dWGc
         5Nfdv2oIbiYxuLcfRyQLrd4hM6NHehQcXHlr9RHeftpWgEqfu6daIHp66s6gUTp5kmer
         O6OFeDXwVsU27ijrDZRsTUGjwGnUSIS/w8ENzMCOX0slxJu6G5POw2ohtHjgOvApRCle
         1R9YzhkvFDWM43bABTAf1+Nutsnev3mz0mQldhxRKnHXbrO7aqS6blUac8ZixlYeSUTX
         dWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701696254; x=1702301054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aE8zXsPfBda9t8ARvJASQplTCIl3JgGGRAv+RnvEkNI=;
        b=GScsipQl46txKVUOMGuAKveaoIss5xNpzdPW3cJRTE+cXAZwIgJx25deoQrWHzsSLE
         GV6qKIAXP3AZJgz/UYmu1MbrEbvVMQo3Xgtb4FTArrBIvmq1PPbCKSfS1r9Jq3K/gdWT
         qz+VfbZtkzI2W3aJJ77q0jRT/+minUzBgQblH01MO72ZcYcdlAxboF/rRg1xKVMWzUb5
         UVIWNdy9XfgamnVPIQk8CgrOW5BM7N3N736M66/oTRjykSUCuiEDzJElAzXPpvUhaB9S
         kIf/tzV+U/fb3UIdeEB9fDt1j8QziENG+DLsPLRO30ISoiB229nOyZn9Xyyj2nqGs9ft
         tqTg==
X-Gm-Message-State: AOJu0Ywircm5kzSlUbnaNw+opdC+n8DAaSzGHYWnyfELCKlh2g0jHoIy
        /CI4jWmonrVTo2+tz4Il6M2alw==
X-Google-Smtp-Source: AGHT+IH9XzaYksJqzJRCX12xbqyt+Twm7u0zddxPx/ttC/Kkf/x5zHAraqiUQ4yPErN9a6weoWuFRg==
X-Received: by 2002:a05:600c:3b89:b0:40c:7a3:920c with SMTP id n9-20020a05600c3b8900b0040c07a3920cmr110686wms.0.1701696253655;
        Mon, 04 Dec 2023 05:24:13 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:abeb:af3b:74a8:840a])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c4e8f00b0040b3632e993sm18666907wmq.46.2023.12.04.05.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:24:11 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Laight <David.Laight@aculab.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v3] locking: Document that some lock types must stay alive during unlock
Date:   Mon,  4 Dec 2023 14:22:59 +0100
Message-ID: <20231204132259.112152-1-jannh@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen several cases of attempts to use mutex_unlock() to release an
object such that the object can then be freed by another task.

This is not safe because mutex_unlock(), in the
MUTEX_FLAG_WAITERS && !MUTEX_FLAG_HANDOFF case, accesses the mutex
structure after having marked it as unlocked; so mutex_unlock() requires
its caller to ensure that the mutex stays alive until mutex_unlock()
returns.

If MUTEX_FLAG_WAITERS is set and there are real waiters, those waiters
have to keep the mutex alive, but we could have a spurious
MUTEX_FLAG_WAITERS left if an interruptible/killable waiter bailed
between the points where __mutex_unlock_slowpath() did the cmpxchg
reading the flags and where it acquired the wait_lock.

( With spinlocks, that kind of code pattern is allowed and, from what I
  remember, used in several places in the kernel. )

Document this, such a semantic difference between mutexes and spinlocks
is fairly unintuitive. Based on feedback on the list, this should be
documented as a general locking caveat, not as a mutex-specific thing.

(changelog with some input from mingo)

Signed-off-by: Jann Horn <jannh@google.com>
---
Based on feedback on the list, I've gotten rid of the confusing
"atomic" wording.
Also, based on Peter Zijlstra's feedback that this more of a general
thing with sleeping locks and not specific to mutexes, I have rewritten
the patch to have some central documentation on the caveat in
Documentation/locking/locktypes.rst, and then just sprinkle some
references to that in a few other places.

I saw that the first version of this patch already landed in tip tree;
can you still yank that back out of the tree? If not, maybe revert that
for now, and then later land this new version (or a future revision of
it) once we've figured out if the new wording is good?


 Documentation/locking/locktypes.rst    | 23 +++++++++++++++++++++++
 Documentation/locking/mutex-design.rst |  2 ++
 kernel/locking/mutex.c                 |  5 +++++
 kernel/locking/rwsem.c                 | 10 ++++++++++
 4 files changed, 40 insertions(+)

diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
index 80c914f6eae7..c9a4bcc967ea 100644
--- a/Documentation/locking/locktypes.rst
+++ b/Documentation/locking/locktypes.rst
@@ -95,6 +95,29 @@ rw_semaphores have a special interface which allows non-owner release for
 readers.
 
 
+Releasing and freeing
+=====================
+For some lock types, such as spinlocks, the lock release operation is designed
+to allow another concurrent task to free the lock as soon as the lock has been
+released - in other words, similarly to refcounts, the unlock operation will not
+access the lock object anymore after marking it as unlocked.
+
+This behavior is guaranteed for:
+
+ - spinlock_t (including in PREEMPT_RT kernels, where spinlock_t is
+   implemented as an rtmutex)
+
+There are other lock types where the lock release operation makes no such
+guarantee and the caller must ensure that the lock is not destroyed before the
+unlock operation has returned.
+Most sleeping locks are in this category.
+
+This is the case in particular for (not an exhaustive list):
+
+ - mutex
+ - rw_semaphore
+
+
 rtmutex
 =======
 
diff --git a/Documentation/locking/mutex-design.rst b/Documentation/locking/mutex-design.rst
index 78540cd7f54b..bbb4c4d56ed0 100644
--- a/Documentation/locking/mutex-design.rst
+++ b/Documentation/locking/mutex-design.rst
@@ -101,6 +101,8 @@ features that make lock debugging easier and faster:
     - Detects multi-task circular deadlocks and prints out all affected
       locks and tasks (and only those tasks).
 
+The mutex user must ensure that the mutex is not destroyed while a unlock
+operation is still in progress, see Documentation/locking/locktypes.rst.
 
 Interfaces
 ----------
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 2deeeca3e71b..fa4834dba407 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -532,6 +532,11 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
  * This function must not be used in interrupt context. Unlocking
  * of a not locked mutex is not allowed.
  *
+ * The caller must ensure that the mutex stays alive until this function has
+ * returned - mutex_unlock() can NOT directly be used to release an object such
+ * that another concurrent task can free it.
+ * See Documentation/locking/locktypes.rst.
+ *
  * This function is similar to (but not equivalent to) up().
  */
 void __sched mutex_unlock(struct mutex *lock)
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 2340b6d90ec6..cbc00a269deb 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1615,6 +1615,11 @@ EXPORT_SYMBOL(down_write_trylock);
 
 /*
  * release a read lock
+ *
+ * The caller must ensure that the rw_semaphore stays alive until this function
+ * has returned - up_read() can NOT directly be used to release an object such
+ * that another concurrent task can free it.
+ * See Documentation/locking/locktypes.rst.
  */
 void up_read(struct rw_semaphore *sem)
 {
@@ -1625,6 +1630,11 @@ EXPORT_SYMBOL(up_read);
 
 /*
  * release a write lock
+ *
+ * The caller must ensure that the rw_semaphore stays alive until this function
+ * has returned - up_write() can NOT directly be used to release an object such
+ * that another concurrent task can free it.
+ * See Documentation/locking/locktypes.rst.
  */
 void up_write(struct rw_semaphore *sem)
 {

base-commit: 3b47bc037bd44f142ac09848e8d3ecccc726be99
-- 
2.43.0.rc2.451.g8631bc7472-goog

