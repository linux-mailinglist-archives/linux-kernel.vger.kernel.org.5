Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53315800840
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378273AbjLAKdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378239AbjLAKdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:33:18 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D983F1;
        Fri,  1 Dec 2023 02:33:24 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a00b01955acso289947266b.1;
        Fri, 01 Dec 2023 02:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701426802; x=1702031602; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FEjxeSnMiazDaio2kYq2DUQMa2zPWhBs8CiVIQTho9s=;
        b=MOtrLGn1sZu2BDFMZTJRMJ73ccOWFi5Fj5N6NMxsmtV2i0qLLrAYqhB7OUZnkoNrGx
         PbYho4cOv2xozYwY3OU1XF6DWNjU9lWe37PvP+ID317j0Kzr4mBAlYRXZSsX4C9qL2LK
         udIRJn5xd8L0bIQFUJDvrabWO45/URQp6uQUZqjKgSW42DRdwcQSbDeIibw/kUg7K1M2
         IWd4Hhjb/6bZzQN0x71Zjf0W7+HoFqF+gMh+SvFtbVArIT0gTdF48CjRn860dkcTKC5y
         nieVVPWxQmL+QZAYOU6jx5yfdeT3cpCwVjjIjbZpBhBK83uEpkM/OfELjuTZfR05GBDZ
         91Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701426802; x=1702031602;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FEjxeSnMiazDaio2kYq2DUQMa2zPWhBs8CiVIQTho9s=;
        b=Ib8aaUEb37qyOa8f3SMfQwg7eu72w4v/HOGT/NoEacJm2yuBrqquQm+cjt0hwBXYJA
         yKWmA+quR3C7XMgAnz/bT+HlahjZD3BRp2ENn5JbQgckIrb9ENXL+xn4/WRFvXkbXUvu
         TyLNxTpaeG3GK8KieD0eZPnxPsXiFk/xhk9OXFWVC3ICtfsbV5EiHp5TNyq1sxqmbAf8
         zdW25tfmqZFRpJtThc1cRqOOGOqY+QTbmdRZZWsJETDYKKxibd5/ZdwS3Q3lyS7i30+S
         HaO+G3BVO9csfb9DECICZbjhuEfoamqvqkcrVhONtLv5vkmjpA9Ost4JvANHMYPqd5SS
         Ih6w==
X-Gm-Message-State: AOJu0Yz0F7XCxmDovVdy0K9NCMxXvH4JmYQ4Sv+OA9VqXCvqOYU325Yz
        RfdSkKMi8SjNiF60u3gEvlw=
X-Google-Smtp-Source: AGHT+IElb/wg7ewXKWnpoQIbwkO9NKhynRUXTMFXs91XlcsWmU+je+BptByRXB6peJNWQg+YNlNDXg==
X-Received: by 2002:a17:906:1251:b0:a19:a19b:7899 with SMTP id u17-20020a170906125100b00a19a19b7899mr603500eja.92.1701426802540;
        Fri, 01 Dec 2023 02:33:22 -0800 (PST)
Received: from gmail.com (1F2EF126.nat.pool.telekom.hu. [31.46.241.38])
        by smtp.gmail.com with ESMTPSA id qx34-20020a170907b5a200b009fd727116b4sm327107ejc.129.2023.12.01.02.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 02:33:21 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 1 Dec 2023 11:33:19 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH -v2] locking/mutex: Document that mutex_unlock() is non-atomic
Message-ID: <ZWm2b+QGpOvzHjc1@gmail.com>
References: <20231130204817.2031407-1-jannh@google.com>
 <2f17a9a6-5781-43ef-a09b-f39310843fe6@redhat.com>
 <CAG48ez1oXW=4MfQ0A6tthud-cvDZUTA+VB=jzu-HxvWzbj+X0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1oXW=4MfQ0A6tthud-cvDZUTA+VB=jzu-HxvWzbj+X0g@mail.gmail.com>
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jann Horn <jannh@google.com> wrote:

> On Thu, Nov 30, 2023 at 10:53 PM Waiman Long <longman@redhat.com> wrote:
> > On 11/30/23 15:48, Jann Horn wrote:
> > > I have seen several cases of attempts to use mutex_unlock() to release an
> > > object such that the object can then be freed by another task.
> > > My understanding is that this is not safe because mutex_unlock(), in the
> > > MUTEX_FLAG_WAITERS && !MUTEX_FLAG_HANDOFF case, accesses the mutex
> > > structure after having marked it as unlocked; so mutex_unlock() requires
> > > its caller to ensure that the mutex stays alive until mutex_unlock()
> > > returns.
> > >
> > > If MUTEX_FLAG_WAITERS is set and there are real waiters, those waiters
> > > have to keep the mutex alive, I think; but we could have a spurious
> > > MUTEX_FLAG_WAITERS left if an interruptible/killable waiter bailed
> > > between the points where __mutex_unlock_slowpath() did the cmpxchg
> > > reading the flags and where it acquired the wait_lock.
> >
> > Could you clarify under what condition a concurrent task can decide to
> > free the object holding the mutex? Is it !mutex_is_locked() or after a
> > mutex_lock()/mutex_unlock sequence?
> 
> I mean a mutex_lock()+mutex_unlock() sequence.
> 
> > mutex_is_locked() will return true if the mutex has waiter even if it
> > is currently free.
> 
> I don't understand your point, and maybe I also don't understand what
> you mean by "free". Isn't mutex_is_locked() defined such that it only
> looks at whether a mutex has an owner, and doesn't look at the waiter
> list?

Yeah, mutex_is_locked() is not a sufficient check - and mutexes have no 
implicit refcount properties like spinlocks. Once you call a mutex API, you 
have to guarantee the lifetime of the object until the function returns.

I.e. entering a mutex_lock()-ed critical section cannot be used to 
guarantee that all mutex_unlock() instances have stopped using the mutex.
I agree that this is a bit unintuitive, and differs from spinlocks.

I've clarified all this a bit more in the final patch (added a 'fully' 
qualifier, etc.), and made the changelog more assertive - see the attached 
patch.

Thanks,

	Ingo

=======================>
From: Jann Horn <jannh@google.com>
Date: Thu, 30 Nov 2023 21:48:17 +0100
Subject: [PATCH] locking/mutex: Document that mutex_unlock() is non-atomic

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
index 78540cd7f54b..7572339b2f12 100644
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
index 2deeeca3e71b..cbae8c0b89ab 100644
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
