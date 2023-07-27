Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D4F765BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjG0TLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjG0TLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:11:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E219272C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:10:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-267f870e6ffso814219a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690485051; x=1691089851;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPWrH1ydAmFa/cYT+qF6NSiBlttgrD65D/tbBsSlPUQ=;
        b=EEA4WGXGuYjLjqCubQ6wDyGGlPv4L3GPQHjuBYpA3BUxwACRWUNkMMd+Nqv7cE1EDu
         XH2XN4jqrSNTr4LxyAGXOSxUBMHgxO0zCj8OV8nsOAVoArLUEc7p1bplxZPgD2d0MYjG
         BemY7EtkBIXsG33dUkGzHBqIXNgO5MHyke+jo+zHBvQ9rqlxJbLSOZghG1AnDrcPDCzD
         aQDHKLDggon6WNkOSZz06oX0CW8ObETZEvkzPfbJhIwWYUfgyGb59C2CdjE0cefTqxWk
         XgeIynwSYXEym4ud4/osIiyRYDkRpAGHe1ip10UNSEPpYWx7ixniYdrHVEIYcGoMFU0v
         aFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690485051; x=1691089851;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPWrH1ydAmFa/cYT+qF6NSiBlttgrD65D/tbBsSlPUQ=;
        b=XPk+E9izG0j/2XiDI55FHkj4vSpDdqu9spFzzS5Oi/SR7NKjquM3OwMvghPCm8wGOG
         /pdgWCKDUN6PMnVqIp+0/qVBl88ZGSMcBqCYOqudtneTSvwNDBl6WG0g3FqWvzsVf1xc
         rTqqBc3SKRQEdkaExvXhZ1utA9uGWVMHFY8QHxRMK00K7Uyeb6AqahzGECMm1KosiwOJ
         RLkVO5HgX6qqKw1BHllu+1ObmrBbteSIWXuZyo/MAU4D0If99dWSsII5fyvaPFR49zaB
         bQPuKkheEk0nmg/yEsplBKvWlBk/C4SYBXKg2glVjjutvRjsVxcrDhN+FH8IMZYVoURg
         nzTA==
X-Gm-Message-State: ABy/qLZvyK2yL7Zw1YLPAn4jF8toLOtNmMX91S4nOnvlNoMARhHN/Rxe
        LuevySxPyNa69lMkquWYZ+g=
X-Google-Smtp-Source: APBJJlGVuvIIqVZP9UEei0KX2pxTSaM/ZK6kF33gqyvkrnGp4nITFFEESRsqQ6l9Ia1GafvZ0hfjCg==
X-Received: by 2002:a17:90a:889:b0:262:d7db:2520 with SMTP id v9-20020a17090a088900b00262d7db2520mr192290pjc.26.1690485051042;
        Thu, 27 Jul 2023 12:10:51 -0700 (PDT)
Received: from smtpclient.apple (c-73-162-233-46.hsd1.ca.comcast.net. [73.162.233.46])
        by smtp.gmail.com with ESMTPSA id 7-20020a17090a034700b0026852d886fcsm3312070pjf.36.2023.07.27.12.10.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jul 2023 12:10:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH 0/2] fix vma->anon_vma check for per-VMA locking; fix
 anon_vma memory ordering
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20230727145747.GB19940@willie-the-truck>
Date:   Thu, 27 Jul 2023 12:05:53 -0700
Cc:     Jann Horn <jannh@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8EA729DD-F1CE-4C6F-A074-147A6A1BBCE0@gmail.com>
References: <20230726214103.3261108-1-jannh@google.com>
 <31df93bd-4862-432c-8135-5595ffd2bd43@paulmck-laptop>
 <CAG48ez1fDzHzdD8YHEK-9D=7YcsR7Bp-FHCr25x13aqXpz7UnQ@mail.gmail.com>
 <20230727145747.GB19940@willie-the-truck>
To:     Will Deacon <will@kernel.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 27, 2023, at 7:57 AM, Will Deacon <will@kernel.org> wrote:
>=20
> On Thu, Jul 27, 2023 at 04:39:34PM +0200, Jann Horn wrote:
>> On Thu, Jul 27, 2023 at 1:19=E2=80=AFAM Paul E. McKenney =
<paulmck@kernel.org> wrote:
>>>=20
>>> On Wed, Jul 26, 2023 at 11:41:01PM +0200, Jann Horn wrote:
>>>> Hi!
>>>>=20
>>>> Patch 1 here is a straightforward fix for a race in per-VMA locking =
code
>>>> that can lead to use-after-free; I hope we can get this one into
>>>> mainline and stable quickly.
>>>>=20
>>>> Patch 2 is a fix for what I believe is a longstanding memory =
ordering
>>>> issue in how vma->anon_vma is used across the MM subsystem; I =
expect
>>>> that this one will have to go through a few iterations of review =
and
>>>> potentially rewrites, because memory ordering is tricky.
>>>> (If someone else wants to take over patch 2, I would be very =
happy.)
>>>>=20
>>>> These patches don't really belong together all that much, I'm just
>>>> sending them as a series because they'd otherwise conflict.
>>>>=20
>>>> I am CCing:
>>>>=20
>>>> - Suren because patch 1 touches his code
>>>> - Matthew Wilcox because he is also currently working on per-VMA
>>>>   locking stuff
>>>> - all the maintainers/reviewers for the Kernel Memory Consistency =
Model
>>>>   so they can help figure out the READ_ONCE() vs smp_load_acquire()
>>>>   thing
>>>=20
>>> READ_ONCE() has weaker ordering properties than smp_load_acquire().
>>>=20
>>> For example, given a pointer gp:
>>>=20
>>>        p =3D whichever(gp);
>>>        a =3D 1;
>>>        r1 =3D p->b;
>>>        if ((uintptr_t)p & 0x1)
>>>                WRITE_ONCE(b, 1);
>>>        WRITE_ONCE(c, 1);
>>>=20
>>> Leaving aside the "&" needed by smp_load_acquire(), if "whichever" =
is
>>> "READ_ONCE", then the load from p->b and the WRITE_ONCE() to "b" are
>>> ordered after the load from gp (the former due to an address =
dependency
>>> and the latter due to a (fragile) control dependency).  The compiler
>>> is within its rights to reorder the store to "a" to precede the load
>>> from gp.  The compiler is forbidden from reordering the store to "c"
>>> wtih the load from gp (because both are volatile accesses), but the =
CPU
>>> is completely within its rights to do this reordering.
>>>=20
>>> But if "whichever" is "smp_load_acquire()", all four of the =
subsequent
>>> memory accesses are ordered after the load from gp.
>>>=20
>>> Similarly, for WRITE_ONCE() and smp_store_release():
>>>=20
>>>        p =3D READ_ONCE(gp);
>>>        r1 =3D READ_ONCE(gi);
>>>        r2 =3D READ_ONCE(gj);
>>>        a =3D 1;
>>>        WRITE_ONCE(b, 1);
>>>        if (r1 & 0x1)
>>>                whichever(p->q, r2);
>>>=20
>>> Again leaving aside the "&" needed by smp_store_release(), if =
"whichever"
>>> is WRITE_ONCE(), then the load from gp, the load from gi, and the =
load
>>> from gj are all ordered before the store to p->q (by address =
dependency,
>>> control dependency, and data dependency, respectively).  The store =
to "a"
>>> can be reordered with the store to p->q by the compiler.  The store =
to
>>> "b" cannot be reordered with the store to p->q by the compiler =
(again,
>>> both are volatile), but the CPU is free to reorder them, especially =
when
>>> whichever() is implemented as a conditional store.
>>>=20
>>> But if "whichever" is "smp_store_release()", all five of the earlier
>>> memory accesses are ordered before the store to p->q.
>>>=20
>>> Does that help, or am I missing the point of your question?
>>=20
>> My main question is how permissible/ugly you think the following use
>> of READ_ONCE() would be, and whether you think it ought to be an
>> smp_load_acquire() instead.
>>=20
>> Assume that we are holding some kind of lock that ensures that the
>> only possible concurrent update to "vma->anon_vma" is that it changes
>> from a NULL pointer to a non-NULL pointer (using =
smp_store_release()).
>>=20
>>=20
>> if (READ_ONCE(vma->anon_vma) !=3D NULL) {
>>  // we now know that vma->anon_vma cannot change anymore
>>=20
>>  // access the same memory location again with a plain load
>>  struct anon_vma *a =3D vma->anon_vma;
>>=20
>>  // this needs to be address-dependency-ordered against one of
>>  // the loads from vma->anon_vma
>>  struct anon_vma *root =3D a->root;
>> }
>>=20
>>=20
>> Is this fine? If it is not fine just because the compiler might
>> reorder the plain load of vma->anon_vma before the READ_ONCE() load,
>> would it be fine after adding a barrier() directly after the
>> READ_ONCE()?
>=20
> I'm _very_ wary of mixing READ_ONCE() and plain loads to the same =
variable,
> as I've run into cases where you have sequences such as:
>=20
> // Assume *ptr is initially 0 and somebody else writes it to 1
> // concurrently
>=20
> foo =3D *ptr;
> bar =3D READ_ONCE(*ptr);
> baz =3D *ptr;
>=20
> and you can get foo =3D=3D baz =3D=3D 0 but bar =3D=3D 1 because the =
compiler only
> ends up reading from memory twice.
>=20
> That was the root cause behind f069faba6887 ("arm64: mm: Use READ_ONCE
> when dereferencing pointer to pte table"), which was very unpleasant =
to
> debug.

Interesting. I wonder if you considered adding to READ_ONCE() something
like:

	asm volatile("" : "+g" (x) );

So later loads (such as baz =3D *ptr) would reload the updated value.

