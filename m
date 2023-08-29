Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7EF78C0F6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjH2JFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbjH2JF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:05:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62B2139
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:05:22 -0700 (PDT)
Received: from dggpeml500019.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RZhHq6s2nzJsFB;
        Tue, 29 Aug 2023 17:01:43 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 29 Aug
 2023 17:05:20 +0800
Message-ID: <087f1c16-7e40-9801-e63d-72a0135d99a4@hisilicon.com>
Date:   Tue, 29 Aug 2023 17:05:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] irqdomain: Fix driver re-inserting failures when IRQs not
 being freed completely
To:     Thomas Gleixner <tglx@linutronix.de>, <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <prime.zeng@hisilicon.com>, <liyihang6@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <shenyang39@huawei.com>,
        <qianweili@huawei.com>
References: <20230720122429.4123447-1-zhanjie9@hisilicon.com>
 <87msyfatoq.ffs@tglx>
From:   Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <87msyfatoq.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/08/2023 02:00, Thomas Gleixner wrote:
> On Thu, Jul 20 2023 at 20:24, Jie Zhan wrote:
>> Since commit 4615fbc3788d ("genirq/irqdomain: Don't try to free an
>> interrupt that has no mapping"), we have found failures when
>> re-inserting some specific drivers:
>>
>> [root@localhost ~]# rmmod hisi_sas_v3_hw
>> [root@localhost ~]# modprobe hisi_sas_v3_hw
>> [ 1295.622525] hisi_sas_v3_hw: probe of 0000:30:04.0 failed with error -2
>>
>> This comes from the case where some IRQs allocated from a low-level domain,
>> e.g. GIC ITS, are not freed completely, leaving some leaked. Thus, the next
>> driver insertion fails to get the same number of IRQs because some IRQs are
>> still occupied.
> Why?
>
>> Free a contiguous group of IRQs in one go to fix this issue.
> Again why?
>
>> @@ -1445,13 +1445,24 @@ static void irq_domain_free_irqs_hierarchy(struct irq_domain *domain,
>>   					   unsigned int nr_irqs)
>>   {
>>   	unsigned int i;
>> +	int n;
>>   
>>   	if (!domain->ops->free)
>>   		return;
>>   
>>   	for (i = 0; i < nr_irqs; i++) {
>> -		if (irq_domain_get_irq_data(domain, irq_base + i))
>> -			domain->ops->free(domain, irq_base + i, 1);
>> +		/* Find the largest possible span of IRQs to free in one go */
>> +		for (n = 0;
>> +			((i + n) < nr_irqs) &&
>> +			 (irq_domain_get_irq_data(domain, irq_base + i + n));
>> +			n++)
>> +			;
> For one this is unreadable gunk. But what's worse it still does not
> explain what this is solving.
>
> It's completely sensible to expect that freeing interrupts in a range
> one by one just works.
>
> So why do we need to work around an obvious low level failure in the
> core code?
>
> Thanks,
>
>          tglx

Hi Thomas,

Many thanks for taking a look.

I believe this patch should be completely reworked as it has caused many 
questions
in the first place --- it's not explaining itself well. Please ignore 
this one now.

The story of the problem is a bit long and complicated. The previous 
disscusion can
be found in the link attached.

Jie

