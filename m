Return-Path: <linux-kernel+bounces-11753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABE781EB35
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D211C22100
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 01:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3342629A8;
	Wed, 27 Dec 2023 01:10:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546EA290B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 01:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8DxGOh3eYtlKuMEAA--.751S3;
	Wed, 27 Dec 2023 09:10:15 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx6r10eYtlkhsMAA--.15386S3;
	Wed, 27 Dec 2023 09:10:14 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Let cores_io_master cover the largest NR_CPUS
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>
Cc: loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev,
 Xuefeng Li <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>,
 Xuerui Wang <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
 Huacai Chen <chenhuacai@loongson.cn>
References: <20231225070002.1350705-1-chenhuacai@loongson.cn>
 <3db5c086-db9b-cb3a-5521-44f18cb55c4a@loongson.cn>
 <CAAhV-H5Rs4BGKHZrA5bxSh0=4uhPx7vbVwBXtdtfU4hemN2QjA@mail.gmail.com>
 <b239bfee-73a7-495d-b094-bdfa31c1500e@flygoat.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <dc93675e-62a2-9648-dfbc-846e3afdf5b4@loongson.cn>
Date: Wed, 27 Dec 2023 09:09:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b239bfee-73a7-495d-b094-bdfa31c1500e@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Dx6r10eYtlkhsMAA--.15386S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFy3XF1rtrykZw4kAFWfCrX_yoW8AF43pr
	4vvFykGFWrGrn3Ga1jq34UCryYyr1DG3WqqF42ga48GrZFv3WqqF4jgryq9F1DZa1rtF10
	qw1fKw1avF4UAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=



On 2023/12/25 下午10:02, Jiaxun Yang wrote:
> 
> 
> 在 2023/12/25 09:19, Huacai Chen 写道:
>> On Mon, Dec 25, 2023 at 5:13 PM maobibo <maobibo@loongson.cn> wrote:
>>>
>>>
>>>
>>> On 2023/12/25 下午3:00, Huacai Chen wrote:
>>>> Now loongson_system_configuration::cores_io_master only covers 64 cpus,
>>>> if NR_CPUS > 64 there will be memory corruption. So let cores_io_master
>>>> cover the largest NR_CPUS (256).
>>>>
>>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>>> ---
>>>>    arch/loongarch/include/asm/bootinfo.h | 4 ++--
>>>>    arch/loongarch/kernel/acpi.c          | 2 +-
>>>>    arch/loongarch/kernel/smp.c           | 2 +-
>>>>    3 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/loongarch/include/asm/bootinfo.h 
>>>> b/arch/loongarch/include/asm/bootinfo.h
>>>> index c60796869b2b..32fd0319594a 100644
>>>> --- a/arch/loongarch/include/asm/bootinfo.h
>>>> +++ b/arch/loongarch/include/asm/bootinfo.h
>>>> @@ -30,7 +30,7 @@ struct loongson_system_configuration {
>>>>        int boot_cpu_id;
>>>>        int cores_per_node;
>>>>        int cores_per_package;
>>>> -     unsigned long cores_io_master;
>>>> +     unsigned long cores_io_master[4];
>>> Can the hardcoded 4 be defined something like this?
>>>      DIV_ROUND_UP(CONFIG_NR_CPUS, sizeof(long))
>> Can this be used to define arrays?
> 
> I think DECLARE_BITMAP should work.
> 
> See how are we dealing with cpumask_t:
> ```
> typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
> ```
Yeap, that will be better.

Regards
Bibo Mao
> 
> Thanks
> - Jiaxun
> [...]
> 
>>
>> Huacai


