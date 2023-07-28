Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418B676742B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbjG1SD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbjG1SDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:03:24 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37493C1D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:03:22 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9c55e0fbeso30090171fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690567401; x=1691172201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPYow9WFU1jaMCih0ymMDtROAfjzkXiwxcD5gbF7K20=;
        b=lwmNpruGPdLgD4RfM/3SayVz6x7Uqn3ph5XE2Kzy/W4DtPEueu5lsgz/yLqva8d8Fx
         TFbFihJRFLqjE3m0mhSmOp5kv38Irv5iMFMYcpx9jCvT0spD/UTxWXk5dk2UcfUcBcHp
         jYn8BgPbHli/PhLM1m2FAgoE5D6jhtBkFBplE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690567401; x=1691172201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPYow9WFU1jaMCih0ymMDtROAfjzkXiwxcD5gbF7K20=;
        b=GaIvcl3e4tDVLgdMumzXQUdg8UuCmWhYMevoC2DRn8/dogym7U46zMl7e/JbCDSi/g
         H/XS8td/p0upj5AYA7e2YjeRJGrKbRWko0TzC9r40CauV9FqqodNgEInkV1USlTlbh0Z
         xCMUCmix52CxAzGM7ENcjwHd6qvcsTUr0vgKvzrkE9xYw3+bHt76py+uPZr33FUB/a/V
         CWgMe30YUQI1PZWZSCR97UrUVBjcKJRWmPuB4WYyKWAfwV+lvi59xbEdeI3m8m/AhhUz
         KtsjZKKFekVS2q/jS8SWoz3Oc6rZq4oIbS89N0vDTOFwh0q6cqw9XOZl8vdSbQKfeYhy
         KNLA==
X-Gm-Message-State: ABy/qLbS2cyQuQffkEfORuPJ38Iz9BF6TE0v2krXeec/QbVen5bxC7g8
        6dnqMxquo4TXRYzcJ5dsTrLVwORe+LUN71aqCrgpDw==
X-Google-Smtp-Source: APBJJlEhn+9zJD4Q4qVaoy//OUafQkPLi9nT38hQl8hoaQ0XlIG3FGGMz5osLwru18XRPkqVBrWwl9UZSWnt/1bNxKo=
X-Received: by 2002:a05:651c:cd:b0:2b6:eb5a:d377 with SMTP id
 13-20020a05651c00cd00b002b6eb5ad377mr2486386ljr.5.1690567400660; Fri, 28 Jul
 2023 11:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <BCDEA397-AA7A-4FDE-8046-C68625CDE166@joelfernandes.org>
 <20230728124412.GA21303@willie-the-truck> <CAEXW_YRtUd4jUP68jzMgDgWxAy8tdJQortK07TZgCxVLNAgaNA@mail.gmail.com>
 <9fd99405-a3ff-4ab7-b6b7-e74849f1d334@rowland.harvard.edu>
In-Reply-To: <9fd99405-a3ff-4ab7-b6b7-e74849f1d334@rowland.harvard.edu>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 28 Jul 2023 14:03:09 -0400
Message-ID: <CAEXW_YS-axyXvX4-aMc9a2EWY59KAyHvirMewVuoNGOGSh35Vw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix vma->anon_vma check for per-VMA locking; fix
 anon_vma memory ordering
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
        paulmck@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 1:51=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Fri, Jul 28, 2023 at 01:35:43PM -0400, Joel Fernandes wrote:
> > On Fri, Jul 28, 2023 at 8:44=E2=80=AFAM Will Deacon <will@kernel.org> w=
rote:
> > >
> > > On Thu, Jul 27, 2023 at 12:34:44PM -0400, Joel Fernandes wrote:
> > > > > On Jul 27, 2023, at 10:57 AM, Will Deacon <will@kernel.org> wrote=
:
> > > > > =EF=BB=BFOn Thu, Jul 27, 2023 at 04:39:34PM +0200, Jann Horn wrot=
e:
> > > > >> if (READ_ONCE(vma->anon_vma) !=3D NULL) {
> > > > >>  // we now know that vma->anon_vma cannot change anymore
> > > > >>
> > > > >>  // access the same memory location again with a plain load
> > > > >>  struct anon_vma *a =3D vma->anon_vma;
> > > > >>
> > > > >>  // this needs to be address-dependency-ordered against one of
> > > > >>  // the loads from vma->anon_vma
> > > > >>  struct anon_vma *root =3D a->root;
> > > > >> }
> > > > >>
> > > > >>
> > > > >> Is this fine? If it is not fine just because the compiler might
> > > > >> reorder the plain load of vma->anon_vma before the READ_ONCE() l=
oad,
> > > > >> would it be fine after adding a barrier() directly after the
> > > > >> READ_ONCE()?
> > > > >
> > > > > I'm _very_ wary of mixing READ_ONCE() and plain loads to the same=
 variable,
> > > > > as I've run into cases where you have sequences such as:
> > > > >
> > > > >    // Assume *ptr is initially 0 and somebody else writes it to 1
> > > > >    // concurrently
> > > > >
> > > > >    foo =3D *ptr;
> > > > >    bar =3D READ_ONCE(*ptr);
> > > > >    baz =3D *ptr;
> > > > >
> > > > > and you can get foo =3D=3D baz =3D=3D 0 but bar =3D=3D 1 because =
the compiler only
> > > > > ends up reading from memory twice.
> > > > >
> > > > > That was the root cause behind f069faba6887 ("arm64: mm: Use READ=
_ONCE
> > > > > when dereferencing pointer to pte table"), which was very unpleas=
ant to
> > > > > debug.
> > > >
> > > > Will, Unless I am missing something fundamental, this case is diffe=
rent though.
> > > > This case does not care about fewer reads. As long as the first rea=
d is volatile, the subsequent loads (even plain)
> > > > should work fine, no?
> > > > I am not seeing how the compiler can screw that up, so please do en=
lighten :).
> > >
> > > I guess the thing I'm worried about is if there is some previous read=
 of
> > > 'vma->anon_vma' which didn't use READ_ONCE() and the compiler kept th=
e
> > > result around in a register. In that case, 'a' could be NULL, even if
> > > the READ_ONCE(vma->anon_vma) returned non-NULL.
> >
> > If I can be a bit brave enough to say -- that appears to be a compiler
> > bug to me. It seems that the compiler in such an instance violates the
> > "Sequential Consistency Per Variable" rule? I mean if it can't even
> > keep SCPV true for a same memory-location load (plain or not) for a
> > sequence of code, how can it expect the hardware to.
>
> It's not a compiler bug.  In this example, some other thread performs a
> write that changes vma->anon_vma from NULL to non-NULL.  This write
> races with the plain reads, and compilers are not required to obey the
> "Sequential Consistency Per Variable" rule (or indeed, any rule) when
> there is a data race.

So you're saying the following code behavior is OK?

/* Say anon_vma can only ever transition from NULL to non-NULL values */
a =3D vma->anon_vma;  // Reads NULL
b =3D READ_ONCE(vma->anon_vma); // Reads non-NULL
c =3D vma->anon_vma;  // Reads NULL!!!
if (b) {
  c->some_attribute++; // Oopsie
}

thanks,

 - Joel
(On the road now, so my replies will be slightly delayed for few hours)
