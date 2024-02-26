Return-Path: <linux-kernel+bounces-81425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FD18675CC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5C31F27FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F96F81213;
	Mon, 26 Feb 2024 12:57:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD5360860
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952251; cv=none; b=DzDbRE5rhA9jSV34pTvDO0gbEFdivC7nvlxyxz2ldRSdv1wiaPgGv/C0YfRQ5G+RPswNJ8rpV6JlXsikqp3dLU9FlysXdo1Fj0esN3oHnRzL0/IvMAEsmdzJDDfMhk4gDQ/G841/0hxCm8xuNFEQilSYYWSj7PM5rVBhFfgp1rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952251; c=relaxed/simple;
	bh=bQkPpPdoYscWgotFsktdxtN3TegKdT+lBcuCShzGxlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDZJYf3ii+PCZ6b6XtWD7E4VYPPvqDiw5FsQCgzSLw2IuwvMhW44SsSjMY7c4uEZWsfznzuT0V55LlzqSxvn37PBW0dxOE54Rtg4Y7bjGvoTqhmYzEspeN759/Mv/xt086/wQshs6WQLruvkG49lhw39tr/LooTZs9RlA4igvXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EA2DDA7;
	Mon, 26 Feb 2024 04:58:07 -0800 (PST)
Received: from [10.57.67.4] (unknown [10.57.67.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40F243F762;
	Mon, 26 Feb 2024 04:57:25 -0800 (PST)
Message-ID: <8b909691-ca53-43b9-aab1-dba3ef3577cd@arm.com>
Date: Mon, 26 Feb 2024 12:57:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in
 madvise_free
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>, fengwei.yin@intel.com
Cc: akpm@linux-foundation.org, david@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 minchan@kernel.org, peterx@redhat.com, shy828301@gmail.com,
 songmuchun@bytedance.com, wangkefeng.wang@huawei.com, zokeefe@google.com,
 21cnbao@gmail.com
References: <df416acb-d913-4e67-b810-cd991003242e@intel.com>
 <20240226083526.26002-1-ioworker0@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240226083526.26002-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/02/2024 08:35, Lance Yang wrote:
> Hey Fengwei,
> 
> Thanks for taking time to review!
> 
>> On Mon, Feb 26, 2024 at 10:38 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>> On Sun, Feb 25, 2024 at 8:32 PM Lance Yang <ioworker0@gmail.com> wrote:
> [...]
>>> --- a/mm/madvise.c
>>> +++ b/mm/madvise.c
>>> @@ -676,11 +676,43 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>>>                */
>>>               if (folio_test_large(folio)) {
>>>                       int err;
>>> +                     unsigned long next_addr, align;
>>>
>>> -                     if (folio_estimated_sharers(folio) != 1)
>>> -                             break;
>>> -                     if (!folio_trylock(folio))
>>> -                             break;
>>> +                     if (folio_estimated_sharers(folio) != 1 ||
>>> +                         !folio_trylock(folio))
>>> +                             goto skip_large_folio;
>>> +
>>> +                     align = folio_nr_pages(folio) * PAGE_SIZE;
>>> +                     next_addr = ALIGN_DOWN(addr + align, align);
>> There is a possible corner case:
>> If there is a cow folio associated with this folio and the cow folio
>> has smaller size than this folio for whatever reason, this change can't
>> handle it correctly.
> 
> Thanks for pointing that out; it's very helpful to me!
> I made some changes. Could you please check if this corner case is now resolved?
> 
> As a diff against this patch.
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index bcbf56595a2e..c7aacc9f9536 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -686,10 +686,12 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  			next_addr = ALIGN_DOWN(addr + align, align);
>  
>  			/*
> -			 * If we mark only the subpages as lazyfree,
> -			 * split the large folio.
> +			 * If we mark only the subpages as lazyfree, or
> +			 * if there is a cow folio associated with this folio,
> +			 * then split the large folio.
>  			 */
> -			if (next_addr > end || next_addr - addr != align)
> +			if (next_addr > end || next_addr - addr != align ||
> +			    folio_total_mapcount(folio) != folio_nr_pages(folio))

I still don't think this is correct. I think you were previously assuming that
if you see a page from a large folio then the whole large folio should be
contiguously mapped? This new check doesn't validate that assumption reliably;
you need to iterate through every pte to generate a batch, like David does in
folio_pte_batch() for this to be safe.

An example of when this check is insufficient; let's say you have a 4 page anon
folio mapped contiguously in a process (total_mapcount=4). The process is forked
(total_mapcount=8). Then each process munmaps the second 2 pages
(total_mapcount=4). In place of the munmapped 2 pages, 2 new pages are mapped.
Then call madvise. It's probably even easier to trigger for file-backed memory
(I think this code path is used for both file and anon?)

Thanks,
Ryan




>  				goto split_large_folio;
>  
>  			/*
> ---
> 
> Thanks again for your time!
> 
> Best,
> Lance


