Return-Path: <linux-kernel+bounces-54135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3F684AB58
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86ACE1F250A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17201361;
	Tue,  6 Feb 2024 01:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TDUMdJAx"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C44ED9
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707181285; cv=none; b=BmwFBS2R/PhImYOv/TF/oSRijMK1jLkJOqmiouOWTjt5jW+LWUWc4ewlqMNZPlTXDGa/q6eWx2kHwgYOo3Fj9qRRsgF0nkb8pihnPNzLdDEhw2KvZkeV2VQ0kv4J/6EnWAlW59cazbMXaOr05m5T1oyeZnFJ8ikPepe7sJhT3WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707181285; c=relaxed/simple;
	bh=EUuJIRIUy9jg+QIqT5SRBnRdaBUOh2gHEYKFd8kswzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c4YJ+4zTI7kxybZI22tXVPRPfr0SlmLqH6blcQf9zFHbhhZkfIdLvuVHgPqgCZ2r96FrOdG2oPk50ui4RhwQQjhxFxSyy5oc7g+hYY6i6MP2YDKIyQ0xQ1lxVIGvFiK+HP1CJSgK1QmcmnOYTLqJXauxKR84ThL2YaPHKu5QLUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TDUMdJAx; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707181275; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7c1tboIXd34qXTIIwjvuY/4rNTG1OWDCX7nIPdrejzY=;
	b=TDUMdJAxUIpcwbEv/c9d1XRKgMjMnO7r8If4DEl0qLh5ko3N/DEc26YkkI4a+TKjnKNnYDOQjCcStziw/is3hSxFttBHxOKqkzU4NHGJKJdDbi+wCbfF2fqXdaPqqJX2LbXCWAAeXeuWAqM5X5l7xaJIZcGrmN2BV6IaA3NZoPU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W0Bns7B_1707181273;
Received: from 30.97.56.40(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W0Bns7B_1707181273)
          by smtp.aliyun-inc.com;
          Tue, 06 Feb 2024 09:01:14 +0800
Message-ID: <1ecddd3f-957f-4dad-90e3-cb820bbe36ec@linux.alibaba.com>
Date: Tue, 6 Feb 2024 09:01:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: hugetlb: improve the handling of hugetlb
 allocation failure for freed or in-use hugetlb
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, osalvador@suse.de,
 david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <23814ccce5dd3cd30fd67aa692fd0bf3514b0166.1707137359.git.baolin.wang@linux.alibaba.com>
 <ZcD1A3gj-Net_I9b@tiehlicka>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZcD1A3gj-Net_I9b@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/5/2024 10:47 PM, Michal Hocko wrote:
> On Mon 05-02-24 20:50:51, Baolin Wang wrote:
>> When handling the freed hugetlb or in-use hugetlb, we should ignore the
>> failure of alloc_buddy_hugetlb_folio() to dissolve the old hugetlb successfully,
>> since we did not use the new allocated hugetlb in this 2 cases. Moreover,
>> moving the allocation into the free hugetlb handling branch.
> 
> The changelog is a bit hard for me to understand. What about the
> following instead?
> alloc_and_dissolve_hugetlb_folio preallocates a new huge page before it
> takes hugetlb_lock. In 3 out of 4 cases the page is not really used and
> therefore the newly allocated page is just freed right away. This is
> wasteful and it might cause pre-mature failures in those cases.
> 
> Address that by moving the allocation down to the only case (hugetlb
> page is really in the free pages pool). We need to drop hugetlb_lock
> to do so and therefore need to recheck the page state after regaining
> it.
> 
> The patch is more of a cleanup than an actual fix to an existing
> problem. There are no known reports about pre-mature failures.

Looks better. Thanks.

>> @@ -3075,6 +3063,24 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
>>   		cond_resched();
>>   		goto retry;
>>   	} else {
>> +		if (!new_folio) {
>> +			spin_unlock_irq(&hugetlb_lock);
>> +			/*
>> +			 * Before dissolving the free hugetlb, we need to allocate
>> +			 * a new one for the pool to remain stable.  Here, we
>> +			 * allocate the folio and 'prep' it by doing everything
>> +			 * but actually updating counters and adding to the pool.
>> +			 * This simplifies and let us do most of the processing
>> +			 * under the lock.
>> +			 */
> 
> This comment is not really needed anymore IMHO.

Acked.

> 
>> +			new_folio = alloc_buddy_hugetlb_folio(h, gfp_mask, nid,
>> +							      NULL, NULL);
>> +			if (!new_folio)
>> +				return -ENOMEM;
>> +			__prep_new_hugetlb_folio(h, new_folio);
>> +			goto retry;
>> +		}
>> +
>>   		/*
>>   		 * Ok, old_folio is still a genuine free hugepage. Remove it from
>>   		 * the freelist and decrease the counters. These will be
> 

