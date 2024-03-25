Return-Path: <linux-kernel+bounces-116527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0758988A06A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823051F39798
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C0E13E88F;
	Mon, 25 Mar 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiiyP1kN"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077974E39
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711342462; cv=none; b=BpnZnExCprinqRubuuDNWFqm3Jp7122bauh4iUkYOdEZtJ9CUmU/cqOZSrnCsI3kOtx9a4kRT+WIUqVqcKwoAgtFVWIDwUudZ4gOGyVz0OC6Z9b2LbIuFQWRrjmbHYrZcmQCqM3KkKD+LKsK+iut41bcMwoaIB8aa16kqjf9vCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711342462; c=relaxed/simple;
	bh=IUO5TFQ8ur58gp8X4v1NZYPJjtD2q5t3wiqkAEwYlMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0PWuK+JjQwQJzXQ2YuAUTgsuWlzPmUZll0O+KAe/1t2S5n1mbjmTj+GMXlyiegnbpjpHcRIn1SrjmREJLB6QH6A8GeefqIohfPlJ2pY1HdjwNY2Ob3kg4dzROt0JV9MNrKZb1cpdBsTA10Mi4XrMIdmUcVNyz18ATQU5iBFjMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiiyP1kN; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7e0f4106a8bso779261241.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 21:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711342459; x=1711947259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3flMnA28xnVDE8zVj79YDHLjc6D0x73P2ccGoK196hA=;
        b=aiiyP1kNcR2MOOUvHPwCZQvKR3b2ck7Y4FGXzXbZAf5zE2wTpKhBRwrT0VjDtkzv6B
         xwS+2BO08IPZY8Y2wB3/BZZbBjjrqTtQ8nHCzf5DPBBO9tQLJL5wWrb4A5PbNhDM9KnP
         +KZyFXD3sVkB9ss+/ji1OFtYkcAptHY5t/mvUKyGuwwRmlzQo37MLVfLI+KMK1JQ0gCt
         Wod56bc6nc6L+2uvdpjAu1uqhF27sWIhvVIk8aDsGgL7dmXkjDmvBVuY32QZoLZpaiwI
         ky2LccZHvkE3pmamquZWbu2YgXpPv3Y4opkLkiSQZEGg06AM9w5/iAZT3rb3d4tcx7wf
         fQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711342459; x=1711947259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3flMnA28xnVDE8zVj79YDHLjc6D0x73P2ccGoK196hA=;
        b=ICmW3NxSx9n+6tzBEwtGVUCzO5LeDuVezzXIEnkz4lEDpC/J4JcFmXAUhvkKZcltI4
         QCry5W2q7eSb7y50MM95s948YiN2lzTeRM0RpUEI34ofOxYXRyddfqchIM/LulpIZZFx
         KCljr3omtquPXUsUKSK+WD1OsaZ6gyqr5ixfnnnmq6U6Voedob91GpLrpnUrjfpJ/AlI
         9tsKtU7uRmzYjOS8LzGQH2m20GVjrFn5QQYIonNUJHUadDXq3v45IjOX/jfYu+zEizZE
         Uw39vtUstHP119PZuQWkOjyW4kwDfu0KuvxvK5DgnJPAhZLfPmqalSUeANOL5qh68Ama
         3avg==
X-Forwarded-Encrypted: i=1; AJvYcCWbQYhWCPvXfciKdH7Mt0Rqg0dWQf9vWIhRQagnG34+/+ESH5voToEWtsqgwJvBIlMbOSEg2jzTl8rIUruBZaGuy5slf2mzyFdNMZfK
X-Gm-Message-State: AOJu0Yzm47rYlh0bK2y6KuGj3tvPemtjBls1Y3pNO4RWrRNLtKPRt+x9
	R2zqVb9XyYTTevWaYGAdA37sYB0l+28sQn2MLP1xEzA863IlOk0o+ikPO+vbeZ2RWlS5ml9EWIe
	W8btZ3u0CkVaUx37eX7hEfAfRojg=
X-Google-Smtp-Source: AGHT+IEvq/NXn7dV2CoT+ELfsUm6EQA0YC7HkzwkQKfanBNR/yZjNX1onExkSyn1ahh09EqwKPvLef5Atf/363j39Ws=
X-Received: by 2002:a05:6102:32c6:b0:477:e55d:668f with SMTP id
 o6-20020a05610232c600b00477e55d668fmr202722vss.23.1711342459098; Sun, 24 Mar
 2024 21:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324210447.956973-1-hannes@cmpxchg.org> <CAJD7tkaWQAV=X1pzYG=VkWe7Ue9ZFbjt9uQ5m1NJujtLspWJTA@mail.gmail.com>
In-Reply-To: <CAJD7tkaWQAV=X1pzYG=VkWe7Ue9ZFbjt9uQ5m1NJujtLspWJTA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 25 Mar 2024 17:54:07 +1300
Message-ID: <CAGsJ_4yeBmNsMGXEWwC+1Hs5zJUP+becq4wG+6CpU7V1=EOvhg@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:23=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Sun, Mar 24, 2024 at 2:04=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > Zhongkun He reports data corruption when combining zswap with zram.
> >
> > The issue is the exclusive loads we're doing in zswap. They assume
> > that all reads are going into the swapcache, which can assume
> > authoritative ownership of the data and so the zswap copy can go.
> >
> > However, zram files are marked SWP_SYNCHRONOUS_IO, and faults will try
> > to bypass the swapcache. This results in an optimistic read of the
> > swap data into a page that will be dismissed if the fault fails due to
> > races. In this case, zswap mustn't drop its authoritative copy.
> >
> > Link: https://lore.kernel.org/all/CACSyD1N+dUvsu8=3DzV9P691B9bVq33erwOX=
NTmEaUbi9DrDeJzw@mail.gmail.com/
> > Reported-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> > Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
> > Cc: stable@vger.kernel.org      [6.5+]
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > Tested-by: Zhongkun He <hezhongkun.hzk@bytedance.com>

Acked-by: Barry Song <baohua@kernel.org>

>
> Do we also want to mention somewhere (commit log or comment) that
> keeping the entry in the tree is fine because we are still protected
> from concurrent loads/invalidations/writeback by swapcache_prepare()
> setting SWAP_HAS_CACHE or so?

It seems that Kairui's patch comprehensively addresses the issue at hand.
Johannes's solution, on the other hand, appears to align zswap behavior
more closely with that of a traditional swap device, only releasing an entr=
y
when the corresponding swap slot is freed, particularly in the sync-io case=
.

Johannes' patch has inspired me to consider whether zRAM could achieve
a comparable outcome by immediately releasing objects in swap cache
scenarios.  When I have the opportunity, I plan to experiment with zRAM.

>
> Anyway, this LGTM.
>
> Acked-by: Yosry Ahmed <yosryahmed@google.com>
>
> > ---
> >  mm/zswap.c | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 535c907345e0..41a1170f7cfe 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1622,6 +1622,7 @@ bool zswap_load(struct folio *folio)
> >         swp_entry_t swp =3D folio->swap;
> >         pgoff_t offset =3D swp_offset(swp);
> >         struct page *page =3D &folio->page;
> > +       bool swapcache =3D folio_test_swapcache(folio);
> >         struct zswap_tree *tree =3D swap_zswap_tree(swp);
> >         struct zswap_entry *entry;
> >         u8 *dst;
> > @@ -1634,7 +1635,20 @@ bool zswap_load(struct folio *folio)
> >                 spin_unlock(&tree->lock);
> >                 return false;
> >         }
> > -       zswap_rb_erase(&tree->rbroot, entry);
> > +       /*
> > +        * When reading into the swapcache, invalidate our entry. The
> > +        * swapcache can be the authoritative owner of the page and
> > +        * its mappings, and the pressure that results from having two
> > +        * in-memory copies outweighs any benefits of caching the
> > +        * compression work.
> > +        *
> > +        * (Most swapins go through the swapcache. The notable
> > +        * exception is the singleton fault on SWP_SYNCHRONOUS_IO
> > +        * files, which reads into a private page and may free it if
> > +        * the fault fails. We remain the primary owner of the entry.)
> > +        */
> > +       if (swapcache)
> > +               zswap_rb_erase(&tree->rbroot, entry);
> >         spin_unlock(&tree->lock);
> >
> >         if (entry->length)
> > @@ -1649,9 +1663,10 @@ bool zswap_load(struct folio *folio)
> >         if (entry->objcg)
> >                 count_objcg_event(entry->objcg, ZSWPIN);
> >
> > -       zswap_entry_free(entry);
> > -
> > -       folio_mark_dirty(folio);
> > +       if (swapcache) {
> > +               zswap_entry_free(entry);
> > +               folio_mark_dirty(folio);
> > +       }
> >
> >         return true;
> >  }
> > --
> > 2.44.0

Thanks
Barry

