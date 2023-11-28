Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692A87FAF8B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 02:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjK1Bao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 20:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbjK1Baj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 20:30:39 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EA910CB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 17:30:44 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6cbca33ad5dso5095827b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 17:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701135044; x=1701739844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hp+Xb5HTxQd+WcWBC6dkBQcOYD3I4yHM6D8m4FcFzBE=;
        b=Vu8ZF9EQdDBSSJLr1XGzVfeFOsVXR/sTDSd10y/vXjA/XRm+rAg9M0KIY8xTPEgeF/
         l+LPK0i3igOjKwwpbN1WUoEpgoiXaQD8KdgVQ3f2vC5xJ6P9y0iJpgrd81NS4F/0tpdt
         lTH0EYLA7tXrPGpHLkoFc8BhVkakwAFpv9IU6FOK+ndD2sI4G1gMgSveRW1oRxscCd/6
         Mimphh9twOEakq/JszInP3Qmf09twbabSL/OznnnYawIc3ua3Ldgv81Fcrcc2Bye+UVk
         xZHfMUBxJjbscUbQggFIGJsJZkjlH3rmn4Ly4YlZND5bwkYz67poOzRTIdxVnoORp/AY
         5abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701135044; x=1701739844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hp+Xb5HTxQd+WcWBC6dkBQcOYD3I4yHM6D8m4FcFzBE=;
        b=FDCT2CCFopN8n0HcldiWc7GCh+lpK21WheHkCbLFPmVpUqkAGQgLDLsfCfN2oTfTba
         Rw+OmCO/9sdHb60UAqaBdq0ttp+6O9YjE2ZN8L+MNSi6pzfRqhtkKjsDcXEDeBZT0wlV
         U8duGc6QMBWx503one76vE6mFtpYChT9hyRfaSSf7I6xxlhRkhvAFlsoUCSyMkru+rjr
         t79aIPHX5o6jyBzZNNKDh9A/kEzkD36xgmSUvRjGKUQ6Z/QMoWvTnmFnGZjzLfxyeQD/
         AV1e+xjhZfZSNAS5UHaAqI5SDDEts8Bw4CEKUe3KUKgi7aPibk4dc3SKgXjzw0mP/z2v
         t0dw==
X-Gm-Message-State: AOJu0YxmbQmEQ6RFg7ok4lFNtQXiCiAn5ay7Mstm+wYEdxOwQUeJ3YrR
        20pYf0fEKjDRVemCX9f3/BicNbvpEXo=
X-Google-Smtp-Source: AGHT+IGqps34qbiD8dT8XbU3sbfmDNfirA7ng9g5HxgIXN7W8/L333ci2ftO2zEibWRwK+DT9E7rcPqFK+E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:3a12:b0:692:c216:8830 with SMTP id
 fj18-20020a056a003a1200b00692c2168830mr3697668pfb.0.1701135044007; Mon, 27
 Nov 2023 17:30:44 -0800 (PST)
Date:   Mon, 27 Nov 2023 17:30:42 -0800
In-Reply-To: <20231123075818.12521-1-likexu@tencent.com>
Mime-Version: 1.0
References: <20231123075818.12521-1-likexu@tencent.com>
Message-ID: <ZWVCwvoETD_NVOFG@google.com>
Subject: Re: [PATCH] KVM: x86: Use get_cpl directly in case of vcpu_load to
 improve accuracy
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023, Like Xu wrote:
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  arch/x86/kvm/x86.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 2c924075f6f1..c454df904a45 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -13031,7 +13031,10 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
>  	if (vcpu->arch.guest_state_protected)
>  		return true;
>  
> -	return vcpu->arch.preempted_in_kernel;
> +	if (vcpu != kvm_get_running_vcpu())
> +		return vcpu->arch.preempted_in_kernel;

Eww, KVM really shouldn't be reading vcpu->arch.preempted_in_kernel in a generic
vcpu_in_kernel() API. 

Rather than fudge around that ugliness with a kvm_get_running_vcpu() check, what
if we instead repurpose kvm_arch_dy_has_pending_interrupt(), which is effectively
x86 specific, to deal with not being able to read the current CPL for a vCPU that
is (possibly) not "loaded", which AFAICT is also x86 specific (or rather, Intel/VMX
specific).

And if getting the CPL for a vCPU that may not be loaded is problematic for other
architectures, then I think the correct fix is to move preempted_in_kernel into
common code and check it directly in kvm_vcpu_on_spin().

This is what I'm thinking:

---
 arch/x86/kvm/x86.c       | 22 +++++++++++++++-------
 include/linux/kvm_host.h |  2 +-
 virt/kvm/kvm_main.c      |  7 +++----
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6d0772b47041..5c1a75c0dafe 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13022,13 +13022,21 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 	return kvm_vcpu_running(vcpu) || kvm_vcpu_has_events(vcpu);
 }
 
-bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu)
+static bool kvm_dy_has_pending_interrupt(struct kvm_vcpu *vcpu)
 {
-	if (kvm_vcpu_apicv_active(vcpu) &&
-	    static_call(kvm_x86_dy_apicv_has_pending_interrupt)(vcpu))
-		return true;
+	return kvm_vcpu_apicv_active(vcpu) &&
+	       static_call(kvm_x86_dy_apicv_has_pending_interrupt)(vcpu);
+}
 
-	return false;
+bool kvm_arch_vcpu_preempted_in_kernel(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Treat the vCPU as being in-kernel if it has a pending interrupt, as
+	 * the vCPU trying to yield may be spinning on IPI delivery, i.e. the
+	 * the target vCPU is in-kernel for the purposes of directed yield.
+	 */
+	return vcpu->arch.preempted_in_kernel ||
+	       kvm_dy_has_pending_interrupt(vcpu);
 }
 
 bool kvm_arch_dy_runnable(struct kvm_vcpu *vcpu)
@@ -13043,7 +13051,7 @@ bool kvm_arch_dy_runnable(struct kvm_vcpu *vcpu)
 		 kvm_test_request(KVM_REQ_EVENT, vcpu))
 		return true;
 
-	return kvm_arch_dy_has_pending_interrupt(vcpu);
+	return kvm_dy_has_pending_interrupt(vcpu);
 }
 
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
@@ -13051,7 +13059,7 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.guest_state_protected)
 		return true;
 
-	return vcpu->arch.preempted_in_kernel;
+	return static_call(kvm_x86_get_cpl)(vcpu);
 }
 
 unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ea1523a7b83a..820c5b64230f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1505,7 +1505,7 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu);
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu);
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu);
 bool kvm_arch_dy_runnable(struct kvm_vcpu *vcpu);
-bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu);
+bool kvm_arch_vcpu_preempted_in_kernel(struct kvm_vcpu *vcpu);
 int kvm_arch_post_init_vm(struct kvm *kvm);
 void kvm_arch_pre_destroy_vm(struct kvm *kvm);
 int kvm_arch_create_vm_debugfs(struct kvm *kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8758cb799e18..e84be7e2e05e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4049,9 +4049,9 @@ static bool vcpu_dy_runnable(struct kvm_vcpu *vcpu)
 	return false;
 }
 
-bool __weak kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu)
+bool __weak kvm_arch_vcpu_preempted_in_kernel(struct kvm_vcpu *vcpu)
 {
-	return false;
+	return kvm_arch_vcpu_in_kernel(vcpu);
 }
 
 void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
@@ -4086,8 +4086,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 			if (kvm_vcpu_is_blocking(vcpu) && !vcpu_dy_runnable(vcpu))
 				continue;
 			if (READ_ONCE(vcpu->preempted) && yield_to_kernel_mode &&
-			    !kvm_arch_dy_has_pending_interrupt(vcpu) &&
-			    !kvm_arch_vcpu_in_kernel(vcpu))
+			    kvm_arch_vcpu_preempted_in_kernel(vcpu))
 				continue;
 			if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
 				continue;

base-commit: e9e60c82fe391d04db55a91c733df4a017c28b2f
-- 

