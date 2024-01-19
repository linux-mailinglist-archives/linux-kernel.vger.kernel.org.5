Return-Path: <linux-kernel+bounces-31517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB786832F6B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447CB1F2470E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DD855C35;
	Fri, 19 Jan 2024 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2tRIcBQf"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD831E480
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705693023; cv=none; b=dQzuxN+kUkCo2yH4Z4I3w/QiLdzTCiLLiJvJ0Ym7zx84wNZDdMxjxlxy0NgTTY0tkw56ilBxDO+TlU1ez9rrRYOFXaEWReilVEcGK75qODDFpLLd+lxkTORplK0ekW+QwH6AzupF8UJOeSWRRgJBod026KFf6/YwjUh7NSRAE9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705693023; c=relaxed/simple;
	bh=4LjheHUisz2n6Y5plVFsRQnMTaIzFhW0WKqk3P3eJa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZ+xj/lcdF1jAiYiArrGedYI6Bly1gMcVnHSwVxS4X9vOmDJfKmUCd2bbIMsakfGq030pQAZ3S7L/IcSWm5apm0Qc3HjTNuCTS3CFtijSNoFKUlW/6tVv1EZ6AbcG6mSqGOqSnS54/+heNwfU6A7RQufhfmq27E1/EDs9b+bJO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2tRIcBQf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so131689866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705693020; x=1706297820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fjm7bz8eyCbh/wR7R5WfPWiMGpqtxISCBuFNemwrIvk=;
        b=2tRIcBQfhrXXN1pI2agEqS6kp8/nBsSuJjOyn07Cx4h6N3FIdfsFgCoFoPpywM9yuD
         KBFJG/Efq1V8YCOco7VdEENF1bjbozsIMf8jxwOyNQ7pjCRr+fnNGuQxkYt2EZ4/f5iz
         Uiios5h8bM6MRFlLSb9NTtPo2G+je+lpCiSnz1RT4UV0bb1sZT4uLbOhuoVSYSf3jDKB
         3D196uI3oYaV41rGMVnw14EmVZAquh3AyCeenNPHMUkg1camzQhJIREPZbzIqJJl2qkj
         XDylXmrceCb/hycouJcsHWzJWZrU1d48wiWJetkm1d8SrH8ntmtnhWfr3TbVvJTnh3Wa
         CyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705693020; x=1706297820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fjm7bz8eyCbh/wR7R5WfPWiMGpqtxISCBuFNemwrIvk=;
        b=Kg2Qdf86aNL57e0cIvrQ1yh93jAS3LrIclJp9ocwgmeCBaNfb/WL0o+1QaYKZdw6iA
         l4pgu2GgevpriMKIFXZ03PuBepauDpiQHh0nem4mgiEjybpfGnVTx9gnGA2YnTErkM1G
         tckh/2EePr7zQhjjo6G2eSPzPq/3adftI7QkbdI6pqirmoOpwZwIkMWgOVXyMYYJzHSN
         DGF7tJpa7Hcj2PIfBp55PeZu3QnvZzk6MGXuOwMYWghA1w+GiONozHinmxYvORGczFFW
         n+8jI6o0U+EhIzTOOetHGlJWx3jtBakrgA564RRhrRF4UAfWZcT7pKBxI4bcxJSIKZ9B
         w7xQ==
X-Gm-Message-State: AOJu0YwThJFmU4tJ67COaQ/7j1gfwdueQQc60B6Njx+nKt9d0I6sTUBw
	9/1I3YaIb2ryibGYeRIhkpSihdjBoj02FwVymDMD0vFXmFTH4lmjcPsHDLkzuiKaFzoT4yTs3TQ
	eIJ9WE1YD3ApUV8Ij7t9tzxeOeNtWWWXShmrg
X-Google-Smtp-Source: AGHT+IHlA5zVgUxC+rQm8QL6dfNwRIpkh+yS0I576RXhxjY0UJ1CeyWSKEOjLYFF863tFrTGrT/FV1yClx7LbPAOJkg=
X-Received: by 2002:a17:906:b741:b0:a2e:893f:7333 with SMTP id
 fx1-20020a170906b74100b00a2e893f7333mr111511ejb.5.1705693020064; Fri, 19 Jan
 2024 11:37:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <20240117-zswap-xarray-v1-2-6daa86c08fae@kernel.org> <CAJD7tkZF102x_8LKAX+sxAttgYD_LNT3cRqeOr7_euwPfNdCFA@mail.gmail.com>
 <CAF8kJuMwF=s-28OPFbCfJf-f3jsfYmyiP6pSBjj8ZgkGmbT9ZA@mail.gmail.com>
In-Reply-To: <CAF8kJuMwF=s-28OPFbCfJf-f3jsfYmyiP6pSBjj8ZgkGmbT9ZA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 19 Jan 2024 11:36:23 -0800
Message-ID: <CAJD7tkbdT-Bdi4YkOS_Px73dkhthq2qn6Yvy7CobzTBji0WMog@mail.gmail.com>
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

On Thu, Jan 18, 2024 at 9:43=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Yosry,
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
>
> We might be able to for the insert case if we don't mind changing the
> code behavior a bit. My original intent is to keep close to the
> original zswap code and not stir the pot too much for the xarray
> replacement. We can always make more adjustment once the RB tree is
> gone.

I don't see how this changes code behavior though. The current code in
zswap_store() will do the following:

- Hold the tree lock to make sure no one else modifies it.
- Try to insert, check if there is already a dupentry at the index and
return -EEXIST.
- Warn, increment zswap_duplicate_entry, and invalidate the dupentry.
- Try to insert again (this should always succeed since we are holding
the lock).

What I am proposing is:
- zswap_xa_insert() is a thin wrapper around xa_store() (or we can
remove it completely).
- zswap_store() does the following:
  - Use zswap_xa_insert() and check if there is a returned dupentry.
  - Warn, increment zswap_duplicate_entry, and invalidate the dupentry.

Either way, we always place the entry we have in the tree, and if
there is a dupentry we warn and invalidate it. If anything, the latter
is more straightforward.

Am I missing something?

> >
> > >  }
> > >
> > >  static bool zswap_erase(struct zswap_tree *tree, struct zswap_entry =
*entry)
> > >  {
> > > +       struct zswap_entry *e;
> > >         pgoff_t offset =3D swp_offset(entry->swpentry);
> > > -       if (!RB_EMPTY_NODE(&entry->rbnode)) {
> > > -               struct zswap_entry *old;
> > > -               old =3D xa_erase(&tree->xarray, offset);
> > > -               BUG_ON(old !=3D entry);
> > > -               rb_erase(&entry->rbnode, &tree->rbroot);
> > > -               RB_CLEAR_NODE(&entry->rbnode);
> > > -               return true;
> > > -       }
> > > -       return false;
> > > +       XA_STATE(xas, &tree->xarray, offset);
> > > +
> > > +       do {
> > > +               xas_lock_irq(&xas);
> > > +               do {
> > > +                       e =3D xas_load(&xas);
> > > +               } while (xas_retry(&xas, e));
> > > +               if (xas_valid(&xas) && e !=3D entry) {
> > > +                       xas_unlock_irq(&xas);
> > > +                       return false;
> > > +               }
> > > +               xas_store(&xas, NULL);
> > > +               xas_unlock_irq(&xas);
> > > +       } while (xas_nomem(&xas, GFP_KERNEL));
> > > +       return !xas_error(&xas);
> > >  }
> >
> > Same here, I think we just want:
> >
> > return !!xa_erase(..);
>
> For the erase case it is tricky.
> The current zswap code does not erase an entry if the tree entry at
> the same offset has been changed. It should be fine if the new entry
> is NULL. Basically some race to remove the entry already. However, if
> the entry is not NULL, then force resetting it to NULL will change
> behavior compared to the current.

I see, very good point. I think we can use xa_cmpxchg() and pass in NULL?

