Return-Path: <linux-kernel+bounces-85607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFBB86B83C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224751F26DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4551615F31D;
	Wed, 28 Feb 2024 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KqpWX0wX"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C35815F300
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148833; cv=none; b=JFqY7uftTVtGBiTATE09Roai1WNIiDnzcOEBBSnvPkRW5beDiHz4wID+3/SqTE1An+AiRi8E2c0ppUBmjDIsecSbBUvWzK15005chEUy4Xv0sejZc5xHHgiSxaeDnmoS5z9AVCQ3lmu87WYT9zSL54DvfaX08dVhTGgcNyFCb0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148833; c=relaxed/simple;
	bh=rHtUr07NXBMCSzgyNiFib3qptNPUiCmpA1avywuSbrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=makb3xwFt7WfW4OMKVFyKOyseBrQ35N82udttDBeuL8y4Q5VbrYdbY3iUxk31F9cwUKF5ITPiUWrnm0NtHoQ0gYtJTaDsc4Zx0+iYWpT1KEY/XQLLPeERO78lllKqsF1Q12r8ve07HzdB0Y/zCWO4uGMPU7W+fJt8I2gSd1iCN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KqpWX0wX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d118a181fso89841f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709148830; x=1709753630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lT04GCfSayZ/NG1YfdCVrXwolvgh0gSX9xKT3OophFQ=;
        b=KqpWX0wXQ99WhpCCJ3E3KfNuFhK9da/LR8d0s7yfOBekz4WR9dG4eEZpzV80NbUJ76
         xB2Pb2Mj5h1BLM2Shg2o9MHwmrd1j7U18EBxvNw9DSTC3wfdTYvs8NFY4NjevLX7Q+8C
         OCbr8xDXws56/smwVmSkWGjR1uScyFNrJsl8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709148830; x=1709753630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lT04GCfSayZ/NG1YfdCVrXwolvgh0gSX9xKT3OophFQ=;
        b=fuCdFM3wWFhAQ+BbmDAV+Hsnv8Wt5EkJDXodwqShklLRamqOHSl3t/k4100eWXNts/
         lPDAkwOujbl1N9sE3iDqk+/l91M7U+lG5OnCfX5Z5/G07Ce79gEmANXsiARo3YLmPsWI
         7NHDANDCKfSdE+tlDDmGEx2161nPuxMphBz9quEZkJJQ8HR+CM6MNlMjLT2TW4COtM4H
         80FEP0MFC0AMDrAHFd5fH8l2K+m68fuc8U56saW93EKGxNusH6A9nqlZVlgjwuFPwHtp
         ArUID8N+XFg0DyckGLszq+lOV+kictGNVqEHvtfYUiAWfKW35JPdGcMj2HKgrs4Pgtw3
         uAUw==
X-Forwarded-Encrypted: i=1; AJvYcCU+6Mw6S1S7O868L31NQ1nC2cTsB9H2JntjV0aAWThlGFUkahycZcNt+IUCXPZFAsF9WZX1Co9i18l0t4r+KPHFhwjY6BIyph7Z5nqb
X-Gm-Message-State: AOJu0Yy9naHlnwpmhBlNKGddLmcm84LDqULDY2i/G25Uja9v1zuxNO+l
	+So/CWzBQ4uhAAMZ3cMXqxYtvt5PtevQbHq8MQrdXQkSaKuh+Onig52INIt+wyU27OfplN9vffD
	VqpJklrT3UIP1RYeiVTYPGX1+/9LdcCH+ZD3D
X-Google-Smtp-Source: AGHT+IHi0a9VVTiFwIdkF5FnWuaSceqJNfODPnjKL5knq0jzCOUubnV9I4KXVitnKYMcQsXNcnfJC9GeIga63VcV/x8=
X-Received: by 2002:adf:f848:0:b0:33d:88c1:31b8 with SMTP id
 d8-20020adff848000000b0033d88c131b8mr399831wrq.60.1709148829737; Wed, 28 Feb
 2024 11:33:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG-rBihs_xMKb3wrMO1+-+p4fowP9oy1pa_OTkfxBzPUVOZF+g@mail.gmail.com>
 <20240221114357.13655-2-vbabka@suse.cz>
In-Reply-To: <20240221114357.13655-2-vbabka@suse.cz>
From: Karthikeyan Ramasubramanian <kramasub@chromium.org>
Date: Wed, 28 Feb 2024 12:33:38 -0700
Message-ID: <CAJZwx_niaTD+n7mvKbzBQeEEki591Rg=W1cJpJew-iTo8P8X8g@mail.gmail.com>
Subject: Re: [PATCH] mm, vmscan: prevent infinite loop for costly GFP_NOIO |
 __GFP_RETRY_MAYFAIL allocations
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, svenva@chromium.org, bgeffon@google.com, 
	cujomalainey@chromium.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-sound@vger.kernel.org, perex@perex.cz, stable@vger.kernel.org, 
	tiwai@suse.com, tiwai@suse.de, Michal Hocko <mhocko@kernel.org>, 
	Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 4:44=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
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
Tested-by: Karthikeyan Ramasubramanian <kramasub@chromium.org>
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

