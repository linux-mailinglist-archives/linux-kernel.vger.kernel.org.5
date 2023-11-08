Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608697E4E1B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344090AbjKHAcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbjKHAcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:32:20 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766EC1BE1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:32:06 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5afe220cadeso84220167b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699403525; x=1700008325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=DXez8jM/aEISjIp4D8bbMEqvy5rF4I4jxOIMNNd6V3A=;
        b=lyBjIQ5XMT/AeIUzefVzZ1MIElN6D646JHLWWEg7/U9TLU8njDxdsd/aDaz4ThaHOw
         BoiGpYhJEonoropoT9flAcokZOxqZ1GJUMkiGpvl1L5EXd/MkcoVQ8EhPkcdpo8CsG/G
         YEth6QNRSPOkNxzKr3EiXCJdgG22Uo131WZnRfIm1JiU/Ehux4mfo9elF0Vq13wfOF4/
         Eth5CJKlGYYT54qVHX/zm0zMmnpBxFFPdnwXQ048hSAE+jqf/I/uzG/CTiKTjeLHA2cD
         /8uYTzXS8LEyUr7nxZToI5QSejnwMo1YWPwM3171Dqnd/kIOKmK98jwJKb1ioJ2axNQQ
         WxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699403525; x=1700008325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXez8jM/aEISjIp4D8bbMEqvy5rF4I4jxOIMNNd6V3A=;
        b=s0ZVv418LD2EbUjpVeA/T5DjDYc8ucel2P7CBaQtVMDqMjKELkf6v2U/gQ9SSQ7VXU
         aQs38poVaJkY662i9gf+vgVBEZHYW6716TYRYesFcwW6fy0/SwVy4sAZrjT9/T5vMH19
         LyIsySevfNBUpZrAAE200eDx5h+nPhdQozSRP/2PtKZ3v4vmGqqo4sstPtT5OJ7jcgO2
         eAyRK/LG7SmNejzqpFEOfSGwW21GUb/KdvDVXYWXP5ctsavPfaXSag2SyViDuCI/eIax
         GIzQrsTDXHJwe1HxqQaGPLjYXsDMKOkx05TubnqSn4GfZwvsGk7PUzhIAlV2rZplo8hs
         OMSw==
X-Gm-Message-State: AOJu0YxnJGMugY5VTEq1ZNAoGQo4CqAl3jO22GlVO5ECTchnoScG7PX7
        48hlw0jainPic8H4RcYFnVoq8T2Dmec=
X-Google-Smtp-Source: AGHT+IHnm6a/RltPae9psNtK7VYkH94gMkTxVlCQBbqFkKkCymjuiyMSgSRzdqZJ+WHaKUQQgcQqeYrG4ts=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d80e:0:b0:5a7:b9ea:5c9d with SMTP id
 a14-20020a0dd80e000000b005a7b9ea5c9dmr4203ywe.8.1699403525714; Tue, 07 Nov
 2023 16:32:05 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Nov 2023 16:31:29 -0800
In-Reply-To: <20231108003135.546002-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231108003135.546002-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108003135.546002-14-seanjc@google.com>
Subject: [PATCH v7 13/19] KVM: selftests: Add functional test for Intel's
 fixed PMU counters
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinrong Liang <cloudliang@tencent.com>

Extend the fixed counters test to verify that supported counters can
actually be enabled in the control MSRs, that unsupported counters cannot,
and that enabled counters actually count.

Co-developed-by: Like Xu <likexu@tencent.com>
Signed-off-by: Like Xu <likexu@tencent.com>
Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
[sean: fold into the rd/wr access test, massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index 8c934e261f2d..b9c073d3ade9 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -324,7 +324,6 @@ static void guest_rd_wr_counters(uint32_t base_msr, uint8_t nr_possible_counters
 		vector = wrmsr_safe(msr, 0);
 		GUEST_ASSERT_PMC_MSR_ACCESS(WRMSR, msr, expect_gp, vector);
 	}
-	GUEST_DONE();
 }
 
 static void guest_test_gp_counters(void)
@@ -342,6 +341,7 @@ static void guest_test_gp_counters(void)
 		base_msr = MSR_IA32_PERFCTR0;
 
 	guest_rd_wr_counters(base_msr, MAX_NR_GP_COUNTERS, nr_gp_counters, 0);
+	GUEST_DONE();
 }
 
 static void test_gp_counters(uint8_t pmu_version, uint64_t perf_capabilities,
@@ -365,6 +365,7 @@ static void guest_test_fixed_counters(void)
 {
 	uint64_t supported_bitmask = 0;
 	uint8_t nr_fixed_counters = 0;
+	uint8_t i;
 
 	/* Fixed counters require Architectural vPMU Version 2+. */
 	if (guest_get_pmu_version() >= 2)
@@ -379,6 +380,34 @@ static void guest_test_fixed_counters(void)
 
 	guest_rd_wr_counters(MSR_CORE_PERF_FIXED_CTR0, MAX_NR_FIXED_COUNTERS,
 			     nr_fixed_counters, supported_bitmask);
+
+	for (i = 0; i < MAX_NR_FIXED_COUNTERS; i++) {
+		uint8_t vector;
+		uint64_t val;
+
+		if (i >= nr_fixed_counters && !(supported_bitmask & BIT_ULL(i))) {
+			vector = wrmsr_safe(MSR_CORE_PERF_FIXED_CTR_CTRL,
+					    FIXED_PMC_CTRL(i, FIXED_PMC_KERNEL));
+			__GUEST_ASSERT(vector == GP_VECTOR,
+				       "Expected #GP for counter %u in FIXED_CTR_CTRL", i);
+
+			vector = wrmsr_safe(MSR_CORE_PERF_GLOBAL_CTRL,
+					    FIXED_PMC_GLOBAL_CTRL_ENABLE(i));
+			__GUEST_ASSERT(vector == GP_VECTOR,
+				       "Expected #GP for counter %u in PERF_GLOBAL_CTRL", i);
+			continue;
+		}
+
+		wrmsr(MSR_CORE_PERF_FIXED_CTR0 + i, 0);
+		wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, FIXED_PMC_CTRL(i, FIXED_PMC_KERNEL));
+		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, FIXED_PMC_GLOBAL_CTRL_ENABLE(i));
+		__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
+		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
+		val = rdmsr(MSR_CORE_PERF_FIXED_CTR0 + i);
+
+		GUEST_ASSERT_NE(val, 0);
+	}
+	GUEST_DONE();
 }
 
 static void test_fixed_counters(uint8_t pmu_version, uint64_t perf_capabilities,
-- 
2.42.0.869.gea05f2083d-goog

