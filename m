Return-Path: <linux-kernel+bounces-142687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF398A2ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE6B1F219E0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A88A5E093;
	Fri, 12 Apr 2024 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHPVUInz"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395755C61C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927221; cv=none; b=E49cBj6kT9Cv5ZVgkY/bVZdRkTSir9QFw6l3ES0GMxSNEZsuPjZuPVPBR5K5dbzDlfkTYjiukAwH6HHUwndKMot3aMApU3yvCIUB5WQBOOOv4ECgO3ywEQvSkYD18Q6JJr2wYXitt1zPVmdYMSTgNi9vjiS1wbPZVIVSkyn012M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927221; c=relaxed/simple;
	bh=WWML42pU0gyPEAbHQUi6Fs7oG2/hltpIrDkhv5AR/ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btz8ljlv8UK4wHx0hunSsR6U0u2+qVlychumKy0qcCKX5tUe4hefWHVgSySsCEc7INh8ZJ6EqCZyF0boYP/F3fgo4rQSLlRAx4x1+3HPpVUKkOfQThwDfUHf1si6kN87S2nkcyrGWGlN8aN60oW9+KOXJ/Nsa8fXrWET1aWkkyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OHPVUInz; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso870535276.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712927219; x=1713532019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SB9S53FpUOU6K6sETjS3Mnaeo0b7/MTmwyW31fw1bBA=;
        b=OHPVUInzLDWo+uF7UqVd4FMp8UHYpDMBrNVX7PhrPnBZ9BN6EOvdfK5eCgsrOuN5aN
         XcqNLVLGnlaD0xadhAlOdDo865pJ19LOPrYVl+Sn+MI8quOvamPp9igk3kdFQIbdTyAk
         WwzD6Pgb32pkNhvQ+PrP01ScsbDKKlYFXp5mI32T9wevAaIaolvDk44GnZubarMVBuDx
         cqtbZwd6FSBEIMILG9okJs8DUSF7Bm8SOX4wCvqTlTcRDNkWuxEpw2p6LbVDIepgVSjM
         COla/i+QoDdh5Xr2FNR6BCX+eFmaoXBOif4mFnsR3BI98HVLYT+Vh4ZFVT5xu7sNTowF
         NJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712927219; x=1713532019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SB9S53FpUOU6K6sETjS3Mnaeo0b7/MTmwyW31fw1bBA=;
        b=JnIin87hxgZzcQP1FK/kpsIoqhIqQlBsaSY1udIjWX0IAfrc0kSQY6pfypZ2RC8zse
         WQJXDDhsTLCsIwr/zYoM9pizLobC9txX0MJdVuA9xiLVU7EkF2/00+A+sL6MJ5koY4Gl
         HxaNixsb/s+ZIiDhK8clqNYVtn56AzEAWHuqbhPERE5xssy/SkcOdhlbY/eZIgGGfeVK
         IMwQhK0ZraidDhazeEZbmHAtnZ7XL+3gJ4GH70vFtG2ioVDHfdDtyRMXUEmhdL1k9YSc
         /Mw4CKL2pcx3vWAyVDrvKi3WyYQ+8Zx6d5RtjB7gFF7SGG5MZmt88H6QGgk2uROZRWGZ
         A++w==
X-Forwarded-Encrypted: i=1; AJvYcCWf0WpYA5rXs3MpyXiAHr7sMuZOoqe0/uNjXNRWJJc3Yu5oUoIXwQ+HKGoIbM2kFZM8v/ikRfDHDCdD516F9RbqJXFB4GD5yGfWkoeL
X-Gm-Message-State: AOJu0Yw/J4slK2xHJiiAuyER0wNn+xqIjMkUPH7ctKLAdV0zkUhKRhIJ
	yKhF3zHQp37PCUZdfC1gMjY6e5NYwyZJOQVCIwpXPMYIfRtPyqyfc995HtHc+XS20gl0t1UCqkX
	9AcNrC+A1r6gT3w6pArW9QwtAaksoTreX6tbP
X-Google-Smtp-Source: AGHT+IEkizqEncaI2tUBnj3BapsVHQZBG/G0ZuX28yKcPkP1UboPKfU2fh9EJAGBcxgdjfuxfzD4unqvpbTxfZAhAzQ=
X-Received: by 2002:a05:6902:511:b0:dcd:1b8f:e6d3 with SMTP id
 x17-20020a056902051100b00dcd1b8fe6d3mr2319169ybs.48.1712927218816; Fri, 12
 Apr 2024 06:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410170621.2011171-1-peterx@redhat.com> <20240411171319.almhz23xulg4f7op@revolver>
 <ZhhSItiyLYBEdAX3@x1n> <ZhhV3PKgEX9d7_vA@casper.infradead.org>
 <ZhhaRXHKk7w_hKgi@x1n> <Zhhd-A7w1A8JUadM@casper.infradead.org>
 <ZhinCD-PoblxGFm0@casper.infradead.org> <ZhkrY5tkxgAsL1GF@x1n>
In-Reply-To: <ZhkrY5tkxgAsL1GF@x1n>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 12 Apr 2024 06:06:46 -0700
Message-ID: <CAJuCfpG7YkQ2giKiv07TetTn=QHK9x723vnLaTjDCaQjUvAavw@mail.gmail.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
To: Peter Xu <peterx@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Lokesh Gidra <lokeshgidra@google.com>, 
	Alistair Popple <apopple@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 5:39=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Apr 12, 2024 at 04:14:16AM +0100, Matthew Wilcox wrote:
> > On Thu, Apr 11, 2024 at 11:02:32PM +0100, Matthew Wilcox wrote:
> > > > How many instructions it takes for a late RETRY for WRITEs to priva=
te file
> > > > mappings, fallback to mmap_sem?
> > >
> > > Doesn't matter.  That happens _once_ per VMA, and it's dwarfed by the
> > > cost of allocating and initialising the COWed page.  You're adding
> > > instructions to every single page fault.  I'm not happy that we had t=
o
> > > add extra instructions to the fault path for single-threaded programs=
,
> > > but we at least had the justification that we were improving scalabil=
ity
> > > on large systems.  Your excuse is "it makes the code cleaner".  And
> > > honestly, I don't think it even does that.
> >
> > Suren, what would you think to this?
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 6e2fe960473d..e495adcbe968 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5821,15 +5821,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct=
 mm_struct *mm,
> >         if (!vma_start_read(vma))
> >                 goto inval;
> >
> > -       /*
> > -        * find_mergeable_anon_vma uses adjacent vmas which are not loc=
ked.
> > -        * This check must happen after vma_start_read(); otherwise, a
> > -        * concurrent mremap() with MREMAP_DONTUNMAP could dissociate t=
he VMA
> > -        * from its anon_vma.
> > -        */
> > -       if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
> > -               goto inval_end_read;
> > -
> >         /* Check since vm_start/vm_end might change before we lock the =
VMA */
> >         if (unlikely(address < vma->vm_start || address >=3D vma->vm_en=
d))
> >                 goto inval_end_read;
> >
> > That takes a few insns out of the page fault path (good!) at the cost
> > of one extra trip around the fault handler for the first fault on an
> > anon vma.  It makes the file & anon paths more similar to each other
> > (good!)
> >
> > We'd need some data to be sure it's really a win, but less code is
> > always good.
>
> You at least need two things:
>
>   (1) don't throw away Jann's comment so easily

I agree, if we make this change we should keep this comment and maybe
move it into vmf_anon_prepare()

>
>   (2) have a look on whether anon memory has the fallback yet, at all

Yeah, I think do_anonymous_page() will have to change as I mentioned
in the previous reply.

>
> Maybe someone can already comment in a harsh way on this one, but no, I'm
> not going to be like that.
>
> I still don't understand why you don't like so much to not fallback at al=
l
> if we could, the flags I checked was all in hot cache I think anyway.
>
> And since I'm also enough on how you comment in your previous replies, I'=
ll
> leave the rest comments for others.

FWIW I fully accept the blame for not seeing that private file mapping
read case regression. In retrospect this should have been obvious...
but the hindsight is always 20/20.

>
> --
> Peter Xu
>

