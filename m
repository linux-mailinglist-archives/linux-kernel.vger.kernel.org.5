Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914747E774A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345928AbjKJCPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345817AbjKJCO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:14:56 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF99E46A3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:14:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da03390793fso1867984276.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699582443; x=1700187243; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HhKpd1SrztABGm/U/aQBO8MgOdSjtPm1/FH+XbVpKsc=;
        b=m4jnRaPOMa1ghC1NR+EN38TtemHSytDQX+0OzCHCThb+07voZlaL/nZ7za+Bd1r/o4
         HTDQAIwyrWA119M8RRfkacyCgiChaAPlQvm4D/NCU7ETDv3zjsO8Cqyhb2Tb7D+fLQ8m
         v3l7ASGhlRagf7Xr3CFNsgs3T0A/bkqf+/oOTu9GHvdUvBga3ldZMzH63ZBHXsJ7NGRs
         UXtuBPs8QdbteWHMR61ri8fsL6+eQ9r+0v+ndesv5+1nfavXQkVYcCt9GMKloYz/mgOq
         UdTWpqyDSEcH6a67BqGOxVctB9vBUc46IIu3FAmmapy7nvWrfeGV2oNtfgCFieSPVKVd
         LeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582443; x=1700187243;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhKpd1SrztABGm/U/aQBO8MgOdSjtPm1/FH+XbVpKsc=;
        b=MGWrJu9HnbjZiFLdcA4k/aaLPdps1ByRjCOGIAQawMGNVU2hzRgdXk7l6Aq68v3jFJ
         991MYMXG8BFu6vyQ0vifq1JUCH99e+0theDPKceUmYDJQ6daPfQrLnOIalCX6m/pKd6G
         ypZpWSGAFvewu5ixAiiMPVONk1POTCmlo1yVATcjJ6jdeCLSYv0tvHVtmq/vMS4VRDco
         +6E5b5bEkE9ePsUHRledCoxOo2xCAzKCYAVcACx0xVHAS2AhlaHcWNYqaSwd+Z9wVyGG
         M56hWPB836fXHuoU37vYpFPWbwvU6vF8i6iCVDD3zDpMgUDvaGhGP4sKcAO0blwISfVD
         gf7g==
X-Gm-Message-State: AOJu0YweMf/M0OvM6Xvq/LHQi3QLfleMPLr0b2woDy2LBEwpP+CWNWRb
        1jXT+iEMMP80/6hCSI2IdFZ8TlUXhaI=
X-Google-Smtp-Source: AGHT+IFpa5+5TQ+Re0pGStxstHQjvzE+KLpTjR1CFF+Bg+wuHzmd7p/Tahi8Gt+fyKyBmhf01tN65xhF9P0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1366:b0:dae:49a3:ae23 with SMTP id
 bt6-20020a056902136600b00dae49a3ae23mr179118ybb.7.1699582443106; Thu, 09 Nov
 2023 18:14:03 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:13:06 -0800
In-Reply-To: <20231110021306.1269082-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110021306.1269082-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110021306.1269082-27-seanjc@google.com>
Subject: [PATCH v8 26/26] KVM: selftests: Extend PMU counters test to validate
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the read/write PMU counters subtest to verify that RDPMC also reads
back the written value.  Opportunsitically verify that attempting to use
the "fast" mode of RDPMC fails, as the "fast" flag is only supported by
non-architectural PMUs, which KVM doesn't virtualize.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index cb808ac827ba..248ebe8c0577 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -328,6 +328,7 @@ __GUEST_ASSERT(expect_gp ? vector == GP_VECTOR : !vector,			\
 static void guest_rd_wr_counters(uint32_t base_msr, uint8_t nr_possible_counters,
 				 uint8_t nr_counters, uint32_t or_mask)
 {
+	const bool pmu_has_fast_mode = !guest_get_pmu_version();
 	uint8_t i;
 
 	for (i = 0; i < nr_possible_counters; i++) {
@@ -352,6 +353,7 @@ static void guest_rd_wr_counters(uint32_t base_msr, uint8_t nr_possible_counters
 		const uint64_t expected_val = expect_success ? test_val : 0;
 		const bool expect_gp = !expect_success && msr != MSR_P6_PERFCTR0 &&
 				       msr != MSR_P6_PERFCTR1;
+		uint32_t rdpmc_idx;
 		uint8_t vector;
 		uint64_t val;
 
@@ -365,6 +367,35 @@ static void guest_rd_wr_counters(uint32_t base_msr, uint8_t nr_possible_counters
 		if (!expect_gp)
 			GUEST_ASSERT_PMC_VALUE(RDMSR, msr, val, expected_val);
 
+		rdpmc_idx = i;
+		if (base_msr == MSR_CORE_PERF_FIXED_CTR0)
+			rdpmc_idx |= INTEL_RDPMC_FIXED;
+
+		/* Redo the read tests with RDPMC, and with forced emulation. */
+		vector = rdpmc_safe(rdpmc_idx, &val);
+		GUEST_ASSERT_PMC_MSR_ACCESS(RDPMC, rdpmc_idx, !expect_success, vector);
+		if (expect_success)
+			GUEST_ASSERT_PMC_VALUE(RDPMC, rdpmc_idx, val, expected_val);
+
+		vector = rdpmc_safe_fep(rdpmc_idx, &val);
+		GUEST_ASSERT_PMC_MSR_ACCESS(RDPMC, rdpmc_idx, !expect_success, vector);
+		if (expect_success)
+			GUEST_ASSERT_PMC_VALUE(RDPMC, rdpmc_idx, val, expected_val);
+
+		/*
+		 * KVM doesn't support non-architectural PMUs, i.e. it should
+		 * impossible to have fast mode RDPMC.  Verify that attempting
+		 * to use fast RDPMC always #GPs.
+		 */
+		GUEST_ASSERT(!expect_success || !pmu_has_fast_mode);
+		rdpmc_idx |= INTEL_RDPMC_FAST;
+
+		vector = rdpmc_safe(rdpmc_idx, &val);
+		GUEST_ASSERT_PMC_MSR_ACCESS(RDPMC, rdpmc_idx, true, vector);
+
+		vector = rdpmc_safe_fep(rdpmc_idx, &val);
+		GUEST_ASSERT_PMC_MSR_ACCESS(RDPMC, rdpmc_idx, true, vector);
+
 		vector = wrmsr_safe(msr, 0);
 		GUEST_ASSERT_PMC_MSR_ACCESS(WRMSR, msr, expect_gp, vector);
 	}
-- 
2.42.0.869.gea05f2083d-goog

