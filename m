Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C720C801884
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442019AbjLBAFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441965AbjLBAEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:04:52 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A131D1BE6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:04:42 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6cdfbba2c64so1794714b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 16:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701475481; x=1702080281; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NWUMUOutKGtyIyuL4E6eg71BcaGpjE4r0WivmAjqhQo=;
        b=vkFmXeBrnLA3KUT2Ag6XygeUQ6MXQduujfOuqBsOvo7RJKXRnBXBV3ATRejtSj4i29
         mrWuRgX1UWxp0EpwihSkC6XWQfFRQI8cVt4bWhHqlo1RPCtqVh1DFQjRYR4KC2O0o/UC
         OPnAelKxH+9QRoEgxK56Qh45Zy8O00nZFFgzL01xYXl6TwN4v9kCoj8aUOt/iDF9steF
         StqVOjgk7A2kJbIq6fxFjkQI56NECaqEsmKSr5stGoPk+lIRazUEZNDNkiD0Kc5xu+UD
         iRbV98Fimcs43Gyt0CdaJbAWt78KBJXWtvRoz3reolnCgSPWKNiWC2hc/5JWTR7yG2HV
         F9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475481; x=1702080281;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWUMUOutKGtyIyuL4E6eg71BcaGpjE4r0WivmAjqhQo=;
        b=axzshEIafP7R+igLTKEywHn5ptsZRWWlQCSJ0Roaxtg6uRjXcsmV6PvcrU+fHgI0KU
         q//g6BGba0xRRMiEzYnERGFr0DDFCGiuEq3w80ftC/pr8MwR6OPqWtHmMLz3PHA9/f12
         uHJdDHy1fwk7kJX4RkHFUy9ywhVjMRfbwdtP2Sqj/WvaIReRAUL9VBAoIMN2ml9z46nK
         FxInlcj9E7nZZnzWUgBhGo0aYEVWl/ZBVaCqKK3pkNLVF0rsMSAuVrp8vBDUNCbB3bq7
         Hcs1SeLvjgsznXMMFPFSud7vIjttuWR2fKbuPQ+oMzX0PzCPU+2jBLjOmmFcqSHXy23q
         QMuA==
X-Gm-Message-State: AOJu0Yx5d2LbtkjVc/eDea+1/A2xqZYUE92zI8iOTb7XwI60FWUhaIY/
        c+YAYctqB0EOnZDuuiFii9S3IdQwwJ4=
X-Google-Smtp-Source: AGHT+IFLZ3n4QDdqu0zGYJAic2GBcG2EKc6qFz6tKfjhBAZX1ARziQITUdnBKgtaw6vShuyvqJ6bj5SgKYk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d29:b0:6cd:f18e:17d with SMTP id
 fa41-20020a056a002d2900b006cdf18e017dmr891277pfb.1.1701475481557; Fri, 01 Dec
 2023 16:04:41 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  1 Dec 2023 16:04:00 -0800
In-Reply-To: <20231202000417.922113-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231202000417.922113-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202000417.922113-12-seanjc@google.com>
Subject: [PATCH v9 11/28] KVM: selftests: Add vcpu_set_cpuid_property() to set properties
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
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinrong Liang <cloudliang@tencent.com>

Add vcpu_set_cpuid_property() helper function for setting properties, and
use it instead of open coding an equivalent for MAX_PHY_ADDR.  Future vPMU
testcases will also need to stuff various CPUID properties.

Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h      |  4 +++-
 .../testing/selftests/kvm/lib/x86_64/processor.c  | 15 ++++++++++++---
 .../x86_64/smaller_maxphyaddr_emulation_test.c    |  2 +-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index a84863503fcb..932944c4ea01 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -995,7 +995,9 @@ static inline void vcpu_set_cpuid(struct kvm_vcpu *vcpu)
 	vcpu_ioctl(vcpu, KVM_GET_CPUID2, vcpu->cpuid);
 }
 
-void vcpu_set_cpuid_maxphyaddr(struct kvm_vcpu *vcpu, uint8_t maxphyaddr);
+void vcpu_set_cpuid_property(struct kvm_vcpu *vcpu,
+			     struct kvm_x86_cpu_property property,
+			     uint32_t value);
 
 void vcpu_clear_cpuid_entry(struct kvm_vcpu *vcpu, uint32_t function);
 void vcpu_set_or_clear_cpuid_feature(struct kvm_vcpu *vcpu,
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index d8288374078e..67eb82a6c754 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -752,12 +752,21 @@ void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *cpuid)
 	vcpu_set_cpuid(vcpu);
 }
 
-void vcpu_set_cpuid_maxphyaddr(struct kvm_vcpu *vcpu, uint8_t maxphyaddr)
+void vcpu_set_cpuid_property(struct kvm_vcpu *vcpu,
+			     struct kvm_x86_cpu_property property,
+			     uint32_t value)
 {
-	struct kvm_cpuid_entry2 *entry = vcpu_get_cpuid_entry(vcpu, 0x80000008);
+	struct kvm_cpuid_entry2 *entry;
+
+	entry = __vcpu_get_cpuid_entry(vcpu, property.function, property.index);
+
+	(&entry->eax)[property.reg] &= ~GENMASK(property.hi_bit, property.lo_bit);
+	(&entry->eax)[property.reg] |= value << property.lo_bit;
 
-	entry->eax = (entry->eax & ~0xff) | maxphyaddr;
 	vcpu_set_cpuid(vcpu);
+
+	/* Sanity check that @value doesn't exceed the bounds in any way. */
+	TEST_ASSERT_EQ(kvm_cpuid_property(vcpu->cpuid, property), value);
 }
 
 void vcpu_clear_cpuid_entry(struct kvm_vcpu *vcpu, uint32_t function)
diff --git a/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c b/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c
index 06edf00a97d6..9b89440dff19 100644
--- a/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c
+++ b/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c
@@ -63,7 +63,7 @@ int main(int argc, char *argv[])
 	vm_init_descriptor_tables(vm);
 	vcpu_init_descriptor_tables(vcpu);
 
-	vcpu_set_cpuid_maxphyaddr(vcpu, MAXPHYADDR);
+	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_MAX_PHY_ADDR, MAXPHYADDR);
 
 	rc = kvm_check_cap(KVM_CAP_EXIT_ON_EMULATION_FAILURE);
 	TEST_ASSERT(rc, "KVM_CAP_EXIT_ON_EMULATION_FAILURE is unavailable");
-- 
2.43.0.rc2.451.g8631bc7472-goog

