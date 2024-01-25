Return-Path: <linux-kernel+bounces-39273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9FC83CDF2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D591F23C78
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23A91386CC;
	Thu, 25 Jan 2024 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ajMnkD3h"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A479F135412
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216509; cv=none; b=NPJT2AIHp+q1u0JbwSyijx2jG0KZL0ZOQj9d/j5TfojYs+IQ6HpJENQo2OxGqA3DTQC3zudai8v5pR16WHySUCsjY6EbVFbetJGf3XDKGWrAffaaS3f1bvQcib6PHQsyFnTljXi5qaf9LsktQYkCTeijUoQV/WH9q+1JQ3/e+/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216509; c=relaxed/simple;
	bh=tcjugv09goaYJycHAFYC9iMMXMtn7q48dmTFTXX855o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJNDbLYcTvKIZDz2fYq88/U9zsXSiOcikrfwWRmKSnlJ6x7gBTa1EakVjvKX3E6K4eLSkT6Nr/kFAp1Pqo6KStNtDTUd3ZHtU5fy6RT6dKLatYbtZuI3jQ2JVSsrK+zeyCQhdyk0WeWyXiMcUHsNpPbtNMnt6pm6PLYYobMdF5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ajMnkD3h; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a3a875f7fso7875635a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706216506; x=1706821306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHxJYsj3/b2slg0GpIBhdjGRhcgy6JBtBKDx08y8ugo=;
        b=ajMnkD3h4+Bxt7nUR2N88o2M91/iIdDM0f9ZfhlSfoCoGfBIP7QWS6NMqygZuUgQqx
         MELGxM1IzWzu95guiZhT2lLcsXtltD3dSZZ1C3KdcQ7r3nkiXcOX91jI/lMucWvk/kBZ
         vNeADYTcTvhkUVQ5TQFWiBgRO8WpBaa9y+Yz7JdNwPxnEkH/xCk2MtwQxwgzPDNu7ysD
         8evdENx3UWYvZJ7kIlTPdRzoZr8kb6EcoBz/9InxYD/fmJ873JVpJZfRfgul0xTu5aP8
         Gsy3YhkmrR8m4PD2YtfMXpSuvOj7e3BiMfAmFYyKGwo/HueHHc/a5X0gwD2KXRNGOhE/
         Sh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706216506; x=1706821306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHxJYsj3/b2slg0GpIBhdjGRhcgy6JBtBKDx08y8ugo=;
        b=Uz0XYOAdhfDC1ZMj40Fk5a3orOakypT2Wa/W9BPyoxNCvQuAZpf73QWZfxUQZ0tYKD
         ANGKhogfFbmlRRqtVwmq0ZoIIJGJ7Nl0giKjQEN4Z5eEucE54NyHSaIkL9loiHMdc0yD
         F/xA8clGu+nUSOgpaeIg6myuikyEIJ7yY25eXgqXQi+nTbG07B1xEASRpsADj6HCsEIu
         qUgIIc3G0ZHqoWvIINvmH4oW1uyfgVs5qXuUWeGNT+5Ans91FBLxc+QZOT84OO6Dekug
         Nycv+/3qQicAZBLt2E39xnaADjAtfjWiyKIuA+OnT/UStzVCZ+myE2RQ7lhgif4UZHRb
         D4Hw==
X-Gm-Message-State: AOJu0YxXu8zscGWEO0InbdmX/sLOJEW+X8OxwjrhhjtCpOVLShBSuoUy
	DHdXD/rv38DW4aZV9lw3sh5Tn0AhBwrwOHwWRrumkO3pwzhQb7AbK7eVwGjXTAX7u05rsVLoiDR
	BtHOqfHfaXnDO++YG8dXOvTrx3LEVqf4dzMEp
X-Google-Smtp-Source: AGHT+IGVqQ1zuVX6dgyb6dJad5fsCjEJeuiQ02r7PgRTBdEA7jkaRsHpW6P9wwBX8IfCUftLd+qYQ5g1jDWXThaYzyA=
X-Received: by 2002:a17:906:f189:b0:a27:7cc5:b019 with SMTP id
 gs9-20020a170906f18900b00a277cc5b019mr79138ejb.92.1706216505581; Thu, 25 Jan
 2024 13:01:45 -0800 (PST)
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
 <CAJD7tkY=qy+dfKacFOBx4uW6hDJwf20ODBgVWRP919hEY5URnQ@mail.gmail.com> <CAF8kJuOvjJ1ARzAGMVheDgq6tpUM76BZ9GggWj7CB=J3XgU6mw@mail.gmail.com>
In-Reply-To: <CAF8kJuOvjJ1ARzAGMVheDgq6tpUM76BZ9GggWj7CB=J3XgU6mw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 25 Jan 2024 13:01:09 -0800
Message-ID: <CAJD7tkZV0+aPD0_pcFONnsGXC0__62yyQQmXX8jj5G=-QAySsg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Chris Li <chrisl@kernel.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 11:04=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
>
> On Thu, Jan 25, 2024 at 12:02=E2=80=AFAM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > > > // lru list lock held
> > > > shrink_memcg_cb()
> > > >   swpentry =3D entry->swpentry
> > > >   // Don't isolate entry from lru list here, just use list_lru_putb=
ack()
> > > >   spin_unlock(lru list lock)
> > > >
> > > >   folio =3D __read_swap_cache_async(swpentry)
> > > >   if (!folio)
> > > >     return
> > > >
> > > >   if (!folio_was_allocated)
> > > >     folio_put(folio)
> > > >     return
> > > >
> > > >   // folio is locked, swapcache is secured against swapoff
> > > >   tree =3D get tree from swpentry
> > > >   spin_lock(&tree->lock)
> > >
> > > That will not work well with zswap to xarray change. We want to remov=
e
> > > the tree lock and only use the xarray lock.
> > > The lookup should just hold xarray RCU read lock and return the entry
> > > with ref count increased.
> >
> > In this path, we also invalidate the zswap entry, which would require
> > holding the xarray lock anyway.
>
> It will drop the RCU read lock after finding the entry and re-acquire
> the xarray spin lock on invalidation. In between there is a brief
> moment without locks.

If my understanding is correct, at that point in the code writeback is
guaranteed to succeed unless the entry had already been removed from
the tree. So we can use xa_cmpxchg() as I described earlier to find
and remove the entry in the tree only if it exists. If it does, we
continue with the writeback, otherwise we abort. No need for separate
load and invalidation. zswap_invalidate_entry() can return a boolean
(whether the entry was found and removed from the tree or not).

