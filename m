Return-Path: <linux-kernel+bounces-37667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A1583B358
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F6ADB21C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1B81350D0;
	Wed, 24 Jan 2024 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FiZ+MbSY"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632097C091
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 20:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129674; cv=none; b=b+sWF+/fIBYreANuRzVY3U8Y3iN8FdCy9zWHkAj3Mof8ZZxqKn+c8CPM3CWcYrs8lG+dRn3gQRhEOWgpcQHe/SrrSTRFUecanxJunx8KPlXj5KeO+ECJXDfAQMHkHVm6PBFL/JM9rRCZ2fEXiaeiGK/qT/2FLjAiinYmIdJB7ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129674; c=relaxed/simple;
	bh=8PpHpDGTvd15z1lyjwFnCzu8+TWE5IPpOUUlHpqfM8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bW3MpML7OrE0SieK7MheJclMW00F+LV4GotWPww6YKmLKZHBB+mNOGEADxc+XECEltTEpJKaQ/hOcgSXtZKdch7KOaeoeButqhyr94tMs8W4bCln5+9fWaHY6uoxKDKs0qrDpG5NTYy9+MyexVSg9Ab8XPsvrIfVUGd/xYUzgIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FiZ+MbSY; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a311e9cca0cso118236366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706129670; x=1706734470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PpHpDGTvd15z1lyjwFnCzu8+TWE5IPpOUUlHpqfM8g=;
        b=FiZ+MbSYqFFf7hsqNZCFjGDz5HvIHlgjw8V+yyavc5t+5M5ryzgM9ywZOLHLEysz9N
         14F5oOhWBaE3YrZjwAjdTa9CvJq8/tN+9LaQFW40uyfVXuDrIXbdfweNX8GExJ79Uj0i
         5/fTprhLFkppv1r5GP5mQG9fM9kD332Qk+tRIf1X3xPD8xqUJgjIyvM65edcz3kSUFwF
         /hwFiaL7PyFYcKaY82xZMi8Kltc40G0tznxItB/zhLyHSf7RUgH15y6Myv6IHpyyspGG
         nK67m+jKjjltwAxgQSp6arAw+konL172NPfokMiEtVLpkRcAxzFe/mmctMhW2onctpgj
         XZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706129670; x=1706734470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PpHpDGTvd15z1lyjwFnCzu8+TWE5IPpOUUlHpqfM8g=;
        b=v0tIoB756kmxUt4K+EEr5rzW8U/Ph0LdZWXMSOnMHOihGZwO2QSKMUlZvD8iJHq59W
         xf/VVj7+EiWVsBkCn4pU6S/qZ6LNDS0VSklPo077RyL4vTfrwwB3iLAtr9hQ/jKONX3a
         pUeZzjALRSNaisBh9ccbo9nkfTqpL8wDxxYao7aHgl7bEhbcMMb6Ky1SDM5JBdjMT0o7
         zOvmRjCYfsLX1CZ9lj6xxSomf0V6fATp6h1mOSJ6Y1KxMS/DJTmExtqxCqFK6U9P/Iuc
         VoDSYQ4g0Oy9XDbLnJjIpFQRV3WxuceXd5xSbu0xU8E3kcgEAXHaCuh7miLxEgmdYFE0
         Iong==
X-Gm-Message-State: AOJu0Yy+cKMNfUx4hCgv+7xsjcjvnPUS73w68nxrcA3dTGsZqYLzxvuR
	oGWLpoh4Udw3L5o33GJMprwBOo532a2p9TJJIJYBi7Bfqt64/rwfZDYaEp+9+rAsDTVt5g8Fhei
	g8iCFQud69de/mMJfmUTYwC/TiEuR4lDsfmPb
X-Google-Smtp-Source: AGHT+IFQWuIM/i4iz3prv5tuO7tWXlBOX7HrLWHwiZ4AjwTkkZqPJOMU3T7di+dK4PngjAfTyy/+XdKG5uJUYqGzGjE=
X-Received: by 2002:a17:907:c5c4:b0:a31:524f:60e4 with SMTP id
 ts4-20020a170907c5c400b00a31524f60e4mr333052ejc.38.1706129670335; Wed, 24 Jan
 2024 12:54:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124100023.660032-1-yosryahmed@google.com> <CALvZod5+S5RLt5t=+ZvrRgOkAhNvC9mJo1SE7r6Ms1LRodV3RQ@mail.gmail.com>
In-Reply-To: <CALvZod5+S5RLt5t=+ZvrRgOkAhNvC9mJo1SE7r6Ms1LRodV3RQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 24 Jan 2024 12:53:52 -0800
Message-ID: <CAJD7tkYR8-Xo566=KwxiZDJVOqG0NvYCo0jwg59Loqd22CwCuA@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: optimize parent iteration in memcg_rstat_updated()
To: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 9:38=E2=80=AFAM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Wed, Jan 24, 2024 at 2:00=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > In memcg_rstat_updated(), we iterate the memcg being updated and its
> > parents to update memcg->vmstats_percpu->stats_updates in the fast path
> > (i.e. no atomic updates). According to my math, this is 3 memory loads
> > (and potentially 3 cache misses) per memcg:
> > - Load the address of memcg->vmstats_percpu.
> > - Load vmstats_percpu->stats_updates (based on some percpu calculation)=
.
> > - Load the address of the parent memcg.
> >
> > Avoid most of the cache misses by caching a pointer from each struct
> > memcg_vmstats_percpu to its parent on the corresponding CPU. In this
> > case, for the first memcg we have 2 memory loads (same as above):
> > - Load the address of memcg->vmstats_percpu.
> > - Load vmstats_percpu->stats_updates (based on some percpu calculation)=
.
> >
> > Then for each additional memcg, we need a single load to get the
> > parent's stats_updates directly. This reduces the number of loads from
> > O(3N) to O(2+N) -- where N is the number of memcgs we need to iterate.

This is actually O(1+N) not O(2+N). Every memcg needs one load, and
the first one needs an extra load.

> >
> > Additionally, stash a pointer to memcg->vmstats in each struct
> > memcg_vmstats_percpu such that we can access the atomic counter that al=
l
> > CPUs fold into, memcg->vmstats->stats_updates.
> > memcg_should_flush_stats() is changed to memcg_vmstats_needs_flush() to
> > accept a struct memcg_vmstats pointer accordingly.
> >
> > In struct memcg_vmstats_percpu, make sure both pointers together with
> > stats_updates live on the same cacheline. Finally, update
> > mem_cgroup_alloc() to take in a parent pointer and initialize the new
> > cache pointers on each CPU. The percpu loop in mem_cgroup_alloc() may
> > look concerning, but there are multiple similar loops in the cgroup
> > creation path (e.g. cgroup_rstat_init()), most of which are hidden
> > within alloc_percpu().
> >
> > According to Oliver's testing [1], this fixes multiple 30-38%
> > regressions in vm-scalability, will-it-scale-tlb_flush2, and
> > will-it-scale-fallocate1. This comes at a cost of 2 more pointers per
> > CPU (<2KB on a machine with 128 CPUs).
> >
> > [1] https://lore.kernel.org/lkml/ZbDJsfsZt2ITyo61@xsang-OptiPlex-9020/
> >
> > Fixes: 8d59d2214c23 ("mm: memcg: make stats flushing threshold per-memc=
g")
> > Tested-by: kernel test robot <oliver.sang@intel.com>
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202401221624.cb53a8ca-oliver.san=
g@intel.com
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
>
> Nice work.
>
> Acked-by: Shakeel Butt <shakeelb@google.com>

Thanks!

