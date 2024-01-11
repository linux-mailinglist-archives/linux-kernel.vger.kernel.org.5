Return-Path: <linux-kernel+bounces-23244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E09B82A959
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1CDAB21064
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2152FBE9;
	Thu, 11 Jan 2024 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MyiOfUru"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA55F9DF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704962916;
	bh=gflHEkCtZCmwgfIS8rr2o7AExOCHAZTyAKAlUQhbSiA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=MyiOfUrumz7b5nTsabxHteMpzN7xlDrp6SKJZfTgbB1diocrBU8bbPm/U0n9X/BMs
	 iBFEJairFm1vyV/EJ2ZvCqkZPquIhRtiSehYH3WPA9B90oKLBtio/woDetCIBwptoY
	 hOkMwg1BpfMj8g4zLn1rS7sV/6Xzjr75TSqh8QG1WjRQnOZSshtDccDFSDTEXCcoP7
	 OCWc9fagZho7Kyz0OMHztf0mOCe4jUgER82vo8cCbErepO+UC2ErYZ5VBD+FN8n+FR
	 k0vlz19II9y6LpO+bL9YBt1lWrsZvJy3t5Rf74LWuApG+gDUBAJJV1b9PSaFxb2wcv
	 fCy1KPRXZo2DQ==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1B534378140A;
	Thu, 11 Jan 2024 08:48:31 +0000 (UTC)
Message-ID: <dd96e476-e1ad-4cb5-b5d1-556f720acd17@collabora.com>
Date: Thu, 11 Jan 2024 13:48:38 +0500
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
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v4 4/4] selftests/mm: add tests for HWPOISON hugetlbfs
 read
Content-Language: en-US
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>,
 Jiaqi Yan <jiaqiyan@google.com>
References: <20230713001833.3778937-1-jiaqiyan@google.com>
 <20230713001833.3778937-5-jiaqiyan@google.com>
 <be3976b5-0a9c-41c6-8160-88e6c1e5d63e@collabora.com>
 <CACw3F51WvZDVCpVg9j4j8WmnmAFOsnK+FZDDoVqhgLqVwhPTCA@mail.gmail.com>
 <e68488e4-764e-4b25-8a47-05bf8976bd19@collabora.com>
 <079335ab-190f-41f7-b832-6ffe7528fd8b@collabora.com>
 <a20e7bdb-7344-306d-e8f5-5ee69af7d5ea@oracle.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <a20e7bdb-7344-306d-e8f5-5ee69af7d5ea@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/11/24 7:32 AM, Sidhartha Kumar wrote:
> On 1/10/24 2:15 AM, Muhammad Usama Anjum wrote:
>> On 1/10/24 11:49 AM, Muhammad Usama Anjum wrote:
>>> On 1/6/24 2:13 AM, Jiaqi Yan wrote:
>>>> On Thu, Jan 4, 2024 at 10:27 PM Muhammad Usama Anjum
>>>> <usama.anjum@collabora.com> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> I'm trying to convert this test to TAP as I think the failures
>>>>> sometimes go
>>>>> unnoticed on CI systems if we only depend on the return value of the
>>>>> application. I've enabled the following configurations which aren't
>>>>> already
>>>>> present in tools/testing/selftests/mm/config:
>>>>> CONFIG_MEMORY_FAILURE=y
>>>>> CONFIG_HWPOISON_INJECT=m
>>>>>
>>>>> I'll send a patch to add these configs later. Right now I'm trying to
>>>>> investigate the failure when we are trying to inject the poison page by
>>>>> madvise(MADV_HWPOISON). I'm getting device busy every single time. The
>>>>> test
>>>>> fails as it doesn't expect any business for the hugetlb memory. I'm not
>>>>> sure if the poison handling code has issues or test isn't robust enough.
>>>>>
>>>>> ./hugetlb-read-hwpoison
>>>>> Write/read chunk size=0x800
>>>>>   ... HugeTLB read regression test...
>>>>>   ...  ... expect to read 0x200000 bytes of data in total
>>>>>   ...  ... actually read 0x200000 bytes of data in total
>>>>>   ... HugeTLB read regression test...TEST_PASSED
>>>>>   ... HugeTLB read HWPOISON test...
>>>>> [    9.280854] Injecting memory failure for pfn 0x102f01 at process
>>>>> virtual
>>>>> address 0x7f28ec101000
>>>>> [    9.282029] Memory failure: 0x102f01: huge page still referenced by
>>>>> 511
>>>>> users
>>>>> [    9.282987] Memory failure: 0x102f01: recovery action for huge
>>>>> page: Failed
>>>>>   ...  !!! MADV_HWPOISON failed: Device or resource busy
>>>>>   ... HugeTLB read HWPOISON test...TEST_FAILED
>>>>>
>>>>> I'm testing on v6.7-rc8. Not sure if this was working previously or not.
>>>>
>>>> Thanks for reporting this, Usama!
>>>>
>>>> I am also able to repro MADV_HWPOISON failure at "501a06fe8e4c
>>>> (akpm/mm-stable, mm-stable) zswap: memcontrol: implement zswap
>>>> writeback disabling."
>>>>
>>>> Then I checked out the earliest commit "ba91e7e5d15a (HEAD -> Base)
>>>> selftests/mm: add tests for HWPOISON hugetlbfs read". The
>>>> MADV_HWPOISON injection works and and the test passes:
>>>>
>>>>   ... HugeTLB read HWPOISON test...
>>>>   ...  ... expect to read 0x101000 bytes of data in total
>>>>   ...  !!! read failed: Input/output error
>>>>   ...  ... actually read 0x101000 bytes of data in total
>>>>   ... HugeTLB read HWPOISON test...TEST_PASSED
>>>>   ... HugeTLB seek then read HWPOISON test...
>>>>   ...  ... init val=4 with offset=0x102000
>>>>   ...  ... expect to read 0xfe000 bytes of data in total
>>>>   ...  ... actually read 0xfe000 bytes of data in total
>>>>   ... HugeTLB seek then read HWPOISON test...TEST_PASSED
>>>>   ...
>>>>
>>>> [ 2109.209225] Injecting memory failure for pfn 0x3190d01 at process
>>>> virtual address 0x7f75e3101000
>>>> [ 2109.209438] Memory failure: 0x3190d01: recovery action for huge
>>>> page: Recovered
>>>> ...
>>>>
>>>> I think something in between broken MADV_HWPOISON on hugetlbfs, and we
>>>> should be able to figure it out via bisection (and of course by
>>>> reading delta commits between them, probably related to page
>>>> refcount).
>>> Thank you for this information.
>>>
>>>>
>>>> That being said, I will be on vacation from tomorrow until the end of
>>>> next week. So I will get back to this after next weekend. Meanwhile if
>>>> you want to go ahead and bisect the problematic commit, that will be
>>>> very much appreciated.
>>> I'll try to bisect and post here if I find something.
>> Found the culprit commit by bisection:
>>
>> a08c7193e4f18dc8508f2d07d0de2c5b94cb39a3
>> mm/filemap: remove hugetlb special casing in filemap.c
>>
>> hugetlb-read-hwpoison started failing from this patch. I've added the
>> author of this patch to this bug report.
>>
> Hi Usama,
> 
> Thanks for pointing this out. After debugging, the below diff seems to fix
> the issue and allows the tests to pass again. Could you test it on your
> configuration as well just to confirm.
> 
> Thanks,
> Sidhartha
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 36132c9125f9..3a248e4f7e93 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -340,7 +340,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb,
> struct iov_iter *to)
>                 } else {
>                         folio_unlock(folio);
> 
> -                       if (!folio_test_has_hwpoisoned(folio))
> +                       if (!folio_test_hwpoison(folio))
>                                 want = nr;
>                         else {
>                                 /*
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index d8c853b35dbb..87f6bf7d8bc1 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -973,7 +973,7 @@ struct page_state {
>  static bool has_extra_refcount(struct page_state *ps, struct page *p,
>                                bool extra_pins)
>  {
> -       int count = page_count(p) - 1;
> +       int count = page_count(p) - folio_nr_pages(page_folio(p));
> 
>         if (extra_pins)
>                 count -= 1;
> 
Tested the patch, it fixes the test. Please send this patch.

Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

-- 
BR,
Muhammad Usama Anjum

