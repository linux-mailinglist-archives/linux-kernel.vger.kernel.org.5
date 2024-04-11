Return-Path: <linux-kernel+bounces-140668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F158A178B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0DD1F21DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE4DD52E;
	Thu, 11 Apr 2024 14:39:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33973D27E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846373; cv=none; b=Y1DpRH5XHG65qvnJl9kfGNEOxLjajnvAsE2WRhruDEizIynILRRARMI74uBgwib5uMSe0SqH5Uqx/L96lQ+kNDwTEd5KVUmSRegF1G344nn9wfjAo3G8KTzsxei/1WFcX04B0VwjoIHUdd7DdYfARc+8cAr36yKElKxKd/ePts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846373; c=relaxed/simple;
	bh=wpVJ4kcnxTyWr37eN9VGmFz67NZpAAUXg36BJUBOQ+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcZA318sx05972Dsc3jZdvraySE4znjhZJfVCeXlHKLqsXBBvsNB2FQWrSy9ERLaBUuJ1rxAdYE7xD/Fyx6V/qbTvI8GdGLArbS5SWPyOFYgr2SG6jbcB8OZCSJuQZtYXkwWXfJpw0Wm20GamkxB1k+O2DQtEDFMZbZXS0ICe+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C159339;
	Thu, 11 Apr 2024 07:40:01 -0700 (PDT)
Received: from [10.1.38.151] (XHFQ2J9959.cambridge.arm.com [10.1.38.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2E6C3F64C;
	Thu, 11 Apr 2024 07:39:29 -0700 (PDT)
Message-ID: <8d674b15-ef74-4d96-bc27-8794f744517c@arm.com>
Date: Thu, 11 Apr 2024 15:39:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] mm/madvise: optimize lazyfreeing with mTHP in
 madvise_free
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, 21cnbao@gmail.com,
 mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com,
 shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240408042437.10951-1-ioworker0@gmail.com>
 <20240408042437.10951-2-ioworker0@gmail.com>
 <38c4add8-53a2-49ca-9f1b-f62c2ee3e764@arm.com>
 <CAK1f24kh-vN3_6ZLUZWXu_g1UOPBuoVXq2jsnx_GBbGFXyXRFQ@mail.gmail.com>
 <3cda8e87-7095-4aad-beb1-6a420912df34@arm.com>
 <CAK1f24k6mhQZwws7fjvL0ynme4FtjqBM3T6ZYuFPytH0fG=v6w@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAK1f24k6mhQZwws7fjvL0ynme4FtjqBM3T6ZYuFPytH0fG=v6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/04/2024 15:07, Lance Yang wrote:
> On Thu, Apr 11, 2024 at 9:48 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> [...]
>>
>>>>> +
>>>>> +             if (!folio_trylock(folio))
>>>>> +                     continue;
>>>>
>>>> This is still wrong. This should all be protected by the "if
>>>> (folio_test_swapcache(folio) || folio_test_dirty(folio))" as it was previously
>>>> so that you only call folio_trylock() if that condition is true. You are
>>>> unconditionally locking here, then unlocking, then relocking below if the
>>>> condition is met. Just put everything inside the condition and lock once.
>>>
>>> I'm not sure if it's safe to call folio_mapcount() without holding the
>>> folio lock.
>>>
>>> As mentioned earlier by David in the v2[1]
>>>> What could work for large folios is making sure that #ptes that map the
>>>> folio here correspond to the folio_mapcount(). And folio_mapcount()
>>>> should be called under folio lock, to avoid racing with swapout/migration.
>>>
>>> [1] https://lore.kernel.org/all/5cc05529-eb80-410e-bc26-233b0ba0b21f@redhat.com/
>>
>> But I'm not suggesting that you should call folio_mapcount() without the lock.
>> I'm proposing this:
>>
>>                 if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
>>                         if (!folio_trylock(folio))
>>                                 continue;
>>                         /*
>> -                        * If folio is shared with others, we mustn't clear
>> -                        * the folio's dirty flag.
>> +                        * If we have a large folio at this point, we know it is
>> +                        * fully mapped so if its mapcount is the same as its
>> +                        * number of pages, it must be exclusive.
>>                          */
>> -                       if (folio_mapcount(folio) != 1) {
>> +                       if (folio_mapcount(folio) != folio_nr_pages(folio)) {
>>                                 folio_unlock(folio);
>>                                 continue;
>>                         }
> 
> IIUC, if the folio is clean and not in the swapcache, we still need to
> compare the number of batched PTEs against folio_mapcount().

Why? That's not how the old code worked. In fact the comment says that the
reason for the exclusive check is to avoid marking a dirty *folio* as clean if
shared; that would be bad because we could throw away data that others relied
upon. It's perfectly safe to clear the dirty flag from the *pte* even if it is
shared; the ptes are private to the process so that won't affect sharers.

You should just follow the pattern already estabilished by the original code.
The only difference is that because the folio is now (potentially) large, you
have to change the way to detect exclusivity.

> 
> Thanks,
> Lance
> 
>>
>> What am I missing?
>>


