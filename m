Return-Path: <linux-kernel+bounces-18519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC2D825EA3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3D2284D24
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540C66129;
	Sat,  6 Jan 2024 07:07:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38435668
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 07:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4T6WZB4G6Yz29dPn;
	Sat,  6 Jan 2024 15:05:54 +0800 (CST)
Received: from kwepemd100006.china.huawei.com (unknown [7.221.188.47])
	by mail.maildlp.com (Postfix) with ESMTPS id E021F14040D;
	Sat,  6 Jan 2024 15:07:22 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 kwepemd100006.china.huawei.com (7.221.188.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Sat, 6 Jan 2024 15:07:21 +0800
Message-ID: <20924c0f-b752-4f58-91ce-21ed3b305481@huawei.com>
Date: Sat, 6 Jan 2024 15:07:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
CC: <joro@8bytes.org>, <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <john.g.garry@oracle.com>,
	<dheerajkumar.srivastava@amd.com>, <jsnitsel@redhat.com>, Ido Schimmel
	<idosch@idosch.org>, Robin Murphy <robin.murphy@arm.com>
References: <cover.1694535580.git.robin.murphy@arm.com>
 <ZY1osaGLyT-sdKE8@shredder> <ZZO6NV-Kq-ktnyo5@shredder>
 <f8ae34f0-dab2-48fa-b3f8-5e969ed028b7@linux.intel.com>
From: "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <f8ae34f0-dab2-48fa-b3f8-5e969ed028b7@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100006.china.huawei.com (7.221.188.47)



在 2024/1/6 12:21, Ethan Zhao 写道:
>
> On 1/2/2024 3:24 PM, Ido Schimmel wrote:
>> On Thu, Dec 28, 2023 at 02:23:20PM +0200, Ido Schimmel wrote:
>>> On Tue, Sep 12, 2023 at 05:28:04PM +0100, Robin Murphy wrote:
>>>> v2: 
>>>> https://lore.kernel.org/linux-iommu/cover.1692641204.git.robin.murphy@arm.com/
>>>>
>>>> Hi all,
>>>>
>>>> I hope this is good to go now, just fixed the locking (and threw
>>>> lockdep at it to confirm, which of course I should have done to begin
>>>> with...) and picked up tags.
>>> Hi,
>>>
>>> After pulling the v6.7 changes we started seeing the following memory
>>> leaks [1] of 'struct iova_magazine'. I'm not sure how to reproduce it,
>>> which is why I didn't perform bisection. However, looking at the
>>> mentioned code paths, they seem to have been changed in v6.7 as part of
>>> this patchset. I reverted both patches and didn't see any memory leaks
>>> when running a full regression (~10 hours), but I will repeat it to be
>>> sure.
>> FYI, we didn't see the leaks since reverting these two patches whereas
>> before we saw them almost everyday, so I'm quite sure they introduced
>> the leaks.
>
> Seems some magazines were not freed when one CPU is dead (hot 
> unplugged) ?
>
> static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain 
> *iovad)
> {
>     struct iova_cpu_rcache *cpu_rcache;
>     struct iova_rcache *rcache;
>     unsigned long flags;
>     int i;
>
>     for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>         rcache = &iovad->rcaches[i];
>         cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
>         spin_lock_irqsave(&cpu_rcache->lock, flags);
>         iova_magazine_free_pfns(cpu_rcache->loaded, iovad);
>
> +     iova_magazine_free(cpu_rcache->loaded);
>
>         iova_magazine_free_pfns(cpu_rcache->prev, iovad);
>
> +     iova_magazine_free(cpu_rcache->prev);
>
>         spin_unlock_irqrestore(&cpu_rcache->lock, flags);
>     }
> }
It seems cpu_rcache->loaded and cpu_rcache->prev will be freed in 
free_iova_rcaches(), and it should not cause memory leak because 
iova_magazine_free() will be called for each possible cpu.
free_cpu_cached_iovas() is used to free cached iovas in magazines.

Thanks,
Zekun



