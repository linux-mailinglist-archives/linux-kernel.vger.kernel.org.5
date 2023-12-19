Return-Path: <linux-kernel+bounces-4801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE857818237
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662631F23D5D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2B3125B5;
	Tue, 19 Dec 2023 07:25:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1961511C88
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4SvSqH3x7Nz1Q6Wg;
	Tue, 19 Dec 2023 15:23:55 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 78C9E1A0173;
	Tue, 19 Dec 2023 15:25:08 +0800 (CST)
Received: from [10.174.185.210] (10.174.185.210) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 15:25:07 +0800
Subject: Re: [bug report] GICv4.1: vSGI remains pending across the guest reset
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
CC: James Morse <james.morse@arm.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, "moderated list:ARM SMMU DRIVERS"
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>, open list
	<linux-kernel@vger.kernel.org>, "wanghaibin.wang@huawei.com"
	<wanghaibin.wang@huawei.com>
References: <7e7f2c0c-448b-10a9-8929-4b8f4f6e2a32@huawei.com>
 <87a5q983zc.wl-maz@kernel.org>
From: Kunkun Jiang <jiangkunkun@huawei.com>
Message-ID: <bb4984d2-ed80-ba97-0f58-b45db4f0ff32@huawei.com>
Date: Tue, 19 Dec 2023 15:24:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87a5q983zc.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)

Hi Marc and Oliver,

On 2023/12/17 19:26, Marc Zyngier wrote:
> On Thu, 14 Dec 2023 12:13:57 +0000,
> Kunkun Jiang <jiangkunkun@huawei.com> wrote:
>> Hi list,
>>
>> We have observed on GICv4.1 systems that, after a guest reset, the
>> secondary VCPU would receive an IPI_CPU_STOP accidently and failed to
>> come online eventually.
>>
>> | Guest User-space
> Guest userspace????
Sorry. The formatting is a bit messy.
|            Guest                               User-space
|
|  reset (with a vSGI pending in the
|  hardware) [0]
|
|                                     disable the distributor (write 0
|                                     into GICD_CTLR) [1]
|
|                                     clear pending status (write 0 into
|                                     GICR_ISPENDR0 for each RD) [2]
|
|  disable the distributor (write 0
|  into GICD_CTLR) [3]
|
|  enable the distributor with ARE,
|  Group1 and nASSGIreq [4]
>> |
>> | reset (with a vSGI pending in the
>> | hardware) [0]
>> |
>> | disable the distributor (write 0
>> | into GICD_CTLR) [1]
>> |
>> | clear pending status (write 0 into
>> | GICR_ISPENDR0 for each RD) [2]
> This cannot clear the pending bits. Writing 0 to any of the
> ISPEND/ICPEND registers is effectively a NOP.
>
> If you want to remove the pending SGIs, you need to write a bunch of
> 1s to ICPENDR0.
>
>> |
>> | disable the distributor (write 0
>> | into GICD_CTLR) [3]
>> |
>> | enable the distributor with ARE,
>> | Group1 and nASSGIreq [4]
>>
>> The problem is that even if user-space tries to disable the distributor
> I don't understand what userspace does here. Why is it significant
> that it is an EL0 access? I don't know of any SW doing that, but even
> if it existed, this should make no difference.
>
>> and clear pending bits for all SGIs, we don't actually propogate it into
>> HW (we only record it via vgic_dist->{enabled, nassgireq} and
>> vgic_irq->pending_latch) and the vSGI remains pending across the guest
>> reset.
>>
>> And when we're at [4], all vSGI's vgic_irq->hw are *true* and
>> vgic_v4_enable_vsgis() becomes a nop.. That's not good.
>>
>> The following solution can solve the problem. Not sure if this is a good
>> solution.Sent out early for suggestions or solutions.
>>
>> diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
>> b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
>> index 89117ba2528a..3678ab33f5b9 100644
>> --- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
>> +++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
>> @@ -374,6 +374,10 @@ static int vgic_v3_uaccess_write_pending(struct
>> kvm_vcpu *vcpu,
>>               irq->pending_latch = true;
>>               vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
>>           } else {
>> +             if (irq->hw && vgic_irq_is_sgi(irq->intid))
>> +                 irq_set_irqchip_state(irq->host_irq,
>> +                              IRQCHIP_STATE_PENDING,
>> +                              false);
>>               irq->pending_latch = false;
>>               raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
>>           }
>>
> But this has *nothing* to do with the guest. This is the *host*
> userspace performing a write to the redistributor view, which has
> different semantics. Which is why your earlier description made no
> sense to me.
>
> I think the problem is slightly larger than what you describe. A write
> to ISPENDR0 should be propagated to the ITS for any values of the
> latch, just like this happens on enabling HW-backed SGIs.
>
> Can you please give this a go?
I have given it a go. I tested reseting the guest 100 times in succession,
and the problem did not occur again.

Thanks,
Kunkun Jiang
> Thanks,
>
> 	M.
>
> >From 9932d74392d969057e84bc3c18bd15f1769b6211 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <maz@kernel.org>
> Date: Sun, 17 Dec 2023 11:15:09 +0000
> Subject: [PATCH] KVM: arm64: vgic-v4: Restore pending state on host userspace
>   write
>
> When the VMM writes to ISPENDR0 to set the state pending state of
> an SGI, we fail to convey this to the HW if this SGI is already
> backed by a GICv4.1 vSGI.
>
> This is a bit of a corner case, as this would only occur if the
> vgic state is changed on an already running VM, but this can
> apparently happen across a guest reset driven by the VMM.
>
> Fix this by always writing out the pending_latch value to the
> HW, and reseting it to false.
>
> Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/7e7f2c0c-448b-10a9-8929-4b8f4f6e2a32@huawei.com
> ---
>   arch/arm64/kvm/vgic/vgic-mmio-v3.c | 27 +++++++++++++++++----------
>   1 file changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> index a764b0ab8bf9..2533f264b954 100644
> --- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> +++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> @@ -365,19 +365,26 @@ static int vgic_v3_uaccess_write_pending(struct kvm_vcpu *vcpu,
>   		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
>   
>   		raw_spin_lock_irqsave(&irq->irq_lock, flags);
> -		if (test_bit(i, &val)) {
> -			/*
> -			 * pending_latch is set irrespective of irq type
> -			 * (level or edge) to avoid dependency that VM should
> -			 * restore irq config before pending info.
> -			 */
> -			irq->pending_latch = true;
> -			vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
> -		} else {
> +
> +		/*
> +		 * pending_latch is set irrespective of irq type
> +		 * (level or edge) to avoid dependency that VM should
> +		 * restore irq config before pending info.
> +		 */
> +		irq->pending_latch = test_bit(i, &val);
> +
> +		if (irq->hw && vgic_irq_is_sgi(irq->intid)) {
> +			irq_set_irqchip_state(irq->host_irq,
> +					      IRQCHIP_STATE_PENDING,
> +					      irq->pending_latch);
>   			irq->pending_latch = false;
> -			raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
>   		}
>   
> +		if (irq->pending_latch)
> +			vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
> +		else
> +			raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
> +
>   		vgic_put_irq(vcpu->kvm, irq);
>   	}
>   

