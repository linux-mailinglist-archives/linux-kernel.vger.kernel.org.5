Return-Path: <linux-kernel+bounces-159525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB358B2FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90CA28405F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDE913A279;
	Fri, 26 Apr 2024 05:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlsFfMgc"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA1713A271
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 05:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714109807; cv=none; b=Q0uWzkvHkCKP4GYUJuf76jUZnyifIVCAIZeQRWbDXfQnxJ4FPCy93UcdWpeWbvqymtaXd+2Ok9lH+E1x0xOu2eLD/kMDkR915MSu+cX/Uby/yOih/itA/sDw9cuxQZnOMKLCXh0YhUtEXnWMBEQr35Az0L6tooo/VzoHH3nAXjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714109807; c=relaxed/simple;
	bh=NNkq0zGDVAvXUD7gt5Xb4JVzIcOqT5Cwhmcg2rtLrXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bG2J4mL7hhcHLjaKoCvIhLCDqukavavF8wddz1SqXFL2gAm0ir+0a1wAVyKCbAe0sBhNkGmUTLPb+YYGK1WQIBzSeB4o+W/dIsUglGbUatMQVYRAd5yUCHAUvsPPvNCJ/4pdmw2Jfzc9bYXfDKzw3k8LwPs8KtrQa9Am0PurpmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlsFfMgc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-571c2055cb1so421068a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714109804; x=1714714604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lc8iU/v3P10/yMOncB/G3mR9tNm+X0e5zlPO4UZDD50=;
        b=YlsFfMgcO0b+SJnNuBMJ0SDzLTK+8ieRlNznIjkq8OiHcpbdKFGz3OCHtLRK3PlxaL
         xApbfmGm9Ryvi6alKuazZvWxzdmb855L5U8SfIl73SFBf0JPpR95qsthV2/B2QK+yaN1
         MZbFaPm9tSApPR8F/MlJNx0WMbjDUy4IVagqtgWiRzPjf9D7kp/8CXrNh/1oBayZ+N3u
         IyXQKqf4+FjoIQb7VTevkLKB2EdxffUH1iLElUqUQXHUpUKmxc1LCv9nC8LYHG/2Xbg5
         a4J8wsFSCMOcA3TosZ/oety2JPpMlqwiAAnOKEn3twsTS0s0Wp5nk1BkRDNo66J/dndo
         C6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714109804; x=1714714604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lc8iU/v3P10/yMOncB/G3mR9tNm+X0e5zlPO4UZDD50=;
        b=gxyq9tt5qGsvjC1Y87xfDMl5T2ltg+K0O7NjdSzFse+R/rS70JsB5deSaA2UTIcL9W
         slegTksCb2N3xj08Igntds18o5PRCJBU8mbf1XRyp72T2obOwMBTWExUTahi61f3Nq98
         JaTC6Pha9REJglmMXK/NFkcNf5ap8bF/Zy3TQG6RFrCEs8jVZ3ZXmdv0Fkcg0xd16uQo
         vgLNza8GuxyW0QNQqyMqQcELiAVh48dclG+ONULKELJBe6wEhwUJ4PHfv5kN/Cn1t2/q
         GAXkK+WvMaby/81W5cZgZXSYO7BlHpTGcrKAlW4ZjD9tBQfmGd6VCmj6dt/H7bKXFDUJ
         5ooA==
X-Forwarded-Encrypted: i=1; AJvYcCUnR9ZdzpSXPHZ06f3S+arSqYJhGPfHDp63m8bdRKuahvgreImsYr9aV+f1bBjpFeKppndFdmK7KXAmROCA4138X8LA/ebkonpMvoYM
X-Gm-Message-State: AOJu0YwwOlof0fEp88t0YYcvPESAp9d1mYvaotcg/6nPl9QSjhYSQG2h
	0T5xBvcFr4aDJHRLuEHz5BBBG4X5hgmN263om10o/a5ML4BWufwOereSKIHdoNli9YSt2huKbE3
	Dlfu/hvEjyPWCwzH8NsGyfozF8UhgHPmySrY=
X-Google-Smtp-Source: AGHT+IFtRB+ue+V6NPjuiSDB3WY/guLQo3ngUF4p7TfZrKiT6CEMmOSRx5mQwx3IiC1H43AO4PRgtI8NE+OzK/gwlqM=
X-Received: by 2002:a50:d5d3:0:b0:56e:3f0:a163 with SMTP id
 g19-20020a50d5d3000000b0056e03f0a163mr1289583edj.14.1714109803820; Thu, 25
 Apr 2024 22:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425211136.486184-1-zi.yan@sent.com> <CAK1f24nZFJKAyEX3A8DsFA8_VkdtYiB251WxvTa9fcnmi01aOg@mail.gmail.com>
In-Reply-To: <CAK1f24nZFJKAyEX3A8DsFA8_VkdtYiB251WxvTa9fcnmi01aOg@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 26 Apr 2024 13:36:32 +0800
Message-ID: <CAK1f24=ouD18JHWEGOW4hmauU-J=QQE9MQQA+shm0XX-SPLhMQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Yang Shi <shy828301@gmail.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, 
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 11:45=E2=80=AFAM Lance Yang <ioworker0@gmail.com> w=
rote:
>
> On Fri, Apr 26, 2024 at 5:11=E2=80=AFAM Zi Yan <zi.yan@sent.com> wrote:
> >
> > From: Zi Yan <ziy@nvidia.com>
> >
> > In __folio_remove_rmap(), a large folio is added to deferred split list
> > if any page in a folio loses its final mapping. But it is possible that
> > the folio is fully unmapped and adding it to deferred split list is
> > unnecessary.
> >
> > For PMD-mapped THPs, that was not really an issue, because removing the
> > last PMD mapping in the absence of PTE mappings would not have added th=
e
> > folio to the deferred split queue.
> >
> > However, for PTE-mapped THPs, which are now more prominent due to mTHP,
> > they are always added to the deferred split queue. One side effect
> > is that the THP_DEFERRED_SPLIT_PAGE stat for a PTE-mapped folio can be
> > unintentionally increased, making it look like there are many partially
> > mapped folios -- although the whole folio is fully unmapped stepwise.
> >
> > Core-mm now tries batch-unmapping consecutive PTEs of PTE-mapped THPs
> > where possible starting from commit b06dc281aa99 ("mm/rmap: introduce
> > folio_remove_rmap_[pte|ptes|pmd]()"). When it happens, a whole PTE-mapp=
ed
> > folio is unmapped in one go and can avoid being added to deferred split
> > list, reducing the THP_DEFERRED_SPLIT_PAGE noise. But there will still =
be
> > noise when we cannot batch-unmap a complete PTE-mapped folio in one go
> > -- or where this type of batching is not implemented yet, e.g., migrati=
on.
> >
> > To avoid the unnecessary addition, folio->_nr_pages_mapped is checked
> > to tell if the whole folio is unmapped. If the folio is already on
> > deferred split list, it will be skipped, too.
> >
> > Note: commit 98046944a159 ("mm: huge_memory: add the missing
> > folio_test_pmd_mappable() for THP split statistics") tried to exclude
> > mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does not
> > fix the above issue. A fully unmapped PTE-mapped order-9 THP was still
> > added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
> > since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
> > deferred_split_folio() the order-9 folio is folio_test_pmd_mappable().
> >
> > Signed-off-by: Zi Yan <ziy@nvidia.com>
> > Reviewed-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/rmap.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index a7913a454028..220ad8a83589 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rmap(=
struct folio *folio,
> >                  * page of the folio is unmapped and at least one page
> >                  * is still mapped.
> >                  */
> > -               if (folio_test_large(folio) && folio_test_anon(folio))
> > -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdm=
apped)
> > -                               deferred_split_folio(folio);
> > +               if (folio_test_large(folio) && folio_test_anon(folio) &=
&
> > +                   list_empty(&folio->_deferred_list) &&
>
> FWIW
>
> Perhaps it would achieve the same check, ensuring that at least one
> page of the folio is unmapped while at least one page remains mapped.
>
>  +                   atomic_read(mapped) && nr < folio_nr_pages(folio))
>  -                   ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(mapped)=
) ||
>  -                    (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapped))=
)

Second thought: it=E2=80=99s probably best to leave it as is. The compiler =
should
optimize out based on the level enum, which is what I overlooked.

Thanks,
Lance

>
> Thanks,
> Lance
>
>
> > +                   ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(mapped=
)) ||
> > +                    (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapped)=
))
> > +                       deferred_split_folio(folio);
> >         }
> >
> >         /*
> >
> > base-commit: 66313c66dd90e8711a8b63fc047ddfc69c53636a
> > --
> > 2.43.0
> >

