Return-Path: <linux-kernel+bounces-24334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A805482BB2F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DD1288D08
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01475C8E8;
	Fri, 12 Jan 2024 06:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5QK0yV41"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CF65C8E1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 06:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705040191;
	bh=r92f2aG9W1o5RGaWeOcmFA+zp/Tat8uerpfmCdUCBJs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=5QK0yV4166uJ+Fb1SPpMaesp9BvEfqbwcqkcRfUEtfeSO4+xtzxIOG96soOBQcyJe
	 k3Exs5xwA67KBbM4daBw2nMBlT8YVMMCLWutZR3D6YjjGKO4A+9GAyGc1hIW0/nNVf
	 MNXZq+Z2Kz3ziUh9p7WXjrUQ44WQDqAxGy46rzZnYaz2azZy1hoX3O/sp4TPuM4mDZ
	 bYurIdwdabygRHPKFNQDqfdq51FzJyp9Gj06ObkhypyvJO+ldGjV1IiEaXdEMyB0B0
	 Vy0NWNXMhCkzDZUL94TUoINlCq3H9c2N4fYoLsXs+OVjF4cDnEHOBuUKHLbZ8mdtH9
	 7x6ZMNuLM8p6w==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 70F6D3781FE5;
	Fri, 12 Jan 2024 06:16:26 +0000 (UTC)
Message-ID: <772a2c59-7616-4ec7-9050-17d3abf0b6eb@collabora.com>
Date: Fri, 12 Jan 2024 11:16:32 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, linmiaohe@huawei.com,
 mike.kravetz@oracle.com, naoya.horiguchi@nec.com, akpm@linux-foundation.org,
 songmuchun@bytedance.com, shy828301@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, jthoughton@google.com,
 "kernel@collabora.com" <kernel@collabora.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Linux Regressions <regressions@lists.linux.dev>
Subject: Re: [PATCH v4 4/4] selftests/mm: add tests for HWPOISON hugetlbfs
 read
Content-Language: en-US
To: Jiaqi Yan <jiaqiyan@google.com>,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>
References: <20230713001833.3778937-1-jiaqiyan@google.com>
 <20230713001833.3778937-5-jiaqiyan@google.com>
 <be3976b5-0a9c-41c6-8160-88e6c1e5d63e@collabora.com>
 <CACw3F51WvZDVCpVg9j4j8WmnmAFOsnK+FZDDoVqhgLqVwhPTCA@mail.gmail.com>
 <e68488e4-764e-4b25-8a47-05bf8976bd19@collabora.com>
 <079335ab-190f-41f7-b832-6ffe7528fd8b@collabora.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <079335ab-190f-41f7-b832-6ffe7528fd8b@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/10/24 3:15 PM, Muhammad Usama Anjum wrote:
> On 1/10/24 11:49 AM, Muhammad Usama Anjum wrote:
>> On 1/6/24 2:13 AM, Jiaqi Yan wrote:
>>> On Thu, Jan 4, 2024 at 10:27 PM Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> I'm trying to convert this test to TAP as I think the failures sometimes go
>>>> unnoticed on CI systems if we only depend on the return value of the
>>>> application. I've enabled the following configurations which aren't already
>>>> present in tools/testing/selftests/mm/config:
>>>> CONFIG_MEMORY_FAILURE=y
>>>> CONFIG_HWPOISON_INJECT=m
>>>>
>>>> I'll send a patch to add these configs later. Right now I'm trying to
>>>> investigate the failure when we are trying to inject the poison page by
>>>> madvise(MADV_HWPOISON). I'm getting device busy every single time. The test
>>>> fails as it doesn't expect any business for the hugetlb memory. I'm not
>>>> sure if the poison handling code has issues or test isn't robust enough.
>>>>
>>>> ./hugetlb-read-hwpoison
>>>> Write/read chunk size=0x800
>>>>  ... HugeTLB read regression test...
>>>>  ...  ... expect to read 0x200000 bytes of data in total
>>>>  ...  ... actually read 0x200000 bytes of data in total
>>>>  ... HugeTLB read regression test...TEST_PASSED
>>>>  ... HugeTLB read HWPOISON test...
>>>> [    9.280854] Injecting memory failure for pfn 0x102f01 at process virtual
>>>> address 0x7f28ec101000
>>>> [    9.282029] Memory failure: 0x102f01: huge page still referenced by 511
>>>> users
>>>> [    9.282987] Memory failure: 0x102f01: recovery action for huge page: Failed
>>>>  ...  !!! MADV_HWPOISON failed: Device or resource busy
>>>>  ... HugeTLB read HWPOISON test...TEST_FAILED
>>>>
>>>> I'm testing on v6.7-rc8. Not sure if this was working previously or not.
>>>
>>> Thanks for reporting this, Usama!
>>>
>>> I am also able to repro MADV_HWPOISON failure at "501a06fe8e4c
>>> (akpm/mm-stable, mm-stable) zswap: memcontrol: implement zswap
>>> writeback disabling."
>>>
>>> Then I checked out the earliest commit "ba91e7e5d15a (HEAD -> Base)
>>> selftests/mm: add tests for HWPOISON hugetlbfs read". The
>>> MADV_HWPOISON injection works and and the test passes:
>>>
>>>  ... HugeTLB read HWPOISON test...
>>>  ...  ... expect to read 0x101000 bytes of data in total
>>>  ...  !!! read failed: Input/output error
>>>  ...  ... actually read 0x101000 bytes of data in total
>>>  ... HugeTLB read HWPOISON test...TEST_PASSED
>>>  ... HugeTLB seek then read HWPOISON test...
>>>  ...  ... init val=4 with offset=0x102000
>>>  ...  ... expect to read 0xfe000 bytes of data in total
>>>  ...  ... actually read 0xfe000 bytes of data in total
>>>  ... HugeTLB seek then read HWPOISON test...TEST_PASSED
>>>  ...
>>>
>>> [ 2109.209225] Injecting memory failure for pfn 0x3190d01 at process
>>> virtual address 0x7f75e3101000
>>> [ 2109.209438] Memory failure: 0x3190d01: recovery action for huge
>>> page: Recovered
>>> ...
>>>
>>> I think something in between broken MADV_HWPOISON on hugetlbfs, and we
>>> should be able to figure it out via bisection (and of course by
>>> reading delta commits between them, probably related to page
>>> refcount).
>> Thank you for this information.
>>
>>>
>>> That being said, I will be on vacation from tomorrow until the end of
>>> next week. So I will get back to this after next weekend. Meanwhile if
>>> you want to go ahead and bisect the problematic commit, that will be
>>> very much appreciated.
>> I'll try to bisect and post here if I find something.
> Found the culprit commit by bisection:
> 
> a08c7193e4f18dc8508f2d07d0de2c5b94cb39a3
> mm/filemap: remove hugetlb special casing in filemap.c

#regzbot title: hugetlbfs hwpoison handling
#regzbot introduced: a08c7193e4f1
#regzbot monitor:
https://lore.kernel.org/all/20240111191655.295530-1-sidhartha.kumar@oracle.com

> 
> hugetlb-read-hwpoison started failing from this patch. I've added the
> author of this patch to this bug report.
> 
>>
>>>
>>> Thanks,
>>> Jiaqi
>>>
>>>
>>>>
>>>> Regards,
>>>> Usama
>>>>
> 

-- 
BR,
Muhammad Usama Anjum

