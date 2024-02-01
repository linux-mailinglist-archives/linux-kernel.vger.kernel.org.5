Return-Path: <linux-kernel+bounces-47494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E868844E9E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B5C1C29EB6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFD84403;
	Thu,  1 Feb 2024 01:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="okgUgo8B"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3C12116
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 01:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706750553; cv=none; b=LmBPlyv69LR7JUHk1x1zJn0gosEWWwWRzWwCsvCjyvsdTVAEwGTkbbHodSaEFrtzKLaGKPZ9QhPwWO2DQCR5nFHErkfkam44J6pTrkAwf3Gd/MczBH1AdSg5kxCKVnAa9GvKitjzTEvjiBL+YCTmNOyoVhZrNE38Xrl8qV05QtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706750553; c=relaxed/simple;
	bh=aEKufm4NNdv5kiYkiKhX+BFZ1Ds7FoO/aoWc/2QOVlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EzDBVpdwb2N+w9hj5dPVgWizYlbsEVt6Lpt1OgYqAhZJ9jZfw69lg7XbJ0S4G1Lx7RPyE1zJwpw3CeBXfU60C7CORjHXfJccp7Q/9cx7Gjb0puud/qorVn2D1xx8lfIIXJ/WKvn03dIe7oSA3KqGBB6OhhmWObQd39q/Y1dBkhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=okgUgo8B; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5112b1a795aso528045e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706750550; x=1707355350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1i2UN1ZAwaudGKHw526hiiniRq9FbmCBbcGNJI+D8E=;
        b=okgUgo8BLDUzlavskTd4/B6sP+P8PNHMmeGAM6cl+QL2uLYrRLJuVrGQ5TQPUepKiJ
         EmuenIoG2uuuFSHBRStwDHxSlmGCmm2XDX2rd5gxBWi2xMlUYpWERKsUXY0RSYniL6UO
         hOiuWDMcivSWtk0hgVatbmvEotgYWshDJJdkW1A6JTZVLzhTnZAwKWtFl8YD0jkre3wy
         V/JsOzsa2OK+MbZN9Agt/TYtdDZlCozTLuRrKOP7ZfHqmw5JmCyS7m86XWcXgNxTbwMO
         L2bXSeHRdBJ3qMJE7e25jYA2t0fokM/q8v4CdcMSQDYDW4IRmp0hdA3HNuLDGd0QjWpo
         HDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706750550; x=1707355350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1i2UN1ZAwaudGKHw526hiiniRq9FbmCBbcGNJI+D8E=;
        b=ZJvhdIHfLnOWB0jySXy1AmRoYXL/bY7hsVxT5hQ7GRJEx0skOH5EGXavvKMy2GCWt1
         s3DBIDY2xgUaIxZKXucdPYxIIt4w+Uf/jtRx3hpEyq9v3aD9tUDsQNxuTi/wd/ISaH7M
         PAJaki/xYzfsacP9LA+iHbLaF8hl/GEDuJvL4Ix2d3p0BH7oOWi/9u5rF5twTMeA3cWe
         o/8vGdqUU4wEPczTQlmL0XeT6by1XxI94ccDI/bXBnprRTcAJI9odHCQggaoZ62Jv93k
         KCEC3MDzccGXxPrBm4TZx1HlPXPIpOmHpM28n6CaBkNhj6vCKI+zbdOafLbvtd1fLdem
         Cn7w==
X-Gm-Message-State: AOJu0YzRq8dW7mCtxQiRG6MuInc4+iQOvyZKFyWICbM907P+WxB6erfj
	PO0L6sNF/meelxuiZwEuw0fB/Vpu0sxMsjo1v5BqyBSkgdkuIEwJnr/L82HSykd6xrqagDLs8tx
	lJgyZMKBHGGDlQTelhM2DeEyL6ZNZIZRr42rB
X-Google-Smtp-Source: AGHT+IH9V/rMJKDrUr81CPdq7YwY4UmiRjjoIicx5JWHtVQaKpzF9lrDkfQ+tDXAGHij8ax9K42I1YO4yp/spgipZxw=
X-Received: by 2002:ac2:551c:0:b0:510:2582:5591 with SMTP id
 j28-20020ac2551c000000b0051025825591mr482052lfk.25.1706750549821; Wed, 31 Jan
 2024 17:22:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221-async-free-v1-1-94b277992cb0@kernel.org>
 <CAJD7tkY6XF_rhnAzqhZ-mo8yw-W4hOjxFsbvH04oqVr0u8mOzQ@mail.gmail.com> <CAF8kJuOZO5C6J44U0CkU-Y9nGYnYiX4EQddjJGo+fQxh3BDVQg@mail.gmail.com>
In-Reply-To: <CAF8kJuOZO5C6J44U0CkU-Y9nGYnYiX4EQddjJGo+fQxh3BDVQg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 31 Jan 2024 17:21:52 -0800
Message-ID: <CAJD7tkYEjr-o0hLVUFqNp+jCGeoYnzs+DsWL59O=FqrXDxW=UA@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: async free swap slot cache entries
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, =?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, 
	=?UTF-8?B?WXUgWmhhb++/vA==?= <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	=?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 4:57=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Yosry,
>
> On Thu, Dec 28, 2023 at 7:34=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Thu, Dec 21, 2023 at 10:25=E2=80=AFPM Chris Li <chrisl@kernel.org> w=
rote:
> > >
> > > We discovered that 1% swap page fault is 100us+ while 50% of
> > > the swap fault is under 20us.
> > >
> > > Further investigation show that a large portion of the time
> > > spent in the free_swap_slots() function for the long tail case.
> > >
> > > The percpu cache of swap slots is freed in a batch of 64 entries
> > > inside free_swap_slots(). These cache entries are accumulated
> > > from previous page faults, which may not be related to the current
> > > process.
> > >
> > > Doing the batch free in the page fault handler causes longer
> > > tail latencies and penalizes the current process.
> > >
> > > Move free_swap_slots() outside of the swapin page fault handler into =
an
> > > async work queue to avoid such long tail latencies.
> > >
> > > Testing:
> > >
> > > Chun-Tse did some benchmark in chromebook, showing that
> > > zram_wait_metrics improve about 15% with 80% and 95% confidence.
> > >
> > > I recently ran some experiments on about 1000 Google production
> > > machines. It shows swapin latency drops in the long tail
> > > 100us - 500us bucket dramatically.
> > >
> > > platform        (100-500us)             (0-100us)
> > > A               1.12% -> 0.36%          98.47% -> 99.22%
> > > B               0.65% -> 0.15%          98.96% -> 99.46%
> > > C               0.61% -> 0.23%          98.96% -> 99.38%
> >
> > I recall you mentioning that mem_cgroup_uncharge_swap() is the most
> > expensive part of the batched freeing. If that's the case, I am
> > curious what happens if we move that call outside of the batching
> > (i.e. once the swap entry is no longer used and will be returned to
> > the cache). This should amortize the cost of memcg uncharging and
> > reduce the tail fault latency without extra work. Arguably, it could
> > increase the average fault latency, but not necessarily in a
> > significant way.
> >
> > Ying pointed out something similar if I understand correctly (and
> > other operations that can be moved).
>
> If the goal is to let the swap fault return as soon as possible. Then
> the current approach is better.
> mem_cgroup_uncarge_swap() is only part of it. Not close to all of it.

I think there are a lot of operations that we can move out of
swapcache_free_entries():
- mem_cgroup_uncharge_swap()
- arch_swap_invalidate_page()
- zswap_invalidate()
- clear_shadow_from_swap_cache()
, and maybe others.

I am curious, if we move these operations from the batched freeing,
would this remove the increased tail latency and make it more
consistent, without doing extra work?

I believe this is what Ying was also asking about.

>
> >
> > Also, if we choose to follow this route, I think there we should flush
> > the async worker in drain_slots_cache_cpu(), right?
> Not sure I understand this part. The drain_slots_cache_cpu(), will
> free the entries already. The current lock around cache->free_lock
> should protect async workers accessing the entries. What do you mean
> by flushing?

Never mind. I just realized that the percpu caches are static, so they
are not freed in drain_slots_cache_cpu(). The NULL check in the async
worker should be enough protection.

