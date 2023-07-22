Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87E475D8FA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 04:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjGVCXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 22:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjGVCXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 22:23:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D2630E3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 19:22:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5704995f964so27147247b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 19:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689992577; x=1690597377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SI6Gva1qvgHyCE7QYiuLXB9Rb6SmeiZnCZaqC2WR/Sc=;
        b=pclINCkRdRgYAwaus01ejO4ihWr9A2XfL0ddUkYV/8EArvjBZbbuZd1gAvOxilC3EG
         LI5ig+mCKvx5zZiKKeWtoSn1KRLqe9PQt44bIhGnETmctKhIlGGYczLFfINjjUmeV8eM
         vF/f00G3soAZho0MrsjCa00CHbPDXDffhgNgwsvO6ihBYLorYgrQRClyFLc4+ju/Ndg2
         KuE5q+mG/CiKyTPw9stpjZ4mmv5/rWSOe25ukny2y+mj1Vac8JoETMrp/Yu7K8MxNjLv
         ZwVGfuZusT3+e53fBM7XlIyyfghatocIbRyjEOEWb7qvJx+JIJLcOjh2l5X25Jd+zX6l
         km/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689992577; x=1690597377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SI6Gva1qvgHyCE7QYiuLXB9Rb6SmeiZnCZaqC2WR/Sc=;
        b=dF5oYBCHbG70sUrA0ADB/EZiyO4++Ad77QgSs5i3e2bJK9YJrcqWmZVmlCuUgGi61W
         ON21E9zP+5e3nL1U1Y7RQF1VMhsQFFBjbKcVODXbr6V7tVS+SBDd7gcEeo/V9jW90+Zb
         2Xiu/0bxTxT+mMAWFT97BHL2jTnWWuaYCJcNZxU3971HFyiQDgabornz+kbwP5WnGSH0
         6trDcj1tYZiw4VIhtT/gxD+hlvMIXTNv2H7mecP164uHLDlhzKcFCow2lOgCO8UBC2jA
         pgbbIvGNdyB0M1fgNubqdjGtjV7qBpLj5B0Awk1swSsdHMWBJppLjVm87Oee65eCZaN7
         rEnA==
X-Gm-Message-State: ABy/qLa8EGhtTAOi7iN/Lk1tVlApFy1QGsVl+AX3sXtkmudvfr7i/c+p
        zFgQlUa0JO0a6XiQz7WJE/WKKSpJh8yn
X-Google-Smtp-Source: APBJJlE74S44aAdDkeUWprjnh97a+iXOQv70bhnTttKdjXjLztwho8eu5se6DQmHFzL4Hoaq3q6ibV20GsDb
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a81:e801:0:b0:57a:793:7fb0 with SMTP id
 a1-20020a81e801000000b0057a07937fb0mr15253ywm.3.1689992577014; Fri, 21 Jul
 2023 19:22:57 -0700 (PDT)
Date:   Sat, 22 Jul 2023 02:22:41 +0000
In-Reply-To: <20230722022251.3446223-1-rananta@google.com>
Mime-Version: 1.0
References: <20230722022251.3446223-1-rananta@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230722022251.3446223-3-rananta@google.com>
Subject: [PATCH v7 02/12] KVM: arm64: Use kvm_arch_flush_remote_tlbs()
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jing Zhang <jingzhangos@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        David Matlack <dmatlack@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop depending on CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL and opt to
standardize on kvm_arch_flush_remote_tlbs() since it avoids
duplicating the generic TLB stats across architectures that implement
their own remote TLB flush.

This adds an extra function call to the ARM64 kvm_flush_remote_tlbs()
path, but that is a small cost in comparison to flushing remote TLBs.

In addition, instead of just incrementing remote_tlb_flush_requests
stat, the generic interface would also increment the
remote_tlb_flush stat.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 3 +++
 arch/arm64/kvm/Kconfig            | 1 -
 arch/arm64/kvm/mmu.c              | 6 +++---
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 8b6096753740..7281222f24ef 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1111,6 +1111,9 @@ int __init kvm_set_ipa_limit(void);
 #define __KVM_HAVE_ARCH_VM_ALLOC
 struct kvm *kvm_arch_alloc_vm(void);
 
+#define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS
+int kvm_arch_flush_remote_tlbs(struct kvm *kvm);
+
 static inline bool kvm_vm_is_protected(struct kvm *kvm)
 {
 	return false;
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index f531da6b362e..6b730fcfee37 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -25,7 +25,6 @@ menuconfig KVM
 	select MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
-	select HAVE_KVM_ARCH_TLB_FLUSH_ALL
 	select KVM_MMIO
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_XFER_TO_GUEST_WORK
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 6db9ef288ec3..0ac721fa27f1 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -161,15 +161,15 @@ static bool memslot_is_logging(struct kvm_memory_slot *memslot)
 }
 
 /**
- * kvm_flush_remote_tlbs() - flush all VM TLB entries for v7/8
+ * kvm_arch_flush_remote_tlbs() - flush all VM TLB entries for v7/8
  * @kvm:	pointer to kvm structure.
  *
  * Interface to HYP function to flush all VM TLB entries
  */
-void kvm_flush_remote_tlbs(struct kvm *kvm)
+int kvm_arch_flush_remote_tlbs(struct kvm *kvm)
 {
-	++kvm->stat.generic.remote_tlb_flush_requests;
 	kvm_call_hyp(__kvm_tlb_flush_vmid, &kvm->arch.mmu);
+	return 0;
 }
 
 static bool kvm_is_device_pfn(unsigned long pfn)
-- 
2.41.0.487.g6d72f3e995-goog

