Return-Path: <linux-kernel+bounces-135145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 639C689BBB0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673291C2181F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CF347A7D;
	Mon,  8 Apr 2024 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lOXYm2zi"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBB148CC6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712568616; cv=none; b=laqSVars362XCp8ughWSDXRELU0RWHcmFYUlc2WHhgAz2oBlrB08nD+ownidrZk5PHAm906PqyAFB3EaAmz3IC1IJZqHM7+JAsFXbHff5vRoP2BrC3Ptb58TfhBRU1V+p+vEo+RUQYLbN2lnxmYIJnKR3ius6W2vsDsH8atVc28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712568616; c=relaxed/simple;
	bh=j0o2vfQvzMJA0ps0XQEAeL1MYAORQQlzx5UjY9J+BX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jve6eRWuhP8j6a/NVEtM7khPYsFPgWVr2jOA4/wZA4ZHT4y5d8qEdAUJaqZENFvrqTwuVCYXxcjfjFWGdefmC0QCDoXDIFnXyS0tHR1TzUAMosGGHpsAhhAzKiu7tsSqW99d4O4GJ7WRCxgFxvo3u94aExx7otsdP5opp7jcmIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lOXYm2zi; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712568606; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=reXpO/J+6w+KU1m059irtt3Ajyyk+9KNlrwMwfsL/dg=;
	b=lOXYm2ziEQNu0GSvZtcnhcq2fRAtc1yDYl2cbHqjjYbx82hughKyv2S+Upm0c96J5P22wbVUkwrhSqYN0tlNGmIkJ+YHIL0Yhauq+DfTMW5VprR7a99RW2hFWibKlYjrOlMLC1UpqBCeETojqkgxaHnl/VFKyp1El5KEBhyxpzk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W477O.l_1712568604;
Received: from 30.97.56.71(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W477O.l_1712568604)
          by smtp.aliyun-inc.com;
          Mon, 08 Apr 2024 17:30:05 +0800
Message-ID: <bf92e3a5-35cb-4dfc-9e41-04df7ea5e14f@linux.alibaba.com>
Date: Mon, 8 Apr 2024 17:30:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/10] mm: page_alloc: freelist migratetype hygiene
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mel Gorman
 <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240320180429.678181-1-hannes@cmpxchg.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240320180429.678181-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/21 02:02, Johannes Weiner wrote:
> V4:
> - fixed !pcp_order_allowed() case in free_unref_folios()
> - reworded the patch 0 changelog a bit for the git log
> - rebased to mm-everything-2024-03-19-23-01
> - runtime-tested again with various CONFIG_DEBUG_FOOs enabled
> 
> ---
> 
> The page allocator's mobility grouping is intended to keep unmovable
> pages separate from reclaimable/compactable ones to allow on-demand
> defragmentation for higher-order allocations and huge pages.
> 
> Currently, there are several places where accidental type mixing
> occurs: an allocation asks for a page of a certain migratetype and
> receives another. This ruins pageblocks for compaction, which in turn
> makes allocating huge pages more expensive and less reliable.
> 
> The series addresses those causes. The last patch adds type checks on
> all freelist movements to prevent new violations being introduced.
> 
> The benefits can be seen in a mixed workload that stresses the machine
> with a memcache-type workload and a kernel build job while
> periodically attempting to allocate batches of THP. The following data
> is aggregated over 50 consecutive defconfig builds:
> 
>                                                          VANILLA                 PATCHED
> Hugealloc Time mean                      165843.93 (    +0.00%)  113025.88 (   -31.85%)
> Hugealloc Time stddev                    158957.35 (    +0.00%)  114716.07 (   -27.83%)
> Kbuild Real time                            310.24 (    +0.00%)     300.73 (    -3.06%)
> Kbuild User time                           1271.13 (    +0.00%)    1259.42 (    -0.92%)
> Kbuild System time                          582.02 (    +0.00%)     559.79 (    -3.81%)
> THP fault alloc                           30585.14 (    +0.00%)   40853.62 (   +33.57%)
> THP fault fallback                        36626.46 (    +0.00%)   26357.62 (   -28.04%)
> THP fault fail rate %                        54.49 (    +0.00%)      39.22 (   -27.53%)
> Pagealloc fallback                         1328.00 (    +0.00%)       1.00 (   -99.85%)
> Pagealloc type mismatch                  181009.50 (    +0.00%)       0.00 (  -100.00%)
> Direct compact stall                        434.56 (    +0.00%)     257.66 (   -40.61%)
> Direct compact fail                         421.70 (    +0.00%)     249.94 (   -40.63%)
> Direct compact success                       12.86 (    +0.00%)       7.72 (   -37.09%)
> Direct compact success rate %                 2.86 (    +0.00%)       2.82 (    -0.96%)
> Compact daemon scanned migrate          3370059.62 (    +0.00%) 3612054.76 (    +7.18%)
> Compact daemon scanned free             7718439.20 (    +0.00%) 5386385.02 (   -30.21%)
> Compact direct scanned migrate           309248.62 (    +0.00%)  176721.04 (   -42.85%)
> Compact direct scanned free              433582.84 (    +0.00%)  315727.66 (   -27.18%)
> Compact migrate scanned daemon %             91.20 (    +0.00%)      94.48 (    +3.56%)
> Compact free scanned daemon %                94.58 (    +0.00%)      94.42 (    -0.16%)
> Compact total migrate scanned           3679308.24 (    +0.00%) 3788775.80 (    +2.98%)
> Compact total free scanned              8152022.04 (    +0.00%) 5702112.68 (   -30.05%)
> Alloc stall                                 872.04 (    +0.00%)    5156.12 (  +490.71%)
> Pages kswapd scanned                     510645.86 (    +0.00%)    3394.94 (   -99.33%)
> Pages kswapd reclaimed                   134811.62 (    +0.00%)    2701.26 (   -98.00%)
> Pages direct scanned                      99546.06 (    +0.00%)  376407.52 (  +278.12%)
> Pages direct reclaimed                    62123.40 (    +0.00%)  289535.70 (  +366.06%)
> Pages total scanned                      610191.92 (    +0.00%)  379802.46 (   -37.76%)
> Pages scanned kswapd %                       76.36 (    +0.00%)       0.10 (   -98.58%)
> Swap out                                  12057.54 (    +0.00%)   15022.98 (   +24.59%)
> Swap in                                     209.16 (    +0.00%)     256.48 (   +22.52%)
> File refaults                             17701.64 (    +0.00%)   11765.40 (   -33.53%)
> 
> Huge page success rate is higher, allocation latencies are shorter and
> more predictable.
> 
> Stealing (fallback) rate is drastically reduced. Notably, while the
> vanilla kernel keeps doing fallbacks on an ongoing basis, the patched
> kernel enters a steady state once the distribution of block types is
> adequate for the workload. Steals over 50 runs:
> 
> VANILLA         PATCHED
> 1504.0		227.0
> 1557.0		6.0
> 1391.0		13.0
> 1080.0		26.0
> 1057.0		40.0
> 1156.0		6.0
> 805.0		46.0
> 736.0		20.0
> 1747.0		2.0
> 1699.0		34.0
> 1269.0		13.0
> 1858.0		12.0
> 907.0		4.0
> 727.0		2.0
> 563.0		2.0
> 3094.0		2.0
> 10211.0		3.0
> 2621.0		1.0
> 5508.0		2.0
> 1060.0		2.0
> 538.0		3.0
> 5773.0		2.0
> 2199.0		0.0
> 3781.0		2.0
> 1387.0		1.0
> 4977.0		0.0
> 2865.0		1.0
> 1814.0		1.0
> 3739.0		1.0
> 6857.0		0.0
> 382.0		0.0
> 407.0		1.0
> 3784.0		0.0
> 297.0		0.0
> 298.0		0.0
> 6636.0		0.0
> 4188.0		0.0
> 242.0		0.0
> 9960.0		0.0
> 5816.0		0.0
> 354.0		0.0
> 287.0		0.0
> 261.0		0.0
> 140.0		1.0
> 2065.0		0.0
> 312.0		0.0
> 331.0		0.0
> 164.0		0.0
> 465.0		1.0
> 219.0		0.0
> 
> Type mismatches are down too. Those count every time an allocation
> request asks for one migratetype and gets another. This can still
> occur minimally in the patched kernel due to non-stealing fallbacks,
> but it's quite rare and follows the pattern of overall fallbacks -
> once the block type distribution settles, mismatches cease as well:
> 
> VANILLA:        PATCHED:
> 182602.0	268.0
> 135794.0	20.0
> 88619.0		19.0
> 95973.0		0.0
> 129590.0	0.0
> 129298.0	0.0
> 147134.0	0.0
> 230854.0	0.0
> 239709.0	0.0
> 137670.0	0.0
> 132430.0	0.0
> 65712.0		0.0
> 57901.0		0.0
> 67506.0		0.0
> 63565.0		4.0
> 34806.0		0.0
> 42962.0		0.0
> 32406.0		0.0
> 38668.0		0.0
> 61356.0		0.0
> 57800.0		0.0
> 41435.0		0.0
> 83456.0		0.0
> 65048.0		0.0
> 28955.0		0.0
> 47597.0		0.0
> 75117.0		0.0
> 55564.0		0.0
> 38280.0		0.0
> 52404.0		0.0
> 26264.0		0.0
> 37538.0		0.0
> 19671.0		0.0
> 30936.0		0.0
> 26933.0		0.0
> 16962.0		0.0
> 44554.0		0.0
> 46352.0		0.0
> 24995.0		0.0
> 35152.0		0.0
> 12823.0		0.0
> 21583.0		0.0
> 18129.0		0.0
> 31693.0		0.0
> 28745.0		0.0
> 33308.0		0.0
> 31114.0		0.0
> 35034.0		0.0
> 12111.0		0.0
> 24885.0		0.0
> 
> Compaction work is markedly reduced despite much better THP rates.
> 
> In the vanilla kernel, reclaim seems to have been driven primarily by
> watermark boosting that happens as a result of fallbacks. With those
> all but eliminated, watermarks average lower and kswapd does less
> work. The uptick in direct reclaim is because THP requests have to
> fend for themselves more often - which is intended policy right
> now. Aggregate reclaim activity is lowered significantly, though.
> 
> ---

With my 2 fixes, the whole series works well on my platform, so please 
feel free to add:
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

