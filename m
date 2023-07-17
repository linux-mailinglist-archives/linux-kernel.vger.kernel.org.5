Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEB57562AF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjGQM0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGQM0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:26:18 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD28E1;
        Mon, 17 Jul 2023 05:26:17 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R4Lrp2BrKz18LY9;
        Mon, 17 Jul 2023 20:25:30 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 20:26:11 +0800
CC:     <yangyicong@hisilicon.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <x86@kernel.org>, <mark.rutland@arm.com>, <ryan.roberts@arm.com>,
        <will@kernel.org>, <anshuman.khandual@arm.com>,
        <linux-doc@vger.kernel.org>, <corbet@lwn.net>,
        <peterz@infradead.org>, <arnd@arndb.de>,
        <punit.agrawal@bytedance.com>, <linux-kernel@vger.kernel.org>,
        <darren@os.amperecomputing.com>, <huzhanyuan@oppo.com>,
        <lipeifeng@oppo.com>, <zhangshiming@oppo.com>, <guojian@oppo.com>,
        <realmz6@gmail.com>, <linux-mips@vger.kernel.org>,
        <openrisc@lists.librecores.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
        Barry Song <21cnbao@gmail.com>, <wangkefeng.wang@huawei.com>,
        <xhao@linux.alibaba.com>, <prime.zeng@hisilicon.com>,
        <Jonathan.Cameron@huawei.com>, Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v10 4/4] arm64: support batched/deferred tlb shootdown
 during page reclamation/migration
To:     Catalin Marinas <catalin.marinas@arm.com>
References: <20230710083914.18336-1-yangyicong@huawei.com>
 <20230710083914.18336-5-yangyicong@huawei.com> <ZLQIvPpKvjWppc59@arm.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <9438aa19-8eb5-a36a-c4a0-6c8333665637@huawei.com>
Date:   Mon, 17 Jul 2023 20:26:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ZLQIvPpKvjWppc59@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
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

On 2023/7/16 23:11, Catalin Marinas wrote:
> On Mon, Jul 10, 2023 at 04:39:14PM +0800, Yicong Yang wrote:
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 7856c3a3e35a..f0ce8208c57f 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -96,6 +96,7 @@ config ARM64
>>  	select ARCH_SUPPORTS_NUMA_BALANCING
>>  	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
>>  	select ARCH_SUPPORTS_PER_VMA_LOCK
>> +	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if EXPERT
> 
> I don't want EXPERT to turn on a feature that's not selectable by the
> user. This would lead to different performance behaviour based on
> EXPERT. Just select it unconditionally.

Got it. will drop it and address the comment below.

Thanks.

> 
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index 412a3b9a3c25..4bb9cec62e26 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -254,17 +254,23 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
>>  	dsb(ish);
>>  }
>>  
>> -static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
>> -					 unsigned long uaddr)
>> +static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
>> +					   unsigned long uaddr)
>>  {
>>  	unsigned long addr;
>>  
>>  	dsb(ishst);
>> -	addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
>> +	addr = __TLBI_VADDR(uaddr, ASID(mm));
>>  	__tlbi(vale1is, addr);
>>  	__tlbi_user(vale1is, addr);
>>  }
>>  
>> +static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
>> +					 unsigned long uaddr)
>> +{
>> +	return __flush_tlb_page_nosync(vma->vm_mm, uaddr);
>> +}
>> +
>>  static inline void flush_tlb_page(struct vm_area_struct *vma,
>>  				  unsigned long uaddr)
>>  {
>> @@ -272,6 +278,42 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
>>  	dsb(ish);
>>  }
>>  
>> +#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> 
> If it's selected unconditionally, we won't need this #ifdef here.
> 
>> +
>> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
>> +{
>> +#ifdef CONFIG_ARM64_WORKAROUND_REPEAT_TLBI
>> +	/*
>> +	 * TLB flush deferral is not required on systems, which are affected with
> 
> "affected by" and drop the comma before "which".
> 
