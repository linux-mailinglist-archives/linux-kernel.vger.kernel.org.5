Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C347ADDD9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjIYRfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjIYRfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:35:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7AB10D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:34:57 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bdb9fe821so130672627b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695663296; x=1696268096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=N3mybIXWXmxE94oHFn/stJfySL7s2PMrxYppKn/7o5E=;
        b=l0fgHK/tYNmZCoIFnp1u4GvzMn7MgmKgs5nOMB3MmccHqjSaqHWNLifvBUHB2HkP5G
         Cwg1jYsQ0A6KaBUrNEljJFvPilIDVizpCoxwsOs1pr/jCqQy/Y2ed9BE7Qo18KkFK1q6
         1yc16MNM0qrsVAcwERqCi31kgrzr1sJW/o50OfMtO4H31yHnCfzx3Bf9BZg2m+HJUBix
         8iepH2LOryPebM4GT/Ncx5s285FB5aECVxjqhDg2aSmVmYYi6T37XzHl8zlotEq5jaNR
         WR1e07AGxzoRzshTPoF8yOewo8YPbtadgqlVveMSntpz5LpIuf4tCg964F7u9IPzmCIh
         vqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695663296; x=1696268096;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3mybIXWXmxE94oHFn/stJfySL7s2PMrxYppKn/7o5E=;
        b=wlSZvtTaXABm6jcSjaQRw5B1jM0OgLvN36IAB5zMQ7UHkG8unKhHFcQ5gduIzCJKV4
         HAbq/cuhGQg/8IpzR0GeVwTWiL4aNktIBE3fX25oTOUawAotP3qQTffgyvLt28oSTIbE
         uSNH2Zb17AEx023i05GhyCaC/TCbNfkdNNFpUFi/4w40iRnQO0Cmcfnvy+7JNWY+Dylg
         Zu9SJQUi7slOzboM+q9yt1ii077s7mAE7+SXqNOrhyvYs/+wpnQvtjuNoN9W+/hJRfAl
         YOm+n5OtbsuB8QL8SBovpf3ftYvrKwtoaCwa+F7dSyGv/2W03hOfNSJS7ljdwA82VOiD
         YwFQ==
X-Gm-Message-State: AOJu0YyEk01DBkiPrR2LjINEL/nhvb3vAzXgzipCerealzaMXVsiFXqi
        Sli6Os349c5k+YKwBmG2vgSrOpFiEJhb
X-Google-Smtp-Source: AGHT+IHTdPAbOtwbBgEp9hepQIswdjpp8KG/4U+ekKeqn+bsXsD9154D6JJa9O9ixd1/G9KRNKfYk3myvjMQ
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a81:ac20:0:b0:59e:ee51:52a1 with SMTP id
 k32-20020a81ac20000000b0059eee5152a1mr93922ywh.10.1695663296760; Mon, 25 Sep
 2023 10:34:56 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Mon, 25 Sep 2023 17:34:46 +0000
In-Reply-To: <20230925173448.3518223-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230925173448.3518223-1-mizhang@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230925173448.3518223-2-mizhang@google.com>
Subject: [PATCH 1/2] KVM: x86: Synthesize at most one PMI per VM-exit
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Like Xu <likexu@tencent.com>, Roman Kagan <rkagan@amazon.de>,
        Kan Liang <kan.liang@intel.com>,
        Dapeng1 Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Mattson <jmattson@google.com>

When the irq_work callback, kvm_pmi_trigger_fn(), is invoked during a
VM-exit that also invokes __kvm_perf_overflow() as a result of
instruction emulation, kvm_pmu_deliver_pmi() will be called twice
before the next VM-entry.

That shouldn't be a problem. The local APIC is supposed to
automatically set the mask flag in LVTPC when it handles a PMI, so the
second PMI should be inhibited. However, KVM's local APIC emulation
fails to set the mask flag in LVTPC when it handles a PMI, so two PMIs
are delivered via the local APIC. In the common case, where LVTPC is
configured to deliver an NMI, the first NMI is vectored through the
guest IDT, and the second one is held pending. When the NMI handler
returns, the second NMI is vectored through the IDT. For Linux guests,
this results in the "dazed and confused" spurious NMI message.

Though the obvious fix is to set the mask flag in LVTPC when handling
a PMI, KVM's logic around synthesizing a PMI is unnecessarily
convoluted.

Remove the irq_work callback for synthesizing a PMI, and all of the
logic for invoking it. Instead, to prevent a vcpu from leaving C0 with
a PMI pending, add a check for KVM_REQ_PMI to kvm_vcpu_has_events().

Fixes: 9cd803d496e7 ("KVM: x86: Update vPMCs when retiring instructions")
Signed-off-by: Jim Mattson <jmattson@google.com>
Tested-by: Mingwei Zhang <mizhang@google.com>
Tested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/pmu.c              | 27 +--------------------------
 arch/x86/kvm/x86.c              |  3 +++
 3 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 28bd38303d70..de951d6aa9a8 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -528,7 +528,6 @@ struct kvm_pmu {
 	u64 raw_event_mask;
 	struct kvm_pmc gp_counters[KVM_INTEL_PMC_MAX_GENERIC];
 	struct kvm_pmc fixed_counters[KVM_PMC_MAX_FIXED];
-	struct irq_work irq_work;
 
 	/*
 	 * Overlay the bitmap with a 64-bit atomic so that all bits can be
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index edb89b51b383..9ae07db6f0f6 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -93,14 +93,6 @@ void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops)
 #undef __KVM_X86_PMU_OP
 }
 
-static void kvm_pmi_trigger_fn(struct irq_work *irq_work)
-{
-	struct kvm_pmu *pmu = container_of(irq_work, struct kvm_pmu, irq_work);
-	struct kvm_vcpu *vcpu = pmu_to_vcpu(pmu);
-
-	kvm_pmu_deliver_pmi(vcpu);
-}
-
 static inline void __kvm_perf_overflow(struct kvm_pmc *pmc, bool in_pmi)
 {
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
@@ -124,20 +116,7 @@ static inline void __kvm_perf_overflow(struct kvm_pmc *pmc, bool in_pmi)
 		__set_bit(pmc->idx, (unsigned long *)&pmu->global_status);
 	}
 
-	if (!pmc->intr || skip_pmi)
-		return;
-
-	/*
-	 * Inject PMI. If vcpu was in a guest mode during NMI PMI
-	 * can be ejected on a guest mode re-entry. Otherwise we can't
-	 * be sure that vcpu wasn't executing hlt instruction at the
-	 * time of vmexit and is not going to re-enter guest mode until
-	 * woken up. So we should wake it, but this is impossible from
-	 * NMI context. Do it from irq work instead.
-	 */
-	if (in_pmi && !kvm_handling_nmi_from_guest(pmc->vcpu))
-		irq_work_queue(&pmc_to_pmu(pmc)->irq_work);
-	else
+	if (pmc->intr && !skip_pmi)
 		kvm_make_request(KVM_REQ_PMI, pmc->vcpu);
 }
 
@@ -675,9 +654,6 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 
 void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 {
-	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
-
-	irq_work_sync(&pmu->irq_work);
 	static_call(kvm_x86_pmu_reset)(vcpu);
 }
 
@@ -687,7 +663,6 @@ void kvm_pmu_init(struct kvm_vcpu *vcpu)
 
 	memset(pmu, 0, sizeof(*pmu));
 	static_call(kvm_x86_pmu_init)(vcpu);
-	init_irq_work(&pmu->irq_work, kvm_pmi_trigger_fn);
 	pmu->event_count = 0;
 	pmu->need_cleanup = false;
 	kvm_pmu_refresh(vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a6b9bea62fb8..6f24a8c1e136 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12820,6 +12820,9 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 		return true;
 #endif
 
+	if (kvm_test_request(KVM_REQ_PMI, vcpu))
+		return true;
+
 	if (kvm_arch_interrupt_allowed(vcpu) &&
 	    (kvm_cpu_has_interrupt(vcpu) ||
 	    kvm_guest_apic_has_interrupt(vcpu)))
-- 
2.42.0.515.g380fc7ccd1-goog

