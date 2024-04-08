Return-Path: <linux-kernel+bounces-135154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C79E89BBC1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE9B1F219D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47844EB3C;
	Mon,  8 Apr 2024 09:32:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D1F4E1BE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712568723; cv=none; b=E2yLuLEsmZqm/3/CgAuDpaTGDNrga2vHIdAmw4/voEcPFh2FayktCGaB7kMSuEExUJs3hBK2mWKXjb30ty3xo6RWSbseXTnY3mkJzJioZK/dd2WV7i14YmTwWRZd3zX4D2Unw2LO5irAj/Q/NpgrI5gPW0mQCOtHd6D6zFP/bwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712568723; c=relaxed/simple;
	bh=AUaPVnuSfJpVtVo2zwvpnfKznV2o5PAdSasSe2Vn65s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWtckrFpynW2mYw1Gjio+/wIg9rk/DgOm414QqaU+KfoRkL1as1Ly67j5eRHCodtKVPe7EDj9gav55BeRlbxXj8D34UbAb/mi+5BjT6b0f7lx1wL35NA+fwtmgZekNw/Ca6aF3O2g4oZHsYHhHkb2fBDFPxTPd/Ql2mPuEQ6BRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEB991007;
	Mon,  8 Apr 2024 02:32:31 -0700 (PDT)
Received: from [10.57.73.169] (unknown [10.57.73.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 693B13F766;
	Mon,  8 Apr 2024 02:31:59 -0700 (PDT)
Message-ID: <47eccc1b-71a2-43f3-8d44-7d26c6ddd4f0@arm.com>
Date: Mon, 8 Apr 2024 10:31:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] mm: vmscan: Avoid split during shrink_folio_list()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>
References: <20240403114032.1162100-1-ryan.roberts@arm.com>
 <20240403114032.1162100-6-ryan.roberts@arm.com>
 <6653ce52-53a2-4d91-b98f-50f1608ae59c@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <6653ce52-53a2-4d91-b98f-50f1608ae59c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/04/2024 11:42, David Hildenbrand wrote:
> On 03.04.24 13:40, Ryan Roberts wrote:
>> Now that swap supports storing all mTHP sizes, avoid splitting large
>> folios before swap-out. This benefits performance of the swap-out path
>> by eliding split_folio_to_list(), which is expensive, and also sets us
>> up for swapping in large folios in a future series.
>>
>> If the folio is partially mapped, we continue to split it since we want
>> to avoid the extra IO overhead and storage of writing out pages
>> uneccessarily.
>>
>> THP_SWPOUT and THP_SWPOUT_FALLBACK counters should continue to count
>> events only for PMD-mappable folios to avoid user confusion. THP_SWPOUT
>> already has the appropriate guard. Add a guard for THP_SWPOUT_FALLBACK.
>> It may be appropriate to add per-size counters in future.
>>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   mm/vmscan.c | 17 +++++++++++------
>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 00adaf1cb2c3..ffc4553c8615 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1223,11 +1223,12 @@ static unsigned int shrink_folio_list(struct list_head
>> *folio_list,
>>                       if (!can_split_folio(folio, NULL))
>>                           goto activate_locked;
>>                       /*
>> -                     * Split folios without a PMD map right
>> -                     * away. Chances are some or all of the
>> -                     * tail pages can be freed without IO.
>> +                     * Split partially mapped folios right
>> +                     * away. We can free the unmapped pages
>> +                     * without IO.
>>                        */
>> -                    if (!folio_entire_mapcount(folio) &&
>> +                    if (data_race(!list_empty(
>> +                        &folio->_deferred_list)) &&
> 
> Please violate the 80 chars rule where reasonable.
> 
> "
> Statements longer than 80 columns should be broken into sensible chunks, unless
> exceeding 80 columns significantly increases readability and does not hide
> information.
> "
> 
> 
> Likely some of that code here should be refactored into readable sub-functions.
> 
> codingstyle also mentions
> 
> "The answer to that is that if you need more than 3 levels of indentation,
> you're screwed anyway, and should fix your program."
> 

Boo! :)

Yeah, no problem, I'll sort this.

