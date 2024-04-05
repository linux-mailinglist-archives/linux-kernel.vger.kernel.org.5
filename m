Return-Path: <linux-kernel+bounces-132415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C7289949C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1211F22774
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229AD2135B;
	Fri,  5 Apr 2024 04:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5B+Blpq"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D5D1803D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 04:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712292818; cv=none; b=P/VfXpPXytc7FyjUJ01hZBMngV7JcbFKu1iEQnl5XncNKVwxQBoQZT09P0QLGbIB2k2XOKOSAUldjaEqyrIt4Myhwjxbke/g73lelCImewSWaJGJVerADQ3unjCLw1qoQZFYZ5PR67bHJG3BglQJ2FO/BqFDMib7qlCoxOSY0LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712292818; c=relaxed/simple;
	bh=cBigDdDQBOpbv8DLHntSqepb64ZImTDRrNw1p6BwOFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofSRnRkKh8sL4URfBoMuOH0U4ZvCPIFyg3I16vwwHPgn4p+gjnMMiEe4E/VgBj6uoPYOaq0U3DZKmqEAXh+8ZBYVLdeLLDZYiI0kELxPUZnK2WVe+nc9VO/+OAWJ/29nOX0FzaY3VDEKt4HT+l4TKw+djDsPKhjyvOx3NSxO8oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5B+Blpq; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7e389d74dcaso971219241.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 21:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712292816; x=1712897616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFVkjkG3EDW3xTK2+dLWlF2WsS83zvxGEi3lzpt+3ww=;
        b=b5B+Blpq9cRYhBxXLm4h2mcVwRu97NW/ZVJqaPKhPa/BrnkDNlpu3IsjuVtXWTMD7h
         J/dZCCilnEyuqxt753gFkjoFnIfD1LT7PQm0PKUcVah5CJAtc3yK9p93O0tH4DMMftUS
         HNF6eW5RVCRZdMByvTQIGzRj0MeBjoTjZ7ZUmD3DqmyQgVXRXOkkQqchxCdnTUbdaOy7
         kWD1EDNFACVAfrbTKgpFYCl4ruCi5h7u2WB5XFxVQoRC3vyB3ZQo95U+VVBIfJD8zq07
         NtlkrMlIi+o3FO8AWBGuB/dA3ZbpTcXF7c1sC1XLbCO1JGzsJ7KCaMWRByBd9F4E4lBv
         qqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712292816; x=1712897616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFVkjkG3EDW3xTK2+dLWlF2WsS83zvxGEi3lzpt+3ww=;
        b=ZslvfwrD4VJhSik62f0U/qiaES8dpi8EeG+VPephBSyQrMomYEKDaBJqco3AxQ5u40
         +k/CK3Zj2MgKUz476kgWTSODkt3byoV5XXWIv0dtSob31cRv6QA2Xf9ZuDuBl3dUpF1E
         5UxBbb2PCuh30jtF8JN6FGDCXzXmq3LXI850Gv/+kFmAVs2j4BQGH9AQkjrLC3P6w+mq
         cTvIrvWzsWuX4deLxNQkq7w4TzMmbMZA7ylxLN6NxVVMDXOJqG8QtJbSH1lMCgUuukbZ
         b7UgpCEyWFF8t5PoXf47G6q+MnLgAFZcu8Swx3qfqfc8MxBvuFia0fmi/g+jdlyxL+jk
         YxaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5vwOow2T4WfN7gbiX/bhw+hCB+hCnsTuo1fFWRvKH0DeVCxRoA9AR+0U1mDeuWUfZ9SyB39bR0vkIzkQhv6O2+pqkMT3L6a2dF2NL
X-Gm-Message-State: AOJu0YyzA8PitVrY/cVXm3wuNPglzg3RZG05rCtw2BN1U9ZZVck5zXE6
	AL/EhCJXfZZ58nru49jVksKO7ltWkInwJpRjwCjsl9LzFM2DszgsVqTlaUzYC/MPCDYDCxK2bEK
	sfO5LBY15H+eGX5+zhsY+m8lu7jo=
X-Google-Smtp-Source: AGHT+IHvjIVIWR4WSYqi79hjDTimfy2HNP7Pth7ojX29LaztBG1WJ/QETo4JB0zzqSIBaUIXaSvkwozrZ9JEnygHqPc=
X-Received: by 2002:a05:6102:4424:b0:478:7191:966c with SMTP id
 df36-20020a056102442400b004787191966cmr225076vsb.12.1712292815680; Thu, 04
 Apr 2024 21:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a25c9e14cd03907d5978b60546a69e6aa3fc2a7d.1712151833.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <a25c9e14cd03907d5978b60546a69e6aa3fc2a7d.1712151833.git.baolin.wang@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 5 Apr 2024 17:53:24 +1300
Message-ID: <CAGsJ_4xvXT6Qy1JgP2khH0DKvTGhjsrexsSj8ddieM_XXn8bng@mail.gmail.com>
Subject: Re: [PATCH] mm: page_alloc: use the correct THP order for THP PCP
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, mgorman@techsingularity.net, vbabka@suse.cz, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 2:47=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Commit 44042b449872 ("mm/page_alloc: allow high-order pages to be stored
> on the per-cpu lists") extends the PCP allocator to store THP pages, and
> it determines whether to cache THP pags in PCP by comparing with pagebloc=
k_order.
> But the pageblock_order is not always equal to THP order, it might also
> be MAX_PAGE_ORDER, which could prevent PCP from caching THP pages.
>
> Therefore, using HPAGE_PMD_ORDER instead to determine the need for cachin=
g
> THP for PCP can fix this issue
>
> Fixes: 44042b449872 ("mm/page_alloc: allow high-order pages to be stored =
on the per-cpu lists")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

LGTM,
Reviewed-by: Barry Song <baohua@kernel.org>

In the context of using mTHP, perhaps there arises a need for PCP
allocation for frequently
requested mTHP orders. These orders typically exceed PAGE_ALLOC_COSTLY_ORDE=
R
but are smaller than HPAGE_PMD_ORDER.

> ---
>  mm/page_alloc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1beb56f75319..915f4ef070da 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -506,7 +506,7 @@ static inline unsigned int order_to_pindex(int migrat=
etype, int order)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         if (order > PAGE_ALLOC_COSTLY_ORDER) {
> -               VM_BUG_ON(order !=3D pageblock_order);
> +               VM_BUG_ON(order !=3D HPAGE_PMD_ORDER);
>                 return NR_LOWORDER_PCP_LISTS;
>         }
>  #else
> @@ -522,7 +522,7 @@ static inline int pindex_to_order(unsigned int pindex=
)
>
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         if (pindex =3D=3D NR_LOWORDER_PCP_LISTS)
> -               order =3D pageblock_order;
> +               order =3D HPAGE_PMD_ORDER;
>  #else
>         VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
>  #endif
> @@ -535,7 +535,7 @@ static inline bool pcp_allowed_order(unsigned int ord=
er)
>         if (order <=3D PAGE_ALLOC_COSTLY_ORDER)
>                 return true;
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -       if (order =3D=3D pageblock_order)
> +       if (order =3D=3D HPAGE_PMD_ORDER)
>                 return true;
>  #endif
>         return false;
> --
> 2.39.3
>

Thanks
Barry

