Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C347E28D3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjKFPfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjKFPfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:35:40 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FBB100
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:35:35 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SPFgG6CmhzMmW3;
        Mon,  6 Nov 2023 23:31:06 +0800 (CST)
Received: from [10.174.185.210] (10.174.185.210) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 6 Nov 2023 23:35:32 +0800
Subject: Re: [RFC PATCH] KVM: arm/arm64: GICv4: Support shared VLPI
To:     Marc Zyngier <maz@kernel.org>
CC:     Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>,
        <kvmarm@lists.linux.dev>, <wanghaibin.wang@huawei.com>
References: <20231102143507.840-1-jiangkunkun@huawei.com>
 <87msvt6cc7.wl-maz@kernel.org>
From:   Kunkun Jiang <jiangkunkun@huawei.com>
Message-ID: <12266a84-1148-954c-c6d6-67c8f9cc80b7@huawei.com>
Date:   Mon, 6 Nov 2023 23:33:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87msvt6cc7.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2023/11/4 18:29, Marc Zyngier wrote:
> On Thu, 02 Nov 2023 14:35:07 +0000,
> Kunkun Jiang <jiangkunkun@huawei.com> wrote:
>> In some scenarios, the guest virtio-pci driver will request two MSI-X,
>> one vector for config, one shared for queues. However, the host driver
>> (vDPA or VFIO) will request a vector for each queue.
> Well, VFIO will request *all* available MSI-X. It doesn't know what a
> queue is.
>
>> In the current implementation of GICv4/4.1 direct injection of vLPI,
>> pINTID and vINTID have one-to-one correspondence. Therefore, the
> This matching is a hard requirement that matches the architecture. You
> cannot change it.
>
>> above scenario cannot be handled correctly. The host kernel will
>> execute its_map_vlpi multiple times but only execute its_unmap_vlpi
>> once. This may cause guest hang[1].
> Why does it hang? As far as it is concerned, it has unmapped the
> interrupts it cares about. Where are the calls to its_map_vlpi()
> coming from? It should only occur if the guest actively programs the
> MSI-X registers. What is your VMM? How can I reproduce this issue?
>
>> |	WARN_ON(!(irq->hw && irq->host_irq == virq));
>> |	if (irq->hw) {
>> |		atomic_dec(&irq->target_vcpu->arch.vgic_cpu.vgic_v3.its_vpe.vlpi_count);
>> |		irq->hw = false;
>> |		ret = its_unmap_vlpi(virq);
>> |	}
>>
>> Add a list to struct vgic_irq to record all host irqs mapped to the vlpi.
>> When performing an action on the vlpi, traverse the list and perform this
>> action on all host irqs.
> This makes no sense. You are blindly associating multiple host
> interrupts with a single guest interrupt. This is a blatant violation
> of the architecture. When unmapping a VLPI from a guest, only this one
> should be turned again into an LPI. Not two, not all, just this one.
>
> Maybe you have found an actual issue, but this patch is absolutely
> unacceptable. Please fully describe the problem, provide traces, and
> if possible a reproducer.
>
>> Link: https://lore.kernel.org/all/0d9fdf42-76b1-afc6-85a9-159c5490bbd4@huawei.com/#t
> I tried to parse this, but it hardly makes sense either. You seem to
> imply that the host driver pre-configures the device, which is
> completely wrong. The host driver (VFIO) should simply request all
> possible physical LPIs, and that's all. It is expected that this
> requesting has no other effect on the HW. Also, since your guest
> driver only configures a single vLPI, there should be only a single
> its_map_vlpi() call.
Sorry to replay so late.

The virtio-scsi device has seven vectors (entry0-6): one for config,
six for queues. In Guest, e.g. centos 7.6 4.19, virtio-pci driver
will request only one vLPI, which is shared for queues.
The entry 0 is used for config. It's not relevant to this issue, so
we're not going to discuss it. The virtio-pci driver write entry1-6
massage.data in the msix-table and trap to QEMU for processing. The
massage.data is as follow:
> entry-0 0
> entry-1 1
> entry-2 1
> entry-3 1
> entry-4 1
> entry-5 1
> entry-6 1 

The calling process of kvm is as follows. its_map_vlpi_will be
executed 6 times. Six host irqs are mapped to one vLPI.
> kvm_irqfd_assign
>     irq_bypass_register_consumer
>         ...
>         kvm_arch_irq_bypass_add_producer
>             kvm_vgic_v4_set_forwarding
>                 its_map_vlpi 

When executing the reboot command inside the Guest,
kvm_vgic_v4_unset_forwarding will be execute 6 times. WARN_ON
will also be triggered 6 times. But its_unmap_vlpi will only
be executed the first time.
> kvm_arch_irq_bypass_del_producer
>     kvm_vgic_v4_unset_forwarding
>         WARN_ON(!(irq->hw && irq->host_irq == virq));
>         if (irq->hw) {
>             irq->hw = false;
> its_unmap_vlpi
>         } 

Therefore, only the mapping between the first host irq and
vLPI is unmapped. When the guest reboots into the BIOS phase,
the remaining 5 host irqs may still send interrupts. This
causes the guest to hang.

Looking forward to your reply.

Thanks,
Kunkun Jiang
> So it seems to me that your HW and SW are doing things that are not
> expected at all.
>
> 	M.
>
