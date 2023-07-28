Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0B176738D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbjG1Rg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbjG1RgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:36:13 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E8C3C24
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:35:57 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9c0391749so36428311fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690565755; x=1691170555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/t220Hmflj/VPTxFmqAg5Xug/KV6ADyc6uAYVTG6Vgk=;
        b=f8BbsCSuJ+1Vl5ttIizbIBKz3oh9F56xaUVVi0cuYOZXkfp3gq91OmfZRP67EIFml1
         Du/E3jw+PZmgXdDBcPxp+29WC9u2XxwcLZ2w8s1ro3NfGTKPSHpvBm/9JpVXcimyA8v3
         7HJmYulel6o02OzFOnuga6a1Nhi3ylXxN+VB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690565755; x=1691170555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/t220Hmflj/VPTxFmqAg5Xug/KV6ADyc6uAYVTG6Vgk=;
        b=LQcT74Dzdx07mDynVjSyb2QqZGINLzovWuI1l6Pp/nV1izOeYjqxIu6idz2kuRQDZ9
         o4UdYJeWnTMFLnTp+osKu/vi3b93P6dQxvcG9X/fvXLCPUY2wf5eI2WRfzFEDooj+cre
         ZsywRYqEQkyDy9ZK/Oph5Mtwqpyv2ForhjZXtYy+JtuUOB9lDve5PRaJpo8o26l3FKzR
         NVCKYQVAaBELMZcl0t0qCJu1HWQtFIOnsi6Ec59cEx5XihMQWsBBOLCA08Oznwz+EZwK
         qJ9MQSUBS48h2DbPqFHQ5lW7XAYmKKqFhFekoOoosFGsfuX4krcVyBIiVB19SeO//05J
         9e+A==
X-Gm-Message-State: ABy/qLaDeZ630ovK490NRKLI54HWqGFefgNT/CWtwNvq4tadxXg/KTKa
        LgKyXc+QxoLVCdXhGgL3unAjCrM60KI7QMwK3GOLug==
X-Google-Smtp-Source: APBJJlGeDyQq93qi2ph5y7OaUdlnjpI1araVuyPUyhyGClXnxoOhJ8lj97tWTCK730unzS4pcewYdNRvSpUgA05dIQE=
X-Received: by 2002:a2e:98da:0:b0:2b6:9909:79bd with SMTP id
 s26-20020a2e98da000000b002b6990979bdmr2211202ljj.24.1690565754899; Fri, 28
 Jul 2023 10:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <BCDEA397-AA7A-4FDE-8046-C68625CDE166@joelfernandes.org> <20230728124412.GA21303@willie-the-truck>
In-Reply-To: <20230728124412.GA21303@willie-the-truck>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 28 Jul 2023 13:35:43 -0400
Message-ID: <CAEXW_YRtUd4jUP68jzMgDgWxAy8tdJQortK07TZgCxVLNAgaNA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix vma->anon_vma check for per-VMA locking; fix
 anon_vma memory ordering
To:     Will Deacon <will@kernel.org>
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

On Fri, Jul 28, 2023 at 8:44=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Thu, Jul 27, 2023 at 12:34:44PM -0400, Joel Fernandes wrote:
> > > On Jul 27, 2023, at 10:57 AM, Will Deacon <will@kernel.org> wrote:
> > > =EF=BB=BFOn Thu, Jul 27, 2023 at 04:39:34PM +0200, Jann Horn wrote:
> > >> if (READ_ONCE(vma->anon_vma) !=3D NULL) {
> > >>  // we now know that vma->anon_vma cannot change anymore
> > >>
> > >>  // access the same memory location again with a plain load
> > >>  struct anon_vma *a =3D vma->anon_vma;
> > >>
> > >>  // this needs to be address-dependency-ordered against one of
> > >>  // the loads from vma->anon_vma
> > >>  struct anon_vma *root =3D a->root;
> > >> }
> > >>
> > >>
> > >> Is this fine? If it is not fine just because the compiler might
> > >> reorder the plain load of vma->anon_vma before the READ_ONCE() load,
> > >> would it be fine after adding a barrier() directly after the
> > >> READ_ONCE()?
> > >
> > > I'm _very_ wary of mixing READ_ONCE() and plain loads to the same var=
iable,
> > > as I've run into cases where you have sequences such as:
> > >
> > >    // Assume *ptr is initially 0 and somebody else writes it to 1
> > >    // concurrently
> > >
> > >    foo =3D *ptr;
> > >    bar =3D READ_ONCE(*ptr);
> > >    baz =3D *ptr;
> > >
> > > and you can get foo =3D=3D baz =3D=3D 0 but bar =3D=3D 1 because the =
compiler only
> > > ends up reading from memory twice.
> > >
> > > That was the root cause behind f069faba6887 ("arm64: mm: Use READ_ONC=
E
> > > when dereferencing pointer to pte table"), which was very unpleasant =
to
> > > debug.
> >
> > Will, Unless I am missing something fundamental, this case is different=
 though.
> > This case does not care about fewer reads. As long as the first read is=
 volatile, the subsequent loads (even plain)
> > should work fine, no?
> > I am not seeing how the compiler can screw that up, so please do enligh=
ten :).
>
> I guess the thing I'm worried about is if there is some previous read of
> 'vma->anon_vma' which didn't use READ_ONCE() and the compiler kept the
> result around in a register. In that case, 'a' could be NULL, even if
> the READ_ONCE(vma->anon_vma) returned non-NULL.

If I can be a bit brave enough to say -- that appears to be a compiler
bug to me. It seems that the compiler in such an instance violates the
"Sequential Consistency Per Variable" rule? I mean if it can't even
keep SCPV true for a same memory-location load (plain or not) for a
sequence of code, how can it expect the hardware to.

In other words, with that kind of caching, the value of the variable
goes back in time which will be tough luck for even a fully ordered
sequentially-consistent processor!!!

> The crux of the issue is that the compiler can break read-after-read
> ordering if you don't use READ_ONCE() consistently. Sadly, judging by
> the other part of the thread from Nadav, it's fiddly to fix this without
> wrecking the codegen.

Right. Thanks to you and others for sharing your informative
perspective as always,

 - Joel
