Return-Path: <linux-kernel+bounces-165759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6258B90B7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2EF1F21F59
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6011649D2;
	Wed,  1 May 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="20M3j84O"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C695C17C6A
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596030; cv=none; b=sLDlKgC8X4DEVX0lm47IYkXwvqun3fF1Xo1dZVLD9I6WhADemCAVi9FJ8gWxrbZ1dMZxSEiQK2qFhqMRX74j5fVrXl/6Porh5YlUpt9KBspXqG50irTT9QzB3PtTcwpl1D/CGx3uwDP+F0La8/eLO7jIhLe3Zw1xgOM3jDv0P+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596030; c=relaxed/simple;
	bh=/AzTAlFYOZyP1Z6rVIGJkxs2GFf5RmhfZpm3TZuulJY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XxNwFZAjQF801rUEdR8EB1MU9fYUV53mTelgd78W5GuXKW8GWNFdoG0cs9Ilm0LyWclodK5Tyebbj9fhfTp+l9+l+LzqLLoa7SILs1yV+CIgi21mpbf37UiT1b5ArVLP63f26TkVhzAOlvSTIeT+M25V50hPsX5DX5fh0qpK4xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=20M3j84O; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bd64c9eadso66557107b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 13:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714596027; x=1715200827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ocZGRDwSRA0JErEaXo6J6ZFLNp2SZZV6No2MVqBh+RU=;
        b=20M3j84OINIVXaSnce3XZ2v0EoWCSRaQoU3neBkWTbrIJ7zTlRjd+61NFh/BNcCi7m
         a2ZWWD2oLlfYSzVcTEXvzmVN00/+nnApQjbFBmkoXjzKaKTNXD5ayikvk8U12PKqglMH
         bjK/UCgJF/ozGrM/xTp7xUDqbT0Q+OsrywvUL3eSG7yuZjYCrjar3NzlaBH59vC8L/yh
         CUnxZQQj4K9CuV/gg4DBa2Y8BKtHbQfPyciO5dS45Fp3cxRSM8kaWdIxJke5qcd9riA1
         swxFDjKG1N5vrD0w06kBv1RQ6JWV8atfoeLt7cxN6gN7BUYEbQ+SCbVnue4797LiVwz5
         eUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596027; x=1715200827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocZGRDwSRA0JErEaXo6J6ZFLNp2SZZV6No2MVqBh+RU=;
        b=IscYAmfoS1qdwA9tli/OLF1bwmvgH0iu3CBx5iCmaJltJzXL/8ZGb7TAHZ4P2DEj7S
         uYFeYeklN0WDMfDUSnNr3usyrtrHUDgzIRA8QsDxCOorHCQKtuNOLWZI7CztcJy9LkMe
         wqvZmPynTGgV+W3H8AhTT6Ca0Pw3yCxSA1ZhFoGpwe5d4JQyQ68v8Il2N7osSlMDyUD6
         zKFm/1aB8AHcfrtfzTCZ3NM1g4saxXknuUI9iHGkdu5KUkUqucumUzDRO1HWfgUnR1HL
         At9cpa4dmAOgyS0q4CiZegV6R3CCRcF11naHKGL8N3Cs1UKFbqF81QrQ4gGXZCO2oBGF
         F+9A==
X-Forwarded-Encrypted: i=1; AJvYcCVJWRIFa9UrLNFcMsEOKpaXEIE3Ogo9SQeYHU8jJm8yh7F3KsCo2F5FzK6t7f4y3VFbZ+yQxx6vI77BcfhMpAj9UZ4SYuYbENv2r3CL
X-Gm-Message-State: AOJu0YzEBz1rFwLYfoBZBiLfPye6r3qqghQs74x7yyEHclUnmXy5jsxy
	YJVP4r7tbVxIR5RjsloBrINHtteD9VHO6Fdz5HjDoXFTpT2Z4WL+0+91R++MslmjHmSuPG1TZ6I
	Vfw==
X-Google-Smtp-Source: AGHT+IF0X/E3JWdTyxCnsrqVP3nouBjTkZAU0SvCzTLrkZadu9iBGhLYkR7qpI5ByA84Kg9q14a4ayExcEg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d60e:0:b0:61b:e8a2:6f4b with SMTP id
 y14-20020a0dd60e000000b0061be8a26f4bmr1589ywd.1.1714596026913; Wed, 01 May
 2024 13:40:26 -0700 (PDT)
Date: Wed, 1 May 2024 13:40:25 -0700
In-Reply-To: <20240219074733.122080-11-weijiang.yang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219074733.122080-1-weijiang.yang@intel.com> <20240219074733.122080-11-weijiang.yang@intel.com>
Message-ID: <ZjKouS2ZyH7cXOqM@google.com>
Subject: Re: [PATCH v10 10/27] KVM: x86: Refine xsave-managed guest
 register/MSR reset handling
From: Sean Christopherson <seanjc@google.com>
To: Yang Weijiang <weijiang.yang@intel.com>
Cc: pbonzini@redhat.com, dave.hansen@intel.com, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	chao.gao@intel.com, rick.p.edgecombe@intel.com, mlevitsk@redhat.com, 
	john.allen@amd.com
Content-Type: text/plain; charset="us-ascii"

The shortlog is a bit stale now that it only deals with XSTATE.  This?

  KVM: x86: Zero XSTATE components on INIT by iterating over supported features

On Sun, Feb 18, 2024, Yang Weijiang wrote:
> Tweak the code a bit to facilitate resetting more xstate components in
> the future, e.g., CET's xstate-managed MSRs.
> 
> No functional change intended.
> 
> Suggested-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/x86.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 10847e1cc413..5a9c07751c0e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12217,11 +12217,27 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>  		static_branch_dec(&kvm_has_noapic_vcpu);
>  }
>  
> +#define XSTATE_NEED_RESET_MASK	(XFEATURE_MASK_BNDREGS | \
> +				 XFEATURE_MASK_BNDCSR)
> +
> +static bool kvm_vcpu_has_xstate(unsigned long xfeature)
> +{
> +	switch (xfeature) {
> +	case XFEATURE_MASK_BNDREGS:
> +	case XFEATURE_MASK_BNDCSR:
> +		return kvm_cpu_cap_has(X86_FEATURE_MPX);
> +	default:
> +		return false;
> +	}
> +}
> +
>  void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  {
>  	struct kvm_cpuid_entry2 *cpuid_0x1;
>  	unsigned long old_cr0 = kvm_read_cr0(vcpu);
> +	DECLARE_BITMAP(reset_mask, 64);

I vote to use a u64 instead of a bitmask.  The result cast isn't exactly pretty,
but it's not all that uncommon, and it's easy enough to make it "safe" by adding
BUILD_BUG_ON().

On the flip side, using the bitmap_*() APIs for super simple bitwise-OR/AND/TEST
operations makes the code harder to read.

>  	unsigned long new_cr0;
> +	unsigned int i;
>  
>  	/*
>  	 * Several of the "set" flows, e.g. ->set_cr0(), read other registers
> @@ -12274,7 +12290,12 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  	kvm_async_pf_hash_reset(vcpu);
>  	vcpu->arch.apf.halted = false;
>  
> -	if (vcpu->arch.guest_fpu.fpstate && kvm_mpx_supported()) {
> +	bitmap_from_u64(reset_mask, (kvm_caps.supported_xcr0 |
> +				     kvm_caps.supported_xss) &
> +				    XSTATE_NEED_RESET_MASK);
> +
> +	if (vcpu->arch.guest_fpu.fpstate &&
> +	    !bitmap_empty(reset_mask, XFEATURE_MAX)) {
>  		struct fpstate *fpstate = vcpu->arch.guest_fpu.fpstate;
>  
>  		/*
> @@ -12284,8 +12305,11 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  		if (init_event)
>  			kvm_put_guest_fpu(vcpu);
>  
> -		fpstate_clear_xstate_component(fpstate, XFEATURE_BNDREGS);
> -		fpstate_clear_xstate_component(fpstate, XFEATURE_BNDCSR);
> +		for_each_set_bit(i, reset_mask, XFEATURE_MAX) {
> +			if (!kvm_vcpu_has_xstate(i))
> +				continue;
> +			fpstate_clear_xstate_component(fpstate, i);
> +		}

A few intertwined thoughts:

 1. fpstate is zero allocated, and KVM absolutely relies on that, e.g. KVM doesn't
    manually zero out the XSAVE fields that are preserved on INIT, but zeroed on
    RESET.

 2. That means there is no need to manually clear XSTATE components during RESET,
    as KVM doesn't support standalone RESET, i.e. it's only cleared during vCPU
    creation, when guest FPU state is guaranteed to be '0'.

 3. That makes XSTATE_NEED_RESET_MASK a misnomer, as it's literally the !RESET
    path that is relevant.  E.g. it should be XSTATE_CLEAR_ON_INIT_MASK or so.

 4. If we add a helper, then XSTATE_NEED_RESET_MASK is probably unneeded.

So, what if we slot in the below (compile tested only) patch as prep work?  Then
this patch becomes:

---
 arch/x86/kvm/x86.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b441bf61b541..b00730353a28 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12220,6 +12220,8 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 static void kvm_xstate_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
 	struct fpstate *fpstate = vcpu->arch.guest_fpu.fpstate;
+	u64 xfeatures_mask;
+	int i;
 
 	/*
 	 * Guest FPU state is zero allocated and so doesn't need to be manually
@@ -12233,16 +12235,20 @@ static void kvm_xstate_reset(struct kvm_vcpu *vcpu, bool init_event)
 	 * are unchanged.  Currently, the only components that are zeroed and
 	 * supported by KVM are MPX related.
 	 */
-	if (!kvm_mpx_supported())
+	xfeatures_mask = (kvm_caps.supported_xcr0 | kvm_caps.supported_xss) &
+			 (XFEATURE_MASK_BNDREGS | XFEATURE_MASK_BNDCSR);
+	if (!xfeatures_mask)
 		return;
 
+	BUILD_BUG_ON(XFEATURE_MAX >= sizeof(xfeatures_mask));
+
 	/*
 	 * All paths that lead to INIT are required to load the guest's FPU
 	 * state (because most paths are buried in KVM_RUN).
 	 */
 	kvm_put_guest_fpu(vcpu);
-	fpstate_clear_xstate_component(fpstate, XFEATURE_BNDREGS);
-	fpstate_clear_xstate_component(fpstate, XFEATURE_BNDCSR);
+	for_each_set_bit(i, xfeatures_mask, XFEATURE_MAX)
+		fpstate_clear_xstate_component(fpstate, i);
 	kvm_load_guest_fpu(vcpu);
 }
 

base-commit: efca8b27900dfec160b6ba90820fa2ced81de904
-- 


and the final code looks like:


static void kvm_xstate_reset(struct kvm_vcpu *vcpu, bool init_event)
{
	struct fpstate *fpstate = vcpu->arch.guest_fpu.fpstate;
	u64 xfeatures_mask;
	int i;

	/*
	 * Guest FPU state is zero allocated and so doesn't need to be manually
	 * cleared on RESET, i.e. during vCPU creation.
	 */
	if (!init_event || !fpstate)
		return;

	/*
	 * On INIT, only select XSTATE components are zeroed, most compoments
	 * are unchanged.  Currently, the only components that are zeroed and
	 * supported by KVM are MPX and CET related.
	 */
	xfeatures_mask = (kvm_caps.supported_xcr0 | kvm_caps.supported_xss) &
			 (XFEATURE_MASK_BNDREGS | XFEATURE_MASK_BNDCSR |
			  XFEATURE_MASK_CET_USER | XFEATURE_MASK_CET_KERNEL);
	if (!xfeatures_mask)
		return;

	BUILD_BUG_ON(XFEATURE_MAX >= sizeof(xfeatures_mask) * BITS_PER_BYTE);

	/*
	 * All paths that lead to INIT are required to load the guest's FPU
	 * state (because most paths are buried in KVM_RUN).
	 */
	kvm_put_guest_fpu(vcpu);
	for_each_set_bit(i, (unsigned long *)&xfeatures_mask, XFEATURE_MAX)
		fpstate_clear_xstate_component(fpstate, i);
	kvm_load_guest_fpu(vcpu);
}


--
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 1 May 2024 12:12:31 -0700
Subject: [PATCH] KVM: x86: Manually clear MPX state only on INIT

Don't manually clear/zero MPX state on RESET, as the guest FPU state is
zero allocated and KVM only does RESET during vCPU creation, i.e. the
relevant state is guaranteed to be all zeroes.

Opportunistically move the relevant code into a helper in anticipation of
adding support for CET shadow stacks, which also has state that is zeroed
on INIT.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 10847e1cc413..b441bf61b541 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12217,6 +12217,35 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 		static_branch_dec(&kvm_has_noapic_vcpu);
 }
 
+static void kvm_xstate_reset(struct kvm_vcpu *vcpu, bool init_event)
+{
+	struct fpstate *fpstate = vcpu->arch.guest_fpu.fpstate;
+
+	/*
+	 * Guest FPU state is zero allocated and so doesn't need to be manually
+	 * cleared on RESET, i.e. during vCPU creation.
+	 */
+	if (!init_event || !fpstate)
+		return;
+
+	/*
+	 * On INIT, only select XSTATE components are zeroed, most compoments
+	 * are unchanged.  Currently, the only components that are zeroed and
+	 * supported by KVM are MPX related.
+	 */
+	if (!kvm_mpx_supported())
+		return;
+
+	/*
+	 * All paths that lead to INIT are required to load the guest's FPU
+	 * state (because most paths are buried in KVM_RUN).
+	 */
+	kvm_put_guest_fpu(vcpu);
+	fpstate_clear_xstate_component(fpstate, XFEATURE_BNDREGS);
+	fpstate_clear_xstate_component(fpstate, XFEATURE_BNDCSR);
+	kvm_load_guest_fpu(vcpu);
+}
+
 void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
 	struct kvm_cpuid_entry2 *cpuid_0x1;
@@ -12274,22 +12303,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	kvm_async_pf_hash_reset(vcpu);
 	vcpu->arch.apf.halted = false;
 
-	if (vcpu->arch.guest_fpu.fpstate && kvm_mpx_supported()) {
-		struct fpstate *fpstate = vcpu->arch.guest_fpu.fpstate;
-
-		/*
-		 * All paths that lead to INIT are required to load the guest's
-		 * FPU state (because most paths are buried in KVM_RUN).
-		 */
-		if (init_event)
-			kvm_put_guest_fpu(vcpu);
-
-		fpstate_clear_xstate_component(fpstate, XFEATURE_BNDREGS);
-		fpstate_clear_xstate_component(fpstate, XFEATURE_BNDCSR);
-
-		if (init_event)
-			kvm_load_guest_fpu(vcpu);
-	}
+	kvm_xstate_reset(vcpu, init_event);
 
 	if (!init_event) {
 		vcpu->arch.smbase = 0x30000;

base-commit: 1a89965fa9dae1ae04f44679860ef6bc008c2003
-- 

