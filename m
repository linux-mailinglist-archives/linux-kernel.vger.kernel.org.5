Return-Path: <linux-kernel+bounces-92175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B713F871C49
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55EFA1F255E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD11F605A5;
	Tue,  5 Mar 2024 10:44:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4C7604DD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635492; cv=none; b=lW90IzghvrAQ8wozmR5YhkdTuHWHPAPC5LsYh+7DF0WAJIdU8tvbnRSRVvd08oecU6CxErMfOg3PekcT0XfwtQuDQOnBuEDbENjdlIqFiYko8aX7/9xOHgs/TPdB7AsLe6NuDrj1f2JdOZqhsQdXA1WjopHVBBFlkplTQOnD1LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635492; c=relaxed/simple;
	bh=1MRTtg6xxW+m8LZNKf6jYXnzCsJ63H6Z/wbBhOItJ6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOC7i/hqse0Peu+pDIn/7dI6BTRHgaayY+Jom+4kNTTcBNbKbtXhPeZS7zkG/4NokkwEhaVyZJPRkHmxQRdbSynY3GpN+fIrNxkUUrWW1pj2Tn1xeCK2CMbczTJgQQ9B8KSVg7DfQbkQ3+OI8vYTmtt73WlK8ac2m7k+YMeo+D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7773D1FB;
	Tue,  5 Mar 2024 02:45:26 -0800 (PST)
Received: from [10.1.39.151] (XHFQ2J9959.cambridge.arm.com [10.1.39.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDD363F762;
	Tue,  5 Mar 2024 02:44:47 -0800 (PST)
Message-ID: <19c2cf15-8789-4977-b149-83b53d2b6abb@arm.com>
Date: Tue, 5 Mar 2024 10:44:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without
 splitting
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org,
 xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com,
 chrisl@kernel.org, surenb@google.com, hanchuanhua@oppo.com
References: <20231025144546.577640-5-ryan.roberts@arm.com>
 <20240205095155.7151-1-v-songbaohua@oppo.com>
 <d4f602db-403b-4b1f-a3de-affeb40bc499@arm.com>
 <CAGsJ_4wo7BiJWSKb1K_WyAai30KmfckMQ3-mCJPXZ892CtXpyQ@mail.gmail.com>
 <7061b9f4-b7aa-4dad-858c-53ee186c2d8f@arm.com>
 <CAGsJ_4w8YWMFjWu2i5NhbOA-pfemvzCHt4hB7rWiOpY63GVWSA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4w8YWMFjWu2i5NhbOA-pfemvzCHt4hB7rWiOpY63GVWSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/03/2024 09:54, Barry Song wrote:
> On Tue, Mar 5, 2024 at 10:00 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Hi Barry,
>>
>> On 18/02/2024 23:40, Barry Song wrote:
>>> On Tue, Feb 6, 2024 at 1:14 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> On 05/02/2024 09:51, Barry Song wrote:
>>>>> +Chris, Suren and Chuanhua
>>>>>
>>>>> Hi Ryan,
>> [...]
>>>>
>>>
>>> Hi Ryan,
>>> I am running into some races especially while enabling large folio swap-out and
>>> swap-in both. some of them, i am still struggling with the detailed
>>> timing how they
>>> are happening.
>>> but the below change can help remove those bugs which cause corrupted data.
>>
>> I'm getting quite confused with all the emails flying around on this topic. Here
>> you were reporting a data corruption bug and your suggested fix below is the one
>> you have now posted at [1]. But in the thread at [1] we concluded that it is not
>> fixing a functional correctness issue, but is just an optimization in some
>> corner cases. So does the corruption issue still manifest? Did you manage to
>> root cause it? Is it a problem with my swap-out series or your swap-in series,
>> or pre-existing?
> 
> Hi Ryan,
> 
> It is not a problem of your swap-out series, but a problem of my swap-in
> series. The bug in swap-in series is triggered by the skipped PTEs in the
> thread[1], but my swap-in code should still be able to cope with this situation
> and survive it -  a large folio might be partially but not completely unmapped
> after try_to_unmap_one(). 

Ahh, understood, thanks!

> I actually replied to you and explained all
> the details here[2], but guess you missed it :-)

I did read that mail, but the first line "They are the same" made me think this
was solving a functional problem. And I still have a very shaky understanding of
parts of the code that I haven't directly worked on, so sometimes some of the
details go over my head - I'll get there eventually!

> 
> [1] https://lore.kernel.org/linux-mm/20240304103757.235352-1-21cnbao@gmail.com/
> [2] https://lore.kernel.org/linux-mm/CAGsJ_4zdh5kOG7QP4UDaE-wmLFiTEJC2PX-_LxtOj=QrZSvkCA@mail.gmail.com/
> 
> apology this makes you confused.

No need to apologise - I appreciate your taking the time to write it all down in
detail. It helps me to learn these areas of the code.

> 
>>
>> [1] https://lore.kernel.org/linux-mm/20240304103757.235352-1-21cnbao@gmail.com/
>>
>> Thanks,
>> Ryan
>>
> 
> Thanks
> Barry


