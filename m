Return-Path: <linux-kernel+bounces-38075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A4F83BAB1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3046C2849E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B8D125CD;
	Thu, 25 Jan 2024 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oG/jX4nk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6AB125B2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706167984; cv=none; b=oVr4umJtSGZTwoaYu9HZPGqdWvSxU9Q8ECXw9q1W6JfaTrlJd41kWXHuInfgz/+b5vdo+u3MArSVF76ncYPtL/MRiMLYsaiBsky14QjC/eTafexNEn8ShslW8GTi3HwZMTnt1YFoTKQ3hYrcmv7H9slAAt2R+vXWQQIFk4+86og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706167984; c=relaxed/simple;
	bh=iAVaXWaN/UpCJVGCevTR5+IwiEwek+tqMMH2DtmBvEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZYPLhHk21uxrhAnaVmLSSjdZkridAIw8fwuvT2ylHHzdlmUKlC1X3FQC29N0iuqbIkTXM5T4JGJ3wCrXP5OFkDqOOiq4Oeos0EN2L7T4L1xlwHOvLPZ15JSSJRCK+eIObZqj4nlE/C+X1HDEkaKMMyAqU7hjggaDuo+xpK4MkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oG/jX4nk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DE4C433B1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706167983;
	bh=iAVaXWaN/UpCJVGCevTR5+IwiEwek+tqMMH2DtmBvEw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oG/jX4nkNezW8Yci6UChQG3xyqgtgDhi2cVoIkLWRYCqrod+jdmhCUU/kVCHu+Vwu
	 voUYs3oi5RxIN4F8ahk3az+e++NT7yjGFq9+FfY/1QkfY3AkLk4GydnffV9yR149jf
	 K1QwWeRWUne89NRwZODofgna1ucwjSOnRSs8WKqc6k0pVpwsVysV41SEtaWrkUxcpd
	 2zZPvonH9TnOnJ1JTfVs6Z4JYQFJwXrNS9+VXx9P3LGxYVrEgIRQp18L/E15SCqe6n
	 plzBXOo1NV8DSLzGBhW5Z07TaYGMkpC0PeU5wpxO7HVgal5Fme5lN7lzB4+w5Xp/he
	 2+JnMgccbSmMw==
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6da6b0eb2d4so3854921b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 23:33:03 -0800 (PST)
X-Gm-Message-State: AOJu0YwjBs09UeN/SnyILSDmDXUIObRiyjk9xAFB7FJOTn7zB555mUb2
	sccJbbUasOtYq6wSuv2QnHBLdQbM8xmxmMFPlpKbi3p7ZV7P/Xl99Y4z/XuWDaUzeDtALxgkxV6
	XrKg/lK5ZZWTKsLM2IqQZa8vjp7QyqtWWBgi1
X-Google-Smtp-Source: AGHT+IFxkwbKGTVnVLnALUZ9cDGjrwgIm+Hoe31GxOvAtymn3w+qKawEqvqzTvcBqdfevAgw1h9QCf492cImBmcqG/0=
X-Received: by 2002:a05:6a00:cb:b0:6dd:ce8b:ecbb with SMTP id
 e11-20020a056a0000cb00b006ddce8becbbmr267276pfj.42.1706167983058; Wed, 24 Jan
 2024 23:33:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123184552.59758-1-ryncsn@gmail.com> <20240123184552.59758-2-ryncsn@gmail.com>
In-Reply-To: <20240123184552.59758-2-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 24 Jan 2024 23:32:51 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNZP-uvsSshVrEY0bPsYLB+5Oi-bQKsEQ3RV6yOW+RgNA@mail.gmail.com>
Message-ID: <CAF8kJuNZP-uvsSshVrEY0bPsYLB+5Oi-bQKsEQ3RV6yOW+RgNA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm, lru_gen: try to prefetch next page when
 scanning LRU
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Yu Zhao <yuzhao@google.com>, Wei Xu <weixugc@google.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 10:46=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> Prefetch for inactive/active LRU have been long exiting, apply the same
> optimization for MGLRU.
>
> Test 1: Ramdisk fio ro test in a 4G memcg on a EPYC 7K62:
>   fio -name=3Dmglru --numjobs=3D16 --directory=3D/mnt --size=3D960m \
>     --buffered=3D1 --ioengine=3Dio_uring --iodepth=3D128 \
>     --iodepth_batch_submit=3D32 --iodepth_batch_complete=3D32 \
>     --rw=3Drandread --random_distribution=3Dzipf:0.5 --norandommap \
>     --time_based --ramp_time=3D1m --runtime=3D6m --group_reporting
>
> Before this patch:
> bw (  MiB/s): min=3D 7758, max=3D 9239, per=3D100.00%, avg=3D8747.59, std=
ev=3D16.51, samples=3D11488
> iops        : min=3D1986251, max=3D2365323, avg=3D2239380.87, stdev=3D422=
5.93, samples=3D11488
>
> After this patch (+7.2%):
> bw (  MiB/s): min=3D 8360, max=3D 9771, per=3D100.00%, avg=3D9381.31, std=
ev=3D15.67, samples=3D11488
> iops        : min=3D2140296, max=3D2501385, avg=3D2401613.91, stdev=3D401=
0.41, samples=3D11488
>
> Test 2: Ramdisk fio hybrid test for 30m in a 4G memcg on a EPYC 7K62 (3 t=
imes):
>   fio --buffered=3D1 --numjobs=3D8 --size=3D960m --directory=3D/mnt \
>     --time_based --ramp_time=3D1m --runtime=3D30m \
>     --ioengine=3Dio_uring --iodepth=3D128 --iodepth_batch_submit=3D32 \
>     --iodepth_batch_complete=3D32 --norandommap \
>     --name=3Dmglru-ro --rw=3Drandread --random_distribution=3Dzipf:0.7 \
>     --name=3Dmglru-rw --rw=3Drandrw --random_distribution=3Dzipf:0.7
>
> Before this patch:
>  READ: 6622.0 MiB/s. Stdev: 22.090722
> WRITE: 1256.3 MiB/s. Stdev: 5.249339
>
> After this patch (+4.6%, +3.3%):
>  READ: 6926.6 MiB/s, Stdev: 37.950260
> WRITE: 1297.3 MiB/s, Stdev: 7.408704
>
> Test 3: 30m of MySQL test in 6G memcg (12 times):
>   echo 'set GLOBAL innodb_buffer_pool_size=3D16106127360;' | \
>     mysql -u USER -h localhost --password=3DPASS
>
>   sysbench /usr/share/sysbench/oltp_read_only.lua \
>     --mysql-user=3DUSER --mysql-password=3DPASS --mysql-db=3DDB \
>     --tables=3D48 --table-size=3D2000000 --threads=3D16 --time=3D1800 run
>
> Before this patch
> Avg: 134743.714545 qps. Stdev: 582.242189
>
> After this patch (+0.2%):
> Avg: 135005.779091 qps. Stdev: 295.299027
>
> Test 4: Build linux kernel in 2G memcg with make -j48 with SSD swap
>         (for memory stress, 18 times):
>
> Before this patch:
> Avg: 1456.768899 s. Stdev: 20.106973
>
> After this patch (+0.0%):
> Avg: 1455.659254 s. Stdev: 15.274481
>
> Test 5: Memtier test in a 4G cgroup using brd as swap (18 times):
>   memcached -u nobody -m 16384 -s /tmp/memcached.socket \
>     -a 0766 -t 16 -B binary &
>   memtier_benchmark -S /tmp/memcached.socket \
>     -P memcache_binary -n allkeys \
>     --key-minimum=3D1 --key-maximum=3D16000000 -d 1024 \
>     --ratio=3D1:0 --key-pattern=3DP:P -c 1 -t 16 --pipeline 8 -x 3
>
> Before this patch:
> Avg: 50317.984000 Ops/sec. Stdev: 2568.965458
>
> After this patch (-5.7%):
> Avg: 47691.343500 Ops/sec. Stdev: 3925.772473
>
> It seems prefetch is helpful in most cases, but the memtier test is
> either hitting a case where prefetch causes higher cache miss or it's
> just too noisy (high stdev).
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/vmscan.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4f9c854ce6cc..03631cedb3ab 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3681,15 +3681,26 @@ static bool inc_min_seq(struct lruvec *lruvec, in=
t type, bool can_swap)
>         /* prevent cold/hot inversion if force_scan is true */
>         for (zone =3D 0; zone < MAX_NR_ZONES; zone++) {
>                 struct list_head *head =3D &lrugen->folios[old_gen][type]=
[zone];
> +               struct folio *prev =3D NULL;
>
> -               while (!list_empty(head)) {
> -                       struct folio *folio =3D lru_to_folio(head);
> +               if (!list_empty(head))
> +                       prev =3D lru_to_folio(head);
> +
> +               while (prev) {
> +                       struct folio *folio =3D prev;
>
>                         VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(foli=
o), folio);
>                         VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), f=
olio);
>                         VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) !=
=3D type, folio);
>                         VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) !=3D z=
one, folio);
>
> +                       if (unlikely(list_is_first(&folio->lru, head))) {
> +                               prev =3D NULL;
> +                       } else {
> +                               prev =3D lru_to_folio(&folio->lru);
> +                               prefetchw(&prev->flags);
> +                       }

This makes the code flow much harder to follow. Also for architecture
that does not support prefetch, this will be a net loss.

Can you use refetchw_prev_lru_folio() instead? It will make the code
much easier to follow. It also turns into no-op when prefetch is not
supported.

Chris

> +
>                         new_gen =3D folio_inc_gen(lruvec, folio, false);
>                         list_move_tail(&folio->lru, &lrugen->folios[new_g=
en][type][zone]);
>
> @@ -4341,11 +4352,15 @@ static int scan_folios(struct lruvec *lruvec, str=
uct scan_control *sc,
>         for (i =3D MAX_NR_ZONES; i > 0; i--) {
>                 LIST_HEAD(moved);
>                 int skipped_zone =3D 0;
> +               struct folio *prev =3D NULL;
>                 int zone =3D (sc->reclaim_idx + i) % MAX_NR_ZONES;
>                 struct list_head *head =3D &lrugen->folios[gen][type][zon=
e];
>
> -               while (!list_empty(head)) {
> -                       struct folio *folio =3D lru_to_folio(head);
> +               if (!list_empty(head))
> +                       prev =3D lru_to_folio(head);
> +
> +               while (prev) {
> +                       struct folio *folio =3D prev;
>                         int delta =3D folio_nr_pages(folio);
>
>                         VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(foli=
o), folio);
> @@ -4355,6 +4370,13 @@ static int scan_folios(struct lruvec *lruvec, stru=
ct scan_control *sc,
>
>                         scanned +=3D delta;
>
> +                       if (unlikely(list_is_first(&folio->lru, head))) {
> +                               prev =3D NULL;
> +                       } else {
> +                               prev =3D lru_to_folio(&folio->lru);
> +                               prefetchw(&prev->flags);
> +                       }
> +
>                         if (sort_folio(lruvec, folio, sc, tier))
>                                 sorted +=3D delta;
>                         else if (isolate_folio(lruvec, folio, sc)) {
> --
> 2.43.0
>
>

