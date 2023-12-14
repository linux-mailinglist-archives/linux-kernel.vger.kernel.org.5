Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AAE812FDC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572963AbjLNMO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572951AbjLNMO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:14:28 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952EEBD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:14:34 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SrWVm0htSzMnmP;
        Thu, 14 Dec 2023 20:14:24 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
        by mail.maildlp.com (Postfix) with ESMTPS id B818B1404D9;
        Thu, 14 Dec 2023 20:14:32 +0800 (CST)
Received: from [10.174.185.210] (10.174.185.210) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 20:14:31 +0800
From:   Kunkun Jiang <jiangkunkun@huawei.com>
To:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>
Subject: [bug report] GICv4.1: vSGI remains pending across the guest reset
Message-ID: <7e7f2c0c-448b-10a9-8929-4b8f4f6e2a32@huawei.com>
Date:   Thu, 14 Dec 2023 20:13:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

We have observed on GICv4.1 systems that, after a guest reset, the
secondary VCPU would receive an IPI_CPU_STOP accidently and failed to
come online eventually.

| Guest User-space
|
| reset (with a vSGI pending in the
| hardware) [0]
|
| disable the distributor (write 0
| into GICD_CTLR) [1]
|
| clear pending status (write 0 into
| GICR_ISPENDR0 for each RD) [2]
|
| disable the distributor (write 0
| into GICD_CTLR) [3]
|
| enable the distributor with ARE,
| Group1 and nASSGIreq [4]

The problem is that even if user-space tries to disable the distributor
and clear pending bits for all SGIs, we don't actually propogate it into
HW (we only record it via vgic_dist->{enabled, nassgireq} and
vgic_irq->pending_latch) and the vSGI remains pending across the guest
reset.

And when we're at [4], all vSGI's vgic_irq->hw are *true* and
vgic_v4_enable_vsgis() becomes a nop.. That's not good.

The following solution can solve the problem. Not sure if this is a good
solution.Sent out early for suggestions or solutions.

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c 
b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 89117ba2528a..3678ab33f5b9 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -374,6 +374,10 @@ static int vgic_v3_uaccess_write_pending(struct 
kvm_vcpu *vcpu,
              irq->pending_latch = true;
              vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
          } else {
+             if (irq->hw && vgic_irq_is_sgi(irq->intid))
+                 irq_set_irqchip_state(irq->host_irq,
+                              IRQCHIP_STATE_PENDING,
+                              false);
              irq->pending_latch = false;
              raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
          }

