Return-Path: <linux-kernel+bounces-31513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFCF832F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E153C1C21CFE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F6256456;
	Fri, 19 Jan 2024 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bhMkI0Yv"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1447F5466D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705692622; cv=none; b=aidW6G1dCrPNio/j1NQSu1eWvOg6OLSL87u0Bzp8OXL/fUasTwv410BISIXddKqUy/xwcWtWwovXnxw9P4bpIMnCVFQz85W0Ok3V7dIM0FMWAEaZHqxkPahp93w4awjNsf1ZdlS4etSpbW/0DFnHBNd5/572sDPQYoY6vgRH3ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705692622; c=relaxed/simple;
	bh=4okcQjoHZtRPK7y+6GvlMJHUm+mOGWVYBEIFCFvB/QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSgDn6hRr1V7l1Zc7PCV5iupykK/h9lPcImZAC/BIZG/aYLKzDRY6GP19LAi4sLKSioeT70pElZXqCbmpcQpD4wFaQ5PjFlF6xY+tkaOtdpfTLA/4eh+68VH1YhDrWOGvjozst4jOlyNHV5zzkRzqEi8+T4ot26cwu1ddqwem/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bhMkI0Yv; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2fbb646eb4so9162566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705692619; x=1706297419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ugyBhCYqe/JSP/toMybx2mnqVSMpXtGwbZ5vXwky8K8=;
        b=bhMkI0Yv2VR7gW1YjD3pGVaPe632+Sw0ZG08f1HwV1gL0L9KnjQL5eSZCf2jQzNjJM
         QqbLRQ5el2W6fKkNJNS2MVd6U3YQP6nQbSq/b3ihiJCgexUBhDbbyKWHBCXM7w6nsfFs
         oyrCTgRKU5R2gquk/meDWJyOyMbBSpGZSTUDoE9C/mnOe+HNgiIaJEMWB0rpbvJA6QKX
         7Jagpt01i3bwmRpqsOCCj/jiHSGnLa0i7MZ5iQjx9CZOWN74GzP7GbFN5k9Rt98LRqvw
         /9/5cYzWD2SpoVqjQ9WGz/Wlz03ufrtXvZYMRrIxhkK1Lvd6ap4I1wGq3qTkdRcISYwd
         x0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705692619; x=1706297419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugyBhCYqe/JSP/toMybx2mnqVSMpXtGwbZ5vXwky8K8=;
        b=ScWWkE2Q19SrG07OMu6g6p/dEgZxvGQo5VAxr5F9IAc7KcoRVLDDFkxBAjg6IfSYag
         29e3/VS4xMju0Q/+iIEknc8rkpW3OzGVXsWv94otxS8+VfHhJUqewOljJWUlPgziwAqO
         9kaTF0i6nv1mo6rXd4wQLDbgvRWw/oZmEQK3+tqtttAc2GcPnemprjckqWAAOcnPDrAg
         tOvKA6084EjV19/NzrlN8IQpGFJTr6rOqxuHUBrcuJxpxzyHswoMIsZN+o0bOMpch5uL
         GPN1i0jF7/qaU9GVnrIsLnaSSfYQX6C0DgummMY4qkbRH8GrJp31NjyuKxd50Hpe9cWR
         B86Q==
X-Gm-Message-State: AOJu0Yx57nEEvZRyUSP4K8zwUlMSb6ZA28zeA+IpkxSPNMfbe6iONOls
	i3S9GubZDjPynO4dQQxzMnH43z+WrjDXud399TwC+J5KqI6Cx1CLton7nOG8RVe0EONOxGuiHnV
	cRVnkgc8p5cbITg/i2GTJsz6be+nejczzRbTy
X-Google-Smtp-Source: AGHT+IE1cNh2Ok1Hw/xx/XTYjRdo3LIOnQNeZKcP5EuYjLQKeenERouSCa8xmrUhaf7ZVukdoVG9YNoA305yp3SzEtw=
X-Received: by 2002:a17:906:2b85:b0:a2f:8533:af79 with SMTP id
 m5-20020a1709062b8500b00a2f8533af79mr139810ejg.36.1705692619040; Fri, 19 Jan
 2024 11:30:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <20240117-zswap-xarray-v1-1-6daa86c08fae@kernel.org> <CAJD7tkYEx57CPBoaN9GW4M3Mx-+jEsOMWJ02nLKSKD-MLb-WPA@mail.gmail.com>
 <CAF8kJuO5tAqwyKQK7AasWgs3Ohfc2osD9oX0m8YAkfsAZsjjyQ@mail.gmail.com>
In-Reply-To: <CAF8kJuO5tAqwyKQK7AasWgs3Ohfc2osD9oX0m8YAkfsAZsjjyQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 19 Jan 2024 11:29:42 -0800
Message-ID: <CAJD7tkY6K8q1t-nzZ7oJu-f3OgS654PiOcQgU=E6f+0joYSzPA@mail.gmail.com>
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

My previous email got messed up, sorry.

> > > @@ -462,9 +463,9 @@ static void zswap_lru_putback(struct list_lru *list_lru,
> > >  /*********************************
> > >  * rbtree functions
> > >  **********************************/
> > > -static struct zswap_entry *zswap_rb_search(struct rb_root *root, pgoff_t offset)
> > > +static struct zswap_entry *zswap_search(struct zswap_tree *tree, pgoff_t offset)
> >
> > Let's change the zswap_rb_* prefixes to zswap_tree_* instead of just
> > zswap_*. Otherwise, it will be confusing to have both zswap_store and
> > zswap_insert (as well as zswap_load and zswap_search).
>
> How about zswap_xa_* ?

SGTM.

> >
> > [..]
> > > @@ -1790,15 +1808,21 @@ void zswap_swapon(int type)
> > >  void zswap_swapoff(int type)
> > >  {
> > >         struct zswap_tree *tree = zswap_trees[type];
> > > -       struct zswap_entry *entry, *n;
> > > +       struct zswap_entry *entry, *e, *n;
> > > +       XA_STATE(xas, tree ? &tree->xarray : NULL, 0);
> > >
> > >         if (!tree)
> > >                 return;
> > >
> > >         /* walk the tree and free everything */
> > >         spin_lock(&tree->lock);
> > > +
> > > +       xas_for_each(&xas, e, ULONG_MAX)
> >
> > Why not use xa_for_each?
> >
> > > +               zswap_invalidate_entry(tree, e);
> > > +
> > >         rbtree_postorder_for_each_entry_safe(entry, n, &tree->rbroot, rbnode)
> > > -               zswap_free_entry(entry);
> >
> > Replacing zswap_free_entry() with zswap_invalidate_entry() is a
> > behavioral change that should be done separate from this series, but I
> > am wondering why it's needed. IIUC, the swapoff code should be making
> > sure there are no ongoing swapin/swapout operations, and there are no
> > pages left in zswap to writeback.
> >
> > Is it the case that swapoff may race with writeback, such that
> > writeback is holding the last remaining ref after zswap_invalidate()
> > is called, and then zswap_swapoff() is called freeing the zswap entry
> > while writeback is still accessing it?
>
> For the RB tree the mapping is stored in the zswap entry as RB node.
> That is different from xarray. Xarry stores the mapping outside of
> zswap entry. Just freeing the entry does not remove the mapping from
> xarray. Therefore it needs to call zswap_invalidate_entry() to remove
> the entry from the xarray. I could call zswap_erase() then free entry.
> I just think zswap_invalidate_entry() is more consistent with the rest
> of the code.

I see, but it's not clear to me if the xarray is being properly
cleaned up in this case.

Do we have to call xa_destroy() anyway to make sure everything is
cleaned up in the xarray? In that case, we can just do that after the
loop.

