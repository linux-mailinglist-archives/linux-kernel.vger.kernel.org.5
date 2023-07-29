Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1851767A9E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 03:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbjG2BQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 21:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbjG2BQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 21:16:42 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5273F4EDA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:16:31 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583f048985bso29330407b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690593390; x=1691198190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=dha0R9DASOGG7XsDxaLGGX3ibqnbBc/BGtiYIStTeKk=;
        b=R3Co0mWiKnMv23E+s2+bqRdZmHQ84c/0b2b0fBo6EJQu6wPbygTYbxo36RI0+IgysS
         XDCFUpUFfWR+ehZJdSP1sSsQQ9o3WOEV2VplPcfel3Ge0mrZ7/rRUgtg0mGGWpuk13bp
         xfpe9jYKGXATKIbGI1hcpa59d19+f3EeNTKaIxoidXs9dYUzDY55tDOFOu/O7QyxycyU
         grN9DnbNhrA+O05bNUzvKfg77yWa464N+cFEO0gvI7NSnuVmeOezegM5mUJyeYF6ioP/
         yksWReHMBzO/z9PT19qKsWocLXdvMQ0NUXoNe7RDBZd6t5rF0HgB/41Nmvvda1pWzJEt
         8aZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690593390; x=1691198190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dha0R9DASOGG7XsDxaLGGX3ibqnbBc/BGtiYIStTeKk=;
        b=iNvV4n1dyw4JqOZWOjFYNzWynuRGpzWyToclMzLJeZ68Vn1/XbarnpqupyaXqSaBxa
         huuNdIlaGbjgoM1krZynDIDJDkr26fBHU/psaWnDk9bJ0jTgenqHnj0ztQmUirNwahJA
         +Eo8GgrI02fopYTzBikJv8nqjNIVwSNU4Odl/Y8xsuJ575KBOaOYSiCOr7OlBRSOUpXD
         QgSjoxcgt9jM2kjbRcKPn7S3LfZeJ7PnyQIPFUnU3bRbLCGGIXir9y32Y7y1q8i6Hasa
         mPSQgeej/Lk38G1HMG0WQF3NllI+Jpd0E+RJd8HSrujAoK4htli5ZgDj4/gGvtkz3o+X
         DrbA==
X-Gm-Message-State: ABy/qLZn4ylD0NazZm32ZjDCWa2Fp+gHU93/o08i0YsKAfnX4INz5s1O
        i9D6a6Rg7PLdmjibcN1IyNkpX2/hM88=
X-Google-Smtp-Source: APBJJlEGQMMVjnj7NPVOTcIR9PA0hrdPRQ5dUv8FmgzbAmnbcIC8v/BGIjyYqfdJwtH6n+7jy0APZwofMcI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:a784:0:b0:577:d5b:7ce3 with SMTP id
 e126-20020a81a784000000b005770d5b7ce3mr27415ywh.9.1690593390450; Fri, 28 Jul
 2023 18:16:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jul 2023 18:15:56 -0700
In-Reply-To: <20230729011608.1065019-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230729011608.1065019-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230729011608.1065019-10-seanjc@google.com>
Subject: [PATCH v2 09/21] KVM: VMX: Recompute "XSAVES enabled" only after
 CPUID update
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

Recompute whether or not XSAVES is enabled for the guest only if the
guest's CPUID model changes instead of redoing the computation every time
KVM generates vmcs01's secondary execution controls.  The boot_cpu_has()
and cpu_has_vmx_xsaves() checks should never change after KVM is loaded,
and if they do the kernel/KVM is hosed.

Opportunistically add a comment explaining _why_ XSAVES is effectively
exposed to the guest if and only if XSAVE is also exposed to the guest.

Practically speaking, no functional change intended (KVM will do fewer
computations, but should still get the see the same xsaves_enabled value
whenever KVM looks at it).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ca6194b0e35e..307d73749185 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4587,19 +4587,10 @@ static u32 vmx_secondary_exec_control(struct vcpu_vmx *vmx)
 	if (!enable_pml || !atomic_read(&vcpu->kvm->nr_memslots_dirty_logging))
 		exec_control &= ~SECONDARY_EXEC_ENABLE_PML;
 
-	if (cpu_has_vmx_xsaves()) {
-		/* Exposing XSAVES only when XSAVE is exposed */
-		bool xsaves_enabled =
-			boot_cpu_has(X86_FEATURE_XSAVE) &&
-			guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
-			guest_cpuid_has(vcpu, X86_FEATURE_XSAVES);
-
-		vcpu->arch.xsaves_enabled = xsaves_enabled;
-
+	if (cpu_has_vmx_xsaves())
 		vmx_adjust_secondary_exec_control(vmx, &exec_control,
 						  SECONDARY_EXEC_XSAVES,
-						  xsaves_enabled, false);
-	}
+						  vcpu->arch.xsaves_enabled, false);
 
 	/*
 	 * RDPID is also gated by ENABLE_RDTSCP, turn on the control if either
@@ -7722,8 +7713,15 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	/* xsaves_enabled is recomputed in vmx_compute_secondary_exec_control(). */
-	vcpu->arch.xsaves_enabled = false;
+	/*
+	 * XSAVES is effectively enabled if and only if XSAVE is also exposed
+	 * to the guest.  XSAVES depends on CR4.OSXSAVE, and CR4.OSXSAVE can be
+	 * set if and only if XSAVE is supported.
+	 */
+	vcpu->arch.xsaves_enabled = cpu_has_vmx_xsaves() &&
+				    boot_cpu_has(X86_FEATURE_XSAVE) &&
+				    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
+				    guest_cpuid_has(vcpu, X86_FEATURE_XSAVES);
 
 	vmx_setup_uret_msrs(vmx);
 
-- 
2.41.0.487.g6d72f3e995-goog

