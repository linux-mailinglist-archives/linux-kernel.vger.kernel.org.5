Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6D976769C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbjG1Tuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbjG1Tun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:50:43 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7CF44AF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 12:50:36 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76c9334baedso45988485a.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 12:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690573836; x=1691178636;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfuoRJxziujetUXDjXCxwtYvQyq/2gDI4Bjf+Iz8CZU=;
        b=w9PsARxXlJeqOq3BhxEJ/0Lm6kcbHuVvB0g2WVjpvdO+kcJefm0gzQhZNBGg32lQd1
         UPbcXCZJZvpN+MWOTvfjSLyyH13pkqcoVvZQdKT9UfrQHD9qEkAgVpnUeYg1cynohv4V
         n5m/7WmNaogHlDPWjlT8TjwRsbX6qbMeUGwjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690573836; x=1691178636;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfuoRJxziujetUXDjXCxwtYvQyq/2gDI4Bjf+Iz8CZU=;
        b=c/+DKr7frKDYhUwA5f4VrRg/UwuBoidX/vg0zwVZxTh3xeHJMr05G2L96uGWxXOhC+
         eKERDKT+pGqTMepZitbEt2veM5iqqYp2CFBRE419lIYjkRrXh2rldzSfL5+5Hpngz2Rt
         hZQyCdrmFXc9hZet8gm80CGOZwTBU+uovjCp0H9r/jBvJsBrP+NsL1EGAkTqokrqN0Km
         qAgEz67OiPTwgxjF5Qnwg8ZdhdYaBBxfFYWIvcEJ0bXA5j6uE+fHmVx0CP3JAsXGadmS
         +v7mEJp6P5GgdwhOTdbIz/Nihs8PivJaAdxIp2AoMWeJfpfj+kstEq+T6SK/PpvLDB3W
         DW0w==
X-Gm-Message-State: ABy/qLYUVfW3KqEwvuK6m7nt3oAnMkZNi6ysGcGxfTHlDfzgEScacLi6
        obUlvbhb97Pw/ilyJSSPYrOddw==
X-Google-Smtp-Source: APBJJlGEGOIBC9+BXrcGUfR9DpWYIGlZ0Tq86INiyBf1Z69+wd/dBeGdTpRCYnTMZSdhU4lLwV+gsw==
X-Received: by 2002:a05:622a:1790:b0:403:f45d:66d4 with SMTP id s16-20020a05622a179000b00403f45d66d4mr3092112qtk.68.1690573835630;
        Fri, 28 Jul 2023 12:50:35 -0700 (PDT)
Received: from smtpclient.apple ([45.85.144.224])
        by smtp.gmail.com with ESMTPSA id x1-20020ac87001000000b00402ed9adfa1sm1401114qtm.87.2023.07.28.12.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 12:50:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/2] fix vma->anon_vma check for per-VMA locking; fix anon_vma memory ordering
Date:   Fri, 28 Jul 2023 15:50:23 -0400
Message-Id: <A31BD1BD-FB53-4E5C-B8B7-44817D2BC322@joelfernandes.org>
References: <ca3706a4-3153-449e-bef0-56183a668d57@paulmck-laptop>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
In-Reply-To: <ca3706a4-3153-449e-bef0-56183a668d57@paulmck-laptop>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 28, 2023, at 2:18 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Fri, Jul 28, 2023 at 02:03:09PM -0400, Joel Fernandes wrote:
>>> On Fri, Jul 28, 2023 at 1:51=E2=80=AFPM Alan Stern <stern@rowland.harvar=
d.edu> wrote:
>>>=20
>>> On Fri, Jul 28, 2023 at 01:35:43PM -0400, Joel Fernandes wrote:
>>>> On Fri, Jul 28, 2023 at 8:44=E2=80=AFAM Will Deacon <will@kernel.org> w=
rote:
>>>>>=20
>>>>> On Thu, Jul 27, 2023 at 12:34:44PM -0400, Joel Fernandes wrote:
>>>>>>> On Jul 27, 2023, at 10:57 AM, Will Deacon <will@kernel.org> wrote:
>>>>>>> =EF=BB=BFOn Thu, Jul 27, 2023 at 04:39:34PM +0200, Jann Horn wrote:
>>>>>>>> if (READ_ONCE(vma->anon_vma) !=3D NULL) {
>>>>>>>> // we now know that vma->anon_vma cannot change anymore
>>>>>>>>=20
>>>>>>>> // access the same memory location again with a plain load
>>>>>>>> struct anon_vma *a =3D vma->anon_vma;
>>>>>>>>=20
>>>>>>>> // this needs to be address-dependency-ordered against one of
>>>>>>>> // the loads from vma->anon_vma
>>>>>>>> struct anon_vma *root =3D a->root;
>>>>>>>> }
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>> Is this fine? If it is not fine just because the compiler might
>>>>>>>> reorder the plain load of vma->anon_vma before the READ_ONCE() load=
,
>>>>>>>> would it be fine after adding a barrier() directly after the
>>>>>>>> READ_ONCE()?
>>>>>>>=20
>>>>>>> I'm _very_ wary of mixing READ_ONCE() and plain loads to the same va=
riable,
>>>>>>> as I've run into cases where you have sequences such as:
>>>>>>>=20
>>>>>>>   // Assume *ptr is initially 0 and somebody else writes it to 1
>>>>>>>   // concurrently
>>>>>>>=20
>>>>>>>   foo =3D *ptr;
>>>>>>>   bar =3D READ_ONCE(*ptr);
>>>>>>>   baz =3D *ptr;
>>>>>>>=20
>>>>>>> and you can get foo =3D=3D baz =3D=3D 0 but bar =3D=3D 1 because the=
 compiler only
>>>>>>> ends up reading from memory twice.
>>>>>>>=20
>>>>>>> That was the root cause behind f069faba6887 ("arm64: mm: Use READ_ON=
CE
>>>>>>> when dereferencing pointer to pte table"), which was very unpleasant=
 to
>>>>>>> debug.
>>>>>>=20
>>>>>> Will, Unless I am missing something fundamental, this case is differe=
nt though.
>>>>>> This case does not care about fewer reads. As long as the first read i=
s volatile, the subsequent loads (even plain)
>>>>>> should work fine, no?
>>>>>> I am not seeing how the compiler can screw that up, so please do enli=
ghten :).
>>>>>=20
>>>>> I guess the thing I'm worried about is if there is some previous read o=
f
>>>>> 'vma->anon_vma' which didn't use READ_ONCE() and the compiler kept the=

>>>>> result around in a register. In that case, 'a' could be NULL, even if
>>>>> the READ_ONCE(vma->anon_vma) returned non-NULL.
>>>>=20
>>>> If I can be a bit brave enough to say -- that appears to be a compiler
>>>> bug to me. It seems that the compiler in such an instance violates the
>>>> "Sequential Consistency Per Variable" rule? I mean if it can't even
>>>> keep SCPV true for a same memory-location load (plain or not) for a
>>>> sequence of code, how can it expect the hardware to.
>>>=20
>>> It's not a compiler bug.  In this example, some other thread performs a
>>> write that changes vma->anon_vma from NULL to non-NULL.  This write
>>> races with the plain reads, and compilers are not required to obey the
>>> "Sequential Consistency Per Variable" rule (or indeed, any rule) when
>>> there is a data race.
>>=20
>> So you're saying the following code behavior is OK?
>>=20
>> /* Say anon_vma can only ever transition from NULL to non-NULL values */
>> a =3D vma->anon_vma;  // Reads NULL
>> b =3D READ_ONCE(vma->anon_vma); // Reads non-NULL
>> c =3D vma->anon_vma;  // Reads NULL!!!
>> if (b) {
>>  c->some_attribute++; // Oopsie
>> }
>=20
> Is there some way to obtain (a && !b) that does not involve a data race,
> and they carte blanche for the compiler to do whatever it pleases?
> I am not seeing one.
>=20
> What am I missing?

Probably nothing. I think I was living briefly in a fantasy world where I
expected predictable compiler behavior on same-memory accesses
amidst data traces. It is good to come back to reality.

thanks,

 - Joel

>=20
>                            Thanx, Paul
