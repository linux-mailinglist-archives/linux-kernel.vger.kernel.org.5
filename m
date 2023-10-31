Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003287DD118
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344851AbjJaQBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344575AbjJaQBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:01:06 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656878F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:01:02 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4A150E000A;
        Tue, 31 Oct 2023 16:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698768061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=24crOmAGV5gUfVqlOxmYLP/ddZjqlVxYdyHg2VsyQaY=;
        b=dlWfSa+SJyOQ4M7DuBt4NIfu4tQoA9m6lMxsmF/4SyIzdShbhb04/nkwjUntsggLFuKNzL
        SSXry9qXlxO0Zwyd2ze7hZykC7EJz445bvs8mXynzgACdWD0IIf/Sz8J12KRp9juYtTO3t
        iGz1LHo2aK0QYVwcYh/DisSC8pPig706w7parsRfLGURM57h5dGIPgqQFFUCr0cHbKq9sT
        SJ0qJV6ZFHb4MB4aikmufSJh+tQbriGccyY6wS4DI3WVUfRc3Y94F6Fu3eSW3WPKF6OuOJ
        7KvJpvBPoNOogy5/hmD2af79Mo9Eph5Qpe//qSy8Z8kWO0JfQo439WWvA6ClNw==
Message-ID: <184d23fc-bb62-473c-8400-cda160aa44f3@bootlin.com>
Date:   Tue, 31 Oct 2023 17:00:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/ti-sci-intr: Add support for system
 suspend/resume PM
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
References: <20220607061912.12222-1-a-govindraju@ti.com>
 <87sfohyma5.wl-maz@kernel.org> <0733f59a-497a-351b-0e97-26a2875a5352@ti.com>
 <871qvzr01u.wl-maz@kernel.org>
From:   Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <871qvzr01u.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 11:12, Marc Zyngier wrote:
> On Wed, 08 Jun 2022 09:48:20 +0100,
> Aswath Govindraju <a-govindraju@ti.com> wrote:
>>
>> Hi Marc,
>>
>> On 07/06/22 12:48, Marc Zyngier wrote:
>>> On Tue, 07 Jun 2022 07:19:12 +0100,
>>> Aswath Govindraju <a-govindraju@ti.com> wrote:
>>>>
>>>> Add support for system level suspend/resume power management. The
>>>> interrupt mappings are stored in an array and restored in the system level
>>>> resume routine. Struct ti_sci_resource_desc can have atmost 2 sets for
>>>> ranges. Therefore, the mapping array is also formatted such that it can
>>>> store two sets of ranges.
>>>>
>>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>>> ---
>>>>  drivers/irqchip/irq-ti-sci-intr.c | 108 ++++++++++++++++++++++++++++++
>>>>  1 file changed, 108 insertions(+)
>>>>
>>>> diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
>>>> index fe8fad22bcf9..a8fc6cfb96ca 100644
>>>> --- a/drivers/irqchip/irq-ti-sci-intr.c
>>>> +++ b/drivers/irqchip/irq-ti-sci-intr.c
>>>> @@ -25,6 +25,7 @@
>>>>   * @dev:	Struct device pointer.
>>>>   * @ti_sci_id:	TI-SCI device identifier
>>>>   * @type:	Specifies the trigger type supported by this Interrupt Router
>>>> + * @mapping:	Pointer to out_irq <-> hwirq mapping table
>>>>   */
>>>>  struct ti_sci_intr_irq_domain {
>>>>  	const struct ti_sci_handle *sci;
>>>> @@ -32,6 +33,7 @@ struct ti_sci_intr_irq_domain {
>>>>  	struct device *dev;
>>>>  	u32 ti_sci_id;
>>>>  	u32 type;
>>>> +	u32 *mapping;
>>>>  };
>>>>  
>>>>  static struct irq_chip ti_sci_intr_irq_chip = {
>>>> @@ -99,6 +101,23 @@ static int ti_sci_intr_xlate_irq(struct ti_sci_intr_irq_domain *intr, u32 irq)
>>>>  	return -ENOENT;
>>>>  }
>>>>  
>>>> +/**
>>>> + * ti_sci_intr_free_irq - Free the irq entry in the out_irq <-> hwirq mapping table
>>>> + * @intr:	IRQ domain corresponding to Interrupt Router
>>>> + * @out_irq:	Out irq number
>>>> + */
>>>> +static void ti_sci_intr_free_irq(struct ti_sci_intr_irq_domain *intr, u16 out_irq)
>>>> +{
>>>> +	u16 start = intr->out_irqs->desc->start;
>>>> +	u16 num = intr->out_irqs->desc->num;
>>>> +	u16 start_sec = intr->out_irqs->desc->start_sec;
>>>> +
>>>> +	if (out_irq < start + num)
>>>> +		intr->mapping[out_irq - start] = 0xFFFFFFFF;
>>>> +	else
>>>> +		intr->mapping[out_irq - start_sec + num] = 0xFFFFFFFF;
>>>> +}
>>>> +
>>>>  /**
>>>>   * ti_sci_intr_irq_domain_free() - Free the specified IRQs from the domain.
>>>>   * @domain:	Domain to which the irqs belong
>>>> @@ -118,11 +137,30 @@ static void ti_sci_intr_irq_domain_free(struct irq_domain *domain,
>>>>  	intr->sci->ops.rm_irq_ops.free_irq(intr->sci,
>>>>  					   intr->ti_sci_id, data->hwirq,
>>>>  					   intr->ti_sci_id, out_irq);
>>>> +	ti_sci_intr_free_irq(intr, out_irq);
>>>>  	ti_sci_release_resource(intr->out_irqs, out_irq);
>>>>  	irq_domain_free_irqs_parent(domain, virq, 1);
>>>>  	irq_domain_reset_irq_data(data);
>>>>  }
>>>>  
>>>> +/**
>>>> + * ti_sci_intr_add_irq - Add the irq entry in the out_irq <-> hwirq mapping table
>>>> + * @intr:	IRQ domain corresponding to Interrupt Router
>>>> + * @hwirq:	Input irq number
>>>> + * @out_irq:	Out irq number
>>>> + */
>>>> +static void ti_sci_intr_add_irq(struct ti_sci_intr_irq_domain *intr, u32 hwirq, u16 out_irq)
>>>> +{
>>>> +	u16 start = intr->out_irqs->desc->start;
>>>> +	u16 num = intr->out_irqs->desc->num;
>>>> +	u16 start_sec = intr->out_irqs->desc->start_sec;
>>>> +
>>>> +	if (out_irq < start + num)
>>>> +		intr->mapping[out_irq - start] = hwirq;
>>>> +	else
>>>> +		intr->mapping[out_irq - start_sec + num] = hwirq;
>>>> +}
>>>
>>> I'll bite: you already have a full resource allocator that is used for
>>> all sort of things. Why isn't this cached by the resource allocator
>>> itself? Why is this an irqchip specific thing? I expect other users of
>>> the same API to have the same needs.
>>>
>>
>> As, the resource allocator does not have enough memory to save and
>> restore all the mappings corresponding various resources, this is being
>> done on the requester or consumer side.
> 
> You're missing the point: the ti_sci_resource structure is managed by
> this resource allocator, and it isn't exactly rocket science to add
> the required context to it, and then get it to restore that context on
> resume.

Hi Marc,

I'm interested to continue the work to upstream this patch.
I read all the thread, but I think I'm also missing the point.

Do you mean the ti_sci_intr_irq_domain struct is not the right place to
save the mappings, and it shall not be done in this irqchip driver?
The context should be saved and restored from the ti_sci driver using
the ti_sci_resource struct?

Am I on the right track?

Best Regards,

Thomas

> 
> This would actually give a sense of purpose to this stuff, which is
> otherwise pretty useless.
> 
> 	M.
> 


