Return-Path: <linux-kernel+bounces-99942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB71878F82
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4FE1C215B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB6F69D08;
	Tue, 12 Mar 2024 08:12:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A8969957
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710231139; cv=none; b=ADZXzw1FnPrnZwk2nFS/2q1vsmfvhp0viV5hNmq6YHXu0l2St0CI2Z3CFxYqLzYO3HFxVw2GYxrFQPoTLVPbq8E/mwzCCyDpZ9ywHtAtIB/kEB6Peoe1nBfDa5zITHk3AIVTOF55SJcbVQ7tHruQ1FMSkZBSmv0ZzgeXJt85aVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710231139; c=relaxed/simple;
	bh=RcWfibgKx1OlU0pgbXdpfZMGI8EXCw7QZXTdrTUBpgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcBWuoIQNNN3dFEHqY/t2uEJqa4btelt6YX/xFTfY8b69SmVawLc6cXAHzwzGeYX2/ItREaJxSez8ib/tOoYrr0qmz4EEHHu93RjdDD31MHdUDc+c4IFsnupV4toZ8E+gDV5k7ZvBMaPR2s0Wh8W/3Vs6XRK1xLAH1/ooVPU2Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36BCA1007;
	Tue, 12 Mar 2024 01:12:53 -0700 (PDT)
Received: from [10.57.68.246] (unknown [10.57.68.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48CD73F73F;
	Tue, 12 Mar 2024 01:12:13 -0700 (PDT)
Message-ID: <b9200ea1-c555-40c0-b748-c449ac6bebc2@arm.com>
Date: Tue, 12 Mar 2024 08:12:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] mm: vmscan: Avoid split during shrink_folio_list()
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>,
 Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Chris Li <chrisl@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-6-ryan.roberts@arm.com>
 <CAGsJ_4zq4jdDdG6Cne6SESSmJQJnGwaQF5y3BHOaLHFdED0zYg@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4zq4jdDdG6Cne6SESSmJQJnGwaQF5y3BHOaLHFdED0zYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/03/2024 22:30, Barry Song wrote:
> On Mon, Mar 11, 2024 at 11:01 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Now that swap supports storing all mTHP sizes, avoid splitting large
>> folios before swap-out. This benefits performance of the swap-out path
>> by eliding split_folio_to_list(), which is expensive, and also sets us
>> up for swapping in large folios in a future series.
>>
>> If the folio is partially mapped, we continue to split it since we want
>> to avoid the extra IO overhead and storage of writing out pages
>> uneccessarily.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  mm/vmscan.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index cf7d4cf47f1a..0ebec99e04c6 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1222,11 +1222,12 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>                                         if (!can_split_folio(folio, NULL))
>>                                                 goto activate_locked;
>>                                         /*
>> -                                        * Split folios without a PMD map right
>> -                                        * away. Chances are some or all of the
>> -                                        * tail pages can be freed without IO.
>> +                                        * Split partially mapped folios map
>> +                                        * right away. Chances are some or all
>> +                                        * of the tail pages can be freed
>> +                                        * without IO.
>>                                          */
>> -                                       if (!folio_entire_mapcount(folio) &&
>> +                                       if (!list_empty(&folio->_deferred_list) &&
> 
> Hi Ryan,
> After reconsidering our previous discussion about PMD-mapped large
> folios, I've pondered
> the possibility of PMD-mapped Transparent Huge Pages (THPs) being
> mapped by multiple
> processes. In such a scenario, if one process decides to unmap a
> portion of the folio while
> others retain the entire mapping, it raises questions about how the
> system should handle
> this situation. Would the large folio be placed in a deferred list? 

No - if the large folio is entirely mapped (via PMD), then the folio will not be
put on the deferred split list in the first place. See __folio_remove_rmap():

	last = (last < ENTIRELY_MAPPED);

means that nr will never be incremented above 0. (_nr_pages_mapped is
incremented by ENTIRELY_MAPPED for every PMD map).

> If
> so, splitting it might not
> yield benefits, as neither I/O nor swap slots would increase in this
> case by not splitting it.
> 
> Regarding PTE-mapped large folios, the absence of an indicator like
> "entire_map" makes it
> challenging to identify cases where the entire folio is mapped. Thus,
> splitting seems to be
> the only viable solution in such circumstances.
> 
>>                                             split_folio_to_list(folio,
>>                                                                 folio_list))
>>                                                 goto activate_locked;
>> --
>> 2.25.1
> 
> Thanks
> Barry


