Return-Path: <linux-kernel+bounces-33056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2478363CD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E40286EC0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6743BB52;
	Mon, 22 Jan 2024 12:57:14 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5551E4A9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705928234; cv=none; b=pcP9xsRBItbxWYvZm7p5E9lhUfc09An5od9Z59qxPb7YUFttDpQok0g29iSJg2l9VB88fmDuRSUdQfN/PEbau8q92QR8uCFMjnxYnwhWBYgqL2q3Vk6+GV3oP861hrmpLIncJrtYIDfQ5saiy3mYqMGlB+28ZISk/c0c/Y4Qd7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705928234; c=relaxed/simple;
	bh=6g2qVr3jm6/VZgc7kBjNS9i3UKhQSZoRmkSmDFWbmkw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=U6W+vWoia75uEki7lM5AfRHjvO4pZyWbKYicGnpD0VRbvwzwe2VC5uXfByy/JzVdodxUBKHS8kLAv+OCGrwNDQfKbYmYdcEkprDvsK4NKIP3mWC83O0JWbLlbFL9i5om8pSf6/keIGAGks2YobqFhXzAiQdIc9NguNsmFN2BdFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TJVZt745jzsWKT;
	Mon, 22 Jan 2024 20:56:06 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 5BCF918006C;
	Mon, 22 Jan 2024 20:57:07 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 20:57:06 +0800
Subject: Re: [PATCH] mm/memory-failure: fix crash in split_huge_page_to_list
 from soft_offline_page
To: Matthew Wilcox <willy@infradead.org>
CC: <naoya.horiguchi@nec.com>, <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240120065729.3276395-1-linmiaohe@huawei.com>
 <Zax60-Qu14QFuDod@casper.infradead.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <aaff56ad-7bbe-8aa9-cd18-2ac9f4ea23f4@huawei.com>
Date: Mon, 22 Jan 2024 20:57:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zax60-Qu14QFuDod@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/1/21 10:00, Matthew Wilcox wrote:
> On Sat, Jan 20, 2024 at 02:57:29PM +0800, Miaohe Lin wrote:
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 636280d04008..20058f7ac3e9 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1377,8 +1377,13 @@ void ClearPageHWPoisonTakenOff(struct page *page)
>>   */
>>  static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
>>  {
>> -	/* Soft offline could migrate non-LRU movable pages */
>> -	if ((flags & MF_SOFT_OFFLINE) && __PageMovable(page))
>> +	/*
>> +	 * Soft offline could migrate non-LRU movable pages.
>> +	 * Note that page->mapping is overloaded with slab->slab_list or slabs
>> +	 * fields which might make slab pages appear like non-LRU movable pages.
>> +	 * So __PageMovable() has to be done after PageSlab() is checked.
>> +	 */
>> +	if ((flags & MF_SOFT_OFFLINE) && !PageSlab(page) && __PageMovable(page))
>>  		return true;
>>  
>>  	return PageLRU(page) || is_free_buddy_page(page);
> 
> I think would make more sense as
> 
> +	if (PageSlab(page))
> +		return false;

Do you mean add PageSlab check above "if ((flags & MF_SOFT_OFFLINE) && __PageMovable(page))" block
so we don't need to add more comment?

> 
> ... and then leave the rest alone (including not touching the comment)> .

I have a concern that __PageMovable() seems unreliable now if we access page from random context.
This might introduce some potential problems. For example, offline_pages() might be stumped with
such pages without any progress until signal occurs IIUC:

  offline_pages
    ..
    do {
      scan_movable_pages
        if (__PageMovable(page)) -- It might be slab page here. ret will also be set to 0.
          goto found;
      do_migrate_range -- Failed to isolate slab page and retry.
    } while (!ret) -- retry since ret is 0.

There might be many similar scenes, but I haven't taken them more closely. Maybe these are
just dumb problems...

Thanks.

