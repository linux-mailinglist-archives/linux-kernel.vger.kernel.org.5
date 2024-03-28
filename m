Return-Path: <linux-kernel+bounces-122597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 275F788FA3D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2061F277C7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D824F616;
	Thu, 28 Mar 2024 08:48:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B915724219
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615693; cv=none; b=twOj0PB0k6vxDq0NsjQls8pgUWBCLPlDwU9dzll7Xaxj7gw22Ly7BSYna4GaY1hTV6Vw3kx9pt2qwPX5qEiVZPbQ1vw9BlJ7WpsSi1Wg1ICWRLpZh8ORLngIZ83nj1xFx+pOogVr5NPNVMQLutyM+m/m6dwBsnt4YyOTUD+bhH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615693; c=relaxed/simple;
	bh=jmmqgYh4xhYWdZhCBFwvyvxclQIee8SJpDjlrL/T+nE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j962ADfKHLFmeBKwqz6G4dg3ZbgrFhumeAO4nF6cyRlPY97nF2WqnPiU16qEcqoniayXRTEhXYEXQuZMNqJ/+86793rk+edeFZAd0WRLa7ltq2iwZKtRtj6Aq8JwVbifVzqrWLrynaNaoRb3nTqy5+teCJhhY5ttD5f6nGM3R3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 015E12F4;
	Thu, 28 Mar 2024 01:48:45 -0700 (PDT)
Received: from [10.57.72.121] (unknown [10.57.72.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA9463F64C;
	Thu, 28 Mar 2024 01:48:08 -0700 (PDT)
Message-ID: <8d28bf39-041b-40f0-90dd-332e69f6c50d@arm.com>
Date: Thu, 28 Mar 2024 08:48:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] mm: vmscan: Avoid split during shrink_folio_list()
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>,
 Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Chris Li <chrisl@kernel.org>, Lance Yang <ioworker0@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>
References: <20240327144537.4165578-1-ryan.roberts@arm.com>
 <20240327144537.4165578-6-ryan.roberts@arm.com>
 <CAGsJ_4x40DxoukgRuEt3OKP7dESj3w+HXz=dHYR+PH8LjtCnEA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4x40DxoukgRuEt3OKP7dESj3w+HXz=dHYR+PH8LjtCnEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/03/2024 08:18, Barry Song wrote:
> On Thu, Mar 28, 2024 at 3:45 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
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
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  mm/vmscan.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 00adaf1cb2c3..293120fe54f3 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1223,11 +1223,12 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>                                         if (!can_split_folio(folio, NULL))
>>                                                 goto activate_locked;
>>                                         /*
>> -                                        * Split folios without a PMD map right
>> -                                        * away. Chances are some or all of the
>> -                                        * tail pages can be freed without IO.
>> +                                        * Split partially mapped folios right
>> +                                        * away. We can free the unmapped pages
>> +                                        * without IO.
>>                                          */
>> -                                       if (!folio_entire_mapcount(folio) &&
>> +                                       if (data_race(!list_empty(
>> +                                               &folio->_deferred_list)) &&
>>                                             split_folio_to_list(folio,
>>                                                                 folio_list))
>>                                                 goto activate_locked;
> 
> Hi Ryan,
> 
> Sorry for bringing up another minor issue at this late stage.
> 
> During the debugging of thp counter patch v2, I noticed the discrepancy between
> THP_SWPOUT_FALLBACK and THP_SWPOUT.

Ahh good spot! I had noticed this previously and clearly forgot all about it.

I'm on holiday today and over the long weekend in the UK. I'll take a proper
look next week and send a fix.

> 
> Should we make adjustments to the counter?
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 293120fe54f3..d7856603f689 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1241,8 +1241,10 @@ static unsigned int shrink_folio_list(struct
> list_head *folio_list,
>                                                                 folio_list))
>                                                 goto activate_locked;
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -
> count_memcg_folio_events(folio, THP_SWPOUT_FALLBACK, 1);
> -                                       count_vm_event(THP_SWPOUT_FALLBACK);
> +                                       if (folio_test_pmd_mappable(folio)) {
> +
> count_memcg_folio_events(folio, THP_SWPOUT_FALLBACK, 1);
> +
> count_vm_event(THP_SWPOUT_FALLBACK);
> +                                       }
>  #endif
>                                         if (!add_to_swap(folio))
>                                                 goto activate_locked_split;
> 
> 
> Because THP_SWPOUT is only for pmd:
> 
> static inline void count_swpout_vm_event(struct folio *folio)
> {
> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         if (unlikely(folio_test_pmd_mappable(folio))) {
>                 count_memcg_folio_events(folio, THP_SWPOUT, 1);
>                 count_vm_event(THP_SWPOUT);
>         }
> #endif
>         count_vm_events(PSWPOUT, folio_nr_pages(folio));
> }
> 
> I can provide per-order counters for this in my THP counter patch.
> 
>> --
>> 2.25.1
>>
> 
> Thanks
> Barry


