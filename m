Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBA37D43F4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjJXA1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjJXA0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:26:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4CF10DB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:26:48 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7af69a4baso52994427b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698107207; x=1698712007; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=U9FAqMqGtvimJV8duNMrmOEEttYHO7Vcjr1pZFha2AI=;
        b=ymyrPoeHtVTHjKzVDHZ3lYEMIix9RkvQml9sH1EKPAPBpnckYVYW+gVePkIixl5pIi
         sTGO/gSzZ/bIQ/SHNU7srTlKMhMjfg9I4mgjvtxO2KtuxWDVjgoHEOSbxuc3wp+hIDvn
         fAxttTmZlDYJv7fQ302ghiVKJzW/sNgyI4Q2So4rDqenZ2Wum/Zto/EHoboZewtVVL8E
         b2qt7YyDsI5HQ1mtF1X7A+Gf2SeOrL1f1tVxMVgfuUdF2wlbbo3QPhmKXqmXlZ7NZTnh
         +EOVh47DtAL1p4ETxEtL5bS2yCOv8JCErPchVyzVdHOmtREI5znIcXl5k3PsJyidnWSc
         Wp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698107207; x=1698712007;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9FAqMqGtvimJV8duNMrmOEEttYHO7Vcjr1pZFha2AI=;
        b=Rkq9sLPRY64blKwRniDLov3dgbHDh7sl89qv3WfDz+fngQJsrnfmsh827aWP4meVK4
         jC5emGLBpCrQlmgJT2+YMrqUzsK+MoO39ar7KYUuXYu8wIdm0QC0GzvsycgtSVC+osko
         ZqC4o5Wc6thPkngDivg/mpfm8cdAWICfcOz774UNCFFuMwZW/bg4+dY1uXM5TZIxRAyY
         02H5lZa6xKqHmItXdbfKK8bMXYLE91aPCvNLPT0aby1pIcmTxkfQeyCq8zWUeNPrnN6d
         swGJ1GSioMQ4KgH2cwjXY4tCE1BeI2ZEEVWe2P251ndUVNFqWrBbDxR96HIPASS34HHp
         sGHg==
X-Gm-Message-State: AOJu0YxZAtTKc6qF/VXea2qtDK7YqL2cnVa+fq44ekVi8BYo9nu8zAeH
        XqoBY5/j8R6n00Nj7fh/57s4Nl+rbUs=
X-Google-Smtp-Source: AGHT+IHdY1RcA75Ev7AeEMIaSUTqKneRwAjog5BXT7thttvE72u2/jknvPFNvqPiTEfmLYJzdXUGHBh7XOE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c3b8:4274 with SMTP id
 v3-20020a056902108300b00d9ac3b84274mr281851ybu.7.1698107207733; Mon, 23 Oct
 2023 17:26:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 23 Oct 2023 17:26:26 -0700
In-Reply-To: <20231024002633.2540714-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231024002633.2540714-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024002633.2540714-7-seanjc@google.com>
Subject: [PATCH v5 06/13] KVM: selftests: Extend {kvm,this}_pmu_has() to
 support fixed counters
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinrong Liang <cloudliang@tencent.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the kvm_x86_pmu_feature framework to allow querying for fixed
counters via {kvm,this}_pmu_has().  Like architectural events, checking
for a fixed counter annoyingly requires checking multiple CPUID fields, as
a fixed counter exists if:

  FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i);

Note, KVM currently doesn't actually support exposing fixed counters via
the bitmask, but that will hopefully change sooner than later, and Intel's
SDM explicitly "recommends" checking both the number of counters and the
mask.

Rename the intermedate "anti_feature" field to simply 'f' since the fixed
counter bitmask (thankfully) doesn't have reversed polarity like the
architectural events bitmask.

Note, ideally the helpers would use BUILD_BUG_ON() to assert on the
incoming register, but the expected usage in PMU tests can't guarantee the
inputs are compile-time constants.

Opportunistically define macros for all of the architectural events and
fixed counters that KVM currently supports.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  | 63 +++++++++++++------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 2d9771151dd9..b103c462701b 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -281,24 +281,39 @@ struct kvm_x86_cpu_property {
  * that indicates the feature is _not_ supported, and a property that states
  * the length of the bit mask of unsupported features.  A feature is supported
  * if the size of the bit mask is larger than the "unavailable" bit, and said
- * bit is not set.
+ * bit is not set.  Fixed counters also bizarre enumeration, but inverted from
+ * arch events for general purpose counters.  Fixed counters are supported if a
+ * feature flag is set **OR** the total number of fixed counters is greater
+ * than index of the counter.
  *
- * Wrap the "unavailable" feature to simplify checking whether or not a given
- * architectural event is supported.
+ * Wrap the events for general purpose and fixed counters to simplify checking
+ * whether or not a given architectural event is supported.
  */
 struct kvm_x86_pmu_feature {
-	struct kvm_x86_cpu_feature anti_feature;
+	struct kvm_x86_cpu_feature f;
 };
-#define	KVM_X86_PMU_FEATURE(__bit)						\
-({										\
-	struct kvm_x86_pmu_feature feature = {					\
-		.anti_feature = KVM_X86_CPU_FEATURE(0xa, 0, EBX, __bit),	\
-	};									\
-										\
-	feature;								\
+#define	KVM_X86_PMU_FEATURE(__reg, __bit)				\
+({									\
+	struct kvm_x86_pmu_feature feature = {				\
+		.f = KVM_X86_CPU_FEATURE(0xa, 0, __reg, __bit),		\
+	};								\
+									\
+	kvm_static_assert(KVM_CPUID_##__reg == KVM_CPUID_EBX ||		\
+			  KVM_CPUID_##__reg == KVM_CPUID_ECX);		\
+	feature;							\
 })
 
-#define X86_PMU_FEATURE_BRANCH_INSNS_RETIRED	KVM_X86_PMU_FEATURE(5)
+#define X86_PMU_FEATURE_CPU_CYCLES		KVM_X86_PMU_FEATURE(EBX, 0)
+#define X86_PMU_FEATURE_INSNS_RETIRED		KVM_X86_PMU_FEATURE(EBX, 1)
+#define X86_PMU_FEATURE_REFERENCE_CYCLES	KVM_X86_PMU_FEATURE(EBX, 2)
+#define X86_PMU_FEATURE_LLC_REFERENCES		KVM_X86_PMU_FEATURE(EBX, 3)
+#define X86_PMU_FEATURE_LLC_MISSES		KVM_X86_PMU_FEATURE(EBX, 4)
+#define X86_PMU_FEATURE_BRANCH_INSNS_RETIRED	KVM_X86_PMU_FEATURE(EBX, 5)
+#define X86_PMU_FEATURE_BRANCHES_MISPREDICTED	KVM_X86_PMU_FEATURE(EBX, 6)
+
+#define X86_PMU_FEATURE_INSNS_RETIRED_FIXED	KVM_X86_PMU_FEATURE(ECX, 0)
+#define X86_PMU_FEATURE_CPU_CYCLES_FIXED	KVM_X86_PMU_FEATURE(ECX, 1)
+#define X86_PMU_FEATURE_REFERENCE_CYCLES_FIXED	KVM_X86_PMU_FEATURE(ECX, 2)
 
 static inline unsigned int x86_family(unsigned int eax)
 {
@@ -697,10 +712,16 @@ static __always_inline bool this_cpu_has_p(struct kvm_x86_cpu_property property)
 
 static inline bool this_pmu_has(struct kvm_x86_pmu_feature feature)
 {
-	uint32_t nr_bits = this_cpu_property(X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH);
+	uint32_t nr_bits;
 
-	return nr_bits > feature.anti_feature.bit &&
-	       !this_cpu_has(feature.anti_feature);
+	if (feature.f.reg == KVM_CPUID_EBX) {
+		nr_bits = this_cpu_property(X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH);
+		return nr_bits > feature.f.bit && !this_cpu_has(feature.f);
+	}
+
+	GUEST_ASSERT(feature.f.reg == KVM_CPUID_ECX);
+	nr_bits = this_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
+	return nr_bits > feature.f.bit || this_cpu_has(feature.f);
 }
 
 static __always_inline uint64_t this_cpu_supported_xcr0(void)
@@ -916,10 +937,16 @@ static __always_inline bool kvm_cpu_has_p(struct kvm_x86_cpu_property property)
 
 static inline bool kvm_pmu_has(struct kvm_x86_pmu_feature feature)
 {
-	uint32_t nr_bits = kvm_cpu_property(X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH);
+	uint32_t nr_bits;
 
-	return nr_bits > feature.anti_feature.bit &&
-	       !kvm_cpu_has(feature.anti_feature);
+	if (feature.f.reg == KVM_CPUID_EBX) {
+		nr_bits = kvm_cpu_property(X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH);
+		return nr_bits > feature.f.bit && !kvm_cpu_has(feature.f);
+	}
+
+	TEST_ASSERT_EQ(feature.f.reg, KVM_CPUID_ECX);
+	nr_bits = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
+	return nr_bits > feature.f.bit || kvm_cpu_has(feature.f);
 }
 
 static __always_inline uint64_t kvm_cpu_supported_xcr0(void)
-- 
2.42.0.758.gaed0368e0e-goog

