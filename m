Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EE97E7734
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345802AbjKJCOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbjKJCOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:14:19 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCC04C38
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:13:46 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-28047dbd6dcso1733529a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699582426; x=1700187226; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JH9+qpUXl836Ph+awMmTwSGh8Ty89oPMRk1LH3tw8s4=;
        b=U5mwE0HKUK4wWia7KWOs+sRqcQy6ImyUbbQIakpNYTH45YOdXze0K14XrNHwr8RRG5
         bCtVZZUHlMsKtxlsb3Y9SmNPH0knDNFbD1BFyfelTG72vn64mq2C6jOrTwvhJObP/H2a
         hlUQmYDmq22eigaxFP6otUMQMZoEv10coOxLsd3z6Q+D8O0bDO2YRNAxlL5P0g3q3VVP
         kGhCvJq3OhBJLuJqNL7MIyvz/EsYKvhEXxqXsl3Rwg5va5uwF82RgSg9jO7FufumDBsF
         7cT9i1zfW7Rm2OL3xjqOt73tnLhqlOuo7L4qE7yQfGHTrQaaIhpEauybF5RNi736GdwL
         lPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582426; x=1700187226;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JH9+qpUXl836Ph+awMmTwSGh8Ty89oPMRk1LH3tw8s4=;
        b=EwSYgwUCeU3agafxNpUMzKDwGMDYCF9Aso7M6zVfIE3W3YGFidPCbO36VazTq8gBlO
         ACi5YoFDfzwlrL6FwjSmykTvFqilc52iYlzRVvcr53GvJYb4G7UKBk+lZ8RCbTzZS93q
         FJxVxCcr5IZzknStzpVdFgYcOK2UBM77dnTSe8PEEzjU2c/zot8848gDXzjwU8TYnotj
         EYQQPjq2bg1mfP98T2f1ljvp+1483ePkxrJiZ/2sdNI0K3lRJyBhi/094fPiwh2gty7h
         jQOndLbIfI68AII8hmWdVGGQqDDaLV9PTqXUHVMyGy38Huxwvv6kHuFCT8v5w8Mg1jFa
         QCfg==
X-Gm-Message-State: AOJu0YyFGNQ5Dt+iftsE9FGrghyOhhfXjNCaV5RjX3sAptlJRd8Ws64w
        qTGxWx5J0QQeJJzchXK7DVGxpbvvF/w=
X-Google-Smtp-Source: AGHT+IECumHEwC4qoDbNH2oeAFTGH5z87NEBzmBmdcyxjebJn7y2REJEvm4jaesyDQVOJ2kmOtwLlmpcpqw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:69a4:b0:27c:ff2d:418 with SMTP id
 s33-20020a17090a69a400b0027cff2d0418mr827687pjj.6.1699582425767; Thu, 09 Nov
 2023 18:13:45 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:12:57 -0800
In-Reply-To: <20231110021306.1269082-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110021306.1269082-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110021306.1269082-18-seanjc@google.com>
Subject: [PATCH v8 17/26] KVM: selftests: Add functional test for Intel's
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
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index b07294af71a3..f5dedd112471 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -332,7 +332,6 @@ static void guest_rd_wr_counters(uint32_t base_msr, uint8_t nr_possible_counters
 		vector = wrmsr_safe(msr, 0);
 		GUEST_ASSERT_PMC_MSR_ACCESS(WRMSR, msr, expect_gp, vector);
 	}
-	GUEST_DONE();
 }
 
 static void guest_test_gp_counters(void)
@@ -350,6 +349,7 @@ static void guest_test_gp_counters(void)
 		base_msr = MSR_IA32_PERFCTR0;
 
 	guest_rd_wr_counters(base_msr, MAX_NR_GP_COUNTERS, nr_gp_counters, 0);
+	GUEST_DONE();
 }
 
 static void test_gp_counters(uint8_t pmu_version, uint64_t perf_capabilities,
@@ -373,6 +373,7 @@ static void guest_test_fixed_counters(void)
 {
 	uint64_t supported_bitmask = 0;
 	uint8_t nr_fixed_counters = 0;
+	uint8_t i;
 
 	/* Fixed counters require Architectural vPMU Version 2+. */
 	if (guest_get_pmu_version() >= 2)
@@ -387,6 +388,34 @@ static void guest_test_fixed_counters(void)
 
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

