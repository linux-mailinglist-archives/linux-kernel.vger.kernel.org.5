Return-Path: <linux-kernel+bounces-119552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB8588CA5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711C71C65838
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE381F94C;
	Tue, 26 Mar 2024 17:08:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CF91F605
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472903; cv=none; b=hkk2wcy+kXA6tzSSugW2ElVKui4YCCEN6OBp+1QOcpNE1Olt00V20vLikRXYqVvHXKiy2HYKxeBOF4UDBh1pSy4YnT/3CICRuAqJvj1Izr2h9V7itvt1Mmo12dfm5oPaUYDhSP/fq2DsHUpOycLE6zwLEQTLaMH2Op9QS/YJM24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472903; c=relaxed/simple;
	bh=N8rkniHSG/zf9bZ59zfqWIlQyZVY7OdEbIT9ni4/8I4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQ6A0P5uDj4MmlKxvV7+eO5KQtRpv5hVLS8TWzJdzKYd/I1TnPh2s48ZLCFSCt2ImEvZ3D2RH0EuAr7IlL15xDZBeb0WeqTBws+SFb09YNyXYPcsBp7jjB33nmhvpz5dULLIPi7ziQCdJ7x/hn98IqkHOKkxRlpLC5d49mPD9GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84C132F4;
	Tue, 26 Mar 2024 10:08:54 -0700 (PDT)
Received: from [10.1.29.179] (XHFQ2J9959.cambridge.arm.com [10.1.29.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0764C3F64C;
	Tue, 26 Mar 2024 10:08:19 -0700 (PDT)
Message-ID: <01ebf398-8898-4b8d-97ff-c7efcdb4a17b@arm.com>
Date: Tue, 26 Mar 2024 17:08:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Can you help us on memory barrier usage? (was Re: [PATCH v4 4/6]
 mm: swap: Allow storage of all mTHP orders)
Content-Language: en-GB
To: "Huang, Ying" <ying.huang@intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, chrisl@kernel.org
References: <87r0g3q9cz.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
 <c56eae89-9559-4b1d-8249-d23281e466b4@gmail.com>
 <766cfb68-f82a-4163-9dc1-5f4483fa5a7a@paulmck-laptop>
 <87r0fzova4.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87r0fzova4.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2024 03:16, Huang, Ying wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> 
>> On Sat, Mar 23, 2024 at 11:11:09AM +0900, Akira Yokosawa wrote:
>>> [Use Paul's reachable address in CC;
>>>  trimmed CC list, keeping only those who have responded so far.]
>>>
>>> Hello Huang,
>>> Let me chime in.
>>>
>>> On Fri, 22 Mar 2024 06:19:52 -0700, Huang, Ying wrote:
>>>> Hi, Paul,
>>>>
>>>> Can you help us on WRITE_ONCE()/READ_ONCE()/barrier() usage as follows?
>>>> For some example kernel code as follows,
>>>>
>>>> "
>>>> unsigned char x[16];
>>>>
>>>> void writer(void)
>>>> {
>>>>         memset(x, 1, sizeof(x));
>>>>         /* To make memset() take effect ASAP */
>>>>         barrier();
>>>> }
>>>>
>>>> unsigned char reader(int n)
>>>> {
>>>>         return READ_ONCE(x[n]);
>>>> }
>>>> "
>>>>
>>>> where, writer() and reader() may be called on 2 CPUs without any lock.
>>>> It's acceptable for reader() to read the written value a little later.
>>
>> What are your consistency requirements?  For but one example, if reader(3)
>> gives the new value, is it OK for a later call to reader(2) to give the
>> old value?
> 
> writer() will be called with a lock held (sorry, my previous words
> aren't correct here).  After the racy checking in reader(), we will
> acquire the lock and check "x[n]" again to confirm.  And, there are no
> dependencies between different "n".  All in all, we can accept almost
> all races between writer() and reader().
> 
> My question is, if there are some operations between writer() and
> unlocking in its caller, whether does barrier() in writer() make any
> sense?  Make write instructions appear a little earlier in compiled
> code?  Mark the memory may be read racy?  Or doesn't make sense at all?

A compiler barrier is neccessary but not sufficient to guarrantee that the
stores become visible to the reader; you would also need a memory barrier to
stop the HW from reordering IIUC. So I really fail to see the value of adding
barrier().

As you state above there is no correctness issue here. Its just a question of
whether the barrier() can make the store appear earlier to the reader for a
(micro!) performance optimization. You'll get both the compiler and memory
barrier from the slightly later spin_unlock(). The patch that added the original
WRITE_ONCE() was concerned with squashing kcsan warnings, not with performance
optimization. (And the addition of the WRITE_ONCE() wasn't actually needed to
achieve the aim).

So I'm planning to repost my series (hopefully tomorrow) without the barrier()
present, unless you still want to try to convince me that it is useful.

Thanks,
Ryan

> 
>> Until we know what your requirements are, it is hard to say whether the
>> above code meets those requirements.  In the meantime, I can imagine
>> requirements that it meets and others that it does not.
>>
>> Also, Akira's points below are quite important.
> 
> Replied for his email.
> 
> --
> Best Regards,
> Huang, Ying


