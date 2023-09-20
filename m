Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DDF7A7553
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjITIHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjITIHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:07:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3276D97
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:07:33 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rr9ym5zlKzNmPB;
        Wed, 20 Sep 2023 16:03:44 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 20 Sep 2023 16:07:30 +0800
Message-ID: <23abf32a-3f34-426f-a918-2af37b409329@huawei.com>
Date:   Wed, 20 Sep 2023 16:07:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] mm: memory: add vm_normal_pmd_folio()
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <willy@infradead.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>
References: <20230918103213.4166210-1-wangkefeng.wang@huawei.com>
 <20230918103213.4166210-6-wangkefeng.wang@huawei.com>
 <87pm2dwna0.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <87pm2dwna0.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/20 11:12, Huang, Ying wrote:
> Kefeng Wang <wangkefeng.wang@huawei.com> writes:
> 
>> The new vm_normal_pmd_folio() wrapper is similar to vm_normal_folio(),
>> which allow them to completely replace the struct page variables with
>> struct folio variables.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   include/linux/mm.h |  2 ++
>>   mm/memory.c        | 10 ++++++++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 12335de50140..7d05ec047186 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2327,6 +2327,8 @@ struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
>>   			     pte_t pte);
>>   struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>>   			     pte_t pte);
>> +struct folio *vm_normal_pmd_folio(struct vm_area_struct *vma, unsigned long addr,
>> +				  pmd_t pmd);
>>   struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>>   				pmd_t pmd);
> 
> Why do not follow the counterpart of page (vm_normal_page_pmd()) to be
> vm_normal_folio_pmd()?

Personally, X_pmd_folio seems to get folio from a pmd, but X_folio_pmd 
looks like "return the PMD of a folio", I could use 
vm_normal_folio_pmd() for consistency, thanks.
