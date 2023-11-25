Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD467F8927
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjKYISw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjKYISs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:18:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD523B7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700900333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7gWnKow7mmEdO4f39vqBRl04PZThOfmSepuYQVktBy4=;
        b=C0MYdLZF+lm3vCMOMwZdg4uIBTyMmT6w3ZOWd8xu5aARMbaHrd3kgB5mop4E776U/1WMgR
        w3XRewCf3AqmFqcd+N/Vqpwu6GzXsUddMiKyz0lGE2TaPHpQDxjF+lsK6zFrTfkZPKqw6V
        fDvIq8DHz/obDAcNbTMT3awetGh/tHY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-n9Qe_U-mMWWK-hI_hA54Ug-1; Sat,
 25 Nov 2023 03:18:51 -0500
X-MC-Unique: n9Qe_U-mMWWK-hI_hA54Ug-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 792C43810B33;
        Sat, 25 Nov 2023 08:18:51 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 603EB1C060B0;
        Sat, 25 Nov 2023 08:18:51 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH] KVM: remove CONFIG_HAVE_KVM_EVENTFD
Date:   Sat, 25 Nov 2023 03:18:50 -0500
Message-Id: <20231125081850.1388059-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virt/kvm/eventfd.c is compiled unconditionally, meaning that the ioeventfds
member of struct kvm is accessed unconditionally.  CONFIG_HAVE_KVM_EVENTFD
therefore must be defined for KVM common code to compile successfully,
remove it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/arm64/kvm/Kconfig     |  1 -
 arch/loongarch/kvm/Kconfig |  1 -
 arch/mips/kvm/Kconfig      |  1 -
 arch/powerpc/kvm/Kconfig   |  1 -
 arch/riscv/kvm/Kconfig     |  1 -
 arch/s390/kvm/Kconfig      |  1 -
 arch/x86/kvm/Kconfig       |  1 -
 include/linux/kvm_host.h   | 30 +-----------------------------
 virt/kvm/Kconfig           |  5 +----
 9 files changed, 2 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 83c1e09be42e..5d9b68b5a0b3 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -29,7 +29,6 @@ menuconfig KVM
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_XFER_TO_GUEST_WORK
 	select KVM_VFIO
-	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_IRQFD
 	select HAVE_KVM_DIRTY_RING_ACQ_REL
 	select NEED_KVM_DIRTY_RING_WITH_BITMAP
diff --git a/arch/loongarch/kvm/Kconfig b/arch/loongarch/kvm/Kconfig
index fda425babfb2..de19b9d9a444 100644
--- a/arch/loongarch/kvm/Kconfig
+++ b/arch/loongarch/kvm/Kconfig
@@ -22,7 +22,6 @@ config KVM
 	depends on AS_HAS_LVZ_EXTENSION
 	depends on HAVE_KVM
 	select HAVE_KVM_DIRTY_RING_ACQ_REL
-	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_VCPU_ASYNC_IOCTL
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_GENERIC_HARDWARE_ENABLING
diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index a8cdba75f98d..c7fc176fffc3 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -22,7 +22,6 @@ config KVM
 	select EXPORT_UASM
 	select PREEMPT_NOTIFIERS
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
-	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_VCPU_ASYNC_IOCTL
 	select KVM_MMIO
 	select MMU_NOTIFIER
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 902611954200..8a3d08559f11 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -20,7 +20,6 @@ if VIRTUALIZATION
 config KVM
 	bool
 	select PREEMPT_NOTIFIERS
-	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_VCPU_ASYNC_IOCTL
 	select KVM_VFIO
 	select IRQ_BYPASS_MANAGER
diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index dfc237d7875b..642f8d95289b 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -20,7 +20,6 @@ if VIRTUALIZATION
 config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support (EXPERIMENTAL)"
 	depends on RISCV_SBI && MMU
-	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQFD
 	select HAVE_KVM_IRQ_ROUTING
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index 45fdf2a9b2e3..ed567b858535 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -23,7 +23,6 @@ config KVM
 	select PREEMPT_NOTIFIERS
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select HAVE_KVM_VCPU_ASYNC_IOCTL
-	select HAVE_KVM_EVENTFD
 	select KVM_ASYNC_PF
 	select KVM_ASYNC_PF_SYNC
 	select HAVE_KVM_IRQCHIP
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 950c12868d30..2efda4fc6a21 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -33,7 +33,6 @@ config KVM
 	select IRQ_BYPASS_MANAGER
 	select HAVE_KVM_IRQ_BYPASS
 	select HAVE_KVM_IRQ_ROUTING
-	select HAVE_KVM_EVENTFD
 	select KVM_ASYNC_PF
 	select USER_RETURN_NOTIFIER
 	select KVM_MMIO
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4944136efaa2..b043202dd0b4 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -753,7 +753,6 @@ struct kvm {
 	struct list_head vm_list;
 	struct mutex lock;
 	struct kvm_io_bus __rcu *buses[KVM_NR_BUSES];
-#ifdef CONFIG_HAVE_KVM_EVENTFD
 	struct {
 		spinlock_t        lock;
 		struct list_head  items;
@@ -762,7 +761,6 @@ struct kvm {
 		struct mutex      resampler_lock;
 	} irqfds;
 	struct list_head ioeventfds;
-#endif
 	struct kvm_vm_stat stat;
 	struct kvm_arch arch;
 	refcount_t users_count;
@@ -2013,8 +2011,6 @@ static inline void kvm_free_irq_routing(struct kvm *kvm) {}
 
 int kvm_send_userspace_msi(struct kvm *kvm, struct kvm_msi *msi);
 
-#ifdef CONFIG_HAVE_KVM_EVENTFD
-
 void kvm_eventfd_init(struct kvm *kvm);
 int kvm_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args);
 
@@ -2039,31 +2035,7 @@ static inline bool kvm_notify_irqfd_resampler(struct kvm *kvm,
 {
 	return false;
 }
-#endif
-
-#else
-
-static inline void kvm_eventfd_init(struct kvm *kvm) {}
-
-static inline int kvm_irqfd(struct kvm *kvm, struct kvm_irqfd *args)
-{
-	return -EINVAL;
-}
-
-static inline void kvm_irqfd_release(struct kvm *kvm) {}
-
-#ifdef CONFIG_HAVE_KVM_IRQCHIP
-static inline void kvm_irq_routing_update(struct kvm *kvm)
-{
-}
-#endif
-
-static inline int kvm_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args)
-{
-	return -ENOSYS;
-}
-
-#endif /* CONFIG_HAVE_KVM_EVENTFD */
+#endif /* CONFIG_HAVE_KVM_IRQFD */
 
 void kvm_arch_irq_routing_update(struct kvm *kvm);
 
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 484d0873061c..18b5a8fb491b 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -3,6 +3,7 @@
 
 config HAVE_KVM
        bool
+       select EVENTFD
 
 config HAVE_KVM_PFNCACHE
        bool
@@ -39,10 +40,6 @@ config NEED_KVM_DIRTY_RING_WITH_BITMAP
 	bool
 	depends on HAVE_KVM_DIRTY_RING
 
-config HAVE_KVM_EVENTFD
-       bool
-       select EVENTFD
-
 config KVM_MMIO
        bool
 
-- 
2.39.1

