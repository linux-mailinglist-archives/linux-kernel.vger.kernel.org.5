Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE25801877
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbjLBAEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441958AbjLBAEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:04:38 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A4F198A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:04:36 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5c65e666609so144020a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 16:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701475475; x=1702080275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2po9gsIH1GemJjlQR8N+Qz1uhCKXgd6uWVlwty8FltY=;
        b=jHuHvQp+gWhwZYQ8isI68jbM5oQ44a9uJANdH31c0P7WRqGZ6/e90RA2u8g+j5LOar
         zRPXN5kmT6lr1SUDXPMCauZRzTx9iTMO3ApYaZTO3f/I/IDgctXiIkWuY/NXL6IwZUIO
         MWWUZb/Q+lLA82ZRlDVpIME+/e0vRy2laxe4aSnTly+RuqFldJPQyK6ZR8SNEa0G8Ylx
         M8na7vkamr24rH1+5jN+LWjrqpm0wVkWsTYZNd9himM0qy9I+DkaPb4TsBR6pFL6fKO2
         PJCEMZ6vKkno0L5khY0dsuA/I9BeXNm8sHNWd/n5jndmIh7QNS8+2T9FGHc3Bza6U6rC
         etDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475475; x=1702080275;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2po9gsIH1GemJjlQR8N+Qz1uhCKXgd6uWVlwty8FltY=;
        b=RgMGldVljqs7z8dqJrLXjqSc/panXzjna+VASWm2V2V5S7sPDY3zRcypqDaN5tIUFA
         1JmurUR/zUh+fR2ENmazAY4DdYKWiOCsZGFTAKufNED6l4Pcu4YN1A5rmiogbysj6HI8
         0SMbt78g6el2dTm9hMxPRQho+p/Y5v7Md8w7HzE8FxDTib/0qWaEbbEBDYncDwoa4/p+
         /+hrADr/WqeKQXw9X8/SLQ00Wzx/37Zi/gkaiWWMTVFqja7GUNAAIxU9U2B3UQBUX61i
         8jI3WO7f2RTwsafBfaZx6Wp5Xm2IzCc3ZktUw7xnq2CsUCuHYXvGQYx3PsZ9ngMJKn9D
         sbgA==
X-Gm-Message-State: AOJu0Yzs2bfJ1iGOBzCmUbDFrkmm9f8c+Qxb5GPlZoKVXLX64Ou32klN
        06/XbQBVRZNTVQ+oUuohNv/aCQ4hDww=
X-Google-Smtp-Source: AGHT+IFz7rAL9yNshqMdfqp2kpz3vwVzN2kIVTRWjAwUtwSyjgM640giCvKwhtyYJxazztzI53oSh9QBKrs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:1402:0:b0:5bd:bcde:c677 with SMTP id
 u2-20020a631402000000b005bdbcdec677mr4147254pgl.2.1701475475730; Fri, 01 Dec
 2023 16:04:35 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  1 Dec 2023 16:03:57 -0800
In-Reply-To: <20231202000417.922113-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231202000417.922113-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202000417.922113-9-seanjc@google.com>
Subject: [PATCH v9 08/28] KVM: x86/pmu: Apply "fast" RDPMC only to Intel PMUs
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
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

Move the handling of "fast" RDPMC instructions, which drop bits 63:32 of
the count, to Intel.  The "fast" flag, and all flags for that matter, are
Intel-only and aren't supported by AMD.

Opportunistically replace open coded bit crud with proper #defines.

Fixes: ca724305a2b0 ("KVM: x86/vPMU: Implement AMD vPMU code for KVM")
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c           |  3 +--
 arch/x86/kvm/vmx/pmu_intel.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 0b0d804ee239..09b0feb975c3 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -576,10 +576,9 @@ static int kvm_pmu_rdpmc_vmware(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 {
-	bool fast_mode = idx & (1u << 31);
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
-	u64 mask = fast_mode ? ~0u : ~0ull;
+	u64 mask = ~0ull;
 
 	if (!pmu->version)
 		return 1;
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 1b1f888ad32b..6903dd9b71ad 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -20,6 +20,10 @@
 #include "nested.h"
 #include "pmu.h"
 
+/* Perf's "BASE" is wildly misleading, this is a single-bit flag, not a base. */
+#define INTEL_RDPMC_FIXED	INTEL_PMC_FIXED_RDPMC_BASE
+#define INTEL_RDPMC_FAST	BIT(31)
+
 #define MSR_PMC_FULL_WIDTH_BIT      (MSR_IA32_PMC0 - MSR_IA32_PERFCTR0)
 
 static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
@@ -59,11 +63,14 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 					    unsigned int idx, u64 *mask)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
-	bool fixed = idx & (1u << 30);
+	bool fixed = idx & INTEL_RDPMC_FIXED;
 	struct kvm_pmc *counters;
 	unsigned int num_counters;
 
-	idx &= ~(3u << 30);
+	if (idx & INTEL_RDPMC_FAST)
+		*mask &= GENMASK_ULL(31, 0);
+
+	idx &= ~(INTEL_RDPMC_FIXED | INTEL_RDPMC_FAST);
 	if (fixed) {
 		counters = pmu->fixed_counters;
 		num_counters = pmu->nr_arch_fixed_counters;
-- 
2.43.0.rc2.451.g8631bc7472-goog

