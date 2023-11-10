Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60A67E7748
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbjKJCPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjKJCOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:14:54 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AEE47B2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:14:01 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc323b2aa3so15493985ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699582441; x=1700187241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=eeEpHUJR4aSIdr4KeWYcEqsui8csxJQ9oememfgsBgo=;
        b=CYAlUniJJyd5oS9loxyK2HllttVfhxLg/R+cDtqV2F8Xz7Zjr3V9a1cP3XvlBVpa/y
         VPbzxG2Zi2heCHKRNSv5S87E6w/txUXRLx1+v0tlFxtCKHACOTAvS0TNbkVlaGtmshqT
         FSIg5hM6aI+DgPPbF8DuMm3iE+eC/763t0RF+gRA+lbTjAvSVYvBPdu+xiW6BjOaKAsy
         8Or5koy7lP7s4YHB5VDriaCoNE7IQsrzv4+XxRI1dZ/u8LuCCleiYmJ84u0T5O5L8yYL
         +83n2klE8doJwk2r0IixUxnQg/T2XhyJjYfxa2AsDaRuHFhpVH1MFbuktnpHcrfrYbmR
         dmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582441; x=1700187241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeEpHUJR4aSIdr4KeWYcEqsui8csxJQ9oememfgsBgo=;
        b=VgLVM84FVraiCQCrbh1YGEznfOH8nNZVOBoa/Y7BQm5XzLHdKDNmYn66fT0OptYGoW
         PIQ2Axb3Rgw8tGuBZRxpgVeElbZmapGM8pUQoShvY4l00sBHnTNCY1blPQ7W1fSdwH9j
         t47Yx/N2NzUuETfVNVlRCi2cAG0Vq+It5OMnsK0ybyqMv/3Zsvu/HyEhL/ufas/2HDcv
         ExTtH62p7L0QiEfG/3Zni1895G0QX63mlWf2Vt0HOgUct7AY95DAWne1mEAFLGUsgmrH
         hIsCp9fwLaXvNMo3f2VlXd2Ndi/q8WTSLxDT1x2wNrcajO/Srk+mxpXdldHuZGjP7o71
         h0QA==
X-Gm-Message-State: AOJu0Yy688xB1F+RPBLLrVlAheL5yOXCKrdxCtUsuEnS5SJpKCWUGhBW
        zo3v7mRaBhEqjhBjFTymbJ9H1V3Uexo=
X-Google-Smtp-Source: AGHT+IGgeUlI1gIdhxbnrF8t5uag7i1+4BWQCrg9/FxqqTptdnxIjWrg8BCH+R9iQPV7aVv/lNp1lonHIGk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:efc1:b0:1cc:2bd6:b54a with SMTP id
 ja1-20020a170902efc100b001cc2bd6b54amr926859plb.10.1699582440858; Thu, 09 Nov
 2023 18:14:00 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:13:05 -0800
In-Reply-To: <20231110021306.1269082-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110021306.1269082-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110021306.1269082-26-seanjc@google.com>
Subject: [PATCH v8 25/26] KVM: selftests: Add helpers for safe and safe+forced
 RDMSR, RDPMC, and XGETBV
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

Add helpers for safe and safe-with-forced-emulations versions of RDMSR,
RDPMC, and XGETBV.  Use macro shenanigans to eliminate the rather large
amount of boilerplate needed to get values in and out of registers.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  | 40 +++++++++++++------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index e83b136ca15b..ba16d714b451 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -1215,21 +1215,35 @@ void vm_install_exception_handler(struct kvm_vm *vm, int vector,
 	vector;								\
 })
 
-static inline uint8_t rdmsr_safe(uint32_t msr, uint64_t *val)
-{
-	uint64_t error_code;
-	uint8_t vector;
-	uint32_t a, d;
-
-	asm volatile(KVM_ASM_SAFE("rdmsr")
-		     : "=a"(a), "=d"(d), KVM_ASM_SAFE_OUTPUTS(vector, error_code)
-		     : "c"(msr)
-		     : KVM_ASM_SAFE_CLOBBERS);
-
-	*val = (uint64_t)a | ((uint64_t)d << 32);
-	return vector;
+#define BUILD_READ_U64_SAFE_HELPER(insn, _fep, _FEP)			\
+static inline uint8_t insn##_safe ##_fep(uint32_t idx, uint64_t *val)	\
+{									\
+	uint64_t error_code;						\
+	uint8_t vector;							\
+	uint32_t a, d;							\
+									\
+	asm volatile(KVM_ASM_SAFE##_FEP(#insn)				\
+		     : "=a"(a), "=d"(d),				\
+		       KVM_ASM_SAFE_OUTPUTS(vector, error_code)		\
+		     : "c"(idx)						\
+		     : KVM_ASM_SAFE_CLOBBERS);				\
+									\
+	*val = (uint64_t)a | ((uint64_t)d << 32);			\
+	return vector;							\
 }
 
+/*
+ * Generate {insn}_safe() and {insn}_safe_fep() helpers for instructions that
+ * use ECX as in input index, and EDX:EAX as a 64-bit output.
+ */
+#define BUILD_READ_U64_SAFE_HELPERS(insn)				\
+	BUILD_READ_U64_SAFE_HELPER(insn, , )				\
+	BUILD_READ_U64_SAFE_HELPER(insn, _fep, _FEP)			\
+
+BUILD_READ_U64_SAFE_HELPERS(rdmsr)
+BUILD_READ_U64_SAFE_HELPERS(rdpmc)
+BUILD_READ_U64_SAFE_HELPERS(xgetbv)
+
 static inline uint8_t wrmsr_safe(uint32_t msr, uint64_t val)
 {
 	return kvm_asm_safe("wrmsr", "a"(val & -1u), "d"(val >> 32), "c"(msr));
-- 
2.42.0.869.gea05f2083d-goog

