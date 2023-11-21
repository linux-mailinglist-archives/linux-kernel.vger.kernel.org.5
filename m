Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AEB7F2C34
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbjKUL4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbjKULzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:55:52 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907E0112;
        Tue, 21 Nov 2023 03:55:48 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1cf52e5e07eso18587085ad.0;
        Tue, 21 Nov 2023 03:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700567748; x=1701172548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75nXJDWiYTEX3B+cQ6vAyTLOcRu7koIcy8TV5Nu2eu8=;
        b=X1yef7wmMXRo7lIFwUeWsLJ/Cr4cMRFFJbBqY/NlxX24PYvB8yk0AUtZ8+0BCFIwco
         oR3O6bX3tU4b1rdmzX+h5ZjpzWEyoh+iOww4v/fifTdbnEOEuhPCbngdS+dCDDGNmazF
         WVXKsoEByTfO1zX5FznpoGKG9DlZTCS+lff4tKMrD01/71JKZvXBxt4Oxt3+bGDrE9W4
         eNDPG+z1uMQAFzRLusfYp6py3EFi/9hgKuy/ZUgbUlhLYbaqz6YS6OZL6cmFSWxlyOAA
         abzRBoTJmefZNhjPlyJC0X0L21VkiF71mCEOegpsrj+h4BjhndyOsvq0R4iL+ijc0Ap0
         /oRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700567748; x=1701172548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75nXJDWiYTEX3B+cQ6vAyTLOcRu7koIcy8TV5Nu2eu8=;
        b=II2/B9Cl4arTw8O2PyNR9UhV/7LcigQ4cwmT6lYq1FM2dwJ76ID/4hQ64Rha9OubLh
         9KLU+xYelDkBUVZpGZ1HYFQBzwCYX+hFlUPS76z7J3PK8L30xErp3QtMn5Y2LbN0fQbp
         JFMcy5DIGoIiSaZfTYgc1M1Ch5IM0IYFxhiKMuywAxMuenyNNU6AfFswxRkE6Eg5i+Y6
         2JkkWBcNfIaywPFUlzHBXS0iDPjHWyawE25Dk14uvBI9PdNsASEaqTqnHhE8xkAVzVa7
         iWLqOgTS4zs6pSqcp4aDJZrKzqZ1TfCGoifmW8ixWij/IPqiNx0K/szR0xKa5SCXSTpV
         Xpaw==
X-Gm-Message-State: AOJu0YzwzvZ3AiTZn3tzHZaGlXkbm8zBFt3zn9CYZ5UKQbWo4rFNsJSh
        74Me0H55a0ss/Mnq3gOGnng=
X-Google-Smtp-Source: AGHT+IFhjyt/O3/z/YBHchD3ADW9O75xPa2r+y7vvCSXnQcSU0+E/p8pO+zMfxjpgVg78tVYZfkGog==
X-Received: by 2002:a17:903:2287:b0:1cc:5ce4:f64b with SMTP id b7-20020a170903228700b001cc5ce4f64bmr3449723plh.8.1700567748067;
        Tue, 21 Nov 2023 03:55:48 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902740a00b001cc1dff5b86sm7685431pll.244.2023.11.21.03.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 03:55:47 -0800 (PST)
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
Subject: [PATCH 6/9] KVM: selftests: Test consistency of AMD PMU counters num
Date:   Tue, 21 Nov 2023 19:54:54 +0800
Message-Id: <20231121115457.76269-7-cloudliang@tencent.com>
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

Add AMD test case to check if non-existent counters can be accessed
in guest. Nor will KVM emulate more counters than it can support.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index 3c4081a508b0..b1502a446a55 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -761,6 +761,64 @@ static void test_amd_zen_events(void)
 	kvm_vm_free(vm);
 }
 
+static void guest_wr_rd_amd_counters(uint32_t pmc_msr, bool expect_gp,
+				     uint64_t test_val)
+{
+	uint8_t vector;
+	uint64_t val;
+
+	vector = wrmsr_safe(pmc_msr, test_val);
+	GUEST_ASSERT_PMC_MSR_ACCESS(WRMSR, pmc_msr, expect_gp, vector);
+
+	vector = rdmsr_safe(pmc_msr, &val);
+	GUEST_ASSERT_PMC_MSR_ACCESS(RDMSR, pmc_msr, expect_gp, vector);
+
+	if (!expect_gp)
+		GUEST_ASSERT_EQ(val, test_val);
+}
+
+static void guest_test_amd_counters_num(void)
+{
+	uint8_t i, flag, nr_amd_counters;
+	uint64_t ctrl_msr;
+	uint32_t pmc_msr;
+	bool expect_gp;
+
+	set_amd_counters(&nr_amd_counters, &ctrl_msr, &pmc_msr, &flag);
+
+	for (i = 0; i < nr_amd_counters * flag; i++) {
+		expect_gp = i >= nr_amd_counters;
+
+		guest_wr_rd_amd_counters(pmc_msr + i * flag, expect_gp, 0xffff);
+		guest_wr_rd_amd_counters(ctrl_msr + i * flag, expect_gp, 0);
+	}
+
+	GUEST_DONE();
+}
+
+static void test_amd_counters_num(void)
+{
+	bool kvm_pmu_is_perfmonv2 = kvm_cpu_has(X86_FEATURE_PERFMON_V2);
+	unsigned int i, nr_test = 1;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	if (kvm_pmu_is_perfmonv2)
+		nr_test = AMD64_NR_COUNTERS_CORE;
+
+	for (i = 0; i <= nr_test; i++) {
+		vm = pmu_vm_create_with_one_vcpu(&vcpu,
+						 guest_test_amd_counters_num);
+
+		if (kvm_pmu_is_perfmonv2)
+			vcpu_set_cpuid_property(vcpu,
+						X86_PROPERTY_PMU_NR_CORE_COUNTERS, i);
+
+		run_vcpu(vcpu);
+		kvm_vm_free(vm);
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_is_pmu_enabled());
@@ -777,6 +835,7 @@ int main(int argc, char *argv[])
 		test_intel_counters();
 	} else if (host_cpu_is_amd) {
 		test_amd_zen_events();
+		test_amd_counters_num();
 	} else {
 		TEST_FAIL("Unknown CPU vendor");
 	}
-- 
2.39.3

