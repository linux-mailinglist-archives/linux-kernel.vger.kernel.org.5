Return-Path: <linux-kernel+bounces-81868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5C9867B2D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1516B1C2948B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E308412C55F;
	Mon, 26 Feb 2024 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QI4zNxBH"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388E212C52D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963760; cv=none; b=F5fe1iCOn/BTxoJcx/YJj2ufu+R5hwAzxPn2/f8Gtjr88+lxb5/iSZPHF8OybNErz1vzYEynzwoqMHJMFdXBxvsmjM6zGfBgQn2fj9LXrbtIizZy+ETS5HHig70K+QY1MXlU3igdDVWS7vhUPM04kcp79I92O+WYD2tvwbDNR/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963760; c=relaxed/simple;
	bh=TidfZc7ErYBLnN3EIMvg/9g/fBw+mmuobrxPTxjxuIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIIfHy5xZ/Tz9x/hWKyqcwTxG78JxpQdZGcY8mg9nLrPx83dMaVld1tvsnWXKMSZ+vufbaY5uxHCAYl1Y15D9VYTbY6iCHozMmIUSAimQQ1GcY2A7dL11efilYnexik0Mk0SslFPjfpLUp4L/t1/qIJPgdkDJ4AMvwRlgigzCS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QI4zNxBH; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a095237eefso403678eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708963757; x=1709568557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kY37XU8Gu2F16RfGDaO10TRnKshw9yrEqXfsRtwgKYw=;
        b=QI4zNxBHDg/8ckWBjGr7HneyycBRBmvqGDinHu259qytlBCvT9pgNo6tTUowbFiHzk
         pGL5cyZe8h0WBuQ8PWaBZ3JuN1WzQWSrFCmp4MYNzwqmXwy/FiWgY/rBJIsnw50Vk+1e
         MXnABJeSMpjwSo9odhsrvFStmg47dfsGPYnfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708963757; x=1709568557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kY37XU8Gu2F16RfGDaO10TRnKshw9yrEqXfsRtwgKYw=;
        b=rajkvrMho6lNAWaHFK+A0Iq2V0TN6EJVq73HVsqngTlZxSELIFttOCg64Mw/ij1ebx
         o0GzLMN4PYskkTGrmohgmw9cM8Y3UU+h0VldxY1lZpDbVhiU4d8ryXHFpO44jZjWdbHd
         v4npUn2BdJq+0fRG+/BFHqS5yZtdCHMWThR4nrHDl8ejnqmMSjt2EqGLBVCzeQ4rqzxn
         CNz83wHIE1cqQp/s8SZJomtIxG3ctELaMHkEnmUST/6vKWRajMTobNCuyPYieZ9+izNW
         kUlAFQYlKzTc9O22W6CJ/uF7OzjVlBSCLx4vRTixsTsLI+bS0whoGg4QNvK3AODlhUy8
         SwWw==
X-Forwarded-Encrypted: i=1; AJvYcCWZf/BvskVuXWLYDkzipfWgKu2TVdM6Ir1J3BOFe0Z5vNlqqjW/5yb+MBSBnTWRtQI6sbqdBWkqLTg7ryYFxkakmOrs4OW0OJWtRnEK
X-Gm-Message-State: AOJu0YzAhtm8utCEKc2MgCn08b4QKGXbx52FznMx7DTDHD3HAtiPqcyL
	OS/aTIaYrREHIv85UXtu1XDzZt1sY2Ljm9b4IJF/brBTsI8fq+aFVKJ5o/pHS+iQkgZNzNILiHS
	us3iG8INHL8RO+ZyemJrA1P6JrLDPu1DaH+P4
X-Google-Smtp-Source: AGHT+IGO8+qRP9Sa5Y8eYjqpu7kaXPnwBCmmXNtbHYpcRdAzwsLsqULq7XSlSPpVhz7oo52TaAYvnvDAeqhL7iNt9wg=
X-Received: by 2002:a4a:7617:0:b0:5a0:3917:5d46 with SMTP id
 t23-20020a4a7617000000b005a039175d46mr6268492ooc.2.1708963757421; Mon, 26 Feb
 2024 08:09:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG-rBihs_xMKb3wrMO1+-+p4fowP9oy1pa_OTkfxBzPUVOZF+g@mail.gmail.com>
 <20240221114357.13655-2-vbabka@suse.cz>
In-Reply-To: <20240221114357.13655-2-vbabka@suse.cz>
From: Sven van Ashbrook <svenva@chromium.org>
Date: Mon, 26 Feb 2024 11:09:06 -0500
Message-ID: <CAG-rBijH3GaHN2zA2_cby-RsQCVHou-WjZnxudMebPrS9imgfg@mail.gmail.com>
Subject: Re: [PATCH] mm, vmscan: prevent infinite loop for costly GFP_NOIO |
 __GFP_RETRY_MAYFAIL allocations
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, bgeffon@google.com, 
	cujomalainey@chromium.org, kramasub@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-sound@vger.kernel.org, 
	perex@perex.cz, stable@vger.kernel.org, tiwai@suse.com, tiwai@suse.de, 
	Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Vlastimil,

We noticed that this patch is now added to Andrew Morton's
mm-hotfixes-unstable branch.

How can we help to get this into mm-hotfixes-stable
and from there, into mainline ?

We are still stress-testing using low memory suspend. Anything else
that is required, and we can help with?

Sven

On Wed, Feb 21, 2024 at 6:44=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Sven reports an infinite loop in __alloc_pages_slowpath() for costly
> order __GFP_RETRY_MAYFAIL allocations that are also GFP_NOIO. Such
> combination can happen in a suspend/resume context where a GFP_KERNEL
> allocation can have __GFP_IO masked out via gfp_allowed_mask.
>
> Quoting Sven:
>
> 1. try to do a "costly" allocation (order > PAGE_ALLOC_COSTLY_ORDER)
>    with __GFP_RETRY_MAYFAIL set.
>
> 2. page alloc's __alloc_pages_slowpath tries to get a page from the
>    freelist. This fails because there is nothing free of that costly
>    order.
>
> 3. page alloc tries to reclaim by calling __alloc_pages_direct_reclaim,
>    which bails out because a zone is ready to be compacted; it pretends
>    to have made a single page of progress.
>
> 4. page alloc tries to compact, but this always bails out early because
>    __GFP_IO is not set (it's not passed by the snd allocator, and even
>    if it were, we are suspending so the __GFP_IO flag would be cleared
>    anyway).
>
> 5. page alloc believes reclaim progress was made (because of the
>    pretense in item 3) and so it checks whether it should retry
>    compaction. The compaction retry logic thinks it should try again,
>    because:
>     a) reclaim is needed because of the early bail-out in item 4
>     b) a zonelist is suitable for compaction
>
> 6. goto 2. indefinite stall.
>
> (end quote)
>
> The immediate root cause is confusing the COMPACT_SKIPPED returned from
> __alloc_pages_direct_compact() (step 4) due to lack of __GFP_IO to be
> indicating a lack of order-0 pages, and in step 5 evaluating that in
> should_compact_retry() as a reason to retry, before incrementing and
> limiting the number of retries. There are however other places that
> wrongly assume that compaction can happen while we lack __GFP_IO.
>
> To fix this, introduce gfp_compaction_allowed() to abstract the __GFP_IO
> evaluation and switch the open-coded test in try_to_compact_pages() to
> use it.
>
> Also use the new helper in:
> - compaction_ready(), which will make reclaim not bail out in step 3, so
>   there's at least one attempt to actually reclaim, even if chances are
>   small for a costly order
> - in_reclaim_compaction() which will make should_continue_reclaim()
>   return false and we don't over-reclaim unnecessarily
> - in __alloc_pages_slowpath() to set a local variable can_compact,
>   which is then used to avoid retrying reclaim/compaction for costly
>   allocations (step 5) if we can't compact and also to skip the early
>   compaction attempt that we do in some cases
>
> Reported-by: Sven van Ashbrook <svenva@chromium.org>
> Closes: https://lore.kernel.org/all/CAG-rBihs_xMKb3wrMO1%2B-%2Bp4fowP9oy1=
pa_OTkfxBzPUVOZF%2Bg@mail.gmail.com/
> Fixes: 3250845d0526 ("Revert "mm, oom: prevent premature OOM killer invoc=
ation for high order request"")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/gfp.h |  9 +++++++++
>  mm/compaction.c     |  7 +------
>  mm/page_alloc.c     | 10 ++++++----
>  mm/vmscan.c         |  5 ++++-
>  4 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index de292a007138..e2a916cf29c4 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -353,6 +353,15 @@ static inline bool gfp_has_io_fs(gfp_t gfp)
>         return (gfp & (__GFP_IO | __GFP_FS)) =3D=3D (__GFP_IO | __GFP_FS)=
;
>  }
>
> +/*
> + * Check if the gfp flags allow compaction - GFP_NOIO is a really
> + * tricky context because the migration might require IO.
> + */
> +static inline bool gfp_compaction_allowed(gfp_t gfp_mask)
> +{
> +       return IS_ENABLED(CONFIG_COMPACTION) && (gfp_mask & __GFP_IO);
> +}
> +
>  extern gfp_t vma_thp_gfp_mask(struct vm_area_struct *vma);
>
>  #ifdef CONFIG_CONTIG_ALLOC
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 4add68d40e8d..b961db601df4 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2723,16 +2723,11 @@ enum compact_result try_to_compact_pages(gfp_t gf=
p_mask, unsigned int order,
>                 unsigned int alloc_flags, const struct alloc_context *ac,
>                 enum compact_priority prio, struct page **capture)
>  {
> -       int may_perform_io =3D (__force int)(gfp_mask & __GFP_IO);
>         struct zoneref *z;
>         struct zone *zone;
>         enum compact_result rc =3D COMPACT_SKIPPED;
>
> -       /*
> -        * Check if the GFP flags allow compaction - GFP_NOIO is really
> -        * tricky context because the migration might require IO
> -        */
> -       if (!may_perform_io)
> +       if (!gfp_compaction_allowed(gfp_mask))
>                 return COMPACT_SKIPPED;
>
>         trace_mm_compaction_try_to_compact_pages(order, gfp_mask, prio);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 150d4f23b010..a663202045dc 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4041,6 +4041,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int=
 order,
>                                                 struct alloc_context *ac)
>  {
>         bool can_direct_reclaim =3D gfp_mask & __GFP_DIRECT_RECLAIM;
> +       bool can_compact =3D gfp_compaction_allowed(gfp_mask);
>         const bool costly_order =3D order > PAGE_ALLOC_COSTLY_ORDER;
>         struct page *page =3D NULL;
>         unsigned int alloc_flags;
> @@ -4111,7 +4112,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int=
 order,
>          * Don't try this for allocations that are allowed to ignore
>          * watermarks, as the ALLOC_NO_WATERMARKS attempt didn't yet happ=
en.
>          */
> -       if (can_direct_reclaim &&
> +       if (can_direct_reclaim && can_compact &&
>                         (costly_order ||
>                            (order > 0 && ac->migratetype !=3D MIGRATE_MOV=
ABLE))
>                         && !gfp_pfmemalloc_allowed(gfp_mask)) {
> @@ -4209,9 +4210,10 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned in=
t order,
>
>         /*
>          * Do not retry costly high order allocations unless they are
> -        * __GFP_RETRY_MAYFAIL
> +        * __GFP_RETRY_MAYFAIL and we can compact
>          */
> -       if (costly_order && !(gfp_mask & __GFP_RETRY_MAYFAIL))
> +       if (costly_order && (!can_compact ||
> +                            !(gfp_mask & __GFP_RETRY_MAYFAIL)))
>                 goto nopage;
>
>         if (should_reclaim_retry(gfp_mask, order, ac, alloc_flags,
> @@ -4224,7 +4226,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int=
 order,
>          * implementation of the compaction depends on the sufficient amo=
unt
>          * of free memory (see __compaction_suitable)
>          */
> -       if (did_some_progress > 0 &&
> +       if (did_some_progress > 0 && can_compact &&
>                         should_compact_retry(ac, order, alloc_flags,
>                                 compact_result, &compact_priority,
>                                 &compaction_retries))
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4f9c854ce6cc..4255619a1a31 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5753,7 +5753,7 @@ static void shrink_lruvec(struct lruvec *lruvec, st=
ruct scan_control *sc)
>  /* Use reclaim/compaction for costly allocs or under memory pressure */
>  static bool in_reclaim_compaction(struct scan_control *sc)
>  {
> -       if (IS_ENABLED(CONFIG_COMPACTION) && sc->order &&
> +       if (gfp_compaction_allowed(sc->gfp_mask) && sc->order &&
>                         (sc->order > PAGE_ALLOC_COSTLY_ORDER ||
>                          sc->priority < DEF_PRIORITY - 2))
>                 return true;
> @@ -5998,6 +5998,9 @@ static inline bool compaction_ready(struct zone *zo=
ne, struct scan_control *sc)
>  {
>         unsigned long watermark;
>
> +       if (!gfp_compaction_allowed(sc->gfp_mask))
> +               return false;
> +
>         /* Allocation can already succeed, nothing to do */
>         if (zone_watermark_ok(zone, sc->order, min_wmark_pages(zone),
>                               sc->reclaim_idx, 0))
> --
> 2.43.1
>

