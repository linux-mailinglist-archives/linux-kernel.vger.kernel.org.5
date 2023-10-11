Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF49D7C479F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344748AbjJKCKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344209AbjJKCKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:10:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8088E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 19:10:14 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S4x2c0KNlzNp95;
        Wed, 11 Oct 2023 10:06:16 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 11 Oct 2023 10:10:11 +0800
CC:     <yangyicong@hisilicon.com>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <jonathan.cameron@huawei.com>,
        <prime.zeng@huawei.com>, <wanghuiqiang@huawei.com>,
        <wangwudi@hisilicon.com>, <guohanjun@huawei.com>,
        <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 0/3] Add HiSilicon system timer driver
To:     Marc Zyngier <maz@kernel.org>
References: <20231010123033.23258-1-yangyicong@huawei.com>
 <874jiymo2l.wl-maz@kernel.org>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <a170493f-cd9f-a0d9-432a-2ae07d18d429@huawei.com>
Date:   Wed, 11 Oct 2023 10:10:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <874jiymo2l.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2023/10/11 0:36, Marc Zyngier wrote:
> On Tue, 10 Oct 2023 13:30:30 +0100,
> Yicong Yang <yangyicong@huawei.com> wrote:
>>
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
> This strikes me as pretty odd. LPIs are, by definition, *edge*
> triggered. The timer interrupt must be *level* triggered. So there
> must be some bridge in the middle that is going to regenerate edges on
> EOI, and that cannot be architectural.
> 
> What am I missing?

In our case, if the timer is working on LPI mode, it's not directly connected
to the GIC. It'll be wired to hisi-mbigen irqchip which will send LPIs to the
GIC.

Thanks.
