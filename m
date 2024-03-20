Return-Path: <linux-kernel+bounces-108265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 668D8880885
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939BD1C2282D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B294637;
	Wed, 20 Mar 2024 00:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeU40jhz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABC9384
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710894416; cv=none; b=dQZ8mM31mOwTqKxJSGSrmLBXUtlRwRqUVZWSzdXz2tvlzYGJ+8gNEfHYmFeojXld/RrsLbXuUW37GyaU8LGLk1VdgE9UwdyedTZispqtLk82KQ1LJT647Ik/2I6vqQuKpEDXJEubgf3+Ayib+hQcNqNb/UcbXqBX4YdAY/aAVJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710894416; c=relaxed/simple;
	bh=laonG8fzc4W0KLfhP/nh9FxfIgaxqhil6/C//Bp4GJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNxdkyTn6FRcntGNsMDpX2GbLIHKcqlCQD9VtLFKtpvBF+xQ2tzZ3aG2huosqT4KIvSU/5yy8gPRDyDVVdBNWvRytBzRsUC8JEQv20X/c81fdt3LAZDKU0nMoHDHwCJi/ulCfdGXKUyc5fha7R+hZduZdVUKESB5OHzVyTodcJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeU40jhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2A2C43141
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710894415;
	bh=laonG8fzc4W0KLfhP/nh9FxfIgaxqhil6/C//Bp4GJs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oeU40jhz/tSdO8fBrm/BjW9wAs6R57+IuguVj+3W/coLupGMdSBELe57dApyEW+Dy
	 aRWXa7NVgwQ7oZgvuuKZLR17yf5g6ge0NthV8fee+pBJTUhWL+9RyVPrsnDMuGPdY/
	 ZMQdgMA4HCyhNA8NhFctYppAWRYpg5f7sEn32BXjKDYq4UYQggPOb7zk5wHrM5UfBX
	 ge8f7YRPhh0JxhswjWH58uSCgz7Zrq6jxtPHlnVlNzhT5VichIammsGmr2+Thajksh
	 Bwn+bWGB8QuUHSeBpr5+LyEGms6yzOJlHu77MVPEmnMpunvfTRr+reCzy2RGn4DrXd
	 sEfb1bkK/IpUQ==
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3684320a751so1376545ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:26:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW53Ps/pVf+x8duIqJ5SHMZI+DTYkkz2T7MFvP6t+0bywbffE89Eg/h/D5I9taPPDf51BnRJRPewaXHLJ4qCZy3LP6ITiMisJ6QKK6j
X-Gm-Message-State: AOJu0Yxo17xfJtzhVVz54MIhCu5fypbEyQOIfO9dY3xTf0V6/ZVMvg8K
	Gr5hMmpPJrG1YzkH3m9+KvNJbQLFaJAP+kg78PBSsN2d4rh7wE2qRNJtCo3IzzkQ+bumwCsp5kv
	4sipIRlBxRYwzvvrBZwuMFBycTmswIDrgvDPT
X-Google-Smtp-Source: AGHT+IFGCIu2gy3PVJ5M6fURfHkdTqF0RyxshlZnMRPY1pOkAJ7qwPFuX+07tEMYD1jL3L8CrB5fQrDKMdM2PLaKZMQ=
X-Received: by 2002:a05:6e02:ca6:b0:366:b269:f4dc with SMTP id
 6-20020a056e020ca600b00366b269f4dcmr4509037ilg.14.1710894414846; Tue, 19 Mar
 2024 17:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312-zswap-xarray-v6-1-1b82027d7082@kernel.org>
 <CAJD7tkZH-mU_7NMMBAS4nyfyWKKK3tSdQisVQ5iRqckqHouoJQ@mail.gmail.com>
 <20240316133302.GB372017@cmpxchg.org> <CAJD7tka4Cemq-1gkfB5fZ0cmKZFX76ZYjAsFQC_Pu_XqzhsL3A@mail.gmail.com>
In-Reply-To: <CAJD7tka4Cemq-1gkfB5fZ0cmKZFX76ZYjAsFQC_Pu_XqzhsL3A@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 19 Mar 2024 17:26:43 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMbE04GWWK1+-O8RMb7JzTXPAKFstF3pdch+mQJ6gbHWw@mail.gmail.com>
Message-ID: <CAF8kJuMbE04GWWK1+-O8RMb7JzTXPAKFstF3pdch+mQJ6gbHWw@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: replace RB tree with xarray
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Nhat Pham <nphamcs@gmail.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>, 
	Barry Song <baohua@kernel.org>, Chengming Zhou <chengming.zhou@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 11:12=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Sat, Mar 16, 2024 at 6:33=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Fri, Mar 15, 2024 at 06:30:37PM -0700, Yosry Ahmed wrote:
> > > [..]
> > > >
> > > > @@ -1555,28 +1473,35 @@ bool zswap_store(struct folio *folio)
> > > >  insert_entry:
> > > >         entry->swpentry =3D swp;
> > > >         entry->objcg =3D objcg;
> > > > -       if (objcg) {
> > > > -               obj_cgroup_charge_zswap(objcg, entry->length);
> > > > -               /* Account before objcg ref is moved to tree */
> > >
> > >
> > > I do not understand this comment, but it seems to care about the
> > > charging happening before the entry is added to the tree. This patch
> > > will move it after the tree insertion.
> > >
> > > Johannes, do you mind elaborating what this comment is referring to?
> > > It should be clarified, updated, or removed as part of this movement.
> >
> > Wait, I wrote that? ^_^
>
> Well, past Johannes did :)
>
> >
> > The thinking was this: the objcg reference acquired in this context is
> > passed on to the tree. Once the entry is in the tree and the
> > tree->lock released, the entry is public and the current context
> > doesn't have its own pin on objcg anymore. Ergo, objcg is no longer
> > safe to access from this context.
> >
> > This is a conservative take, though, considering the wider context:
> > the swapcache itself, through folio lock, prevents invalidation; and
> > reclaim/writeback cannot happen before the entry is on the LRU.
>
> Actually, I think just the folio being locked in the swapcache is
> enough protection. Even if the entry is added to the LRU, the
> writeback code will find it in the swapcache and abort.
>
> >
> > After Chris's patch, the tree is no longer a serialization point for
> > stores. The swapcache and the LRU are. I had asked Chris upthread to
> > add an explicit comment about that. I think once he does that, the
> > objcg situation should be self-evident as well.
>
> Perhaps it should be clarified that the swapcache on its own is enough
> protection against both invalidation and reclaim/writeback, and the
> entry not being on the LRU is *additional* protection on top of that
> against reclaim/writeback. Right?
>
> >
> > So in the next version, please just remove this now stale one-liner.
>
> Thanks for confirming. Chris, please remove this comment and update
> the comment Johannes asked you to add as mentioned above. Thanks!

Will do.

Chris

