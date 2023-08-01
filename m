Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06DD76B316
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjHALXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbjHALXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:23:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C84DE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:22:17 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RFXjd3q0gzrS62;
        Tue,  1 Aug 2023 19:21:09 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 19:22:10 +0800
Message-ID: <4b5a3cfb-e13d-4df4-c08a-fb176cc2cbf6@huawei.com>
Date:   Tue, 1 Aug 2023 19:22:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/2] arm64: hugetlb: enable
 __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
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
        <linux-kernel@vger.kernel.org>, <21cnbao@gmail.com>
References: <20230801023145.17026-1-wangkefeng.wang@huawei.com>
 <20230801023145.17026-3-wangkefeng.wang@huawei.com>
 <ZMjn+68gKrdQSjMD@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZMjn+68gKrdQSjMD@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/1 19:09, Catalin Marinas wrote:
> On Tue, Aug 01, 2023 at 10:31:45AM +0800, Kefeng Wang wrote:
>> +#define __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
>> +static inline void flush_hugetlb_tlb_range(struct vm_area_struct *vma,
>> +					   unsigned long start,
>> +					   unsigned long end)
>> +{
>> +	unsigned long stride = huge_page_size(hstate_vma(vma));
>> +
>> +	if (stride != PMD_SIZE && stride != PUD_SIZE)
>> +		stride = PAGE_SIZE;
>> +	__flush_tlb_range(vma, start, end, stride, false, 0);
> 
> We could use some hints here for the tlb_level (2 for pmd, 1 for pud).
> Regarding the last_level argument to __flush_tlb_range(), I think it
> needs to stay false since this function is also called on the
> hugetlb_unshare_pmds() path where the pud is cleared and needs
> invalidating.
>  > That said, maybe you can rewrite it as a switch statement and call
> flush_pmd_tlb_range() or flush_pud_tlb_range() (just make sure these are
> defined when CONFIG_HUGETLBFS is enabled).
> 

How about this way, not involved with thp ？

diff --git a/arch/arm64/include/asm/hugetlb.h 
b/arch/arm64/include/asm/hugetlb.h
index e5c2e3dd9cf0..a7ce59d3388e 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -66,10 +66,22 @@ static inline void flush_hugetlb_tlb_range(struct 
vm_area_struct *vma,
                                            unsigned long end)
  {
         unsigned long stride = huge_page_size(hstate_vma(vma));
+       int tlb_level = 0;

-       if (stride != PMD_SIZE && stride != PUD_SIZE)
+       switch (stride) {
+#ifndef __PAGETABLE_PMD_FOLDED
+       case PUD_SIZE:
+               tlb_level = 1;
+               break;
+#endif
+       case PMD_SIZE:
+               tlb_level = 2;
+               break;
+       default:
                 stride = PAGE_SIZE;
-       __flush_tlb_range(vma, start, end, stride, false, 0);
+       }
+
+       __flush_tlb_range(vma, start, end, stride, false, tlb_level);
  }

