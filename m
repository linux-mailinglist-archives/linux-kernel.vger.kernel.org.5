Return-Path: <linux-kernel+bounces-156433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496BB8B02B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84001F20F97
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0C815A4A4;
	Wed, 24 Apr 2024 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YQKThryx"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA2A158A07
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941766; cv=none; b=QXseCng/uLNP1++zAkn/D/Gte8Z/fG5B0PnVwuMVcAVO1CbmncRAYStl7KmYLbkd/NhDtsZ3PHDkIkH4iNddi2X/5g6lhyncNXqK36jeH00QapndvdAvm/L6o8xjlbo3W2letL4zDHbJcqIYStOl+f/84zRnOxC6uILUsMD+XdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941766; c=relaxed/simple;
	bh=17fXrczM/USVDSV8Jtxa3v6EpsLB23z4oQSPwC3f+Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oySyFozXjkNtGEHJpqLsBVIPJ/2w2Ez64j7rCEMe1aAJrJppfzwV5tauH0SXSWpA74KM09y4VNd8LDnWv3mfRr7i/5r/3llN0vD3hsA4ZIaL1JirB7cpG3EEMwCWEhOMB24MO181Exg+Tuw/XsTUG+TLCDxy5SN3SNxZIeG3OCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YQKThryx; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713941762; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2LDS+LSReqfsB8JRylwTSVQ4K8jQm0x7cZkTh0Y40I4=;
	b=YQKThryxABYHVng0HXVknTY8e1PSCv0Z9To+K+zwvfyMk/xgQPhRnPwnMfYaQgRFy1sEmzYwUkFw+OH9l9esc7vulPFRHXWILb1gf3wd2lkcBzeDVAtH5whyCFu/c44NMjDy6jpRdVL8hhPQj7/WltHloZXdDoAnLg+wj8OKVQ4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W5BTi-m_1713941728;
Received: from 30.97.56.58(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5BTi-m_1713941728)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 14:56:00 +0800
Message-ID: <5b663fcc-cace-4091-aa56-e88b00ec1d1c@linux.alibaba.com>
Date: Wed, 24 Apr 2024 14:55:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] mm: shmem: add an 'order' parameter for
 shmem_alloc_hugefolio()
To: Kefeng Wang <wangkefeng.wang@huawei.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ying.huang@intel.com, shy828301@gmail.com,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
 <2014bf7370d78bc1f5600731af5bf8f569e5868b.1713755580.git.baolin.wang@linux.alibaba.com>
 <c51d8d04-e108-4a0c-9f0b-7c47b619a76c@huawei.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <c51d8d04-e108-4a0c-9f0b-7c47b619a76c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/24 14:28, Kefeng Wang wrote:
> 
> 
> On 2024/4/22 15:02, Baolin Wang wrote:
>> Add a new parameter to specify the huge page order for 
>> shmem_alloc_hugefolio(),
>> as a preparation to supoort mTHP.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/shmem.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index fa2a0ed97507..893c88efc45f 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1604,14 +1604,14 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, 
>> gfp_t limit_gfp)
>>   }
>>   static struct folio *shmem_alloc_hugefolio(gfp_t gfp,
>> -        struct shmem_inode_info *info, pgoff_t index)
>> +        struct shmem_inode_info *info, pgoff_t index, int order)
>>   {
>>       struct mempolicy *mpol;
>>       pgoff_t ilx;
>>       struct page *page;
>> -    mpol = shmem_get_pgoff_policy(info, index, HPAGE_PMD_ORDER, &ilx);
>> -    page = alloc_pages_mpol(gfp, HPAGE_PMD_ORDER, mpol, ilx, 
>> numa_node_id());
>> +    mpol = shmem_get_pgoff_policy(info, index, order, &ilx);
>> +    page = alloc_pages_mpol(gfp, order, mpol, ilx, numa_node_id());
>>       mpol_cond_put(mpol);
>>       return page_rmappable_folio(page);
>> @@ -1639,13 +1639,14 @@ static struct folio 
>> *shmem_alloc_and_add_folio(gfp_t gfp,
>>       struct shmem_inode_info *info = SHMEM_I(inode);
>>       struct folio *folio;
>>       long pages;
>> -    int error;
>> +    int error, order;
>>       if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
>>           huge = false;
>>       if (huge) {
>>           pages = HPAGE_PMD_NR;
>> +        order = HPAGE_PMD_ORDER;
>>           index = round_down(index, HPAGE_PMD_NR);
>>           /*
>> @@ -1660,7 +1661,7 @@ static struct folio 
>> *shmem_alloc_and_add_folio(gfp_t gfp,
>>                   index + HPAGE_PMD_NR - 1, XA_PRESENT))
>>               return ERR_PTR(-E2BIG);
>> -        folio = shmem_alloc_hugefolio(gfp, info, index);
>> +        folio = shmem_alloc_hugefolio(gfp, info, index, order);
> 
> Avoid order variable, we can directly use HPAGE_PMD_NR here.

Yes, sure. Thanks.

