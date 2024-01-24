Return-Path: <linux-kernel+bounces-36768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7924083A648
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4B01C22B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F0D18625;
	Wed, 24 Jan 2024 10:02:18 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A15182A1;
	Wed, 24 Jan 2024 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090538; cv=none; b=gqoAF7sZngN+Z+CusWvK/9mtZHLgCwBGQMTzyJtCXa8jvIWHDPIaJoV5ionWTtW24PKLLzz7R8k0hSrq1kZscoDm5bmLKJ+q+TA3bbwo7LtRSnJ7v7O5d/54199oW/PipBjxVxd3RZTcSuRL74iF82UINNxK+8kER1yBkcmUaZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090538; c=relaxed/simple;
	bh=fPZu8fVVW4LkeJMKBPP8DK2GyWfVf/kOWZvHoRKVv94=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=muH0KX5yvFvb5hn6PAgVD/lfH0Nffiez5OypYaDO7mNGrJuOdePc5feeusy0DuvfEr6MP5+lfHON/tSFm7zEq1/dsGiPVSQA7V2FLV67ZSIVnBxni7b+eOE7z2vHocjJ2j+WyJtIpSiH6DqiI6epodPUaX10gLHuPz+9S6HO75g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8Cxrusl4LBlrrAEAA--.18410S3;
	Wed, 24 Jan 2024 18:02:13 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxRMwi4LBllqQWAA--.25642S3;
	Wed, 24 Jan 2024 18:02:12 +0800 (CST)
Subject: Re: [PATCH v3 1/3] irqchip/loongson-eiointc: Skip handling if there
 is no pending irq
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
 lvjianmin@loongson.cn
References: <20240118121542.748351-1-maobibo@loongson.cn>
 <20240118121542.748351-2-maobibo@loongson.cn>
 <CAAhV-H5-da4AvtgHu1Hv0sbXddab6Mqg6eCkwJzr32Xi4A97yQ@mail.gmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <8c133026-3c70-2e2a-7f79-2f3c4327b7b4@loongson.cn>
Date: Wed, 24 Jan 2024 18:02:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5-da4AvtgHu1Hv0sbXddab6Mqg6eCkwJzr32Xi4A97yQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxRMwi4LBllqQWAA--.25642S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFyrXw4UJrWDZrykKr17Arc_yoW8Zry3p3
	y5CFn0kFW5JryUAw1agF4UJF1Yvwn5KFZrA393Gay3Jr98J3s8KF4rCF1q9rs7Cry3Ga12
	vF4Ygr4UCa15CFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9
	N3UUUUU==



On 2024/1/24 下午5:51, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Thu, Jan 18, 2024 at 8:15 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> There is one simple optimization in the interrupt dispatch function
>> eiointc_irq_dispatch. There are 256 IRQs supported for eiointc, eiointc
>> irq handler reads the bitmap and find pending irqs when irq happens.
>> So there are four times of consecutive iocsr_read64 operations for the
>> total 256 bits to find all pending irqs. If the pending bitmap is zero,
>> it means that there is no pending irq for the this irq bitmap range,
>> we can skip handling to avoid some useless operations such as clearing
>> hw ISR.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   drivers/irqchip/irq-loongson-eiointc.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
>> index 1623cd779175..6143adb1b73b 100644
>> --- a/drivers/irqchip/irq-loongson-eiointc.c
>> +++ b/drivers/irqchip/irq-loongson-eiointc.c
>> @@ -198,6 +198,17 @@ static void eiointc_irq_dispatch(struct irq_desc *desc)
>>
>>          for (i = 0; i < eiointc_priv[0]->vec_count / VEC_COUNT_PER_REG; i++) {
>>                  pending = iocsr_read64(EIOINTC_REG_ISR + (i << 3));
>> +
>> +               /*
>> +                * Get pending eiointc irq from bitmap status, there are 4 times
>> +                * consecutive iocsr_read64 operations for 256 IRQs.
>> +                *
>> +                * Skip handling if pending bitmap is zero
> This driver is shared by Loongson-2 and Loongson-3 series, for
> Loongson-2K0500 there is only 128 IRQs, so I suggest only keep the
> last line "Skip handling if current pending bitmap is zero" is enough.
Sure, will refine the patch in this way.

Regards
Bibo Mao
> 
> Huacai
> 
>> +                */
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


