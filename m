Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B427DF528
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjKBOfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjKBOfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:35:20 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E53B7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:35:16 -0700 (PDT)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SLmWb4YYFzMmXM;
        Thu,  2 Nov 2023 22:30:51 +0800 (CST)
Received: from DESKTOP-6NKE0BC.china.huawei.com (10.174.185.210) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 2 Nov 2023 22:35:12 +0800
From:   Kunkun Jiang <jiangkunkun@huawei.com>
To:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <wanghaibin.wang@huawei.com>, Kunkun Jiang <jiangkunkun@huawei.com>
Subject: [RFC PATCH] KVM: arm/arm64: GICv4: Support shared VLPI
Date:   Thu, 2 Nov 2023 22:35:07 +0800
Message-ID: <20231102143507.840-1-jiangkunkun@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some scenarios, the guest virtio-pci driver will request two MSI-X,
one vector for config, one shared for queues. However, the host driver
(vDPA or VFIO) will request a vector for each queue.

In the current implementation of GICv4/4.1 direct injection of vLPI,
pINTID and vINTID have one-to-one correspondence. Therefore, the
above scenario cannot be handled correctly. The host kernel will
execute its_map_vlpi multiple times but only execute its_unmap_vlpi
once. This may cause guest hang[1].

|	WARN_ON(!(irq->hw && irq->host_irq == virq));
|	if (irq->hw) {
|		atomic_dec(&irq->target_vcpu->arch.vgic_cpu.vgic_v3.its_vpe.vlpi_count);
|		irq->hw = false;
|		ret = its_unmap_vlpi(virq);
|	}

Add a list to struct vgic_irq to record all host irqs mapped to the vlpi.
When performing an action on the vlpi, traverse the list and perform this
action on all host irqs.

Link: https://lore.kernel.org/all/0d9fdf42-76b1-afc6-85a9-159c5490bbd4@huawei.com/#t

Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 arch/arm64/kvm/vgic/vgic-its.c | 74 ++++++++++++++++++++++++----------
 arch/arm64/kvm/vgic/vgic-v4.c  | 37 ++++++++++++++---
 include/kvm/arm_vgic.h         |  7 ++++
 3 files changed, 91 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 5fe2365a629f..c4b453155fcf 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -54,6 +54,7 @@ static struct vgic_irq *vgic_add_lpi(struct kvm *kvm, u32 intid,
 
 	INIT_LIST_HEAD(&irq->lpi_list);
 	INIT_LIST_HEAD(&irq->ap_list);
+	INIT_LIST_HEAD(&irq->host_irq_head);
 	raw_spin_lock_init(&irq->irq_lock);
 
 	irq->config = VGIC_CONFIG_EDGE;
@@ -61,6 +62,7 @@ static struct vgic_irq *vgic_add_lpi(struct kvm *kvm, u32 intid,
 	irq->intid = intid;
 	irq->target_vcpu = vcpu;
 	irq->group = 1;
+	atomic_set(&irq->map_count, 0);
 
 	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
 
@@ -284,6 +286,7 @@ static int update_lpi_config(struct kvm *kvm, struct vgic_irq *irq,
 	u8 prop;
 	int ret;
 	unsigned long flags;
+	struct vlpi_host_irq *vlpi_hirq;
 
 	ret = kvm_read_guest_lock(kvm, propbase + irq->intid - GIC_LPI_OFFSET,
 				  &prop, 1);
@@ -305,8 +308,13 @@ static int update_lpi_config(struct kvm *kvm, struct vgic_irq *irq,
 
 	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 
-	if (irq->hw)
-		return its_prop_update_vlpi(irq->host_irq, prop, needs_inv);
+	if (irq->hw) {
+		list_for_each_entry(vlpi_hirq, &irq->host_irq_head, host_irq_list) {
+			ret = its_prop_update_vlpi(vlpi_hirq->host_irq, prop, needs_inv);
+			if (ret)
+				return ret;
+		}
+	}
 
 	return 0;
 }
@@ -354,25 +362,31 @@ int vgic_copy_lpi_list(struct kvm *kvm, struct kvm_vcpu *vcpu, u32 **intid_ptr)
 static int update_affinity(struct vgic_irq *irq, struct kvm_vcpu *vcpu)
 {
 	int ret = 0;
-	unsigned long flags;
+	unsigned long flags, counts;
+	struct vlpi_host_irq *vlpi_hirq;
 
 	raw_spin_lock_irqsave(&irq->irq_lock, flags);
 	irq->target_vcpu = vcpu;
 	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 
 	if (irq->hw) {
-		struct its_vlpi_map map;
+		counts = atomic_read(&irq->map_count);
+		list_for_each_entry(vlpi_hirq, &irq->host_irq_head, host_irq_list) {
+			struct its_vlpi_map map;
 
-		ret = its_get_vlpi(irq->host_irq, &map);
-		if (ret)
-			return ret;
+			ret = its_get_vlpi(vlpi_hirq->host_irq, &map);
+			if (ret)
+				return ret;
 
-		if (map.vpe)
-			atomic_dec(&map.vpe->vlpi_count);
-		map.vpe = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
-		atomic_inc(&map.vpe->vlpi_count);
+			counts--;
+			if (map.vpe && !counts)
+				atomic_dec(&map.vpe->vlpi_count);
+			map.vpe = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
+			if (!counts)
+				atomic_inc(&map.vpe->vlpi_count);
 
-		ret = its_map_vlpi(irq->host_irq, &map);
+			ret = its_map_vlpi(vlpi_hirq->host_irq, &map);
+		}
 	}
 
 	return ret;
@@ -731,6 +745,7 @@ static int vgic_its_trigger_msi(struct kvm *kvm, struct vgic_its *its,
 				u32 devid, u32 eventid)
 {
 	struct vgic_irq *irq = NULL;
+	struct vlpi_host_irq *vlpi_hirq;
 	unsigned long flags;
 	int err;
 
@@ -738,9 +753,15 @@ static int vgic_its_trigger_msi(struct kvm *kvm, struct vgic_its *its,
 	if (err)
 		return err;
 
-	if (irq->hw)
-		return irq_set_irqchip_state(irq->host_irq,
-					     IRQCHIP_STATE_PENDING, true);
+	if (irq->hw) {
+		list_for_each_entry(vlpi_hirq, &irq->host_irq_head, host_irq_list) {
+			err = irq_set_irqchip_state(vlpi_hirq->host_irq,
+						    IRQCHIP_STATE_PENDING, true);
+			if (err)
+				return err;
+			return 0;
+		}
+	}
 
 	raw_spin_lock_irqsave(&irq->irq_lock, flags);
 	irq->pending_latch = true;
@@ -806,12 +827,17 @@ int vgic_its_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
 /* Requires the its_lock to be held. */
 static void its_free_ite(struct kvm *kvm, struct its_ite *ite)
 {
+	struct vlpi_host_irq *vlpi_hirq;
+
 	list_del(&ite->ite_list);
 
 	/* This put matches the get in vgic_add_lpi. */
 	if (ite->irq) {
-		if (ite->irq->hw)
-			WARN_ON(its_unmap_vlpi(ite->irq->host_irq));
+		if (ite->irq->hw) {
+			list_for_each_entry(vlpi_hirq, &ite->irq->host_irq_head, host_irq_list) {
+				WARN_ON(its_unmap_vlpi(vlpi_hirq->host_irq));
+			}
+		}
 
 		vgic_put_irq(kvm, ite->irq);
 	}
@@ -1290,7 +1316,8 @@ static int vgic_its_cmd_handle_clear(struct kvm *kvm, struct vgic_its *its,
 	u32 device_id = its_cmd_get_deviceid(its_cmd);
 	u32 event_id = its_cmd_get_id(its_cmd);
 	struct its_ite *ite;
-
+	struct vlpi_host_irq *vlpi_hirq;
+	int ret;
 
 	ite = find_ite(its, device_id, event_id);
 	if (!ite)
@@ -1298,9 +1325,14 @@ static int vgic_its_cmd_handle_clear(struct kvm *kvm, struct vgic_its *its,
 
 	ite->irq->pending_latch = false;
 
-	if (ite->irq->hw)
-		return irq_set_irqchip_state(ite->irq->host_irq,
-					     IRQCHIP_STATE_PENDING, false);
+	if (ite->irq->hw) {
+		list_for_each_entry(vlpi_hirq, &ite->irq->host_irq_head, host_irq_list) {
+			ret = irq_set_irqchip_state(vlpi_hirq->host_irq,
+						    IRQCHIP_STATE_PENDING, false);
+			if (ret)
+				return ret;
+		}
+	}
 
 	return 0;
 }
diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
index 339a55194b2c..d634ba3dd225 100644
--- a/arch/arm64/kvm/vgic/vgic-v4.c
+++ b/arch/arm64/kvm/vgic/vgic-v4.c
@@ -413,6 +413,7 @@ int kvm_vgic_v4_set_forwarding(struct kvm *kvm, int virq,
 {
 	struct vgic_its *its;
 	struct vgic_irq *irq;
+	struct vlpi_host_irq *vlpi_hirq;
 	struct its_vlpi_map map;
 	unsigned long flags;
 	int ret;
@@ -456,9 +457,19 @@ int kvm_vgic_v4_set_forwarding(struct kvm *kvm, int virq,
 	if (ret)
 		goto out;
 
-	irq->hw		= true;
-	irq->host_irq	= virq;
-	atomic_inc(&map.vpe->vlpi_count);
+	vlpi_hirq = kzalloc(sizeof(struct vlpi_host_irq), GFP_KERNEL_ACCOUNT);
+	if (!vlpi_hirq)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&vlpi_hirq->host_irq_list);
+	vlpi_hirq->host_irq = virq;
+	list_add_tail(&vlpi_hirq->host_irq_list, &irq->host_irq_head);
+
+	if (!atomic_read(&irq->map_count)) {
+		irq->hw = true;
+		atomic_inc(&map.vpe->vlpi_count);
+	}
+	atomic_inc(&irq->map_count);
 
 	/* Transfer pending state */
 	raw_spin_lock_irqsave(&irq->irq_lock, flags);
@@ -488,6 +499,8 @@ int kvm_vgic_v4_unset_forwarding(struct kvm *kvm, int virq,
 {
 	struct vgic_its *its;
 	struct vgic_irq *irq;
+	struct vlpi_host_irq *vlpi_hirq;
+	struct its_vpe *vpe;
 	int ret;
 
 	if (!vgic_supports_direct_msis(kvm))
@@ -508,10 +521,22 @@ int kvm_vgic_v4_unset_forwarding(struct kvm *kvm, int virq,
 	if (ret)
 		goto out;
 
-	WARN_ON(!(irq->hw && irq->host_irq == virq));
+	WARN_ON(!(irq->hw));
 	if (irq->hw) {
-		atomic_dec(&irq->target_vcpu->arch.vgic_cpu.vgic_v3.its_vpe.vlpi_count);
-		irq->hw = false;
+		list_for_each_entry(vlpi_hirq, &irq->host_irq_head, host_irq_list) {
+			if (vlpi_hirq->host_irq == virq) {
+				list_del(&vlpi_hirq->host_irq_list);
+				kfree(vlpi_hirq);
+				break;
+			}
+		}
+
+		atomic_dec(&irq->map_count);
+		if (!atomic_read(&irq->map_count)) {
+			vpe = &irq->target_vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
+			atomic_dec(&vpe->vlpi_count);
+			irq->hw = false;
+		}
 		ret = its_unmap_vlpi(virq);
 	}
 
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 5b27f94d4fad..2b8f25d1eff2 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -114,6 +114,11 @@ struct irq_ops {
 	bool (*get_input_level)(int vintid);
 };
 
+struct vlpi_host_irq {
+	struct list_head host_irq_list;
+	unsigned int host_irq;
+};
+
 struct vgic_irq {
 	raw_spinlock_t irq_lock;	/* Protects the content of the struct */
 	struct list_head lpi_list;	/* Used to link all LPIs together */
@@ -138,6 +143,8 @@ struct vgic_irq {
 	bool active;			/* not used for LPIs */
 	bool enabled;
 	bool hw;			/* Tied to HW IRQ */
+	atomic_t map_count;		/* record vLPI map times */
+	struct list_head host_irq_head;	/* record host irqs list of a vLPI */
 	struct kref refcount;		/* Used for LPIs */
 	u32 hwintid;			/* HW INTID number */
 	unsigned int host_irq;		/* linux irq corresponding to hwintid */
-- 
2.33.0

