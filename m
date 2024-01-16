Return-Path: <linux-kernel+bounces-27125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3911782EAD9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A251F24114
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEAE11C83;
	Tue, 16 Jan 2024 08:26:41 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226FE11713;
	Tue, 16 Jan 2024 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8Dxfeu9PaZlw6AAAA--.2862S3;
	Tue, 16 Jan 2024 16:26:37 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxHs+6PaZlNKQDAA--.19022S3;
	Tue, 16 Jan 2024 16:26:36 +0800 (CST)
Subject: Re: [PATCH v2] irqchip/loongson-eiointc: Refine irq affinity setting
 during resume
To: Sergey Shtylyov <s.shtylyov@omp.ru>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvjianmin@loongson.cn
References: <20240116080555.409215-1-maobibo@loongson.cn>
 <58b05897-8d06-52fa-8cde-ca7caa591200@omp.ru>
From: maobibo <maobibo@loongson.cn>
Message-ID: <236c62f1-29b9-bbd2-1391-bb713d9cd3c8@loongson.cn>
Date: Tue, 16 Jan 2024 16:26:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <58b05897-8d06-52fa-8cde-ca7caa591200@omp.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxHs+6PaZlNKQDAA--.19022S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Gw1UKw47Ar48Zw1xGF47WrX_yoWkGrb_WF
	Z2k34xuw1UXF13tFWktw4UtFZIg3yru348W34UXF1jq345Z34kWrZYkrnrK3Wxta47CFn8
	ury3Ar4Sk347uosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=

Sergey,

Thanks for reviewing my patch.
I reply inline.

On 2024/1/16 下午4:17, Sergey Shtylyov wrote:
> On 1/16/24 11:05 AM, Bibo Mao wrote:
> 
>> During suspend and resume, other CPUs are hot-unpluged and IRQs are
>> migrated to CPU0. So it is not necessary to restore irq affinity for
>> eiointc irq controller.
>>
>> Also there is some optimization for the interrupt dispatch function
>> eiointc_irq_dispatch. There are 256 IRQs supported for eiointc, eiointc
>> irq handler reads the bitmap and find pending irqs when irq happens.
>> So there are four times of consecutive iocsr_read64 operations for the
>> total 256 bits to find all pending irqs. If the pending bitmap is zero,
>> it means that there is no pending irq for the this irq bitmap range,
>> we can skip handling to avoid some useless operations sush as clearing
> 
>      s/sush/such/?
will fix.

> 
>> hw ISR.
> 
>     This sounds like you need 2 patches to deal with 2 separate issues...
Sure, I will separate it into 2 patches in next version.

Regards
Bibo Mao
> 
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> [...]
> 
> MBR, Sergey
> 


