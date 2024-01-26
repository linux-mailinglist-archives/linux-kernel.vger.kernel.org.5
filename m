Return-Path: <linux-kernel+bounces-40663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D37C83E3D0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604741C23B47
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B7E24B29;
	Fri, 26 Jan 2024 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPqrGKi+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F27241F8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706303992; cv=none; b=B2eWLee0GQUQGIrV7C+FfKQw67fxM+DqWotnFYmvyKugkMnamcDuA65Kr2AE8Q2zwDLZFAMY1OGuSJsqTQvkqJS5+f2oPy/B4L7lvqni3A3opfWKG9UPDgZE4BouJFAazsHtAbAiKu7NCxM9coouWSUZ9ft1JGUaVQ1vyXp0mLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706303992; c=relaxed/simple;
	bh=g+ueImr0RPbrGmsoFelyQwne/GFqsa3s9BFQ3P7pP6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osmKlq4gbg5+gNQzJYGMexPLA9i5joAt6aKtWz15Zkxf4nJPR0qy2Mh8KQOFKwGeg6C7dKaQWdTMXU4JgemjDGkA0KqJWHZq/tpco+SfQgoxsE70jcXVLoWQttpylKSit4nyBH7RoqdhmP/fPDqwIbrXh3rAZ/PKp0VoSSFef7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPqrGKi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E79C43394
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 21:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706303992;
	bh=g+ueImr0RPbrGmsoFelyQwne/GFqsa3s9BFQ3P7pP6E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KPqrGKi+69qOSpmZ+KbmvKosdLUluUxXRyfLOKziZHf9SYTF5dg5nDohrX04Mtd2f
	 O9MzBiJ0xZjyddx5W9BmphG4RxbxpQpVAb4JqJOJGJYRD2AFNboETG8o3V1RW0bvy2
	 IyBqnUBcZBH0p51/eWSIp6C6LumoSXi3fUcD4MlxQkqg103La62mLfa7tb9J/f4d13
	 kvfVJCw5Wk0YUa2YnsZrEFGlrr3ihDzOWvuQRu8DVU4Swg/I4A/bPjkiBKx4ZU6vAq
	 82POnO6+1+sAv35vwdkN02k0HnnUIaTPrdHfMjLhPUWIMvDimgSKFettCpXQKKB8I3
	 zS39aLdK7Dj9g==
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-361a38dd171so1312845ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:19:52 -0800 (PST)
X-Gm-Message-State: AOJu0YzXDW9k9llTLlsnOC9v2FRkNTEttdpqtsgSsIL5kB5n7bIfU3QO
	Ens8QcsIfB6bcDKvVy3AOIrcuWUKzussGXRgzWHdYo8f4aQmu/6FOkbVO9vvjvIcEQrOhDwURUt
	m5iULB9InJ7cU/4qktMWRsjmhjIW93dbzVDm2
X-Google-Smtp-Source: AGHT+IHjoovFGYhfrOsOiX2J7Q/RG5loa0jY/XGn0WfkMb+S6mul0iXCkOLNTpoaFmkgcvgll6/NAc0ys0f70Vs1YYg=
X-Received: by 2002:a05:6e02:1d15:b0:362:8bdf:45cc with SMTP id
 i21-20020a056e021d1500b003628bdf45ccmr516586ila.17.1706303991343; Fri, 26 Jan
 2024 13:19:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123184552.59758-1-ryncsn@gmail.com> <20240123184552.59758-2-ryncsn@gmail.com>
 <CAF8kJuNZP-uvsSshVrEY0bPsYLB+5Oi-bQKsEQ3RV6yOW+RgNA@mail.gmail.com>
 <CAMgjq7CbxZQ2CmWNjsNjJajBEVkZ839_X5twwLfiiv0-ZgN32A@mail.gmail.com>
 <ZbMDO5mkAFmN2LHz@google.com> <CAMgjq7AMZv7dmhoL_XgROnfHFWhsDDvFhZ--b-jzC47j=z-8ug@mail.gmail.com>
In-Reply-To: <CAMgjq7AMZv7dmhoL_XgROnfHFWhsDDvFhZ--b-jzC47j=z-8ug@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 26 Jan 2024 13:19:39 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOz4x_-yG=RHqMU2NP-TxSYNZ_kuDRK8avA3Xfjc3ZoVQ@mail.gmail.com>
Message-ID: <CAF8kJuOz4x_-yG=RHqMU2NP-TxSYNZ_kuDRK8avA3Xfjc3ZoVQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm, lru_gen: try to prefetch next page when
 scanning LRU
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yu Zhao <yuzhao@google.com>, Wei Xu <weixugc@google.com>, 
	Matthew Wilcox <willy@infradead.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 2:31=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>

> > > >
> > > > This makes the code flow much harder to follow. Also for architectu=
re
> > > > that does not support prefetch, this will be a net loss.
> > > >
> > > > Can you use refetchw_prev_lru_folio() instead? It will make the cod=
e
> > > > much easier to follow. It also turns into no-op when prefetch is no=
t
> > > > supported.
> > > >
> > > > Chris
> > > >
> > >
> > > Hi Chris,
> > >
> > > Thanks for the suggestion.
> > >
> > > Yes, that's doable, I made it this way because in previous series (V1
> > > & V2) I applied the bulk move patch first which needed and introduced
> > > the `prev` variable here, so the prefetch logic just used it.
> > > For V3 I did a rebase and moved the prefetch commit to be the first
> > > one, since it seems to be the most effective one, and just kept the
> >
> > Maybe something like this? Totally not tested. Feel free to use it any =
way you want.
> >
> > Chris
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 4f9c854ce6cc..2100e786ccc6 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3684,6 +3684,7 @@ static bool inc_min_seq(struct lruvec *lruvec, in=
t type, bool can_swap)
> >
> >                 while (!list_empty(head)) {
> >                         struct folio *folio =3D lru_to_folio(head);
> > +                       prefetchw_prev_lru_folio(folio, head, flags);
> >
> >                         VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(fo=
lio), folio);
> >                         VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio),=
 folio);
> > @@ -4346,7 +4347,10 @@ static int scan_folios(struct lruvec *lruvec, st=
ruct scan_control *sc,
> >
> >                 while (!list_empty(head)) {
> >                         struct folio *folio =3D lru_to_folio(head);
> > -                       int delta =3D folio_nr_pages(folio);
> > +                       int delta;
> > +
> > +                       prefetchw_prev_lru_folio(folio, head, flags);
> > +                       delta =3D folio_nr_pages(folio);
> >
> >                         VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(fo=
lio), folio);
> >                         VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio),=
 folio);
> >
>
> Thanks!
>
> Actually if benefits from 2/3 and 3/3 is trivial compared to the complexi=
ty and not appealing, then let's only keep the prefetch one, which will be =
just a one liner change with good result.

That is great. I did take a look at 2/3 and 3/3 and come to the same
conclusion regarding the complexity part.

If you resend the one liner for 1/3, you can consider it having my Ack.

Chris

