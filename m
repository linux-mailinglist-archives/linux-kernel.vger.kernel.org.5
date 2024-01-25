Return-Path: <linux-kernel+bounces-39168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF18D83CBD1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1DC1C20D4A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81461339BE;
	Thu, 25 Jan 2024 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSpcK9jc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C60479C7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209440; cv=none; b=iMR2xIZJra+NnYd8fwgDkz4Au0Imi/f4EZ/Mnxri9dHn5lGCYe9B6zgggri1m5c/5TdCRm54p/lXYYQKePvPATydrDlmEFAqQwebo4qZidZKX1TM+gzbV91W7SojEDXqWaGsG7OfdDFzYPqHhyzlyGiCA1Nidi4AjpdYs2hfWMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209440; c=relaxed/simple;
	bh=OKQ5H3y/6ft4s4cArnAzRiS4QoNgetqAsWM0oJmFgUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODPy3s9W/jaQHz8E5k9+dsYwQoiU83E8QhuLDOT5fnDX7739wG4q0hmaMcxUfYI9VVPQbN+cZSqTjsSo9UshtLDdTDFc8DH/7wo17OzuPNR1L1vuaEnN1rQCZsyQEZHoCAm99YvGkqFXcmTcy3L9z0pDvIxU8dzgkYZDALM/M6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSpcK9jc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94942C433A6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 19:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706209439;
	bh=OKQ5H3y/6ft4s4cArnAzRiS4QoNgetqAsWM0oJmFgUQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nSpcK9jcFSG0UNQr+qnc361vIgn7yfPjan65bjBThR/U8/DxQpHH2QxDbadfRTa1M
	 AlZ8vFpkm+tXmOhKpCs5RrBoI+xNk8Wc+kkmIVPt1Sk1ZVDoOOUiW7cAHMvub6CcNh
	 K5oWuB9JlFGcEeE2rRX+yYYYPS6w7xKqaxM5r0s4nnFLLLsO3Iu8Mah/gPpZg2eBea
	 9bzXTowS2qQQqPIT+1tJmc6DQV3SKV4IEmWASOMQGGivVZIMnGESd/ffnZOkp+zUjG
	 WOjqyWjzUwd6VubemssATJtaGzIUwa/216mxdyhCOJH+wO0r3a+UDLMzpAugEtV5M4
	 mJhN1O15ldweg==
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d88e775d91so7289705ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:03:59 -0800 (PST)
X-Gm-Message-State: AOJu0YwfPsqZQJqIh6gHYJwd1sWvcRoKT9/vZb4FKowzG5rX0O7vccYQ
	zzgfS6J1J5HPZg80/4cdYR5rPbQ0poDL7t+Ub8uH0C7465CAdf7PIfcbA4lIk8CLh67/fhyAUXQ
	tHY4EY+U4LTEZPTgK9mASzgy5IUAtRe6reAkq
X-Google-Smtp-Source: AGHT+IEfP/516rZwAoRiJwHeoRL6xGx7Ks8U9uIvUP18ohazY66Y7FFyTBlYkQa0r/b+xoIP2I+l/rYfWzkU0uBkuYE=
X-Received: by 2002:a17:90a:c503:b0:28b:2f4f:75e7 with SMTP id
 k3-20020a17090ac50300b0028b2f4f75e7mr70350pjt.13.1706209439002; Thu, 25 Jan
 2024 11:03:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-3-yosryahmed@google.com> <20240122201906.GA1567330@cmpxchg.org>
 <CAJD7tkaATS48HVuBfbOmPM3EvRUoPFr66WhF64UC4FkyVH5exg@mail.gmail.com>
 <20240123153851.GA1745986@cmpxchg.org> <CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com>
 <20240123201234.GC1745986@cmpxchg.org> <CAJD7tkZC6w2EaE=j2NEVWn1s7Lo2A7YZh8LiZ+w72jQzFFWLUQ@mail.gmail.com>
 <f3fa799f-1815-4cfe-abc8-3ba929fcd1ba@bytedance.com> <CAF8kJuOv0FHsHgp=i7ZzjTpvZ7fN8uOQ3DT=8Q2eYWzRM7Hsgw@mail.gmail.com>
 <CAJD7tkY=qy+dfKacFOBx4uW6hDJwf20ODBgVWRP919hEY5URnQ@mail.gmail.com>
In-Reply-To: <CAJD7tkY=qy+dfKacFOBx4uW6hDJwf20ODBgVWRP919hEY5URnQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 25 Jan 2024 11:03:47 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOvjJ1ARzAGMVheDgq6tpUM76BZ9GggWj7CB=J3XgU6mw@mail.gmail.com>
Message-ID: <CAF8kJuOvjJ1ARzAGMVheDgq6tpUM76BZ9GggWj7CB=J3XgU6mw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:02=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> > > // lru list lock held
> > > shrink_memcg_cb()
> > >   swpentry =3D entry->swpentry
> > >   // Don't isolate entry from lru list here, just use list_lru_putbac=
k()
> > >   spin_unlock(lru list lock)
> > >
> > >   folio =3D __read_swap_cache_async(swpentry)
> > >   if (!folio)
> > >     return
> > >
> > >   if (!folio_was_allocated)
> > >     folio_put(folio)
> > >     return
> > >
> > >   // folio is locked, swapcache is secured against swapoff
> > >   tree =3D get tree from swpentry
> > >   spin_lock(&tree->lock)
> >
> > That will not work well with zswap to xarray change. We want to remove
> > the tree lock and only use the xarray lock.
> > The lookup should just hold xarray RCU read lock and return the entry
> > with ref count increased.
>
> In this path, we also invalidate the zswap entry, which would require
> holding the xarray lock anyway.

It will drop the RCU read lock after finding the entry and re-acquire
the xarray spin lock on invalidation. In between there is a brief
moment without locks.

Chris

