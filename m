Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4704B7C54F9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbjJKNK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjJKNKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:10:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B965F8F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:10:22 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S5Cjt2FQ4zrT8m;
        Wed, 11 Oct 2023 21:07:46 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 11 Oct 2023 21:10:20 +0800
CC:     <yangyicong@hisilicon.com>, Marc Zyngier <maz@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <jonathan.cameron@huawei.com>,
        <prime.zeng@huawei.com>, <wanghuiqiang@huawei.com>,
        <wangwudi@hisilicon.com>, <guohanjun@huawei.com>,
        <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 0/3] Add HiSilicon system timer driver
To:     Mark Rutland <mark.rutland@arm.com>
References: <20231010123033.23258-1-yangyicong@huawei.com>
 <874jiymo2l.wl-maz@kernel.org>
 <a170493f-cd9f-a0d9-432a-2ae07d18d429@huawei.com>
 <ZSZ7OiySl1wcG3CD@FVFF77S0Q05N.cambridge.arm.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <a6597f6f-2a6f-7c04-b3b8-1fd2b7b394e1@huawei.com>
Date:   Wed, 11 Oct 2023 21:10:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ZSZ7OiySl1wcG3CD@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Hi Mark,

On 2023/10/11 18:38, Mark Rutland wrote:
> On Wed, Oct 11, 2023 at 10:10:11AM +0800, Yicong Yang wrote:
>> On 2023/10/11 0:36, Marc Zyngier wrote:
>>> On Tue, 10 Oct 2023 13:30:30 +0100,
>>> Yicong Yang <yangyicong@huawei.com> wrote:
>>>>
>>>> From: Yicong Yang <yangyicong@hisilicon.com>
>>>>
>>>> HiSilicon system timer is a memory mapped platform timer compatible with
>>>> the arm's generic timer specification. The timer supports both SPI and
>>>> LPI interrupt and can be enumerated through ACPI DSDT table. Since the
>>>> timer is fully compatible with the spec, it can reuse most codes of the
>>>> arm_arch_timer driver. However since the arm_arch_timer driver only
>>>> supports GTDT and SPI interrupt, this series support the HiSilicon system
>>>> timer by:
>>>>
>>>> - refactor some of the arm_arch_timer codes and export the function to
>>>>   register a arch memory timer by other drivers
>>>> - retrieve the IO memory and interrupt resource through DSDT in a separate
>>>>   driver, then setup and register the clockevent device reuse the arm_arch_timer
>>>>   function
>>>>
>>>> Using LPI for the timer is mentioned in BSA Spec section 3.8.1 (DEN0094C 1.0C).
>>>
>>> This strikes me as pretty odd. LPIs are, by definition, *edge*
>>> triggered. The timer interrupt must be *level* triggered. So there
>>> must be some bridge in the middle that is going to regenerate edges on
>>> EOI, and that cannot be architectural.
>>>
>>> What am I missing?
>>
>> In our case, if the timer is working on LPI mode, it's not directly connected
>> to the GIC. It'll be wired to hisi-mbigen irqchip which will send LPIs to the
>> GIC.
> 
> In that case, the timerr itself isn't using an LPI: it's wired to a secondary
> interrupt controller, and the secondary interrupt controller is using an LPI.
> 
> The BSA doesn't describe that as a permitted configuration.
> 
> I think there are two problems here:
> 
> (1) The BSA spec is wrong, and shouldn't say "or LPI" here as it simply doesn't
>     make sense.
> 
>     I think this should be fixed by removing the "or LPI" wording form the BSA
>     spec for this interrupt.
> 
> (2) This platform is not compatible with the BSA, and is not compatible with
>     the existing ACPI bindings in the GTDT.
> 
> Do you actually need this wakeup timer?
> 

Thanks for the quick feedback!

So the LPI timer mentioned in the BSA spec is probably a mistake and our LPI
mode is not compatible to the BSA spec. Then I need to discuss with my team
and re-evaluate the solution for the LPI mode of the timer.

Thanks,
Yicong
