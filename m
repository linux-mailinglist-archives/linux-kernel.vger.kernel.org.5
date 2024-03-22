Return-Path: <linux-kernel+bounces-110833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E28886478
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083D21C21F1B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D07138E;
	Fri, 22 Mar 2024 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaisNmUg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E3B10E3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711068096; cv=none; b=Su9GmAmyVm/njOaR3+6PBuqm/1N/KvwptNUaz+hJGeUw/BoAVjhDE7MnB0b5LRzMmxkO5XvCu5bQ/7XrdHMzGczAxyeq+3w8MhNV44GPgfrBDTKybDrIQ12L3DkwdhQFZzU889WmD3MJtTEfbEnPu6q8HdvY4+Y+WNAnfgm4LvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711068096; c=relaxed/simple;
	bh=UH+4ywsql5/vQaJCNVmGGH/4GxhNtUwh9xnmpT32IxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2jN4l1Z9g3KeJu1IqeyB4yIkg3vwmjI+YUaD3IoyMzkt3NWZxB3Y2Tp/a8p15/Hz+VLoTPF2VStioP/VBzg6amUpGexoARg3iQNP1j+qg05cPaHg95J7hDQWIIK/UnqDtUIhjjper+Aq76uqN2w8ywGuFWZ4gEVRixTEgO0/5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaisNmUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780F8C433C7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711068096;
	bh=UH+4ywsql5/vQaJCNVmGGH/4GxhNtUwh9xnmpT32IxU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SaisNmUgBsMs79qSLQPh0egDdyqI0icXbBoOH4Hxnb7gpyIAmJco4NRzCf+L+5j1y
	 ad70brPIgO2uxEPdWH0A46rWPYgEj7T4TqU4qdOLl3dFoDE52XYm/CBfvWnM7k5HoY
	 odM3Q4plzH03XpoVROgoYi2w7KV64s7HOQTMy/YyXEvk2qyjtryBaFWwXyZw/Bn/TQ
	 8I4uQb3y9FuyxB1EHfX5K0vG2T3qblx1uB9YDhbWKCU8HCywtliMCF3rV+vKecK6pT
	 tXa8VdWzt3SKDbhnDv8i6o8sRh2yEUZpc1DI7aIbJfj07ZVS1dN2AZ1Dw9BJPwwIRa
	 DEWsCP0QRcxDg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so20982281fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 17:41:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvZkU18/ead4qAxeomGX/pVxljmnSlE8/zWefa7dVyVpFiEH9MDjZgkEEax2vkmlftdKh9HkOeiPyJdwxox2H3poTacVdmMYatreOU
X-Gm-Message-State: AOJu0Yw90+8+pNdgA9H4wZbSV3tFxG7JeXYz3wr/tH/rFigmRrHCxmwU
	ByXFnH2/I1Xf8iD0fTkki0da1HdyXYR7zQMvru7+VzU4myOUo+8LFy3wQTU4BzBMTgPdg93klaT
	aePR3sZqdHBhvgu1IpIbjAo685Q==
X-Google-Smtp-Source: AGHT+IGGWjaY9cfNeIvOIRdpQr+qInr9/bOKNfk7UJKEEU3pIig/YFIE259HZrZQ6V+sQXZ6yoFf7ZDCGv03EvrUfqo=
X-Received: by 2002:a05:651c:1037:b0:2d4:5c0c:77db with SMTP id
 w23-20020a05651c103700b002d45c0c77dbmr653235ljm.3.1711068095191; Thu, 21 Mar
 2024 17:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321-zswap-fill-v1-1-b6180dbf7c27@kernel.org> <CAJD7tkY8os3yvYLiotaiRuYa1jdEGiPHQsZEU6E52zRBQ34kQQ@mail.gmail.com>
In-Reply-To: <CAJD7tkY8os3yvYLiotaiRuYa1jdEGiPHQsZEU6E52zRBQ34kQQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 21 Mar 2024 17:41:23 -0700
X-Gmail-Original-Message-ID: <CANeU7QmHs-8K7-6yoJS0ccfvP2SMNsSoYNZ8CnFep8isS8h=JQ@mail.gmail.com>
Message-ID: <CANeU7QmHs-8K7-6yoJS0ccfvP2SMNsSoYNZ8CnFep8isS8h=JQ@mail.gmail.com>
Subject: Re: [PATCH] zswap: initialize entry->pool on same filled entry
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 4:56=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Mar 21, 2024 at 4:53=E2=80=AFPM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > Current zswap will leave the entry->pool uninitialized if
> > the page is same  filled. The entry->pool pointer can
> > contain data written by previous usage.
> >
> > Initialize entry->pool to zero for the same filled zswap entry.
> >
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > ---
> > Per Yosry's suggestion to split out this clean up
> > from the zxwap rb tree to xarray patch.
> >
> > https://lore.kernel.org/all/ZemDuW25YxjqAjm-@google.com/
> > ---
> >  mm/zswap.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index b31c977f53e9..f04a75a36236 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1527,6 +1527,7 @@ bool zswap_store(struct folio *folio)
> >                         kunmap_local(src);
> >                         entry->length =3D 0;
> >                         entry->value =3D value;
> > +                       entry->pool =3D 0;
>
> This should be NULL.
>
> That being said, I am working on a series that should make non-filled
> entries not use a zswap_entry at all. So I think this cleanup is
> unnecessary, especially that it is documented in the definition of
> struct zswap_entry that entry->pool is invalid for same-filled
> entries.

It does not really hurt to initialize it. It is obviously correct if
we initialize it as well. One thing to consider is that, this pointer
can contain user space data if the page previously was map to user
space. Kdump typically doesn't save user space data. This
uninitialized value might let kdump contain user space data.

Chris

>
> >                         atomic_inc(&zswap_same_filled_pages);
> >                         goto insert_entry;
> >                 }
> >
> > ---
> > base-commit: a824831a082f1d8f9b51a4c0598e633d38555fcf
> > change-id: 20240315-zswap-fill-f65f44574760
> >
> > Best regards,
> > --
> > Chris Li <chrisl@kernel.org>
> >

