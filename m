Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B0D79FFB3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbjINJJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbjINJJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:09:25 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B1530CD;
        Thu, 14 Sep 2023 02:08:45 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38E4F14n000879;
        Thu, 14 Sep 2023 11:08:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=19/t/7aa3tjI7A+p++1QXECy1ZjoXC8SO7oXAgid7Sc=; b=u3
        x4KHbO52/oq3U66cUFVWVm7f45NKHDyjrgZ5+mnwiFdJfanA+4PaQNLZ+wTP21Gg
        is6c/bjxfH9SAMkK3wcKg6VqMb7+nSEiTZs+lh2jBonWYcowJZX5vGS8t193KtKv
        fbSuBSARQ0/R5TEj7jMRNAHQpyhymD0BouS/4wZhWFNyUyiN93t+2f978bjybZam
        XfQ0PUYbZORaaSDQskqMHClEaM8jNbSgBxbI93Yn78jc2uYeBWOOSUQXRKh/yD66
        9vZPrZkHlaHhLFfhuhcPIR0IEbjgHJ/1GNGVYUKayrD2TSJcbG6fMr4izIyK553L
        rK3C4dM0ZYO146SjuDug==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t3tyw18gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 11:08:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D609E10005A;
        Thu, 14 Sep 2023 11:08:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BE640227EFD;
        Thu, 14 Sep 2023 11:08:13 +0200 (CEST)
Received: from [10.201.20.125] (10.201.20.125) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 11:08:12 +0200
Message-ID: <ab2f88c3-2f80-a0ae-3a74-d90dd2a6ccf3@foss.st.com>
Date:   Thu, 14 Sep 2023 11:08:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] mmc: mmci: stm32: add SDIO in-band interrupt mode
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Rob Herring <robh@kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230901120836.1057900-1-yann.gautier@foss.st.com>
 <CACRpkdacRe5cPoSFJyEdo6nZrtmUHTNqMxf55CntvsdpFqhhrQ@mail.gmail.com>
 <CAPDyKFqJzoBiG4c2NbXA_6YDNsAh4W0TO-SP9+C2Qw40TKVH7g@mail.gmail.com>
Content-Language: en-US
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <CAPDyKFqJzoBiG4c2NbXA_6YDNsAh4W0TO-SP9+C2Qw40TKVH7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.125]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_07,2023-09-13_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/23 14:21, Ulf Hansson wrote:
> On Fri, 1 Sept 2023 at 16:10, Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> Hi Yann/Christophe,
>>
>> thanks for your patch!
>>
>> On Fri, Sep 1, 2023 at 2:08 PM Yann Gautier <yann.gautier@foss.st.com> wrote:
>>
>>> From: Christophe Kerello <christophe.kerello@foss.st.com>
>>>
>>> Add the support of SDIO in-band interrupt mode for STM32 variant.
>>> It allows the SD I/O card to interrupt the host on SDMMC_D1 data line.
>>>
>>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
>> (...)
>>> +++ b/drivers/mmc/host/mmci.h
>>> @@ -332,6 +332,7 @@ enum mmci_busy_state {
>>>    * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
>>>    * @dma_lli: true if variant has dma link list feature.
>>>    * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
>>> + * @use_sdio_irq: allow SD I/O card to interrupt the host
>>
>> The documentation tag should be one line up (compare to the members...)
>>
>>> @@ -376,6 +377,7 @@ struct variant_data {
>>>          u32                     start_err;
>>>          u32                     opendrain;
>>>          u8                      dma_lli:1;
>>> +       u8                      use_sdio_irq:1;
>>
>> 1. bool use_sdio_irq;
>>
Hi,

Should it really be changed to a bool?
Other boolean likes in the structure are u8:1.

>> 2. supports_sdio_irq is more to the point don't you think?
>>      Especially since it activates these two callbacks:
>>
>>> +       void (*enable_sdio_irq)(struct mmci_host *host, int enable);
>>> +       void (*sdio_irq)(struct mmci_host *host, u32 status);
>>
>> Further: all the Ux500 variants support this (bit 22) as well, so enable those
>> too in their vendor data. All I have is out-of-band signaling with an GPIO IRQ
>> on my Broadcom chips but I think it works (maybe Ulf has tested it in the
>> far past).
> 
> For the ux500 variant there is a HW problem. After running some stress
> tests, we may end up being stuck waiting for an SDIO IRQ to be
> delivered. Even if the SDIO irqs should be considered level triggered,
> it looked like it was implemented in the HW as an edge triggered IRQ.
> 
> The downstream workaround consisted of re-routing the DAT1 to a GPIO
> at runtime suspend (we wanted that for optimal power save support
> anyway) - and manually checking if the DAT1 line was asserted, before
> enabling the GPIO line for an irq. This worked perfectly fine as a
> workaround, with the limitation that one may observe a little bit of
> hick-up in the traffic occasionally.
> 
> That said, the out-of-band IRQs is what works best for the ux500 variants.

What I understand here is that in-band interrupts are not properly 
working on ux500, and then the feature shouldn't be enabled for this 
platform.
Am I correct?

If this is the case, the v2 will consist in changing the use_sdio_irq to 
use_sdio_irq, and update the comment of the struct.
And depending on the answer, maybe change the field to bool.

Best regards,
Yann
> 
> Kind regards
> Uffe

