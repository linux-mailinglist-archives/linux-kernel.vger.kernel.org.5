Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215A47F66EA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjKWTGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWTGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:06:43 -0500
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B679E;
        Thu, 23 Nov 2023 11:06:47 -0800 (PST)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1r6F2B-0007vm-O5; Thu, 23 Nov 2023 20:06:43 +0100
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86: Allow XSAVES on CPUs where host doesn't use it due to an errata
Date:   Thu, 23 Nov 2023 20:06:37 +0100
Message-ID: <c858817d3e3be246a1a2278e3b42d06284e615e5.1700766316.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Since commit b0563468eeac ("x86/CPU/AMD: Disable XSAVES on AMD family 0x17")
kernel unconditionally clears the XSAVES CPU feature bit on Zen1/2 CPUs.

Since KVM CPU caps are initialized from the kernel boot CPU features this
makes the XSAVES feature also unavailable for KVM guests in this case, even
though they might want to decide on their own whether they are affected by
this errata.

Allow KVM guests to make such decision by setting the XSAVES KVM CPU
capability bit based on the actual CPU capability.

This fixes booting Hyper-V enabled Windows Server 2016 VMs with more than
one vCPU on Zen1/2 CPUs.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 arch/x86/kvm/cpuid.c   | 16 ++++++++++++++++
 arch/x86/kvm/svm/svm.c |  5 ++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index dda6fc4cfae8..a8820460163a 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -679,6 +679,22 @@ void kvm_set_cpu_caps(void)
 		F(AMX_COMPLEX)
 	);
 
+	/*
+	 * It is possible that CPU supports XSAVES but the host kernel decided
+	 * not to use it, for example due to AMD Erratum 1386, and cleared the
+	 * relevant CPU feature bit.
+	 *
+	 * In such case let the guest decide on it own whether to make use of
+	 * this feature.
+	 */
+	if (boot_cpu_data.cpuid_level >= XSTATE_CPUID) {
+		unsigned int eax, ebx, ecx, edx;
+
+		cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
+		if (eax & F(XSAVES))
+			kvm_cpu_cap_set(X86_FEATURE_XSAVES);
+	}
+
 	kvm_cpu_cap_mask(CPUID_D_1_EAX,
 		F(XSAVEOPT) | F(XSAVEC) | F(XGETBV1) | F(XSAVES) | f_xfd
 	);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 712146312358..3cc36710eb21 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4306,9 +4306,12 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 * whether it's advertised to the guest so that KVM context switches
 	 * XSS on VM-Enter/VM-Exit.  Failure to do so would effectively give
 	 * the guest read/write access to the host's XSS.
+	 *
+	 * Make sure to check for XSAVES in KVM CPU capabilities, since the
+	 * boot CPU feature bit might be disabled due to Erratum 1386.
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVE) &&
-	    boot_cpu_has(X86_FEATURE_XSAVES) &&
+	    kvm_cpu_cap_has(X86_FEATURE_XSAVES) &&
 	    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE))
 		kvm_governed_feature_set(vcpu, X86_FEATURE_XSAVES);
 
