Return-Path: <linux-kernel+bounces-30521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4200F831FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 189E9B20E29
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCBD2E410;
	Thu, 18 Jan 2024 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eXxknxGf"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6A52E403
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705606580; cv=none; b=gmFcuul3NUszmP7Myr2MqfUyWfjx+TRuxJaIk7QBynzO+ttGnLc6GpZTeATYGU8OL3rM1ogIs/4QAHZC4dUIr//nFDIhEdVNjkWky/4zZcw8DXMewHHwJefkzGem6+ZkOmomXPQOwFnFQBucSxHLAgGb+W2O3opbmpgxubiff4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705606580; c=relaxed/simple;
	bh=0Spb8poRMfqQSK08H+TL3uHUKPHZzTZQ/fCBGPaH0wI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koO178slDm/3zEfHSUzxjIyavcbuwjNYXbIl1iIVn/XC3ouG2dTB8c0adiR3rAfsJ0PCSGP1r4UtIWi1ZmuJvsfZ3ispIhBbSZX3kGVaXuRFtw9BEoepOOvUK/nXILd0fmTPJeen3WZLiZ2FGSqiKC6XH1YI8yODQGTJiAlMsJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eXxknxGf; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-559cef15db5so2122544a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705606576; x=1706211376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZDkcKK8uyhcMNTfFp6ML8LXI1RuetKqYpSVVoE584Q=;
        b=eXxknxGfb5/amFXjTjOI+dnJEAVV0gYSvwKJwnM2hN9/CAWLTdqWMOfyByGjx/PFAb
         gogmVFEuZklyUCra12O0PIdIf/i/osHfDGbKGmmRilYhnSRwZjj7ab+uSSIwNdjDnIa9
         JxgkdAvH5MOOUhyPdF/lvJgrQAv3MGDA4h2JKKjtw6Lxj2FxJQxjwJcK2vdOy+WUHxF2
         QbCXKa4PejW1aZGs43PrQpPi7EXi67m9Iw4cc8TF6ysjaB0FiAa5zkAC3yL9B76xZRCL
         MAo2Cn17Ep1GNglbs4R+/58of25xPTyO5Jo4IzfvDrHtGigZ73GHy58hsyVyeqbM90tl
         huRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705606576; x=1706211376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZDkcKK8uyhcMNTfFp6ML8LXI1RuetKqYpSVVoE584Q=;
        b=oMBSooxe1KMOzQJmCYEJPkEg0Z1HOJmAEHkTKmRL4bvgY6RIqZ9yBGX2E2HnSqJqsG
         uxdZreM1mah7cmOGunTJf34tJtB45ifemtUyeEI4O5aZTRTTPlHmlkffQhJ9I2u65dWL
         hL2ADogKVWk2Je8e0ll8eWsNUjSrMKNMwaCWgpLXamW/2BpYQ8vRqPLUbok9bZswovyW
         yYwA1JS6XjBSyLO22P1ghKpaUqV/7uIsoA6BnrfgHWYRgRJAJe+chwBvP+bKuaYwRAzz
         egHGJOZqj5OrXHzqg12MwKtBH52wF3xfXhKXyoOZB9BvGRLQyEzTVwcKlkXtMfi9Ko8R
         pDhg==
X-Gm-Message-State: AOJu0YwUE121KZXzWSJ6QlB2kneMQyvy8DGrUWUuY9CbKb15TePCBXaB
	rwzGo7yBllFjBd8Syd3nqWte8h1TvrEorkbxs+Ms4ZlQn2TRNVwv7Cd4mATMFrA6Bi//2gKnstG
	4MtFeR6FdV/+yjbxPMoVjdEsHUeLhpQLztHNL
X-Google-Smtp-Source: AGHT+IHNARndcPkevbhESph8uzGKHb3QILXTpJfID+26UjpTZwh9rl0SKaz5Jxqu1azSrdHtE0kbuTG6/SSnWwwcCms=
X-Received: by 2002:a17:907:da8:b0:a2e:98d2:9c29 with SMTP id
 go40-20020a1709070da800b00a2e98d29c29mr2257202ejc.70.1705606576334; Thu, 18
 Jan 2024 11:36:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <20240117-zswap-xarray-v1-2-6daa86c08fae@kernel.org> <CAJD7tkZF102x_8LKAX+sxAttgYD_LNT3cRqeOr7_euwPfNdCFA@mail.gmail.com>
In-Reply-To: <CAJD7tkZF102x_8LKAX+sxAttgYD_LNT3cRqeOr7_euwPfNdCFA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 18 Jan 2024 11:35:38 -0800
Message-ID: <CAJD7tkbFxfLxYPXHkSCq=1JsAinW9G+unyOadFY+Xfo-QTqNyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap.c: remove RB tree
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

On Wed, Jan 17, 2024 at 10:35=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> > @@ -493,45 +471,47 @@ static struct zswap_entry *zswap_search(struct zs=
wap_tree *tree, pgoff_t offset)
> >  static int zswap_insert(struct zswap_tree *tree, struct zswap_entry *e=
ntry,
> >                         struct zswap_entry **dupentry)
> >  {
> > -       struct rb_root *root =3D &tree->rbroot;
> > -       struct rb_node **link =3D &root->rb_node, *parent =3D NULL;
> > -       struct zswap_entry *myentry, *old;
> > -       pgoff_t myentry_offset, entry_offset =3D swp_offset(entry->swpe=
ntry);
> > -
> > -
> > -       while (*link) {
> > -               parent =3D *link;
> > -               myentry =3D rb_entry(parent, struct zswap_entry, rbnode=
);
> > -               myentry_offset =3D swp_offset(myentry->swpentry);
> > -               if (myentry_offset > entry_offset)
> > -                       link =3D &(*link)->rb_left;
> > -               else if (myentry_offset < entry_offset)
> > -                       link =3D &(*link)->rb_right;
> > -               else {
> > -                       old =3D xa_load(&tree->xarray, entry_offset);
> > -                       BUG_ON(old !=3D myentry);
> > -                       *dupentry =3D myentry;
> > +       struct zswap_entry *e;
> > +       pgoff_t offset =3D swp_offset(entry->swpentry);
> > +       XA_STATE(xas, &tree->xarray, offset);
> > +
> > +       do {
> > +               xas_lock_irq(&xas);
> > +               do {
> > +                       e =3D xas_load(&xas);
> > +                       if (xa_is_zero(e))
> > +                               e =3D NULL;
> > +               } while (xas_retry(&xas, e));
> > +               if (xas_valid(&xas) && e) {
> > +                       xas_unlock_irq(&xas);
> > +                       *dupentry =3D e;
> >                         return -EEXIST;
> >                 }
> > -       }
> > -       rb_link_node(&entry->rbnode, parent, link);
> > -       rb_insert_color(&entry->rbnode, root);
> > -       old =3D xa_store(&tree->xarray, entry_offset, entry, GFP_KERNEL=
);
> > -       return 0;
> > +               xas_store(&xas, entry);
> > +               xas_unlock_irq(&xas);
> > +       } while (xas_nomem(&xas, GFP_KERNEL));
> > +       return xas_error(&xas);
>
> I think using the xas_* APIs can be avoided here. The only reason we
> need it is that we want to check if there's an existing entry first,
> and return -EEXIST. However, in that case, the caller will replace it
> anyway (and do some operations on the dupentry):
>
> while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) =3D=3D -EEXIST) {
>         WARN_ON(1);
>         zswap_duplicate_entry++;
>         zswap_invalidate_entry(tree, dupentry);
> }
>
> So I think we can do something like this in zswap_insert() instead:
>
> dupentry =3D xa_store(..);
> if (WARN_ON(dupentry)) {
>         zswap_duplicate_entry++;
>         zswap_invalidate_entry(tree, dupentry);
> }

If this is doable, I think we can return xa_store(..) and keep the
logic in the caller. I think there's a chance
zswap_{search/insert/erase} may end up being very thin wrappers around
xa_{load/store/erase}, and we may be able to remove them completely.
Let's see how it goes.

