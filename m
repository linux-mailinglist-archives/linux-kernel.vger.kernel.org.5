Return-Path: <linux-kernel+bounces-29733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0CA8312AA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C292832E9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA1BB641;
	Thu, 18 Jan 2024 06:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GqeMTYm1"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C23AD32
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558869; cv=none; b=ivzLL+bWtrrxLStR96+o/dRGhLhQRxAK5WXFTNDrOToKpXWKTlhkPyZwedgW18hhu6PlQvC30nSzugO82qrIMR4qN46GYNYwkOATL6kajAqTOpEooK2j7kySsnyN7xmFB6hUxvj22OiHsqAsO/CWrCLGcKkD+SGgDRHKHUVNiEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558869; c=relaxed/simple;
	bh=S20zCEpNDq/pV+bHDoxCXxZGf7EohjVM/y/O8lfCHtw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=u0gAZcniB+LHTVqGRgNhMcw/6KDK/AGAzLB2wiUfVSzxJSZVsX7Hnuld1VN2R8qLz+5EVZrRziTLK9ECtat8FAhaVnL/653hHU0FAZOLr5DeBvytCDBCwUO+irRODuXSigrbolrSt2M5wHAZWKXIoLyWxDqli6BdHLBUqxT27Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GqeMTYm1; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a08b00ac1so199844a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705558866; x=1706163666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJlVK4iBv+zofuCe2C1FT9Euxl2G3WgJemm135I8Sv4=;
        b=GqeMTYm1rrSXlF9fjQloKGDmg6ZZllT9GUMn5e5SW0Tt5z2mLha/rkTiMKtt5F0Miq
         2Aa313hjp5RzkbAuYXn6gLIiArebRACiP73iefWT7AKAHPWI4GIA6YnyUM10NQ/0YbiL
         EBGcMQE563drLMC/JxTVC8wtC6WujoGICoGNMSBbfyWYifj8jKCRmabPNRDEU27eVLG+
         WR3272nSrco4kv2/E8IMHwAuuvDUo5e4zZhftPJb6KkhzYJPSzyvoWG7WhR6Shauh1I+
         x+DeNWmAbwCQ7lf81gV/Rev92FAAnf0rh+lXu57zDnQXtBlfUmPl1Nd6VoGEsNyLJtfj
         bCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705558866; x=1706163666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJlVK4iBv+zofuCe2C1FT9Euxl2G3WgJemm135I8Sv4=;
        b=cWA/uqf8sOlaUpwQNoMd9JqdSQNCvr7rmhJ5SEd1uZqOkSRAGvWrhVWys7S7NnH99F
         CXngouDWQimfgPNJUkJwr+lwbb/yyg3SK4C0CWTwFHSQGa6uLPiVqnEDMvzqGoX1Tu9D
         0k5I/C/yLmwaeQiAy9hygPyPrN4LUb8vgVpAuD1mHzpTer5xH91fUaNtRJrC/5yffSBr
         Yrxw8iwDkA/xTZuqLtRqokmEDF0EMx/9MXlGPUTbvUxeQRIvK/PT7ulRpsHLcyyDt8Tl
         p0OSZNHlIxxePuy6Lwa2w3jDBvAP8vazK33GiYqFTtkKB60NkzLz7i00Ttv4OiZ6W16N
         C71A==
X-Gm-Message-State: AOJu0Yy0An7Vq1gFU3wyVHC5Gr3aYpzdX2pv4Ms4wEgfN9QG6qknGBTl
	mWSJBAh7pD37Ki6ke+WdfwsgSw9qESwfH9nDgfP8pCqyvMmGwpxFxbMato8cB2nm/QPV3rrQ0LO
	wB+CkqT8g1kw2Mmiq8suNgBB+bMt+TkOwbGVf
X-Google-Smtp-Source: AGHT+IGHduAicQV3fcnyu3+XAb4+oQD+mNQx9HiyHI2Ew3gcecJqxh1u4e8lz19YEfvFEU0MN6dX2/LLnavDgy4XyPs=
X-Received: by 2002:a17:906:f0d8:b0:a2c:872c:5683 with SMTP id
 dk24-20020a170906f0d800b00a2c872c5683mr152624ejb.41.1705558865635; Wed, 17
 Jan 2024 22:21:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org> <20240117-zswap-xarray-v1-1-6daa86c08fae@kernel.org>
In-Reply-To: <20240117-zswap-xarray-v1-1-6daa86c08fae@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jan 2024 22:20:29 -0800
Message-ID: <CAJD7tkYEx57CPBoaN9GW4M3Mx-+jEsOMWJ02nLKSKD-MLb-WPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: zswap.c: add xarray tree to zswap
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, =?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, 
	Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>, 
	Chun-Tse Shao <ctshao@google.com>, =?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 7:06=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> The xarray tree is added alongside the zswap RB tree.
> Checks for the xarray get the same result as the RB tree operations.
>
> Rename the zswap RB tree function to a more generic function
> name without the RB part.

As I mentioned in the cover letter, I believe this should be squashed
into the second patch. I have some comments below as well on the parts
that should remain after the squash.

[..]
>
> @@ -462,9 +463,9 @@ static void zswap_lru_putback(struct list_lru *list_l=
ru,
>  /*********************************
>  * rbtree functions
>  **********************************/
> -static struct zswap_entry *zswap_rb_search(struct rb_root *root, pgoff_t=
 offset)
> +static struct zswap_entry *zswap_search(struct zswap_tree *tree, pgoff_t=
 offset)

Let's change the zswap_rb_* prefixes to zswap_tree_* instead of just
zswap_*. Otherwise, it will be confusing to have both zswap_store and
zswap_insert (as well as zswap_load and zswap_search).

[..]
> @@ -1790,15 +1808,21 @@ void zswap_swapon(int type)
>  void zswap_swapoff(int type)
>  {
>         struct zswap_tree *tree =3D zswap_trees[type];
> -       struct zswap_entry *entry, *n;
> +       struct zswap_entry *entry, *e, *n;
> +       XA_STATE(xas, tree ? &tree->xarray : NULL, 0);
>
>         if (!tree)
>                 return;
>
>         /* walk the tree and free everything */
>         spin_lock(&tree->lock);
> +
> +       xas_for_each(&xas, e, ULONG_MAX)

Why not use xa_for_each?

> +               zswap_invalidate_entry(tree, e);
> +
>         rbtree_postorder_for_each_entry_safe(entry, n, &tree->rbroot, rbn=
ode)
> -               zswap_free_entry(entry);

Replacing zswap_free_entry() with zswap_invalidate_entry() is a
behavioral change that should be done separate from this series, but I
am wondering why it's needed. IIUC, the swapoff code should be making
sure there are no ongoing swapin/swapout operations, and there are no
pages left in zswap to writeback.

Is it the case that swapoff may race with writeback, such that
writeback is holding the last remaining ref after zswap_invalidate()
is called, and then zswap_swapoff() is called freeing the zswap entry
while writeback is still accessing it?

