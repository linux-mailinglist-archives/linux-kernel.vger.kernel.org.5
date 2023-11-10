Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807717E86BD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344894AbjKJX4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbjKJXz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:55:59 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583F346A8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:55:48 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-daee86e2d70so2875964276.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699660547; x=1700265347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UULTl/CyX49jqhiU5nSfvUmNnB7m6080sqG/jitSL4w=;
        b=HkEaraVMU8Q1Xv6qlJMKTXr3R1QZdSZDUhjMTeXdlphPZBIvOABKFefoexphcPV207
         9zudU26QRzrrBbtmlGKdI+JM6D06F7Y+bvKH5yqhuE7vBYzfBtuMxgj0w2mxL9R/0crL
         cc6OKPxeYSOb4Z/BC22uLZWRNMRrDYTDxMsO+BPAoJcKdlZnxRP+wRFofkpg0PAyom1U
         rC43d7XjW/6He/+pdX+J9CrJeev5+3YerO020Ywg7q3l9VVbFStsvnGv/xf+lQhd0jE3
         J3RNw+FtKfEDxhudsIsTpiNzCI5zDYqtza1WJRUvzDcZTIJn4CikRmWCKlHAgv5TLGZW
         Ht7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699660547; x=1700265347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UULTl/CyX49jqhiU5nSfvUmNnB7m6080sqG/jitSL4w=;
        b=Vpv2F2zaDT8PhNl0dG5J4bqCZEt+K8ya20oQZLqj5UTmo9HkYpnCT53H5hsL7VLwCz
         hyY+I54jVviy8ZxbdYfgRKGAVeH5dorXI2Do+RYljBquD+ZTHk0/a6ElN6rrMsnpcJWw
         XuZGpQx8Qd27gbt8t3A2Ydufmay9X79wgOtlMKZEq0g719w6SYPJ642U8w/6HQZkJvMu
         EX/39wl037ieOxIjiHu06UfHzEbQhji/YclElO/rGrM3oNcqFiPX5BWqNCmC8mtcCwLE
         /5PXf+LYdryGy1omUTqXCJyYGajofQUiaaWRpIufkgoKhkq54y62k80RVEs+85I2u0Qh
         XAHg==
X-Gm-Message-State: AOJu0YzvkRvwCz2VJ0E31kcr8HZMkdKdnYJysUTG0N8+KCwqD7iPCQTM
        ka2HzOx6izaSn7Q3XnUOfQkj08PKdcU=
X-Google-Smtp-Source: AGHT+IEmMZEklqzEl46skV0jCyEKXRJqMj1H5jtFG7Z2uM2pVcO1WJh448Dutk6lRZZB//FZxGGR0+c/Kxk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:aba7:0:b0:dae:292e:68de with SMTP id
 v36-20020a25aba7000000b00dae292e68demr16244ybi.6.1699660547065; Fri, 10 Nov
 2023 15:55:47 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Nov 2023 15:55:26 -0800
In-Reply-To: <20231110235528.1561679-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110235528.1561679-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110235528.1561679-8-seanjc@google.com>
Subject: [PATCH 7/9] KVM: x86: Shuffle code to prepare for dropping guest_cpuid_has()
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

Move the implementations of guest_has_{spec_ctrl,pred_cmd}_msr() down
below guest_cpu_cap_has() so that their use of guest_cpuid_has() can be
replaced with calls to guest_cpu_cap_has().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 1707ef10b269..bebf94a69630 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -163,21 +163,6 @@ static inline int guest_cpuid_stepping(struct kvm_vcpu *vcpu)
 	return x86_stepping(best->eax);
 }
 
-static inline bool guest_has_spec_ctrl_msr(struct kvm_vcpu *vcpu)
-{
-	return (guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) ||
-		guest_cpuid_has(vcpu, X86_FEATURE_AMD_STIBP) ||
-		guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) ||
-		guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD));
-}
-
-static inline bool guest_has_pred_cmd_msr(struct kvm_vcpu *vcpu)
-{
-	return (guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) ||
-		guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBPB) ||
-		guest_cpuid_has(vcpu, X86_FEATURE_SBPB));
-}
-
 static inline bool supports_cpuid_fault(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.msr_platform_info & MSR_PLATFORM_INFO_CPUID_FAULT;
@@ -298,4 +283,19 @@ static __always_inline bool guest_cpu_cap_has(struct kvm_vcpu *vcpu,
 	return vcpu->arch.cpu_caps[x86_leaf] & __feature_bit(x86_feature);
 }
 
+static inline bool guest_has_spec_ctrl_msr(struct kvm_vcpu *vcpu)
+{
+	return (guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) ||
+		guest_cpuid_has(vcpu, X86_FEATURE_AMD_STIBP) ||
+		guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) ||
+		guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD));
+}
+
+static inline bool guest_has_pred_cmd_msr(struct kvm_vcpu *vcpu)
+{
+	return (guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) ||
+		guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBPB) ||
+		guest_cpuid_has(vcpu, X86_FEATURE_SBPB));
+}
+
 #endif
-- 
2.42.0.869.gea05f2083d-goog

