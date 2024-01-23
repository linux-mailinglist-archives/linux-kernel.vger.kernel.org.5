Return-Path: <linux-kernel+bounces-34683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC0B83861C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4145228B59B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF6617FE;
	Tue, 23 Jan 2024 03:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e4MVPVKA"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBADA110A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705981291; cv=none; b=FjC13Cxthmymu+1daPZehGxQ9OXadJUoa6gIq29ygKD+sQJn6w8DylcqofxQTEjz4IySziZFn8BhaWrSzV6zmf9XF1uQtACKDzZ1nSZFXbZUrWccOaednGqTb2dBQYhh5wpU5EWE5ugDNVY4L1wZIBuDFjcbNwcos3sxpfVvGdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705981291; c=relaxed/simple;
	bh=Ig2RP/uw0YQwueq8TUo7iEgZya+f3pXFj+GEGBrXvpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M89AwdGCrS8WBM0gNxWRlE9QQaaaZg5xx8/CKELaops6TTQQubDmHIg1ohmnJHaDqamUm6Gwt9Se770F+HU26JoRkPOoCTkZPD6mwrm0qV0VFTCAIlfW4M5666Pu+h57xtair1RJ54WFJUhATcLPUAaoXCjSeBkq9DXlK58n7MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e4MVPVKA; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <11da8b32-9946-9f7c-95fe-f6254b4f6e99@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705981287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yt3AR0W7SP2tLShyq/3MhllgHeKq9WrP4nJ6WWve3yg=;
	b=e4MVPVKA49CpZDs0C9I8EVqSiZTtfNWwjMCyOE54+2oirnjVE8J0e0vX3mo6iDnZS9Uhik
	0XYRyGma4KiRE+Si6AaTpFK3viNajkr9Hmk5WmlIpFSYVvGbFcmrnKmc55cr1IVdfDwTUz
	R0A2LC1vw4WJwn8P/KEQvqiD9k9+4/o=
Date: Tue, 23 Jan 2024 11:41:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/mmap: introduce vma_range_init()
Content-Language: en-US
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240111021526.3461825-1-yajun.deng@linux.dev>
 <20240122220031.pwiravglee7o7k34@revolver>
 <20240122154031.b710f834b14d9027176f439a@linux-foundation.org>
 <20240123001830.glqdmrv2qc56zfpc@revolver>
 <2a1d6a9b-f486-44c8-6d1d-e6bab4dc3ced@linux.dev>
 <20240123031906.pwbjuzdpl6hqiptj@revolver>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20240123031906.pwbjuzdpl6hqiptj@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2024/1/23 11:19, Liam R. Howlett wrote:
> * Yajun Deng <yajun.deng@linux.dev> [240122 21:23]:
>> On 2024/1/23 08:18, Liam R. Howlett wrote:
>>> * Andrew Morton <akpm@linux-foundation.org> [240122 18:40]:
>>>> On Mon, 22 Jan 2024 17:00:31 -0500 "Liam R. Howlett" <Liam.Howlett@Oracle.com> wrote:
>>>>
>>>>> * Yajun Deng <yajun.deng@linux.dev> [240110 21:15]:
>>>>>> There is a lot of code needs to set the range of vma, introduce
>>>>>> vma_range_init() to initialize the range of vma.
>>>>>>
>>>>>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>>>>>> ---
>>>>>>    include/linux/mm.h |  9 +++++++++
>>>>>>    mm/mmap.c          | 29 +++++++----------------------
>>>>>>    2 files changed, 16 insertions(+), 22 deletions(-)
>>>>> This isn't a whole lot of code, are there others?  We're losing code
>>>>> clarity in favour of saving 6 lines?
>>>>>
>>>> Oh.  I thought it was a nice cleanup which made things more clear.
>>> I'm not totally against it; that's why I suggested the changes below. I
>>> think a name change would go a long way for clarity. It's not as much as
>>> I though it would be though.
>>>
>>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>>> index f5a97dec5169..abb4534be3cc 100644
>>>>>> --- a/include/linux/mm.h
>>>>>> +++ b/include/linux/mm.h
>>>>>> @@ -3516,6 +3516,15 @@ static inline bool range_in_vma(struct vm_area_struct *vma,
>>>>>>    	return (vma && vma->vm_start <= start && end <= vma->vm_end);
>>>>>>    }
>>>>>> +static inline void vma_range_init(struct vm_area_struct *vma,
>>>>> Any reason this can't be in mm/internal.h ?
>>>> That would be good.
>>> One other thing, do we trust this to be inlined correctly by the
>>> compiler or should this be __always_inline?  I'd expect it to be okay as
>>> it is, but I've been proven wrong in a perf trace before..
>>>
>> Okay, I would take __always_inline and put it in mm/internal.h in v2.
> I'm not confident in this suggestion as the rest.
> Please rename the function when you move it.

inline is a suggestion, __always_inline is mandatory.
I think __always_inline is better if we're demanding.

>>>>> vma_range_set(), vma_set_range(), or just vma_range() might be a better
>>>>> name?  My thinking is that some of these are actually modifying the vma
>>>>> and not just initializing it, right?
>>>> I'd vote for vma_set_range().
>                        ^  This part, use vma_set_range() please.

Okay.


By the way, I sent another patch with ("mm/mmap: simplify vma_merge()") 
subject a few days ago.

Please comment if you would like.

>>> Using vma_set_range() leaves vma_range() or vma_size(), which could be
>>> added for the calculations of vma->vm_end - vma->vm_start.  Davidlohr
>>> suggested such a beast a few years ago, but that one would need to live
>>> in the include/linux/mm.h as it occurs a lot more.
>>>
>>> $ git grep "vma->vm_end - vma->vm_start" | wc -l
>>> 198
>>>
>>> .. for just those named vma.
>>>

