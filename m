Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470A57E7725
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345763AbjKJCOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345749AbjKJCNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:13:39 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E892C47B3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:13:30 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6b3e4c22dabso1494927b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699582410; x=1700187210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bz+cFjmGJykZammOdDVwa1MNebY51dfMTOWn2QBuCm4=;
        b=n6s2P59WuqBwH5zqjT5/UyGf/jPYWzlQAs4dYBd52sZf4mMdptZihnVvL9DFjNyvbg
         zEiiCMSX4ZCfJBQcsQmDnh7AXL5GNMgqFRsAm0rE5WpJugC/dqeifBaFX8Lip/5Xl54l
         PEXqVcroRlZHw/4SxNEcZxeo99iGp1GYyfFHQbFRfr/RRJTzQlaSo9tsbP9e6G5sk1wI
         2sw5cV1ZOa7bYkpoi6vSiJlwnaY3BdLNDVZVIX17feXbKfSu/EoAG+Tz4WPbmlyT5L5y
         xo7OSG375P2ndInIu52GzSlV412HLF6izIMqwzimAaaVjZOe6WBZuOULGnC1+UBdFIKi
         GTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582410; x=1700187210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bz+cFjmGJykZammOdDVwa1MNebY51dfMTOWn2QBuCm4=;
        b=IQ2z9T4suB71y1e6xFGEOzojfCGpGIP2gGsc5FM/Rvht4bgjuJtta+1Vj3OL0nrvVu
         4x7XjGjG3eoHaeC2HIgbaeZF2o8LhwFO/N1BByWZ/qmSKm3Q9FxRiP7A9PdfFkiZwGGQ
         x6Uw/yIHi3nFRrD44HrNrbFcVcHK3FA1jfidxv+9tlC54Khwxmwx05xxVNARYo3AMq0G
         RAnrW/bGBxt9ISadh9iRQw5rG+z2FibvO9EYxfE5GO4JTZ7/9PtoOyNLdhcGO3EHIW1k
         nGdQ61ciOLNfN2jyP1h8R5WakSsd08/N/rnlLJUpQyH+1KwPiwU5EWBL51TIYonESvoo
         gRVQ==
X-Gm-Message-State: AOJu0Ywj5+qQNOtYeBDXpl6sj459nKoB77BzaWLIdRgRVFi5xSWTjPEN
        uiZtmk0etnNbEfoRu9segY49+s59MUU=
X-Google-Smtp-Source: AGHT+IFrUaQlXe1zq/FgSYHz0vm+SUwiTd20fARy8yP7dca37b6JphU5TOkonG80Qlu/5pn/jlo5StSE4yI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:b20:b0:6be:aed:7ad0 with SMTP id
 f32-20020a056a000b2000b006be0aed7ad0mr901504pfu.2.1699582410463; Thu, 09 Nov
 2023 18:13:30 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:12:49 -0800
In-Reply-To: <20231110021306.1269082-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110021306.1269082-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110021306.1269082-10-seanjc@google.com>
Subject: [PATCH v8 09/26] KVM: selftests: Add vcpu_set_cpuid_property() to set properties
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
2.42.0.869.gea05f2083d-goog

