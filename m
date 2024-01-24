Return-Path: <linux-kernel+bounces-37003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E2483AA14
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB6A1F2272E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FECC77639;
	Wed, 24 Jan 2024 12:42:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925C117543;
	Wed, 24 Jan 2024 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100132; cv=none; b=lmBE6lq1YJMbD2Wu6iDMES+KAAozKP3dJydfXYl1ZCgoQ4ge18XN3XiPi0YMxtRdvj4wu55fo/Tqj+t/+6hXaC3h3Y7CrePcVJaNXs8bm7ctVPDHsCFd3LcDGJF34ro5RwSKfas8NUJadsANfsYib2l4RJRadJwKI3dtIZnr2iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100132; c=relaxed/simple;
	bh=EcGrZYA6tDcbHMaVmklIwEpXVmyzro/cspPYoe6ROiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4PJ4S+taMcDOGwks0ilobVwYTyK7y3LKwfWnRRckk/Tb9nk+WVfvCn7SRfHHrno3M/+xN6ehA64Q51w7LDPNj9G6pEn6L4+dnqZtTlVzNl0cys2jcXdEOq1NkY8A2OhB51yK5qNSRrhQMATD56U/k9vaojcX7omL11R8h4esT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD1361FB;
	Wed, 24 Jan 2024 04:42:54 -0800 (PST)
Received: from [10.57.77.165] (unknown [10.57.77.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3654A3F5A1;
	Wed, 24 Jan 2024 04:42:06 -0800 (PST)
Message-ID: <e7a21ef8-6b72-46da-9a59-7e33394465f3@arm.com>
Date: Wed, 24 Jan 2024 12:42:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/10] mm: Non-pmd-mappable, large folios for
 folio_add_new_anon_rmap()
Content-Language: en-GB
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Yin Fengwei <fengwei.yin@intel.com>,
 Yu Zhao <yuzhao@google.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Yang Shi
 <shy828301@gmail.com>, "Huang, Ying" <ying.huang@intel.com>,
 Zi Yan <ziy@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Itaru Kitayama <itaru.kitayama@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 John Hubbard <jhubbard@nvidia.com>, David Rientjes <rientjes@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Hugh Dickins <hughd@google.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>, linux-s390@vger.kernel.org
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
 <20231207161211.2374093-3-ryan.roberts@arm.com> <ZaMR2EWN-HvlCfUl@krava>
 <41dc7dff-1ea8-4894-a487-88d46ec2b2d8@redhat.com> <ZaRKMwKJIBmh8-lD@krava>
 <1188e67e-5c04-4bb5-b242-78d92c3fc85c@arm.com>
 <yt9d1qa7x9qv.fsf@linux.ibm.com> <ZbDyLzoIm0GdQzZA@krava>
 <6caaced7-a9d7-4fe4-823a-11b96be83e46@arm.com> <ZbD9YdCmZ3_uTj_k@krava>
 <edfade67-269e-4a49-8db6-40617131e283@arm.com>
 <yt9dcytqx6dv.fsf@linux.ibm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <yt9dcytqx6dv.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/01/2024 12:28, Sven Schnelle wrote:
> Hi Ryan,
> 
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>>>>>>>>>> I'm hitting this bug (console output below) with adding uprobe
>>>>>>>>>> on simple program like:
>>>>>>>>>>
>>>>>>>>>>    $ cat up.c
>>>>>>>>>>    int main(void)
>>>>>>>>>>    {
>>>>>>>>>>       return 0;
>>>>>>>>>>    }
>>>>>>>>>>
>>>>>>>>>>    # bpftrace -e 'uprobe:/home/jolsa/up:_start {}'
>>>>>>>>>>
>>>>>>>>>>    $ ./up
>>>>>>>>>>
>>>>>>>>>> it's on top of current linus tree master:
>>>>>>>>>>    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat
>>>>>>>>>>
>>>>>>>>>> before this patch it seems to work, I can send my .config if needed
>>>>>>>
>>>>>>> Thanks for the bug report!
>>>>>>
>>>>>> I just hit the same bug in our CI, but can't find the fix in -next. Is
>>>>>> this in the queue somewhere?
>>>>>
>>>>> we hit it as well, but I can see the fix in linux-next/master
>>>>>
>>>>>   4c137bc28064 uprobes: use pagesize-aligned virtual address when replacing pages
>>>>
>>>> Yes that's the one. Just to confirm: you are still hitting the VM_BUG_ON despite
>>>> having this change in your kernel? Could you please send over the full bug log?
>>>
>>> ah sorry.. I meant the change fixes the problem for us, it just did not
>>> yet propagate through the merge cycle into bpf trees.. but I can see it
>>> in linux-next tree, so it's probably just matter of time
>>
>> OK great! How about you, Sven? Do you have this change in your kernel? Hopefully
>> it should fix your problem.
> 
> Same here - the fix makes uprobes work again, i just didn't see it in
> torvalds-master and neither in todays linux-next. But Jiri is right,
> it's in linux-next/master. I just missed to find it there. So everything
> should be ok.

Great!

