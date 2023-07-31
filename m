Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C46E7694C0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjGaL1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjGaL1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:27:19 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB99C9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:27:18 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RDwsz6y5Lz1GDJw;
        Mon, 31 Jul 2023 19:26:15 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 19:27:14 +0800
Message-ID: <70e81ce8-a27a-325f-68d1-836532ed2ba0@huawei.com>
Date:   Mon, 31 Jul 2023 19:27:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 4/4] arm64: tlb: set huge page size to stride for hugepage
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
 <20230731074829.79309-5-wangkefeng.wang@huawei.com>
 <ZMeW5jcsYgisxsoJ@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZMeW5jcsYgisxsoJ@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/31 19:11, Catalin Marinas wrote:
> On Mon, Jul 31, 2023 at 03:48:29PM +0800, Kefeng Wang wrote:
>> +/*
>> + * We cannot use leaf-only invalidation here, since we may be invalidating
>> + * table entries as part of collapsing hugepages or moving page tables.
>> + * Set the tlb_level to 0 because we can not get enough information here.
>> + */
>> +#define flush_tlb_range(vma, start, end)				\
>> +	__flush_tlb_range(vma, start, end,				\
>> +				((vma)->vm_flags & VM_HUGETLB)		\
>> +				? huge_page_size(hstate_vma(vma))	\
>> +				: PAGE_SIZE, false, 0)
> 
> This won't work if we use the contiguous PTE to get 64K hugetlb pages on
> a 4K base page configuration. The 16 base pages in the range would have
> to be invalidated individually (the contig PTE bit is just a hint, the
> hardware may or may not take it into account).

Got it, the contig huge page is depended on hardware implementation,
but for normal hugepage(2M/1G), we could use this, right?
> 
