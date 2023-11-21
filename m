Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386337F2C38
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjKUL4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbjKULz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:55:57 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1838123;
        Tue, 21 Nov 2023 03:55:53 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1cf5901b4c8so21522915ad.1;
        Tue, 21 Nov 2023 03:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700567753; x=1701172553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtftiOzjpf70P5oevOX6XZZCHaAm7J3EtiuJv1/+VvA=;
        b=Qm1AT+aPqLX7p1TgcTgzbWKQ/pOBlQTM0zaHKYZ7UxcdmVQia044wKWQFtAAd037y7
         ZMch7ujaVV5dP4J6DG7R744rjMP/BHDDK3LYOVXc/uYIkQJxWtQb2HUfWTCcRL+2Er+v
         4tXLApM5mv9EzRecwxBxymxGbXSJfP8mmP4M3vNQeTKsFlfgmpLBmcYxyiRpcmDlraWw
         HXzk4WLf2L7lIb+IC1o1ciVivUYMcIrLp9/1XlenXuqakN/zU4E6CPHYdV5HHNwdXbDV
         ec3427YMtgY79JuCf18o5xSRxJLFFPxJbY/KYQMkMX7LCBzvgIgwQQLgQj4Slk1iaMRL
         CKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700567753; x=1701172553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtftiOzjpf70P5oevOX6XZZCHaAm7J3EtiuJv1/+VvA=;
        b=qXiE5UpC8hcFw6iTsGUDaUbZNEsDTtMo6g7wxblFy3iUtf4aFFUtp/W3HhhN3o8pyq
         UeN3Sbh15giGyhuyPg6Fp249p5VJ0xsWwr8uI67BDofsHMkDwzd3HLw4XYp10GnKggMd
         h9wbc82AQI0TUnwjmVlu1qNUg4REkrahw+bU0OLSQiqh8pdVMhOMRj4wKEORDuGAg4WJ
         F5T03JyouJFw+4NB+Q6rUvxCfR/CdDBeT1Ul1UjSkP4mDqSv0LondGj2eDGWRtUU2AJR
         7Q/ak6JpUtKpjU7Tl7axtHW+bSFGd1uCw8xEo58vBSG3cOHIB+XI+8uo4IKYORKb8l36
         GHxg==
X-Gm-Message-State: AOJu0YysVdUqSSiCBjlX8HM7k0kO5E8x7IHYOD+1Zr8/hGFfpkZSIYTm
        9DWFWaeYlA4xePiiU/xfKCI=
X-Google-Smtp-Source: AGHT+IE1b6bIYK6eqr41otZww4GK+zX5EHlGcethonC2GP2y7PIZJt3ciJynJJiNd0GEaVazWNbg5A==
X-Received: by 2002:a17:903:2350:b0:1cf:6ce6:5f22 with SMTP id c16-20020a170903235000b001cf6ce65f22mr2426187plh.60.1700567753338;
        Tue, 21 Nov 2023 03:55:53 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902740a00b001cc1dff5b86sm7685431pll.244.2023.11.21.03.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 03:55:53 -0800 (PST)
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
Subject: [PATCH 8/9] KVM: selftests: Test AMD Guest PerfCtrExtCore
Date:   Tue, 21 Nov 2023 19:54:56 +0800
Message-Id: <20231121115457.76269-9-cloudliang@tencent.com>
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

Add test case for AMD Guest PerfCtrExtCore.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index 07cb9694e225..ca5b352ea6ae 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -863,6 +863,36 @@ static void test_amd_pmu_version(void)
 	}
 }
 
+static void guest_test_perfctr_core(void)
+{
+	bool expect_gp = !this_cpu_has(X86_FEATURE_PERFCTR_CORE);
+	unsigned int i;
+
+	for (i = 0; i < AMD64_NR_COUNTERS_CORE; i++) {
+		guest_wr_rd_amd_counters(MSR_F15H_PERF_CTR0 + i * 2, expect_gp, 0xffff);
+		guest_wr_rd_amd_counters(MSR_F15H_PERF_CTL0 + i * 2, expect_gp, 0);
+	}
+
+	GUEST_DONE();
+}
+
+static void test_amd_perfctr_core(void)
+{
+	bool kvm_pmu_has_perfctr_core = kvm_cpu_has(X86_FEATURE_PERFCTR_CORE);
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	unsigned int i;
+
+	for (i = 0; i <= kvm_pmu_has_perfctr_core; i++) {
+		vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_perfctr_core);
+
+		vcpu_set_or_clear_cpuid_feature(vcpu, X86_FEATURE_PERFCTR_CORE, i);
+
+		run_vcpu(vcpu);
+		kvm_vm_free(vm);
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_is_pmu_enabled());
@@ -881,6 +911,7 @@ int main(int argc, char *argv[])
 		test_amd_zen_events();
 		test_amd_counters_num();
 		test_amd_pmu_version();
+		test_amd_perfctr_core();
 	} else {
 		TEST_FAIL("Unknown CPU vendor");
 	}
-- 
2.39.3

