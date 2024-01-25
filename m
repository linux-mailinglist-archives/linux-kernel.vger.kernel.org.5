Return-Path: <linux-kernel+bounces-37851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0EF83B685
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BD828409F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899EC17C2;
	Thu, 25 Jan 2024 01:21:35 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E958ECC;
	Thu, 25 Jan 2024 01:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706145695; cv=none; b=OWz/s7iM/K8D5qUWQqVf0+eX9O4kRjfPvyFPHWXFb87xYU4kB6sR4GHeyu1d98ELCR4K/KsnbWEZmDInPhTtiFFEEl7IAYJzJ+SMZUnL2c7nO/A5UIK46zOci9tFfRKRaFHS2AJqS163TAg/k0xhiPphRQF+U3GLd4iifKzZc30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706145695; c=relaxed/simple;
	bh=/oin/qnvYKc2uY8SIBw5aQyOj/J0z/cBZ9Y3IWiZ4pA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=k4TP7A4E/IbJweZE4KPZtmZy42z9bn/uI4rt0+n1IUcNLM42OQfEc/gmsTQTORlDy6pVYDR1wcy8jbD0Tq+nRhmyo2aszUkKimPRHTkbX5AN0uhtpgVbzJVIXLQA2KiaEmqK+gj8cEvywGtZ/Yl+ekSztMDSfAflD4wY91T7z0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8CxruuZt7FloTEFAA--.19882S3;
	Thu, 25 Jan 2024 09:21:29 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxLs+Wt7FlRSQYAA--.39799S3;
	Thu, 25 Jan 2024 09:21:28 +0800 (CST)
Subject: Re: [PATCH v3 2/3] irqchip/loongson-eiointc: Refine irq affinity
 setting during resume
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
 lvjianmin@loongson.cn
References: <20240118121542.748351-1-maobibo@loongson.cn>
 <20240118121542.748351-3-maobibo@loongson.cn>
 <CAAhV-H45A4m-imDh8UZqXJ3WXduMyubbd1ze-EgZtqqbfjHt1g@mail.gmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <25248832-c377-4d7b-db78-6851d9ea2762@loongson.cn>
Date: Thu, 25 Jan 2024 09:21:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H45A4m-imDh8UZqXJ3WXduMyubbd1ze-EgZtqqbfjHt1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxLs+Wt7FlRSQYAA--.39799S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw48tw1kJr45WrW3uryUArc_yoW8uw1DpF
	W3A3ZIyF48GFyUXrWF9w1Utryavws0qrZrta1fWa9xuFZ8uw1DtF4FyFyIvFWvkry2kF1v
	yF45X34ruFn0yagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=

My work area is hypervisor and I find gaps between other architectures 
and hypervisors, try to keep up. And We prepare to provide eiointc 
virtualization extension patch, so there is such patch.

For internal repo, you can give suggestion in internal forum to driver 
owner. This is linux kernel mainline forum, I suggest we had better 
discuss patch based on mainline base code.

Regards
Bibo Mao

On 2024/1/24 下午5:56, Huacai Chen wrote:
> I can give an Acked-by if these lines are also removed in our internal repo.
> 
> Huacai
> 
> On Thu, Jan 18, 2024 at 8:15 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> During suspend and resume, CPUs except CPU0 are hot-unpluged and IRQs
>> are migrated to CPU0. So it is not necessary to restore irq affinity for
>> eiointc irq controller when system resumes. This patch removes the piece
>> of code about irq affinity restoring in function eiointc_resume.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   drivers/irqchip/irq-loongson-eiointc.c | 16 ----------------
>>   1 file changed, 16 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
>> index 6143adb1b73b..86f4faad0695 100644
>> --- a/drivers/irqchip/irq-loongson-eiointc.c
>> +++ b/drivers/irqchip/irq-loongson-eiointc.c
>> @@ -315,23 +315,7 @@ static int eiointc_suspend(void)
>>
>>   static void eiointc_resume(void)
>>   {
>> -       int i, j;
>> -       struct irq_desc *desc;
>> -       struct irq_data *irq_data;
>> -
>>          eiointc_router_init(0);
>> -
>> -       for (i = 0; i < nr_pics; i++) {
>> -               for (j = 0; j < eiointc_priv[0]->vec_count; j++) {
>> -                       desc = irq_resolve_mapping(eiointc_priv[i]->eiointc_domain, j);
>> -                       if (desc && desc->handle_irq && desc->handle_irq != handle_bad_irq) {
>> -                               raw_spin_lock(&desc->lock);
>> -                               irq_data = irq_domain_get_irq_data(eiointc_priv[i]->eiointc_domain, irq_desc_get_irq(desc));
>> -                               eiointc_set_irq_affinity(irq_data, irq_data->common->affinity, 0);
>> -                               raw_spin_unlock(&desc->lock);
>> -                       }
>> -               }
>> -       }
>>   }
>>
>>   static struct syscore_ops eiointc_syscore_ops = {
>> --
>> 2.39.3
>>


