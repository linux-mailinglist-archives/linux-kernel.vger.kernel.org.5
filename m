Return-Path: <linux-kernel+bounces-36414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F9E83A060
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C43B1F29234
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B8A8C1C;
	Wed, 24 Jan 2024 04:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x/7wK9yi"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C63BE45
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706069776; cv=none; b=u1MrYSjnttFVvgm+UZApDpHq42hpxJlO3WPtPW/6T8NhackBWbIT6zH9ZTn3Xm2MPrGNRFUR1DnTXmmwKYDARvA/M1T5NvUlNHAwjby1fZqbjOjgQph3eigiUbMSx0KGU9x12KiBp6amzEyzoisLDF258V66riLtXP+Y9+NmwWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706069776; c=relaxed/simple;
	bh=bxKciMWTkznDTn0hni/KjJXgxqyonfruDOVay30TpiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rb33KQogmD5mddlg1oY0l5n7sAiEgd+kqUVAAr0gOXRuRWt5Q/C1KLV5CX9q5b9ezIipfSCRenxyibCZVNAZQgiHlziM8//tBjo3o83YHNtrfgBiWDOqPUpBrNfHffUL/3DUrqN2DV9lSJJqppAlIgoGAvQm1YyYOHChXgNvmCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x/7wK9yi; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5100cb238bcso1332532e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 20:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706069773; x=1706674573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Qab8SRWACvf6cv/ZfXhgOQYzxgAOfcaBZoqSpTBiLQ=;
        b=x/7wK9yiH7MtO+ZN4iwB8XFqmo4yUH0GTjWo51W2POeAcdqXWAp8k3IEWE6lddnXH0
         wodRDY8uFlYW4qVrIo1dGCKQRxwMt9TfaOgGmzGCHy0lIAlpgpX5KpNryk/DejhgluVs
         lNOZnVAVDK781OJck80GaEC1+dfPTlAEttPmrmTjLBUcF1KTxNX5L5g/wS2DMAPyiwYX
         PrXR2ErKDT94kecGcf7acwSOa9g0+wC5lTzbyyB784qjG2VNc6qLBPMwdb2+4NqhRVIh
         i/+dSg/9P659zuOLhm/t5F8K6Du38Q7K7K5msd8xAfG09GlV1iU9zOdZFxp7XvL+cW4c
         CHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706069773; x=1706674573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Qab8SRWACvf6cv/ZfXhgOQYzxgAOfcaBZoqSpTBiLQ=;
        b=mPxzOfyBKop8Y+LvV1Q7589idvkmVjLZVCzGioCCwYcEbicnddbS1U/iOZlBWB/bEU
         3RI4MlYMZwLGzxeuTEnNiHlhpqKcYYOq/kQbuErMqOxsUYGKCfVu2PK7P/UGc5PAN69Q
         G6BUj9rcudwxbO1V/tSrnfJXRT3MOD5qRH++3DK9SYJUb89Xlf/YXvdXRX3g6rbtlO92
         Cq3Lf+6I3PXZx4+iVjorW7hx4cYAEdqhOg5ADndnkLwGYRC0D11UzUE8rkazhKbHhxrp
         oC/h6/Z2Ix1Cz8OTHWqkmXqlXOoD09dG6toKh7Ae9kR0fAt1Y0mgbD7fp6u60FMnfaWQ
         3hfw==
X-Gm-Message-State: AOJu0YxLPZWt5uLVzlC1eqYgSzFHx5d0WtnSsibtT6ovFOYGHYIZckCd
	Ho926HxRDk29FK6CpdGdSJLoj2mNnE9gEs6TQK9uTMnQ/nwd0VAkbflpeWJVdRuVma7Rb8MnBUG
	UxPVNqY6FPlWKn2PPfkceuSeJ+uKTLMnDyo3M
X-Google-Smtp-Source: AGHT+IFVgSEvSMkCTmyC8Ljl0LoXmFmNHu+mQPfw91AtNRoOEzESlE289mx7tNZkHE//cn5CCuSPPV65dolc8E9vDA8=
X-Received: by 2002:a05:6512:685:b0:50e:594d:3533 with SMTP id
 t5-20020a056512068500b0050e594d3533mr3810083lfe.106.1706069772716; Tue, 23
 Jan 2024 20:16:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-2-yosryahmed@google.com> <87wms0toh4.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAJD7tkb=-0mP1CXEmAd4QjMXKgep7myHShiwUSNnY1cjfRqfJA@mail.gmail.com>
 <878r4ftodl.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAJD7tkbKxfuy-uWrOMVnOeDpx-TuJwosxk2jG_0Gx4bi1tUBog@mail.gmail.com>
 <874jf3tnpf.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <874jf3tnpf.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 23 Jan 2024 20:15:36 -0800
Message-ID: <CAJD7tkagZaddX3SPXiZNkJkRu8f5j11jk=AZMdWJ=f2jU6Ydfg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: swap: update inuse_pages after all cleanups are done
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 7:29=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Yosry Ahmed <yosryahmed@google.com> writes:
>
> >> > In swap_range_free, we want to make sure that the write to
> >> > si->inuse_pages in swap_range_free() happens *after* the cleanups
> >> > (specifically zswap_invalidate() in this case).
> >> > In swap_off, we want to make sure that the cleanups following
> >> > try_to_unuse() (e.g. zswap_swapoff) happen *after* reading
> >> > si->inuse_pages =3D=3D 0 in try_to_unuse().
> >> >
> >> > So I think we want smp_wmb() in swap_range_free() and smp_mb() in
> >> > try_to_unuse(). Does the below look correct to you?
> >> >
> >> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> > index 2fedb148b9404..a2fa2f65a8ddd 100644
> >> > --- a/mm/swapfile.c
> >> > +++ b/mm/swapfile.c
> >> > @@ -750,6 +750,12 @@ static void swap_range_free(struct
> >> > swap_info_struct *si, unsigned long offset,
> >> >                 offset++;
> >> >         }
> >> >         clear_shadow_from_swap_cache(si->type, begin, end);
> >> > +
> >> > +       /*
> >> > +        * Make sure that try_to_unuse() observes si->inuse_pages re=
aching 0
> >> > +        * only after the above cleanups are done.
> >> > +        */
> >> > +       smp_wmb();
> >> >         atomic_long_add(nr_entries, &nr_swap_pages);
> >> >         WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
> >> >  }
> >> > @@ -2130,6 +2136,11 @@ static int try_to_unuse(unsigned int type)
> >> >                 return -EINTR;
> >> >         }
> >> >
> >> > +       /*
> >> > +        * Make sure that further cleanups after try_to_unuse() retu=
rns happen
> >> > +        * after swap_range_free() reduces si->inuse_pages to 0.
> >> > +        */
> >> > +       smp_mb();
> >> >         return 0;
> >> >  }
> >>
> >> We need to take care of "si->inuse_pages" checking at the beginning of
> >> try_to_unuse() too.  Otherwise, it looks good to me.
> >
> > Hmm, why isn't one barrier at the end of the function enough? I think
> > all we need is that before we return from try_to_unuse(), all the
> > cleanups in swap_range_free() are taken care of, which the barrier at
> > the end should be doing. We just want instructions after
> > try_to_unuse() to not get re-ordered before si->inuse_pages is read as
> > 0, right?
>
> Because at the begin of try_to_unuse() as below, after reading, function
> returns directly without any memory barriers.
>
>   if (!READ_ONCE(si->inuse_pages))
>         return 0;

Right, I missed this one. Let me fix this up and send a v2.

Thanks!

