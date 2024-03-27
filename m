Return-Path: <linux-kernel+bounces-120248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6918988D4D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717491C23CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B40D21A02;
	Wed, 27 Mar 2024 03:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOpKS5zU"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C45D208B6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711508486; cv=none; b=mo7r1dFTM/9dv/1v5uUGIchTVlLZW4GQBe/vyI5ETLWtLRgn5seYB9xJb13vWmC0yIZwOCnJYwNbZceAT8WlC8fIPnqLUWunPtqnpOHt3U0FnPsTrzMJk24w36rzb6C4ViwN6uzjaaLy7eEbozeM9RB7WIrvd2exafEKNeeq65M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711508486; c=relaxed/simple;
	bh=yIDyP6RE3oOwNB+y7HP2djDSoDmiiSXLeIUMOFldWeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjjRGtSLB7wGRjYJ5W+SnS6JFDhGazHQU3JtkhVBsS/VwUxqaCTbm70P13lCb5d84D/hT8ffXZgJYzLM6yO4tmrdkm0fTD4gqe9eUEm9raUgJhEFuuhNhHuNUkzi85BBLQ5A+t2x7+X/coSijPXxVq04mhCdW5cOihjTI3+bMZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOpKS5zU; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d24a727f78so69561531fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711508483; x=1712113283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTwGH14b5hNtq+Bp/YEoNS/F6ZykszY1GkITKMy45JI=;
        b=ZOpKS5zUbkkCpAGkY8LZDgzuAVpi+SPWBvNfk0lSTROYN0wZU2ZH7A8J8AR99TcewF
         45Dvi1j6UoEoclQUf/UjRvRArKip1SLQ0/Y/jArwtjDiJTG8Y2FEhG9Fjml+sEJBqC8L
         PgvId8m+WlZT29FVxEQyqrppDGicB9B9n41aGm10aJDkw8GsLlDxplqGVI86kkqy3LYP
         2SOHnV4tksNkNLDaFDZR2o8zVTn09mRgI/NMHRCJQRhc1hwnDDHSMZTzq3GIyApoRXkW
         gYYgntQtHjSvaIV3swiCZmZWn+6HspqRiRcIWdPkhV8Sl0L1qemFDF4wftvoR5MXQGc6
         rAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711508483; x=1712113283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTwGH14b5hNtq+Bp/YEoNS/F6ZykszY1GkITKMy45JI=;
        b=iyyqLmjZMUwkmvXATrdboJvJGcrNPpDsJM8FrFJuupP0m+Hgrs5WFM+KYwHX/yHqgT
         n53Sbvxm38wa48KsxbCZNg/JA8VPtYiT7VU1RPPiHN1P/udeNHZ9DUqSACbFYyvA33lq
         zwWt1Vd628Mj/0iyeCFEkXxReok3/83uLjsggJW3ateUC7XTTEGfIcmIppOOP7ttOxXt
         54MPXtR9zmz0jN9SElSgr+7nilRHKpbm93jxXWQEF6PqNBxmtEDM89qhV7RIYWNE8akT
         V/3iMYPlKNTPtUEUTmyBA+EWifjssaJZ3o9X/o2OSZvaOrgfqWTAG3hxZ9w7F6Dn2FvN
         F34g==
X-Forwarded-Encrypted: i=1; AJvYcCUdawPz6SDX8oI0w884GKbqBrFCaeGRx+hhJ1u9eXhK15VlXkt4InjzZDMHEf9If9DuPKe3vHa+8zuTq/xnIQA/4TLFfJYT/fPcm3Qs
X-Gm-Message-State: AOJu0YyXpyz+lBPqgMFAfkovFJbumgr/mFXazgSbOGz37N88XTUu74rS
	iFcJT3zaAGqvQqBaGYjjLa6v34Olin5aNrbKkD/fluaF/y+Qh95VIaboTeJ7uSP6jYDHGz7lIKi
	YqZ8VIiIUDSemddW8JcOBCjJ0Ais=
X-Google-Smtp-Source: AGHT+IHRoKRGlAZVZR5ETdWGWh78P9+3JjU3kEy2ae1wV0N2/dbfCA4T5JRCvYroGbLRoJLKnuUVseUlPDYLu3jpycg=
X-Received: by 2002:a2e:3017:0:b0:2d6:a9be:19e with SMTP id
 w23-20020a2e3017000000b002d6a9be019emr2942919ljw.46.1711508482368; Tue, 26
 Mar 2024 20:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326185032.72159-1-ryncsn@gmail.com> <878r24o07p.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <878r24o07p.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 27 Mar 2024 11:01:05 +0800
Message-ID: <CAMgjq7B4Aejv16XK-zm9zPFrtVV1YutYWk5Ywzy8GwfMsTAXgA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] mm/swap: always use swap cache for synchronization
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, Minchan Kim <minchan@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Yu Zhao <yuzhao@google.com>, SeongJae Park <sj@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 10:54=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Hi, Kairui,
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > A month ago a bug was fixed for SWP_SYNCHRONOUS_IO swapin (swap cache
> > bypass swapin):
> > https://lore.kernel.org/linux-mm/20240219082040.7495-1-ryncsn@gmail.com=
/
> >
> > Because we have to spin on the swap map on race, and swap map is too sm=
all
> > to contain more usable info, an ugly schedule_timeout_uninterruptible(1=
)
> > is added. It's not the first time a hackish workaround was added for ca=
che
> > bypass swapin and not the last time. I did many experiments locally to
> > see if the swap cache bypass path can be dropped while keeping the
> > performance still comparable. And it seems doable.
> >
>
> In general, I think that it's a good idea to unify cache bypass swapin
> and normal swapin.  But I haven't dive into the implementation yet.

Thanks!

This series might be a bit too large, I can try to split it for easier
reviewing later, just if we are OK with this idea.

>
> > This series does the following things:
> > 1. Remove swap cache bypass completely.
> > 2. Apply multiple optimizations after that, these optimizations are
> >    either undoable or very difficult to do without dropping the cache
> >    bypass swapin path.
> > 3. Use swap cache as a synchronization layer, also unify some code
> >    with page cache (filemap).
> >
> > As a result, we have:
> > 1. A comparable performance, some tests are even faster.
> > 2. Multi-index support for swap cache.
> > 3. Removed many hackish workarounds including above long tailing
> >    issue is gone.
> >
> > Sending this as RFC to collect some discussion, suggestion, or rejectio=
n
> > early, this seems need to be split into multiple series, but the
> > performance is not good until the last patch so I think start by
> > seperating them may make this approach not very convincing. And there
> > are still some (maybe further) TODO items and optimization space
> > if we are OK with this approach.
> >
> > This is based on my another series, for reusing filemap code for swapca=
che:
> > [PATCH v2 0/4] mm/filemap: optimize folio adding and splitting
> > https://lore.kernel.org/linux-mm/20240325171405.99971-1-ryncsn@gmail.co=
m/
> >
> > Patch 1/10, introduce a helper from filemap side to be used later.
> > Patch 2/10, 3/10 are clean up and prepare for removing the swap cache
> >   bypass swapin path.
> > Patch 4/10, removed the swap cache bypass swapin path, and the
> >   performance drop heavily (-28%).
> > Patch 5/10, apply the first optimization after the removal, since all
> >   folios goes through swap cache now, there is no need to explicit shad=
ow
> >   clearing any more.
> > Patch 6/10, apply another optimization after clean up shadow clearing
> >   routines. Now swapcache is very alike page cache, so just reuse page
> >   cache code and we will have multi-index support. Shadow memory usage
> >   dropped a lot.
> > Patch 7/10, just rename __read_swap_cache_async, it will be refactored
> >   and a key part of this series, and the naming is very confusing to me=
.
> > Patch 8/10, make swap cache as a synchronization layer, introduce two
> >   helpers for adding folios to swap cache, caller will either succeed o=
r
> >   get a folio to wait on.
> > Patch 9/10, apply another optimization. With above two helpers, looking
> >   up of swapcache can be optimized and avoid false looking up, which
> >   helped improve the performance.
> > Patch 10/10, apply a major optimization for SWP_SYNCHRONOUS_IO devices,
> >   after this commit, performance for simple swapin/swapout is basically
> >   same as before.
> >
> > Test 1, sequential swapin/out of 30G zero page on ZRAM:
> >
> >                Before (us)        After (us)
> > Swapout:       33619409           33886008
> > Swapin:        32393771           32465441 (- 0.2%)
> > Swapout (THP): 7817909            6899938  (+11.8%)
> > Swapin (THP) : 32452387           33193479 (- 2.2%)
>
> If my understanding were correct, we don't have swapin (THP) support,
> yet.  Right?

Yes, this series doesn't change how swapin/swapout works with THP in
general, but now THP swapout will leave shadows with large order, so
it needs to be splitted upon swapin, that will slow down later swapin
by a little bit but I think that's worth it.

If we can do THP swapin in the future, this split on swapin can be
saved to make the performance even better.

>
> > And after swapping out 30G with THP, the radix node usage dropped by a
> > lot:
> >
> > Before: radix_tree_node 73728K
> > After:  radix_tree_node  7056K (-94%)
>
> Good!
>
> > Test 2:
> > Mysql (16g buffer pool, 32G ZRAM SWAP, 4G memcg, Zswap disabled, THP ne=
ver)
> >   sysbench /usr/share/sysbench/oltp_read_only.lua --mysql-user=3Droot \
> >   --mysql-password=3D1234 --mysql-db=3Dsb --tables=3D36 --table-size=3D=
2000000 \
> >   --threads=3D48 --time=3D300 --report-interval=3D10 run
> >
> > Before: transactions: 4849.25 per sec
> > After:  transactions: 4849.40 per sec
> >
> > Test 3:
> > Mysql (16g buffer pool, NVME SWAP, 4G memcg, Zswap enabled, THP never)
> >   echo never > /sys/kernel/mm/transparent_hugepage/enabled
> >   echo 100 > /sys/module/zswap/parameters/max_pool_percent
> >   echo 1 > /sys/module/zswap/parameters/enabled
> >   echo y > /sys/module/zswap/parameters/shrinker_enabled
> >
> >   sysbench /usr/share/sysbench/oltp_read_only.lua --mysql-user=3Droot \
> >   --mysql-password=3D1234 --mysql-db=3Dsb --tables=3D36 --table-size=3D=
2000000 \
> >   --threads=3D48 --time=3D600 --report-interval=3D10 run
> >
> > Before: transactions: 1662.90 per sec
> > After:  transactions: 1726.52 per sec
>
> 3.8% improvement.  Good!
>
> > Test 4:
> > Mysql (16g buffer pool, NVME SWAP, 4G memcg, Zswap enabled, THP always)
> >   echo always > /sys/kernel/mm/transparent_hugepage/enabled
> >   echo 100 > /sys/module/zswap/parameters/max_pool_percent
> >   echo 1 > /sys/module/zswap/parameters/enabled
> >   echo y > /sys/module/zswap/parameters/shrinker_enabled
> >
> >   sysbench /usr/share/sysbench/oltp_read_only.lua --mysql-user=3Droot \
> >   --mysql-password=3D1234 --mysql-db=3Dsb --tables=3D36 --table-size=3D=
2000000 \
> >   --threads=3D48 --time=3D600 --report-interval=3D10 run
> >
> > Before: transactions: 2860.90 per sec.
> > After:  transactions: 2802.55 per sec.
> >
> > Test 5:
> > Memtier / memcached (16G brd SWAP, 8G memcg, THP never):
> >
> >   memcached -u nobody -m 16384 -s /tmp/memcached.socket -a 0766 -t 16 -=
B binary &
> >
> >   memtier_benchmark -S /tmp/memcached.socket \
> >     -P memcache_binary -n allkeys --key-minimum=3D1 \
> >     --key-maximum=3D24000000 --key-pattern=3DP:P -c 1 -t 16 \
> >     --ratio 1:0 --pipeline 8 -d 1000
> >
> > Before: 106730.31 Ops/sec
> > After:  106360.11 Ops/sec
> >
> > Test 5:
> > Memtier / memcached (16G brd SWAP, 8G memcg, THP always):
> >
> >   memcached -u nobody -m 16384 -s /tmp/memcached.socket -a 0766 -t 16 -=
B binary &
> >
> >   memtier_benchmark -S /tmp/memcached.socket \
> >     -P memcache_binary -n allkeys --key-minimum=3D1 \
> >     --key-maximum=3D24000000 --key-pattern=3DP:P -c 1 -t 16 \
> >     --ratio 1:0 --pipeline 8 -d 1000
> >
> > Before: 83193.11 Ops/sec
> > After:  82504.89 Ops/sec
> >
> > These tests are tested under heavy memory stress, and the performance
> > seems basically same as before,very slightly better/worse for certain
> > cases, the benefits of multi-index are basically erased by
> > fragmentation and workingset nodes usage is slightly lower.
> >
> > Some (maybe further) TODO items if we are OK with this approach:
> >
> > - I see a slight performance regression for THP tests,
> >   could identify a clear hotspot with perf, my guess is the
> >   content on the xa_lock is an issue (we have a xa_lock for
> >   every 64M swap cache space), THP handling needs to take the lock
> >   longer than usual. splitting the xa_lock to be more
> >   fine-grained seems a good solution. We have
> >   SWAP_ADDRESS_SPACE_SHIFT =3D 14 which is not an optimal value.
> >   Considering XA_CHUNK_SHIFT is 6, we will have three layer of Xarray
> >   just for 2 extra bits. 12 should be better to always make use of
> >   the whole XA chunk and having two layers at most. But duplicated
> >   address_space struct also wastes more memory and cacheline.
> >   I see an observable performance drop (~3%) after change
> >   SWAP_ADDRESS_SPACE_SHIFT to 12. Might be a good idea to
> >   decouple swap cache xarray from address_space (there are
> >   too many user for swapcache, shouldn't come too dirty).
> >
> > - Actually after patch Patch 4/10, the performance is much better for
> >   tests limited with memory cgroup, until 10/10 applied the direct swap
> >   cache freeing logic for SWP_SYNCHRONOUS_IO swapin. Because if the swa=
p
> >   device is not near full, swapin doesn't clear up the swapcache, so
> >   repeated swapout doesn't need to re-alloc a swap entry, make things
> >   faster. This may indicate that lazy freeing of swap cache could benif=
it
> >   certain workloads and may worth looking into later.
> >
> > - Now SWP_SYNCHRONOUS_IO swapin will bypass readahead and force drop
> >   swap cache after swapin is done, which can be cleaned up and optimize=
d
> >   further after this patch. Device type will only determine the
> >   readahead logic, and swap cache drop check can be based purely on swa=
p
> >   count.
> >
> > - Recent mTHP swapin/swapout series should have no fundamental
> >   conflict with this.
> >
> > Kairui Song (10):
> >   mm/filemap: split filemap storing logic into a standalone helper
> >   mm/swap: move no readahead swapin code to a stand-alone helper
> >   mm/swap: convert swapin_readahead to return a folio
> >   mm/swap: remove cache bypass swapin
> >   mm/swap: clean shadow only in unmap path
> >   mm/swap: switch to use multi index entries
> >   mm/swap: rename __read_swap_cache_async to swap_cache_alloc_or_get
> >   mm/swap: use swap cache as a synchronization layer
> >   mm/swap: delay the swap cache look up for swapin
> >   mm/swap: optimize synchronous swapin
> >
> >  include/linux/swapops.h |   5 +-
> >  mm/filemap.c            | 161 +++++++++-----
> >  mm/huge_memory.c        |  78 +++----
> >  mm/internal.h           |   2 +
> >  mm/memory.c             | 133 ++++-------
> >  mm/shmem.c              |  44 ++--
> >  mm/swap.h               |  71 ++++--
> >  mm/swap_state.c         | 478 +++++++++++++++++++++-------------------
> >  mm/swapfile.c           |  64 +++---
> >  mm/vmscan.c             |   8 +-
> >  mm/workingset.c         |   2 +-
> >  mm/zswap.c              |   4 +-
> >  12 files changed, 540 insertions(+), 510 deletions(-)
>
> --
> Best Regards,
> Huang, Ying

