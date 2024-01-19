Return-Path: <linux-kernel+bounces-31511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C29832F59
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54841C233AB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7715156455;
	Fri, 19 Jan 2024 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mRGMGICy"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F9856440
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705692237; cv=none; b=rq4+dBt5tXcrdJONLg21m+Th7HnvNJjB/d0FnA95WFdmI8onnLMD+hbnYUirPoxzgBKEGXgYZHNqE4k0wWYiJCoXuYgwHKhe7x24Vc5M2ClzGoIPAlG5eRq1zm5l344QH1IEcIfd9utCE9a/U8m1cqCQe/osch/KiZiyRy7G4eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705692237; c=relaxed/simple;
	bh=aeqviCpKDLT0lx4K6jr7lFK0TAFT6Wi8GHPvMeb8568=;
	h=MIME-Version:Message-ID:Date:Subject:From:To:Content-Type; b=bfxdkTA7TOvQNcTDBhFQmmQ5KjgfHsfXnJtSU3UBdu5bFWLqS+FGmGrU/NWYDMM9c292UWrNsAumdYxqEhTUn5Vd2FocweEz0noj+5XDXP1CrRo1MMhsoJJ0UyeQMPTYK3TfGUZjDSQ92TcApTPh3gMR0aAJzg4A9KPMhHuxnLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mRGMGICy; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbdb46770d7so1767702276.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705692234; x=1706297034; darn=vger.kernel.org;
        h=to:from:subject:date:message-id:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oUbM7cZJSS+Lma0bSlkj3sq8QPcMKfV5ziywtM55XZs=;
        b=mRGMGICypO1jgtofnN3tCgdPOzj9X4GxWf9Clau+0gJrckdxPLbf/8EguSgqKoAl+2
         qkh2ETHEe1v8dos/0srWxA384/a+LJr3b2C8Ti26aRtHy8iYZlg9omT4Yen8NIAcDvBF
         nthYJLRbV21jo52bHLGKqJSZTPKOs2SYX+KnVZdAVTNuVhG7gOPwZw8AuJO8XlPMpAA6
         ecksewwaEydjyi5RM7IoSoBnSdfTKEcwGMrNrOwWWIlvatRmVZLf46VUcBAPh7zjzjBl
         euXdmaRVGdwZM4Lspf2XvTDCq1lTaDuU304rDsXDxXgM6oZ+LlIwR/WyJEsEUY9wB9xy
         KW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705692234; x=1706297034;
        h=to:from:subject:date:message-id:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oUbM7cZJSS+Lma0bSlkj3sq8QPcMKfV5ziywtM55XZs=;
        b=HuF/XxDJiitsTa1KNC0oZP6J0e36iPOy8G74BiLJvzgiqH1OBjYV7clWYtuaykJSFf
         G6acU+rDLdkMrq0E1obAZEeLxm/1fs4xpn94qvHN8VnIdNGZOkyI7Q5lC5IMjJK+8mCR
         UMDdjfzypTNhUA1llXhT/4aBnMa+6VVvEswSJa+Ig3TjKRGGXCyayWuyoWymx6dc1JkU
         BcXhTJj0rmGY42XP7I8FQmW/aPBa1XkmqbVwR3BB7bpc6nM3UVyVEFr9k7KNVs/OUwu2
         IcG+1f3qnyyNIcgTKWzCXDvm28YDpBuotW/boiGEs2PonWHX2aceJJuQ0BV6KlUSGC3r
         cvRg==
X-Gm-Message-State: AOJu0Yxb2zUScIVYPwUygThbmp6YLTWX6271uCjXFQxmnEV/MkGAVSEb
	xG3lBs3tDZF24D8KVyPLmbD1TiLsmraCzN3+XV1N2sSedStXUuUe2pyMQ7c+yuKFY8L2BQIzG7w
	aJb15ky8iXFxzk+7SxA==
X-Google-Smtp-Source: AGHT+IEpWgAQBb1yqSKPeBiS9sl7v3sjX6fxYDf795Og8eFstvsY4t4/Snuov7KxcwMsJUmFAfcUj9yPTdYarkwU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:a8c:b0:dc2:65e9:6a35 with SMTP
 id cd12-20020a0569020a8c00b00dc265e96a35mr177305ybb.4.1705692234453; Fri, 19
 Jan 2024 11:23:54 -0800 (PST)
Message-ID: <000000000000bb617b060f516b23@google.com>
Date: Fri, 19 Jan 2024 19:23:54 +0000
Subject: 
From: yosryahmed@google.com
To: chrisl@kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, weixugc@google.com, yuzhao@google.com, gthelen@google.com, 
	ctshao@google.com, surenb@google.com, bgeffon@google.com, minchan@kernel.org, 
	mhocko@suse.com, mgorman@techsingularity.net, ying.huang@intel.com, 
	nphamcs@gmail.com, hannes@cmpxchg.org, kasong@tencent.com, 
	hezhongkun.hzk@bytedance.com, shikemeng@huaweicloud.com, 
	v-songbaohua@oppo.com, willy@infradead.org, Liam.Howlett@oracle.com, 
	joel@joelfernandes.org, zhouchengming@bytedance.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Date: Fri, 19 Jan 2024 19:23:52 +0000
From: Yosry Ahmed <yosryahmed@google.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Wei =?utf-8?B?WHXvv7w=?= <weixugc@google.com>,
	Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Suren =?utf-8?B?QmFnaGRhc2FyeWFu77+8?= <surenb@google.com>,
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Huang Ying <ying.huang@intel.com>, Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kairui Song <kasong@tencent.com>,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Barry Song <v-songbaohua@oppo.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH 1/2] mm: zswap.c: add xarray tree to zswap
Message-ID: <ZarMHYEqXCOeKau0@google.com>
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
  <20240117-zswap-xarray-v1-1-6daa86c08fae@kernel.org>
  <CAJD7tkYEx57CPBoaN9GW4M3Mx-+jEsOMWJ02nLKSKD-MLb-WPA@mail.gmail.com>
  <CAF8kJuO5tAqwyKQK7AasWgs3Ohfc2osD9oX0m8YAkfsAZsjjyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To:  
<CAF8kJuO5tAqwyKQK7AasWgs3Ohfc2osD9oX0m8YAkfsAZsjjyQ@mail.gmail.com>

> > > -static struct zswap_entry *zswap_rb_search(struct rb_root *root,  
> pgoff_t offset)
> > > +static struct zswap_entry *zswap_search(struct zswap_tree *tree,  
> pgoff_t offset)
> >
> > Let's change the zswap_rb_* prefixes to zswap_tree_* instead of just
> > zswap_*. Otherwise, it will be confusing to have both zswap_store and
> > zswap_insert (as well as zswap_load and zswap_search).

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
> > >         rbtree_postorder_for_each_entry_safe(entry, n, &tree->rbroot,  
> rbnode)
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

> For the RB tree the mapping is stored in the zswap entry as RB node.
> That is different from xarray. Xarry stores the mapping outside of
> zswap entry. Just freeing the entry does not remove the mapping from
> xarray. Therefore it needs to call zswap_invalidate_entry() to remove
> the entry from the xarray. I could call zswap_erase() then free entry.
> I just think zswap_invalidate_entry() is more consistent with the rest
> of the code.

Do we have to call xa_destroy() anyway to make sure everything is
cleaned up in the xarray? In that case, we can just do that after the
loop.

