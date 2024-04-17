Return-Path: <linux-kernel+bounces-148544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0548A8434
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D03D1C22204
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF5114036D;
	Wed, 17 Apr 2024 13:19:52 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BDF13D290;
	Wed, 17 Apr 2024 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359992; cv=none; b=tlXcMjKbZJD8beTDoHa9jCvPMMXbuVYbHmf3wf5JQynFFPg/IMNDWNP3y56hdHw59G05FgulJiyFlkafF/R4LZx/TNWIgOSG/kutOvG4FXw6qBo/CuobB8BqsIB2+7/qNlV1sB/GyXX7JKdINM31mIqofVd8p/JPegWwvtawZsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359992; c=relaxed/simple;
	bh=GOm/T8OG4KNEggUOzjxW+PjsIIqS6Eb/AF7ttlgIRlM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=S7emLtN38F4rm5/svHKPUzWhRpYjJJGAPLzE2lPRpIAJpkFJ4ICCrHrZ/tfH/qCfoCnqgFQ0zRlrVNvUCPe7rDIs5kp7zc4YX9Dr55gEwlyca0XMWbusrLQY1N95Bj6YIIjQKfTz1KHpXy7gY0WoIDUcTy74+mKLaFFgMVBb6xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VKLzD0SGRztT23;
	Wed, 17 Apr 2024 21:16:56 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id BD4A71800C3;
	Wed, 17 Apr 2024 21:19:48 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Apr
 2024 21:19:48 +0800
Subject: Re: [PATCH net-next v2 09/15] mm: page_frag: reuse MSB of 'size'
 field for pfmemalloc
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
 <20240415131941.51153-10-linyunsheng@huawei.com>
 <37d012438d4850c3d7090e784e09088d02a2780c.camel@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <8b7361c2-6f45-72e8-5aca-92e8a41a7e5e@huawei.com>
Date: Wed, 17 Apr 2024 21:19:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <37d012438d4850c3d7090e784e09088d02a2780c.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/17 0:22, Alexander H Duyck wrote:
> On Mon, 2024-04-15 at 21:19 +0800, Yunsheng Lin wrote:
>> The '(PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)' case is for the
>> system with page size less than 32KB, which is 0x8000 bytes
>> requiring 16 bits space, change 'size' to 'size_mask' to avoid
>> using the MSB, and change 'pfmemalloc' field to reuse the that
>> MSB, so that we remove the orginal space needed by 'pfmemalloc'.
>>
>> For another case, the MSB of 'offset' is reused for 'pfmemalloc'.
>>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>  include/linux/page_frag_cache.h | 13 ++++++++-----
>>  mm/page_frag_cache.c            |  5 +++--
>>  2 files changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
>> index fe5faa80b6c3..40a7d6da9ef0 100644
>> --- a/include/linux/page_frag_cache.h
>> +++ b/include/linux/page_frag_cache.h
>> @@ -12,15 +12,16 @@ struct page_frag_cache {
>>  	void *va;
>>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>>  	__u16 offset;
>> -	__u16 size;
>> +	__u16 size_mask:15;
>> +	__u16 pfmemalloc:1;
>>  #else
>> -	__u32 offset;
>> +	__u32 offset:31;
>> +	__u32 pfmemalloc:1;
>>  #endif
> 
> This seems like a really bad idea. Using a bit-field like this seems
> like a waste as it means that all the accesses now have to add
> additional operations to access either offset or size. It wasn't as if
> this is an oversized struct, or one that we are allocating a ton of. As
> such I am not sure why we need to optmize for size like this.

For the old 'struct page_frag' use case, there is one 'struct page_frag'
for every socket and task_struct, there may be tens of thousands of
them even in a 32 bit sysmem, which might mean a lof of memory even for
a single byte saving, see patch 13.

> 
>>  	/* we maintain a pagecount bias, so that we dont dirty cache line
>>  	 * containing page->_refcount every time we allocate a fragment.
>>  	 */
>>  	unsigned int		pagecnt_bias;
>> -	bool pfmemalloc;
>>  };

