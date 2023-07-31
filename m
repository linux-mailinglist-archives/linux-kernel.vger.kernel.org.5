Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28850769498
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjGaLUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjGaLUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:20:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819981704
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:20:07 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RDwgl6lBszLnjT;
        Mon, 31 Jul 2023 19:17:23 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 19:20:03 +0800
Message-ID: <91863dc8-1f70-ba29-b36d-9261dd594574@huawei.com>
Date:   Mon, 31 Jul 2023 19:20:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/4] mm: mremap: use flush_pmd_tlb_range() in
 move_normal_pmd()
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Mina Almasry <almasrymina@google.com>, <kirill@shutemov.name>,
        <joel@joelfernandes.org>, <william.kucharski@oracle.com>,
        <kaleshsingh@google.com>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230731074829.79309-1-wangkefeng.wang@huawei.com>
 <20230731074829.79309-3-wangkefeng.wang@huawei.com>
 <ZMeVdcNcp76L8bOG@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZMeVdcNcp76L8bOG@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/31 19:05, Catalin Marinas wrote:
> On Mon, Jul 31, 2023 at 03:48:27PM +0800, Kefeng Wang wrote:
>> Archs may need to do special things when flushing thp tlb,
>> so use the more applicable flush_pud_tlb_range() instead of
>> flush_tlb_range().
>>
>> Fixes: 2c91bd4a4e2e ("mm: speed up mremap by 20x on large regions")
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   mm/mremap.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/mremap.c b/mm/mremap.c
>> index 11e06e4ab33b..1883205fa22b 100644
>> --- a/mm/mremap.c
>> +++ b/mm/mremap.c
>> @@ -284,7 +284,7 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>>   	VM_BUG_ON(!pmd_none(*new_pmd));
>>   
>>   	pmd_populate(mm, new_pmd, pmd_pgtable(pmd));
>> -	flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
>> +	flush_pmd_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
> 
> I don't think that's correct for arm64. The assumption in the
> flush_p*d_tlb_range() was that they are called only for block mappings
> at that p*d level (and we use FEAT_TTL on arm64 indicating that the leaf
> level is level 2 for pmd, 1 for pud). IIUC move_normal_pmd() is only
> called for table pmds which would have a leaf level of 3 (the pte).

oops, yes, this is for NORMAL_PMD case, not HPAGE_PMD, please ignore 
patch 2/3.

> 
> Same for the next patch doing the equivalent for the pud.
> 
