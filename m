Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F0E80189C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442173AbjLBAGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442128AbjLBAFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:05:41 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC891BCD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:05:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db539c987e0so1538753276.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 16:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701475515; x=1702080315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xw+c5GCsB2b8QDdbiEI/AG23aqiIRhU7uRpXc8eyon4=;
        b=WkRoMeuko5UfiH3J/18cIfBk1gCbDo1soCgiSVD2hd56Qv4TnX8smp4Ygii8l5KeAI
         QGHhHNLZqoatieppkT8MzCt7nKGhv4evi9+Kt6QLyDJUw/s+hdSC+FqhnKa3QO4FKnJY
         bQxvCdX2yh3fBwDcJjyv4VQr7q5rez9QtWpLRR3wh7JjBL5NMRGbX3YXtT/3OFRPKXl7
         4vx7JSEz7vWGXpGshQQTbtJwpkQbshhLXFHV2Y3LB7mBrrmqb1M1E47nOKJ2GSblCRWN
         KHEhQDfIBHdZNZNiqfumbY//7oHTMSDVChc49nDJ8GaLJNRj6YsmQxDR1UhY73Oo9UGV
         LjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475515; x=1702080315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xw+c5GCsB2b8QDdbiEI/AG23aqiIRhU7uRpXc8eyon4=;
        b=GfVE5GxfWF5SHt7HvmNXH758yScE8Gt3w8IamAOHlb/z2b6mTI7hes8LPpYKAtUMFc
         HVy+3+8s23NJL1lrL0vX56XX3HLysWrXEc/xQI29TtsVbjTCdEti90XmifbNi8kZv/Wg
         eggTO0VnljABe61RImhy2TyY1QnlgYaFauB3APtEtN6TPAXwjpDHfTWrAjfwFs6Oy1qr
         +YWAgEFoCokJVnzbNYCBrZINcqC6PCydzagmj+fSBoJLm4w2b8srt+iVdAIH48HG1wMW
         EmoZsjfiauICnJYM9h/pixowCFvth4LCwGxm2dc2ZR0WeQfXbA4EO7yhuhCnWQxmRy9r
         8Jew==
X-Gm-Message-State: AOJu0YysGVl8aBoWjPaVwwEX0coAFKzq7bc3D4hf+qgstDXMMOL27Tmu
        m/e7kWh65COTy9ZUlcfR/ToKSqTASNo=
X-Google-Smtp-Source: AGHT+IGhkJP5g/XYfw/UjHT//gHh8kp5x/HRzqm+5MPT1PYzribzU2fOgOj6KCB2Mi95jvctFRT8RUus6/0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:3f87:0:b0:d9a:36cd:482e with SMTP id
 m129-20020a253f87000000b00d9a36cd482emr838388yba.13.1701475515032; Fri, 01
 Dec 2023 16:05:15 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  1 Dec 2023 16:04:17 -0800
In-Reply-To: <20231202000417.922113-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231202000417.922113-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202000417.922113-29-seanjc@google.com>
Subject: [PATCH v9 28/28] KVM: selftests: Extend PMU counters test to validate
 RDPMC after WRMSR
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

Extend the read/write PMU counters subtest to verify that RDPMC also reads
back the written value.  Opportunsitically verify that attempting to use
the "fast" mode of RDPMC fails, as the "fast" flag is only supported by
non-architectural PMUs, which KVM doesn't virtualize.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index cb808ac827ba..ae5f6042f1e8 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -325,9 +325,30 @@ __GUEST_ASSERT(expect_gp ? vector == GP_VECTOR : !vector,			\
 		       "Expected " #insn "(0x%x) to yield 0x%lx, got 0x%lx",	\
 		       msr, expected_val, val);
 
+static void guest_test_rdpmc(uint32_t rdpmc_idx, bool expect_success,
+			     uint64_t expected_val)
+{
+	uint8_t vector;
+	uint64_t val;
+
+	vector = rdpmc_safe(rdpmc_idx, &val);
+	GUEST_ASSERT_PMC_MSR_ACCESS(RDPMC, rdpmc_idx, !expect_success, vector);
+	if (expect_success)
+		GUEST_ASSERT_PMC_VALUE(RDPMC, rdpmc_idx, val, expected_val);
+
+	if (!is_forced_emulation_enabled)
+		return;
+
+	vector = rdpmc_safe_fep(rdpmc_idx, &val);
+	GUEST_ASSERT_PMC_MSR_ACCESS(RDPMC, rdpmc_idx, !expect_success, vector);
+	if (expect_success)
+		GUEST_ASSERT_PMC_VALUE(RDPMC, rdpmc_idx, val, expected_val);
+}
+
 static void guest_rd_wr_counters(uint32_t base_msr, uint8_t nr_possible_counters,
 				 uint8_t nr_counters, uint32_t or_mask)
 {
+	const bool pmu_has_fast_mode = !guest_get_pmu_version();
 	uint8_t i;
 
 	for (i = 0; i < nr_possible_counters; i++) {
@@ -352,6 +373,7 @@ static void guest_rd_wr_counters(uint32_t base_msr, uint8_t nr_possible_counters
 		const uint64_t expected_val = expect_success ? test_val : 0;
 		const bool expect_gp = !expect_success && msr != MSR_P6_PERFCTR0 &&
 				       msr != MSR_P6_PERFCTR1;
+		uint32_t rdpmc_idx;
 		uint8_t vector;
 		uint64_t val;
 
@@ -365,6 +387,25 @@ static void guest_rd_wr_counters(uint32_t base_msr, uint8_t nr_possible_counters
 		if (!expect_gp)
 			GUEST_ASSERT_PMC_VALUE(RDMSR, msr, val, expected_val);
 
+		/*
+		 * Redo the read tests with RDPMC, which has different indexing
+		 * semantics and additional capabilities.
+		 */
+		rdpmc_idx = i;
+		if (base_msr == MSR_CORE_PERF_FIXED_CTR0)
+			rdpmc_idx |= INTEL_RDPMC_FIXED;
+
+		guest_test_rdpmc(rdpmc_idx, expect_success, expected_val);
+
+		/*
+		 * KVM doesn't support non-architectural PMUs, i.e. it should
+		 * impossible to have fast mode RDPMC.  Verify that attempting
+		 * to use fast RDPMC always #GPs.
+		 */
+		GUEST_ASSERT(!expect_success || !pmu_has_fast_mode);
+		rdpmc_idx |= INTEL_RDPMC_FAST;
+		guest_test_rdpmc(rdpmc_idx, false, -1ull);
+
 		vector = wrmsr_safe(msr, 0);
 		GUEST_ASSERT_PMC_MSR_ACCESS(WRMSR, msr, expect_gp, vector);
 	}
-- 
2.43.0.rc2.451.g8631bc7472-goog

