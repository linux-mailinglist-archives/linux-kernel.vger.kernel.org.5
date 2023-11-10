Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDD37E86BF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345029AbjKJX4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345124AbjKJX4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:56:01 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D37478A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:55:52 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5af592fed43so34315317b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699660551; x=1700265351; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qmj7GZ0SAOjD/VDeZDIJ7y/K+3O78AzZdQ/afS++F9w=;
        b=pM6pVi7nJiH1VW2fSQVC2iEpCLiB96dBV6OwYdYlfpC2N1QxzswHcd8WlRbLywOM35
         ZU0cKFLTyFglKyY7QcsuxCqFncMlIlq5asWvP2HUd8dd5h84I3/LwsfLExd84Wno9ifx
         /Blllg4y8tlAFu+xRkz98CaCTVKwiVRyDDKYALTv7/8jrhNr5VljzjscK4BXghdqH9J+
         oPFovF+7+tk7V+J+BLwfVoU2hZkikHpOQ0gvgS+s2ADC+a3pXkriT4HbVv3FnAzJboAt
         86CprFHucIdFj9otwpL9vtfHniVtlbBZRP0K+ee98Pgxw4lrFai5q5lzuz/O1dGqn6QZ
         9kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699660551; x=1700265351;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmj7GZ0SAOjD/VDeZDIJ7y/K+3O78AzZdQ/afS++F9w=;
        b=NiIWleVGmSEMGdb0x2a6ESxsk2Xbgi23ZROy7jjRNdjcuZ3HyKNXaykxkaNczcaGon
         qDi4SO7b1e4K+QW2iV6B9jh0AJqllHTVlRKllKRf8T/qYgJjFqgSAXDwPwZDL74Gu3kg
         g08UXV1/o3WHCl5fj3P2wsDLkRNFgiAAjCV4VI2NBPYqIZ6OWbRxwFv0AQqFYSPbEf9a
         dNziKevsddkDxOKUXDcKVN2AgdyVAu/T2Uy+NXP0Zs8RQdQWXeIn6PyZrUmx7+40A5h2
         RcnKu6m1z0+kJN/YataoxoA0eajb2oHgGzOsYaj0zbUxdHyQzXBRXMuRM7qfO9w5Hr6b
         koCg==
X-Gm-Message-State: AOJu0Yy2vxphkLH5YwQskQhsjB8kuRAJKEfKstwTkRiv23dVhJaNS8x8
        W5+t8025dgH6+5VDKyrnJZiGC2Yn5xk=
X-Google-Smtp-Source: AGHT+IEjA1FyHv2eFtTBRxlVBGlSko6kQgtbPOhwvosPV9tjPhS4aG+DEOi3c1T1lz38zGocB/oAF1i7h7w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:914e:0:b0:5a7:db29:40e3 with SMTP id
 i75-20020a81914e000000b005a7db2940e3mr21020ywg.7.1699660551073; Fri, 10 Nov
 2023 15:55:51 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Nov 2023 15:55:28 -0800
In-Reply-To: <20231110235528.1561679-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110235528.1561679-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110235528.1561679-10-seanjc@google.com>
Subject: [PATCH 9/9] KVM: x86: Restrict XSAVE in cpu_caps based on KVM capabilities
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

Restrict XSAVE in guest cpu_caps so that XSAVES dependencies on XSAVE are
automatically handled instead of manually checking for host and guest
XSAVE support.  Aside from modifying XSAVE in cpu_caps, this should be a
glorified nop as KVM doesn't query guest XSAVE support (which is also why
it wasn't/isn't a bug to leave XSAVE set in guest CPUID).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 +-
 arch/x86/kvm/vmx/vmx.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 9e3a9191dac1..6fe2d7bf4959 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4315,8 +4315,8 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 * XSS on VM-Enter/VM-Exit.  Failure to do so would effectively give
 	 * the guest read/write access to the host's XSS.
 	 */
+	guest_cpu_cap_restrict(vcpu, X86_FEATURE_XSAVE);
 	guest_cpu_cap_change(vcpu, X86_FEATURE_XSAVES,
-			     boot_cpu_has(X86_FEATURE_XSAVE) &&
 			     boot_cpu_has(X86_FEATURE_XSAVES) &&
 			     guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVE));
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 815692dc0aff..7645945af5c5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7752,8 +7752,8 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 * to the guest.  XSAVES depends on CR4.OSXSAVE, and CR4.OSXSAVE can be
 	 * set if and only if XSAVE is supported.
 	 */
-	if (boot_cpu_has(X86_FEATURE_XSAVE) &&
-	    guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVE))
+	guest_cpu_cap_restrict(vcpu, X86_FEATURE_XSAVE);
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVE))
 		guest_cpu_cap_restrict(vcpu, X86_FEATURE_XSAVES);
 	else
 		guest_cpu_cap_clear(vcpu, X86_FEATURE_XSAVES);
-- 
2.42.0.869.gea05f2083d-goog

