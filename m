Return-Path: <linux-kernel+bounces-73363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC3385C17A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59188B24AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD37076416;
	Tue, 20 Feb 2024 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmnP2qmD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077AC657C5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446751; cv=none; b=M3THblnygskUJT3MbtEZr2VHlyHKBflYF2MT2oSnfcB0WbVFKD50P8JclAT/pNvm2nf/b35AodXKav1YECcdx76kowmH71Gj4X6pTCFWCBg6VH8d+poLyntx6DlX/EvMq+Ibp8UQiPhf8nNWiJc3WvWCG84BTzh/ciyGQ5oyIqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446751; c=relaxed/simple;
	bh=N355tVdPSOKMObJsCfJAPqCnsKJxMxvzjEgXaDCSUXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfbCNS6puPW6Tqtpa9fvh2fvB2bb5rfoa8uS23cC6+U4hPiNgrJsepOyTT2lnG2bagO5h5b9SqD5BiKU3pNSFR6JnXwc7Vwr1j1npyBDv5RCV3jwrlEL4aUhB4B/+BQgfHroo0Z6uoTwlPJHwBMsUNc2ceIC4hSqFnYQ1UfNn4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmnP2qmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1A7C43394
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708446750;
	bh=N355tVdPSOKMObJsCfJAPqCnsKJxMxvzjEgXaDCSUXw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CmnP2qmD/M9yEkgydZZU3v+WxaSDjI+CJo+RQ5FVKERrUziDft1RI0x52ykfTUBOn
	 WSKpPyDCsVtJ4RiDG9sYGTUb8v6FNZmHEyn1rJX0pdBb4CD2jw6FfgrlutN5qA+lVu
	 qXInCRbgKUGGj+d3hCrgIfBUEuSg3v2lDHaUoOeMhy5/LmjUWLzAbe4SOFl2WLJh4u
	 oiUTKmm4IXeGIJYzlz1SoOuPdibZTVLSCXlk8rMgfBAl/EwjmrNRoe/JLlozAUA+hK
	 l7y/yX86cPsCdoqgJLiGkFnLhk7Dczd/HAz7uBQ8/UMdTcgt6d1ok905KlP+M7TE0z
	 Z51worHqqkYdg==
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3650c7e0dd2so9849005ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:32:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXOXZlPnrJWwHNpOE6G2oCLoIgugtklmtVO4HFuKcqj8DmUxg7z5bsV6z8KHT1jlT2RcK7kyFRVYTW5tC2iESJB/78zgCWxMPzqfKxg
X-Gm-Message-State: AOJu0YzkpMGMyXmGB49OO7LpKckY1koaroSY7RYeN41+31sVB3G7rBtJ
	ZLg7euo4SXBhI39Dzwlmj71KVQSmyrCyAV26SzFg3URqK72/8M1gI9PPDn4Cw/0H1KnoP8WOh/E
	MI3gftAWLsgwoR3+wsszArFaEcpqAl9WA8eFn
X-Google-Smtp-Source: AGHT+IHoX5iSsVEGfeRD4cVDodXDxIVSA1k9wV22OCHIw4jn0j9xiCArJfC2r0sinIV6wprQrsUc1IoQGOjKhC7E+Mc=
X-Received: by 2002:a05:6e02:154c:b0:364:216e:d1dc with SMTP id
 j12-20020a056e02154c00b00364216ed1dcmr17350823ilu.22.1708446745860; Tue, 20
 Feb 2024 08:32:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219082040.7495-1-ryncsn@gmail.com> <20240219173147.3f4b50b7c9ae554008f50b66@linux-foundation.org>
 <CAMgjq7DgBOJhDJStwGuD+C6-FNYZBp-cu6M_HAgRry3gBSf7GA@mail.gmail.com>
 <CAGsJ_4zyf5OOq_WA7VjsDKp1ciaDwzM23Ef95_O-24oLtr_5AQ@mail.gmail.com> <CAMgjq7AnZJSseC2BB_nF+s533YybyP_WU8HijEKFA=OXE1x41Q@mail.gmail.com>
In-Reply-To: <CAMgjq7AnZJSseC2BB_nF+s533YybyP_WU8HijEKFA=OXE1x41Q@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 20 Feb 2024 08:32:13 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMbocSa06MSeg5HOofWisc0BxVnCFBLdKErmV8_7pKhUA@mail.gmail.com>
Message-ID: <CAF8kJuMbocSa06MSeg5HOofWisc0BxVnCFBLdKErmV8_7pKhUA@mail.gmail.com>
Subject: Re: [PATCH v4] mm/swap: fix race when skipping swapcache
To: Kairui Song <ryncsn@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	"Huang, Ying" <ying.huang@intel.com>, Minchan Kim <minchan@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Yu Zhao <yuzhao@google.com>, SeongJae Park <sj@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Aaron Lu <aaron.lu@intel.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 8:56=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:

>
> Hi Barry,
>
> > it might not be a problem for throughput. but for real-time and tail la=
tency,
> > this hurts. For example, this might increase dropping frames of UI whic=
h
> > is an important parameter to evaluate performance :-)
> >
>
> That's a true issue, as Chris mentioned before I think we need to
> think of some clever data struct to solve this more naturally in the
> future, similar issue exists for cached swapin as well and it has been
> there for a while. On the other hand I think maybe applications that
> are extremely latency sensitive should try to avoid swap on fault? A
> swapin could cause other issues like reclaim, throttled or contention
> with many other things, these seem to have a higher chance than this
> race.


Yes, I do think the best long term solution is to have some clever
data structure to solve the synchronization issue and allow racing
threads to make forward progress at the same time.

I have also explored some (failed) synchronization ideas, for example
having the run time swap entry refcount separate from swap_map count.
BTW, zswap entry->refcount behaves like that, it is separate from swap
entry and manages the temporary run time usage count held by the
function. However that idea has its own problem as well, it needs to
have an xarray to track the swap entry run time refcount (only stored
in the xarray when CPU fails to get SWAP_HAS_CACHE bit.) When we are
done with page faults, we still need to look up the xarray to make
sure there is no racing CPU and put the refcount into the xarray. That
 kind of defeats the purpose of avoiding the swap cache in the first
place. We still need to do the xarray lookup in the normal path.

I came to realize that, while this current fix is not perfect, (I
still wish we had a better solution not pausing the racing CPU). This
patch stands better than not fixing this data corruption issue and the
patch remains relatively simple. Yes it has latency issues but still
better than data corruption.  It also doesn't stop us from coming up
with better solutions later on. If we want to address the
synchronization in a way not blocking other CPUs, it will likely
require a much bigger change.

Unless we have a better suggestion. It seems the better one among the
alternatives so far.

Chris

>
> > BTW, I wonder if ying's previous proposal - moving swapcache_prepare()
> > after swap_read_folio() will further help decrease the number?
>
> We can move the swapcache_prepare after folio alloc or cgroup charge,
> but I didn't see an observable change from statistics, for some
> workload the reading is even worse. I think that's mostly due to
> noise, or higher swap out rate since all raced threads will alloc an
> extra folio now. Applications that have many pages swapped out due to
> memory limit are already on the edge of triggering another reclaim, so
> a dozen more folio alloc could just trigger that...
>
> And we can't move it after swap_read_folio()... That's exactly what we
> want to protect.
>

