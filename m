Return-Path: <linux-kernel+bounces-148353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C86E8A8150
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9051F21A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEC013C697;
	Wed, 17 Apr 2024 10:53:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1CD7FBD2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351195; cv=none; b=K6MYS10a3Ohf7WlzOpi1RpBPHoFTyfJsWQ0FfA/yeUW0d+h/r8rsxvZyhJuUam4X2No+dh3krzgL7IAyimkCQ0QjvrlS3Wf07La1o/Fz+NTE/WZOHbx/9zKuDe40q+ZPdXTUtxIvJLKLD0UvzJ2ATk3hpM0fQVLhNBFi8I9cQhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351195; c=relaxed/simple;
	bh=DvyqV4VNBcgPHLGo6VzuhHCFubdOg2mGm7XN7iu9Z1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7BnKSxDnZ7DhEVLFRt1FC1pJ97RAX3A+XPcfTRHaBFo23Qgi3eOnpI9JqCfcKGu5v595E0duwsMPwq6pjdCWuc+FGHtTOYaFazGMuvh+rJ3WSCAMzWfffGFrhExjjxKJqAuV6DEbbmVVrXnOgHPMJKSOL082hdJ5/HxCD6C8to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDE41339;
	Wed, 17 Apr 2024 03:53:40 -0700 (PDT)
Received: from [10.1.37.181] (XHFQ2J9959.cambridge.arm.com [10.1.37.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F02873F64C;
	Wed, 17 Apr 2024 03:53:10 -0700 (PDT)
Message-ID: <39905c50-a228-4e85-a5de-3b10cae5f2bc@arm.com>
Date: Wed, 17 Apr 2024 11:53:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] mm/madvise: introduce clear_young_dirty_ptes()
 batch helper
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>, David Hildenbrand <david@redhat.com>
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org, fengwei.yin@intel.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 minchan@kernel.org, peterx@redhat.com, shy828301@gmail.com,
 songmuchun@bytedance.com, wangkefeng.wang@huawei.com, xiehuan09@gmail.com,
 zokeefe@google.com
References: <CAK1f24mEoC_Pg7-49G=y7dMUaGhzW11_A5sK0EWVhH6K1kjMMA@mail.gmail.com>
 <20240417050426.66194-1-ioworker0@gmail.com>
 <76d22c08-82db-4ea8-a7cd-c77589e132e3@redhat.com>
 <CAK1f24mFfwXky9Patwmcq-VQ8y1hxcRm8K4B4o0RO+dsr-7Q=A@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAK1f24mFfwXky9Patwmcq-VQ8y1hxcRm8K4B4o0RO+dsr-7Q=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/04/2024 10:01, Lance Yang wrote:
> On Wed, Apr 17, 2024 at 4:19 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 17.04.24 07:04, Lance Yang wrote:
>>> Hey David, Ryan,
>>>
>>> How about this change?
>>>
>>> static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
>>>                                         unsigned long addr, pte_t *ptep,
>>>                                         unsigned int nr, cydp_t flags)
>>> {
>>>       if (flags == CYDP_CLEAR_YOUNG) {
>>>               for (;;) {
>>>                       ptep_test_and_clear_young(vma, addr, ptep);
>>>                       if (--nr == 0)
>>>                               break;
>>>                       ptep++;
>>>                       addr += PAGE_SIZE;
>>>               }
>>>               return;
>>>       }
>>>
>>>       pte_t pte;
>>>
>>>       for (;;) {
>>>               pte = ptep_get_and_clear(vma->vm_mm, addr, ptep);
>>>
>>>               if (flags & CYDP_CLEAR_YOUNG)
>>>                       pte = pte_mkold(pte);
>>>               if (flags & CYDP_CLEAR_DIRTY)
>>>                       pte = pte_mkclean(pte);
>>>
>>>               if (--nr == 0)
>>>                       break;
>>>               ptep++;
>>>               addr += PAGE_SIZE;
>>>       }
>>> }
>>
>> Likely it might be best to just KIS for now and leave it as is. The
>> compiler should optimize out based on flags already, that's what I ignored.
> 
> Got it. Let's keep it as is for now :)

Yep agreed; you're passing the flags as constants so the compiler should be
completely removing one half of the conditional. And if the input isn't a
constant, I'd still expect the compiler to hoist the conditional out of the loop.

> 
> Thanks,
> Lance
> 
>>
>> --
>> Cheers,
>>
>> David / dhildenb
>>


