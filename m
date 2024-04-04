Return-Path: <linux-kernel+bounces-132171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DC4899092
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDB81F2A6F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511CE13BC38;
	Thu,  4 Apr 2024 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AYfFhgZn"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EEC15EA6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712267075; cv=none; b=JPb1u83jqLjkR3XbOi+PJ5KTnZ+yWwbN9z0UU9fkiZb93FaODcLh++pgo17Z6RudZ2YqpHL7SxQBqfV8uFh4SxPIp9mhIN1D0EvpfMO7E6UKyeZwle0iqhU493M0bPqbprJBnQI+ZmBQ8dnWvTi4farKP22uxP+sDA772J0NeW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712267075; c=relaxed/simple;
	bh=DO7i1XU2k34Cx2S28rsf+J+RqV+bNWgGo4J7EkP6ZKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDpN3RoyknuGD+4IS5/QP+HUvfLY6UXSLZ6+Rb0nArXMIk28av3RYxd6FdcJGdP6Lw/poYGgMf9fpjq7eWQ7WptpzydjO0BgvOCiJQXlGvutcAJBlj2phb8MxlMB0r553WyIkApnPlYqmuLcscJ0JjNHM4KtAHUkyg7ULAUpIBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AYfFhgZn; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-479cc1791bfso374224137.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 14:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712267073; x=1712871873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j28I1CCYHEt/JOzyDtFXIH06wcxI6ew8Dw/pbr+Z6ug=;
        b=AYfFhgZnwGKYWi4eqfZ1okjgXdQd+PrJFKLY2esxxW3Q42jWE1vB4+cLOVImx81Wpc
         OQbNkCaWXbXlKCvzABVak5IR4uZK0zeN1vXDFBqOUYs/NC1GjcFPQ3OCmz3BvA5EVNpg
         PCqc8b9tLBi+w62wObZym8QQV8oPBYJePYi9VSsUa/Ab/zi/LCO7R11hGopsVw1bpYK+
         ADrQ+IaynCOz9eGzK9VLqR+bGN0IBTkvzx42zPjW7T3oNCjhu+kTEaXOoPy2TAm7mn4C
         n/AdBecoWOSLhfw+5BSro7YwcvhIxyTZb14FIEX+Q5zsT8JooYmyg5ic4L6xRP01vqbx
         73GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712267073; x=1712871873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j28I1CCYHEt/JOzyDtFXIH06wcxI6ew8Dw/pbr+Z6ug=;
        b=TRSaqNFAZxrhlmqDDw/crzpX1B+9EUpF1dRJ5ZEugE/6YyD+ZTxAZMe5JKJjTDmYPH
         /vP5SoJXpWMwXukzu6BGYspW+pk2RJGM23yfL2KbwnuxThcu45LFb9norSJKOAismPKm
         6LHs5TP04FzO0FHXm33VmCrEK63B9WuU3n/mOClIfyaGw5gqq4S1om2/1GXIsEVWCu+3
         DNLxHyc13yJ+GSIl6wCFSOYapV8ouk1ukRJ54WCPvA+DGNAkLDkH6zmpOkst7bC/PJu3
         tAwIHK75XWlEhuPgrW1nS2/m+c1CbeLe0m4P/1+2Kp0dGXx+WaL02ZKf40oJwrVe3Qrr
         JMJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx5YevOvYpXy0VdS31gxA8AyWEb5x5C55y7Dpz48aGQEwe0gEgco2S4p3a8/3cfKrIAzfalwgHdg1YXo+9SEOUBi/Z8zRKp1NUUiKQ
X-Gm-Message-State: AOJu0YzhqE7hJEuXcHOF0fSn/qoh8zGqMnEZ3xk+N85U2tUPiEWDcVHa
	us++YCNfuaOzgUkdaHJ75cqZL9P0HN5Bxnzsk2ckoWVMzEiiAovfhNO2YP4eKoePkpeZZxYRKr1
	d+4PpkpqqPa34b5ZM6HZ3gDfOhHJDAro5kDyK
X-Google-Smtp-Source: AGHT+IHCoc5srOPRPl6ct1l7nD86qQ+kfsIrX9sZJWk0vU4O+qwPM9eOC2FFUSXJSf9L303FCKE0hC++lB6bgom7UNw=
X-Received: by 2002:a05:6102:2045:b0:476:df40:b366 with SMTP id
 q5-20020a056102204500b00476df40b366mr1077203vsr.32.1712267072793; Thu, 04 Apr
 2024 14:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404162515.527802-1-fvdl@google.com> <20240404162515.527802-2-fvdl@google.com>
 <e74cfee3-565f-4c69-bb7b-bdd40d01d212@redhat.com>
In-Reply-To: <e74cfee3-565f-4c69-bb7b-bdd40d01d212@redhat.com>
From: Frank van der Linden <fvdl@google.com>
Date: Thu, 4 Apr 2024 14:44:21 -0700
Message-ID: <CAPTztWbpDizLVk14jfxtS8mzQo3KvR+3KHiAiksxCXo=SQ4HrQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/hugetlb: pass correct order_per_bit to cma_declare_contiguous_nid
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, muchun.song@linux.dev, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 1:13=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 04.04.24 18:25, Frank van der Linden wrote:
> > The hugetlb_cma code passes 0 in the order_per_bit argument to
> > cma_declare_contiguous_nid (the alignment, computed using the
> > page order, is correctly passed in).
> >
> > This causes a bit in the cma allocation bitmap to always represent
> > a 4k page, making the bitmaps potentially very large, and slower.
> >
> > So, correctly pass in the order instead.
> >
> > Signed-off-by: Frank van der Linden <fvdl@google.com>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepag=
es using cma")
>
> It might be subopimal, but do we call it a "BUG" that needs "fixing". I
> know, controversial :)
>
> > ---
> >   mm/hugetlb.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 23ef240ba48a..6dc62d8b2a3a 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -7873,9 +7873,9 @@ void __init hugetlb_cma_reserve(int order)
> >                * huge page demotion.
> >                */
> >               res =3D cma_declare_contiguous_nid(0, size, 0,
> > -                                             PAGE_SIZE << HUGETLB_PAGE=
_ORDER,
> > -                                              0, false, name,
> > -                                              &hugetlb_cma[nid], nid);
> > +                                     PAGE_SIZE << HUGETLB_PAGE_ORDER,
> > +                                     HUGETLB_PAGE_ORDER, false, name,
> > +                                     &hugetlb_cma[nid], nid);
> >               if (res) {
> >                       pr_warn("hugetlb_cma: reservation failed: err %d,=
 node %d",
> >                               res, nid);
>
> ... I'm afraid this is not completely correct.
>
> For example, on arm64, HUGETLB_PAGE_ORDER is essentially PMD_ORDER.
>
> ... but we do support smaller hugetlb sizes than that (cont-pte hugetlb
> size is 64 KiB, not 2 MiB -- PMD -- on a 4k kernel)

Right,  smaller hugetlb page sizes exist. But, the value here is not
intended to represent the minimum hugetlb page size - it's the minimum
hugetlb page size that we can demote a CMA-allocated hugetlb page to.
See:

a01f43901cfb ("hugetlb: be sure to free demoted CMA pages to CMA")

So, this just restricts demotion of the gigantic, CMA-allocated pages
to HUGETLB_PAGE_ORDER-sized chunks.

- Frank

