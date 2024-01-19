Return-Path: <linux-kernel+bounces-30788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2096483245D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFB41F23901
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274F9611B;
	Fri, 19 Jan 2024 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTxQXpuL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5340F4A0A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705643355; cv=none; b=ppRO/n5lxLL62CTPuzqHdJoPO4B5RYtnpH14tFuJzO5cqaU9RXamaDgQOO4mCRVUxCQc+hjYUFTImESxLuw3qEV+K8+d2S75d5EhUETws4EE5x0byixrR1YjZCHaT3mfVYzKdtJY0aoRA6kgFL1LZPiBBEYkxxUN1xUzgbz850Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705643355; c=relaxed/simple;
	bh=gFaoz5Lad+xTGdXdZ7SAqJDCdLlZZMjHIoUjSxAe/Ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=df9EsaHv5Ecz4mJ0muL81Tx15qKr9aX9TsPqqNEpyziYlvE3SpFbx47hSDShHhP0h1KXfAlBl33qtPEf6rdfAL7mYl65xVWOxTyGY4//WF1urkb4gyRj/3q/RMmPeM2Tl+cz58wvYz5SoiAC17NmMKKn1uOcjqMu2BH0EWSvrNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTxQXpuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16377C433F1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705643355;
	bh=gFaoz5Lad+xTGdXdZ7SAqJDCdLlZZMjHIoUjSxAe/Ws=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FTxQXpuLFOJfe145uoTZI2lFRgbOWDzvMPE6rUfq4pGJhAbWk0jYK+jbs94X16kXJ
	 PSpyO0xNKyPGV5B1WyAfVCu0WMXPJhKxi1MW35bLoqlbgfFIeZ7ZZpa6V1lsOzVp0w
	 nqKiYJ8aSn1wAjuvX4kL3aCCZLf7ibD40/FNZ6VCDHM3sk9Y9gbpDlum9Dd7KkGRIf
	 O3KuK8GJqZWAXDOexLp8WN6jCIrgIQBlkDMWkQXaOdPiraaxu1818hI88cjkDS2llT
	 qmlEh0BxSE2SfXHQCsa9w718A9vEDcvAjDF8RMzcD4EeBiGrpRWCPH83c9PTJnPQi5
	 slkIOH7urPmNw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59960d26f65so8941eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 21:49:14 -0800 (PST)
X-Gm-Message-State: AOJu0YzK0XM4FgpMfZlZsnFRPDneZE8ncKD/fAhsN2Wdeho2vLevPlxv
	cmlPrhmhDwtS0sOTMglnAKovA2lmVwTsV5WeF0PeqnZ1XGz0QXeq/XYV3W/kIBaKP2jmLJ7ycLq
	PBiCS6oWiOzJBrHdYUCxLwadRbZz7kLUFgApo
X-Google-Smtp-Source: AGHT+IF0zUxYWNPabx8vxbpRQ8Nx587jedet0oDo6CRg6ecDT2wFKoHxB4IWqV1gAwVBFcfxSv6C3uxGcuX+1llkUqs=
X-Received: by 2002:a05:6359:320c:b0:175:67e3:cb28 with SMTP id
 rj12-20020a056359320c00b0017567e3cb28mr1756236rwb.12.1705643353344; Thu, 18
 Jan 2024 21:49:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <20240117-zswap-xarray-v1-2-6daa86c08fae@kernel.org> <CAJD7tkZF102x_8LKAX+sxAttgYD_LNT3cRqeOr7_euwPfNdCFA@mail.gmail.com>
 <CAJD7tkbFxfLxYPXHkSCq=1JsAinW9G+unyOadFY+Xfo-QTqNyA@mail.gmail.com>
In-Reply-To: <CAJD7tkbFxfLxYPXHkSCq=1JsAinW9G+unyOadFY+Xfo-QTqNyA@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 18 Jan 2024 21:49:02 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPXrkN3XRvpgf4t-afxU-JpcNGVKyoXXwiEXMypchaEGg@mail.gmail.com>
Message-ID: <CAF8kJuPXrkN3XRvpgf4t-afxU-JpcNGVKyoXXwiEXMypchaEGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap.c: remove RB tree
To: Yosry Ahmed <yosryahmed@google.com>
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

On Thu, Jan 18, 2024 at 11:36=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Wed, Jan 17, 2024 at 10:35=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > > @@ -493,45 +471,47 @@ static struct zswap_entry *zswap_search(struct =
zswap_tree *tree, pgoff_t offset)
> > >  static int zswap_insert(struct zswap_tree *tree, struct zswap_entry =
*entry,
> > >                         struct zswap_entry **dupentry)
> > >  {
> > > -       struct rb_root *root =3D &tree->rbroot;
> > > -       struct rb_node **link =3D &root->rb_node, *parent =3D NULL;
> > > -       struct zswap_entry *myentry, *old;
> > > -       pgoff_t myentry_offset, entry_offset =3D swp_offset(entry->sw=
pentry);
> > > -
> > > -
> > > -       while (*link) {
> > > -               parent =3D *link;
> > > -               myentry =3D rb_entry(parent, struct zswap_entry, rbno=
de);
> > > -               myentry_offset =3D swp_offset(myentry->swpentry);
> > > -               if (myentry_offset > entry_offset)
> > > -                       link =3D &(*link)->rb_left;
> > > -               else if (myentry_offset < entry_offset)
> > > -                       link =3D &(*link)->rb_right;
> > > -               else {
> > > -                       old =3D xa_load(&tree->xarray, entry_offset);
> > > -                       BUG_ON(old !=3D myentry);
> > > -                       *dupentry =3D myentry;
> > > +       struct zswap_entry *e;
> > > +       pgoff_t offset =3D swp_offset(entry->swpentry);
> > > +       XA_STATE(xas, &tree->xarray, offset);
> > > +
> > > +       do {
> > > +               xas_lock_irq(&xas);
> > > +               do {
> > > +                       e =3D xas_load(&xas);
> > > +                       if (xa_is_zero(e))
> > > +                               e =3D NULL;
> > > +               } while (xas_retry(&xas, e));
> > > +               if (xas_valid(&xas) && e) {
> > > +                       xas_unlock_irq(&xas);
> > > +                       *dupentry =3D e;
> > >                         return -EEXIST;
> > >                 }
> > > -       }
> > > -       rb_link_node(&entry->rbnode, parent, link);
> > > -       rb_insert_color(&entry->rbnode, root);
> > > -       old =3D xa_store(&tree->xarray, entry_offset, entry, GFP_KERN=
EL);
> > > -       return 0;
> > > +               xas_store(&xas, entry);
> > > +               xas_unlock_irq(&xas);
> > > +       } while (xas_nomem(&xas, GFP_KERNEL));
> > > +       return xas_error(&xas);
> >
> > I think using the xas_* APIs can be avoided here. The only reason we
> > need it is that we want to check if there's an existing entry first,
> > and return -EEXIST. However, in that case, the caller will replace it
> > anyway (and do some operations on the dupentry):
> >
> > while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) =3D=3D -EEXIST)=
 {
> >         WARN_ON(1);
> >         zswap_duplicate_entry++;
> >         zswap_invalidate_entry(tree, dupentry);
> > }
> >
> > So I think we can do something like this in zswap_insert() instead:
> >
> > dupentry =3D xa_store(..);
> > if (WARN_ON(dupentry)) {
> >         zswap_duplicate_entry++;
> >         zswap_invalidate_entry(tree, dupentry);
> > }
>
> If this is doable, I think we can return xa_store(..) and keep the
> logic in the caller. I think there's a chance
> zswap_{search/insert/erase} may end up being very thin wrappers around
> xa_{load/store/erase}, and we may be able to remove them completely.
> Let's see how it goes.
>

See my other email about erasing an entry raced into a new entry. That
is the part I am not certain.
Anyway, when zswap adopte folio, then it might need to handle multi
entry, we will be back to using the XAS API.

Chris

