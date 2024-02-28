Return-Path: <linux-kernel+bounces-84412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7A786A673
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21E11F246DF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E901D53C;
	Wed, 28 Feb 2024 02:19:00 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A93E1CF8C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709086739; cv=none; b=a1wSIxGhPkIYTSyf0LOq435W3pjiZL2KXswvrnCtjpojTEFs7ZKbqUShOhA5Pic+lvJixXG79+5G4zDbqqQ1YTvcNSlZAeYViku5v1ec7vufmZ8iqser/BwLt/Mp549PfuaTrFU7fe6mx3Kmsm86rTRFNP5Ba2oGQNEwRId4TwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709086739; c=relaxed/simple;
	bh=R8J8v9gASL1zih1cis7pGYntvqoft304Fk3/CNwsKwo=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rz8Nzi8G0u7QcSLWpcVf+tk4yQZ/dnE43LD2cfBwLRWm6Plu1ADZJBION829WT7vwBmrrpfONWVl+SEOP1VymqpMx8CxLHmeLIjzkyEthVlCarlrx+SuFGF0YBTS5R3etaf3mL2rtPsx4qAD3QzY2GxRJ3sVPROHCxYhI0I5VYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Tkygj239XzLqSg;
	Wed, 28 Feb 2024 10:18:09 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DA6A140499;
	Wed, 28 Feb 2024 10:18:48 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 28 Feb 2024 10:18:47 +0800
Message-ID: <aa07e3ad-8c31-4c8b-9c4b-48c857ffc875@huawei.com>
Date: Wed, 28 Feb 2024 10:18:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <david@redhat.com>, <akpm@linux-foundation.org>,
	<khlebnikov@openvz.org>, <jaredeh@gmail.com>, <linmiaohe@huawei.com>,
	<hpa@zytor.com>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <mingo@redhat.com>, <rdunlap@infradead.org>,
	<bhelgaas@google.com>, <linux-mm@kvack.org>
Subject: Re: [Question] CoW on VM_PFNMAP vma during write fault
Content-Language: en-US
To: <willy@infradead.org>
References: <20240227122814.3781907-1-mawupeng1@huawei.com>
 <a74c8b96-3fc5-44ff-949c-6e5c5e05e122@redhat.com>
 <de0cc6e0-dd15-40b6-89c2-c8e83fd6f587@redhat.com>
 <fa8f9f3b-e01e-4662-a2d5-77caeeb7b9f5@huawei.com>
 <Zd6WJe9xrRwkphfm@casper.infradead.org>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <Zd6WJe9xrRwkphfm@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd200001.china.huawei.com (7.185.36.224)



On 2024/2/28 10:10, Matthew Wilcox wrote:
> On Wed, Feb 28, 2024 at 09:55:24AM +0800, mawupeng wrote:
>> On 2024/2/27 21:15, David Hildenbrand wrote:
>>> On 27.02.24 14:00, David Hildenbrand wrote:
>>>> On 27.02.24 13:28, Wupeng Ma wrote:
>>>>> We find that a warn will be produced during our test, the detail log is
>>>>> shown in the end.
>>>>>
>>>>> The core problem of this warn is that the first pfn of this pfnmap vma is
>>>>> cleared during memory-failure. Digging into the source we find that this
>>>>> problem can be triggered as following:
>>>>>
>>>>> // mmap with MAP_PRIVATE and specific fd which hook mmap
>>>>> mmap(MAP_PRIVATE, fd)
>>>>>     __mmap_region
>>>>>       remap_pfn_range
>>>>>       // set vma with pfnmap and the prot of pte is read only
>>>>>     
>>>>
>>>> Okay, so we get a MAP_PRIVATE VM_PFNMAP I assume.
>>>>
>>>> What fd is that exactly? Often, we disallow private mappings in the
>>>> mmap() callback (for a good reason).
>>
>> just a device fd with device-specify mmap which use remap_pfn_range to assign memory.
> 
> But what meaning do you want MAP_PRIVATE of this fd to have?  Does it
> make sense to permit this, or should you rather just return -EINVAL if
> somebody tries to mmap() with MAP_PRIVATE set?

I think return -EINVAL if somebody tries to mmap() with MAP_PRIVATE and MAP_MAYWRITE is reasonable to me.

Read to this pfnmap vma will not trigger fault.

> 

