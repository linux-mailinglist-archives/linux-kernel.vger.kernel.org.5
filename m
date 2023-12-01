Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D102C800FB6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjLAP6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjLAP6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:58:38 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC7C10DE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:58:43 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso11278a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701446322; x=1702051122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5r69d7flVI5ckkQOOgWcECH4o4ZC5eGRq35Be8p9mMM=;
        b=xlU0MnRRG5PmaJL1C914UZo1HGfMiW5MQQqmvWrn/S2crvb/6XpLnWZ5mM+zevQmiw
         RR3NNOX6shMLnSRyx+cI6bGMuXXisiA2vMxxxFjc9DGB6m/qnWhTGMltznU4eK8uiszw
         074JI/GQ1+xWE4ZZE94k2DG8GfAmruPEkoSTLdvZDvL5LL3QRYYBkleDRt7N5v5RovuV
         /Ts25bMugBqj+KmhvL5sh6ZH5pdzTEcINOsoKLfHBHZuhCYiaOTzokMjlEP8Rf6bR6N1
         HAuCjnd96S3eBPonfJLQc5mJjlttBKn2ivkN8pgQsnN2sdBU25JrarU7Aw4kSlzXiqr8
         Tv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701446322; x=1702051122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5r69d7flVI5ckkQOOgWcECH4o4ZC5eGRq35Be8p9mMM=;
        b=b9ioiEOLksPgiE2lHNdtVAB3R6bxtFIZhP7dQOldNbXu0qGvrvZdlK+02BGAsxPKtg
         KE5UBOvNdkOjMvdIlSZZbRMQyUZLFOYtbnCmD+TYNsMS5qJW/8kilm/qvIDM8bXHkqE5
         JORsV03a36PHNAvt9bGfcOL9wCniP0nXR53pc+tbJNhNsfwAEv2eqjo7C9aTtAo5sP4M
         SwVOmTpaysByREwCDGmBK0DsSrrx+1iDHle+vALEdcZSkbuMcXFMWnlAV5VZa9Mo94zX
         Z2hd2dhAAiPEVZK2P4EL6+mHR9KMo+D/pBa0S+v6HWdWMClrTGLE+wqArKMJHhbO97oM
         5t+A==
X-Gm-Message-State: AOJu0Ywl1U6werq9GTckR8Ssz8yJeEf+useLerAfVim4tEAtWEn6nJ9z
        tulI6SEFGhWtM+UisZRk+4XzedEelEG4+tbNqUquEQ==
X-Google-Smtp-Source: AGHT+IErdOk/QPmVt7v/u4AAj1bjWAZ/H5XkqJx3BSLyfjpo5aJ3cR04l78MS2Tzt65zXVO16nU9HGOny3ocRwcuaeM=
X-Received: by 2002:a50:9514:0:b0:544:e2b8:ba6a with SMTP id
 u20-20020a509514000000b00544e2b8ba6amr104854eda.3.1701446321806; Fri, 01 Dec
 2023 07:58:41 -0800 (PST)
MIME-Version: 1.0
References: <20231130204817.2031407-1-jannh@google.com> <20231201091007.GG3818@noisy.programming.kicks-ass.net>
In-Reply-To: <20231201091007.GG3818@noisy.programming.kicks-ass.net>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 1 Dec 2023 16:58:04 +0100
Message-ID: <CAG48ez3oqU+P7NJ3Lj1qVKuqgDDdNqsaXdQVR5KaRx5J+BJGJg@mail.gmail.com>
Subject: Re: [PATCH] locking: Document that mutex_unlock() is non-atomic
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 10:10=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> On Thu, Nov 30, 2023 at 09:48:17PM +0100, Jann Horn wrote:
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
> IIRC this is true of all sleeping locks, and I think completion was the
> explcicit exception here, but it's been a while.

In addition to completions, I think this also applies to up()? But I
don't know if that's intentionally supported or just an implementation
detail.

Is there some central place where this should be documented instead of
Documentation/locking/mutex-design.rst as a more general kernel
locking design thing? Maybe Documentation/locking/locktypes.rst?

I think it should also be documented on top of the relevant locking
function(s) though, since I don't think everyone who uses locking
functions necessarily reads the separate documentation files first.
Mutexes kind of stand out as the most common locking type, but I guess
to be consistent, we'd have to put the same comment on functions like
up_read() and up_write()? And maybe drop the "Mutexes are different
from spinlocks in this aspect" part?

(Sidenote: Someone pointed out to me that an additional source of
confusion could be that userspace POSIX mutexes support this usage
pattern.)

> > index 78540cd7f54b..087716bfa7b2 100644
> > --- a/Documentation/locking/mutex-design.rst
> > +++ b/Documentation/locking/mutex-design.rst
> > @@ -101,6 +101,12 @@ features that make lock debugging easier and faste=
r:
> >      - Detects multi-task circular deadlocks and prints out all affecte=
d
> >        locks and tasks (and only those tasks).
> >
> > +Releasing a mutex is not an atomic operation: Once a mutex release ope=
ration
>
> Well, it very much is an atomic store-release. That is, I object to your
> confusing use of atomic here :-)

I'd say it involves an atomic store-release, but the whole operation
is not atomic. :P

But yeah, I see how this is confusing wording, and I'm not
particularly attached to my specific choice of words.
