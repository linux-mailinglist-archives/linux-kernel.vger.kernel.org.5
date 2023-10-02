Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FE67B4C75
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbjJBHTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbjJBHTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:19:03 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36B28E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:18:59 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3EE534000D;
        Mon,  2 Oct 2023 07:18:52 +0000 (UTC)
Message-ID: <96984fd2-2e3b-d861-5555-5b5a4e5c55d6@ghiti.fr>
Date:   Mon, 2 Oct 2023 09:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH -fixes 2/2] riscv: Fix set_huge_pte_at() for NAPOT
 mappings when a swap entry is set
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230928151846.8229-1-alexghiti@rivosinc.com>
 <20230928151846.8229-3-alexghiti@rivosinc.com>
 <20230930-unnoticed-slacked-0bf5696cc265@spud>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230930-unnoticed-slacked-0bf5696cc265@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On 30/09/2023 11:14, Conor Dooley wrote:
> On Thu, Sep 28, 2023 at 05:18:46PM +0200, Alexandre Ghiti wrote:
>> We used to determine the number of page table entries to set for a NAPOT
>> hugepage by using the pte value which actually fails when the pte to set is
>> a swap entry.
>>
>> So take advantage of a recent fix for arm64 reported in [1] which
>> introduces the size of the mapping as an argument of set_huge_pte_at(): we
>> can then use this size to compute the number of page table entries to set
>> for a NAPOT region.
>>
>> Fixes: 82a1a1f3bfb6 ("riscv: mm: support Svnapot in hugetlb page")
>> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
>> Closes: https://lore.kernel.org/linux-arm-kernel/20230922115804.2043771-1-ryan.roberts@arm.com/ [1]
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Breaks the build. Your $subject marks this for -fixes, but this will not
> build there, as it relies on content that's not yet in that branch.
> AFAICT, you're going to have to resend this with akpm on CC, as the
> dependency is in his tree...


I see, but I still don't understand why -fixes does not point to the 
latest rcX instead of staying on rc1? The patch which this series 
depends on just made it to rc4.

Thanks,

Alex


> Thanks,
> Conor.
>
>> ---
>>   arch/riscv/mm/hugetlbpage.c | 19 +++++++++++++------
>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
>> index e4a2ace92dbe..b52f0210481f 100644
>> --- a/arch/riscv/mm/hugetlbpage.c
>> +++ b/arch/riscv/mm/hugetlbpage.c
>> @@ -183,15 +183,22 @@ void set_huge_pte_at(struct mm_struct *mm,
>>   		     pte_t pte,
>>   		     unsigned long sz)
>>   {
>> +	unsigned long hugepage_shift;
>>   	int i, pte_num;
>>   
>> -	if (!pte_napot(pte)) {
>> -		set_pte_at(mm, addr, ptep, pte);
>> -		return;
>> -	}
>> +	if (sz >= PGDIR_SIZE)
>> +		hugepage_shift = PGDIR_SHIFT;
>> +	else if (sz >= P4D_SIZE)
>> +		hugepage_shift = P4D_SHIFT;
>> +	else if (sz >= PUD_SIZE)
>> +		hugepage_shift = PUD_SHIFT;
>> +	else if (sz >= PMD_SIZE)
>> +		hugepage_shift = PMD_SHIFT;
>> +	else
>> +		hugepage_shift = PAGE_SHIFT;
>>   
>> -	pte_num = napot_pte_num(napot_cont_order(pte));
>> -	for (i = 0; i < pte_num; i++, ptep++, addr += PAGE_SIZE)
>> +	pte_num = sz >> hugepage_shift;
>> +	for (i = 0; i < pte_num; i++, ptep++, addr += (1 << hugepage_shift))
>>   		set_pte_at(mm, addr, ptep, pte);
>>   }
>>   
>> -- 
>> 2.39.2
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
