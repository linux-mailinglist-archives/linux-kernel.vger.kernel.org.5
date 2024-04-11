Return-Path: <linux-kernel+bounces-140243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338848A1005
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15DB287D93
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE3A147C77;
	Thu, 11 Apr 2024 10:29:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F30146D47
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831386; cv=none; b=SnH44aDE7v3/KGxBFZ+eFvLO1gsdrMLpo//lzbotHuBkYYTBYnsfpe1qqCO+dVpMRf6N4EzB+XiObcqKOePhMOowM8tCss46TSDP96L6ikcuiwogr9JVtJZre21PaRxKbJitb5M71KB/vMDY3PjRZCfAnaMOCvEu2ejg2oNQHtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831386; c=relaxed/simple;
	bh=CXdh8/phT1LYAJMjE1cvVPsEOyv+4xRLzsmicYf9AD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Noy/nWGzAirS+wdsuA9ns+hpa2lMFf9uTfgzfDy49eRR+/Immyw/XhlzmUKGVN8R93KVlSq9zJJ4F/eUmgP9CBCyx7O6gLPYtjWHYm8PB6ISNFfbBtoNHlH2XB0c9eVjjlc8pRnYhdemD2Ncm46VYX8svoSCmUHr/x39Oxj+snQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF647113E;
	Thu, 11 Apr 2024 03:30:12 -0700 (PDT)
Received: from [10.1.38.151] (XHFQ2J9959.cambridge.arm.com [10.1.38.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A2B93F6C4;
	Thu, 11 Apr 2024 03:29:41 -0700 (PDT)
Message-ID: <f6841f42-7f54-4d43-9234-7748df4975cf@arm.com>
Date: Thu, 11 Apr 2024 11:29:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] mm/madvise: enhance lazyfreeing with mTHP in
 madvise_free
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: david@redhat.com, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240408042437.10951-1-ioworker0@gmail.com>
 <20240410145033.5cdb8a41f3a6894a62191f42@linux-foundation.org>
 <CAK1f24nfN_cfdKn_q391NAug-dvWsX-LW9NzxcTaRm95Px3Kqw@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAK1f24nfN_cfdKn_q391NAug-dvWsX-LW9NzxcTaRm95Px3Kqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/04/2024 06:01, Lance Yang wrote:
> On Thu, Apr 11, 2024 at 5:50 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Mon,  8 Apr 2024 12:24:35 +0800 Lance Yang <ioworker0@gmail.com> wrote:
>>
>>> Hi All,
>>>
>>> This patchset adds support for lazyfreeing multi-size THP (mTHP) without
>>> needing to first split the large folio via split_folio(). However, we
>>> still need to split a large folio that is not fully mapped within the
>>> target range.
>>>
>>> If a large folio is locked or shared, or if we fail to split it, we just
>>> leave it in place and advance to the next PTE in the range. But note that
>>> the behavior is changed; previously, any failure of this sort would cause
>>> the entire operation to give up. As large folios become more common,
>>> sticking to the old way could result in wasted opportunities.
>>>
>>> Performance Testing
>>> ===================
>>>
>>> On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by PTE-mapped folios of
>>> the same size results in the following runtimes for madvise(MADV_FREE)
>>> in seconds (shorter is better):
>>>
>>> Folio Size |   Old    |   New    | Change
>>> ------------------------------------------
>>>       4KiB | 0.590251 | 0.590259 |    0%
>>>      16KiB | 2.990447 | 0.185655 |  -94%
>>>      32KiB | 2.547831 | 0.104870 |  -95%
>>>      64KiB | 2.457796 | 0.052812 |  -97%
>>>     128KiB | 2.281034 | 0.032777 |  -99%
>>>     256KiB | 2.230387 | 0.017496 |  -99%
>>>     512KiB | 2.189106 | 0.010781 |  -99%
>>>    1024KiB | 2.183949 | 0.007753 |  -99%
>>>    2048KiB | 0.002799 | 0.002804 |    0%
>>
>> That looks nice but punting work to another thread can slightly
>> increase overall system load and can mess up utilization accounting by
>> attributing work to threads which didn't initiate that work.

My understanding is that this speedup is all coming from the avoidance of
splitting folios synchonously in the context of madvise(MADV_FREE). It's not
actually punting anymore work to be done lazily, its just avoiding doing extra
uneccessary work up front. In fact, it would result in less work to do at
lazyfree time because the folios remain large so there are fewer folios to free.

Perhaps I've misunderstood your point?

Thanks,
Ryan

>>
>> And there's a corner-case risk where the thread running madvise() has
>> realtime policy (SCHED_RR/SCHED_FIFO) on a single-CPU system,
>> preventing any other threads from executing, resulting in indefinitely
>> deferred freeing resulting in memory squeezes or even OOM conditions.
>>
>> It would be good if the changelog(s) were to show some consideration of
>> such matters and some demonstration that the benefits exceed the risks
>> and costs.
>>
> 
> Hey Andrew,
> 
> Thanks for bringing up these concerns!
> 
> I completely agree that we need to consider such masters and include
> them into the changelog(s). Additionally, I'll do my best to show that the
> benefits exceed the risks and costs, and then update the changelog(s)
> accordingly.
> 
> Thanks again for your time!
> Lance


