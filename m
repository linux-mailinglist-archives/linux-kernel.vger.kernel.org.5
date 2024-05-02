Return-Path: <linux-kernel+bounces-166787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421308B9F7D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7FF1C22441
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5C516FF4E;
	Thu,  2 May 2024 17:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GF2pJc9p"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D3A16FF43
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670860; cv=none; b=jAOWvFefzQUQ5o+EI1ktQAJeHlyCzQ3xFTT6sTX95b8TNsPVW3Usu8nk3GjAe0LQvWmoAzQj8BK/LaxmVG0xWTDSf4rFicmrPu52+R2ECWWn6FzwPrGxxsBt92sEItQmBza42yHBqG93ATzd5O/aI2pkyHKnJCscml7BkbZktVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670860; c=relaxed/simple;
	bh=IODz6rURhmbvGrZ5LohgKuLkW2J02pSbwFR6mCjv3xY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTdc4G+boMuB4nQ+gXFjqIFHUT74rv0jpVX0+NnNAkZ0ETpmJAE7vweYcrb4Dq+MzL5KJnmX8/eA++geoXAJxNQI09dH0S0W2RRXpdhQMdV+eXmfw0w3NRoun4D3bZnKvKJEhqXB18VLtlwy4k4MhNs4L3n0BjLXmsGwmkUYUys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GF2pJc9p; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-47a404c6decso2422179137.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 10:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714670857; x=1715275657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUNTNSxf5jFZNiSIENiFHEDs4SL26oCzRgNOWpdMUDI=;
        b=GF2pJc9pUvoAaNiTQi7bPplrbypCYDd3HfHa7EM/NzApHVbtIuBi9qYSRVF+ZrOKrm
         Kz6LBsULgcKOTeHRvq4y/F61DdZ9YTEiAtyhZpVHai+SjcKcQWdKsvCFDr/Z/uM43JD/
         A0FdlY1/8y2UL8GhBpGuT7K2cq1EX2ZVis4T9uiRm9rWnt03neLf729qMiMLen5Nf6au
         r+TM7ZfDyPChGvtZW9iaGe2PMeoeNJ0fLldxDgTD0cNyrbjroKQEbsD/NfrQjV7paJ4m
         SHwhm76SOc5hKNTySErQxayBboz/X6tldXLC3XRULAc/uKKd5GXmIj5rPAfXX5Z9cFrd
         t2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714670857; x=1715275657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUNTNSxf5jFZNiSIENiFHEDs4SL26oCzRgNOWpdMUDI=;
        b=f+vhKLbGPOiYUvrtZ9FV9o7R8T8P7WUA3g/m64GIpOLJIRPDNqidm461YcHNKKUNx1
         N4pckIdMFH2jfELUENemPeG+5kNpxdL02VsUYOe1POCrNT8fTwSvFDnDkZutEZv7dgHp
         9VOak4TFsMa8azgs2MmcfDbs9VywkbMLpXxaFJuNlVncmnnc8IDn5q3SzkJhREhv2Tjq
         kc9EpK5fXOtmW8ADP9rhKRSmbVseK7abA2rlNyBZpnFZBfZloGEiq/dduD2jfs7IzJsb
         WfGQ4ldJmipXM4XMnw2ld86UWqsM/rxgsyrbf8e3GIqe1kOSaAbV9Iw42dS7l85UrUZE
         FDjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7ixipvCnxViuJBLTglsqKvgdJWT25r52mr806Sbn+Ru7RxrdtWNc5U4XMds53Cmm4TCVCyqAj0zaV1W2PSuRK9+2MTroEF2vNc5vv
X-Gm-Message-State: AOJu0YxACg7io7TyfUK1+HwkDhpdAHjd7v1S5gFXyrBGgzoLaERdUKeR
	q6t1tq6HyH/J26AOMagovY+0Yancsu4iCWn77wVVlM3FfEKqJDIzN1NIUUUkOPmJT8mJxIh4kA+
	ebezMeSg8n3yLC1c1wvXs27fUX26yXRf61QI9
X-Google-Smtp-Source: AGHT+IETS7W+0UiiCxMHSkWyqgFGBmGn1czdfEi9XQryWuBAq1ubtfmmYxw+yY12+x/JSJ5/L7jKzJduZF8+8/1rnI4=
X-Received: by 2002:a05:6122:4319:b0:4db:223b:1c0a with SMTP id
 cp25-20020a056122431900b004db223b1c0amr408732vkb.11.1714670857208; Thu, 02
 May 2024 10:27:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430161437.2100295-1-fvdl@google.com> <f44e3b1b-d8f7-4b5c-a66b-13ae3f3d53bd@redhat.com>
In-Reply-To: <f44e3b1b-d8f7-4b5c-a66b-13ae3f3d53bd@redhat.com>
From: Frank van der Linden <fvdl@google.com>
Date: Thu, 2 May 2024 10:27:25 -0700
Message-ID: <CAPTztWZB1kYCETiwEAdemrqgPC+KmRMHTvb945BPjCo4QgWQvQ@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: align cma on allocation order, not demotion order
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, muchun.song@linux.dev, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 6:15=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 30.04.24 18:14, Frank van der Linden wrote:
> > Align the CMA area for hugetlb gigantic pages to their size, not the
> > size that they can be demoted to. Otherwise there might be misaligned
> > sections at the start and end of the CMA area that will never be used
> > for hugetlb page allocations.
> >
> > Signed-off-by: Frank van der Linden <fvdl@google.com>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Fixes: a01f43901cfb ("hugetlb: be sure to free demoted CMA pages to CMA=
")
> > ---
> >   mm/hugetlb.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 5dc3f5ea3a2e..cfe7b025c576 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -7794,7 +7794,7 @@ void __init hugetlb_cma_reserve(int order)
> >                * huge page demotion.
> >                */
> >               res =3D cma_declare_contiguous_nid(0, size, 0,
> > -                                     PAGE_SIZE << HUGETLB_PAGE_ORDER,
> > +                                     PAGE_SIZE << order,
> >                                       HUGETLB_PAGE_ORDER, false, name,
> >                                       &hugetlb_cma[nid], nid);
> >               if (res) {
>
> I was wondering how that worked when reviewing your other patch.
> Wondering why we never got a BUG report, maybe we were always lucky
> about the alignment we actually got?

I think this issue was probably masked by the hugetlb allocator
falling back to direct alloc_contig_pages allocation if cma_alloc
fails. So if you're not under memory pressure, the failure to allocate
from the misaligned areas might not have been noticed.

I noticed it, because I was working with change I made: a flag that
prevents the fallback to straight alloc_contig_pages, as that behavior
may not be desired - you don't want to potentially eat in to
non-movable space that the kernel needs, it might be better to fail if
there's no CMA available.
>
> We round up size to PAGE_SIZE << order, so that's the alignment we need.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!

