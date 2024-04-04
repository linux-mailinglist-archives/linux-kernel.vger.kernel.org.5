Return-Path: <linux-kernel+bounces-131404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF84A89872F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FD36B255A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1AC1272B5;
	Thu,  4 Apr 2024 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PGfGwHMq"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F691272AA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233181; cv=none; b=l3/iwYthwT3z3aCzQjLIg7OkqWt9qpZ0kxroaOt9A7lZCVrMlPI+Osh+2BWglMT5wu1VWxF03gXYj+w9BhljcI5e5Qq41FnFa3e31iomaluUdpmJ/3ecWGgkWC5CjoEtASsFe4ThMqOaSFpuK9g3M8mx+tzTpbo6PKUQKoFbZWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233181; c=relaxed/simple;
	bh=YO48f1x2NlrJ3K2FnhVJkv7sNaC0Wo8Yk9d5hK3zOpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=st0NgRdGEhjcpw1skr6cL9paTyBjugws0U3Z5HsXU6b+RzAoYRjdoVyvrBLX5DWBV9y8h0hGxZ7C3r6Qih2MamuMTZAEr7eGKrdRGJUqDtM2kdkQJyzTu9B30LrWt5dMsAj321RxPqeBSTfLvLWkIBpRwQLH/TPN3hCDab5ShNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PGfGwHMq; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712233170; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Q/Xj/NVp/iPCOrj04cewJTw2OUemfY9s87BaeSgWeRk=;
	b=PGfGwHMqG5gTx/ZZllWF15VkTPI0l69OgCj0Q58aKo19uuAIyxwaRyCnqQDOly5zLR5bytPVjiVs+8htOkmh0bml3O9ovuh+J1OZoARSAPoQytDjt/sUEu9B9Lcwib1V+mJK4g45lasH6c6DhLCvbNpkezlSHliUEW5+XrymLOE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W3uSCUF_1712233169;
Received: from 30.120.150.29(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W3uSCUF_1712233169)
          by smtp.aliyun-inc.com;
          Thu, 04 Apr 2024 20:19:30 +0800
Message-ID: <30bef3d6-3381-491e-a00a-bd1fb7e8d8f8@linux.alibaba.com>
Date: Thu, 4 Apr 2024 20:19:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: page_alloc: use the correct THP order for THP PCP
To: Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org
Cc: mgorman@techsingularity.net, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <a25c9e14cd03907d5978b60546a69e6aa3fc2a7d.1712151833.git.baolin.wang@linux.alibaba.com>
 <76457ec5-d789-449b-b8ca-dcb6ceb12445@suse.cz>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <76457ec5-d789-449b-b8ca-dcb6ceb12445@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/4 18:03, Vlastimil Babka wrote:
> On 4/3/24 3:47 PM, Baolin Wang wrote:
>> Commit 44042b449872 ("mm/page_alloc: allow high-order pages to be stored
>> on the per-cpu lists") extends the PCP allocator to store THP pages, and
>> it determines whether to cache THP pags in PCP by comparing with pageblock_order.
>> But the pageblock_order is not always equal to THP order, it might also
>> be MAX_PAGE_ORDER, which could prevent PCP from caching THP pages.
>>
>> Therefore, using HPAGE_PMD_ORDER instead to determine the need for caching
>> THP for PCP can fix this issue
>>
>> Fixes: 44042b449872 ("mm/page_alloc: allow high-order pages to be stored on the per-cpu lists")
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> IIUC this happens with CONFIG_HUGETLB_PAGE disabled because HUGETLBFS is
> disabled? But THPs are still enabled? I think there might be more of THP

Right, and seems the Powerpc arch will set pageblock_order via 
set_pageblock_order() when the huge page sizes are variable (not sure if 
this is always equal to THP order).

Moreover, it still does not make sense to use pageblock_order to 
indicate a THP page, especially when we already have HPAGE_PMD_ORDER to 
represent THP.

> working suboptimally in that case with pageblock_order being larger
> (MAX_PAGE_ORDER).
> 
> In other words, should be rather make pageblock_order itself defined as
> 
>   min_t(unsigned int, HPAGE_PMD_ORDER, MAX_PAGE_ORDER)
> 
> in case with !CONFIG_HUGETLB_PAGE but THP enabled.

Yes, this makes sense to me (I wonder why this wasn't done before?). I 
can create a seperate patch to do this, what do you think? Thanks.

