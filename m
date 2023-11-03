Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D423A7E0BEA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376749AbjKCXGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjKCXF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:05:56 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80CFD72
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:05:53 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5b62a669d61so1919899a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 16:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699052753; x=1699657553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KalgR4SKhAn+0sVVXRME3OmIqom3v7Pw10s1BHql8OU=;
        b=qJpmvbS4OgR53WFbHs4AZgKDK5ndzazak1vWEbz/cDu6CgzVXgDynazd9FqmPpal3x
         cTu/rGCHdGUYjECGOWrV6pmfhcqQm6SXNGQvdDJFO2Ad1g6nzx/c+eDWpeBjmCtGNTEv
         FNSWmhJu9y985Wwe4KRQDCUluhoT5vbHyqXIaQaQsl33REWDVBH+Ql4LiukQEd7vC2LL
         9A41oSFLehYil9jiv4L58PfRA5SerZXfovsWnpvaJTqhWHGos1EG1JlhtHkrSrVrmTNs
         vpwmumI2Y7ivqlesPqGUMfmNOpka1mf3EJvfhFCPw12j91gp+D0TIZHM53F03W3AxHXJ
         2FfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699052753; x=1699657553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KalgR4SKhAn+0sVVXRME3OmIqom3v7Pw10s1BHql8OU=;
        b=FuF5/x5ypCksm5TgY/xu8CgDoaAbx+TynGaNHxhy5WJooDcnnTQc3LYDzSqdPJkDR+
         J542riQoOMkcrqpQhOQQOktlfldLhxV0SHzjuLiH66whcZqV+BwDDDTeDtnXR7JewZfF
         fCKrjtRE2yeRxlGyuKsgshEDRuclEVC+ZUbiueScg9g0ZCKiNmW01B7DKzhSX6u0cex7
         pVwxgnVymPnnbXmKDqrahsFtnWgTNEqCoa0wCYp0HxkIPDB12vHlzBygHzzUeBkPhpT5
         +f8ChwHaFyZ26R+TvKKPdXZacDi9Y7jd2CPGd1uk9OOjWb11pKyuol4EYgg6voeKdzt/
         IFkw==
X-Gm-Message-State: AOJu0Yw+C8EmYcQ7rg9tItwfPkWRjOBsKk3zdkr+wWYjXsoFlmIMFtKd
        NGeNlypybJ0XTsG4gTxTAtEu2U8AkdU=
X-Google-Smtp-Source: AGHT+IHKLQjPHL3n2kllMLwJDbv0Cew6To0NVPSGT/ozQbYBOu+Gv6NZi/BCRRom0CQh5YNSoT3WIBNa6hU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:efd1:b0:1c6:2b9d:570b with SMTP id
 ja17-20020a170902efd100b001c62b9d570bmr412463plb.7.1699052753358; Fri, 03 Nov
 2023 16:05:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Nov 2023 16:05:40 -0700
In-Reply-To: <20231103230541.352265-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231103230541.352265-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231103230541.352265-6-seanjc@google.com>
Subject: [PATCH v2 5/6] KVM: x86/pmu: Update sample period in pmc_write_counter()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Mingwei Zhang <mizhang@google.com>,
        Roman Kagan <rkagan@amazon.de>,
        Jim Mattson <jmattson@google.com>,
        Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update a PMC's sample period in pmc_write_counter() to deduplicate code
across all callers of pmc_write_counter().  Opportunistically move
pmc_write_counter() into pmc.c now that it's doing more work.  WRMSR isn't
such a hot path that an extra CALL+RET pair will be problematic, and the
order of function definitions needs to be changed anyways, i.e. now is a
convenient time to eat the churn.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c           | 27 +++++++++++++++++++++++++++
 arch/x86/kvm/pmu.h           | 25 +------------------------
 arch/x86/kvm/svm/pmu.c       |  1 -
 arch/x86/kvm/vmx/pmu_intel.c |  2 --
 4 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index c06090196b00..3725d001239d 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -161,6 +161,15 @@ static u64 pmc_get_pebs_precise_level(struct kvm_pmc *pmc)
 	return 1;
 }
 
+static u64 get_sample_period(struct kvm_pmc *pmc, u64 counter_value)
+{
+	u64 sample_period = (-counter_value) & pmc_bitmask(pmc);
+
+	if (!sample_period)
+		sample_period = pmc_bitmask(pmc) + 1;
+	return sample_period;
+}
+
 static int pmc_reprogram_counter(struct kvm_pmc *pmc, u32 type, u64 config,
 				 bool exclude_user, bool exclude_kernel,
 				 bool intr)
@@ -268,6 +277,24 @@ static void pmc_stop_counter(struct kvm_pmc *pmc)
 	}
 }
 
+static void pmc_update_sample_period(struct kvm_pmc *pmc)
+{
+	if (!pmc->perf_event || pmc->is_paused ||
+	    !is_sampling_event(pmc->perf_event))
+		return;
+
+	perf_event_period(pmc->perf_event,
+			  get_sample_period(pmc, pmc->counter));
+}
+
+void pmc_write_counter(struct kvm_pmc *pmc, u64 val)
+{
+	pmc->counter += val - pmc_read_counter(pmc);
+	pmc->counter &= pmc_bitmask(pmc);
+	pmc_update_sample_period(pmc);
+}
+EXPORT_SYMBOL_GPL(pmc_write_counter);
+
 static int filter_cmp(const void *pa, const void *pb, u64 mask)
 {
 	u64 a = *(u64 *)pa & mask;
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index db9a12c0a2ef..cae85e550f60 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -74,11 +74,7 @@ static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
 	return counter & pmc_bitmask(pmc);
 }
 
-static inline void pmc_write_counter(struct kvm_pmc *pmc, u64 val)
-{
-	pmc->counter += val - pmc_read_counter(pmc);
-	pmc->counter &= pmc_bitmask(pmc);
-}
+void pmc_write_counter(struct kvm_pmc *pmc, u64 val);
 
 static inline bool pmc_is_gp(struct kvm_pmc *pmc)
 {
@@ -128,25 +124,6 @@ static inline struct kvm_pmc *get_fixed_pmc(struct kvm_pmu *pmu, u32 msr)
 	return NULL;
 }
 
-static inline u64 get_sample_period(struct kvm_pmc *pmc, u64 counter_value)
-{
-	u64 sample_period = (-counter_value) & pmc_bitmask(pmc);
-
-	if (!sample_period)
-		sample_period = pmc_bitmask(pmc) + 1;
-	return sample_period;
-}
-
-static inline void pmc_update_sample_period(struct kvm_pmc *pmc)
-{
-	if (!pmc->perf_event || pmc->is_paused ||
-	    !is_sampling_event(pmc->perf_event))
-		return;
-
-	perf_event_period(pmc->perf_event,
-			  get_sample_period(pmc, pmc->counter));
-}
-
 static inline bool pmc_speculative_in_use(struct kvm_pmc *pmc)
 {
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 3fd47de14b38..b6a7ad4d6914 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -161,7 +161,6 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_COUNTER);
 	if (pmc) {
 		pmc_write_counter(pmc, data);
-		pmc_update_sample_period(pmc);
 		return 0;
 	}
 	/* MSR_EVNTSELn */
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 90c1f7f07e53..a6216c874729 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -437,11 +437,9 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			    !(msr & MSR_PMC_FULL_WIDTH_BIT))
 				data = (s64)(s32)data;
 			pmc_write_counter(pmc, data);
-			pmc_update_sample_period(pmc);
 			break;
 		} else if ((pmc = get_fixed_pmc(pmu, msr))) {
 			pmc_write_counter(pmc, data);
-			pmc_update_sample_period(pmc);
 			break;
 		} else if ((pmc = get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0))) {
 			reserved_bits = pmu->reserved_bits;
-- 
2.42.0.869.gea05f2083d-goog

