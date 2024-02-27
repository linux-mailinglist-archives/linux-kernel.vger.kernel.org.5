Return-Path: <linux-kernel+bounces-84155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329B886A335
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555101C242F7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3751B55E52;
	Tue, 27 Feb 2024 23:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MICrNUC2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE3E55C32
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074906; cv=none; b=gTYfjgatFykCbMOgQQ/0AMCnSXF9KsY9QVpjR+peWOm0ZgSuJrN9N2Xr5sH546vJxmTjON3H38FeuOMVmTSYDY3Jsy2y8GVwmbRp6tKiC+4E+MH2GbXXiLV2EKtMhRbgiT/H4r9XSlKYtq+9KW0HUs6NDDTuWEInE5oP6dqZ9Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074906; c=relaxed/simple;
	bh=ltQf9QGvHmKdkf4gUO5QGjXTQ1hZxW5t+zJTbMUaYU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acjYTyjbMdQOEwt0CDlquCJ+8b+AHR4BCoGAIWs4rX6oSW56aDEcJCgMLkySdmwS70qlBGWQfJxVKw/22ruN4+gG7Z5Fparybr2MsQKi6ayM45EPnZKs+7X852cj2LanHMEk+ZqvQnDJsKTQiddgwGZURU1KnccDea9kdbrr354=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MICrNUC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1243FC4166D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709074906;
	bh=ltQf9QGvHmKdkf4gUO5QGjXTQ1hZxW5t+zJTbMUaYU8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MICrNUC2f5QzOXvD0VqDHrSxdiyqnE3VJLUhrLLGGTBj49yN9dSC8gdIc1IFtM72K
	 aZSBf5llLvLYcyoQHkn/62sf43Y2AKFj3k//V+fzvcsaoSqhSTojU//cveZgogaNT0
	 HJyFGMBBuVzIfIQkC6xQ7b6mppOzzu/wogd0ZyCNJiB67VvQZrDJyebXQRX72b0TN9
	 Fdy8gkj19ApYabnsmlsEr50v78/XY031kTRwEvgzy8TCgWLHsOm9IqAnd9uTUVKCTB
	 idH4KYEJHks13kOUH+sz/rVC2AcuerrGbrRKrr9FG3N0TcVlHA8WyS/N0yUSlBfyHO
	 /S1njTyfYJSUQ==
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-365afa34572so3351255ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:01:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW/iZl8XV5+Y6Yl42LKDHXBK61KfawLDiddJGW9NqGHFyVRAVDxZ4V7qG8Ws44dkj4jlkbDSJMaMa307wF8JoUqzJ+Gq5flvVEFucV6
X-Gm-Message-State: AOJu0YwQsP3qeYR6L3L73HMjqCWw4gd4n0VAidX6psYeWgEOg58PNcWG
	q9V7gQmQFodYZXIT5I2xqSDuDEw1kklxVepUA99n2NUZMdgrdRRySfdlpc7EEJv1nIgKlVG+noQ
	CJ79BHI3uOpXEU3KyGY9G85K4VZYRJfWzWZ/a
X-Google-Smtp-Source: AGHT+IEBT0yzs7D3rJSX2Vi+s9A19tz0c6SONKG25kyDAzEkDeKh4f8hbYmOEY47nEtjTinQSJXplqpfxt0vU+1Uw9Y=
X-Received: by 2002:a92:d30d:0:b0:365:cf7:af3a with SMTP id
 x13-20020a92d30d000000b003650cf7af3amr10903664ila.21.1709074905147; Tue, 27
 Feb 2024 15:01:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219082040.7495-1-ryncsn@gmail.com> <20240219173147.3f4b50b7c9ae554008f50b66@linux-foundation.org>
 <CAMgjq7DgBOJhDJStwGuD+C6-FNYZBp-cu6M_HAgRry3gBSf7GA@mail.gmail.com>
 <CAGsJ_4zyf5OOq_WA7VjsDKp1ciaDwzM23Ef95_O-24oLtr_5AQ@mail.gmail.com>
 <CAMgjq7AnZJSseC2BB_nF+s533YybyP_WU8HijEKFA=OXE1x41Q@mail.gmail.com>
 <CAF8kJuMbocSa06MSeg5HOofWisc0BxVnCFBLdKErmV8_7pKhUA@mail.gmail.com> <CAMgjq7BHAk_6ktCruKq_Yc30n++yhUyKTqzQuJ9fPvGVNNSdVA@mail.gmail.com>
In-Reply-To: <CAMgjq7BHAk_6ktCruKq_Yc30n++yhUyKTqzQuJ9fPvGVNNSdVA@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 27 Feb 2024 15:01:32 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOXj+Q5O=eLaRJOZrHDs7wygdTEfY3MfqGWQCmjEWQ_XQ@mail.gmail.com>
Message-ID: <CAF8kJuOXj+Q5O=eLaRJOZrHDs7wygdTEfY3MfqGWQCmjEWQ_XQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm/swap: fix race when skipping swapcache
To: Kairui Song <ryncsn@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm <linux-mm@kvack.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Minchan Kim <minchan@kernel.org>, Barry Song <v-songbaohua@oppo.com>, Yu Zhao <yuzhao@google.com>, 
	SeongJae Park <sj@kernel.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Aaron Lu <aaron.lu@intel.com>, stable@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:14=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> On Wed, Feb 21, 2024 at 12:32=E2=80=AFAM Chris Li <chrisl@kernel.org> wro=
te:
> >
> > On Mon, Feb 19, 2024 at 8:56=E2=80=AFPM Kairui Song <ryncsn@gmail.com> =
wrote:
> >
> > >
> > > Hi Barry,
> > >
> > > > it might not be a problem for throughput. but for real-time and tai=
l latency,
> > > > this hurts. For example, this might increase dropping frames of UI =
which
> > > > is an important parameter to evaluate performance :-)
> > > >
> > >
> > > That's a true issue, as Chris mentioned before I think we need to
> > > think of some clever data struct to solve this more naturally in the
> > > future, similar issue exists for cached swapin as well and it has bee=
n
> > > there for a while. On the other hand I think maybe applications that
> > > are extremely latency sensitive should try to avoid swap on fault? A
> > > swapin could cause other issues like reclaim, throttled or contention
> > > with many other things, these seem to have a higher chance than this
> > > race.
> >
> >
> > Yes, I do think the best long term solution is to have some clever
> > data structure to solve the synchronization issue and allow racing
> > threads to make forward progress at the same time.
> >
> > I have also explored some (failed) synchronization ideas, for example
> > having the run time swap entry refcount separate from swap_map count.
> > BTW, zswap entry->refcount behaves like that, it is separate from swap
> > entry and manages the temporary run time usage count held by the
> > function. However that idea has its own problem as well, it needs to
> > have an xarray to track the swap entry run time refcount (only stored
> > in the xarray when CPU fails to get SWAP_HAS_CACHE bit.) When we are
> > done with page faults, we still need to look up the xarray to make
> > sure there is no racing CPU and put the refcount into the xarray. That
> >  kind of defeats the purpose of avoiding the swap cache in the first
> > place. We still need to do the xarray lookup in the normal path.
> >
> > I came to realize that, while this current fix is not perfect, (I
> > still wish we had a better solution not pausing the racing CPU). This
> > patch stands better than not fixing this data corruption issue and the
> > patch remains relatively simple. Yes it has latency issues but still
> > better than data corruption.  It also doesn't stop us from coming up
> > with better solutions later on. If we want to address the
> > synchronization in a way not blocking other CPUs, it will likely
> > require a much bigger change.
> >
> > Unless we have a better suggestion. It seems the better one among the
> > alternatives so far.
> >
>
> Hi,
>
> Thanks for the comments. I've been trying some ideas locally, I think a s=
imple and straight solution exists: We just don't skip the swap cache xarra=
y.

Yes, I have been pondering about that as well.

Notice in __read_swap_cache_async(), it has a similar
"schedule_timeout_uninterruptible(1)" when  swapcache_prepare(entry)
fails to grab the SWAP_HAS_CACHE bit. So falling back to use the swap
cache does not automatically solve the latency issue. Similar delay
exists in the swap cache case as well.

> The current reason we are skipping it is for performance, but with some o=
ptimization, the performance should be as good as skipping it (in current b=
ehavior). Notice even in the swap cache bypass path, we need to do one look=
up, and one modify (delete the shadow). That can't be skipped. So the usage=
 of swap cache can be better organized and optimized.

> After all swapin makes use of swap cache, swapin can insert the folio in =
swap cache xarray first, then set swap map cache bit. I'm thinking about re=
using the folio lock, or having an intermediate value in xarray, so raced s=
wapins can wait properly. There are some tricky parts syncing with swap map=
s though.

Inserting the swap cache xarray first and setting SWAP_HAS_CACHE bit
later will need more audit on the race. I assume you take the swap
device/cluster lock before folio insert into swap cache xarray?

Chris
>
> Currently working on a series, will send in a few weeks if it works.

