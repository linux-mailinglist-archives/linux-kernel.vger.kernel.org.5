Return-Path: <linux-kernel+bounces-140997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922978A1A05
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04B21C21A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4501C127E;
	Thu, 11 Apr 2024 15:38:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FD61C124F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849879; cv=none; b=kdRI0GzvVZm4iDBTS9jTC+ADFMQ4PxaHGvghkxmYcfTSVttF1wVg+17sI5gv73JH7QYwfT1C0nYtnC8fZsBxudcENDAaF/CJEiLQjEMqFXkIyDE3AAFonp4WGraSzk9CVMqyYSN88pSfjojdend/JxvWtvyhnnUxyZLSoFjEkhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849879; c=relaxed/simple;
	bh=MAMYui+jp1n4vPA6ZwebIUQNWsmP7XShJzR/yynCjEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgWte94ir1gGqZLXSlyK4iCeFkBaWXq/Fu7uB0aOSYbpKakFsVE6Wnp4Iw3OD7x3uTAV4XvLvaVnqOHtVlojzGH0VGlvCJD3jB2mWYgD/oc4YRrO5lAwfA3V77OAzTKkM1wulxhJwXYNtz8EYS9CubP01J6q2vYzasKVDe+S+Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EB48113E;
	Thu, 11 Apr 2024 08:38:27 -0700 (PDT)
Received: from [10.1.38.151] (XHFQ2J9959.cambridge.arm.com [10.1.38.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBD303F6C4;
	Thu, 11 Apr 2024 08:37:56 -0700 (PDT)
Message-ID: <ac5ebf6d-fbe2-4354-8a9d-8f269dfd3a1a@arm.com>
Date: Thu, 11 Apr 2024 16:37:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: mm: Don't remap pgtables for allocate vs
 populate
Content-Language: en-GB
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, David Hildenbrand <david@redhat.com>,
 Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Itaru Kitayama <itaru.kitayama@fujitsu.com>
References: <20240404143308.2224141-1-ryan.roberts@arm.com>
 <20240404143308.2224141-4-ryan.roberts@arm.com>
 <ZhffSyrqCQsMV2pG@FVFF77S0Q05N>
 <37d4c278-3780-49ce-bd7e-e8f2ff4501fd@arm.com>
 <Zhf4LqNhQFN8ezx1@FVFF77S0Q05N>
 <d9582c0e-af24-46a1-9c3e-b9dc68af20d8@arm.com>
 <ZhgA8WDkZDbYIDHg@FVFF77S0Q05N>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZhgA8WDkZDbYIDHg@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/04/2024 16:25, Mark Rutland wrote:
> On Thu, Apr 11, 2024 at 03:57:04PM +0100, Ryan Roberts wrote:
>> On 11/04/2024 15:48, Mark Rutland wrote:
>>> On Thu, Apr 11, 2024 at 02:37:49PM +0100, Ryan Roberts wrote:
>>>> On 11/04/2024 14:02, Mark Rutland wrote:
>>>>> but the logic remains fairly simple, and I suspect the overhead for late
>>>>> allocations might not matter since the bulk of late changes are non-allocating.
>>>>
>>>> Its just the fixmap overhead that remains...
>>>
>>> True; my thinking there is that almost all of the later changes are for smaller
>>> ranges than the linear map (~10s of MB vs GBs in your test data), so I'd expect
>>> the overhead of those to be dominated by the cost of mappin the linear map.
>>>
>>> The only big exception is arch_add_memory(), but memory hotplug is incredibly
>>> rare, and we're not making it massively slower than it already was...
>>
>> What about something like coco guest mem (or whatever its called). Isn't that
>> scrubbed out of the linear map? So if a coco VM is started with GBs of memory,
>> could that be a real case we want to optimize?
> 
> I think that's already handled -- the functions we have to carve portions out
> of the linear map use apply_to_page_range(), which doesn't use the fixmap. See
> set_memory_*() and set_direct_map_*() in arch/arm64/mm/pageattr.c.

Ahh gottya. Yet another table walker :)

> 
> Note that apply_to_page_range() does what its name implies and *only* handles
> mappings at page granularity. Hence not using that for
> mark_linear_text_alias_ro() and mark_rodata_ro() which need to be able to
> handle blocks.
> 
> Mark.


