Return-Path: <linux-kernel+bounces-47459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DAF844E3A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC4A1F27214
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79D2139F;
	Thu,  1 Feb 2024 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQ7+woMJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A6D20E4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749077; cv=none; b=H19TSl9fm2SKPpKgHZXwGrid0zr0XmgmclLpnRzSlhuFcGhydDajM6aAF/sz+oEwLoZHkvGP/9wt5ADyzc7BQAcISc58CKNXqLbsFIC+So2gB33Rj95N9jRKqq1Mkymz+1KhIcbRJtTVFJiIYOoNoqP9wBj4kt5It59ZGC5/abA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749077; c=relaxed/simple;
	bh=8k0ghcR4VPDFES5qhdUN/8xWWs6EqfQ8PKPk1D1kB24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLhoC5uocgPHjPkiWcsOjVmTFQh/jWZRogtJd+lrRKzKG/8gav/EH7icqA8aszwN70G4J6A6eNs9lWGj4DP/9yAZN7QKSSZLWuelpL6MJT2SIjTcW5pGeo1xd+jKHIVKQSXZhFn+EsK1xxOb1eok28IWBN0GmRzNIdybVWk7dKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQ7+woMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7F2C4166C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 00:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706749076;
	bh=8k0ghcR4VPDFES5qhdUN/8xWWs6EqfQ8PKPk1D1kB24=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RQ7+woMJyhZ5xwaXun7RkiXhY8yZcJcOm5385luZ5v8tXK1kYYWb2RqGkXjaomjiu
	 PaF7q7MjCmt8ICQ/fDoIURd93DpmZD452SGPP4/N+sJ/1MZSikMvRjs5kMrPYfHWQ1
	 Whxu+QKOkL0InXzf6oLYcRkoHgLfM/oNanA+iCnx3m4oxf5jiq66cO1gMeUHOrLkAd
	 6L20H2pM+L5SlOVZCRtRdCYwAXVr3OZtYDNwvzBGbCwXwO0OoZBJdCl73Kulu6Wu7B
	 gDc0fKB8THCXtC5b9OS0y6vhylMgXseWdKirjMWcDX0K1NE6ClbM54C9zPV4YmeN+x
	 JFbjYXPG3uXjQ==
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36380147a69so1640075ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:57:56 -0800 (PST)
X-Gm-Message-State: AOJu0YyIMWjRs/2lvPqF/mTclMLXNa+P3bkwRvHtnbVZH7hYphbH6/ze
	zM79xeKzIGxQBpdagobIQ08vqKq+ICnXlkA/FGSk3dIPiC8lfXYQdCuIISL3lkfXuEB2EzUTjdA
	chp0VKT68bRf2jxvl+M+X+p3qei1CwocjINhD
X-Google-Smtp-Source: AGHT+IGKUurwsJMSUXptg8WBQRlcd/mcUrOb09X7kqm5toaDCgm+DHc+joHcrdNygWdls/NNK4npl5EZGAuMVdJaRUc=
X-Received: by 2002:a05:6e02:1c87:b0:363:8c6c:4c8e with SMTP id
 w7-20020a056e021c8700b003638c6c4c8emr1046887ill.31.1706749075395; Wed, 31 Jan
 2024 16:57:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221-async-free-v1-1-94b277992cb0@kernel.org> <CAJD7tkY6XF_rhnAzqhZ-mo8yw-W4hOjxFsbvH04oqVr0u8mOzQ@mail.gmail.com>
In-Reply-To: <CAJD7tkY6XF_rhnAzqhZ-mo8yw-W4hOjxFsbvH04oqVr0u8mOzQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 31 Jan 2024 16:57:44 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOZO5C6J44U0CkU-Y9nGYnYiX4EQddjJGo+fQxh3BDVQg@mail.gmail.com>
Message-ID: <CAF8kJuOZO5C6J44U0CkU-Y9nGYnYiX4EQddjJGo+fQxh3BDVQg@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: async free swap slot cache entries
To: Yosry Ahmed <yosryahmed@google.com>
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

Hi Yosry,

On Thu, Dec 28, 2023 at 7:34=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Dec 21, 2023 at 10:25=E2=80=AFPM Chris Li <chrisl@kernel.org> wro=
te:
> >
> > We discovered that 1% swap page fault is 100us+ while 50% of
> > the swap fault is under 20us.
> >
> > Further investigation show that a large portion of the time
> > spent in the free_swap_slots() function for the long tail case.
> >
> > The percpu cache of swap slots is freed in a batch of 64 entries
> > inside free_swap_slots(). These cache entries are accumulated
> > from previous page faults, which may not be related to the current
> > process.
> >
> > Doing the batch free in the page fault handler causes longer
> > tail latencies and penalizes the current process.
> >
> > Move free_swap_slots() outside of the swapin page fault handler into an
> > async work queue to avoid such long tail latencies.
> >
> > Testing:
> >
> > Chun-Tse did some benchmark in chromebook, showing that
> > zram_wait_metrics improve about 15% with 80% and 95% confidence.
> >
> > I recently ran some experiments on about 1000 Google production
> > machines. It shows swapin latency drops in the long tail
> > 100us - 500us bucket dramatically.
> >
> > platform        (100-500us)             (0-100us)
> > A               1.12% -> 0.36%          98.47% -> 99.22%
> > B               0.65% -> 0.15%          98.96% -> 99.46%
> > C               0.61% -> 0.23%          98.96% -> 99.38%
>
> I recall you mentioning that mem_cgroup_uncharge_swap() is the most
> expensive part of the batched freeing. If that's the case, I am
> curious what happens if we move that call outside of the batching
> (i.e. once the swap entry is no longer used and will be returned to
> the cache). This should amortize the cost of memcg uncharging and
> reduce the tail fault latency without extra work. Arguably, it could
> increase the average fault latency, but not necessarily in a
> significant way.
>
> Ying pointed out something similar if I understand correctly (and
> other operations that can be moved).

If the goal is to let the swap fault return as soon as possible. Then
the current approach is better.
mem_cgroup_uncarge_swap() is only part of it. Not close to all of it.

>
> Also, if we choose to follow this route, I think there we should flush
> the async worker in drain_slots_cache_cpu(), right?
Not sure I understand this part. The drain_slots_cache_cpu(), will
free the entries already. The current lock around cache->free_lock
should protect async workers accessing the entries. What do you mean
by flushing?

Chris

