Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299B47F2C36
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbjKUL4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjKULzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:55:54 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1B5123;
        Tue, 21 Nov 2023 03:55:51 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1cf62a3b249so13031055ad.0;
        Tue, 21 Nov 2023 03:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700567751; x=1701172551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FModTmbvq/rIeTJqrbp/ejTbdstDXjo4HWlV+9PgZ9k=;
        b=dBczypLPi+Zope3SmHlN4gkvy2+cQWTwMjwijI8vsKWrDHybX3QB5Y0lWS1zzKUtkB
         d3mlnXUFhEAm9Hf8BvBo7Ynh42LNJhNId2xqFzrTdV6QdUh2ahn3DvSXZzO7/YzDWdhE
         O37YGAo8rvMEvhgsaMtpGlQRxyWzT/gYBAyQmUwtWjA/hJZ2aELMfQm7sxRZIexh5Tlt
         /pEqcFtUncb1PDSa1ewymlDhStMhQ3cGm6a3hdhfeuq1g77gM0VItD+2Fc3bA/Y97Ix+
         Yrauqjv/pUn+FABYV0BwV1Fc8YRXm1A9ZuP2P+c09flaNtFKEtpm0nBkoz2PsJO9STRf
         zOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700567751; x=1701172551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FModTmbvq/rIeTJqrbp/ejTbdstDXjo4HWlV+9PgZ9k=;
        b=Av5eec2cC4m4rt2Zb3OpXmckclYSbn8/zsLgaEs+TUlPekOxQD5irIzjMke8dpdfYC
         K0TFtYbsxGOSZ1LadDulWOLrH4bFJj/WjSYPcQlTfo6B46zGrZ6AROTc+Ihdesa8WGNn
         kXmITmJUpuqDai4JuOhmzBXQAh9leDgXY10Kxp0vQO8NFeZDz+7wAniskbSb5UImRq+E
         3sUAQG+HdrwkPpCTIbCSN4xh1NO7ifr1x6P95oDrEddZnyDxy6hZcka4h6NbR13Mcent
         fZ+aTgxW/yHnDEbIbdELFn0rCmRISgtG30HdiAY5SPbMUyvUjfouy5HSWSeutB+y0GNH
         S49A==
X-Gm-Message-State: AOJu0Yy3yoTCFt7Mhh8tGouL7AsPnWW9n1Wi6ekt7SEl4VuRWC9979Wg
        nbFMXq+mH5YNa55I0IePN4Vkh0el+VGmCfZHyc0=
X-Google-Smtp-Source: AGHT+IENILlMREfBj1e1iMvLSwt8Z6C4mae28rX8qBuCPqtn4P/zKbl8L9tnlLR5FwQ5k+MmEw/Ohw==
X-Received: by 2002:a17:902:e5cd:b0:1cf:51c5:d427 with SMTP id u13-20020a170902e5cd00b001cf51c5d427mr9118844plf.65.1700567750712;
        Tue, 21 Nov 2023 03:55:50 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902740a00b001cc1dff5b86sm7685431pll.244.2023.11.21.03.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 03:55:50 -0800 (PST)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <cloudliang@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Like Xu <likexu@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Jinrong Liang <ljr.kernel@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] KVM: selftests: Test consistency of PMU MSRs with AMD PMU version
Date:   Tue, 21 Nov 2023 19:54:55 +0800
Message-Id: <20231121115457.76269-8-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121115457.76269-1-cloudliang@tencent.com>
References: <20231121115457.76269-1-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinrong Liang <cloudliang@tencent.com>

Add AMD test case to check that KVM accurately accesses the MSRs
supported by the AMD PMU version.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index b1502a446a55..07cb9694e225 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -819,6 +819,50 @@ static void test_amd_counters_num(void)
 	}
 }
 
+static void guest_test_amd_pmu_version(void)
+{
+	bool expect_gp = !this_cpu_has(X86_FEATURE_PERFMON_V2);
+	uint8_t vector;
+	uint64_t val;
+
+	guest_wr_rd_amd_counters(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+				 expect_gp, 0);
+	guest_wr_rd_amd_counters(MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
+				 expect_gp, 0);
+
+	/*
+	 * Attempt to write to MSR_AMD64_PERF_CNTR_GLOBAL_STATUS register, which
+	 * will trigger a #GP exception. Because MSR_AMD64_PERF_CNTR_GLOBAL_STATUS
+	 * is read-only.
+	 */
+	vector = wrmsr_safe(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, 0);
+	GUEST_ASSERT_PMC_MSR_ACCESS(WRMSR, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
+				    true, vector);
+
+	vector = rdmsr_safe(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, &val);
+	GUEST_ASSERT_PMC_MSR_ACCESS(RDMSR, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
+				    expect_gp, vector);
+
+	GUEST_DONE();
+}
+
+static void test_amd_pmu_version(void)
+{
+	bool kvm_pmu_is_perfmonv2 = kvm_cpu_has(X86_FEATURE_PERFMON_V2);
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	unsigned int i;
+
+	for (i = 0; i <= kvm_pmu_is_perfmonv2; i++) {
+		vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_amd_pmu_version);
+
+		vcpu_set_or_clear_cpuid_feature(vcpu, X86_FEATURE_PERFMON_V2, i);
+
+		run_vcpu(vcpu);
+		kvm_vm_free(vm);
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_is_pmu_enabled());
@@ -836,6 +880,7 @@ int main(int argc, char *argv[])
 	} else if (host_cpu_is_amd) {
 		test_amd_zen_events();
 		test_amd_counters_num();
+		test_amd_pmu_version();
 	} else {
 		TEST_FAIL("Unknown CPU vendor");
 	}
-- 
2.39.3

