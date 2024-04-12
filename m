Return-Path: <linux-kernel+bounces-142413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFE98A2B35
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD23C1C2311D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9D950A6C;
	Fri, 12 Apr 2024 09:30:11 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0B65029B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914210; cv=none; b=s2zK3G2jLJ4R1psI7e+MiiDalxsotrYfomNRZg70ORoMXVJhAANV44Z8/0yXV1hVnBLL0zMAQKY41FlarNjPWtfQImC/WCUwtGISv4eTG1pgR5UPMRx7mxExZ7RlIKjThLRuJZ1etR46HvwNAhyLZP9JXlcmz5PAftQBWkMgnFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914210; c=relaxed/simple;
	bh=HFqo7+vWZ0Wz3w2aeaZqrJQ+MORGGd/mtA2CPk//mpI=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ALccvGOqP1MVq6rk/TEYOBtL0jS7k43Xs6696fih0pUCzdhDHMQHpy4Ljqwr+W6gwnelo9Z1TA7orfYulklOIehmSB1ag/uPGJYKd7YUnCvw2UVtW1n3GT6uWZocF9ocExpx/QzbMOCEaq/yu7KeFq/tGM0Dy7awvPSosn5jPQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bxiegf_xhmgFMmAA--.2890S3;
	Fri, 12 Apr 2024 17:30:07 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxHs8c_xhmV6N4AA--.34991S3;
	Fri, 12 Apr 2024 17:30:05 +0800 (CST)
Subject: Re: [PATCH v3 3/4] LoongArch: Save and restore PERCPU_BASE_KS for
 ACPI S3 state
To: Huacai Chen <chenhuacai@kernel.org>
References: <20240411010510.22135-1-yangtiezhu@loongson.cn>
 <20240411010510.22135-4-yangtiezhu@loongson.cn>
 <CAAhV-H7SqudMeyK6_+j0ah=N=ywsv=4kk_b=hxocEQFsKZ+0bA@mail.gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <maz@kernel.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <9b95e6d7-35d2-eeee-f6dc-fc7741a48b62@loongson.cn>
Date: Fri, 12 Apr 2024 17:30:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7SqudMeyK6_+j0ah=N=ywsv=4kk_b=hxocEQFsKZ+0bA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxHs8c_xhmV6N4AA--.34991S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFW7KryUXw47ZFW5Ar1xCrX_yoW8Xw17pF
	92yF4ktF40kFn7JF1qv3WqgF4UX393KrWIq3ZIk3yqkr9Fq3s8Wr4rt3WYgF1kWw1xAa10
	v3yft343XFyUJabCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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



On 04/12/2024 12:18 PM, Huacai Chen wrote:
> Hi, Tiezhu,
>
> On Thu, Apr 11, 2024 at 9:05 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> Currently, per_cpu_offset(x) is defined as __per_cpu_offset[x])
>> only under CONFIG_SMP in include/asm-generic/percpu.h, that is
>> to say, the implementation of loongarch_common_resume() which
>> calls per_cpu_offset(0) is not suitable for the case of non-SMP,
>> so do not write per_cpu_offset(0) to PERCPU_BASE_KS when resume,
>> just save the value of PERCPU_BASE_KS when suspend and restore
>> it when resume to make it work well for both SMP and non-SMP.
> For non-SMP you need PERCPU_BASE_KS to do what?

The initial aim is to avoid build error under !CONFIG_SMP
and it works well on both !CONFIG_SMP and CONFIG_SMP, the
changes are similar with the code in hibernate.c.

An alternative way is to do the following simple change,
but it seems a little ugly due to the ifdef, let me know
what is your preference.

diff --git a/arch/loongarch/power/suspend.c b/arch/loongarch/power/suspend.c
index 166d9e06a64b..35191afefcda 100644
--- a/arch/loongarch/power/suspend.c
+++ b/arch/loongarch/power/suspend.c
@@ -44,7 +44,9 @@ void loongarch_common_resume(void)
  {
         sync_counter();
         local_flush_tlb_all();
+#ifdef
         csr_write64(per_cpu_offset(0), PERCPU_BASE_KS);
+#endif
         csr_write64(eentry, LOONGARCH_CSR_EENTRY);
         csr_write64(eentry, LOONGARCH_CSR_MERRENTRY);
         csr_write64(tlbrentry, LOONGARCH_CSR_TLBRENTRY);

Thanks,
Tiezhu


