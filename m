Return-Path: <linux-kernel+bounces-158004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955558B1A03
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A4EB24961
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C7739AF0;
	Thu, 25 Apr 2024 04:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fxc8R/yv"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA243B781
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 04:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714020476; cv=none; b=RhYfPBADQXuGd85MlUmJWwsq6JF7da2KvwKGV5878j2opvRPNsstpDNBcVAVtIwN1YoUTgVUb5F8jox3neJaEowhGM5fy9bHwyyTO8fqn0uLnsS0guyt/cketX71LHBl8cQN05uLnt9J9Bj2J2QI5l/aFneNHgoBPqOChy5UCD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714020476; c=relaxed/simple;
	bh=QkHoR9z3dRPqyKAHwrKyU3s1xCzs4/hpk8clqKIK+HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bp6WEBY0r0R7bo8mw6JOn7lGvp/K4cGxkBMUABY5p9G1djUCsfxuXLwnhh3d+yH0aH0dzRiSstbWAmbIasbO0ZrjzgDtLVXH7pulFHh6AYnXWipihhdgd7Oc0peh13CgMnaKky8yn/AiIznbG3fXcXK8bSuSN8khWLQLzYrMCYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fxc8R/yv; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2dd615b6c44so5842721fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714020473; x=1714625273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpo5EwUdOC96YukS8QWkRpGkkyVlX6pSgH/vTHIzZok=;
        b=Fxc8R/yvbGdiolGzb064c6Cz05OCNOKI8+o1ZZM9b2QIb0vo8/w3ll1Uhvqw9iaI6A
         nttFQi6dQNj6N55GvdqnRDj8B/2d/KuCDR9SpCdAOfNNpiGtS8pV4qCOhZYRpSGNozGc
         n9T/3h0wdbmZhzTmDIqZ2komjUr9kiR4Fmvq6RRKfAQ55mIxf/bx89o+ZZqD4tKn9FWv
         NMmIIlYA8rA37r/8XSx8E8SrLZkaDW4Gb1rG/GrCGdcYyxgzzYJbsPpCnppiIDvVsYLP
         +99sQ7dgfCdLwW8wwu9rX8UqBsaEfaMJKhOaw2nfqLtyyZc+vAtJKkLDGUWow0/0jMZu
         WNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714020473; x=1714625273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpo5EwUdOC96YukS8QWkRpGkkyVlX6pSgH/vTHIzZok=;
        b=Ld8Ns9e4ZuLm132ork7xVQLO3TlpbdksEhyMDPv6gO/8K7bF1HEv+4Cnw/XZoZLj8T
         f4D/2gvxiNTaNII4gqwGEnQB/3DGFWRPSUs40LWk3IUs5zKgmk3tna3moH68NPn9PG9f
         NZg1THHeE97Zvcxm54TfRo9d/HFP0LdiYiZIhsPZbCOUdCbzOrwNUsf2dYERyEofgpw5
         mlkEiYVkwmbrqCdi3wtP+mkRmUQjeiMMxrBzwecRiw8IdtgRdwCTLHUofQMggCbGKLMT
         YHwX0az9aMoD06YZwr0vK+vFh0ULkxDFkT7crz9cqv+D0I1SeCZHOEL7v7wTpCLhWaHR
         9YFw==
X-Forwarded-Encrypted: i=1; AJvYcCUTJ94pz6aj4zYcpNltsG3K4z0MwP7YjY+hQHj2Jw/8kDshxH84WH3q+v4VEWVsbBM9TTTjQwoJ2WQuJ6zSnuQfrMTcg7Kbi6Zic+mv
X-Gm-Message-State: AOJu0YwHDvEMnot5UV2rllJaEVWrmQVBF8/9ecIS0iytLyV+XDCtZ94n
	D4IeUBKKGh6JodAlFT2SzSHzWs+5G9oPBRgwGBFb28nm9R1QoFkxeTIL6TTcOrv3zsI8jSmRY4a
	rjx/QpTlf7Wwu3vYBksUJz5onqb8=
X-Google-Smtp-Source: AGHT+IEcY1PB98rnhwReQi4sQiaQRD3HiP5OZtKx50yyJPlKlr64VRSTvtpWF+5AibA/pSQcllF/WKGP5xjT3aSQxY8=
X-Received: by 2002:a2e:2c0c:0:b0:2dd:372c:e7bc with SMTP id
 s12-20020a2e2c0c000000b002dd372ce7bcmr3030160ljs.31.1714020472863; Wed, 24
 Apr 2024 21:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424135148.30422-1-ioworker0@gmail.com> <20240424135148.30422-2-ioworker0@gmail.com>
 <1192295a-5b94-4c1a-b11c-7cd8ef0e62b7@gmail.com> <dfbced2e-487c-413f-bfed-567a852ab1bc@gmail.com>
In-Reply-To: <dfbced2e-487c-413f-bfed-567a852ab1bc@gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 25 Apr 2024 12:47:41 +0800
Message-ID: <CAK1f24m-xV=gxY5D=xevfov=TGfcvbiereTt3ZawVn0Fntnhjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: add per-order mTHP split counters
To: Bang Li <libang.linux@gmail.com>
Cc: akpm@linux-foundation.org, 21cnbao@gmail.com, ryan.roberts@arm.com, 
	david@redhat.com, baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Bang,

Thanks for taking time to review!

On Thu, Apr 25, 2024 at 1:59=E2=80=AFAM Bang Li <libang.linux@gmail.com> wr=
ote:
>
> Hey, sorry for making noise, there was something wrong with the format of
> the last email.
>
> On 2024/4/25 1:12, Bang Li wrote:
> > Hey Lance,
> >
> > On 2024/4/24 21:51, Lance Yang wrote:
> >
> >> At present, the split counters in THP statistics no longer include
> >> PTE-mapped mTHP. Therefore, this commit introduces per-order mTHP spli=
t
> >> counters to monitor the frequency of mTHP splits. This will assist
> >> developers in better analyzing and optimizing system performance.
> >>
> >> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
> >>          split_page
> >>          split_page_failed
> >>          deferred_split_page
> >>
> >> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> >> ---
> >>   include/linux/huge_mm.h |  3 +++
> >>   mm/huge_memory.c        | 14 ++++++++++++--
> >>   2 files changed, 15 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >> index 56c7ea73090b..7b9c6590e1f7 100644
> >> --- a/include/linux/huge_mm.h
> >> +++ b/include/linux/huge_mm.h
> >> @@ -272,6 +272,9 @@ enum mthp_stat_item {
> >>       MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> >>       MTHP_STAT_ANON_SWPOUT,
> >>       MTHP_STAT_ANON_SWPOUT_FALLBACK,
> >> +    MTHP_STAT_SPLIT_PAGE,
> >> +    MTHP_STAT_SPLIT_PAGE_FAILED,
> >> +    MTHP_STAT_DEFERRED_SPLIT_PAGE,
> >>       __MTHP_STAT_COUNT
> >>   };
> >>   diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 055df5aac7c3..52db888e47a6 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -557,6 +557,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback,
> >> MTHP_STAT_ANON_FAULT_FALLBACK);
> >>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge,
> >> MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> >>   DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
> >>   DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback,
> >> MTHP_STAT_ANON_SWPOUT_FALLBACK);
> >> +DEFINE_MTHP_STAT_ATTR(split_page, MTHP_STAT_SPLIT_PAGE);
> >> +DEFINE_MTHP_STAT_ATTR(split_page_failed, MTHP_STAT_SPLIT_PAGE_FAILED)=
;
> >> +DEFINE_MTHP_STAT_ATTR(deferred_split_page,
> >> MTHP_STAT_DEFERRED_SPLIT_PAGE);
> >>     static struct attribute *stats_attrs[] =3D {
> >>       &anon_fault_alloc_attr.attr,
> >> @@ -564,6 +567,9 @@ static struct attribute *stats_attrs[] =3D {
> >>       &anon_fault_fallback_charge_attr.attr,
> >>       &anon_swpout_attr.attr,
> >>       &anon_swpout_fallback_attr.attr,
> >> +    &split_page_attr.attr,
> >> +    &split_page_failed_attr.attr,
> >> +    &deferred_split_page_attr.attr,
> >>       NULL,
> >>   };
> >>   @@ -3083,7 +3089,7 @@ int split_huge_page_to_list_to_order(struct
> >> page *page, struct list_head *list,
> >>       XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index,
> >> new_order);
> >>       struct anon_vma *anon_vma =3D NULL;
> >>       struct address_space *mapping =3D NULL;
> >> -    bool is_thp =3D folio_test_pmd_mappable(folio);
> >> +    int order =3D folio_order(folio);
> >>       int extra_pins, ret;
> >>       pgoff_t end;
> >>       bool is_hzp;
> >> @@ -3262,8 +3268,10 @@ int split_huge_page_to_list_to_order(struct
> >> page *page, struct list_head *list,
> >>           i_mmap_unlock_read(mapping);
> >>   out:
> >>       xas_destroy(&xas);
> >> -    if (is_thp)
> >> +    if (order >=3D HPAGE_PMD_ORDER)
> >>           count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED=
);
> >> +    count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT_PAGE :
> >> +                      MTHP_STAT_SPLIT_PAGE_FAILED);
> >>       return ret;
> >>   }
> >>   @@ -3327,6 +3335,8 @@ void deferred_split_folio(struct folio *folio)
> >>       if (list_empty(&folio->_deferred_list)) {
> >>           if (folio_test_pmd_mappable(folio))
> >>               count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> >> +        count_mthp_stat(folio_order(folio),
> >> +                MTHP_STAT_DEFERRED_SPLIT_PAGE);
> >>           list_add_tail(&folio->_deferred_list, &ds_queue->split_queue=
);
> >>           ds_queue->split_queue_len++;
> >>   #ifdef CONFIG_MEMCG
> >
> > My opinion can be ignored :). Would it be better to modify the
> > deferred_split_folio
> > function as follows? I'm not sure.
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c index
> > 055df5aac7c3..e8562e8630b1 100644 --- a/mm/huge_memory.c +++
> > b/mm/huge_memory.c @@ -3299,12 +3299,13 @@ void
> > deferred_split_folio(struct folio *folio) struct mem_cgroup *memcg =3D
> > folio_memcg(folio); #endif unsigned long flags; + int order =3D
> > folio_order(folio); /* * Order 1 folios have no space for a deferred
> > list, but we also * won't waste much memory by not adding them to the
> > deferred list. */ - if (folio_order(folio) <=3D 1) + if (order <=3D 1)
> > return; /* @@ -3325,8 +3326,9 @@ void deferred_split_folio(struct
> > folio *folio) spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> > if (list_empty(&folio->_deferred_list)) { - if
> > (folio_test_pmd_mappable(folio)) + if (order >=3D HPAGE_PMD_ORDER)
> > count_vm_event(THP_DEFERRED_SPLIT_PAGE); + count_mthp_stat(order,
> > MTHP_STAT_DEFERRED_SPLIT_PAGE); list_add_tail(&folio->_deferred_list,
> > &ds_queue->split_queue); ds_queue->split_queue_len++; #ifdef
> > CONFIG_MEMCG thanks,
> > bang
> >
>
> My opinion can be ignored :). Would it be better to modify the
> deferred_split_folio
> function as follows? I'm not sure.
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 055df5aac7c3..e8562e8630b1 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3299,12 +3299,13 @@ void deferred_split_folio(struct folio *folio)
>          struct mem_cgroup *memcg =3D folio_memcg(folio);
>   #endif
>          unsigned long flags;
> +       int order =3D folio_order(folio);

I'll consider storing it in a variable earlier for later reuse.

Thanks,
Lance

>
>          /*
>           * Order 1 folios have no space for a deferred list, but we also
>           * won't waste much memory by not adding them to the deferred li=
st.
>           */
> -       if (folio_order(folio) <=3D 1)
> +       if (order <=3D 1)
>                  return;
>
>          /*
> @@ -3325,8 +3326,9 @@ void deferred_split_folio(struct folio *folio)
>
>          spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>          if (list_empty(&folio->_deferred_list)) {
> -               if (folio_test_pmd_mappable(folio))
> +               if (order >=3D HPAGE_PMD_ORDER)
>                          count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> +               count_mthp_stat(order, MTHP_STAT_DEFERRED_SPLIT_PAGE);
>                  list_add_tail(&folio->_deferred_list,
> &ds_queue->split_queue);
>                  ds_queue->split_queue_len++;
>   #ifdef CONFIG_MEMCG
>
> thanks,
> bang

