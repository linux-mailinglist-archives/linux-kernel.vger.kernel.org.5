Return-Path: <linux-kernel+bounces-15307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011B98229FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A017728533C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED77182BE;
	Wed,  3 Jan 2024 09:12:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DE1182AA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA3D2C15;
	Wed,  3 Jan 2024 01:13:31 -0800 (PST)
Received: from [10.57.74.226] (unknown [10.57.74.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F2D73F7A6;
	Wed,  3 Jan 2024 01:12:43 -0800 (PST)
Message-ID: <7acefbe0-9413-48fd-ad98-56fecc6f29da@arm.com>
Date: Wed, 3 Jan 2024 09:12:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Enable >0 order folio memory compaction
Content-Language: en-GB
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Huang, Ying" <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, "Yin, Fengwei"
 <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Mel Gorman <mgorman@techsingularity.net>, Rohan Puri
 <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20231113170157.280181-1-zi.yan@sent.com>
 <1e7cf758-ac0e-4eda-a8e2-90db5eed7f7a@arm.com>
 <7ED1378A-AC39-48A2-8A2A-E06C7858DCE1@nvidia.com>
 <df51bbb7-f791-4747-9077-e9f7f37e9518@arm.com>
 <E22D7AC8-0891-4B4D-BB90-129B1CB77CB2@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <E22D7AC8-0891-4B4D-BB90-129B1CB77CB2@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/01/2024 20:50, Zi Yan wrote:
> On 21 Nov 2023, at 12:11, Ryan Roberts wrote:
> 
>> On 21/11/2023 16:45, Zi Yan wrote:
>>> On 21 Nov 2023, at 10:46, Ryan Roberts wrote:
>>>
>>>>>
>>>>> vm-scalability results
>>>>> ===
>>>>>
>>>>> =========================================================================================
>>>>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>>>>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalability
>>>>>
>>>>> commit:
>>>>>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>>>>>   6.6.0-rc4-split-folio-in-compaction+
>>>>>   6.6.0-rc4-folio-migration-in-compaction+
>>>>>   6.6.0-rc4-folio-migration-free-page-split+
>>>>>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
>>>>>
>>>>> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f
>>>>> ---------------- --------------------------- --------------------------- --------------------------- ---------------------------
>>>>>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>>>>>              \          |                \          |                \          |                \          |                \
>>>>>   12896955            +2.7%   13249322            -4.0%   12385175 ±  5%      +1.1%   13033951            -0.4%   12845698        vm-scalability.throughput
>>>>
>>>> Hi Zi,
>>>>
>>>> Are you able to add any commentary to these results as I'm struggling to
>>>> interpret them; Is a positive or negative change better (are they times or
>>>> rates?). What are the stddev values? The title suggests percent but the values
>>>> are huge - I'm trying to understand what the error bars look like - are the
>>>> swings real or noise?
>>>
>>> The metric is vm-scalability.throughput, so the larger the better. Some %stddev
>>> are not present since they are too small. For 6.6.0-rc4-folio-migration-in-compaction+,
>>> %stddev is greater than %change, so the change might be noise.
>>
>> Ahh got it - thanks!
>>
>>>
>>> Also, I talked to DavidH in last THP Cabal meeting about this. He suggested that
>>> there are a lot of noise in vm-scalability like what I have here and I should
>>> run more iterations and on bare metal. I am currently rerun them on a baremetal
>>> and more iterations on the existing VM and report the results later. Please
>>> note that the runs really take some time.
>>
>> Ahh ok, I'll wait for the bare metal numbers and will disregard these for now.
>> Thanks!
> 
> It seems that the unexpected big mmap-pread-seq-mt perf drop came from the mistake I
> made in patch 1. After fixing that, mmap-pread-seq-mt perf only drops 0.5%. The new
> results on top of 6.7.0-rc1-mm-everything-2023-11-15-00-17 are at the end of the email.

Good news! I don't see the results for mmap-pread-seq-mt below - perhaps you
forgot to include it?

> 
> I am preparing v2 and will send it out soon.
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalability
> 
> commit:
>   6.7.0-rc1-mm-everything-2023-11-15-00-17+
>   6.7.0-rc1-split-folio-in-compaction+
>   6.7.0-rc1-folio-migration-in-compaction+
>   6.7.0-rc1-folio-migration-free-page-split+
>   6.7.0-rc1-folio-migration-free-page-split-sort-src+
> 
> 6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration-i 6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
> ---------------- --------------------------- --------------------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \
>   13041962           +16.1%   15142976            +5.0%   13690666 ±  6%      +6.7%   13920441            +5.5%   13762582        vm-scalability.throughput

I'm still not sure I'm interpretting this correctly; is %change always relative
to 6.7.0-rc1-mm-everything-2023-11-15-00-17 or is it relative to the previous
commit?

If the former, then it looks like splitting the folios is actually faster than
migrating them whole?


> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq/vm-scalability
> 
> commit:
>   6.7.0-rc1-mm-everything-2023-11-15-00-17+
>   6.7.0-rc1-split-folio-in-compaction+
>   6.7.0-rc1-folio-migration-in-compaction+
>   6.7.0-rc1-folio-migration-free-page-split+
>   6.7.0-rc1-folio-migration-free-page-split-sort-src+
> 
> 6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration-i 6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
> ---------------- --------------------------- --------------------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \
>   14998168            -1.0%   14852803            -0.7%   14890569            -0.3%   14946766            -0.4%   14943302        vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/qemu-vm/lru-file-readtwice/vm-scalability
> 
> commit:
>   6.7.0-rc1-mm-everything-2023-11-15-00-17+
>   6.7.0-rc1-split-folio-in-compaction+
>   6.7.0-rc1-folio-migration-in-compaction+
>   6.7.0-rc1-folio-migration-free-page-split+
>   6.7.0-rc1-folio-migration-free-page-split-sort-src+
> 
> 6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration-i 6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
> ---------------- --------------------------- --------------------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \
>    6750930 ±  7%     +41.5%    9549570 ±  2%     +31.6%    8883545 ±  2%     +33.1%    8982606 ±  2%     +30.7%    8821667 ±  3%  vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/qemu-vm/lru-file-mmap-read/vm-scalability
> 
> commit:
>   6.7.0-rc1-mm-everything-2023-11-15-00-17+
>   6.7.0-rc1-split-folio-in-compaction+
>   6.7.0-rc1-folio-migration-in-compaction+
>   6.7.0-rc1-folio-migration-free-page-split+
>   6.7.0-rc1-folio-migration-free-page-split-sort-src+
> 
> 6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration-i 6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
> ---------------- --------------------------- --------------------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \
>    5818610 ± 14%     +43.1%    8329118 ±  2%     +26.0%    7331427 ±  4%     +23.2%    7170418 ±  4%     +22.8%    7147458 ±  4%  vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/qemu-vm/anon-r-rand/vm-scalability
> 
> commit:
>   6.7.0-rc1-mm-everything-2023-11-15-00-17+
>   6.7.0-rc1-split-folio-in-compaction+
>   6.7.0-rc1-folio-migration-in-compaction+
>   6.7.0-rc1-folio-migration-free-page-split+
>   6.7.0-rc1-folio-migration-free-page-split-sort-src+
> 
> 6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration-i 6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
> ---------------- --------------------------- --------------------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \
>    1973808            -0.2%    1969617            -0.5%    1964376            +0.3%    1979245            +1.0%    1993677        vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/512G/qemu-vm/anon-w-rand/vm-scalability
> 
> commit:
>   6.7.0-rc1-mm-everything-2023-11-15-00-17+
>   6.7.0-rc1-split-folio-in-compaction+
>   6.7.0-rc1-folio-migration-in-compaction+
>   6.7.0-rc1-folio-migration-free-page-split+
>   6.7.0-rc1-folio-migration-free-page-split-sort-src+
> 
> 6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration-i 6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
> ---------------- --------------------------- --------------------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \
>     479486            +0.3%     481036            +0.0%     479580            +2.3%     490310            +1.6%     487107        vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/512G/qemu-vm/anon-cow-rand/vm-scalability
> 
> commit:
>   6.7.0-rc1-mm-everything-2023-11-15-00-17+
>   6.7.0-rc1-split-folio-in-compaction+
>   6.7.0-rc1-folio-migration-in-compaction+
>   6.7.0-rc1-folio-migration-free-page-split+
>   6.7.0-rc1-folio-migration-free-page-split-sort-src+
> 
> 6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration-i 6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
> ---------------- --------------------------- --------------------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \
>     453237            +1.2%     458580            +0.5%     455455            +2.6%     464830            +2.6%     465211        vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/256G/qemu-vm/msync/vm-scalability
> 
> commit:
>   6.7.0-rc1-mm-everything-2023-11-15-00-17+
>   6.7.0-rc1-split-folio-in-compaction+
>   6.7.0-rc1-folio-migration-in-compaction+
>   6.7.0-rc1-folio-migration-free-page-split+
>   6.7.0-rc1-folio-migration-free-page-split-sort-src+
> 
> 6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration-i 6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
> ---------------- --------------------------- --------------------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \
>    1074404 ±  5%     +78.7%    1920268           +78.7%    1920270           +77.2%    1903612           +78.0%    1912223        vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/256G/qemu-vm/msync-mt/vm-scalability
> 
> commit:
>   6.7.0-rc1-mm-everything-2023-11-15-00-17+
>   6.7.0-rc1-split-folio-in-compaction+
>   6.7.0-rc1-folio-migration-in-compaction+
>   6.7.0-rc1-folio-migration-free-page-split+
>   6.7.0-rc1-folio-migration-free-page-split-sort-src+
> 
> 6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration-i 6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
> ---------------- --------------------------- --------------------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \
>    2568988            +5.3%    2706227            +5.3%    2706214            +6.3%    2729716            +5.3%    2704539        vm-scalability.throughput
> 
> 
> --
> Best Regards,
> Yan, Zi


