Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6A17C479C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344740AbjJKCHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344209AbjJKCHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:07:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9938C8E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 19:07:10 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S4wz42z8tzNp5w;
        Wed, 11 Oct 2023 10:03:12 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 11 Oct 2023 10:07:08 +0800
CC:     <yangyicong@hisilicon.com>, <maz@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <jonathan.cameron@huawei.com>,
        <prime.zeng@huawei.com>, <wanghuiqiang@huawei.com>,
        <wangwudi@hisilicon.com>, <guohanjun@huawei.com>,
        <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 0/3] Add HiSilicon system timer driver
To:     Mark Rutland <mark.rutland@arm.com>
References: <20231010123033.23258-1-yangyicong@huawei.com>
 <ZSVxNanrFunWZLNm@FVFF77S0Q05N.cambridge.arm.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <8238c143-5795-a975-1a71-c5e7d8ffa9a0@huawei.com>
Date:   Wed, 11 Oct 2023 10:07:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ZSVxNanrFunWZLNm@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/10 23:43, Mark Rutland wrote:
> Hi,
> 
> On Tue, Oct 10, 2023 at 08:30:30PM +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> HiSilicon system timer is a memory mapped platform timer compatible with
>> the arm's generic timer specification. The timer supports both SPI and
>> LPI interrupt and can be enumerated through ACPI DSDT table. Since the
>> timer is fully compatible with the spec, it can reuse most codes of the
>> arm_arch_timer driver. However since the arm_arch_timer driver only
>> supports GTDT and SPI interrupt, this series support the HiSilicon system
>> timer by:
>>
>> - refactor some of the arm_arch_timer codes and export the function to
>>   register a arch memory timer by other drivers
>> - retrieve the IO memory and interrupt resource through DSDT in a separate
>>   driver, then setup and register the clockevent device reuse the arm_arch_timer
>>   function
>>
>> Using LPI for the timer is mentioned in BSA Spec section 3.8.1 (DEN0094C 1.0C).
> 
> This seems like an oversight; there *should* be a generic way of describing
> this, and I've poked our BSA and ACPI architects to figure out how this is
> supposed to work. The lack of a way to do that seems like a major oversight and
> something that needs to be solved.
> 
> I'll try to get back to you shortly on that.
> 

Looking forward to the conclusion/solution.

> Regardless of that, I do not think this should be a separate driver, and I'm
> very much not keen on having vendor-specific companion drivers like this. Using
> LPIs isn't specific to HiSilicon, and this should be entirely common (and if we
> need a DSDT device, should use a common HID too).
> 

This is reasonable. Actually we're using most funtions of the arch timer driver, only
do the resource enumeration in the separate driver which is lack in the arch timer driver.
So if there's a common solution in the arch timer driver as well as a common HID we're
willing to use it.

Thanks.

> Thanks,
> Mark.
> 
>>
>> Yicong Yang (3):
>>   clocksource/drivers/arm_arch_timer: Split the function of
>>     __arch_timer_setup()
>>   clocksource/drivers/arm_arch_timer: Extend and export
>>     arch_timer_mem_register()
>>   clocksource/drivers: Add HiSilicon system timer driver
>>
>>  drivers/clocksource/Kconfig          |  10 +++
>>  drivers/clocksource/Makefile         |   1 +
>>  drivers/clocksource/arm_arch_timer.c | 123 +++++++++++++++------------
>>  drivers/clocksource/timer-hisi-sys.c |  68 +++++++++++++++
>>  include/clocksource/arm_arch_timer.h |   2 +
>>  5 files changed, 148 insertions(+), 56 deletions(-)
>>  create mode 100644 drivers/clocksource/timer-hisi-sys.c
>>
>> -- 
>> 2.24.0
>>
> 
> .
> 
