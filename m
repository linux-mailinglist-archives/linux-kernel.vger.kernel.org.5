Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D6B7E4E20
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344398AbjKHAdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbjKHAc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:32:26 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C851BEA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:32:10 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc1ddb34ccso42811835ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699403529; x=1700008329; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=d/dAIl3E7dSknIpj/mbUAcQ6yoHoVBYd62xaxn7wfeg=;
        b=1ysSe0cVrhaGiWIeb1ZVFDTx+8uSlcMOSie46ndKOpihRbJxFFRA+pCRYPeYBe4VdM
         cYHfMpmEuns9s6jMuLb2KhP5oiSrKYMAk+gcCM9cVaDi3IPzOsvu9INdK3W1HqRDveUO
         iK92vbJuQZSgjY3GI4hiH68ZkJh9AiQE8WbZEJIajnRhmhuRs11pz4GUHj6cujKTzuGa
         SKHcWfNNu+jr6P3U1CSDx8nlim0vpadOJVq3b3bXNrFhSOfjdilQP8rgDXjvXpi5nHB5
         lfc3ByNLue1f6fwLsdfo60AGQ4RGRqJ6TIttnDsqXRjsiUmCwZaomL+ZWVtWciO7tf3j
         sxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699403529; x=1700008329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/dAIl3E7dSknIpj/mbUAcQ6yoHoVBYd62xaxn7wfeg=;
        b=VBAG2w8ir+0YP0t5W9oj5Fpy7S1ZnsWVggUFCSjIfpJB7Y+V6IsgufFdH7UUE+Zw67
         pFkOfM+gTKR60LZeBhi762MHf20jrzF/D02qArpY9F5wyUbSDxOTLt5zq2FBUn7SoDxG
         Uhi6JID3x5+cNys8sYUrmAVFTEPfnHf1p+ecu/8/qBT18edY2/Ltm7gZ7wxDdiZ7zyi+
         lbe2jnLYRtzRyqU3eathSiCL7yZEWxPr+xnB9dCBVxx0LzOC1SsaDisij5QoaskBYWeS
         B0iCzpIw08OWo6OLSqnBvJTk7YE6KO/lk6dI/M21nxbWcrBUjloKldBHmgJl6aWxh2HK
         T4dQ==
X-Gm-Message-State: AOJu0YyuriP4LepYKnTjoB+61CHzA+SwD4yHmTQ+zdwr2knvs8Fm9Faf
        6gyHAYPoVeW5+XE4amT9kC9PfjJDl9o=
X-Google-Smtp-Source: AGHT+IGu/iyGnKnELoi33jrkYhWYrFeoJOaJbKiDhgUCaYbTY5azCthXGWTcbU0o5GWdPu/JoBkablBFxG0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:1390:b0:1cc:cc77:94ed with SMTP id
 jx16-20020a170903139000b001cccc7794edmr8893plb.10.1699403529654; Tue, 07 Nov
 2023 16:32:09 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Nov 2023 16:31:31 -0800
In-Reply-To: <20231108003135.546002-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231108003135.546002-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108003135.546002-16-seanjc@google.com>
Subject: [PATCH v7 15/19] KVM: selftests: Add a helper to query if the PMU
 module param is enabled
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

Add a helper to problem KVM's "enable_pmu" param, open coding strings in
multiple places is just asking for a false negatives and/or runtime errors
due to typos.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h     | 5 +++++
 tools/testing/selftests/kvm/x86_64/pmu_counters_test.c     | 2 +-
 tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c | 2 +-
 tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c     | 2 +-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 64aecb3dcf60..c261e0941dfe 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -1216,6 +1216,11 @@ static inline uint8_t xsetbv_safe(uint32_t index, uint64_t value)
 
 bool kvm_is_tdp_enabled(void);
 
+static inline bool kvm_is_pmu_enabled(void)
+{
+	return get_kvm_param_bool("enable_pmu");
+}
+
 uint64_t *__vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr,
 				    int *level);
 uint64_t *vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr);
diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index 90381382c51f..d775cc7e8fab 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -537,7 +537,7 @@ static void test_intel_counters(void)
 
 int main(int argc, char *argv[])
 {
-	TEST_REQUIRE(get_kvm_param_bool("enable_pmu"));
+	TEST_REQUIRE(kvm_is_pmu_enabled());
 
 	TEST_REQUIRE(host_cpu_is_intel);
 	TEST_REQUIRE(kvm_cpu_has_p(X86_PROPERTY_PMU_VERSION));
diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 7ec9fbed92e0..fa407e2ccb2f 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -867,7 +867,7 @@ int main(int argc, char *argv[])
 	struct kvm_vcpu *vcpu, *vcpu2 = NULL;
 	struct kvm_vm *vm;
 
-	TEST_REQUIRE(get_kvm_param_bool("enable_pmu"));
+	TEST_REQUIRE(kvm_is_pmu_enabled());
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_PMU_EVENT_FILTER));
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_PMU_EVENT_MASKED_EVENTS));
 
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index ebbcb0a3f743..562b0152a122 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -237,7 +237,7 @@ int main(int argc, char *argv[])
 {
 	union perf_capabilities host_cap;
 
-	TEST_REQUIRE(get_kvm_param_bool("enable_pmu"));
+	TEST_REQUIRE(kvm_is_pmu_enabled());
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_PDCM));
 
 	TEST_REQUIRE(kvm_cpu_has_p(X86_PROPERTY_PMU_VERSION));
-- 
2.42.0.869.gea05f2083d-goog

