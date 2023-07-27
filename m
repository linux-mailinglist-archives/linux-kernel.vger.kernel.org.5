Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649BC7658D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjG0QfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjG0Qe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:34:59 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A4F30E4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:34:57 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-63cf6b21035so8011846d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690475697; x=1691080497;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4M64aY7MND+8kDvfr6Jb21UTiBjsxTrzrXa+kPuKjOA=;
        b=NKjR/jzXrciTrHWs+gbG+F/LXw0U2qRdVICRdk+g4TorVApf+fFL4P9OILdu4Ic+xS
         ORpnriHemCmM/YUb3R57wPcwg+cC5XRoLTyka8D21DSFSjgl7mIXGIWM7HEhcvEUKpCa
         RsTGJY2cODFPuqXBW9rWW8oocpDJXlIUH1tTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690475697; x=1691080497;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4M64aY7MND+8kDvfr6Jb21UTiBjsxTrzrXa+kPuKjOA=;
        b=XRGYNA1Kwt80knjNKTZOE7coDHSYjOJMeW7jMfjq2FBF2Aw/b8huoBxqMx2w0nJqED
         tMgjSoA4FxT1wjY2O/kZzLcGSH3mC/xTJWpI6Tmzenzb9zYBPFHsifJc8gyCSb3qZbMz
         zLBW+hf3Gu90ODOn3CaWQuca2Wbh7bwkLWB3BWtJyUT14aBBt7gdtr4RGW6SNVA6OeJs
         72a8TCl7PbRMQd2sGv58yWFe1fxGUdiyQ7q2GYBdFkIgX8M6LrStkR+Ztq0Jm8FkC7GA
         8lsv4a7ykFH9X6DVLOl6qHURH0Wzj6JN4q2ErCh6WFWn4pPDMgx5PRxmoUpRueERIqPD
         LwcQ==
X-Gm-Message-State: ABy/qLaq6fIWApk+702ExKFRD9TJsCU9/tbCsTsrzlBs1H6Gh9v5Rj7I
        suK3+j+z2CXLXBbhYiDx85MvZQ==
X-Google-Smtp-Source: APBJJlG91/oj6QegvwQKLIfS5Rof+hPwFf7cXXnHXMmRTnij/AVWdu6az0I4RX4y1XJYIQwAZRb96A==
X-Received: by 2002:a05:6214:448c:b0:63c:f3ed:d48e with SMTP id on12-20020a056214448c00b0063cf3edd48emr445315qvb.21.1690475696878;
        Thu, 27 Jul 2023 09:34:56 -0700 (PDT)
Received: from smtpclient.apple ([45.88.220.68])
        by smtp.gmail.com with ESMTPSA id f9-20020a0caa89000000b0063c7037f85fsm536501qvb.73.2023.07.27.09.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 09:34:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/2] fix vma->anon_vma check for per-VMA locking; fix anon_vma memory ordering
Message-Id: <BCDEA397-AA7A-4FDE-8046-C68625CDE166@joelfernandes.org>
Date:   Thu, 27 Jul 2023 12:34:44 -0400
Cc:     Jann Horn <jannh@google.com>, paulmck@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
To:     Will Deacon <will@kernel.org>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=EF=BB=BF


> On Jul 27, 2023, at 10:57 AM, Will Deacon <will@kernel.org> wrote:
> =EF=BB=BFOn Thu, Jul 27, 2023 at 04:39:34PM +0200, Jann Horn wrote:
>> On Thu, Jul 27, 2023 at 1:19=E2=80=AFAM Paul E. McKenney <paulmck@kernel.=
org> wrote:
>>> On Wed, Jul 26, 2023 at 11:41:01PM +0200, Jann Horn wrote:
>>>> Hi!
>>>> Patch 1 here is a straightforward fix for a race in per-VMA locking cod=
e
>>>> that can lead to use-after-free; I hope we can get this one into
>>>> mainline and stable quickly.
>>>> Patch 2 is a fix for what I believe is a longstanding memory ordering
>>>> issue in how vma->anon_vma is used across the MM subsystem; I expect
>>>> that this one will have to go through a few iterations of review and
>>>> potentially rewrites, because memory ordering is tricky.
>>>> (If someone else wants to take over patch 2, I would be very happy.)
>>>> These patches don't really belong together all that much, I'm just
>>>> sending them as a series because they'd otherwise conflict.
>>>> I am CCing:
>>>> - Suren because patch 1 touches his code
>>>> - Matthew Wilcox because he is also currently working on per-VMA
>>>>   locking stuff
>>>> - all the maintainers/reviewers for the Kernel Memory Consistency Model=

>>>>   so they can help figure out the READ_ONCE() vs smp_load_acquire()
>>>>   thing
>>> READ_ONCE() has weaker ordering properties than smp_load_acquire().
>>> For example, given a pointer gp:
>>>        p =3D whichever(gp);
>>>        a =3D 1;
>>>        r1 =3D p->b;
>>>        if ((uintptr_t)p & 0x1)
>>>                WRITE_ONCE(b, 1);
>>>        WRITE_ONCE(c, 1);
>>> Leaving aside the "&" needed by smp_load_acquire(), if "whichever" is
>>> "READ_ONCE", then the load from p->b and the WRITE_ONCE() to "b" are
>>> ordered after the load from gp (the former due to an address dependency
>>> and the latter due to a (fragile) control dependency).  The compiler
>>> is within its rights to reorder the store to "a" to precede the load
>>> from gp.  The compiler is forbidden from reordering the store to "c"
>>> wtih the load from gp (because both are volatile accesses), but the CPU
>>> is completely within its rights to do this reordering.
>>> But if "whichever" is "smp_load_acquire()", all four of the subsequent
>>> memory accesses are ordered after the load from gp.
>>> Similarly, for WRITE_ONCE() and smp_store_release():
>>>        p =3D READ_ONCE(gp);
>>>        r1 =3D READ_ONCE(gi);
>>>        r2 =3D READ_ONCE(gj);
>>>        a =3D 1;
>>>        WRITE_ONCE(b, 1);
>>>        if (r1 & 0x1)
>>>                whichever(p->q, r2);
>>> Again leaving aside the "&" needed by smp_store_release(), if "whichever=
"
>>> is WRITE_ONCE(), then the load from gp, the load from gi, and the load
>>> from gj are all ordered before the store to p->q (by address dependency,=

>>> control dependency, and data dependency, respectively).  The store to "a=
"
>>> can be reordered with the store to p->q by the compiler.  The store to
>>> "b" cannot be reordered with the store to p->q by the compiler (again,
>>> both are volatile), but the CPU is free to reorder them, especially when=

>>> whichever() is implemented as a conditional store.
>>> But if "whichever" is "smp_store_release()", all five of the earlier
>>> memory accesses are ordered before the store to p->q.
>>> Does that help, or am I missing the point of your question?
>>=20
>> My main question is how permissible/ugly you think the following use
>> of READ_ONCE() would be, and whether you think it ought to be an
>> smp_load_acquire() instead.
>>=20
>> Assume that we are holding some kind of lock that ensures that the
>> only possible concurrent update to "vma->anon_vma" is that it changes
>> from a NULL pointer to a non-NULL pointer (using smp_store_release()).
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
> I'm _very_ wary of mixing READ_ONCE() and plain loads to the same variable=
,
> as I've run into cases where you have sequences such as:
>=20
>    // Assume *ptr is initially 0 and somebody else writes it to 1
>    // concurrently
>=20
>    foo =3D *ptr;
>    bar =3D READ_ONCE(*ptr);
>    baz =3D *ptr;
>=20
> and you can get foo =3D=3D baz =3D=3D 0 but bar =3D=3D 1 because the compi=
ler only
> ends up reading from memory twice.
>=20
> That was the root cause behind f069faba6887 ("arm64: mm: Use READ_ONCE
> when dereferencing pointer to pte table"), which was very unpleasant to
> debug.

Will, Unless I am missing something fundamental, this case is different thou=
gh.
This case does not care about fewer reads. As long as the first read is vola=
tile, the subsequent loads (even plain)
should work fine, no?
I am not seeing how the compiler can screw that up, so please do enlighten :=
).

Also RCU read dereference does a similar pattern (as Alan also pointed).

Cheers,

- Joel

>=20
> Will
