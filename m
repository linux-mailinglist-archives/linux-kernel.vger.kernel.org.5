Return-Path: <linux-kernel+bounces-161862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4B68B5263
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0911C21021
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C487214A8D;
	Mon, 29 Apr 2024 07:32:23 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE38883D;
	Mon, 29 Apr 2024 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375943; cv=none; b=t2XJ+yBvo6O7NpHjMUlYZUce50wHaX15rh93TiV0gKwav58DBt5b0LH/wvXNj/f89kgTwpEjyMfNJQCbDOd0ZgDLMO0LMU7h2AdniEQTHeWPC1uUSv6jmbbLxRfp8+X9xSjlkqnzSQlA8Rw3NiUrc7XHv+jYrIqwXuDunAbVkl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375943; c=relaxed/simple;
	bh=XRXKieqHp1DvJ7IC6w1mftvCxe3LJrs0wxu9R+nqtiU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HRjI3q5BpKcassNFLD656p3/tXhKToe0lFhDbgwyWSQRrtTkb9D+QbsizZPaZSzoo4wRT1p7p6ClLj89q9hjFcfxY+77Qg87j/wUntW7Peuuu6g+Qch540N1B4lGrmN9SeoI1l5cIHgBcMVI1jZkAAh649qBg4edpSXveNWPxiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.239])
	by gateway (Coremail) with SMTP id _____8BxSfH9TC9m1tUEAA--.16844S3;
	Mon, 29 Apr 2024 15:32:13 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxIlb5TC9meN8JAA--.7916S3;
	Mon, 29 Apr 2024 15:32:11 +0800 (CST)
Subject: Re: [PATCH v3] LoongArch: KVM: Add PMU support
To: Markus Elfring <Markus.Elfring@web.de>, loongarch@lists.linux.dev,
 kernel-janitors@vger.kernel.org, maobibo@loongson.cn
Cc: LKML <linux-kernel@vger.kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 Wang Xuerui <kernel@xen0n.name>
References: <20240424091813.1471440-1-gaosong@loongson.cn>
 <e68e09e0-75f3-43b8-b947-22cc0d1a0dae@web.de>
From: gaosong <gaosong@loongson.cn>
Message-ID: <b8818597-2770-f2a3-03bd-1653cd26fc78@loongson.cn>
Date: Mon, 29 Apr 2024 15:32:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e68e09e0-75f3-43b8-b947-22cc0d1a0dae@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:AQAAf8CxIlb5TC9meN8JAA--.7916S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFW3JF15ur13GFWUJw15WrX_yoW8ArW3pF
	4ruan0y3yDtF10kw4kX3yvyry7WrZ8Jr13urn7X3Z8JrZ8ZwnYvr1fZr1agFyDZ34rKFW2
	q3Z3ArWF9FyDtFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zw
	Z7UUUUU==

在 2024/4/25 下午3:18, Markus Elfring 写道:
> …
>> On KVM side. we save the host PMU CSRs into structure kvm_context.
>> If the host supports the PMU feature. When entering guest mode.
>> we save the host PMU CSRs and restore the guest PMU CSRs.
> …
>
> I suggest to reconsider the usage of a few dots in such a wording approach.
>
>
> …
> Signed-off-by: Song Gao <gaosong@loongson.cn>
>
> v2->V3:
> …
>
> * Please put your version descriptions behind a marker line.
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.9-rc5#n713
Got  it,  thank for you suggestion.
> * How do you think about to avoid the repetition of version identifiers here?
I'm new to this, is the following example correct?

[...]

Signed-off-by: Song Gao <gaosong@loongson.cn>
---

v4:
   - Use the macro kvm_read_clear_hw_gcsr to optimize the code
     and remove redundant code.

V3:
   - When saving the PMU context, clear the CTRL register
      before reading the CNTR register.
   - Put kvm_lose_pmu() in kvm_handler_exit().

v2:
   - Add new vcpu->request flag KVM_REQ_PMU. If we use PMU,
     We need to set this flag;
   - Add kvm_check_pmu() to kvm_pre_enter_guest();
   - On _kvm_setcsr(), after modifying the PMU CSR register value,
      if we use PMU, we need to set KVM_REQ_PMU.

Patch v3: 
https://lore.kernel.org/all/20240424091813.1471440-1-gaosong@loongson.cn/
Patch v2: 
https://lore.kernel.org/all/20240417065236.500011-1-gaosong@loongson.cn/
Patch v1: 
https://lore.kernel.org/all/20240410095812.2943706-1-gaosong@loongson.cn/

---

[...]

Regards.
Song Gao
>
> Regards,
> Markus


