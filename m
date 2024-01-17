Return-Path: <linux-kernel+bounces-28430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E7682FE6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29D29B26BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E12B46BB;
	Wed, 17 Jan 2024 01:34:14 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B014687
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 01:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705455253; cv=none; b=gKsYCMIzaS2koMkzNa2RED7jD02Prux+4LZBDchJfEhfnbJ8IXTZr+XvmsJCEFG+Cbu3KHOVII4yIm1ChJmGOGW/zkfkC1mSpXRi4n6f2H+gbDvOZiKZHJm2yfkGNfggO/ZKqV7VwZs7Mofz5oZh0I1UgKVhTsenM7PeRi4fcG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705455253; c=relaxed/simple;
	bh=Bu02hejcdkvtR8GKaENOTxwiUSz6U7HJKAvIKycRKRE=;
	h=Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy; b=lGpMnHZBJkgG6s5I2/GhDMJYsbOE0pi7wDRPBmgTYJrIxo6x37VXQaAvVFMtpMBUUOkFhWeaek1twM1R8nZSoQQ4nHlYA3VB3hGLF0S2lT5BzDCCEjxC/R5jXLUbeh7T/O9qkD+38H9dF20Tufbc92nPbRiBgEfWZTBDsqPYEfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TF7fH6c46z1V48D;
	Wed, 17 Jan 2024 09:32:23 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 13B0D140113;
	Wed, 17 Jan 2024 09:34:02 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 09:34:01 +0800
Message-ID: <49ee43cd-f356-4441-ba95-4ac81ef98bb2@huawei.com>
Date: Wed, 17 Jan 2024 09:34:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: memory: move mem_cgroup_charge() into
 alloc_anon_folio()
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, David Hildenbrand <david@redhat.com>
References: <20240116071302.2282230-1-wangkefeng.wang@huawei.com>
 <2c24afdf-5103-4c1b-a649-2eeed185f3fb@arm.com>
 <ZaaX4Yi9JYBWrUEs@casper.infradead.org>
 <dda2ce7c-a487-44a0-bb97-8405524a0ed0@arm.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <dda2ce7c-a487-44a0-bb97-8405524a0ed0@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/1/16 23:07, Ryan Roberts wrote:
> On 16/01/2024 14:51, Matthew Wilcox wrote:
>> On Tue, Jan 16, 2024 at 02:35:54PM +0000, Ryan Roberts wrote:
>>> On 16/01/2024 07:13, Kefeng Wang wrote:
>>>> In order to allocate as much as possible of large folio, move
>>>> the mem charge into alloc_anon_folio() and try the next order
>>>> if mem_cgroup_charge() fails, also we change the GFP_KERNEL
>>>> to gfp to be consistent with PMD THP.
>>>
>>> I agree that changing gfp gives you consistency. But it's not entirely clear to
>>> me why THP should use one set of flags for this case, and since pages another.
>>> Why does this difference exist?
>>
>> I think it needs to be spelled out much better in the changelog.  Here's
>> my attempt at explaining why we might want this change.
>>
>> mem_cgroup_charge() uses the GFP flags in a fairly sophisticated way.
>> In addition to checking gfpflags_allow_blocking(), it pays attention to
>> __GFP_NORETRY and __GFP_RETRY_MAYFAIL to ensure that processes within
>> this memcg do not exceed their quotas.  Using the same GFP flags ensures
>> that we handle large anonymous folios correctly, including falling back
>> to smaller orders when there is plenty of memory available in the system
>> but this memcg is close to its limits.
> 
> Thanks for the explanation. Please add to the commit log.

Thanks, it is much better, will update, a similar change in THP, see
commit 3b3636924dfe "mm, memcg: sync allocation and memcg charge gfp
flags for THP".

> 
> Essentially you are saying that previously, all mTHP allocations would cause
> reclaim from the memcg if the allocation caused the quota to be used up. But
> with this change, it might now avoid that reclaim and just OOM, if the flags are
> as such? So then we retry with the next lowest available size. Makes sense!
> 

With correct GFP, we could get less reclaim and faster fallabck to next 
order, that's what I want too.

> 
>>
>> ... I remain not-an-expert in memcg and anonymous memory and welcome
>> improvements to that text.
> 
> Me too...

