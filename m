Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CD67E7776
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345787AbjKJC3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345773AbjKJC3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:29:18 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C24446A3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:29:12 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b31e000e97so21857847b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699583351; x=1700188151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5SlrZj36n0KChIF9h7ClFhiP6zYdMuLYWl1Pm7fXb0o=;
        b=aGTsrWI6rNx2REpLaZfKFSLSD/hcmTzs1814Pp82zEYuYvL3JggSLNVzAob/txjcJs
         ldcP57jwqy9gnJNPzwVvM4qC/WOsXZ7+/5UblA3iyFsP5QK53pXs37YBELaYwv9NNLKi
         9MMo2fBt40/WVfbubfj/RfJ0EscJyX9nTCODarsHSbV0xcYg7K56LU43PEoCWP5HgMSD
         /QetNZmWomGIDPb1Cr7GObxq32cUg3hNIWqnoawoWGgckqVd9EijwzaM8IqocF3TeE65
         MEJWuV4srT4g31h1NomwG3MmDAKyNMS/KNL/8cz/YvK5a19yS5e3zMLcosAI8G/qF2zu
         Hs4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699583351; x=1700188151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SlrZj36n0KChIF9h7ClFhiP6zYdMuLYWl1Pm7fXb0o=;
        b=ifZyNYbWWTRvIOQzX1tuqsaUYjH2udHoKftmjRnitjnufji2eBaUPzSyGvjR9x3A1z
         FhmHs+Egv+wW+7+qDFBaCtYM/OVnVihvdL4AEE1461Q4S6KZuaGzz1V1TnUm9reWwQbd
         YGQKIrAMsJ98FDNuyuUjSjBJVWQvnuGkFv5vfB0pp3q4NgfoE2T9VXSyBUNKu66AZxo3
         TOJuk1aD3Fn3Vsz3l438uvX0mkCDqxUh/mEToW9wGw7YWlhD7LBFxm+Rw+coNngfno9e
         6dwnIYpt4NUNA/gBnkuJU2vOq4hMeEVOHMdWoK9SwdYHze5tWhoo8XcObXVd+A96ZxOe
         w0Zw==
X-Gm-Message-State: AOJu0YzKueT6JcHfZMiUw2vGZYxDmYANDwScCl2zEhCet09awMLinVP4
        psR6FGsoJcV0Qkj5KK5tFQCqjDvQf0c=
X-Google-Smtp-Source: AGHT+IGFCa9KkZ81i+JJNjZhR4CIbz66m6zI5H/yCZMjmXJL+cscV1zQxhDZNMxmnsOJUKFv8SOM0ug181w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:f12:0:b0:da1:513d:8a3c with SMTP id
 x18-20020a5b0f12000000b00da1513d8a3cmr161843ybr.11.1699583351272; Thu, 09 Nov
 2023 18:29:11 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:28:52 -0800
In-Reply-To: <20231110022857.1273836-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110022857.1273836-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110022857.1273836-6-seanjc@google.com>
Subject: [PATCH 05/10] KVM: x86/pmu: Add macros to iterate over all PMCs given
 a bitmap
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and use kvm_for_each_pmc() to dedup a variety of open coded for-loops
that iterate over valid PMCs given a bitmap (and because seeing checkpatch
whine about bad macro style is always amusing).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c           | 26 +++++++-------------------
 arch/x86/kvm/pmu.h           |  6 ++++++
 arch/x86/kvm/vmx/pmu_intel.c |  7 ++-----
 3 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index ee921b24d9e4..0e2175170038 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -493,6 +493,7 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 {
 	DECLARE_BITMAP(bitmap, X86_PMC_IDX_MAX);
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct kvm_pmc *pmc;
 	int bit;
 
 	bitmap_copy(bitmap, pmu->reprogram_pmi, X86_PMC_IDX_MAX);
@@ -505,12 +506,7 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 	BUILD_BUG_ON(sizeof(bitmap) != sizeof(atomic64_t));
 	atomic64_andnot(*(s64 *)bitmap, &pmu->__reprogram_pmi);
 
-	for_each_set_bit(bit, bitmap, X86_PMC_IDX_MAX) {
-		struct kvm_pmc *pmc = kvm_pmc_idx_to_pmc(pmu, bit);
-
-		if (unlikely(!pmc))
-			continue;
-
+	kvm_for_each_pmc(pmu, pmc, bit, bitmap) {
 		/*
 		 * If reprogramming fails, e.g. due to contention, re-set the
 		 * regprogram bit set, i.e. opportunistically try again on the
@@ -720,11 +716,7 @@ static void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 
 	bitmap_zero(pmu->reprogram_pmi, X86_PMC_IDX_MAX);
 
-	for_each_set_bit(i, pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX) {
-		pmc = kvm_pmc_idx_to_pmc(pmu, i);
-		if (!pmc)
-			continue;
-
+	kvm_for_each_pmc(pmu, pmc, i, pmu->all_valid_pmc_idx) {
 		pmc_stop_counter(pmc);
 		pmc->counter = 0;
 		pmc->emulated_counter = 0;
@@ -796,10 +788,8 @@ void kvm_pmu_cleanup(struct kvm_vcpu *vcpu)
 	bitmap_andnot(bitmask, pmu->all_valid_pmc_idx,
 		      pmu->pmc_in_use, X86_PMC_IDX_MAX);
 
-	for_each_set_bit(i, bitmask, X86_PMC_IDX_MAX) {
-		pmc = kvm_pmc_idx_to_pmc(pmu, i);
-
-		if (pmc && pmc->perf_event && !pmc_speculative_in_use(pmc))
+	kvm_for_each_pmc(pmu, pmc, i, bitmask) {
+		if (pmc->perf_event && !pmc_speculative_in_use(pmc))
 			pmc_stop_counter(pmc);
 	}
 
@@ -851,10 +841,8 @@ void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 perf_hw_id)
 	struct kvm_pmc *pmc;
 	int i;
 
-	for_each_set_bit(i, pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX) {
-		pmc = kvm_pmc_idx_to_pmc(pmu, i);
-
-		if (!pmc || !pmc_event_is_allowed(pmc))
+	kvm_for_each_pmc(pmu, pmc, i, pmu->all_valid_pmc_idx) {
+		if (!pmc_event_is_allowed(pmc))
 			continue;
 
 		/* Ignore checks for edge detect, pin control, invert and CMASK bits */
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 2235772a495b..cb62a4e44849 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -83,6 +83,12 @@ static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
 	return NULL;
 }
 
+#define kvm_for_each_pmc(pmu, pmc, i, bitmap)			\
+	for_each_set_bit(i, bitmap, X86_PMC_IDX_MAX)		\
+		if (!(pmc = kvm_pmc_idx_to_pmc(pmu, i)))	\
+			continue;				\
+		else						\
+
 static inline u64 pmc_bitmask(struct kvm_pmc *pmc)
 {
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 4254411be467..ee3e122d3617 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -696,11 +696,8 @@ void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu)
 	struct kvm_pmc *pmc = NULL;
 	int bit, hw_idx;
 
-	for_each_set_bit(bit, (unsigned long *)&pmu->global_ctrl,
-			 X86_PMC_IDX_MAX) {
-		pmc = kvm_pmc_idx_to_pmc(pmu, bit);
-
-		if (!pmc || !pmc_speculative_in_use(pmc) ||
+	kvm_for_each_pmc(pmu, pmc, bit, (unsigned long *)&pmu->global_ctrl) {
+		if (!pmc_speculative_in_use(pmc) ||
 		    !pmc_is_globally_enabled(pmc) || !pmc->perf_event)
 			continue;
 
-- 
2.42.0.869.gea05f2083d-goog

