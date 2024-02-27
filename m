Return-Path: <linux-kernel+bounces-82881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBE6868B20
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7C61C2233D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811F913172B;
	Tue, 27 Feb 2024 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8eARM5l"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DC412FB18
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709023538; cv=none; b=AxNpaC+X/laWjmU9mYvb5UUZ7fv16HSvQIZF9wG5IN1x7G1NqxyX7NczLYwn/obN/fvlMLjZLSuj0+70HgAJYaMQovU6WAdBZp440SoWa5FDn2wozPUqkJja1F0dW/IBL4Co5qzfC2S2XuCKRfnC0d9pOHQtHSYZzkgI5l2OF4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709023538; c=relaxed/simple;
	bh=NQXAMJy/2J5czV1DsPsort/y7A38ChaDbSJa0ZjsrqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eliUCS6bXIcI23GHgePNa5mrpJOxZ2fs/EXaipk927yH2nI9zSkuBUsNnf02NzrUMpk8mVvfPg4Wmzlu8QqFd3oeLO8T3c5mbW7g1mktCCs6gsAtZCDM2uk1eqzBo0bps55J4obAm0gEn77mK+S3bUe6DKfESz6PEsM0bGVSolw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8eARM5l; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6087d1355fcso23062047b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709023536; x=1709628336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQXAMJy/2J5czV1DsPsort/y7A38ChaDbSJa0ZjsrqA=;
        b=Q8eARM5lHcq5PCvQS9DG11UHsm+w+fw8T1Rb7MUAqYzWA1OzExq2Y74pAxdxZtBPEX
         RIB/KLUBvzIbI6Rzdx4ZhWqzSOlp4/qknVya7lCZO9oLRTmMSpc5yAWgTf6A+hBFdMoH
         QL4PQfnk9TIzm3L9jvhPU2SrtrP/tbH6kbYfFvdwjSk+zcblVfVvmuj+ZCzdOrI+j3Ee
         VYx4OLqBQJBeO+s3uTK60ShAti4BuktQscPlnvf3g9A8pFw49FMC3f7dxIJAdwzk59Ks
         QmjJjhMSObeGtORiRkQsaJCB2CFkY67LrW99I/RXGMy4T86ljfVeSDHRIw1x/RUU9XsO
         PwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709023536; x=1709628336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQXAMJy/2J5czV1DsPsort/y7A38ChaDbSJa0ZjsrqA=;
        b=OtED7WrMeJG9X6lQGtq+5qjVpKFwcoSvrOHIgPo2nHWTb8isl/fgNcbDhsg72Snd+s
         h3SORZR5akbD6KgE09Opc3EK0tqr+bPahin/4C9LCW+Ttnk8lAWEnQg+K54PmFtPi9k4
         7ukfTk0+Epy88uW826cDepn6Zz0IyGGwjtIa1w2lCJSex7XUIG6vFa0RpCZAgu577zfi
         dh+qdra4WOfgiVepmUwOTXacxPSR6lA85X2gd8RWGYyzcQfVvSvkZ7xQ9QqtNRjpbdvW
         YxGVENp1ZDb5lqe/0Do9BSZuVM65nXhwfFFxxaIRVHORVZs/p+JPPBA43o4Y8Ht+/X7X
         2QEw==
X-Forwarded-Encrypted: i=1; AJvYcCXnVpJ4RoTv2/ONQsrx22xty39fTK5YznIqZInp8xp3SxtQmy0uBYXKAhBz5B4I5UWtbz/oBS/qpojpb0zoVYXEr6v2M+Rfxloj5YRp
X-Gm-Message-State: AOJu0YxtfOXTWRpCy45NbF5VYWpDTDDxfhP18xSpJIXX+F8JuAgpVd9H
	FnsiC1ES5WQlfJs14LVzUOyqCF40ZWmGBhc1suis+Uq2SJ1sUx+7qZGmNMZeZAr/2ieGMJbSGOa
	DNr8g9xZossIpvCcWBT9MPAklGM8=
X-Google-Smtp-Source: AGHT+IGERW1IeD22ep/7ZxNjLmYxShr7IfSgZW0Lwc1Ew0CHS2TcDv1xLiHW7OYMeA/oZxsrKaAuo11kQGqHXiE0so4=
X-Received: by 2002:a81:6cc7:0:b0:608:3c43:9186 with SMTP id
 h190-20020a816cc7000000b006083c439186mr1571872ywc.45.1709023534709; Tue, 27
 Feb 2024 00:45:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227070418.62292-1-ioworker0@gmail.com> <90471b2f-826e-4275-a9a3-ec673c3e6af8@redhat.com>
 <CAK1f24nr=giiYW2CVtbpuUxNshb9ksLhtY_v-SK1_AVvQPUEdQ@mail.gmail.com> <2aa8b0f0-4fd4-469a-ba72-82fe01d37f15@redhat.com>
In-Reply-To: <2aa8b0f0-4fd4-469a-ba72-82fe01d37f15@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 27 Feb 2024 16:45:23 +0800
Message-ID: <CAK1f24mVT7ucbUQZVnFQqN4KrgwTYHQ0q2ySXjq1UYW3s1m9SQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/memory: Fix boundary check for next PFN in folio_pte_batch()
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, 21cnbao@gmail.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:33=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 27.02.24 09:23, Lance Yang wrote:
> > Hey David,
> >
> > Thanks for taking time to review!
> >
> > On Tue, Feb 27, 2024 at 3:30=E2=80=AFPM David Hildenbrand <david@redhat=
com> wrote:
> >>
> >> On 27.02.24 08:04, Lance Yang wrote:
> >>> Previously, in folio_pte_batch(), only the upper boundary of the
> >>> folio was checked using '>=3D' for comparison. This led to
> >>> incorrect behavior when the next PFN exceeded the lower boundary
> >>> of the folio, especially in corner cases where the next PFN might
> >>> fall into a different folio.
> >>
> >> Which commit does this fix?
> >>
> >> The introducing commit (f8d937761d65c87e9987b88ea7beb7bddc333a0e) is
> >> already in mm-stable, so we would need a Fixes: tag. Unless, Ryan's
> >> changes introduced a problem.
> >>
> >> BUT
> >>
> >> I don't see what is broken. :)
> >>
> >> Can you please give an example/reproducer?
> >
> > For example1:
> >
> > PTE0 is present for large folio1.
> > PTE1 is present for large folio1.
> > PTE2 is present for large folio1.
> > PTE3 is present for large folio1.
> >
> > folio_nr_pages(folio1) is 4.
> > folio_nr_pages(folio2) is 4.
> >
> > pte =3D *start_ptep =3D PTE0;
> > max_nr =3D folio_nr_pages(folio2);
> >
> > If folio_pfn(folio1) < folio_pfn(folio2),
> > the return value of folio_pte_batch(folio2, start_ptep, pte, max_nr)
> > will be 4(Actually it should be 0).
> >
> > For example2:
> >
> > PTE0 is present for large folio2.
> > PTE1 is present for large folio1.
> > PTE2 is present for large folio1.
> > PTE3 is present for large folio1.
> >
> > folio_nr_pages(folio1) is 4.
> > folio_nr_pages(folio2) is 4.
> >
> > pte =3D *start_ptep =3D PTE0;
> > max_nr =3D folio_nr_pages(folio1);
> >
>
> In both cases, start_ptep does not map the folio.
>
> It's a BUG in your caller unless I am missing something important.

Sorry, I understood.

Thanks for your clarification!
Lance

>
>
> > If max_nr=3D4, the return value of folio_pte_batch(folio1, start_ptep,
> > pte, max_nr)
> > will be 1(Actually it should be 0).
> >
> > folio_pte_batch() will soon be exported, and IMO, these corner cases ma=
y need
> > to be handled.
>
> No, you should fix your caller.
>
> The function cannot possibly do something reasonable if start_ptep does
> not map the folio.
>
> nr =3D pte_batch_hint(start_ptep, pte);
> ...
> ptep =3D start_ptep + nr; /* nr is >=3D 1 */
> ...
> return min(ptep - start_ptep, max_nr); /* will return something > 0 */
>
> Which would return > 0 for something that does not map that folio.
>
>
> I was trying to avoid official kernel docs for this internal helper,
> maybe we have to improve it now.
>
> --
> Cheers,
>
> David / dhildenb
>

