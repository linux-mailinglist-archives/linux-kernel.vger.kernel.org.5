Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1BC7E0C87
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 01:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjKDADA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 20:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjKDACs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 20:02:48 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D849D52
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 17:02:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7c97d5d5aso36356147b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 17:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699056164; x=1699660964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=p4xV9oxEUCCvhRrb6fqtuKFYy/N3YfDlsPZEG53vyL0=;
        b=otFSU2wWsZyl6neWohK/oP5brqvW3GLUgh7Q9z4+AzrG2/RG/ZeNc6EanSs3Q5VcOo
         TRrENT125CPq3l9YFbCsGPuFjWXD1/RODD/vBgJ6yC9FZuWaoCeMQcDmNWZvVVmB0nSv
         nwlV2/LI+/7KTg3ZZeLx/VCKlQ0qgGmUAauD/3WwkJnHCooiv/i9Xe1BMMTD8MK2Br3Z
         tF9gFAeiDpDxCcUmod7qNxBHWGfOY6rKtYkBFv/CPldYLWzRXXXmtsRfY0pK/3DT/6lJ
         ZFRwt6DcwtiWD26JOzyj017zB1aGraj4kUwhZM42gUBFjbJUgDYm7YGG9tBofMSWhBYn
         ahcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699056164; x=1699660964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4xV9oxEUCCvhRrb6fqtuKFYy/N3YfDlsPZEG53vyL0=;
        b=G9udR8SO8uhOH8EtJKm640DlGdwbLKWWZgilf9XySeNp0WCkj5nwo/VZ4BavzaLmaw
         zIbwvvycSEekRtw4VDe3QBpJCAVjBC1Gc85UeSccIpEk1ZHnA1hZyPdXKM8tqkDsbwIC
         doZ09MATtU46SX/aUUCjvbm6MHuUUE0qhaOjhByOmctNH6UsQLQIxiWb+CY2sKsjBoiZ
         jBTgh/XLvGBILNQ8oJSAel07DPGp1reIA+V7RyHc+xvxv6T4I7B1r8al+pXejFvl2BBC
         ltB3XH99mtDbEq1jgo6Fd5UKgWomb+m4gO1gwxa/3L/OWr+v//fxGxcCfmBY+dCi3O/G
         iJJg==
X-Gm-Message-State: AOJu0YzuOyX3nezg9RR6goAnBgolYPtLBNxmPr/HEnaMANafg4vWHJdQ
        BJ0FcT+9wlGCwFBaLmOc/qJJPzh+hxw=
X-Google-Smtp-Source: AGHT+IFF5h6aHvxK72aMJUSi4VypGMmZlTaV053V/rwUhfhONXUsVv99CMju5sH06/LqKgg4wCIizIPYbAE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:bc90:0:b0:d9c:c9a8:8c27 with SMTP id
 e16-20020a25bc90000000b00d9cc9a88c27mr445478ybk.13.1699056164647; Fri, 03 Nov
 2023 17:02:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Nov 2023 17:02:20 -0700
In-Reply-To: <20231104000239.367005-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231104000239.367005-3-seanjc@google.com>
Subject: [PATCH v6 02/20] KVM: x86/pmu: Don't enumerate support for fixed
 counters KVM can't virtualize
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Like Xu <likexu@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hide fixed counters for which perf is incapable of creating the associated
architectural event.  Except for the so called pseudo-architectural event
for counting TSC reference cycle, KVM virtualizes fixed counters by
creating a perf event for the associated general purpose architectural
event.  If the associated event isn't supported in hardware, KVM can't
actually virtualize the fixed counter because perf will likely not program
up the correct event.

Note, this issue is almost certainly limited to running KVM on a funky
virtual CPU model, no known real hardware has an asymmetric PMU where a
fixed counter is supported but the associated architectural event is not.

Fixes: f5132b01386b ("KVM: Expose a version 2 architectural PMU to a guests")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.h           |  4 ++++
 arch/x86/kvm/vmx/pmu_intel.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 1d64113de488..5341e8f69a22 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -19,6 +19,7 @@
 #define VMWARE_BACKDOOR_PMC_APPARENT_TIME	0x10002
 
 struct kvm_pmu_ops {
+	void (*init_pmu_capability)(void);
 	bool (*hw_event_available)(struct kvm_pmc *pmc);
 	struct kvm_pmc *(*pmc_idx_to_pmc)(struct kvm_pmu *pmu, int pmc_idx);
 	struct kvm_pmc *(*rdpmc_ecx_to_pmc)(struct kvm_vcpu *vcpu,
@@ -218,6 +219,9 @@ static inline void kvm_init_pmu_capability(const struct kvm_pmu_ops *pmu_ops)
 					  pmu_ops->MAX_NR_GP_COUNTERS);
 	kvm_pmu_cap.num_counters_fixed = min(kvm_pmu_cap.num_counters_fixed,
 					     KVM_PMC_MAX_FIXED);
+
+	if (pmu_ops->init_pmu_capability)
+		pmu_ops->init_pmu_capability();
 }
 
 static inline void kvm_pmu_request_counter_reprogram(struct kvm_pmc *pmc)
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 1b13a472e3f2..3316fdea212a 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -68,6 +68,36 @@ static int fixed_pmc_events[] = {
 	[2] = PSEUDO_ARCH_REFERENCE_CYCLES,
 };
 
+static void intel_init_pmu_capability(void)
+{
+	int i;
+
+	/*
+	 * Perf may (sadly) back a guest fixed counter with a general purpose
+	 * counter, and so KVM must hide fixed counters whose associated
+	 * architectural event are unsupported.  On real hardware, this should
+	 * never happen, but if KVM is running on a funky virtual CPU model...
+	 *
+	 * TODO: Drop this horror if/when KVM stops using perf events for
+	 * guest fixed counters, or can explicitly request fixed counters.
+	 */
+	for (i = 0; i < kvm_pmu_cap.num_counters_fixed; i++) {
+		int event = fixed_pmc_events[i];
+
+		/*
+		 * Ignore pseudo-architectural events, they're a bizarre way of
+		 * requesting events from perf that _can't_ be backed with a
+		 * general purpose architectural event, i.e. they're guaranteed
+		 * to be backed by the real fixed counter.
+		 */
+		if (event < NR_REAL_INTEL_ARCH_EVENTS &&
+		    (kvm_pmu_cap.events_mask & BIT(event)))
+			break;
+	}
+
+	kvm_pmu_cap.num_counters_fixed = i;
+}
+
 static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 {
 	struct kvm_pmc *pmc;
@@ -789,6 +819,7 @@ void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu)
 }
 
 struct kvm_pmu_ops intel_pmu_ops __initdata = {
+	.init_pmu_capability = intel_init_pmu_capability,
 	.hw_event_available = intel_hw_event_available,
 	.pmc_idx_to_pmc = intel_pmc_idx_to_pmc,
 	.rdpmc_ecx_to_pmc = intel_rdpmc_ecx_to_pmc,
-- 
2.42.0.869.gea05f2083d-goog

