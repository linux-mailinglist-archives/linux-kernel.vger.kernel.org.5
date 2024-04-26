Return-Path: <linux-kernel+bounces-160676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 228DA8B40F1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0101F22B95
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE992C1A7;
	Fri, 26 Apr 2024 20:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmcvHsVC"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F4D2907
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714164188; cv=none; b=ngpOAZCUN5GgqcFScVIhpbZpYGHg0kaj6so/0DuaR/6GNZ7xRqOb+SbMMHPiY8GnBkLs5mQAxLM9k6VrJjbe7m+W6j0ptip0RBOOhlMU8dY2jh/50NxDQFXdSh357+4lqkBC1EnkJa+6x9P7gBHLAHJLYscsAWR2hZI1xcvS+44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714164188; c=relaxed/simple;
	bh=BBR96LaW4Vs7bchHlk90vM6AfN08uRrFi9ZABUR8U4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvGvIvMoeOeMnjUVk7Hjrm4oA+bd0UkHOwu80AeL2sWrU5yqVMa9EhqGte22dRQVHc2weY1VgEhwN46xwCpSmQXAjsJpq3txAhubqigyShaUQkXtQ/qp/hPN1PVuF7NpCxPs8k4yhCB7OXahq+oUMR2Sx6QXDcX9Ud+cSBhP6ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmcvHsVC; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5724e69780bso2190413a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714164185; x=1714768985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueA8BocmTSJNHsyrYj2TNISaWPcMWAXxPevjbN2I4Kk=;
        b=HmcvHsVCT5OhzpNcYXJ7SU7ENsNwetBD5gKN579hEvySVt7lPO3ULIYHHTO30DWdM5
         zi+8UL+4FtKSWDeyUVIABZP9pYaG+cOax/1oQYD6+F/1eRLcDnAvfNXCUHFPIzDwZHHG
         vLA6wren5hPc4Jr+UektUNOmOwvLyr7Mm82sScxfHVk6jt3RLfh4BFLBZL84Qn50FK6k
         mctwX2jQz9UFniiloszkwyUnGUS1yvBZuNfLznAWaxNlmufHn2QpZ1So6RCVEJAwonbY
         OiixD596mPeYKfe34nNPBWU7MaKka06cNu8TaHdFyxeByrYJWwlPq4F/2XMQbGMi+9tT
         9Gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714164185; x=1714768985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueA8BocmTSJNHsyrYj2TNISaWPcMWAXxPevjbN2I4Kk=;
        b=luA4qGA/Ph1gA5XBO3i16JmnYv1dDfc+uV6r+jIAmzw5aLEyD80RBpPcutK78n2nH9
         6Fo4H876mdjgOUQ28RoV8q9OkjRQ5EoYCtbQ4mqp55WPDUgfwwHy30dtejMLKZfONHb4
         3ZM2DgjBsNT6Fc2MJVflWwLN0yKzAQsdAbkD79lZXBzCEWomXKRtEzpoJsxbxHv7G1p6
         XDa4ntS4JcBhhbKRU4gU/pk85Zj5LDEXPYraHI3i2t+v4IY0DnEQ4JxXf/aao7Oud+uy
         DJ57yea0EREidMSgRDepl4N9TpqsLSoGTpNudY4BH2UQ2w7PtarPdXKtTAQEcCKPGjH6
         6rwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKoalolbmY/4nIK/FVsGX0uV3Bb+ba8XFHijcJLh7rpzaMl5ma8JWXpA3c0TxFde3xZD3vWPcGYV44eCrDfaIQ29KGmZMlkN3KMaxP
X-Gm-Message-State: AOJu0YyHp0WB0t2oBVOyM5BA53zT7Ej83OI0KjSpaN/U9qKYnVDTS1H5
	iV48rV0/zierqEOd7YAKGqD6fThZMjayq7JVkmWkN8h4dnpSgNMYfQexBdS2FtjXEFxS7ndWJNN
	UxF4rD+sO5bFmsvNw8xDu4Ee3j3g=
X-Google-Smtp-Source: AGHT+IHtHDw+SuBuLCHF9dQ3rXR8SAurLqm91cNlAtwclmb1U5hypuDEGRG0X0bZJKfBAiNEWJtfqCEAmUnDwh4c7RI=
X-Received: by 2002:a50:d651:0:b0:572:47be:be36 with SMTP id
 c17-20020a50d651000000b0057247bebe36mr2476472edj.0.1714164185112; Fri, 26 Apr
 2024 13:43:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426190253.541419-1-zi.yan@sent.com>
In-Reply-To: <20240426190253.541419-1-zi.yan@sent.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 26 Apr 2024 13:42:53 -0700
Message-ID: <CAHbLzkr9t_Kfrjddn2Xu22vSQUO55Z5wHVi8_oz=qL1oEQ9wvg@mail.gmail.com>
Subject: Re: [PATCH v5] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 12:02=E2=80=AFPM Zi Yan <zi.yan@sent.com> wrote:
>
> From: Zi Yan <ziy@nvidia.com>
>
> In __folio_remove_rmap(), a large folio is added to deferred split list
> if any page in a folio loses its final mapping. But it is possible that
> the folio is fully unmapped and adding it to deferred split list is
> unnecessary.
>
> For PMD-mapped THPs, that was not really an issue, because removing the
> last PMD mapping in the absence of PTE mappings would not have added the
> folio to the deferred split queue.
>
> However, for PTE-mapped THPs, which are now more prominent due to mTHP,
> they are always added to the deferred split queue. One side effect
> is that the THP_DEFERRED_SPLIT_PAGE stat for a PTE-mapped folio can be
> unintentionally increased, making it look like there are many partially
> mapped folios -- although the whole folio is fully unmapped stepwise.
>
> Core-mm now tries batch-unmapping consecutive PTEs of PTE-mapped THPs
> where possible starting from commit b06dc281aa99 ("mm/rmap: introduce
> folio_remove_rmap_[pte|ptes|pmd]()"). When it happens, a whole PTE-mapped
> folio is unmapped in one go and can avoid being added to deferred split
> list, reducing the THP_DEFERRED_SPLIT_PAGE noise. But there will still be
> noise when we cannot batch-unmap a complete PTE-mapped folio in one go
> -- or where this type of batching is not implemented yet, e.g., migration=
.
>
> To avoid the unnecessary addition, folio->_nr_pages_mapped is checked
> to tell if the whole folio is unmapped. If the folio is already on
> deferred split list, it will be skipped, too.
>
> Note: commit 98046944a159 ("mm: huge_memory: add the missing
> folio_test_pmd_mappable() for THP split statistics") tried to exclude
> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does not
> fix the above issue. A fully unmapped PTE-mapped order-9 THP was still
> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable().
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/rmap.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2608c40dffad..a9bd64ebdd9a 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1495,6 +1495,7 @@ static __always_inline void __folio_remove_rmap(str=
uct folio *folio,
>  {
>         atomic_t *mapped =3D &folio->_nr_pages_mapped;
>         int last, nr =3D 0, nr_pmdmapped =3D 0;
> +       bool partially_mapped =3D false;
>         enum node_stat_item idx;
>
>         __folio_rmap_sanity_checks(folio, page, nr_pages, level);
> @@ -1515,6 +1516,8 @@ static __always_inline void __folio_remove_rmap(str=
uct folio *folio,
>                                         nr++;
>                         }
>                 } while (page++, --nr_pages > 0);
> +
> +               partially_mapped =3D !!nr && !!atomic_read(mapped);
>                 break;
>         case RMAP_LEVEL_PMD:
>                 atomic_dec(&folio->_large_mapcount);
> @@ -1532,6 +1535,8 @@ static __always_inline void __folio_remove_rmap(str=
uct folio *folio,
>                                 nr =3D 0;
>                         }
>                 }
> +
> +               partially_mapped =3D nr < nr_pmdmapped;
>                 break;
>         }
>
> @@ -1553,9 +1558,10 @@ static __always_inline void __folio_remove_rmap(st=
ruct folio *folio,
>                  * page of the folio is unmapped and at least one page
>                  * is still mapped.
>                  */
> -               if (folio_test_large(folio) && folio_test_anon(folio))
> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmap=
ped)
> -                               deferred_split_folio(folio);
> +               if (folio_test_anon(folio) &&
> +                   list_empty(&folio->_deferred_list) &&
> +                   partially_mapped)
> +                       deferred_split_folio(folio);
>         }
>
>         /*
>
> base-commit: 3dba658670af22074cc6f26dc92efe0013ac3359
> --
> 2.43.0
>

