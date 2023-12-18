Return-Path: <linux-kernel+bounces-3276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D1D816A43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81DD21F22E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80E012B75;
	Mon, 18 Dec 2023 09:54:54 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CD112B6F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4StwCW2LZ7z1wnxH;
	Mon, 18 Dec 2023 17:54:31 +0800 (CST)
Received: from kwepemm000003.china.huawei.com (unknown [7.193.23.66])
	by mail.maildlp.com (Postfix) with ESMTPS id BB4431402E0;
	Mon, 18 Dec 2023 17:54:43 +0800 (CST)
Received: from [10.174.179.79] (10.174.179.79) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 17:54:42 +0800
Subject: Re: [PATCH 1/3] mm: HVO: introduce helper function to update and
 flush pgtable
To: Kefeng Wang <wangkefeng.wang@huawei.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <mike.kravetz@oracle.com>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>, <anshuman.khandual@arm.com>
CC: <willy@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20231214073912.1938330-1-sunnanyong@huawei.com>
 <20231214073912.1938330-2-sunnanyong@huawei.com>
 <f7950e7c-12b8-44b4-bfa9-fb2cb16944c0@huawei.com>
From: Nanyong Sun <sunnanyong@huawei.com>
Message-ID: <7a86f31d-475a-133e-fb79-3a1d6147372a@huawei.com>
Date: Mon, 18 Dec 2023 17:54:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f7950e7c-12b8-44b4-bfa9-fb2cb16944c0@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000003.china.huawei.com (7.193.23.66)


On 2023/12/15 14:16, Kefeng Wang wrote:
>
>
> On 2023/12/14 15:39, Nanyong Sun wrote:
>> Add pmd/pte update and tlb flush helper function to update page
>> table. This refactoring patch is designed to facilitate each
>> architecture to implement its own special logic in preparation
>> for the arm64 architecture to follow the necessary break-before-make
>> sequence when updating page tables.
>>
>> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
>> ---
>>   mm/hugetlb_vmemmap.c | 55 ++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 43 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>> index 87818ee7f01d..49e8b351def3 100644
>> --- a/mm/hugetlb_vmemmap.c
>> +++ b/mm/hugetlb_vmemmap.c
>> @@ -45,6 +45,37 @@ struct vmemmap_remap_walk {
>>       unsigned long        flags;
>>   };
>>   +#ifndef vmemmap_update_pmd
>> +static inline void vmemmap_update_pmd(unsigned long start,
>> +                      pmd_t *pmd, pte_t *pgtable)
>
> pgtable ->  ptep
Hi Kefeng，

Thank you for your review on this patch set, I'll fix them and send out 
the v2 version later.

>
>> +{
>> +    pmd_populate_kernel(&init_mm, pmd, pgtable);
>> +}
>> +#endif
>> +
>> +#ifndef vmemmap_update_pte
>> +static inline void vmemmap_update_pte(unsigned long addr,
>> +                      pte_t *pte, pte_t entry)
>
> pte   -> ptep
> entry -> pte
>
>> +{
>> +    set_pte_at(&init_mm, addr, pte, entry);
>> +}
>> +#endif
>
> .

