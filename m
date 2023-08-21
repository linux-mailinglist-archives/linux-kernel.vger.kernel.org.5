Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B37782115
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjHUBTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjHUBTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:19:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51D8A0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:19:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7719C62600
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EF5C433C7;
        Mon, 21 Aug 2023 01:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692580768;
        bh=DW3Rkm64vuwtwMBbIqCA2GpSEy3gnsoalKuEuFJJaWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rXszqG9hnuzM5B5aORpcJM5tFbtP47DwlBt7MX4jqQcPs1Vi0T7hd151utynjdkf8
         P+TF4obMZ7dlEgLmkl5eh+zDf/ySNWvOmoCauwHrJ0ZL55i9Yo8xLvzsEpdO32RY/k
         oCzenoJe+M77+MIVT+m0McZil227wB+kjSqQZGne3I93oqWuqan16w2/9jHwf5kiFP
         Wj9oK3wXDHuL/QDHs+9XXwhs1az1c+HWXtojP8LXX2tjNk7ISgBBYTPiHX3U0wgdt6
         HrxwmiIqoesxLDA942+qurp0XondanfqJTFPyad0g1WH5FRMBsRHyM6IEejydodvVl
         bcW9O0sdSQ5iw==
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
Subject: [PATCH 03/22] KVM: x86: Support IBPB_BRTYPE and SBPB
Date:   Sun, 20 Aug 2023 18:19:00 -0700
Message-ID: <a4d62162bcb501e50b0bb19b748702aa12260615.1692580085.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692580085.git.jpoimboe@kernel.org>
References: <cover.1692580085.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IBPB_BRTYPE and SBPB CPUID bits aren't set by HW.

From the AMD SRSO whitepaper:

  "Hypervisor software should synthesize the value of both the
  IBPB_BRTYPE and SBPB CPUID bits on these platforms for use by guest
  software."

These bits are already set during kernel boot.  Manually propagate them
to the guest.

Also, propagate PRED_CMD_SBPB writes.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kvm/cpuid.c | 4 ++++
 arch/x86/kvm/x86.c   | 9 +++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index d3432687c9e6..cdf703eec42d 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -729,6 +729,10 @@ void kvm_set_cpu_caps(void)
 		F(NULL_SEL_CLR_BASE) | F(AUTOIBRS) | 0 /* PrefetchCtlMsr */
 	);
 
+	if (cpu_feature_enabled(X86_FEATURE_SBPB))
+		kvm_cpu_cap_set(X86_FEATURE_SBPB);
+	if (cpu_feature_enabled(X86_FEATURE_IBPB_BRTYPE))
+		kvm_cpu_cap_set(X86_FEATURE_IBPB_BRTYPE);
 	if (cpu_feature_enabled(X86_FEATURE_SRSO_NO))
 		kvm_cpu_cap_set(X86_FEATURE_SRSO_NO);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c381770bcbf1..dd7472121142 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3676,12 +3676,13 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!msr_info->host_initiated && !guest_has_pred_cmd_msr(vcpu))
 			return 1;
 
-		if (!boot_cpu_has(X86_FEATURE_IBPB) || (data & ~PRED_CMD_IBPB))
+		if (boot_cpu_has(X86_FEATURE_IBPB) && data == PRED_CMD_IBPB)
+			wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
+		else if (boot_cpu_has(X86_FEATURE_SBPB) && data == PRED_CMD_SBPB)
+			wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_SBPB);
+		else if (data)
 			return 1;
-		if (!data)
-			break;
 
-		wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
 		break;
 	case MSR_IA32_FLUSH_CMD:
 		if (!msr_info->host_initiated &&
-- 
2.41.0

