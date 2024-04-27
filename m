Return-Path: <linux-kernel+bounces-160979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF098B455F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 11:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885571C20FE4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 09:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9805E47A7D;
	Sat, 27 Apr 2024 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWQC7TDc"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558C946424
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714210340; cv=none; b=Q5h/s9nNGC0/yNZxiMFM2mSqprjGvtlBLhfklL+026HPqQzIUlkY/F31WOLcFVJZVv7i03/VHshRKNwbaOECdCgWRI8n8lZWS/D6xgdfzUROM8BGVTopbWCAQKRWveW4UA5PZc/848C4P6O2smgWzbObtsfwXmNVD0xm2j8mWoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714210340; c=relaxed/simple;
	bh=gm/k2/7xGLSlKafmjWF+EVOPfqyzb/z2M5ENx0VPP0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H799OCSQ1d92+Wq69/4D50BwkpQFfPNcDfVULUCGf3iNRhpUochP5iuad9TKG3/8tHW4E/J49SQe8MiHEez0yPj6YSg39+sazsortv8q5yy/YzqI4GyrpuWO8aGaBTmPSWKO5o4kgdWjDXAvrWtvzTs2ScHon2RFpTjW+i1+TGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWQC7TDc; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-479d1454cb4so1024052137.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 02:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714210338; x=1714815138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miy8rObJQOFD7a6RxpdDR5fplId/ZmKxfdplFT7AJPU=;
        b=QWQC7TDcrWXk3Gra5tTr1ClvLle5Ckc/si0rI0GMG6P78ojFddeoM7WEC9L+qmAufY
         zLaCdaFecMNjoGEfp2q6wB5EnDvBy0SJsLR4nKA3Nkz03ueViRpw3JvclVQIDYxRo2om
         h93H5nJNHrvIMuuSZEvhoH2CBXTAg2d64ze103Totv2doA7DNAej/92nWZ8OgAeF1PgI
         WSzt8gOTOf+4iwxOmG6RYwKNkhRG0qfmgn5X6qtqtKmnapD8ZxKQYIAde52xp2D8oZVG
         kk6WhFZyyaBmhGKo9StICQy4zMLF2381YzmKuG+cFofiNp+RNZZQMCMmzbNCdmOJRs4O
         cGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714210338; x=1714815138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miy8rObJQOFD7a6RxpdDR5fplId/ZmKxfdplFT7AJPU=;
        b=SwK3AORsQB2BVHuCk/maY0nOcAS6Ph0T/XWJ63xxkq6e9BB8I4087EF9KvPe1Lpe2U
         WzQ7exEpxIrdNv7fhCE3ZPkbU7hRBS+6XwfUniqf8upmc5dvr0tu1SSmlfdO7GVxALpl
         SRSIxBjl/OwcEwD38OMQtEM3k696p5yHN+JE4Zw/B+7QCfe8/8pTrvfIQVhU7APyYOA9
         WV0H2JL0v4M48DtWezOOWI6/FTrLQQzVueASBEMm8pd15EKews6pdChcYXQIxmioMvk7
         GSk/GS72ZdGxAAqnuY/HVGbmXubSC6R79mh9KHMnZUWwYoO5jE+QtWSJxZJy/ULmyoTy
         jWyw==
X-Forwarded-Encrypted: i=1; AJvYcCXRyVGPgzh1qiF3lV+txty2y3tzTWkwDSGOP/jAXWzGk49M9ZoTPbr90qRNRwHssRXlRSf5brYZPDhKzUoph9KizW7fUgbENstz6ddD
X-Gm-Message-State: AOJu0YxriNczvt1EF+VhFmUwqarWpa48dIokWK1Ow/IMnOT4x5re9gzg
	ANJuKAoBvbeDFwMA4VzCfuiI26DzCyDVkczT2g6BGuQtLUIaf65IV3H83xvSmG43BoRdauDUz4e
	0+zv1nhA37NZZ4dmqIi81klk8l88=
X-Google-Smtp-Source: AGHT+IGI2EMELholAHRxu2R2Fs8lKaa4cJMxVhzg55OuCrkk7HwFt7DoLKSdDNYH6JZpirbIOCLkUu38yY2kccbCpOs=
X-Received: by 2002:a67:e947:0:b0:47b:c614:8bd8 with SMTP id
 p7-20020a67e947000000b0047bc6148bd8mr5664441vso.12.1714210336722; Sat, 27 Apr
 2024 02:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426190253.541419-1-zi.yan@sent.com> <e274ad3b-bbeb-49b0-81bf-24fd33106f05@redhat.com>
 <CB058583-C99A-4897-B3AE-11C56D6E3A59@nvidia.com>
In-Reply-To: <CB058583-C99A-4897-B3AE-11C56D6E3A59@nvidia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 27 Apr 2024 17:32:04 +0800
Message-ID: <CAGsJ_4wEGhL7rRPP_soiEt5bjnpa3zhPnU+8JrNLZvWdcRNuqg@mail.gmail.com>
Subject: Re: [PATCH v5] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Yang Shi <shy828301@gmail.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 3:20=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On 26 Apr 2024, at 15:08, David Hildenbrand wrote:
>
> > On 26.04.24 21:02, Zi Yan wrote:
> >> From: Zi Yan <ziy@nvidia.com>
> >>
> >> In __folio_remove_rmap(), a large folio is added to deferred split lis=
t
> >> if any page in a folio loses its final mapping. But it is possible tha=
t
> >> the folio is fully unmapped and adding it to deferred split list is
> >> unnecessary.
> >>
> >> For PMD-mapped THPs, that was not really an issue, because removing th=
e
> >> last PMD mapping in the absence of PTE mappings would not have added t=
he
> >> folio to the deferred split queue.
> >>
> >> However, for PTE-mapped THPs, which are now more prominent due to mTHP=
,
> >> they are always added to the deferred split queue. One side effect
> >> is that the THP_DEFERRED_SPLIT_PAGE stat for a PTE-mapped folio can be
> >> unintentionally increased, making it look like there are many partiall=
y
> >> mapped folios -- although the whole folio is fully unmapped stepwise.
> >>
> >> Core-mm now tries batch-unmapping consecutive PTEs of PTE-mapped THPs
> >> where possible starting from commit b06dc281aa99 ("mm/rmap: introduce
> >> folio_remove_rmap_[pte|ptes|pmd]()"). When it happens, a whole PTE-map=
ped
> >> folio is unmapped in one go and can avoid being added to deferred spli=
t
> >> list, reducing the THP_DEFERRED_SPLIT_PAGE noise. But there will still=
 be
> >> noise when we cannot batch-unmap a complete PTE-mapped folio in one go
> >> -- or where this type of batching is not implemented yet, e.g., migrat=
ion.
> >>
> >> To avoid the unnecessary addition, folio->_nr_pages_mapped is checked
> >> to tell if the whole folio is unmapped. If the folio is already on
> >> deferred split list, it will be skipped, too.
> >>
> >> Note: commit 98046944a159 ("mm: huge_memory: add the missing
> >> folio_test_pmd_mappable() for THP split statistics") tried to exclude
> >> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does no=
t
> >> fix the above issue. A fully unmapped PTE-mapped order-9 THP was still
> >> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
> >> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
> >> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable().
> >>
> >> Suggested-by: David Hildenbrand <david@redhat.com>
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >> ---
> >>   mm/rmap.c | 12 +++++++++---
> >>   1 file changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/mm/rmap.c b/mm/rmap.c
> >> index 2608c40dffad..a9bd64ebdd9a 100644
> >> --- a/mm/rmap.c
> >> +++ b/mm/rmap.c
> >> @@ -1495,6 +1495,7 @@ static __always_inline void __folio_remove_rmap(=
struct folio *folio,
> >>   {
> >>      atomic_t *mapped =3D &folio->_nr_pages_mapped;
> >>      int last, nr =3D 0, nr_pmdmapped =3D 0;
> >> +    bool partially_mapped =3D false;
> >>      enum node_stat_item idx;
> >>      __folio_rmap_sanity_checks(folio, page, nr_pages, level);
> >> @@ -1515,6 +1516,8 @@ static __always_inline void __folio_remove_rmap(=
struct folio *folio,
> >>                                      nr++;
> >>                      }
> >>              } while (page++, --nr_pages > 0);
> >> +
> >> +            partially_mapped =3D !!nr && !!atomic_read(mapped);
> >
> > Nit: The && should remove the need for both !!.
>
> My impression was that !! is needed to convert from int to bool and I do
> find "!!int && !!int" use in the kernel. If this is unnecessary, Andrew
> can apply the fixup below. I can send a new version if it is really neede=
d.
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index a9bd64ebdd9a..c1fd5828409b 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1517,7 +1517,7 @@ static __always_inline void __folio_remove_rmap(str=
uct folio *folio,
>                         }
>                 } while (page++, --nr_pages > 0);
>
> -               partially_mapped =3D !!nr && !!atomic_read(mapped);
> +               partially_mapped =3D nr && atomic_read(mapped

Reviewed-by=EF=BC=9ABarry Song <baohua@kernel.org>

>                 break;
>         case RMAP_LEVEL_PMD:
>                 atomic_dec(&folio->_large_mapcount);
>
> >
> > Reviewed-by: David Hildenbrand <david@redhat.com>
>
> Thanks.
>
> --
> Best Regards,
> Yan, Zi

