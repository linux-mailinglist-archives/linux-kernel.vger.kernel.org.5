Return-Path: <linux-kernel+bounces-43893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23388841A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D92283393
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C7C374D1;
	Tue, 30 Jan 2024 03:23:35 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE0337171;
	Tue, 30 Jan 2024 03:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706585015; cv=none; b=EO5BTrYfqQyrVQYvfXlQmTSNlKnkOdafk2v97Wiv5H83jWx2vfqtGlqreScwdwMks9zq50QSnoYw7YeK5yQg8DnI/AYOoeECEdB61+u/6C1IsmB8OrX9dUeg0A8LqfzgVQ+xQs5RrFr3/xRLMzpP/nvgYWVkEojFXBDm1zbKy3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706585015; c=relaxed/simple;
	bh=JixfZLRBAcL76btxusE3CiEUz0Lzxhmpuqg1wOtqKLQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WFF9y2ISgVrOMmJ66UoVKp1rEdGV2lTFNlsfIOxK3xQdE3+6+4Lq7YYEmIeg9NCZWLapNueYSvLFcBxsTcJYn7fVIBmj1dDOhNoxesnKYgMmYwPItBHXLo1uOvKAbYXB8NvqigzYlVvjvB+y+EWDoOuDtinNZExeKNvnBrSB0R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8CxifCza7hlNyoIAA--.25382S3;
	Tue, 30 Jan 2024 11:23:31 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxZMyxa7hlQzsnAA--.28908S3;
	Tue, 30 Jan 2024 11:23:29 +0800 (CST)
Subject: Re: [PATCH v4 2/3] irqchip/loongson-eiointc: Skip handling if there
 is no pending irq
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
 lvjianmin@loongson.cn
References: <20240125113623.2043061-1-maobibo@loongson.cn>
 <20240125113623.2043061-3-maobibo@loongson.cn>
 <CAAhV-H7wBBx-8fVfRoujMUJuLbQWW2oKDbW6A52G2S_pqmTK6A@mail.gmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <3d8cdc3a-415c-0f5a-d8d5-3fd2084926fc@loongson.cn>
Date: Tue, 30 Jan 2024 11:23:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7wBBx-8fVfRoujMUJuLbQWW2oKDbW6A52G2S_pqmTK6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxZMyxa7hlQzsnAA--.28908S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw1rWr15JrWrXFWkKw4Utrc_yoW8Zw18p3
	yUCa1qkF4DJryUCFnIqr18JF1YvwsYgFWDCa1kG3y3Z3s8JwnYkF4Fk3Wqvrs7Cr1fGa12
	vF4YgF1Uua15C3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4AhLUUUUU



On 2024/1/29 下午8:27, Huacai Chen wrote:
> Hi, Bibo,
> 
> As commented in another patch, you can use eiointc_irq_dispatch(),
> iocsr_read64() to describe functions, and it is better to use
> Loongson-3A5000, Loongson-2K2000, Loongson-2K0500 rather than 3A5000,
> 2K2000, 2K0500. Besides, please always use IRQs rather than IRQS.
Huacai,

Thanks for reviewing.

Will do in next patch.

Regards
Bibo Mao
> 
> With these modifications,
> 
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> 
> On Thu, Jan 25, 2024 at 7:36 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> It is one simple optimization in the interrupt dispatch function
>> eiointc_irq_dispatch. There are 256 IRQs supported for eiointc on
>> 3A5000 and 2K2000 platform, 128 IRQS on 2K0500 platform, eiointc irq
>> handler reads the bitmap and find pending irqs when irq happens. So
>> there are several consecutive iocsr_read64 operations for the all
>> bits to find all pending irqs. If the pending bitmap is zero, it
>> means that there is no pending irq for the this irq bitmap range,
>> we can skip handling to avoid some useless operations such as
>> clearing hw ISR.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   drivers/irqchip/irq-loongson-eiointc.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
>> index b3736bdd4b9f..6a71a8c29ac7 100644
>> --- a/drivers/irqchip/irq-loongson-eiointc.c
>> +++ b/drivers/irqchip/irq-loongson-eiointc.c
>> @@ -198,6 +198,12 @@ static void eiointc_irq_dispatch(struct irq_desc *desc)
>>
>>          for (i = 0; i < eiointc_priv[0]->vec_count / VEC_COUNT_PER_REG; i++) {
>>                  pending = iocsr_read64(EIOINTC_REG_ISR + (i << 3));
>> +
>> +               /* Skip handling if pending bitmap is zero */
>> +               if (!pending)
>> +                       continue;
>> +
>> +               /* Clear the IRQs */
>>                  iocsr_write64(pending, EIOINTC_REG_ISR + (i << 3));
>>                  while (pending) {
>>                          int bit = __ffs(pending);
>> --
>> 2.39.3
>>


