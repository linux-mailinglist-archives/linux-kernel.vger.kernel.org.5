Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9785A788079
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242744AbjHYHCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241686AbjHYHCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:02:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE0719A1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:02:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5A1F647DE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D272BC433CB;
        Fri, 25 Aug 2023 07:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692946925;
        bh=zeNcQIFerO0x8e576oBWYTsxTNAjnbWNYZddqKZsdI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RL8t05DeXH+QXuuA5q1zgKYzkcykxzaVQx8WG1SHhumZo8qbLEx4uWLgLKbfFj98S
         5mwiG4d4MsLt97x9I3Ek8lDbztGY5TZ69llr8HL79kVKZ/n8jHJm2gMXh8En6sdLVZ
         SX6EXqXdQDLJ5HpW5Dj1PXpLBHLKXuaeGjUKJD7uLjzmCX3CndeLSHeL4N8xmgLuRo
         wOQvrY+moGz7WgYP01Jv/oS+LqA2Pg/9dye3RrQsA4atVXMv03nShNiizNFFShl2Dv
         VlHBb+JfYPdzBumJyGnz0AqbtTEYCW3uWdZGNOXZCByeER//xX0TkmfaxENqWZaFq2
         CyVSxlgnccWUw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 05/23] KVM: x86: Add SBPB support
Date:   Fri, 25 Aug 2023 00:01:36 -0700
Message-ID: <a4ab1e7fe50096d50fde33e739ed2da40b41ea6a.1692919072.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692919072.git.jpoimboe@kernel.org>
References: <cover.1692919072.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the AMD Selective Branch Predictor Barrier (SBPB) by
advertising the CPUID bit and handling PRED_CMD writes accordingly.

Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kvm/cpuid.c |  1 +
 arch/x86/kvm/cpuid.h |  3 ++-
 arch/x86/kvm/x86.c   | 29 ++++++++++++++++++++++++-----
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index c65f3ff1c79d..3a9879605513 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -729,6 +729,7 @@ void kvm_set_cpu_caps(void)
 		F(NULL_SEL_CLR_BASE) | F(AUTOIBRS) | 0 /* PrefetchCtlMsr */
 	);
 
+	kvm_cpu_cap_check_and_set(X86_FEATURE_SBPB);
 	kvm_cpu_cap_check_and_set(X86_FEATURE_IBPB_BRTYPE);
 	kvm_cpu_cap_check_and_set(X86_FEATURE_SRSO_NO);
 
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index b1658c0de847..e4db844a58fe 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -174,7 +174,8 @@ static inline bool guest_has_spec_ctrl_msr(struct kvm_vcpu *vcpu)
 static inline bool guest_has_pred_cmd_msr(struct kvm_vcpu *vcpu)
 {
 	return (guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) ||
-		guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBPB));
+		guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBPB) ||
+		guest_cpuid_has(vcpu, X86_FEATURE_SBPB));
 }
 
 static inline bool supports_cpuid_fault(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c381770bcbf1..0af7d4484435 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3672,17 +3672,36 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		vcpu->arch.perf_capabilities = data;
 		kvm_pmu_refresh(vcpu);
 		break;
-	case MSR_IA32_PRED_CMD:
-		if (!msr_info->host_initiated && !guest_has_pred_cmd_msr(vcpu))
+	case MSR_IA32_PRED_CMD: {
+		u64 reserved_bits = ~(PRED_CMD_IBPB | PRED_CMD_SBPB);
+
+		if (!msr_info->host_initiated) {
+			if ((!guest_has_pred_cmd_msr(vcpu)))
+				return 1;
+
+			if (!guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) &&
+			    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBPB))
+				reserved_bits |= PRED_CMD_IBPB;
+
+			if (!guest_cpuid_has(vcpu, X86_FEATURE_SBPB))
+				reserved_bits |= PRED_CMD_SBPB;
+		}
+
+		if (!boot_cpu_has(X86_FEATURE_IBPB))
+			reserved_bits |= PRED_CMD_IBPB;
+
+		if (!boot_cpu_has(X86_FEATURE_SBPB))
+			reserved_bits |= PRED_CMD_SBPB;
+
+		if (data & reserved_bits)
 			return 1;
 
-		if (!boot_cpu_has(X86_FEATURE_IBPB) || (data & ~PRED_CMD_IBPB))
-			return 1;
 		if (!data)
 			break;
 
-		wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
+		wrmsrl(MSR_IA32_PRED_CMD, data);
 		break;
+	}
 	case MSR_IA32_FLUSH_CMD:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_FLUSH_L1D))
-- 
2.41.0

