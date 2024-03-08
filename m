Return-Path: <linux-kernel+bounces-97025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D441876487
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B0D1C21DC1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF5118C3B;
	Fri,  8 Mar 2024 12:50:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D663D817
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902216; cv=none; b=bC43Ehat/S73F6UHQRvAlPKCUBjSu6qN/Ymagcj5mzAVpWrI98sLRzEse3ppwZTZK8RKb3WDeoDnJZVo/uJcph3J8GtSqWvn8feIyG6PLcRtkH9f2zSfqr+JF0qFOONu44/FHS6LDj3HzntiXM4fDLsyXeg7AX5jNfBEDg5s+s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902216; c=relaxed/simple;
	bh=IRVg5M/t+oiJAaIajfBT88nkhX8EpPR6h54xRcayDGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJ4udp7awe7/YUHRfC3RJt1zLfFAoZR2mQ/iRHVw0sZgqWBICg2jjlfuNl4c+TIQZ8v+FRdWx7TnHWAD3XTCpHowJMi76BDivoZg1MqZnLaEfgtwhh82tt1L8KrlADYsS7wRYKdlldwp4AqxEmt6cy77jCkeY83MoZZ1stuMuvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87D40C15;
	Fri,  8 Mar 2024 04:50:50 -0800 (PST)
Received: from [10.57.70.163] (unknown [10.57.70.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 953CD3F762;
	Fri,  8 Mar 2024 04:50:10 -0800 (PST)
Message-ID: <cfe7d2b5-eb41-4df0-bf6b-4ed4044e20ea@arm.com>
Date: Fri, 8 Mar 2024 12:50:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: prohibit the last subpage from reusing the entire
 large folio
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: minchan@kernel.org, fengwei.yin@intel.com, linux-kernel@vger.kernel.org,
 mhocko@suse.com, peterx@redhat.com, shy828301@gmail.com,
 songmuchun@bytedance.com, wangkefeng.wang@huawei.com, xiehuan09@gmail.com,
 zokeefe@google.com, chrisl@kernel.org, yuzhao@google.com,
 Barry Song <v-songbaohua@oppo.com>, Lance Yang <ioworker0@gmail.com>
References: <20240308092721.144735-1-21cnbao@gmail.com>
 <519fd6a7-072e-43a2-a9a8-2467ee783524@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <519fd6a7-072e-43a2-a9a8-2467ee783524@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/03/2024 09:34, David Hildenbrand wrote:
> On 08.03.24 10:27, Barry Song wrote:
>> From: Barry Song <v-songbaohua@oppo.com>
>>
>> In a Copy-on-Write (CoW) scenario, the last subpage will reuse the entire
>> large folio, resulting in the waste of (nr_pages - 1) pages. This wasted
>> memory remains allocated until it is either unmapped or memory
>> reclamation occurs.
>>
>> The following small program can serve as evidence of this behavior
>>
>>   main()
>>   {
>>   #define SIZE 1024 * 1024 * 1024UL
>>           void *p = malloc(SIZE);
>>           memset(p, 0x11, SIZE);
>>           if (fork() == 0)
>>                   _exit(0);
>>           memset(p, 0x12, SIZE);
>>           printf("done\n");
>>           while(1);
>>   }
>>
>> For example, using a 1024KiB mTHP by:
>>   echo always > /sys/kernel/mm/transparent_hugepage/hugepages-1024kB/enabled
>>
>> (1) w/o the patch, it takes 2GiB,
>>
>> Before running the test program,
>>   / # free -m
>>                  total        used        free      shared  buff/cache  
>> available
>>   Mem:            5754          84        5692           0          17       
>> 5669
>>   Swap:              0           0           0
>>
>>   / # /a.out &
>>   / # done
>>
>> After running the test program,
>>   / # free -m
>>                   total        used        free      shared  buff/cache  
>> available
>>   Mem:            5754        2149        3627           0          19       
>> 3605
>>   Swap:              0           0           0
>>
>> (2) w/ the patch, it takes 1GiB only,
>>
>> Before running the test program,
>>   / # free -m
>>                   total        used        free      shared  buff/cache  
>> available
>>   Mem:            5754          89        5687           0          17       
>> 5664
>>   Swap:              0           0           0
>>
>>   / # /a.out &
>>   / # done
>>
>> After running the test program,
>>   / # free -m
>>                  total        used        free      shared  buff/cache  
>> available
>>   Mem:            5754        1122        4655           0          17       
>> 4632
>>   Swap:              0           0           0
>>
>> This patch migrates the last subpage to a small folio and immediately
>> returns the large folio to the system. It benefits both memory availability
>> and anti-fragmentation.
> 
> It might be controversial optimization, and as Ryan said, there, are likely
> other cases where we'd want to migrate off-of a thp if possible earlier.

Personally, I think there might also be cases where you want to copy/reuse the
entire large folio. If you're application is using 16K THPs perhaps it's a
bigger win to just treat it like a base page? I expect the cost/benefit will
change as the THP size increases?

I know we have previously talked about using a khugepaged-like mechanism to
re-collapse after CoW, but for the smaller sizes maybe that's just a lot more
effort?

> 
> But I like that it just handles large folios now in a consistent way for the
> time being.

Yes agreed.

> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 


