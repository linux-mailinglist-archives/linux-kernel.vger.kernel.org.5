Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571A475D7C3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 01:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGUXAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 19:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjGUXA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 19:00:27 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD5E3A9E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:00:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5704991ea05so25109677b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689980421; x=1690585221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=X/oIShHlu0RWHnSfFLoqzSAF9H1dCTHQouzdEN73lD8=;
        b=pwTqHKWTE0X3bdnmjOpODVldyzk1dIzpF7+/KwNuUcq64cH0kstCCEWs/DVZKzzEcQ
         UIYI4y3o0dgHuY00MGLBeSShDY9DK9C+Vfe4LhtztHr1nAl9wCZc6nU2bDk/liPtPPYx
         eAE7ePKu5VeqX1llGnUpHdkCH0Naz8m2VAO2fa1k9qT0yn88NXpzEGgopXRvGimnBP79
         cCyS3p/HCCNaTaVR6tDiHh7Jk/rUY4F9H9aVkv+jM+VqiQSGK7B7d2bMKDH9A9eDIub9
         sJnTzFf4aggrhXC+PkV0I/dQ1oj5ueL69wIDEM+TJnL9gSTW5M1DReAyvT+tQK2kt83X
         SGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689980421; x=1690585221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/oIShHlu0RWHnSfFLoqzSAF9H1dCTHQouzdEN73lD8=;
        b=ja9kvnyLJpeaxO+fXqeZtICdVHs0WNUtMP8bhMDTulDHVA1DSJ5o4OjULmRsav62EM
         RKLBUBN4YdN3IqIxrKcJH7cSa2f+FeO1hH2EzvVjzeq/fq3hQOASyRWYFaJ5nTOhLXas
         rHDN2RCuvE7jrQsfaZWGPaG8+ZwvkppyN67qPvG0vi5a1LoScqnbCW66AXuBLgsIZnAV
         h6S+lCce45ADJopLbJz2emOEr8Zg5AU/0OCHWUY7s5lgB4uEFcd0HYzGcdKwtak0uZmv
         Dl0EycuTvRjnPR6j4p38OjfIKCzNZDFs5RqL0xDabGT8nbJkghoG+C3Lrn6+ZkuRggQR
         IcAw==
X-Gm-Message-State: ABy/qLYJVhXLgFXm9OaQDfst2EgYJ87Zfp6Al5L2eGyazU8ai1iIKH3v
        mYJkv50Dx/r5qw8Y904HsMrWaZlEypg=
X-Google-Smtp-Source: APBJJlGsBQocGngXBpfZzLx0ZDqWk+ySytms2F+SQYW02DzFelMXdLlIMGbRjWpoaeOJ0cRSsCRm8yAEIk0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ae18:0:b0:577:4540:905a with SMTP id
 m24-20020a81ae18000000b005774540905amr12452ywh.7.1689980421153; Fri, 21 Jul
 2023 16:00:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 21 Jul 2023 16:00:03 -0700
In-Reply-To: <20230721230006.2337941-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230721230006.2337941-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230721230006.2337941-7-seanjc@google.com>
Subject: [PATCH v2 6/9] KVM: x86/mmu: Replace MMU_DEBUG with proper
 KVM_PROVE_MMU Kconfig
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>
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

Replace MMU_DEBUG, which requires manually modifying KVM to enable the
macro, with a proper Kconfig, KVM_PROVE_MMU.  Now that pgprintk() and
rmap_printk() are gone, i.e. the macro guards only KVM_MMU_WARN_ON() and
won't flood the kernel logs, enabling the option for debug kernels is both
desirable and feasible.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/Kconfig            | 13 +++++++++++++
 arch/x86/kvm/mmu/mmu.c          |  4 ++--
 arch/x86/kvm/mmu/mmu_internal.h |  4 +---
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 89ca7f4c1464..4e5a282cc518 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -138,6 +138,19 @@ config KVM_XEN
 
 	  If in doubt, say "N".
 
+config KVM_PROVE_MMU
+	bool "Prove KVM MMU correctness"
+	depends on DEBUG_KERNEL
+	depends on KVM
+	depends on EXPERT
+	help
+	  Enables runtime assertions in KVM's MMU that are too costly to enable
+	  in anything remotely resembling a production environment, e.g. this
+	  gates code that verifies a to-be-freed page table doesn't have any
+	  present SPTEs.
+
+	  If in doubt, say "N".
+
 config KVM_EXTERNAL_WRITE_TRACKING
 	bool
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index eb6af9c4cf14..933e48a73a9a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1693,7 +1693,7 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	return young;
 }
 
-#ifdef MMU_DEBUG
+#ifdef CONFIG_KVM_PROVE_MMU
 static int is_empty_shadow_page(u64 *spt)
 {
 	u64 *pos;
@@ -1707,7 +1707,7 @@ static int is_empty_shadow_page(u64 *spt)
 		}
 	return 1;
 }
-#endif
+#endif /* CONFIG_KVM_PROVE_MMU */
 
 /*
  * This value is the sum of all of the kvm instances's
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index cfe925fefa68..40e74db6a7d5 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -6,9 +6,7 @@
 #include <linux/kvm_host.h>
 #include <asm/kvm_host.h>
 
-#undef MMU_DEBUG
-
-#ifdef MMU_DEBUG
+#ifdef CONFIG_KVM_PROVE_MMU
 #define KVM_MMU_WARN_ON(x) WARN_ON_ONCE(x)
 #else
 #define KVM_MMU_WARN_ON(x) do { } while (0)
-- 
2.41.0.487.g6d72f3e995-goog

