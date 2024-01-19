Return-Path: <linux-kernel+bounces-31589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87C9833069
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08FBBB2212E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0AA58229;
	Fri, 19 Jan 2024 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iVegl6ZZ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749BD57888
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705700705; cv=none; b=qwn88AE5QelUMVgS88Tac4coGXp3PSXlf25Mo0ugYJlkUd9qhOP2+gzUJ5BPShLuLB8P/W6sRi3o3RwwFLuMbThAXoyIokp/iUltjhRjGj1ciPzD/Rtc5iAtWgTf8QD5kzGl2SbUsqadtEBf39hmTGjsjB4Oi6QjQWbJeshUSAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705700705; c=relaxed/simple;
	bh=UoTGZPGLjSKotWGcOsKycPrcx3E0xv916IA9TgXjXfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9ATvuatrEz/aWjWe0nW6WK9COpD7pxZUc3OzyTC5WFihtZXLTgYIty6DrAAf5Ir1dLrUoVm55yeHdgz6rsCZu830Y2mbnABj7pjbJvmzclJFmpf8D6he6P+BQQ58UDWe0bYyyGJuldXZcmt8Y3l7s+1WjlJbiGPubAVaDY1xfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iVegl6ZZ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2821884a09so93284566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705700701; x=1706305501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFHkRRUf4+mmCS00V7PU7SyvKE+JJ4qA1z51rRSw46o=;
        b=iVegl6ZZii9treZls2PIVBveubwyh2eneaBBce9eMt6olmtAa1hlUsOH8ppZ2V8tcg
         ZeVSiJF+BplYjgpc7LQj4LXYuGqZ+4eLUCb5YxDgYp1vyTH8LoPoitCYN+owOTILyf9h
         ImcL/1F0RCln0T6wip4ZpjtOMoQxBifzfpZKYr1oG0AcpnRL0tHWAkyjzHwVwNDyKZm0
         ry1LC9DaWDFFeyGuAPhOPyDZclPgv5F7PkmRjzmzv4+UxSzrBfDyGfakn0BiE8Hqd/Kz
         A9x1tGX+fgKjWPiWOKcVUS2fFGpOFmfqmmLB/w6KL5h0CLqYvGfA6E196UySvG5cbZY1
         KSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705700701; x=1706305501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFHkRRUf4+mmCS00V7PU7SyvKE+JJ4qA1z51rRSw46o=;
        b=NZdzVYBmfR45+c5UlLrQ+R7v26L1PLxUbgzjBVMw7PyZSlDEqZJRDG4uQTdusBHekd
         qZJ6cbIRYMJaTfv5oGfTfdf8IA5qPwaGaogQkmo5eA0LA1Yg3mHQ2rwnFyO8GBgKFo3O
         TeURu2pN/mmIOaotBLtVZdeUm+s7c7KB/FHd3mie2Hf762Dc08Q9WDjpwOO1VmPxdetD
         dwG0go7EYeSXj8zeENpcFOIt/SQL1YhypYDn7F8Am4Xbw2NDv3fW5HwbQ0sV74NEAW/u
         Db88j6e9MmqQXKanLved4MGMQY4fSZAotuxBSdGol3pQ1dFdnJF0s25NPNxMMITmbyMB
         1OLw==
X-Gm-Message-State: AOJu0YyeWWSpAQGreq1H8L99lHDVLeU8O0DXlpF8nwL4LpVGyLcb5als
	mu+gmzKk0K7V7REfH99pOdG052u5oQ68l6/w8pGgrpHD/oKB1pw32/OFnddcWhtsSyUHxnZRwQz
	f5vXryCP/K0CGDDTGXj1nOUexPa395GTMUvsiKqCQR3pAw46jOUvh
X-Google-Smtp-Source: AGHT+IHNH/A8G136eZd1r/TCC/N64BQ1NGlGnBBEvogcIwpsnX9PbC7a57fLAHve3xa3XPzkpth7hOSq93E+mezX0m8=
X-Received: by 2002:a17:907:d503:b0:a29:7ddf:40eb with SMTP id
 wb3-20020a170907d50300b00a297ddf40ebmr290646ejc.15.1705700701405; Fri, 19 Jan
 2024 13:45:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <20240117-zswap-xarray-v1-2-6daa86c08fae@kernel.org> <CAJD7tkZF102x_8LKAX+sxAttgYD_LNT3cRqeOr7_euwPfNdCFA@mail.gmail.com>
 <CAF8kJuMwF=s-28OPFbCfJf-f3jsfYmyiP6pSBjj8ZgkGmbT9ZA@mail.gmail.com>
 <CAJD7tkbdT-Bdi4YkOS_Px73dkhthq2qn6Yvy7CobzTBji0WMog@mail.gmail.com> <CAF8kJuOOwyzGGz21PKsGBdJBU3B+gk1+o78MwGqG5FDNZK9LSA@mail.gmail.com>
In-Reply-To: <CAF8kJuOOwyzGGz21PKsGBdJBU3B+gk1+o78MwGqG5FDNZK9LSA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 19 Jan 2024 13:44:25 -0800
Message-ID: <CAJD7tkbKvJtLNDZn7G=yJKH+tbdmhF7sbkWru-V7vrAVwGb2sg@mail.gmail.com>
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

On Fri, Jan 19, 2024 at 1:32=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Fri, Jan 19, 2024 at 11:37=E2=80=AFAM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> > > > I think using the xas_* APIs can be avoided here. The only reason w=
e
> > > > need it is that we want to check if there's an existing entry first=
,
> > > > and return -EEXIST. However, in that case, the caller will replace =
it
> > > > anyway (and do some operations on the dupentry):
> > >
> > > We might be able to for the insert case if we don't mind changing the
> > > code behavior a bit. My original intent is to keep close to the
> > > original zswap code and not stir the pot too much for the xarray
> > > replacement. We can always make more adjustment once the RB tree is
> > > gone.
> >
> > I don't see how this changes code behavior though. The current code in
> > zswap_store() will do the following:
>
> I am referring to the log and update counter happening after the zswap
> mapping was updated. Maybe nobody actually cares about that behavior
> difference. In my mind, there is a difference.

I don't think it matters tbh, certainly not worth the more complicated
implementation.

> > > > >  static bool zswap_erase(struct zswap_tree *tree, struct zswap_en=
try *entry)
> > > > >  {
> > > > > +       struct zswap_entry *e;
> > > > >         pgoff_t offset =3D swp_offset(entry->swpentry);
> > > > > -       if (!RB_EMPTY_NODE(&entry->rbnode)) {
> > > > > -               struct zswap_entry *old;
> > > > > -               old =3D xa_erase(&tree->xarray, offset);
> > > > > -               BUG_ON(old !=3D entry);
> > > > > -               rb_erase(&entry->rbnode, &tree->rbroot);
> > > > > -               RB_CLEAR_NODE(&entry->rbnode);
> > > > > -               return true;
> > > > > -       }
> > > > > -       return false;
> > > > > +       XA_STATE(xas, &tree->xarray, offset);
> > > > > +
> > > > > +       do {
> > > > > +               xas_lock_irq(&xas);
> > > > > +               do {
> > > > > +                       e =3D xas_load(&xas);
> > > > > +               } while (xas_retry(&xas, e));
> > > > > +               if (xas_valid(&xas) && e !=3D entry) {
> > > > > +                       xas_unlock_irq(&xas);
> > > > > +                       return false;
> > > > > +               }
> > > > > +               xas_store(&xas, NULL);
> > > > > +               xas_unlock_irq(&xas);
> > > > > +       } while (xas_nomem(&xas, GFP_KERNEL));
> > > > > +       return !xas_error(&xas);
> > > > >  }
> > > >
> > > > Same here, I think we just want:
> > > >
> > > > return !!xa_erase(..);
> > >
> > > For the erase case it is tricky.
> > > The current zswap code does not erase an entry if the tree entry at
> > > the same offset has been changed. It should be fine if the new entry
> > > is NULL. Basically some race to remove the entry already. However, if
> > > the entry is not NULL, then force resetting it to NULL will change
> > > behavior compared to the current.
> >
> > I see, very good point. I think we can use xa_cmpxchg() and pass in NUL=
L?
> >
> That is certainly possible. Thanks for bringing it up.
> Let me try to combine the tree->lock with xarray lock first. If
> xa_cmpxchg() can simplify the result there, I will use it.

SGTM.

> > Handling large folios in zswap is a much larger topic that involves a
> > lot more than this xa_* vs. xas_* apis dispute. Let's not worry about
> > this for now.
>
> Ack. One more reason to use the XAS interface is that zswap currently
> does multiple lookups on typical zswap_load(). It finds entries by
> offset, for the entry (lookup one). Then after folio install to swap
> cache, it deletes the entry, it will performan another lookup to
> delete the entry (look up two). Using XAS might be able to cache the
> node location for the second lookup to avoid the full node walk. That
> is not in my current patch and can be a later improvement patch as
> well.

One more straightforward optimization we can do with the xas_* API is
to cache the lookup done in zswap_load() and reuse it when doing
invalidations for exclusive loads.

For the initial implementation, let's keep it simple and try to use
the xa_* APIs where possible.

