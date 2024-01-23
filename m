Return-Path: <linux-kernel+bounces-34864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF94838877
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1240C2820BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAA556B61;
	Tue, 23 Jan 2024 08:06:28 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7F45675D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997187; cv=none; b=MuBMymaxRoR4eb+/MoL2lYol0IMwQiPB67To2BpPWwNhlDeYBJhvHYvi3/Wl2KwEhd0OKC8XX86uzf3wi6q2BScpVaw8yTop0OY0yHOjbxXRn69OZ+zSM6Efrxn5aR7VlBO8GU0B5lehIXdUX9/Ata0Appop2qKmGE7hCK03KuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997187; c=relaxed/simple;
	bh=LZ+NZo7qdlXNCUJZcu2qtSXl9a+sOqKHa4APCYHWXZ4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EePeEo8EUuk8yo56LLNnW6Mx1k7/TtdHsd4KY9jbPPLZE27/n2pQQS+86JHYELRX3zsxw8PewPaYl958TZw6WmXfvhYhtGqfYWXp/8WQFZAtfvluSHw/KcT0noAM4e8luLG9O7FnP4wMTQ0Mzmk6TUH1eHxFJKjmj5BvxFy4ZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TK0511RKzz1xmcD;
	Tue, 23 Jan 2024 16:05:25 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 34F981A0172;
	Tue, 23 Jan 2024 16:06:16 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 16:06:09 +0800
Subject: Re: [PATCH] mm/memory-failure: fix crash in split_huge_page_to_list
 from soft_offline_page
To: Matthew Wilcox <willy@infradead.org>
CC: <naoya.horiguchi@nec.com>, <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240120065729.3276395-1-linmiaohe@huawei.com>
 <Zax60-Qu14QFuDod@casper.infradead.org>
 <aaff56ad-7bbe-8aa9-cd18-2ac9f4ea23f4@huawei.com>
 <Za59h0ORxsj3t3GW@casper.infradead.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a9e02fcf-da11-1f0e-1e71-ce88a93d747b@huawei.com>
Date: Tue, 23 Jan 2024 16:06:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Za59h0ORxsj3t3GW@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/1/22 22:36, Matthew Wilcox wrote:
> On Mon, Jan 22, 2024 at 08:57:06PM +0800, Miaohe Lin wrote:
>> On 2024/1/21 10:00, Matthew Wilcox wrote:
>>> On Sat, Jan 20, 2024 at 02:57:29PM +0800, Miaohe Lin wrote:
>>>>  {
>>>> -	/* Soft offline could migrate non-LRU movable pages */
>>>> -	if ((flags & MF_SOFT_OFFLINE) && __PageMovable(page))
>>>> +	/*
>>>> +	 * Soft offline could migrate non-LRU movable pages.
>>>> +	 * Note that page->mapping is overloaded with slab->slab_list or slabs
>>>> +	 * fields which might make slab pages appear like non-LRU movable pages.
>>>> +	 * So __PageMovable() has to be done after PageSlab() is checked.
>>>> +	 */
>>>> +	if ((flags & MF_SOFT_OFFLINE) && !PageSlab(page) && __PageMovable(page))
>>>>  		return true;
>>>>  
>>>>  	return PageLRU(page) || is_free_buddy_page(page);
>>>
>>> I think would make more sense as
>>>
>>> +	if (PageSlab(page))
>>> +		return false;
>>
>> Do you mean add PageSlab check above "if ((flags & MF_SOFT_OFFLINE) && __PageMovable(page))" block
>> so we don't need to add more comment?
> 
> Yes, although not just that we don't need to add a comment.
> Fundamentally, if you see PageSlab, you don't need to test anything
> else, you know it's not migratable.

Yes, this really makes sense.

> 
>> I have a concern that __PageMovable() seems unreliable now if we access page from random context.
>> This might introduce some potential problems. For example, offline_pages() might be stumped with
>> such pages without any progress until signal occurs IIUC:
>>
>>   offline_pages
>>     ..
>>     do {
>>       scan_movable_pages
>>         if (__PageMovable(page)) -- It might be slab page here. ret will also be set to 0.
>>           goto found;
>>       do_migrate_range -- Failed to isolate slab page and retry.
>>     } while (!ret) -- retry since ret is 0.
>>
>> There might be many similar scenes, but I haven't taken them more closely. Maybe these are
>> just dumb problems...
> 
> Yep, lots of places are insufficiently careful about testing
> PageMovable.  This will get fixed with memdescs, but we're a fair way
> from having memdescs ...

I believe memdescs will fix all these mess, but we might need to fix them before memdescs becoming ready as a compromise.

Thanks.

> 
> .
> 


