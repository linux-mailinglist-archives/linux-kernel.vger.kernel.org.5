Return-Path: <linux-kernel+bounces-116425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB95889C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BAD41F35ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF36115664C;
	Mon, 25 Mar 2024 06:24:38 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32FE25D03F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335463; cv=none; b=Wllg/EuwPncAcM2rJMXcDyQhF7mRni4Dm7eGn6Nrh6V5xgvOQSyri8/AAkGuy5CsNaV+mUQZ5f5x59/TMrBVNuCqBcglUZiu7h/8cWcXWdd80B9j1uXecRL0AC5h1iVXftLIovCjdlH6y4qxdn3Rz+pIC6UJFdL0V7Y+UviOBww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335463; c=relaxed/simple;
	bh=Iq0l8d+smzcyIUy4k+N1v6VVd/r/I7UzeUZkGu16rqM=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dNIWLCc1WK3ZyR6y78o3I6/g82nM+3wKWzVNSYfeJRcfTElMbvw4L6Gn5FIeFouHfsb5KMy7nMN6gtlAQSwDMdC9lmFdEHv0R/Pt+kwriqFuii0uYeAyoWKuSaN/S+fXbetkt+TiKFqqVlEY6nxxm+TXp3DkrN2cmN/MHgh7NmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V2yG6219Jz2BhYF;
	Mon, 25 Mar 2024 10:54:54 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id C5BE81A016F;
	Mon, 25 Mar 2024 10:57:31 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 10:57:30 +0800
Message-ID: <ecab580c-28b7-42ee-b026-4600e16aef89@huawei.com>
Date: Mon, 25 Mar 2024 10:57:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <x86@kernel.org>, <dave.hansen@linux.intel.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>
Subject: Re: [PATCH v1] x86/mm/pat: fix VM_PAT handling in COW mappings
Content-Language: en-US
To: <david@redhat.com>, <willy@infradead.org>
References: <20240312181118.318701-1-david@redhat.com>
 <ZfCrkL-Aieer2EAg@casper.infradead.org>
 <5bc9de2f-c3ba-46e7-a234-3d3a46e53ba1@redhat.com>
 <1f2a8ed4-aaff-4be7-b3b6-63d2841a2908@redhat.com>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <1f2a8ed4-aaff-4be7-b3b6-63d2841a2908@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemd200001.china.huawei.com (7.185.36.224)



On 2024/3/15 0:42, David Hildenbrand wrote:
> On 12.03.24 20:38, David Hildenbrand wrote:
>> On 12.03.24 20:22, Matthew Wilcox wrote:
>>> On Tue, Mar 12, 2024 at 07:11:18PM +0100, David Hildenbrand wrote:
>>>> PAT handling won't do the right thing in COW mappings: the first PTE
>>>> (or, in fact, all PTEs) can be replaced during write faults to point at
>>>> anon folios. Reliably recovering the correct PFN and cachemode using
>>>> follow_phys() from PTEs will not work in COW mappings.
>>>
>>> I guess the first question is: Why do we want to support COW mappings
>>> of VM_PAT areas?  What breaks if we just disallow it?
>>
>> Well, that was my first approach. Then I decided to be less radical (IOW
>> make my life easier by breaking less user space) and "fix it" with
>> minimal effort.
>>
>> Chances of breaking some weird user space is possible, although I
>> believe for most such mappings MAP_PRIVATE doesn't make too much sense
>> sense.
>>
>> Nasty COW support for VM_PFNMAP mappings dates back forever. So does PAT
>> support.
>>
>> I can try finding digging through some possible user space users tomorrow.
> 
> As discussed, MAP_PRIVATE doesn't make too much sense for most PFNMAP mappings.
> 
> However, /dev/mem and /proc/vmcore are still used with MAP_PRIVATE in some cases.
> 
> Side note: /proc/vmcore is a bit weird: mmap_vmcore() sets VM_MIXEDMAP, and then we might call remap_pfn_range(), which sets VM_PFNMAP. I'm not so sure if that's what we want to happen ...
> 
> As far as I can see, makedumpfile always mmap's memory to be dumped (/dev/mem, /proc/vmcore) using PROT_READ+MAP_PRIVATE, resulting in a COW mapping.
> 
> 
> In my opinion, we should use this fairly simple fix to keep it working for now and look into disabling any MAP_PRIVATE of VM_PFNMAP separately, for all architectures.
> 
> But I'll leave the decision to x86 maintainers.

Hi, x86 maintainers:

kindle ping.

> 

