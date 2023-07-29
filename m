Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76190767AA3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 03:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbjG2BRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 21:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbjG2BRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 21:17:13 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC3C44B1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:16:48 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bbd4f526caso20313835ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690593392; x=1691198192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/Va/MWC5DRY46k94Uc8qLWdNEj91Xq1TuiBAGty68F8=;
        b=yRqDe6hnQT3wYKRPtH+TorJeNAyO7rJdwfhdzAa8+zEHsyF8WvTsItjBPD+rKS0Bre
         AWLVyXBfQ54MW4JkJ0PV5hWRO1Fxd0rFnJdzJfj+6026Wy296jACG2ypQTWOPOTxnm58
         hc2QwMRTYw5zBjGNrKdbTgeJQRTl0AXfMn7T05nG5aiuEMzUZmIZWtCkP+omOr++FrxB
         L7ENLl09CAGiAgDkJr/jQ27vcqMUjXRP0JP7gCAc28Rd7+WWeW9u2YkmTg8Sqqf2cTBy
         D4BXD3n8j8znlME2TL5r/kHdBzikHOsATdn4giB+mgOwpVwUEiQ07zQ9RlC8q4nywObi
         deTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690593392; x=1691198192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Va/MWC5DRY46k94Uc8qLWdNEj91Xq1TuiBAGty68F8=;
        b=iw/avOnQfsE3oldf3I1QPI3gdaor0qYrJ4TLXfBmDHeF14/YylY/w/ju45HKdqHlCu
         Z1U542kKk9cvDo9AiCLl/TDIp/ZmiSfD8JFqAuPz48WyxZOBv6IAFki6nBrIt9MwLUuk
         xtfmWXkDNkMLADw6tTlO5Dz5SEYW0qgTMlsZLwXwH6CD4qQtcvgM7e9QUIpJjFxAMGdN
         E74aOK9G3VyNa2kPpuSLeO9nLv6nCuyC2oWtUVi3FAPKFW9luX+4Ak/Ytt/tvv3k22uB
         p1Lb2mnJclJGmbs3RJnLypsp2cr5K4HfoVReGqWV83CpO33S6ACtnfq8sQDVrOQiqmcF
         xUlA==
X-Gm-Message-State: ABy/qLbFNYZSunySjFFYeJl7R4h3pMgLgJUojwcjwjNoYUDzx5NbJ8MX
        sALeDjI9m+lhTJNzpKrOf9Ppm719XkE=
X-Google-Smtp-Source: APBJJlFQbjjv4j0eZ7yTd6o6d4NNrnwqwn3O3h5tAwnBDxSdxiPvphArnIx6zqIUmY01tf1nqT4wuZuZFt4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c409:b0:1b8:2055:fc1f with SMTP id
 k9-20020a170902c40900b001b82055fc1fmr12348plk.2.1690593392373; Fri, 28 Jul
 2023 18:16:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jul 2023 18:15:57 -0700
In-Reply-To: <20230729011608.1065019-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230729011608.1065019-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230729011608.1065019-11-seanjc@google.com>
Subject: [PATCH v2 10/21] KVM: VMX: Check KVM CPU caps, not just VMX MSR
 support, for XSAVE enabling
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check KVM CPU capabilities instead of raw VMX support for XSAVES when
determining whether or not XSAVER can/should be exposed to the guest.
Practically speaking, it's nonsensical/impossible for a CPU to support
"enable XSAVES" without XSAVES being supported natively.  The real
motivation for checking to kvm_cpu_cap_has() is to allow using the
governed feature's standard check-and-set logic.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 307d73749185..e358e3fa1ced 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7718,7 +7718,7 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 * to the guest.  XSAVES depends on CR4.OSXSAVE, and CR4.OSXSAVE can be
 	 * set if and only if XSAVE is supported.
 	 */
-	vcpu->arch.xsaves_enabled = cpu_has_vmx_xsaves() &&
+	vcpu->arch.xsaves_enabled = kvm_cpu_cap_has(X86_FEATURE_XSAVES) &&
 				    boot_cpu_has(X86_FEATURE_XSAVE) &&
 				    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
 				    guest_cpuid_has(vcpu, X86_FEATURE_XSAVES);
-- 
2.41.0.487.g6d72f3e995-goog

