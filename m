Return-Path: <linux-kernel+bounces-23031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F02682A67F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283961F22231
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B74111C;
	Thu, 11 Jan 2024 03:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sFkAxDeI"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BC5EC0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fd43393e-b4db-4a12-84ee-0f045071c119@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704943880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0dgdoE6OzasbBRrKE1GhrUB+ZWb0Jou+J+d3JWPw3A=;
	b=sFkAxDeItSQnYqjjK7nh77pjlOZPi4bghgbIuwWh+6moNF/AdeGybgkMoLeIUVU57ogIrO
	xH7JiAyPRSSWZ6GbuIcVnfrsDIHfCmdmRi2Hf//9g6BB5HB71u93xl7MpWbZV3yz4NEsLh
	n0G5Q0kDJc3ytVFSQsFOdWyTKRFYnhY=
Date: Thu, 11 Jan 2024 11:30:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/7] hugetlb: code clean for hugetlb_hstate_alloc_pages
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com, David Hildenbrand <david@redhat.com>,
 David Rientjes <rientjes@google.com>, Mike Kravetz
 <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
References: <20240102131249.76622-1-gang.li@linux.dev>
 <20240102131249.76622-2-gang.li@linux.dev>
 <73111be3-3077-4821-8c2f-9c5564cb2bb7@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <73111be3-3077-4821-8c2f-9c5564cb2bb7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2024/1/10 18:19, Muchun Song wrote:
> 
> 
> On 2024/1/2 21:12, Gang Li wrote:
>> The readability of `hugetlb_hstate_alloc_pages` is poor. By cleaning the
>> code, its readability can be improved, facilitating future modifications.
>>
>> This patch extracts two functions to reduce the complexity of
>> `hugetlb_hstate_alloc_pages` and has no functional changes.
>>
>> - hugetlb_hstate_alloc_pages_node_specific() to handle iterates through
>>    each online node and performs allocation if necessary.
>> - hugetlb_hstate_alloc_pages_report() report error during allocation.
>>    And the value of h->max_huge_pages is updated accordingly.
>>
>> Signed-off-by: Gang Li <gang.li@linux.dev>
>> ---
>>   mm/hugetlb.c | 46 +++++++++++++++++++++++++++++-----------------
>>   1 file changed, 29 insertions(+), 17 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index ed1581b670d42..2606135ec55e6 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -3482,6 +3482,33 @@ static void __init 
>> hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
>>       h->max_huge_pages_node[nid] = i;
>>   }
>> +static bool __init hugetlb_hstate_alloc_pages_node_specific(struct 
>> hstate *h)
> 
> I'd like to rename this to hugetlb_hstate_alloc_pages_specific_nodes.
> 
> Otherwise, LGTM.
> 
> Reviewed-by: Muchun Song <muchun.song@linux.dev>
> 

Thanks! I will adjust it in the next version.


