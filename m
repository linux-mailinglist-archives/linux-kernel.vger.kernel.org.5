Return-Path: <linux-kernel+bounces-35011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6CD838A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE601C23BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF855A0E6;
	Tue, 23 Jan 2024 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nn+2zH0F"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A40359B61
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002873; cv=none; b=e+g50NhWaRCQq282QVB1cAYYQyWcbrevg2KyGUeAoZEA8lWze58DbWvPtfKIinCV5K2EVBNfZOUKwokZ9m5PMKrl5T0iI847dp5KGHY2F5i2GFVVtkWG40oO4xgIX3yeILUGTTPYq0hdx5IVwR/kQR/ctpv2hCRDG4Oxoug2Yd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002873; c=relaxed/simple;
	bh=8u78/J+RjRUbYUI9yVVF6yW8nqAs/OzenKNfZLtFbdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umE+NQ2sCKHsVaZ9pM9q9CcCEeDxuYESMM1fWF4JnbQ1wHzm4g9bWE47qYbw6gHhWpwAodMfEj79np54gHDyQIkYy3zo040glfOQ5t3wsp323t5zSHJhiMLQteTM2ZdNDPBC3I8kWVvAb3qCmGun5QrqkBdeyqYVy95Ds2zaQtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nn+2zH0F; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a30a99c4609so55605666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706002870; x=1706607670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Jw7Te7uYE9PH5qHhJ1FdEJVlDUHOKVTA7B+Dxi5RB0=;
        b=Nn+2zH0F6mJMtPlUPc6c3GC8AnjswRTS5NvydFlD++ceuUh14jL4UHqKI0lJDYoZg3
         BT7mODiehwrL8Nlh/IDn6meZwvXkxBnE0o3WEDDjWD8yPvDnofhExx4nsoUQLyxLakzL
         oNcGLAFoxcL40Sz8XFaIWldAgsTC4+RQB2egmUcwqLgM69MC7BBg00Uq2TMNdfd/Ipey
         nrL2lQWU1fUE7+WNO9hQNq6MH2Igvf1WnDxEcC+6p8yhlEqm2adxMLpmLDDk+lLYocAP
         rwBswSbLuB55MuD9sXGuWirBR4boB29rYunwCQMDxw+v4E0KRmOl7zdAXs+p1ZVeU5tg
         Zwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706002870; x=1706607670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Jw7Te7uYE9PH5qHhJ1FdEJVlDUHOKVTA7B+Dxi5RB0=;
        b=ZTtsRUq3e5FAgHdlhTFNY1oamJRyJZUWoBQt2eHpfCR1dhbO1BrEJWdTYNs7oikNzZ
         G5eUAsyuFXWhjXK99BTvqORLfqERsUXf5u6dUolVPUzhPhDJ/gwrK7Ml/6FhwShNHUOL
         35AkSbBsxTzh7yiYwuRJi3hZN83mDiO0e8fOWD81SXDV9HqRyCGwc2WOo8NzYr+Tn0Hi
         zrPx+fL1HunAKjPKpsWYiuc5hyd+JWsv6ubefMTdIQ2YDGkfbWgYW7ozhN/8W1pch+xC
         3w+tXYTiNQNOB1Djh8m/OLZwnLpXbxfHAfM4tnPpJbSGQXcnEAusyGDsuWR08KuCPJWt
         cHyQ==
X-Gm-Message-State: AOJu0YxYONV8T2l+ZORAz8N2J4zlq4/npGiAzEDuY/EZ0KvaRwpmRozU
	4X82J+rWRR5AIRpdYbMAfMR64dPyTua7Iw1M2uoqN9IVrev96z8Zb5ve/sDYrzlizAawQZm9hD1
	1ZhMiRMf9gxncCc1jC7AU4KQsJv8IMw2eMdR8
X-Google-Smtp-Source: AGHT+IGpFf1LOqIC5er5+fjmEgG1UGwZ6ZIniiQMZxW+boi7YEZ/Y47r+BqG5im/8YHk1lTPopC5ij/1wYnb9hUHWzo=
X-Received: by 2002:a17:906:4ad2:b0:a30:6802:9d8 with SMTP id
 u18-20020a1709064ad200b00a30680209d8mr1435680ejt.26.1706002869919; Tue, 23
 Jan 2024 01:41:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-2-yosryahmed@google.com> <87wms0toh4.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87wms0toh4.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 23 Jan 2024 01:40:31 -0800
Message-ID: <CAJD7tkb=-0mP1CXEmAd4QjMXKgep7myHShiwUSNnY1cjfRqfJA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: swap: update inuse_pages after all cleanups are done
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 1:01=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Yosry Ahmed <yosryahmed@google.com> writes:
>
> > In swap_range_free(), we update inuse_pages then do some cleanups (arch
> > invalidation, zswap invalidation, swap cache cleanups, etc). During
> > swapoff, try_to_unuse() uses inuse_pages to make sure all swap entries
> > are freed. Make sure we only update inuse_pages after we are done with
> > the cleanups.
> >
> > In practice, this shouldn't matter, because swap_range_free() is called
> > with the swap info lock held, and the swapoff code will spin for that
> > lock after try_to_unuse() anyway.
> >
> > The goal is to make it obvious and more future proof that once
> > try_to_unuse() returns, all cleanups are done.
>
> Defines "all cleanups".  Apparently, some other operations are still
> to be done after try_to_unuse() in swap_off().

I am referring to the cleanups in swap_range_free() that I mentioned above.

How about s/all the cleanups/all the cleanups in swap_range_free()?

>
> > This also facilitates a
> > following zswap cleanup patch which uses this fact to simplify
> > zswap_swapoff().
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  mm/swapfile.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 556ff7347d5f0..2fedb148b9404 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -737,8 +737,6 @@ static void swap_range_free(struct swap_info_struct=
 *si, unsigned long offset,
> >               if (was_full && (si->flags & SWP_WRITEOK))
> >                       add_to_avail_list(si);
> >       }
> > -     atomic_long_add(nr_entries, &nr_swap_pages);
> > -     WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
> >       if (si->flags & SWP_BLKDEV)
> >               swap_slot_free_notify =3D
> >                       si->bdev->bd_disk->fops->swap_slot_free_notify;
> > @@ -752,6 +750,8 @@ static void swap_range_free(struct swap_info_struct=
 *si, unsigned long offset,
> >               offset++;
> >       }
> >       clear_shadow_from_swap_cache(si->type, begin, end);
> > +     atomic_long_add(nr_entries, &nr_swap_pages);
> > +     WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>
> This isn't enough.  You need to use smp_wmb() here and smp_rmb() in
> somewhere reading si->inuse_pages.

Hmm, good point. Although as I mentioned in the commit message, this
shouldn't matter today as swap_range_free() executes with the lock
held, and we spin on the lock after try_to_unuse() returns. It may
still be more future-proof to add the memory barriers.

In swap_range_free, we want to make sure that the write to
si->inuse_pages in swap_range_free() happens *after* the cleanups
(specifically zswap_invalidate() in this case).
In swap_off, we want to make sure that the cleanups following
try_to_unuse() (e.g. zswap_swapoff) happen *after* reading
si->inuse_pages =3D=3D 0 in try_to_unuse().

So I think we want smp_wmb() in swap_range_free() and smp_mb() in
try_to_unuse(). Does the below look correct to you?

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2fedb148b9404..a2fa2f65a8ddd 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -750,6 +750,12 @@ static void swap_range_free(struct
swap_info_struct *si, unsigned long offset,
                offset++;
        }
        clear_shadow_from_swap_cache(si->type, begin, end);
+
+       /*
+        * Make sure that try_to_unuse() observes si->inuse_pages reaching =
0
+        * only after the above cleanups are done.
+        */
+       smp_wmb();
        atomic_long_add(nr_entries, &nr_swap_pages);
        WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
 }
@@ -2130,6 +2136,11 @@ static int try_to_unuse(unsigned int type)
                return -EINTR;
        }

+       /*
+        * Make sure that further cleanups after try_to_unuse() returns hap=
pen
+        * after swap_range_free() reduces si->inuse_pages to 0.
+        */
+       smp_mb();
        return 0;
 }

Alternatively, we may just hold the spinlock in try_to_unuse() when we
check si->inuse_pages at the end. This will also ensure that any calls
to swap_range_free() have completed. Let me know what you prefer.

