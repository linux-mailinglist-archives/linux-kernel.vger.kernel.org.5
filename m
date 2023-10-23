Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C447D4355
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjJWXkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjJWXkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:40:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE9FCC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:40:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7af69a4baso52648357b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698104407; x=1698709207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Jf1tQhWhiUHsUcOyz6b9syOvbswpkBFGF9h9iOKMWy8=;
        b=P966TVZ/R0NaGEdVlwjG21WF+qcIHmwPICnTwvETRjc65V9UfTjzkBucCMZ/TAdpuv
         Mm6jK1vCno8DkckRhP0rPcjhbt4s5H3SY31sOW56OmfpvP45MzKyDi+k/VQNzmV60oKK
         aW8zjLBc/QWjeAv3I9n7yUGY0fhF6bcs5/UX6r/fgZxzJOgtvtHCJM2zJ8URnfJ0Zzfu
         AQMn3Noipq7tnQUrz7t1JwaXajWX1wkwF0wTSjmOUPt8efOj72siZ5DaS5HHZs3kq9I1
         N1AyWHiXr0BDfQI2rfzOdedItpkYlZU1I3bk4UxJJDu3FnT9pGNj0e942rwYFh79fPK2
         ZczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698104407; x=1698709207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jf1tQhWhiUHsUcOyz6b9syOvbswpkBFGF9h9iOKMWy8=;
        b=rjWXvSxiH+8YQPki0iVpr7X3n3hsOwIQzva/8fSbEpgcHN1TI8TIPmsovebot//iy7
         jEVjHa1+DfoY1wY5NWOUBkCghrVVWtgXB0hBDjdn5lyB7PnaAvUBbexviq/3HS5OS6uz
         c+OVF42DuNXe13FrfUS1dWMaZLSnpesm7kGDlM3ClEU8m0ukPuKrGLGQj1dEJSdt+mXi
         HidlCHvifLj8z2NgIXfcIwesg8EZ+ijkf6PjYZZn9iAIf7Rqcvo+mTTqzfDl/JQlreYG
         SDEnCTxksbe/Kf5lsviRSJ/gwOuDwkpsjULx+2btxE0T9e/XND25C/5mY4yzG8+Ytc0Q
         ZtYg==
X-Gm-Message-State: AOJu0YwC6JNpXkj4OVld6HCoabCQ0ONzh6gHCDQDCf3yr0BueYfbJfGq
        hC4R79y+HdO+hL9G7Ryg+IVtjvZfdKE=
X-Google-Smtp-Source: AGHT+IFB7gkT4ats34fYJblhK65PLyXH0GidTgEeYOQzGsiLxPvYUCVeyGmEAxdjKxNhFRyCGJwD95zbBOQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:e245:0:b0:576:af04:3495 with SMTP id
 l66-20020a0de245000000b00576af043495mr245928ywe.9.1698104407226; Mon, 23 Oct
 2023 16:40:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 23 Oct 2023 16:39:56 -0700
In-Reply-To: <20231023234000.2499267-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231023234000.2499267-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231023234000.2499267-3-seanjc@google.com>
Subject: [PATCH 2/6] KVM: x86/pmu: Reset the PMU, i.e. stop counters, before refreshing
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        Roman Kagan <rkagan@amazon.de>,
        Jim Mattson <jmattson@google.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Like Xu <like.xu.linux@gmail.com>
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

Stop all counters and release all perf events before refreshing the vPMU,
i.e. before reconfiguring the vPMU to respond to changes in the vCPU
model.

Clear need_cleanup in kvm_pmu_reset() as well so that KVM doesn't
prematurely stop counters, e.g. if KVM enters the guest and enables
counters before the vCPU is scheduled out.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 027e9c3c2b93..dc8e8e907cfb 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -657,25 +657,14 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 0;
 }
 
-/* refresh PMU settings. This function generally is called when underlying
- * settings are changed (such as changes of PMU CPUID by guest VMs), which
- * should rarely happen.
- */
-void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
-{
-	if (KVM_BUG_ON(kvm_vcpu_has_run(vcpu), vcpu->kvm))
-		return;
-
-	bitmap_zero(vcpu_to_pmu(vcpu)->all_valid_pmc_idx, X86_PMC_IDX_MAX);
-	static_call(kvm_x86_pmu_refresh)(vcpu);
-}
-
 void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
 	int i;
 
+	pmu->need_cleanup = false;
+
 	bitmap_zero(pmu->reprogram_pmi, X86_PMC_IDX_MAX);
 
 	for_each_set_bit(i, pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX) {
@@ -695,6 +684,26 @@ void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 	static_call_cond(kvm_x86_pmu_reset)(vcpu);
 }
 
+
+/*
+ * Refresh the PMU configuration for the vCPU, e.g. if userspace changes CPUID
+ * and/or PERF_CAPABILITIES.
+ */
+void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
+{
+	if (KVM_BUG_ON(kvm_vcpu_has_run(vcpu), vcpu->kvm))
+		return;
+
+	/*
+	 * Stop/release all existing counters/events before realizing the new
+	 * vPMU model.
+	 */
+	kvm_pmu_reset(vcpu);
+
+	bitmap_zero(vcpu_to_pmu(vcpu)->all_valid_pmc_idx, X86_PMC_IDX_MAX);
+	static_call(kvm_x86_pmu_refresh)(vcpu);
+}
+
 void kvm_pmu_init(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
-- 
2.42.0.758.gaed0368e0e-goog

