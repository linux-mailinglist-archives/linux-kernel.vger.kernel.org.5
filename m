Return-Path: <linux-kernel+bounces-141498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF558A1F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6919D1F23472
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99B913AE2;
	Thu, 11 Apr 2024 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsngoCEo"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB7EEB5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862094; cv=none; b=YaLauVG0Rn5Y7GrxGGCxLdhEMBcUH51Wcyn/grm1cJmfdLOPcZ16PzIcbJJbjIbsqMoCuwz9gufHF4CvriyyHoiEIiq8XR/Ww2njdv8075H2feqT5+dC+OEzXLpKWeuhoxr5MZhkE8rGEFM/D6NAbt+p+pYGmudhzpjb77HeSuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862094; c=relaxed/simple;
	bh=ce00B21aveQD28I0QeBY2SGRTUBz8TXcd6Ao9V6K2CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpibS5TxO0PWVIPiJXF42SaY3+XUDiF4mANeNlVrmZ1fnLgr/BKL5KOs1YIuF39EQBHlVaildD9YbTxsil5z3hKBcWtjSL+nHIfPp8xHezZf/duA51L1JNlYu0YZ7Bl7uVLdSxzsIwemabB4i08MpgyvDi0OB3+0v2gs439qmbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsngoCEo; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso153403a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712862091; x=1713466891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=On0pdQbnNfIXAmUmoEHJcbDmNfZu81x6Td0YfnGw5JQ=;
        b=AsngoCEo9XcNbKG9Wq7EyqvFHjYuSSZM0mH6VCV5ugoYKgLMnZxMyd15kIVr4IyzCf
         Bt5jerZwnhu6ZEDBbyRo+Ed7aDqbySkkY9ramRqxzbJ1DbsnfcGy8b5QBxx0jHAzHE/0
         VO0Q/vTmix2JKjpD5RRIR1sFZb9Gk+reeW/p0tAqR6h7ATr5j4ttQR2VbGUBPSq0bDk7
         3mRs4Xhy1rdnKbIJMhskGo4pYB6QXjLoEWwJSMk+IvlnIbMoEIALEwidYViOkUJozbgl
         HeUFoeFVs0oZeQ8vHqgivXS9jQzTp3Jxlkoh8IGktY/g+Xcd7x1ChruFymK55uuJGtLS
         nXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712862091; x=1713466891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=On0pdQbnNfIXAmUmoEHJcbDmNfZu81x6Td0YfnGw5JQ=;
        b=a9CsR2T3ZX5ZnDIZvBQhjsKgRx5GNoRvM66imt/ItS1KptAGamkAyg4jd90pIGnAh7
         79JOVcLnvJzRPrFP2XR3fRmYp1dZsXX2qw8b4INITqhp69OOxegItGudPNUAboOhf3pD
         1xbquzqQmAU7cd0PH2BrxlizLi6dEH+CptmeDYi8lsSQm+NssZgJq/S2ExqQllDUcQmX
         3qcOlabGMM5mT/LEF2KnrSa8rczrYVn2Z2K39eBhf6g4ck7NfyG/3zUilCjM8gbsgr4K
         GpGCKE4Gl7rYuJa+Ty9TVJirifHon+hdFPMbrgxtnS4Pe+YA1OcWK90+70lz+7ctjwwf
         NM4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQYqmTHRtJvfk4I9hzDwprn+fNw4KmvWmrFL39tYmcHrAsVc2PX7MmRHahYyla6mpbU1Z+ujJ6hWkmQ2aXjqgI2Z4LRceaq11q1pBQ
X-Gm-Message-State: AOJu0Yy5JWJvh2kAFYuky0sXo36doq9tSA7vXw9QeqgCzLpu6Jm3ylzf
	qVuHup5/m5uims8E3gYxAU7NWMSUAVlZheI9fniE78SFnN4lZZ35QBwG2VX4LGYyAjJ4Hjz3dK7
	159q0TClpTdJNFwi4PypSyfxdATgvNw==
X-Google-Smtp-Source: AGHT+IEJF/JNfb/P01W/FbeAKWb/rxSbfj/2/v/ZSbO4AFGp9NdlPHKK2XNQzjMTNnx5KnDdwFSADAJdlKtwzsVoVRY=
X-Received: by 2002:a50:a69e:0:b0:56d:b687:5a45 with SMTP id
 e30-20020a50a69e000000b0056db6875a45mr438862edc.1.1712862090359; Thu, 11 Apr
 2024 12:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411153232.169560-1-zi.yan@sent.com> <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
In-Reply-To: <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 11 Apr 2024 12:01:19 -0700
Message-ID: <CAHbLzkr99knWKZvE4WCWKKr=eezkg89idpE59oo_oBneAQynAA@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 8:46=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 11.04.24 17:32, Zi Yan wrote:
> > From: Zi Yan <ziy@nvidia.com>
> >
> > In __folio_remove_rmap(), a large folio is added to deferred split list
> > if any page in a folio loses its final mapping. It is possible that
> > the folio is unmapped fully, but it is unnecessary to add the folio
> > to deferred split list at all. Fix it by checking folio mapcount before
> > adding a folio to deferred split list.
> >
> > Signed-off-by: Zi Yan <ziy@nvidia.com>
> > ---
> >   mm/rmap.c | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 2608c40dffad..d599a772e282 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1494,7 +1494,7 @@ static __always_inline void __folio_remove_rmap(s=
truct folio *folio,
> >               enum rmap_level level)
> >   {
> >       atomic_t *mapped =3D &folio->_nr_pages_mapped;
> > -     int last, nr =3D 0, nr_pmdmapped =3D 0;
> > +     int last, nr =3D 0, nr_pmdmapped =3D 0, mapcount =3D 0;
> >       enum node_stat_item idx;
> >
> >       __folio_rmap_sanity_checks(folio, page, nr_pages, level);
> > @@ -1506,7 +1506,8 @@ static __always_inline void __folio_remove_rmap(s=
truct folio *folio,
> >                       break;
> >               }
> >
> > -             atomic_sub(nr_pages, &folio->_large_mapcount);
> > +             mapcount =3D atomic_sub_return(nr_pages,
> > +                                          &folio->_large_mapcount) + 1=
;
>
> That becomes a new memory barrier on some archs. Rather just re-read it
> below. Re-reading should be fine here.
>
> >               do {
> >                       last =3D atomic_add_negative(-1, &page->_mapcount=
);
> >                       if (last) {
> > @@ -1554,7 +1555,9 @@ static __always_inline void __folio_remove_rmap(s=
truct folio *folio,
> >                * is still mapped.
> >                */
> >               if (folio_test_large(folio) && folio_test_anon(folio))
> > -                     if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmap=
ped)
> > +                     if ((level =3D=3D RMAP_LEVEL_PTE &&
> > +                          mapcount !=3D 0) ||
> > +                         (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdma=
pped))
> >                               deferred_split_folio(folio);
> >       }
>
> But I do wonder if we really care? Usually the folio will simply get
> freed afterwards, where we simply remove it from the list.
>
> If it's pinned, we won't be able to free or reclaim, but it's rather a
> corner case ...
>
> Is it really worth the added code? Not convinced.

It is actually not only an optimization, but also fixed the broken
thp_deferred_split_page counter in /proc/vmstat.

The counter actually counted the partially unmapped huge pages (so
they are on deferred split queue), but it counts the fully unmapped
mTHP as well now. For example, when a 64K THP is fully unmapped, the
thp_deferred_split_page is not supposed to get inc'ed, but it does
now.

The counter is also useful for performance analysis, for example,
whether a workload did a lot of partial unmap or not. So fixing the
counter seems worthy. Zi Yan should have mentioned this in the commit
log.

>
> --
> Cheers,
>
> David / dhildenb
>

