Return-Path: <linux-kernel+bounces-82859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CF1868AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23352B24C00
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDF656467;
	Tue, 27 Feb 2024 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPZUxZm2"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5AE55E68
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022230; cv=none; b=MC7DLX3x1D7Gvw1mHrKpJf/MQiLQkYeGpHen2sZCIB5ife6y3NqVUjfQ9K3uo8TeF6YQ/4S5aQsGu/N/VjTzxuhvvd2woxGqF4pXfDq9qvj8fTCn2H6mynTA2K/EU2bqd32I6IQj5nlX8uRJsdF0yxEidbLX+s7hS6osur+H2cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022230; c=relaxed/simple;
	bh=3+NYbfL02EAe7Dr9dGgMTiO2H3guLGEqi7s1WiNud3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCruw7ei8GVyTXM8PYNC3mL7GxoyB9ZHXRNMf7Cvt2QHFpVr9JuevxfFVIkigvuq6M9PinXo3EHpcA4DD5z1FSxg+2QT1YnAPX7aAXEXHX4LZR7739pc/nxpVYHrRc130+MUdYwUdTe1LMd7bvj1FwBsXv3/aKD7ilelRXe+32g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPZUxZm2; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-608d490a64aso28996477b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709022228; x=1709627028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6B8RP6a8YyuQVMWpLc3aNKulJBA75T/Z2hdZPd6pvYc=;
        b=IPZUxZm2IsLtriaIoWfrAdoFjZ40yudBIEmlfauZe16FUCmap8JZFw+iw5cwQfnjX3
         sk8mQOdH6YxNiQLa33DdO/jyb8DOSu8SX3SXw/0ATFKX7oJ9jDL3FdYH6XqFwBW85ACC
         +jUQcS3ww5TefPbiHwnmzw5XocKMj7PUMk8N4f1xLM9kNfiK/DhgoQHEe9Loe/BK+noj
         IQNTctKQJjRfMgKyZyXmQZ3AV/H7fB5frsNGzChhM5DOtDNDhb4M3sSs7+QUkHT8WDCp
         xLERL4N7eIXX25HG/YikjpHOE1AV9VIh2c2C03QhUdKRvt9YS9u+6Hu67CVoPWPoL7SR
         r1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709022228; x=1709627028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6B8RP6a8YyuQVMWpLc3aNKulJBA75T/Z2hdZPd6pvYc=;
        b=imQRj9ROuxBXK5EFwiAOADzsFXM8xCzvWdqwgnO/jTR/kGbU+KNF15s/rKbzYRbyAG
         mkFkSwaD8ptbTYzcu5umSkkp7b13Y510gsBHYg/LTgKt9wIXVmjFUcIm81AIJUzwjiCo
         4zqz24+dAJPIKKu1YbsJZF1xCL4eLYP7/0O3407sH4m0iyjmCDNNzwRBeyRqOwocmdlA
         Hgv2nc52yDR1agOosWi9ZOb1huWVl93FFVsjq2d8CHqAGnaNJsp18hlEFULbUSvMnZxl
         uoamcifmSSryiyq3WL/7JxXXmpbi8pdb72eYdjesI9+9DU16JFtewrJQsCRIlIVGtAy/
         tFVg==
X-Forwarded-Encrypted: i=1; AJvYcCXgrqHve0nnlCfUhZTWIk0Lb9Wand5BQwib/PJyUO6ZbHsrks2w+tpvYhH+VilEQ2+7xUq7pyJuUfw1F+tWY1kOFOoLgSB6T3w9ZgFu
X-Gm-Message-State: AOJu0YxITlpJUNueeSlV2RP+TbF35XsHYs92SfI6EOV4rl/1R1naAnIh
	MqP9f+SUtFXbZOGvixYV6ty/lVJimrnOjNe/XLNp2i2bNQVvF2zH43JslVO4w+cGFBplCrIP+Y7
	RNIU7fRwHtfGQJQwCDdbHeEI5T5tgetukvLVQvrg2
X-Google-Smtp-Source: AGHT+IEjnTYxfirewIQ1lX56xzcoZLgRN10ewnue+kjoxb7KArMYmYjXx7GE732BsCGyKbWCp/wFaYPAj3bW4A8q/no=
X-Received: by 2002:a0d:d68c:0:b0:607:6fe9:f55a with SMTP id
 y134-20020a0dd68c000000b006076fe9f55amr1451239ywd.35.1709022228290; Tue, 27
 Feb 2024 00:23:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227070418.62292-1-ioworker0@gmail.com> <90471b2f-826e-4275-a9a3-ec673c3e6af8@redhat.com>
In-Reply-To: <90471b2f-826e-4275-a9a3-ec673c3e6af8@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 27 Feb 2024 16:23:36 +0800
Message-ID: <CAK1f24nr=giiYW2CVtbpuUxNshb9ksLhtY_v-SK1_AVvQPUEdQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/memory: Fix boundary check for next PFN in folio_pte_batch()
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, 21cnbao@gmail.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey David,

Thanks for taking time to review!

On Tue, Feb 27, 2024 at 3:30=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 27.02.24 08:04, Lance Yang wrote:
> > Previously, in folio_pte_batch(), only the upper boundary of the
> > folio was checked using '>=3D' for comparison. This led to
> > incorrect behavior when the next PFN exceeded the lower boundary
> > of the folio, especially in corner cases where the next PFN might
> > fall into a different folio.
>
> Which commit does this fix?
>
> The introducing commit (f8d937761d65c87e9987b88ea7beb7bddc333a0e) is
> already in mm-stable, so we would need a Fixes: tag. Unless, Ryan's
> changes introduced a problem.
>
> BUT
>
> I don't see what is broken. :)
>
> Can you please give an example/reproducer?

For example1:

PTE0 is present for large folio1.
PTE1 is present for large folio1.
PTE2 is present for large folio1.
PTE3 is present for large folio1.

folio_nr_pages(folio1) is 4.
folio_nr_pages(folio2) is 4.

pte =3D *start_ptep =3D PTE0;
max_nr =3D folio_nr_pages(folio2);

If folio_pfn(folio1) < folio_pfn(folio2),
the return value of folio_pte_batch(folio2, start_ptep, pte, max_nr)
will be 4(Actually it should be 0).

For example2:

PTE0 is present for large folio2.
PTE1 is present for large folio1.
PTE2 is present for large folio1.
PTE3 is present for large folio1.

folio_nr_pages(folio1) is 4.
folio_nr_pages(folio2) is 4.

pte =3D *start_ptep =3D PTE0;
max_nr =3D folio_nr_pages(folio1);

If max_nr=3D4, the return value of folio_pte_batch(folio1, start_ptep,
pte, max_nr)
will be 1(Actually it should be 0).

folio_pte_batch() will soon be exported, and IMO, these corner cases may ne=
ed
to be handled.

Thanks,
Lance

>
> We know that the first PTE maps the folio. By incrementing the PFN using
> pte_next_pfn/pte_advance_pfn, we cannot suddenly get a lower PFN.
>
> So how would pte_advance_pfn(folio_start_pfn + X) suddenly give us a PFN
> lower than folio_start_pfn?
>
> Note that we are not really concerned about any kind of
> pte_advance_pfn() overflow that could generate PFN=3D0. I convinces mysel=
f
> that that that is something we don't have to worry about.
>
>
> [I also thought about getting rid of the pte_pfn(pte) >=3D folio_end_pfn
> and instead limiting end_ptep. But that requires more work before the
> loop and feels more like a micro-optimization.]
>
> >
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >   mm/memory.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 642b4f2be523..e5291d1e8c37 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -986,12 +986,15 @@ static inline int folio_pte_batch(struct folio *f=
olio, unsigned long addr,
> >               pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> >               bool *any_writable)
> >   {
> > -     unsigned long folio_end_pfn =3D folio_pfn(folio) + folio_nr_pages=
(folio);
> > +     unsigned long folio_start_pfn, folio_end_pfn;
> >       const pte_t *end_ptep =3D start_ptep + max_nr;
> >       pte_t expected_pte, *ptep;
> >       bool writable;
> >       int nr;
> >
> > +     folio_start_pfn =3D folio_pfn(folio);
> > +     folio_end_pfn =3D folio_start_pfn + folio_nr_pages(folio);
> > +
> >       if (any_writable)
> >               *any_writable =3D false;
> >
> > @@ -1015,7 +1018,7 @@ static inline int folio_pte_batch(struct folio *f=
olio, unsigned long addr,
> >                * corner cases the next PFN might fall into a different
> >                * folio.
> >                */
> > -             if (pte_pfn(pte) >=3D folio_end_pfn)
> > +             if (pte_pfn(pte) >=3D folio_end_pfn || pte_pfn(pte) < fol=
io_start_pfn)
> >                       break;
> >
> >               if (any_writable)
>
> --
> Cheers,
>
> David / dhildenb
>

