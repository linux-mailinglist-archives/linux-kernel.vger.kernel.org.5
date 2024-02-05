Return-Path: <linux-kernel+bounces-52623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 371DC849A90
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F6C1F22409
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9201BC5C;
	Mon,  5 Feb 2024 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="C/Mso+Ar"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248391CA88
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136731; cv=none; b=p7r+f0LkPccDKq/NJvwc76R6T4nrOCjOjGSSGsperG1slO5URGCH+/qZZiPHwO6AijJdkw5oTElw/QRnKJ2nEMfNxD4uAbOfmnumvJCx/2x75zp/bFAkLiOxeuMqtvz2eA3znzuM1rUqB8dt0xmMtoRtGZaObrj5EV4Jr9C84oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136731; c=relaxed/simple;
	bh=WPGXq2rV+SqQbpUMqD9YNjZ2jjtUSAl3Nfvhhth2sE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6nVUFA039ej6zDPTDkbwPFBOm/qKyxgkce1aY38X92g5258Nwt18faHFObIeUyLnchZd0+WfjAYeM1IOeuthKXwbn/YGAUZGjkdUsSPs9JBiGIdF8Yq9+0s1mBoipyhvOYC2q5302xfmEKqHcqSvR239ZMbmhon33iVnnYfLUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=C/Mso+Ar; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707136720; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EPrTp2HaSci14lwoV1Q3t2am9bD2lGmQe7hOOG3fJgk=;
	b=C/Mso+Ar5rA3ddRqyakX7X+iNkgtpf0PIjXj/NlCAqPc3bZwxFgA5dZFPjVPHNuqM2B23cL9mQud2XYkVzLE79uxUcnHEjLEHlw+Bq9pYbwbaYtSpjwpHf0oF5zne2Blcbv7Rrv1XneXeeou7o/gMtn6ozs09wuA5+J8LZIyw30=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W0AY-Un_1707136718;
Received: from 192.168.0.105(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W0AY-Un_1707136718)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 20:38:39 +0800
Message-ID: <88ff7f59-654c-4313-b2db-a926b4ca86b9@linux.alibaba.com>
Date: Mon, 5 Feb 2024 20:38:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: hugetlb: fix hugetlb allocation failure when handling
 freed or in-use hugetlb
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, osalvador@suse.de,
 david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <b2e6ce111400670d8021baf4d7ac524ae78a40d5.1707105047.git.baolin.wang@linux.alibaba.com>
 <ZcCq8L6KpmAs11py@tiehlicka>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZcCq8L6KpmAs11py@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/5/2024 5:31 PM, Michal Hocko wrote:
> On Mon 05-02-24 11:54:17, Baolin Wang wrote:
>> When handling the freed hugetlb or in-use hugetlb, we should ignore the
>> failure of alloc_buddy_hugetlb_folio() to dissolve the old hugetlb successfully,
>> since we did not use the new allocated hugetlb in this 2 cases.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/hugetlb.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 9d996fe4ecd9..212ab331d355 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -3042,9 +3042,8 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
>>   	 * under the lock.
>>   	 */
>>   	new_folio = alloc_buddy_hugetlb_folio(h, gfp_mask, nid, NULL, NULL);
>> -	if (!new_folio)
>> -		return -ENOMEM;
>> -	__prep_new_hugetlb_folio(h, new_folio);
>> +	if (new_folio)
>> +		__prep_new_hugetlb_folio(h, new_folio);
> 
> Is there any reason why you haven't moved the allocation to the only
> branch that actually needs it? I know that we hold hugetlb lock but you

Nope, just did a simple patch to ignore the allocation failure.

> could have easily dropped the lock, allocate a page and then goto retry.
> This would actually save an allocation.

Yes, will do. Thanks.

> Something like this:
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ed1581b670d4..db5f72b94422 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3029,21 +3029,9 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
>   {
>   	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
>   	int nid = folio_nid(old_folio);
> -	struct folio *new_folio;
> +	struct folio *new_folio = NULL;
>   	int ret = 0;
>   
> -	/*
> -	 * Before dissolving the folio, we need to allocate a new one for the
> -	 * pool to remain stable.  Here, we allocate the folio and 'prep' it
> -	 * by doing everything but actually updating counters and adding to
> -	 * the pool.  This simplifies and let us do most of the processing
> -	 * under the lock.
> -	 */
> -	new_folio = alloc_buddy_hugetlb_folio(h, gfp_mask, nid, NULL, NULL);
> -	if (!new_folio)
> -		return -ENOMEM;
> -	__prep_new_hugetlb_folio(h, new_folio);
> -
>   retry:
>   	spin_lock_irq(&hugetlb_lock);
>   	if (!folio_test_hugetlb(old_folio)) {
> @@ -3073,6 +3061,15 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
>   		cond_resched();
>   		goto retry;
>   	} else {
> +
> +		if (!new_folio) {
> +			spin_unlock_irq(&hugetlb_lock);
> +			new_folio = alloc_buddy_hugetlb_folio(h, gfp_mask, nid, NULL, NULL);
> +			if (!new_folio)
> +				return -ENOMEM;
> +			__prep_new_hugetlb_folio(h, new_folio);
> +			goto retry;
> +		}
>   		/*
>   		 * Ok, old_folio is still a genuine free hugepage. Remove it from
>   		 * the freelist and decrease the counters. These will be
> @@ -3100,9 +3097,11 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
>   
>   free_new:
>   	spin_unlock_irq(&hugetlb_lock);
> -	/* Folio has a zero ref count, but needs a ref to be freed */
> -	folio_ref_unfreeze(new_folio, 1);
> -	update_and_free_hugetlb_folio(h, new_folio, false);
> +	if (new_folio) {
> +		/* Folio has a zero ref count, but needs a ref to be freed */
> +		folio_ref_unfreeze(new_folio, 1);
> +		update_and_free_hugetlb_folio(h, new_folio, false);
> +	}
>   
>   	return ret;
>   }

