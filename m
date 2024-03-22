Return-Path: <linux-kernel+bounces-111231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142E788696D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E9A1C216D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D264B2230F;
	Fri, 22 Mar 2024 09:39:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2108A224F1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100377; cv=none; b=rQSlI3DuJFrr9cLthY3fI2iv5vHquV0dL47aV1RitR2+uO9D/AZBrUSUlL07xf6tmAwncq9+NZ0KT2+UM+YqeDRZcCMvGQ3pTRerod/g2fEWBwzqxtVLG2ZlasEp83BkQ9hQktUm18Ct4isr7sx/4fuypwipOwtHSKnJk18cEK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100377; c=relaxed/simple;
	bh=OJoEnYOjFTP4CHdGTPSIyur2cVGQFbj8igAcc8O+R/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRyM5G9p8i6qAdQ0P8xDrb4gEw0jgQYVy9G28ZHCKURIybGmL+ci4OdQBitvM14rPpbSejedsKk5M4chsk9cO6TIiyn5IsMyrixqiJ2fB7OkJ9wQAUyG3wu501EwVREPKNF5wPANMX3O9InEa15MmHopx4OdCHUJpFR5ja7+m/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71DC51007;
	Fri, 22 Mar 2024 02:40:08 -0700 (PDT)
Received: from [10.57.72.175] (unknown [10.57.72.175])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1DD13F64C;
	Fri, 22 Mar 2024 02:39:31 -0700 (PDT)
Message-ID: <32ca7e47-4a85-4170-a34a-d007494cc262@arm.com>
Date: Fri, 22 Mar 2024 09:39:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] mm: swap: Allow storage of all mTHP orders
Content-Language: en-GB
To: "Huang, Ying" <ying.huang@intel.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-5-ryan.roberts@arm.com>
 <87jzm751n3.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <d6ac1097-2ca3-4e6d-902d-1b942cacf0fb@arm.com>
 <8734skryev.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <b22a222b-7fd8-4648-84a7-21d35f529f27@arm.com>
 <87plvnq9ap.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87plvnq9ap.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/03/2024 02:39, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> On 21/03/2024 04:39, Huang, Ying wrote:
>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>
>>>> Hi Huang, Ying,
>>>>
>>>>
>>>> On 12/03/2024 07:51, Huang, Ying wrote:
>>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>> [...]
>>>>
>>>>>> @@ -905,17 +961,18 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>>>>>  	}
>>>>>>  
>>>>>>  	if (si->swap_map[offset]) {
>>>>>> +		VM_WARN_ON(order > 0);
>>>>>>  		unlock_cluster(ci);
>>>>>>  		if (!n_ret)
>>>>>>  			goto scan;
>>>>>>  		else
>>>>>>  			goto done;
>>>>>>  	}
>>>>>> -	WRITE_ONCE(si->swap_map[offset], usage);
>>>>>> -	inc_cluster_info_page(si, si->cluster_info, offset);
>>>>>> +	memset(si->swap_map + offset, usage, nr_pages);
>>>>>
>>>>> Add barrier() here corresponds to original WRITE_ONCE()?
>>>>> unlock_cluster(ci) may be NOP for some swap devices.
>>>>
>>>> Looking at this a bit more closely, I'm not sure this is needed. Even if there
>>>> is no cluster, the swap_info is still locked, so unlocking that will act as a
>>>> barrier. There are a number of other callsites that memset(si->swap_map) without
>>>> an explicit barrier and with the swap_info locked.
>>>>
>>>> Looking at the original commit that added the WRITE_ONCE() it was worried about
>>>> a race with reading swap_map in _swap_info_get(). But that site is now annotated
>>>> with a data_race(), which will suppress the warning. And I don't believe there
>>>> are any places that read swap_map locklessly and depend upon observing ordering
>>>> between it and other state? So I think the si unlock is sufficient?
>>>>
>>>> I'm not planning to add barrier() here. Let me know if you disagree.
>>>
>>> swap_map[] may be read locklessly in swap_offset_available_and_locked()
>>> in parallel.  IIUC, WRITE_ONCE() here is to make the writing take effect
>>> as early as possible there.
>>
>> Afraid I'm not convinced by that argument; if it's racing, it's racing - the
> 
> It's not a race.
> 
>> lockless side needs to be robust (it is). Adding the compiler barrier limits the
>> compiler's options which could lead to slower code in this path. If your
>> argument is that you want to reduce the window where
>> swap_offset_available_and_locked() could observe a free swap slot but then see
>> that its taken after it gets the si lock, that seems like a micro-optimization
>> to me, which we should avoid if we can.
> 
> Yes.  I think that it is a micro-optimization too.  I had thought that
> it is a common practice to use WRITE_ONCE()/READ_ONCE() or barrier() in
> intentional racy data accessing to make the change available as soon as
> possible.  But I may be wrong here.

My understanding is that WRITE_ONCE() forces the compiler to emit a store at
that point in the program; it can't just rely on knowing that it has previously
written the same value to that location, it can't reorder the load to later in
the program and it must store the whole word atomically so that no tearing can
be observed. But given that swap_map is only ever written with the si lock held,
I don't believe we require the first two of those semantics. It should be enough
to know that the compiler has emitted all the stores (if it determines they are
required) prior to the spin_unlock(). I'm not sure about the anti-tearing
guarrantee.

Happy to be told I'm wrong here!

> 
>> By remnoving the WRITE_ONCE() and using memset, the lockless reader could
>> observe tearing though. I don't think that should cause a problem (because
>> everything is rechecked with under the lock), but if we want to avoid it, then
>> perhaps we just need to loop over WRITE_ONCE() here instead of using memset?
> 
> IIUC, in practice that isn't necessary, because type of si->swap_map[]
> is "unsigned char".  It isn't possible to tear "unsigned char".  

In practice, perhaps. But I guess the compiler is free to update the char
bit-by-bit if it wants to, if the store is not marked WRITE_ONCE()?

> In
> theory, it may be better to use WRITE_ONCE() because we may change the
> type of si->swap_map[] at some time (who knows).  I don't have a strong
> opinion here.

The way I see it, the precedent is already set; there are a number of places
that already use memset to update swap_map. They are all under the si lock, and
none use barrier(). If its wrong here, then its wrong in those places too, I
believe.

> 
>>>>>> +	add_cluster_info_page(si, si->cluster_info, offset, nr_pages);
>>>>>>  	unlock_cluster(ci);
> 
> --
> Best Regards,
> Huang, Ying


