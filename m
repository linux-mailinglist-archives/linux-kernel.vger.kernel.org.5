Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD0A7D43F1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjJXA0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjJXA0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:26:46 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCC210D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:26:44 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c9c83b656fso32912225ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698107204; x=1698712004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=F8dxA5PYrMgcC3TCFQUnjkCAgDkYN5FCICeYb/ZzON0=;
        b=3ANCsRAOhw2Bys8XhAYGao+LqGKuUu60I6BcYMOl9QOwq9ONFG9TSzR7Db/ay/LHFA
         Xd8NBJ+hpOPC/ocdqgLZnBu5DE/fOTJ90krxvyQ2J5UJk9h8Pz0y7r9m0LIBN2dnPy8D
         wWBUmtudodW93UWc3NQdUIAdL1RWCFlkRce3lR+535kkwWn8yZFvMicZtm8MEC1qDk/5
         5lcT0fugNM7bDMb4eJgdP4qsw1Vy2qpTUkfOC3OuBaxuye0wAY8lk0XVXrvvRjBk+zQI
         lBUNt2mdmDA+q/X/U+0ipYte8bmyhk9lhbMjjQradhvWUDxGmKBEMF/Q+8RSWsYhyd4W
         Xx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698107204; x=1698712004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8dxA5PYrMgcC3TCFQUnjkCAgDkYN5FCICeYb/ZzON0=;
        b=YeDPpcpsA9d56HW4RKf5dSw/tCCTgZDNvxajfo5V783FSaO6z7D5GH94kX7/UMop6g
         CNwifPIDsOif6zuQxdeibTh3gw9Wz9KqSMPb5ibRQrSBsOydP51eDrza8QNrQORx2X4m
         oEqHPjBuydA9f0preMHwDqsWAUA00H+Fav0QM1KUpaSdOV8wCppOhVBJBfviFhzcJSxE
         uB3xgfPv24+zy/yP2SKr9UJPiK454cyjsM48QRRGrJKebMykKNUxfcGnCq7ksPXlq9fo
         VN6ugV+krmiz3qQXdcHeGuh3NHVJw5W6MhnjQrQyFldiskHwC/MmM3KGyIoQ9099T3tt
         yPng==
X-Gm-Message-State: AOJu0Yw2L+sO2nGSYxbs6w38Sj9g/zGHFDTa/Z/nJA8sKvoTK2Tg/zw3
        TA8jPifvTnUWdPtm8/ex4b/IWwWyZzI=
X-Google-Smtp-Source: AGHT+IFxcLi6IwWcXtvtdZIs4kyjvjtoxoncPE9QN4ThjeMC3VX0DBhml+M+m1iSJrMtMUkKANjGOAL6YJM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c1d4:b0:1bc:2547:b17c with SMTP id
 c20-20020a170902c1d400b001bc2547b17cmr202838plc.1.1698107204068; Mon, 23 Oct
 2023 17:26:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 23 Oct 2023 17:26:24 -0700
In-Reply-To: <20231024002633.2540714-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231024002633.2540714-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024002633.2540714-5-seanjc@google.com>
Subject: [PATCH v5 04/13] KVM: selftests: Add vcpu_set_cpuid_property() to set properties
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinrong Liang <cloudliang@tencent.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinrong Liang <cloudliang@tencent.com>

Add vcpu_set_cpuid_property() helper function for setting properties, and
use it instead of open coding an equivalent for MAX_PHY_ADDR.  Future vPMU
testcases will also need to stuff various CPUID properties.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/x86_64/processor.h |  4 +++-
 tools/testing/selftests/kvm/lib/x86_64/processor.c   | 12 +++++++++---
 .../kvm/x86_64/smaller_maxphyaddr_emulation_test.c   |  2 +-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 25bc61dac5fb..a01931f7d954 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -994,7 +994,9 @@ static inline void vcpu_set_cpuid(struct kvm_vcpu *vcpu)
 	vcpu_ioctl(vcpu, KVM_GET_CPUID2, vcpu->cpuid);
 }
 
-void vcpu_set_cpuid_maxphyaddr(struct kvm_vcpu *vcpu, uint8_t maxphyaddr);
+void vcpu_set_cpuid_property(struct kvm_vcpu *vcpu,
+			     struct kvm_x86_cpu_property property,
+			     uint32_t value);
 
 void vcpu_clear_cpuid_entry(struct kvm_vcpu *vcpu, uint32_t function);
 void vcpu_set_or_clear_cpuid_feature(struct kvm_vcpu *vcpu,
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index d8288374078e..9e717bc6bd6d 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -752,11 +752,17 @@ void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *cpuid)
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
+	(&entry->eax)[property.reg] |= value << (property.lo_bit);
 
-	entry->eax = (entry->eax & ~0xff) | maxphyaddr;
 	vcpu_set_cpuid(vcpu);
 }
 
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
2.42.0.758.gaed0368e0e-goog

