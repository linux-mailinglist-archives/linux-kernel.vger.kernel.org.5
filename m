Return-Path: <linux-kernel+bounces-31155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D798329D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8A01C22461
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7C6524D3;
	Fri, 19 Jan 2024 12:59:31 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1933A51C4D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669170; cv=none; b=ZFKzixJEaMBzndZ3Pn2bQ0sOaiNB6vBRe9W2MeAdy1DgHDdFIFCErRRTbLkFPLhyAAxarh7hSOJ8kuAUhcNLTvxrkjfeKhjAaq1aB3MCPYb7defdnyQtUwzdqHOUc4uFB4TaTSnhY1kpD9glC5pW653sYMvDBHA6oo0csoEp+tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669170; c=relaxed/simple;
	bh=a9evNIQTQ4v07c3j6jPq8pkzsYOuV1SjMhA90sc661c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VCasajjGBMoEKAtCqIdCqBOhPGG1OzaWBhG7yCmM/QIM7hFa8RNQ18jQW+54UBgUJ/zTou8z2FN2V32joAinOij/Ys7TJ8cVyDCliGN2KqtjPZxxsLu1V9VqLvwjCxB7sJfyqvMIbu/VhMXoHLEI6Imn5cKG1+vIgQ0vZFaINOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TGfmz0QQ3zsVs0;
	Fri, 19 Jan 2024 20:58:27 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D9CD140153;
	Fri, 19 Jan 2024 20:59:23 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 20:59:23 +0800
Message-ID: <14ae628d-a9ef-42f3-9201-e90c5c88c133@huawei.com>
Date: Fri, 19 Jan 2024 20:59:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: memory: move mem_cgroup_charge() into
 alloc_anon_folio()
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <ryan.roberts@arm.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>
References: <20240117103954.2756050-1-wangkefeng.wang@huawei.com>
 <ZalK3suIskEyaR7m@tiehlicka>
 <c7b1cc8e-c434-4c86-972e-4a105524646c@huawei.com>
 <ZaosK59cRa27K9zW@tiehlicka>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZaosK59cRa27K9zW@tiehlicka>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/1/19 16:00, Michal Hocko wrote:
> On Fri 19-01-24 10:05:15, Kefeng Wang wrote:
>>
>>
>> On 2024/1/18 23:59, Michal Hocko wrote:
>>> On Wed 17-01-24 18:39:54, Kefeng Wang wrote:
>>>> mem_cgroup_charge() uses the GFP flags in a fairly sophisticated way.
>>>> In addition to checking gfpflags_allow_blocking(), it pays attention
>>>> to __GFP_NORETRY and __GFP_RETRY_MAYFAIL to ensure that processes within
>>>> this memcg do not exceed their quotas. Using the same GFP flags ensures
>>>> that we handle large anonymous folios correctly, including falling back
>>>> to smaller orders when there is plenty of memory available in the system
>>>> but this memcg is close to its limits.
>>>
>>> The changelog is not really clear in the actual problem you are trying
>>> to fix. Is this pure consistency fix or have you actually seen any
>>> misbehavior. From the patch I suspect you are interested in THPs much
>>> more than regular order-0 pages because those are GFP_KERNEL like when
>>> it comes to charging. THPs have a variety of options on how aggressive
>>> the allocation should try. From that perspective NORETRY and
>>> RETRY_MAYFAIL are not all that interesting because costly allocations
>>> (which THPs are) already do imply MAYFAIL and NORETRY.
>>
>> I don't meet actual issue, it founds from code inspection.
>>
>> mTHP is introduced by Ryan（19eaf44954df "mm: thp: support allocation of
>> anonymous multi-size THP")，so we have similar check for mTHP like PMD THP
>> in alloc_anon_folio(), it will try to allocate large order folio below
>> PMD_ORDER, and fallback to order-0 folio if fails, meanwhile,
>> it get GFP flags from vma_thp_gfp_mask() according to user configuration
>> like PMD THP allocation, so
>>
>> 1) the memory charge failure check should be moved into fallback
>> logical, because it will make us to allocated as much as possible large
>> order folio, although the memcg's memory usage is close to its limits.
>>
>> 2) using seem GFP flags for allocate/mem charge, be consistent with PMD
>> THP firstly, in addition, according to GFP flag returned for
>> vma_thp_gfp_mask(), GFP_TRANSHUGE_LIGHT could make us skip direct reclaim,
>> _GFP_NORETRY will make us skip mem_cgroup_oom and won't kill
>> any progress from large order folio charging.
> 
> OK, makes sense. Please turn that into the changelog.

Sure.

> 
>>> GFP_TRANSHUGE_LIGHT is more interesting though because those do not dive
>>> into the direct reclaim at all. With the current code they will reclaim
>>> charges to free up the space for the allocated THP page and that defeats
>>> the light mode. I have a vague recollection of preparing a patch to
>>
>> We are interesting to GFP_TRANSHUGE_LIGHT and _GFP_NORETRY as mentioned
>> above.
> 
> if mTHP can be smaller than COSTLY_ORDER then you are correct and
> NORETRY makes a difference. Please mention that in the changelog as
> well.
> 

For memory cgroup charge, _GFP_NORETRY checked to make us directly skip
mem_cgroup_oom(), it has no concern with folio order or COSTLY_ORDER 
when check _GFP_NORETRY in try_charge_memcg(), so I think NORETRY should
always make difference for all large order folio.

	

