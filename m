Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A977F2D70
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjKUMmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjKULzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:55:44 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74B1112;
        Tue, 21 Nov 2023 03:55:40 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-6bee11456baso4596584b3a.1;
        Tue, 21 Nov 2023 03:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700567740; x=1701172540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maJ6auOp8L0b9qivkNZj20bUmfFTqIu0eFCNZfSuBj0=;
        b=JcyGLbpbjM9C1isQ2bo06+B8NEJd4AUr8du5v4ybN68pv7GpjUXNCbEqTCX9lhjzop
         BoEnfKZ6yzMMcmNEEN0QCjsf37kTGFAndfEqNE58OLej+sSJAEgEJBrrgoMsdLn8eLT3
         Qill8FncNrhOH5Pj3AtzBiS/WJyyKUEkU14CZvqU7w+EKPfTGdRYQtJOyp5gRiOkOV+C
         jB5qMJRpFH1qVffuAl9H0dJ8lTtoOfC+NQ5Z6d0nS5pD2+IH7UGkVm1IxaM1JdUdAtet
         M/Ff/ml0FoUxbxENuQBs0wKhZA/lJLYtn8tEAzunSsiSaNLiFdEFBj14YdqQKjPtsHHa
         TypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700567740; x=1701172540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maJ6auOp8L0b9qivkNZj20bUmfFTqIu0eFCNZfSuBj0=;
        b=phXB2g1Khu9+4xvxZ82WVRWLFzSQ4UtQPzgItWwnckjS3lqwGE4g4YbXBZDkeGidxX
         TRkzhwqj8b8RMH3/i6Go2s4Z/sjJ70Lo5UdXAnH9YqTPd92lstW3XHU/cu9sBeb1z7eZ
         HLc+MX9u8rTWYwb4niAryDi1pYo75M8dt6e3dhDEiBCBC1XmAZJBGnCHsqLOWf77MKcm
         05xUUETSzwkcH63WY7SG4zvjEGr5qrgXtY01xmj8oPUvyEY0h9qnPnYAnEWisWYWAKP4
         iWo+xP0k8EsPMqYaJbhd1zPHeWaufUpyUFOI9umH5g/EijDK5Ji8YRppetQts/dbkPE1
         CI9A==
X-Gm-Message-State: AOJu0YxM/DqQPnhV6tq7+H7WOougxLydziyfIA3hQevsE8DqrpCNPWBa
        +ntHQJbu0KXi5dPfHQaQbDghdhuzjU+b0Q9GfSw=
X-Google-Smtp-Source: AGHT+IGmg76G1HFzflYvOXXqnwz6YbYp0uFoJFotAJKgtV8TfUQ0NSV4EmpR58mIZsO+Muftq+W4ag==
X-Received: by 2002:a05:6a20:7f8d:b0:187:f2f7:2383 with SMTP id d13-20020a056a207f8d00b00187f2f72383mr8957676pzj.45.1700567740082;
        Tue, 21 Nov 2023 03:55:40 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902740a00b001cc1dff5b86sm7685431pll.244.2023.11.21.03.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 03:55:39 -0800 (PST)
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
Subject: [PATCH 3/9] KVM: selftests: Test fixed counters overflow interrupt handling
Date:   Tue, 21 Nov 2023 19:54:51 +0800
Message-Id: <20231121115457.76269-4-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121115457.76269-1-cloudliang@tencent.com>
References: <20231121115457.76269-1-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinrong Liang <cloudliang@tencent.com>

Add tests to verify that fixed counters overflow interrupt handling
works as expected.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 32 +++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index 1b108e6718fc..efd8c61e1c16 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -551,9 +551,8 @@ static void test_pmi_init_x2apic(void)
 	pmi_irq_called = false;
 }
 
-static void guest_test_gp_counter_pmi(void)
+static void guest_test_gp_counter_pmi(uint8_t guest_pmu_version)
 {
-	uint8_t guest_pmu_version = guest_get_pmu_version();
 	uint32_t base_msr = get_pmc_msr();
 
 	test_pmi_init_x2apic();
@@ -569,6 +568,33 @@ static void guest_test_gp_counter_pmi(void)
 	guest_test_counters_pmi_workload();
 
 	GUEST_ASSERT(pmi_irq_called);
+}
+
+static void guest_test_fixed_counter_pmi(uint8_t guest_pmu_version)
+{
+	if (guest_pmu_version < 2)
+		return;
+
+	test_pmi_init_x2apic();
+
+	wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
+	wrmsr(MSR_CORE_PERF_FIXED_CTR0,
+	      (1ULL << this_cpu_property(X86_PROPERTY_PMU_FIXED_COUNTERS_BIT_WIDTH)) - 2);
+	wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, FIXED_PMC_CTRL(0, FIXED_PMC_ENABLE_PMI));
+
+	wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, FIXED_PMC_GLOBAL_CTRL_ENABLE(0));
+	guest_test_counters_pmi_workload();
+
+	GUEST_ASSERT(pmi_irq_called);
+}
+
+static void guest_test_counters_pmi(void)
+{
+	uint8_t guest_pmu_version = guest_get_pmu_version();
+
+	guest_test_gp_counter_pmi(guest_pmu_version);
+	guest_test_fixed_counter_pmi(guest_pmu_version);
+
 	GUEST_DONE();
 }
 
@@ -580,7 +606,7 @@ static void test_intel_ovf_pmi(uint8_t pmu_version, uint64_t perf_capabilities)
 	if (!pmu_version)
 		return;
 
-	vm = intel_pmu_vm_create(&vcpu, guest_test_gp_counter_pmi, pmu_version,
+	vm = intel_pmu_vm_create(&vcpu, guest_test_counters_pmi, pmu_version,
 				 perf_capabilities);
 
 	vm_install_exception_handler(vm, PMI_VECTOR, pmi_irq_handler);
-- 
2.39.3

