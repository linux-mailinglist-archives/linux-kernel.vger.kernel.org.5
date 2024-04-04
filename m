Return-Path: <linux-kernel+bounces-132121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388FA898FE5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F62288B86
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3C613B295;
	Thu,  4 Apr 2024 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lbp2U1Zc"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F8C12D1EF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712264882; cv=none; b=Px28wkvkjpet8pmmHBh1q+HJ3gIsvGOSJm2w94pEpilbEopfAzvgnAXBHp9wIvNltxhF4oIX+ql4i+6clCkKHh2QTC6hpO4JIwYB22SuqY7+P9xQE03f2kLeS+YOOfVpC7GhefPYa5bwkNSPAjV3LOh6BXb/ei4EQ8OzomZ9XO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712264882; c=relaxed/simple;
	bh=jiPmv7P0Zt+7AyXesKeCak2Yp5DYXGginccDd9ut1dE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5H2mOYete+C1kVK8AotRfT4Yuq3lsLdwWgZj11Q9YlFQ2XNsxHFRekhonN112snBzcqW9EWtyGH+WGyv29VrMGc/gJC/U1FegCPszvaAli2KHXwS3eqTp/hAysswWUew70LweX5GXv233XYsKptLAsSTojwI8ltprgm2wu0DwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lbp2U1Zc; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6151d2489b4so17028237b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 14:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712264879; x=1712869679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEPgxv5jO+a3XFdTbHPF5Q9T9DAeBlFJtTQ1Lr368bE=;
        b=lbp2U1ZcPqsSPnTX9rIjuOSfO+NYSkJA1B4uPxFuFENz7Ir9o4W9/W4Z865Cj5Z/7J
         2rGXpoBR0lXVSMbkX04RHhXVP+RajHrwtEm79Cojg9B5b2IazbdhkOlI2mSwZMrcH6YA
         A9qogcgT/cRyRUVSiuLxB0vv9vR2is4+icrbzJOprJOrHj8M3/Vhv8CMAYBlRBl4J8y0
         KTMfeIUUTCg4h1Ll9xxlz1lHMR0Q9E0ByfM4p+AdMZT5/6OSt4+69opzCQaUVsJ/qUBG
         2mOBt6aSy9aSpWd1QvixhaH9nwWfwd2YlouyFe5FS+7fQ8YW5rqC6p09iMehDUuOatge
         O9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712264879; x=1712869679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEPgxv5jO+a3XFdTbHPF5Q9T9DAeBlFJtTQ1Lr368bE=;
        b=gpJ6GCRh+eQoTk9bP5vp243f8REu/ISkWcVKy1SpTwBa6mb7cPV24t8PFv8NcF/K26
         7XQhSHsdm5t1wAPU2JiUbIauoyon+Ml5FiPyzrmYU5HU82oB/A/BMWWdekr3dMT8JmTj
         yOPaFYAfvNScAc3InY6Cmkb8nUF0RcVI0/wq9p5kXPQgmwRt5hLcy2n+6eueDRL4VS5i
         Prylv7Q3mXpyz+wJ8NfHvTJEb501K5J2Pk7yu392Qoi2pmVEJDosn9OTrnlu3MNQzZm4
         +7sZdn1KJDmAzdWtggbhejlavO27ZG3DNxKnnmadjxwshn5EivEcKWCBMRmDJCAwHXNz
         kfWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSg5zseTADkp+roEugKAWVQDNKoyFb9UNz5XjJHSz4cxFjC2wkfKWtqmnNw1t7gvtDw/QXQvRbemK7DauodowsB2lEDsZagYRJh/aC
X-Gm-Message-State: AOJu0Yys2qlFGkhRizhLH+Qb2nXNrNv5e7oWxbiphYxBpkVqcgViMQGC
	2jBYtIzJ44UmFzk5vpP2VgBJIdSloZCMsgMgz4uTfaFPhhYoDCcpY4tJ3neaQK8yEo20CqOgFI1
	xwRwOyVJAkxxtUju2xal1dZsPtlRrBrcN/Zwp
X-Google-Smtp-Source: AGHT+IGeSDcayNFImOyFgb30C9ktisTL2ID44stHNniOVpp+PNE1qvTfexNZELS3w9g9f5CAg8+S1Ah1YxYXd/48pl0=
X-Received: by 2002:a25:ea53:0:b0:dca:e4fd:b6d6 with SMTP id
 o19-20020a25ea53000000b00dcae4fdb6d6mr3005124ybe.61.1712264879294; Thu, 04
 Apr 2024 14:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404171726.2302435-1-lokeshgidra@google.com>
 <Zg7hrt5HudXLBUn_@casper.infradead.org> <Zg8OYYV7DDo7S2Yf@x1n>
 <CAJuCfpGHe2=noJomL0XonT4dVGvZmVujRMEbgpYgVg_d5wo-+g@mail.gmail.com> <Zg8V5OycPYYk7-Qp@x1n>
In-Reply-To: <Zg8V5OycPYYk7-Qp@x1n>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 4 Apr 2024 14:07:45 -0700
Message-ID: <CAJuCfpGj5xk-NxSwW6Mt8NGZcV9N__8zVPMGXDPAYKMcN9=Oig@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: change src_folio after ensuring it's
 unpinned in UFFDIO_MOVE
To: Peter Xu <peterx@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Lokesh Gidra <lokeshgidra@google.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, david@redhat.com, 
	zhengqi.arch@bytedance.com, kaleshsingh@google.com, ngeoffray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 2:04=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Apr 04, 2024 at 01:55:07PM -0700, Suren Baghdasaryan wrote:
> > On Thu, Apr 4, 2024 at 1:32=E2=80=AFPM Peter Xu <peterx@redhat.com> wro=
te:
> > >
> > > On Thu, Apr 04, 2024 at 06:21:50PM +0100, Matthew Wilcox wrote:
> > > > On Thu, Apr 04, 2024 at 10:17:26AM -0700, Lokesh Gidra wrote:
> > > > > -           folio_move_anon_rmap(src_folio, dst_vma);
> > > > > -           WRITE_ONCE(src_folio->index, linear_page_index(dst_vm=
a, dst_addr));
> > > > > -
> > > > >             src_pmdval =3D pmdp_huge_clear_flush(src_vma, src_add=
r, src_pmd);
> > > > >             /* Folio got pinned from under us. Put it back and fa=
il the move. */
> > > > >             if (folio_maybe_dma_pinned(src_folio)) {
> > > > > @@ -2270,6 +2267,9 @@ int move_pages_huge_pmd(struct mm_struct *m=
m, pmd_t *dst_pmd, pmd_t *src_pmd, pm
> > > > >                     goto unlock_ptls;
> > > > >             }
> > > > >
> > > > > +           folio_move_anon_rmap(src_folio, dst_vma);
> > > > > +           WRITE_ONCE(src_folio->index, linear_page_index(dst_vm=
a, dst_addr));
> > > > > +
> > > >
> > > > This use of WRITE_ONCE scares me.  We hold the folio locked.  Why d=
o
> > > > we need to use WRITE_ONCE?  Who's looking at folio->index without
> > > > holding the folio lock?
> > >
> > > Seems true, but maybe suitable for a separate patch to clean it even =
so?
> > > We also have the other pte level which has the same WRITE_ONCE(), so =
if we
> > > want to drop we may want to drop both.
> >
> > Yes, I'll do that separately and will remove WRITE_ONCE() in both place=
s.
>
> Thanks, Suren.  Besides, any comment on below?
>
> It's definely a generic per-vma question too (besides my willingness to
> remove that userfault specific code..), so comments welcomed.

Yes, I was typing my reply :)
This might have happened simply because lock_vma_under_rcu() was
originally developed to handle only anonymous page faults and then got
expanded to cover file-backed cases as well. Your suggestion seems
fine to me but I would feel much more comfortable after Matthew (who
added file-backed support) reviewed it.

>
> >
> > >
> > > I just got to start reading some the new move codes (Lokesh, apologie=
s on
> > > not be able to provide feedbacks previously..), but then I found one =
thing
> > > unclear, on special handling of private file mappings only in userfau=
lt
> > > context, and I didn't know why:
> > >
> > > lock_vma():
> > >         if (vma) {
> > >                 /*
> > >                  * lock_vma_under_rcu() only checks anon_vma for priv=
ate
> > >                  * anonymous mappings. But we need to ensure it is as=
signed in
> > >                  * private file-backed vmas as well.
> > >                  */
> > >                 if (!(vma->vm_flags & VM_SHARED) && unlikely(!vma->an=
on_vma))
> > >                         vma_end_read(vma);
> > >                 else
> > >                         return vma;
> > >         }
> > >
> > > AFAIU even for generic users of lock_vma_under_rcu(), anon_vma must b=
e
> > > stable to be used.  Here it's weird to become an userfault specific
> > > operation to me.
> > >
> > > I was surprised how it worked for private file maps on faults, then I=
 had a
> > > check and it seems we postponed such check until vmf_anon_prepare(), =
which
> > > is the CoW path already, so we do as I expected, but seems unnecessar=
y to
> > > that point?
> > >
> > > Would something like below make it much cleaner for us?  As I just do=
n't
> > > yet see why userfault is special here.
> > >
> > > Thanks,
> > >
> > > =3D=3D=3D8<=3D=3D=3D
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 984b138f85b4..d5cf1d31c671 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -3213,10 +3213,8 @@ vm_fault_t vmf_anon_prepare(struct vm_fault *v=
mf)
> > >
> > >         if (likely(vma->anon_vma))
> > >                 return 0;
> > > -       if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > > -               vma_end_read(vma);
> > > -               return VM_FAULT_RETRY;
> > > -       }
> > > +       /* We shouldn't try a per-vma fault at all if anon_vma isn't =
solid */
> > > +       WARN_ON_ONCE(vmf->flags & FAULT_FLAG_VMA_LOCK);
> > >         if (__anon_vma_prepare(vma))
> > >                 return VM_FAULT_OOM;
> > >         return 0;
> > > @@ -5817,9 +5815,9 @@ struct vm_area_struct *lock_vma_under_rcu(struc=
t mm_struct *mm,
> > >          * find_mergeable_anon_vma uses adjacent vmas which are not l=
ocked.
> > >          * This check must happen after vma_start_read(); otherwise, =
a
> > >          * concurrent mremap() with MREMAP_DONTUNMAP could dissociate=
 the VMA
> > > -        * from its anon_vma.
> > > +        * from its anon_vma.  This applies to both anon or private f=
ile maps.
> > >          */
> > > -       if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
> > > +       if (unlikely(!(vma->vm_flags & VM_SHARED) && !vma->anon_vma))
> > >                 goto inval_end_read;
> > >
> > >         /* Check since vm_start/vm_end might change before we lock th=
e VMA */
> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index f6267afe65d1..61f21da77dcd 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > > @@ -72,17 +72,8 @@ static struct vm_area_struct *lock_vma(struct mm_s=
truct *mm,
> > >         struct vm_area_struct *vma;
> > >
> > >         vma =3D lock_vma_under_rcu(mm, address);
> > > -       if (vma) {
> > > -               /*
> > > -                * lock_vma_under_rcu() only checks anon_vma for priv=
ate
> > > -                * anonymous mappings. But we need to ensure it is as=
signed in
> > > -                * private file-backed vmas as well.
> > > -                */
> > > -               if (!(vma->vm_flags & VM_SHARED) && unlikely(!vma->an=
on_vma))
> > > -                       vma_end_read(vma);
> > > -               else
> > > -                       return vma;
> > > -       }
> > > +       if (vma)
> > > +               return vma;
> > >
> > >         mmap_read_lock(mm);
> > >         vma =3D find_vma_and_prepare_anon(mm, address);
> > > --
> > > 2.44.0
> > >
> > >
> > > --
> > > Peter Xu
> > >
> >
>
> --
> Peter Xu
>

