Return-Path: <linux-kernel+bounces-31580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3CB833051
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF23A1C2297A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625EF5914F;
	Fri, 19 Jan 2024 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4mWa9Em"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A8158123
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699919; cv=none; b=JA88Et58JiZIIGVbnmhKyFeqvVm881QNLnh7o+xp61gzyxJ+UOJ5VR1c5xn1sInFnBBAmbjZRualr9OAvMnlSKGp1KS7MKk2bSR/4Cj3QsxCOZ/qy3iq3/VoiEUbQj0nKpubAiL/p0s3kpJ3SfEFF+asTOfVuYYJDdJmKTkgdvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699919; c=relaxed/simple;
	bh=FFuVjU3mY+IzP8h5t5jS3m765EvdKkoQi/+p+qZCu84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9Bbosh8YBBZZLiTp90Gf5utdKCAalXc3Nsiae39j9U+0zwdTxYZwiSvMhfA2Kekx8lD3BHLy50oVuvv1SjnlO9vPCK/lF2Jsg4cF1CYZ8Mv70lO6Tc6/BBk1BxsQ50tnECrJB0FTtfNESj2P3ZIapon0hTXL9b8zjkH+yCifik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4mWa9Em; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABEEC43394
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 21:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705699919;
	bh=FFuVjU3mY+IzP8h5t5jS3m765EvdKkoQi/+p+qZCu84=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d4mWa9EmQX4yuKB4EXi5g51uWDIi2sdzsdWZbaRuxcfzcH8VJuuklFBO+SA6fMQs2
	 xxgPsDsc7/TeEiaZKfsUFn0T1yIQ2hJmHneKa3m5psG+BwhPd0v2aI9/tDM4OIyD2v
	 lDExuJ9Wcz1nTtEA4NNQtYhLTeJfeJM7SS61NAF1lGCjR1REb/utepZk+W9YCnrkeo
	 Qzd3Q8DZ/3xZma2JFIHBI5IWLlAU7RYQLXCm9v5VBtzsdoYfUb7XRHdWQQd/DKtAJq
	 EwbM8eb7unZtBGk3ULLQLVbHhD+Kk8qE6FNqrpIld4zXJ8OIMmn0JYa6TFgOqXqSLY
	 vuZm+MUk5unjw==
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d5f5a2e828so9477925ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:31:59 -0800 (PST)
X-Gm-Message-State: AOJu0YyXveSeTou+tz9TIVUZnz9QnhTr/EKNFc5+nkQcSgeDpLGUgmZb
	b4uo3HtdYDIyX8XSTJdkt8OuN1HRZtyetFBmxqIlwHSJy7SlVezd3I3p1nvaRbwC5ZXIoF85oEE
	XyG2pEwzs75F2S+KQj9CrDHC3mL/Sd4GxyxPZ
X-Google-Smtp-Source: AGHT+IH7jPpj5bIa8OCYsO+Psj8QEHoaSqxEzysy3jIV9/sxIC4fXEIhQsIPwKCqX5u1OZblRRB4L/oR3KEZydCuqtw=
X-Received: by 2002:a17:90b:108c:b0:28a:f0bc:2a9f with SMTP id
 gj12-20020a17090b108c00b0028af0bc2a9fmr342582pjb.21.1705699918523; Fri, 19
 Jan 2024 13:31:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <20240117-zswap-xarray-v1-2-6daa86c08fae@kernel.org> <CAJD7tkZF102x_8LKAX+sxAttgYD_LNT3cRqeOr7_euwPfNdCFA@mail.gmail.com>
 <CAF8kJuMwF=s-28OPFbCfJf-f3jsfYmyiP6pSBjj8ZgkGmbT9ZA@mail.gmail.com> <CAJD7tkbdT-Bdi4YkOS_Px73dkhthq2qn6Yvy7CobzTBji0WMog@mail.gmail.com>
In-Reply-To: <CAJD7tkbdT-Bdi4YkOS_Px73dkhthq2qn6Yvy7CobzTBji0WMog@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 19 Jan 2024 13:31:46 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOOwyzGGz21PKsGBdJBU3B+gk1+o78MwGqG5FDNZK9LSA@mail.gmail.com>
Message-ID: <CAF8kJuOOwyzGGz21PKsGBdJBU3B+gk1+o78MwGqG5FDNZK9LSA@mail.gmail.com>
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

On Fri, Jan 19, 2024 at 11:37=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> > > I think using the xas_* APIs can be avoided here. The only reason we
> > > need it is that we want to check if there's an existing entry first,
> > > and return -EEXIST. However, in that case, the caller will replace it
> > > anyway (and do some operations on the dupentry):
> >
> > We might be able to for the insert case if we don't mind changing the
> > code behavior a bit. My original intent is to keep close to the
> > original zswap code and not stir the pot too much for the xarray
> > replacement. We can always make more adjustment once the RB tree is
> > gone.
>
> I don't see how this changes code behavior though. The current code in
> zswap_store() will do the following:

I am referring to the log and update counter happening after the zswap
mapping was updated. Maybe nobody actually cares about that behavior
difference. In my mind, there is a difference.

>
> - Hold the tree lock to make sure no one else modifies it.
> - Try to insert, check if there is already a dupentry at the index and
> return -EEXIST.
> - Warn, increment zswap_duplicate_entry, and invalidate the dupentry.
> - Try to insert again (this should always succeed since we are holding
> the lock).
>
> What I am proposing is:
> - zswap_xa_insert() is a thin wrapper around xa_store() (or we can
> remove it completely).
> - zswap_store() does the following:
>   - Use zswap_xa_insert() and check if there is a returned dupentry.
>   - Warn, increment zswap_duplicate_entry, and invalidate the dupentry.
>
> Either way, we always place the entry we have in the tree, and if
> there is a dupentry we warn and invalidate it. If anything, the latter
> is more straightforward.
>
> Am I missing something?

No, that is what I would do if I have to use the xa_* API.


>
> > >
> > > >  }
> > > >
> > > >  static bool zswap_erase(struct zswap_tree *tree, struct zswap_entr=
y *entry)
> > > >  {
> > > > +       struct zswap_entry *e;
> > > >         pgoff_t offset =3D swp_offset(entry->swpentry);
> > > > -       if (!RB_EMPTY_NODE(&entry->rbnode)) {
> > > > -               struct zswap_entry *old;
> > > > -               old =3D xa_erase(&tree->xarray, offset);
> > > > -               BUG_ON(old !=3D entry);
> > > > -               rb_erase(&entry->rbnode, &tree->rbroot);
> > > > -               RB_CLEAR_NODE(&entry->rbnode);
> > > > -               return true;
> > > > -       }
> > > > -       return false;
> > > > +       XA_STATE(xas, &tree->xarray, offset);
> > > > +
> > > > +       do {
> > > > +               xas_lock_irq(&xas);
> > > > +               do {
> > > > +                       e =3D xas_load(&xas);
> > > > +               } while (xas_retry(&xas, e));
> > > > +               if (xas_valid(&xas) && e !=3D entry) {
> > > > +                       xas_unlock_irq(&xas);
> > > > +                       return false;
> > > > +               }
> > > > +               xas_store(&xas, NULL);
> > > > +               xas_unlock_irq(&xas);
> > > > +       } while (xas_nomem(&xas, GFP_KERNEL));
> > > > +       return !xas_error(&xas);
> > > >  }
> > >
> > > Same here, I think we just want:
> > >
> > > return !!xa_erase(..);
> >
> > For the erase case it is tricky.
> > The current zswap code does not erase an entry if the tree entry at
> > the same offset has been changed. It should be fine if the new entry
> > is NULL. Basically some race to remove the entry already. However, if
> > the entry is not NULL, then force resetting it to NULL will change
> > behavior compared to the current.
>
> I see, very good point. I think we can use xa_cmpxchg() and pass in NULL?
>
That is certainly possible. Thanks for bringing it up.
Let me try to combine the tree->lock with xarray lock first. If
xa_cmpxchg() can simplify the result there, I will use it.


> Handling large folios in zswap is a much larger topic that involves a
> lot more than this xa_* vs. xas_* apis dispute. Let's not worry about
> this for now.

Ack. One more reason to use the XAS interface is that zswap currently
does multiple lookups on typical zswap_load(). It finds entries by
offset, for the entry (lookup one). Then after folio install to swap
cache, it deletes the entry, it will performan another lookup to
delete the entry (look up two). Using XAS might be able to cache the
node location for the second lookup to avoid the full node walk. That
is not in my current patch and can be a later improvement patch as
well.

Chris

