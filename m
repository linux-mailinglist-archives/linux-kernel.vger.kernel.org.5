Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E445F7E86B9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344974AbjKJXzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjKJXzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:55:44 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B3B4212
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:55:41 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ae5b12227fso36794137b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699660541; x=1700265341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oLHGbgMEnF7UGu+6KnCI0TJhWQAK6x2mt0wz6s7ykc4=;
        b=dAzZU6CdykaoHdvYARoV6neDZVvw7hVI4xpMyWN7gM9IWzVKxO3zkFNR6kFkTQfyvq
         uk566WTmbyYGz1Ljxvqph6xCL+KLLH/6Pc5/OKOUonEk1sLodD1LwU2uYSTQ5Flm6Pax
         1bNebUib4UWKL6dqJSWIeUrkdmNToszAAbcGvmeOe7qwkRPgrMbXMeaAlRnsdlJDkJhL
         Klql/IVqWc3zUmXd1nYq1Mup4Yqi3CpqSofs379JcCLQPC+jGGvksi4SHbDJAVLErZ7u
         IeGMavAkJFGf9LtblTyFq5U4B5p+98N736XPDXISA0xIt1XnNF3xF31IqotaPcFuxpqf
         IMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699660541; x=1700265341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLHGbgMEnF7UGu+6KnCI0TJhWQAK6x2mt0wz6s7ykc4=;
        b=SiSVP4FREm1dA/knY5Cu7Xoxzyh02+rVIm8J2oYGINUBnmLtrPXVXKUBujv/e6wQK2
         KyVAydbmGHMbH3RpWCny3w1ESzPp0h7gmQNoOyC67ccxqrIMg/aoasBGLlOON8y9T/jj
         +piVesziSldt1aURwlsfCynrczfyyvLFu1RLjpiowu/7DBkECgOIhJFOjthNcG2+USPC
         DipeaB8JrjKf6tH71fzH5gGwSn9OoDInnJB5HD81zE5uL/M3mbq/v9sEdtNAh9GW94T4
         mLEe5fl0vHEtB9hOw4j3dLknNHe3FZ5c/l+OG0J6nPA7/MPIVNslyIH4+2GQaDMMUCca
         svBQ==
X-Gm-Message-State: AOJu0YxfTTulNO1RwhNS07H4Yt6Fk1vKOwK5ahslrTxfoHY6yyyYyrLR
        QcgHhrMwnKVjlQBVhcFGdEo2AxMlTnw=
X-Google-Smtp-Source: AGHT+IESTak3Kvc+5R2t9g4ghv/O+uX4mJqcQgiYQ6ovjTnEqtz6DMMF2xAoZX/ZzdZFBnD+aha49EHQq5I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:a18b:0:b0:5be:94a6:d84b with SMTP id
 y133-20020a81a18b000000b005be94a6d84bmr23544ywg.5.1699660540914; Fri, 10 Nov
 2023 15:55:40 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Nov 2023 15:55:23 -0800
In-Reply-To: <20231110235528.1561679-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110235528.1561679-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110235528.1561679-5-seanjc@google.com>
Subject: [PATCH 4/9] KVM: x86: Avoid double CPUID lookup when updating MWAIT
 at runtime
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the handling of X86_FEATURE_MWAIT during CPUID runtime updates to
utilize the lookup done for other CPUID.0x1 features.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 5cf3d697ecb3..6777780be6ae 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -276,6 +276,11 @@ static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_e
 
 		cpuid_entry_change(best, X86_FEATURE_APIC,
 			   vcpu->arch.apic_base & MSR_IA32_APICBASE_ENABLE);
+
+		if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT))
+			cpuid_entry_change(best, X86_FEATURE_MWAIT,
+					   vcpu->arch.ia32_misc_enable_msr &
+					   MSR_IA32_MISC_ENABLE_MWAIT);
 	}
 
 	best = cpuid_entry2_find(entries, nent, 7, 0);
@@ -296,14 +301,6 @@ static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_e
 	if (kvm_hlt_in_guest(vcpu->kvm) && best &&
 		(best->eax & (1 << KVM_FEATURE_PV_UNHALT)))
 		best->eax &= ~(1 << KVM_FEATURE_PV_UNHALT);
-
-	if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT)) {
-		best = cpuid_entry2_find(entries, nent, 0x1, KVM_CPUID_INDEX_NOT_SIGNIFICANT);
-		if (best)
-			cpuid_entry_change(best, X86_FEATURE_MWAIT,
-					   vcpu->arch.ia32_misc_enable_msr &
-					   MSR_IA32_MISC_ENABLE_MWAIT);
-	}
 }
 
 void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
-- 
2.42.0.869.gea05f2083d-goog

