Return-Path: <linux-kernel+bounces-93473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F06873049
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489951C243C5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5153D5D486;
	Wed,  6 Mar 2024 08:10:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975A15CDFE;
	Wed,  6 Mar 2024 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712644; cv=none; b=GoiK2d+GNxg+RZdH71Egsao2D1Qk55sRUVKO6uNLeoV6Nhg+KcmgXgQqKNkuU2K+rITNp7vpZmlYGEx10mYPYRF111EnN/LjMGQTWsJCYM2KDfFSXNoHgOtJ0dtVIkhZrjZKxx1mT/CLh44sM2SZjm4F1Bl6GwOt6UdWEt7KTlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712644; c=relaxed/simple;
	bh=QuTzfsq5qFtEQmqZsy9/Pelr0yam13hCPofh5Culf34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUuMvmOUsH2qStB21sGfRL3d64xbmij6+WRQSb1Us5B+3aqte9MK7ltqruXFjF3FhsX/pfMM9aQe4h4/k7HqZLS8Eit/iyc7pdkn+Y8syb06FoLk4lscIaaS3GwUsRUw092Kc/D3adhvP0N1jfc7h5U1adbqvy3I3lFjSUql3w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5B4C1FB;
	Wed,  6 Mar 2024 00:11:17 -0800 (PST)
Received: from [10.57.68.241] (unknown [10.57.68.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C8943F762;
	Wed,  6 Mar 2024 00:10:39 -0800 (PST)
Message-ID: <ae4bc850-3522-42d8-9446-add13d9368da@arm.com>
Date: Wed, 6 Mar 2024 08:10:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: swap: Fix race between free_swap_and_cache() and
 swapoff()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying"
 <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240305151349.3781428-1-ryan.roberts@arm.com>
 <cb738797-77d9-4e20-a54c-f70385cdbd95@redhat.com>
 <8989df79-84f5-488c-bd74-c11d2241eff1@arm.com>
 <017414bc-78cd-4aa1-9edf-6ce947b9e4e4@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <017414bc-78cd-4aa1-9edf-6ce947b9e4e4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/03/2024 22:05, David Hildenbrand wrote:
> On 05.03.24 17:33, Ryan Roberts wrote:
>> On 05/03/2024 15:50, David Hildenbrand wrote:
>>> On 05.03.24 16:13, Ryan Roberts wrote:
>>>> There was previously a theoretical window where swapoff() could run and
>>>> teardown a swap_info_struct while a call to free_swap_and_cache() was
>>>> running in another thread. This could cause, amongst other bad
>>>> possibilities, swap_page_trans_huge_swapped() (called by
>>>> free_swap_and_cache()) to access the freed memory for swap_map.
>>>>
>>>> This is a theoretical problem and I haven't been able to provoke it from
>>>> a test case. But there has been agreement based on code review that this
>>>> is possible (see link below).
>>>>
>>>> Fix it by using get_swap_device()/put_swap_device(), which will stall
>>>> swapoff(). There was an extra check in _swap_info_get() to confirm that
>>>> the swap entry was valid. This wasn't present in get_swap_device() so
>>>> I've added it. I couldn't find any existing get_swap_device() call sites
>>>> where this extra check would cause any false alarms.
>>>>
>>>> Details of how to provoke one possible issue (thanks to David Hilenbrand
>>>> for deriving this):
>>>
>>> Almost
>>>
>>> "s/Hilenbrand/Hildenbrand/" :)
>>
>> Ahh sorry... I even explicitly checked it against your name on emails... fat
>> fingers...
> 
> No need to be sorry. Even your average German person would get it wrong,
> because there are other (more common) variants :)
> 
> [...]
> 
>>>>
>>>
>>> LGTM
>>>
>>> Are you planning on sending a doc extension for get_swap_device()?
>>
>> I saw your comment:
>>
>> We should likely update the documentation of get_swap_device(), that after
>> decrementing the refcount, the SI might become stale and should not be touched
>> without a prior get_swap_device().
>>
>> But when I went to make the changes, I saw the documentation already said:
>>
>> ...we need to enclose all swap related functions with get_swap_device() and
>> put_swap_device()... Notice that swapoff ... can still happen before the
>> percpu_ref_tryget_live() in get_swap_device() or after the percpu_ref_put() in
>> put_swap_device()... The caller must be prepared for that.
>>
>> I thought that already covered it? I'm sure as usual, I've misunderstood your
>> point. Happy to respin if you have something in mind?
> 
> No need to respin, we could clarify on top, if we decide it makes sense.
> 
> I was thinking about something like this, making it clearer that the PTL
> discussion above does not express the corner case we discovered:
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 2b3a2d85e350b..646a436581eee 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1232,6 +1232,11 @@ static unsigned char __swap_entry_free_locked(struct
> swap_info_struct *p,
>   * with get_swap_device() and put_swap_device(), unless the swap
>   * functions call get/put_swap_device() by themselves.
>   *
> + * Note that when only holding the PTL, swapoff might succeed immediately
> + * after freeing a swap entry. Therefore, immediately after
> + * __swap_entry_free(), the swap info might become stale and should not
> + * be touched without a prior get_swap_device().
> + *

Are yes, this is useful. I'm going to have to respin anyway, so will include it
in the next version. Thanks!


>   * Check whether swap entry is valid in the swap device.  If so,
>   * return pointer to swap_info_struct, and keep the swap entry valid
>   * via preventing the swap device from being swapoff, until
> 
> 


