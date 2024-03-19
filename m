Return-Path: <linux-kernel+bounces-107456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D9187FCC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020F528427C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8906B7EEEA;
	Tue, 19 Mar 2024 11:26:36 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDFB54FAB;
	Tue, 19 Mar 2024 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847596; cv=none; b=qSkmsC0fO58d/TZQWhM6aOIUaHGqN04lWxybxXvSSIf1UYv5TpRPnd14G2jwMUT/Tndv+18BE9y5RS4Sr6LPx4TAD7BDrGEV2ev4YEdcsWgL28vJ+xXi2AXAl4tk5Z42ElCEhITRAbrYcTGPWS17cD+HFZCVmc/CbhutIn+OOww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847596; c=relaxed/simple;
	bh=UDoNhCNX9cLIwDHxTiLG6Mn94hXAJaVESaCEt/McFi0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NVVSWrR3ahrvDXSFb2YyuaC0GolQKU/vZ1QHs6dE4Zx6XjmYCcFzhZ8k1dfAePL7t8S4sTndXIePnnuzJMjxi+tBWFjt6wC+cSj1SYdWUbtn2GdBG4kyO9PTXQs5xnnoN1sWNKRBHHHy6/Iwm60pncNqvPTUIfL+RhnfAxymGCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8AxDOtldvll87waAA--.54120S3;
	Tue, 19 Mar 2024 19:26:29 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx8ORjdvllXmddAA--.49291S3;
	Tue, 19 Mar 2024 19:26:29 +0800 (CST)
Subject: Re: [PATCH V2] irqchip/loongson-pch-pic: Update interrupt
 registration policy
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 chenhuacai@kernel.org, jiaxun.yang@flygoat.com, tglx@linutronix.de
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Baoqi Zhang <zhangbaoqi@loongson.cn>, Biao Dong <dongbiao@loongson.cn>
References: <20240316082141.26139-1-zhangtianyang@loongson.cn>
 <0fda46c7-87e1-41f1-b3f0-ee3d1a4ac601@wanadoo.fr>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <45b36854-fd80-a410-6cca-f3b776566de6@loongson.cn>
Date: Tue, 19 Mar 2024 19:26:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0fda46c7-87e1-41f1-b3f0-ee3d1a4ac601@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:AQAAf8Bx8ORjdvllXmddAA--.49291S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr1UXryDJr1UAr48ZF47GFX_yoWruw1xpF
	4kJrWUJryUJr18Jr1kJr1UJFy5Ar1UJ3WDGr18XF1UJw17Jr1jgr17Wr1qgr1UJr48Jr1U
	Jr1jqr17ur17JFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5xhLUUUUU=

Hi Christophe

This part of the code is not a hotspot path. In fact, it may only be 
executed once at startup,

so some optimizations that we consider extreme can be omitted

Tianyang

在 2024/3/16 下午10:03, Christophe JAILLET 写道:
> Le 16/03/2024 à 09:21, Tianyang Zhang a écrit :
>> From: Baoqi Zhang <zhangbaoqi@loongson.cn>
>>
>> This patch remove the fixed mapping between the 7A interrupt source
>> and the HT interrupt vector, and replaced it with a dynamically
>> allocated approach.
>>
>> We introduce a mapping table in struct pch_pic, where each interrupt
>> source will allocate an index as a 'hwirq' from the table in the order
>> of application and set table value as interrupt source number. This 
>> hwirq
>> will be configured as its vector in the HT interrupt controller. For an
>> interrupt source, the validity period of the obtained hwirq will last 
>> until
>> the system reset
>>
>> This will be more conducive to fully utilizing existing vectors to
>> support more devices
>>
>> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
>> Signed-off-by: Biao Dong <dongbiao@loongson.cn>
>> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
>> ---
>>   drivers/irqchip/irq-loongson-pch-pic.c | 77 ++++++++++++++++++++------
>>   1 file changed, 59 insertions(+), 18 deletions(-)
>>
>
> ...
>
>> @@ -171,6 +183,27 @@ static int pch_pic_domain_translate(struct 
>> irq_domain *d,
>>               return -EINVAL;
>>             *hwirq = fwspec->param[0] - priv->gsi_base;
>> +
>> +        raw_spin_lock_irqsave(&priv->pic_lock, flags);
>> +        /* Check pic-table to confirm if the hwirq has been assigned */
>> +        for (i = 0; i < priv->inuse; i++) {
>> +            if (priv->table[i] == *hwirq) {
>> +                *hwirq = i;
>> +                break;
>> +            }
>> +        }
>> +        if (i == priv->inuse) {
>> +            /* Assign a new hwirq in pic-table */
>> +            if (priv->inuse >= PIC_COUNT) {
>> +                pr_err("pch-pic domain has no free vectors\n");
>> + raw_spin_unlock_irqrestore(&priv->pic_lock, flags);
>> +                return -EINVAL;
>> +            }
>> +            priv->table[priv->inuse] = *hwirq;
>> +            *hwirq = priv->inuse++;
>> +        }
>> +        raw_spin_unlock_irqrestore(&priv->pic_lock, flags);
>
> Hi,
>
> not sure if it helps or if this is a hot path, but, IIUC, taking the 
> lock could be avoided with some code reordering and 'inuse' being an 
> atomic_t.
>
> IIUC, the lock is only needed to protect 'inuse' and 'table' is never 
> modified afterwards.
>
> Somehing like:
>
> > +        int cur_inuse;
>         ...
> > +        cur_inuse = atomic_read(&priv->inuse);
> > +        /* Check pic-table to confirm if the hwirq has been 
> assigned */
> > +        for (i = 0; i < cur_inuse; i++) {
> > +            if (priv->table[i] == *hwirq) {
> > +                *hwirq = i;
> > +                break;
> > +            }
> > +        }
> > +        if (i == cur_inuse) {
> > +            /* Assign a new hwirq in pic-table */
> > +            if (cur_inuse >= PIC_COUNT) {
> > +                pr_err("pch-pic domain has no free vectors\n");
> > +                return -EINVAL;
> > +            }
> > +            priv->table[cur_inuse] = *hwirq;
> > +            *hwirq = atomic_inc_return(&priv->inuse);
> > +        }
>
>
>> +
>>           if (fwspec->param_count > 1)
>>               *type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
>>           else
>> @@ -194,6 +227,9 @@ static int pch_pic_alloc(struct irq_domain 
>> *domain, unsigned int virq,
>>       if (err)
>>           return err;
>>   +    /* Write vector ID */
>> +    writeb(priv->ht_vec_base + hwirq, priv->base + 
>> PCH_INT_HTVEC(hwirq_to_bit(priv, hwirq)));
>> +
>>       parent_fwspec.fwnode = domain->parent->fwnode;
>>       parent_fwspec.param_count = 1;
>>       parent_fwspec.param[0] = hwirq + priv->ht_vec_base;
>
> ...


