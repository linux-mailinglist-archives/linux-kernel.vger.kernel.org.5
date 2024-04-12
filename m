Return-Path: <linux-kernel+bounces-142410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 221D88A2B2F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541321C21ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C89C502B7;
	Fri, 12 Apr 2024 09:29:00 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0540F5027F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914139; cv=none; b=X0bNq4rXWSuXx4GATW93Jl8zTi02wexckxaNvtZ41zmZiEesRkovvCZSumq1wtidRoe8mmPmHQbN0ztuM8niTtcsIeqYFI7K8zFcvGAtLwvMDDbz9d+1/QV8YbcbLEZP+YPiz0vIJOq619RbMEId92ENuTxU+g4yV/Uy0b3sviE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914139; c=relaxed/simple;
	bh=3W/lvW+cd509tmRSShTncTH2iQD2ypL2DTjIec6w4UE=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Emc0o7+/4q7sWATub+2AQRTe1v2ZyeyJi9jk5RMHQybozj/eY7jenTlMqrI6uwVSIyjjrLyyUIiEDGhhKQx1me1qEvMZc/5C3MINxGDAuna+MwIWGW8u3ZSuSi8Xd15oj9uRdzheHLQg0pIgRxN0ufh14lRHn4sYunBq/Qaxj78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx67rW_hhmTlMmAA--.6368S3;
	Fri, 12 Apr 2024 17:28:54 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxfRPU_hhm_KJ4AA--.2797S3;
	Fri, 12 Apr 2024 17:28:53 +0800 (CST)
Subject: Re: [PATCH v3 2/4] LoongArch: Refactor get_acpi_id_for_cpu() related
 code
To: Huacai Chen <chenhuacai@kernel.org>
References: <20240411010510.22135-1-yangtiezhu@loongson.cn>
 <20240411010510.22135-3-yangtiezhu@loongson.cn>
 <CAAhV-H73d5hVM+anfHhTFHjWDmVtC2TJdxU9hANJvQgm-E3g6w@mail.gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <maz@kernel.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <45a3ef9b-54f2-cea6-5902-d9681fad6a48@loongson.cn>
Date: Fri, 12 Apr 2024 17:28:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H73d5hVM+anfHhTFHjWDmVtC2TJdxU9hANJvQgm-E3g6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxfRPU_hhm_KJ4AA--.2797S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFyDGry7XryfKw4xAF18Zwc_yoW8Cryfpa
	ykt343trs2y34xuw4kGw13Gr15tr1DWFyIvF4IkFWrAa1kur15tFs7Ka429FZ8Wa18Gr4a
	vrn3ta4j9a1UCabCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DU
	UUU



On 04/12/2024 12:17 PM, Huacai Chen wrote:
> Hi, Tiezhu,
>
> On Thu, Apr 11, 2024 at 9:05 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> Currently, cpu_logical_map(cpu) is defined as __cpu_logical_map[cpu]
>> in arch/loongarch/include/asm/smp.h and __cpu_logical_map[] is defined
>> in arch/loongarch/kernel/smp.c, that is to say, cpu_logical_map(cpu) is
>> vaild only under CONFIG_SMP, the implementation of get_acpi_id_for_cpu()
>> which calls cpu_logical_map(cpu) is not suitable for the case of non-SMP,
>> so refactor get_acpi_id_for_cpu() related code to make it work well for
>> both SMP and non-SMP.
> But you implement cpu_logical_map(cpu) for non-SMP in the 4th patch, right?

The initial aim is to make get_acpi_id_for_cpu() only related with
acpi stuff and referenced the following riscv code, this patch can
be dropped if you think it is better to only define cpu_logical_map(cpu)
under !CONFIG_SMP, I am not sure whether it needs to keep the changes
in acpi.c at least.

static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, 
const unsigned long end)
{
	struct acpi_madt_rintc *rintc = (struct acpi_madt_rintc *)header;
	int cpuid;

	if (!(rintc->flags & ACPI_MADT_ENABLED))
		return 0;

	cpuid = riscv_hartid_to_cpuid(rintc->hart_id);
	/*
	 * When CONFIG_SMP is disabled, mapping won't be created for
	 * all cpus.
	 * CPUs more than num_possible_cpus, will be ignored.
	 */
	if (cpuid >= 0 && cpuid < num_possible_cpus())
		cpu_madt_rintc[cpuid] = *rintc;

	return 0;
}

struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
{
	return &cpu_madt_rintc[cpu];
}

u32 get_acpi_id_for_cpu(int cpu)
{
	return acpi_cpu_get_madt_rintc(cpu)->uid;
}

https://elixir.bootlin.com/linux/v6.9-rc3/source/arch/riscv/kernel/acpi.c#L194

Thanks,
Tiezhu


