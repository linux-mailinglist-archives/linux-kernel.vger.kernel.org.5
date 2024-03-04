Return-Path: <linux-kernel+bounces-90269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAB886FCAA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B72282E7C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0B620DCF;
	Mon,  4 Mar 2024 09:04:41 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F8A20B02
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543080; cv=none; b=WeU8S+KCNdn7UzsYbM+Fs7lwzz39IBRB+T87YpH0/Mee/Jjy7r7CXKPw6Y9RT7G4feAG0OEzYUzrk9/E6hyyry1prbulxDTICQmnCuxtpWZZ6WsQ0pQYnK8Y/Gz0xAOcIkLdgPtg9VlYK5l94rd3BAVTUCQtbKoGK4REkt3pYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543080; c=relaxed/simple;
	bh=fK1frum68jA9vSq+G4MNQ9yklqMoIZwae5gc7iIYhZw=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O88vCV2aSD6QPmuhgMt5TyfdAUZGAitbgIi6Zz9y0SB6cizINwYkjTdG25rC1Hpic77qu/p61gC7YvRZetnIxgYNXRiF8nuUDuQez1/mGR2ni9+Td1Ss/n4JYMYUG6GTp7x//4YfcGrEMK851oZ/78VtQnuVhdJYQ7rdnXOXJoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TpCRN5t7MzNp35;
	Mon,  4 Mar 2024 17:03:44 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CAE2180073;
	Mon,  4 Mar 2024 17:04:26 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 4 Mar 2024 17:04:25 +0800
Message-ID: <fefd4a04-0af3-4135-9e98-c983ee321e52@huawei.com>
Date: Mon, 4 Mar 2024 17:04:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>, <rdunlap@infradead.org>,
	<bhelgaas@google.com>, <linux-mm@kvack.org>
Subject: Re: [Question] CoW on VM_PFNMAP vma during write fault
Content-Language: en-US
To: <david@redhat.com>, <akpm@linux-foundation.org>, <khlebnikov@openvz.org>,
	<jaredeh@gmail.com>, <linmiaohe@huawei.com>, <hpa@zytor.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<cotte@de.ibm.com>, <npiggin@suse.de>
References: <20240227122814.3781907-1-mawupeng1@huawei.com>
 <a74c8b96-3fc5-44ff-949c-6e5c5e05e122@redhat.com>
 <de0cc6e0-dd15-40b6-89c2-c8e83fd6f587@redhat.com>
 <fa8f9f3b-e01e-4662-a2d5-77caeeb7b9f5@huawei.com>
 <234a5423-8d6d-444a-a27c-c772a71c9871@huawei.com>
 <6e948123-df3a-4450-8fd3-76b9131a35a0@redhat.com>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <6e948123-df3a-4450-8fd3-76b9131a35a0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd200001.china.huawei.com (7.185.36.224)



On 2024/3/4 16:57, David Hildenbrand wrote:
> On 04.03.24 09:47, mawupeng wrote:
>> Hi Maintainers, kindly ping...
>>
>> On 2024/2/28 9:55, mawupeng wrote:
>>>
>>>
>>> On 2024/2/27 21:15, David Hildenbrand wrote:
>>>> On 27.02.24 14:00, David Hildenbrand wrote:
>>>>> On 27.02.24 13:28, Wupeng Ma wrote:
>>>>>> We find that a warn will be produced during our test, the detail log is
>>>>>> shown in the end.
>>>>>>
>>>>>> The core problem of this warn is that the first pfn of this pfnmap vma is
>>>>>> cleared during memory-failure. Digging into the source we find that this
>>>>>> problem can be triggered as following:
>>>>>>
>>>>>> // mmap with MAP_PRIVATE and specific fd which hook mmap
>>>>>> mmap(MAP_PRIVATE, fd)
>>>>>>      __mmap_region
>>>>>>        remap_pfn_range
>>>>>>        // set vma with pfnmap and the prot of pte is read only
>>>>>>      
>>>>>
>>>>> Okay, so we get a MAP_PRIVATE VM_PFNMAP I assume.
>>>>>
>>>>> What fd is that exactly? Often, we disallow private mappings in the
>>>>> mmap() callback (for a good reason).
>>
>> We found this problem in 5.10, Commit 9f78bf330a66 ("xsk: support use vaddr as ring") Fix this
>> problem during supporting vaddr by remap VM_PFNMAP by VM_MIXEDMAP. But other modules which
>> use remap_pfn_range may still have this problem.
> 
> I wrote a simple reproducer using MAP_PRIVATE of iouring queues on Friday.
> 
>>
>> It do seems wired for private mappings, What is the good reason?
> 
> I'm sure there are some use cases that require MAP_PRIVATE of such areas, and usually there is nothing wrong with that.

So MAP_PRIVATE for VM_PFNMAP area with write access is ok? What is the user case for this situation?

> 
> It's just that the PAT implementation incompatible.

PAT do have its problem.

> 
> I can submit a cleaned-up version of my patches.

Thanks

> 

