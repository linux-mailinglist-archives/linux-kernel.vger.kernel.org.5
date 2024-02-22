Return-Path: <linux-kernel+bounces-75881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7A985F03E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBEB52845E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD10C17597;
	Thu, 22 Feb 2024 03:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xNMQagNW"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE48101EC
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708574122; cv=none; b=T202H8oQ4/YthSenAyZegIf8Y5gnCmvXwdrV/b2XW2zZqw5cjq97HiutNhFt2DjL6HUkapK9RkD2z9oyKTJgrG1am2yefgDvdiriGNMdt0qzeGSPdBMAi8AfSaTccD5Y715HEdTeA1N/jmIhNcV4SWZB3PQSgLg55k3zOrRatbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708574122; c=relaxed/simple;
	bh=jDOLWPHSvbqh81vabMmbh1edqbrBy/gl1j2n8fl7AD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GmQFUueHLzzpltoysb8qn7C69vYta3wwFH/9MlZdfDgscSxQklcummJCHmLC0LuZtyTM/wKQFaugb9Oimd3SJnTea6XPQkJirvxGuHzLovM7QhEIvYE2ZPEPKbXz7iT9zw7fQIUEvT7L++gEgD/f4IDWMmN/zZxGLFWJuY3Hc0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xNMQagNW; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ba2ec393-f484-4c69-aa45-7e9433a71d5d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708574117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nv6VYGEQ0sJ5MaAPxTPkbrTyxfIJu5b09N+vZJ3e8NM=;
	b=xNMQagNWKbz5rPZH5Dx9BbA/BtkPxUuvrX5Jc19lx3AakFMci1ylR/84U7UKqwH/0qXGz7
	UizCwc/BZU6BA31XMxvPRNiJN0thrAHKN7PeEgObr6Da2BOrAE4++Uf0ciTIkBY+MDmtlH
	2BBUqBKYxsELKs8xr0hRkdJN3rGivZM=
Date: Thu, 22 Feb 2024 11:54:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC] Analyzing zpool allocators / Removing zbud and z3fold
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin
 <linmiaohe@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Nhat Pham <nphamcs@gmail.com>, Linux-MM <linux-mm@kvack.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Minchan Kim <minchan@kernel.org>, Chris Down <chris@chrisdown.name>,
 Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>,
 Chris Li <chrisl@kernel.org>
References: <CAJD7tkbRF6od-2x_L8-A1QL3=2Ww13sCj4S3i4bNndqF+3+_Vg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAJD7tkbRF6od-2x_L8-A1QL3=2Ww13sCj4S3i4bNndqF+3+_Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/9 11:27, Yosry Ahmed wrote:
> Hey folks,
> 
> This is a follow up on my previously sent RFC patch to deprecate
> z3fold [1]. This is an RFC without code, I thought I could get some
> discussion going before writing (or rather deleting) more code. I went
> back to do some analysis on the 3 zpool allocators: zbud, zsmalloc,
> and z3fold.

This is a great analysis! Sorry for being late to see it.

I want to vote for this direction, zram has been using zsmalloc directly,
zswap can also do this, which is simpler and we can just maintain and optimize
only one allocator. The only evident downside is dependence on MMU, right?

And I'm trying to optimize the scalability performance for zsmalloc now,
which is bad so zswap has to use 32 pools to workaround it. (zram only use
one pool, should also have the scalability problem on big server, maybe
have to use many zram block devices to workaround it too.)

But too many pools would cause more memory waste and more fragmentation,
so the resulted compression ratio is not good enough.

As for the MMU dependence, we can actually avoid it? Maybe I missed something,
we can get object's memory vecs from zsmalloc, then send it to decompress,
which should support length(memory vecs) > 1?

> 
> [1]https://lore.kernel.org/linux-mm/20240112193103.3798287-1-yosryahmed@google.com/
> 
> In this analysis, for each of the allocators I ran a kernel build test
> on tmpfs in a limit cgroup 5 times and captured:
> (a) The build times.
> (b) zswap_load() and zswap_store() latencies using bpftrace.
> (c) The maximum size of the zswap pool from /proc/meminfo::Zswapped.

Here should use /proc/meminfo::Zswap, right?
Zswap is the sum of pool pages size, Zswapped is the swapped/compressed pages.

Thanks!

> 
> Here are the results I have. I am using zsmalloc as the base for all
> comparisons.
> 
> -------------------------------- <Results> --------------------------------
> 
> (a) Build times
> 
> *** zsmalloc ***
> ──────────────────────────────────────────────────────────────
>  LABEL   │ MIN      │ MAX      │ MEAN     │ MEDIAN   │ STDDEV
> ────────────────────┼──────────┼──────────┼──────────┼────────
>  real    │ 108.890  │ 116.160  │ 111.304  │ 110.310  │ 2.719
>  sys     │ 6838.860 │ 7137.830 │ 6936.414 │ 6862.160 │ 114.860
>  user    │ 2838.270 │ 2859.050 │ 2850.116 │ 2852.590 │ 7.388
> ──────────────────────────────────────────────────────────────
> 
> *** zbud ***
> ──────────────────────────────────────────────────────────────
>  LABEL   │ MIN      │ MAX      │ MEAN     │ MEDIAN   │ STDDEV
> ────────────────────┼──────────┼──────────┼──────────┼────────
>  real    │ 105.540  │ 114.430  │ 108.738  │ 108.140  │ 3.027
>  sys     │ 6553.680 │ 6794.330 │ 6688.184 │ 6661.840 │ 86.471
>  user    │ 2836.390 │ 2847.850 │ 2842.952 │ 2843.450 │ 3.721
> ──────────────────────────────────────────────────────────────
> 
> *** z3fold ***
> ──────────────────────────────────────────────────────────────
>  LABEL   │ MIN      │ MAX      │ MEAN     │ MEDIAN   │ STDDEV
> ────────────────────┼──────────┼──────────┼──────────┼────────
>  real    │ 113.020  │ 118.110  │ 114.642  │ 114.010  │ 1.803
>  sys     │ 7168.860 │ 7284.900 │ 7243.930 │ 7265.290 │ 42.254
>  user    │ 2865.630 │ 2869.840 │ 2868.208 │ 2868.710 │ 1.625
> ──────────────────────────────────────────────────────────────
> 
> Comparing the means, zbud is 2.3% faster, and z3fold is 3% slower.
> 
> (b) zswap_load() and zswap_store() latencies
> 
> *** zsmalloc ***
> 
> @load_ns:
> [128, 256)           377 |                                                    |
> [256, 512)           772 |                                                    |
> [512, 1K)            923 |                                                    |
> [1K, 2K)           22141 |                                                    |
> [2K, 4K)           88297 |                                                    |
> [4K, 8K)         1685833 |@@@@@                                               |
> [8K, 16K)       17087712 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [16K, 32K)      10875077 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                   |
> [32K, 64K)        777656 |@@                                                  |
> [64K, 128K)       127239 |                                                    |
> [128K, 256K)       50301 |                                                    |
> [256K, 512K)        1669 |                                                    |
> [512K, 1M)            37 |                                                    |
> [1M, 2M)               3 |                                                    |
> 
> @store_ns:
> [512, 1K)            279 |                                                    |
> [1K, 2K)           15969 |                                                    |
> [2K, 4K)          193446 |                                                    |
> [4K, 8K)          823283 |                                                    |
> [8K, 16K)       14209844 |@@@@@@@@@@@                                         |
> [16K, 32K)      62040863 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [32K, 64K)       9737713 |@@@@@@@@                                            |
> [64K, 128K)      1278302 |@                                                   |
> [128K, 256K)      487285 |                                                    |
> [256K, 512K)        4406 |                                                    |
> [512K, 1M)           117 |                                                    |
> [1M, 2M)              24 |                                                    |
> 
> *** zbud ***
> 
> @load_ns:
> [128, 256)           452 |                                                    |
> [256, 512)           834 |                                                    |
> [512, 1K)            998 |                                                    |
> [1K, 2K)           22708 |                                                    |
> [2K, 4K)          171247 |                                                    |
> [4K, 8K)         2853227 |@@@@@@@@                                            |
> [8K, 16K)       17727445 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [16K, 32K)       9523050 |@@@@@@@@@@@@@@@@@@@@@@@@@@@                         |
> [32K, 64K)        752423 |@@                                                  |
> [64K, 128K)       135560 |                                                    |
> [128K, 256K)       52360 |                                                    |
> [256K, 512K)        4071 |                                                    |
> [512K, 1M)            57 |                                                    |
> 
> @store_ns:
> [512, 1K)            518 |                                                    |
> [1K, 2K)           13337 |                                                    |
> [2K, 4K)          193043 |                                                    |
> [4K, 8K)          846118 |                                                    |
> [8K, 16K)       15240682 |@@@@@@@@@@@@@                                       |
> [16K, 32K)      60945786 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [32K, 64K)      10230719 |@@@@@@@@                                            |
> [64K, 128K)      1612647 |@                                                   |
> [128K, 256K)      498344 |                                                    |
> [256K, 512K)        8550 |                                                    |
> [512K, 1M)           199 |                                                    |
> [1M, 2M)               1 |                                                    |
> 
> *** z3fold ***
> 
> @load_ns:
> [128, 256)           344 |                                                    |
> [256, 512)           999 |                                                    |
> [512, 1K)            859 |                                                    |
> [1K, 2K)           21069 |                                                    |
> [2K, 4K)           53704 |                                                    |
> [4K, 8K)         1351571 |@@@@                                                |
> [8K, 16K)       14142680 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [16K, 32K)      11788684 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         |
> [32K, 64K)       1133377 |@@@@                                                |
> [64K, 128K)       121670 |                                                    |
> [128K, 256K)       68663 |                                                    |
> [256K, 512K)         120 |                                                    |
> [512K, 1M)            21 |                                                    |
> 
> [512, 1K)            257 |                                                    |
> [1K, 2K)           10162 |                                                    |
> [2K, 4K)          149599 |                                                    |
> [4K, 8K)          648121 |                                                    |
> [8K, 16K)        9115497 |@@@@@@@@                                            |
> [16K, 32K)      56467456 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [32K, 64K)      16235236 |@@@@@@@@@@@@@@                                      |
> [64K, 128K)      1397437 |@                                                   |
> [128K, 256K)      705916 |                                                    |
> [256K, 512K)        3087 |                                                    |
> [512K, 1M)            62 |                                                    |
> [1M, 2M)               1 |                                                    |
> 
> I did not perform any sophisticated analysis on these histograms, but
> eyeballing them makes it clear that all allocators have somewhat
> similar latencies. zbud is slightly better than zsmalloc, and z3fold
> is slightly worse than zsmalloc. This corresponds naturally to the
> build times in (a).
> 
> (c) Maximum size of the zswap pool
> 
> *** zsmalloc ***
> 1,137,659,904 bytes = ~1.13G
> 
> *** zbud ***
> 1,535,741,952 bytes = ~1.5G
> 
> *** z3fold ***
> 1,151,303,680 bytes = ~1.15G
> 
> zbud consumes ~32.7% more memory, and z3fold consumes ~1.8% more
> memory. This makes sense because zbud only stores a maximum of two
> compressed pages on each order-0 page, regardless of the compression
> ratio, so it is bound to consume more memory.
> 
> -------------------------------- </Results> --------------------------------
> 
> According to those results, it seems like zsmalloc is superior to
> z3fold in both efficiency and latency. Zbud has a small latency
> advantage, but that comes with a huge cost in terms of memory
> consumption. Moreover, most known users of zswap are currently using
> zsmalloc. Perhaps some folks are using zbud because it was the default
> allocator up until recently. The only known disadvantage of zsmalloc
> is the dependency on MMU.
> 
> Based on that, I think it doesn't make sense to keep all 3 allocators
> going forward. I believe we should start with removing either zbud or
> z3fold, leaving only one allocator supporting MMU. Once zsmalloc
> supports !MMU (if possible), we can keep zsmalloc as the only
> allocator.
> 
> Thoughts and feedback are highly appreciated. I tried to CC all the
> interested folks, but others feel free to chime in.
> 


