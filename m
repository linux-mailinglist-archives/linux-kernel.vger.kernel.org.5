Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959BF800DD8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379291AbjLAPCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379274AbjLAPCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:02:08 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BB61707
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:02:14 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so11874a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701442933; x=1702047733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvS5+725FOUXFMMq/VbInwmdI+QK4gqPGaiLWv9jUGk=;
        b=dARl+zrXLvpcS/xiphPXSPqyZYY8eFofHIrNxUUHuKWtM4gEVnYvLSPTvefqumBeCK
         koAI8ZIFebWAJLLvnbPANIgQyXEwCGBRLWuMX0Wqr/S1UNIqYRARIDlVlGv89sm3XV+O
         NLkyvJPUllLlM/E22D3sGMcUaEGrLAUTXqnbYVq8lYnbRqr5efvnLxTTcJHHiuKIbi/k
         czu4HuZ6uTa2NSUdz+wx5rOl8xcoXQUsfBjae7GxRJO7Vbb2M1if884yIUcrscnhToDl
         8c8X4TTbFwSoaB/Dvqazo9UP5XWk276Rxxc3HEv3lMvXJ1/7nFX1a0ZaBlLdz23QDXOY
         fX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701442933; x=1702047733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvS5+725FOUXFMMq/VbInwmdI+QK4gqPGaiLWv9jUGk=;
        b=jyhJOgTNVdAnx1xo4oS+cQvJFLOtwnPGY241oA73861Pmd0CSbHZMwEdCaWYoWA4v/
         3RMS3YVYtyUZNxHSDOUzkXNTUO+aB/gPwfIJQHZjjVPTJftagSS9E8loCDtRB0k0nuP7
         HL8Sv1xVA+L3FdN4IJ+piuMXib5ngks/yzCSADKQbctx7bXnpkMn6uvs90icUuEcaH9w
         zcRWHNN22tQmN8YGZ9gjFBv3F89zBHyhEi2yvzggiYNeQfw7eKu03IeR92T955lStIUQ
         DkUMiTsq83m+xDUIemRwtCFrAVNhP77Oj90+NgZIvKjYDgCrPIyL93+ShelSLYfGte+U
         Sp2g==
X-Gm-Message-State: AOJu0YyZjf/Caukk2fXKIcKhOTQKbRoRADNRlm64a7BRS6YH8KLLmejX
        0nR760dluT8I5igUkLMwieMfzi86t83k61L66NnoAQ==
X-Google-Smtp-Source: AGHT+IEcpNgo7dBSakfutUBem768TAYVjsANcalSOjsejY24k/zMbSFp2qc2sPu4f40T4H7h6sqxFTAIE14G44xsqyo=
X-Received: by 2002:a50:9514:0:b0:544:e2b8:ba6a with SMTP id
 u20-20020a509514000000b00544e2b8ba6amr94399eda.3.1701442931362; Fri, 01 Dec
 2023 07:02:11 -0800 (PST)
MIME-Version: 1.0
References: <20231130204817.2031407-1-jannh@google.com> <06c05c8b-9a3b-4c04-b898-0f82e98da70f@redhat.com>
In-Reply-To: <06c05c8b-9a3b-4c04-b898-0f82e98da70f@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 1 Dec 2023 16:01:33 +0100
Message-ID: <CAG48ez1a=VuEWwPTjcXFAwCyt9bRH-WzAfw0uP-qVu83kdxkZw@mail.gmail.com>
Subject: Re: [PATCH] locking: Document that mutex_unlock() is non-atomic
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 1:33=E2=80=AFAM Waiman Long <longman@redhat.com> wro=
te:
> On 11/30/23 15:48, Jann Horn wrote:
> > I have seen several cases of attempts to use mutex_unlock() to release =
an
> > object such that the object can then be freed by another task.
> > My understanding is that this is not safe because mutex_unlock(), in th=
e
> > MUTEX_FLAG_WAITERS && !MUTEX_FLAG_HANDOFF case, accesses the mutex
> > structure after having marked it as unlocked; so mutex_unlock() require=
s
> > its caller to ensure that the mutex stays alive until mutex_unlock()
> > returns.
> >
> > If MUTEX_FLAG_WAITERS is set and there are real waiters, those waiters
> > have to keep the mutex alive, I think; but we could have a spurious
> > MUTEX_FLAG_WAITERS left if an interruptible/killable waiter bailed
> > between the points where __mutex_unlock_slowpath() did the cmpxchg
> > reading the flags and where it acquired the wait_lock.
> >
> > (With spinlocks, that kind of code pattern is allowed and, from what I
> > remember, used in several places in the kernel.)
> >
> > If my understanding of this is correct, we should probably document thi=
s -
> > I think such a semantic difference between mutexes and spinlocks is fai=
rly
> > unintuitive.
>
> Spinlocks are fair. So doing a lock/unlock sequence will make sure that
> all the previously waiting waiters are done with the lock. Para-virtual
> spinlocks, however, can be a bit unfair so doing a lock/unlock sequence
> may not be enough to guarantee there is no waiter. The same is true for
> mutex. Adding a spin_is_locked() or mutex_is_locked() check can make
> sure that all the waiters are gone.

I think this pattern anyway only works when you're only trying to wait
for the current holder of the lock, not tasks that are queued up on
the lock as waiters - so a task initially holds a stable reference to
some object, then acquires the object's lock, then drops the original
reference, and then later drops the lock.
You can see an example of such mutex usage (which is explicitly legal
with userspace POSIX mutexes, but is forbidden with kernel mutexes) at
the bottom of the POSIX manpage for pthread_mutex_destroy() at
<https://pubs.opengroup.org/onlinepubs/007904875/functions/pthread_mutex_de=
stroy.html>,
in the section "Destroying Mutexes".

(I think trying to wait for pending waiters before destroying a mutex
wouldn't make sense because if there can still be pending waiters,
there can almost always also be tasks that are about to _become_
pending waiters but that haven't called mutex_lock() yet.)
