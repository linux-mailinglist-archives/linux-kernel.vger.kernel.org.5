Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BB78008B4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378347AbjLAKoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378331AbjLAKoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:44:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86281D40;
        Fri,  1 Dec 2023 02:44:13 -0800 (PST)
Date:   Fri, 01 Dec 2023 10:44:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701427450;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qPCIzTyiZpaSnXIh/BvFIvvdQAACVmWB9mApE7JKoAs=;
        b=DvakLAApprtB0OyOTMY42r02WoLgRIQ/ta6o+V3Hwr+e8WxyucftkyCOtIs0dGreeHx/8C
        4VexC5Qo83qvFbep6hWE5pgnqtndnXwD1uqZfG9Ph89V1FeVymawKhzsdEtGi6fzxeXQF+
        9UH37eE3ClHq9iNqNxCIo0vWXWqk5GXRGnocuSzsZ6RWJEUXda7FsvH8qzMUfGARF/kAlM
        mvhgYWByQPu2xsFv9NdmJi9XK8V4p7GvkF/7ESHPf8TPLB7XuFamtobukk9kqlJ55Q5SxJ
        sCWVEHVSy1swB3tKJKXR5fr2mSZ+fhY1avsYNJoaFaRQ49fcs8tUGB4IFjGvgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701427450;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qPCIzTyiZpaSnXIh/BvFIvvdQAACVmWB9mApE7JKoAs=;
        b=F2lG/6euZHkXs93PwgAAg1+EU07oCX9oLV1x9G1eyAL//oYtb7ZABV7ZBBpl4zgjYNf22V
        DWU5rgKWWP/OIUAA==
From:   "tip-bot2 for Jann Horn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/mutex: Document that mutex_unlock() is non-atomic
Cc:     Jann Horn <jannh@google.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231130204817.2031407-1-jannh@google.com>
References: <20231130204817.2031407-1-jannh@google.com>
MIME-Version: 1.0
Message-ID: <170142744948.398.4203675877225809071.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a51749ab34d9e5dec548fe38ede7e01e8bb26454
Gitweb:        https://git.kernel.org/tip/a51749ab34d9e5dec548fe38ede7e01e8bb26454
Author:        Jann Horn <jannh@google.com>
AuthorDate:    Thu, 30 Nov 2023 21:48:17 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 01 Dec 2023 11:27:43 +01:00

locking/mutex: Document that mutex_unlock() is non-atomic

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
is fairly unintuitive.

[ mingo: Made the changelog a bit more assertive, refined the comments. ]

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231130204817.2031407-1-jannh@google.com
---
 Documentation/locking/mutex-design.rst | 6 ++++++
 kernel/locking/mutex.c                 | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/locking/mutex-design.rst b/Documentation/locking/mutex-design.rst
index 78540cd..7572339 100644
--- a/Documentation/locking/mutex-design.rst
+++ b/Documentation/locking/mutex-design.rst
@@ -101,6 +101,12 @@ features that make lock debugging easier and faster:
     - Detects multi-task circular deadlocks and prints out all affected
       locks and tasks (and only those tasks).
 
+Releasing a mutex is not an atomic operation: Once a mutex release operation
+has begun, another context may be able to acquire the mutex before the release
+operation has fully completed. The mutex user must ensure that the mutex is not
+destroyed while a release operation is still in progress - in other words,
+callers of mutex_unlock() must ensure that the mutex stays alive until
+mutex_unlock() has returned.
 
 Interfaces
 ----------
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 2deeeca..cbae8c0 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -532,6 +532,11 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
  * This function must not be used in interrupt context. Unlocking
  * of a not locked mutex is not allowed.
  *
+ * The caller must ensure that the mutex stays alive until this function has
+ * returned - mutex_unlock() can NOT directly be used to release an object such
+ * that another concurrent task can free it.
+ * Mutexes are different from spinlocks & refcounts in this aspect.
+ *
  * This function is similar to (but not equivalent to) up().
  */
 void __sched mutex_unlock(struct mutex *lock)
