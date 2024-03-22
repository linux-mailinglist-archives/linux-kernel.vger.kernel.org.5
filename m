Return-Path: <linux-kernel+bounces-111277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D20886A03
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939D0285A32
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A141539AF1;
	Fri, 22 Mar 2024 10:14:23 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5C638DDD;
	Fri, 22 Mar 2024 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102463; cv=none; b=guermURhxnbpY7dgDfhUbZlRawmqdkkAFCM8wbRrCH88ly71r81f97Z89MmVzxZxan7wNPGlzBmn/hm0Q78BfAY6R1fQ6anpNF8c7EvEEIm8Vyx5V8mlz4JpA0sWvoo+X4BrQiSKAj/Zv2TDV03qS5BtKA8zf38eSF6NLqH5BNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102463; c=relaxed/simple;
	bh=5S8ymAudHdNfId4Tqv7tuai+C9MtL4MSBq1XCsGm7MU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MbTRrY8eF+lGbG11yxQC0SnmQL/Vhw87yUB4kmsWamGAc4GGxcQmHfDMf621wTfMwJUmeRBGsrxUonxx3ohgQK75ppUy0OKc2qmVzo+qoK8tEJW3DCZkMiWVeZWuFo/KiRffmSHzWn4KplFwXuUxYJ7jZmfL5FemmD0hZ1jzwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8CxbevzWf1lymocAA--.1807S3;
	Fri, 22 Mar 2024 18:14:11 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxPs_tWf1lNuNhAA--.59382S3;
	Fri, 22 Mar 2024 18:14:10 +0800 (CST)
Subject: Re: [PATCH V3] irqchip/loongson-pch-pic: Update interrupt
 registration policy
To: Thomas Gleixner <tglx@linutronix.de>, chenhuacai@kernel.org,
 jiaxun.yang@flygoat.com
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Baoqi Zhang <zhangbaoqi@loongson.cn>, Biao Dong <dongbiao@loongson.cn>
References: <20240319124629.23925-1-zhangtianyang@loongson.cn>
 <878r2di3ak.ffs@tglx>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <648e7f23-a2e0-ce8f-7c52-3bcda262de86@loongson.cn>
Date: Fri, 22 Mar 2024 18:14:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <878r2di3ak.ffs@tglx>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:AQAAf8CxPs_tWf1lNuNhAA--.59382S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WrykWw45WFyUZw1DGw4rJFc_yoW8Ar43pa
	yxX3ZFgan0qw47KrZ7Xrs7Xr1xCF97Ga4kKr90yry2k3s8W3W7KFW7AFW5uFyfGryFya1j
	vrZ3trW8Ka4UAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ek
	sDUUUUU==

Hi, Thomas

I will continue to revise my patch according to the document requirements.

Regarding "WHY", my understanding is that a convincing reason is needed 
to explain the necessity of this patch.

If so, can the last paragraph "This will be more conducive to fully 
utilizing existing vectors to support more devices."

be considered a simple explanation?

ÔÚ 2024/3/20 ÏÂÎç6:52, Thomas Gleixner Ð´µÀ:
> On Tue, Mar 19 2024 at 20:46, Tianyang Zhang wrote:
>> From: Baoqi Zhang <zhangbaoqi@loongson.cn>
>>
>> This patch remove the fixed mapping between the LS7A interrupt source
> Please don't use 'This patch'. We already know that this is a patch.
>
> See Documentation/process/
>
>> and the HT interrupt vector, and replaced it with a dynamically
>> allocated approach.
> You explain the WHAT, but you really need to explain the WHY.
>
>> We introduce a mapping table in struct pch_pic, where each interrupt
> s/We introduce/Introduce/ See documentation.
>
>> source will allocate an index as a 'hwirq' from the table in the order
>> of application and set table value as interrupt source number. This hwirq
>> will be configured as its vector in the HT interrupt controller. For an
>> interrupt source, the validity period of the obtained hwirq will last until
>> the system reset.
>>
>> This will be more conducive to fully utilizing existing vectors to
>> support more devices.
>>
>> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
>> Signed-off-by: Biao Dong <dongbiao@loongson.cn>
>> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
> This Signed-off-by chain is wrong.
>
> Please see Documentation/process/submitting-patches.rst
>
> Thanks,
>
>          tglx


