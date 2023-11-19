Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FF37F0817
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 18:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjKSRdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 12:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjKSRdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 12:33:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE418115
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700415177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B6yst7CdKWMVhtcxh80M3CuEYdtCNK6UjowCaejfFpo=;
        b=UzAEUz0qPbKd10Zogs+oagGd83p42LRfpcZxEV+7J2sxpLqxbpJMf836G73klNfmWt2G2f
        Y7zCb/ZDq0ulR7kT9QmLqK/FR95grriqoqkISXnxAcZKgaxFKbYcALtmf5QIv7aTX8mG9H
        7cQdsUpRTtJvZsRY6fnJ2osP8fSLoxQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-MA9-kNFZPWSWxr9kIcb_kQ-1; Sun, 19 Nov 2023 12:32:55 -0500
X-MC-Unique: MA9-kNFZPWSWxr9kIcb_kQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40a4c765d3bso7078595e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700415174; x=1701019974;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B6yst7CdKWMVhtcxh80M3CuEYdtCNK6UjowCaejfFpo=;
        b=IXQkQN03dq/iTONUJvCnwd6HQ4Dczl8+WAiddHkyd+DaTMq591VCepSQiYVR3MIyKS
         RfxC1HP+HoM9qOU5GO2O/YS08XcERhsV7UV/GXBeWNvjXrlMahpp1EOwVi+tslVeVeE/
         6hMsm/YJ80d4HX7ptbcoYwSDMdKJJLg1vY0a9LlvdxDjkIT9LHDvbWeJxBllr2wOw0D1
         7rPF6KpRIevuFIH3mo7VDz2tmInMiqbHKCBpdaVmogcGmGiKd3HHIa4e25dZz5s6i4E9
         nB+betygUq+yT7bQG6JwZxBqFgksPG/f0FAaGdK2Hg2TQ64wQtU7S63zp6GJvaS6w8u3
         pClg==
X-Gm-Message-State: AOJu0Yyhz5gG4tC19NP9x7v1yBJbt9tpQpZRsGAtnQyLfCkik7PBBtlv
        VEBrOZz/itMENhbGhrp/61NIVNOkFIw3MEhz/hmN/OidEg9DGjcrcrmBpJ5VVlfDZ5D1/5UbKTl
        lg/84Cmq7eWIsPMO1QWXQ57bu
X-Received: by 2002:a05:600c:1d18:b0:403:c70b:b688 with SMTP id l24-20020a05600c1d1800b00403c70bb688mr4080236wms.6.1700415174139;
        Sun, 19 Nov 2023 09:32:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsWRkSqBUE5SR4P6sqN9+Q2iYh3Cbu9bqqZIk6ULtdcguL5X6mSwh4KZnFj7PTyGiTa6eXhQ==
X-Received: by 2002:a05:600c:1d18:b0:403:c70b:b688 with SMTP id l24-20020a05600c1d1800b00403c70bb688mr4080224wms.6.1700415173707;
        Sun, 19 Nov 2023 09:32:53 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b004068e09a70bsm10632965wmq.31.2023.11.19.09.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 09:32:53 -0800 (PST)
Message-ID: <3ad69657ba8e1b19d150db574193619cf0cb34df.camel@redhat.com>
Subject: Re: [PATCH 3/9] KVM: x86: Initialize guest cpu_caps based on guest
 CPUID
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 19 Nov 2023 19:32:51 +0200
In-Reply-To: <20231110235528.1561679-4-seanjc@google.com>
References: <20231110235528.1561679-1-seanjc@google.com>
         <20231110235528.1561679-4-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-10 at 15:55 -0800, Sean Christopherson wrote:
> Initialize a vCPU's capabilities based on the guest CPUID provided by
> userspace instead of simply zeroing the entire array.  This will allow
> using cpu_caps to query *all* CPUID-based guest capabilities, i.e. will
> allow converting all usage of guest_cpuid_has() to guest_cpu_cap_has().
> 
> Zeroing the array was the logical choice when using cpu_caps was opt-in,
> e.g. "unsupported" was generally a safer default, and the whole point of
> governed features is that KVM would need to check host and guest support,
> i.e. making everything unsupported by default didn't require more code.
> 
> But requiring KVM to manually "enable" every CPUID-based feature in
> cpu_caps would require an absurd amount of boilerplate code.
> 
> Follow existing CPUID/kvm_cpu_caps nomenclature where possible, e.g. for
> the change() and clear() APIs.  Replace check_and_set() with restrict() to
> try and capture that KVM is restricting userspace's desired guest feature
> set based on KVM's capabilities.
> 
> This is intended to be gigantic nop, i.e. should not have any impact on
> guest or KVM functionality.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c   | 43 +++++++++++++++++++++++++++++++++++++++---
>  arch/x86/kvm/cpuid.h   | 25 +++++++++++++++++++++---
>  arch/x86/kvm/svm/svm.c | 24 +++++++++++------------
>  arch/x86/kvm/vmx/vmx.c |  6 ++++--
>  4 files changed, 78 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 4bf3c2d4dc7c..5cf3d697ecb3 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -321,13 +321,51 @@ static bool kvm_cpuid_has_hyperv(struct kvm_cpuid_entry2 *entries, int nent)
>  	return entry && entry->eax == HYPERV_CPUID_SIGNATURE_EAX;
>  }
>  
> +/*
> + * This isn't truly "unsafe", but all callers except kvm_cpu_after_set_cpuid()
> + * should use __cpuid_entry_get_reg(), which provides compile-time validation
> + * of the input.
> + */
> +static u32 cpuid_get_reg_unsafe(struct kvm_cpuid_entry2 *entry, u32 reg)
> +{
> +	switch (reg) {
> +	case CPUID_EAX:
> +		return entry->eax;
> +	case CPUID_EBX:
> +		return entry->ebx;
> +	case CPUID_ECX:
> +		return entry->ecx;
> +	case CPUID_EDX:
> +		return entry->edx;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return 0;
> +	}
> +}



> +
>  static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_lapic *apic = vcpu->arch.apic;
>  	struct kvm_cpuid_entry2 *best;
>  	bool allow_gbpages;
> +	int i;
>  
> -	memset(vcpu->arch.cpu_caps, 0, sizeof(vcpu->arch.cpu_caps));
> +	BUILD_BUG_ON(ARRAY_SIZE(reverse_cpuid) != NR_KVM_CPU_CAPS);
> +
> +	/*
> +	 * Reset guest capabilities to userspace's guest CPUID definition, i.e.
> +	 * honor userspace's definition for features that don't require KVM or
> +	 * hardware management/support (or that KVM simply doesn't care about).
> +	 */
> +	for (i = 0; i < NR_KVM_CPU_CAPS; i++) {
> +		const struct cpuid_reg cpuid = reverse_cpuid[i];
> +
> +		best = kvm_find_cpuid_entry_index(vcpu, cpuid.function, cpuid.index);
> +		if (best)
> +			vcpu->arch.cpu_caps[i] = cpuid_get_reg_unsafe(best, cpuid.reg);

Why not just use __cpuid_entry_get_reg? 

cpuid.reg comes from read/only 'reverse_cpuid' anyway, and in fact
it seems that all callers of __cpuid_entry_get_reg, take the reg value from
x86_feature_cpuid() which also takes it from 'reverse_cpuid'.

So if the compiler is smart enough to not complain in these cases, I don't see why this case
is different.


Also why not to initialize guest_caps = host_caps & userspace_cpuid?

If this was the default we won't need any guest_cpu_cap_restrict and such,
instead it will just work.

Special code will only be needed in few more complex cases, like forced exposed
of a feature to a guest due to a virtualization hole.


> +		else
> +			vcpu->arch.cpu_caps[i] = 0;
> +	}
>  
>  	/*
>  	 * If TDP is enabled, let the guest use GBPAGES if they're supported in
> @@ -342,8 +380,7 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	 */
>  	allow_gbpages = tdp_enabled ? boot_cpu_has(X86_FEATURE_GBPAGES) :
>  				      guest_cpuid_has(vcpu, X86_FEATURE_GBPAGES);
> -	if (allow_gbpages)
> -		guest_cpu_cap_set(vcpu, X86_FEATURE_GBPAGES);
> +	guest_cpu_cap_change(vcpu, X86_FEATURE_GBPAGES, allow_gbpages);

IMHO the original code was more readable, now I need to look up the 'guest_cpu_cap_change()'
to understand what is going on.

>  
>  	best = kvm_find_cpuid_entry(vcpu, 1);
>  	if (best && apic) {
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index 9f18c4395b71..1707ef10b269 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -263,11 +263,30 @@ static __always_inline void guest_cpu_cap_set(struct kvm_vcpu *vcpu,
>  	vcpu->arch.cpu_caps[x86_leaf] |= __feature_bit(x86_feature);
>  }
>  
> -static __always_inline void guest_cpu_cap_check_and_set(struct kvm_vcpu *vcpu,
> -							unsigned int x86_feature)
> +static __always_inline void guest_cpu_cap_clear(struct kvm_vcpu *vcpu,
> +						unsigned int x86_feature)
>  {
> -	if (kvm_cpu_cap_has(x86_feature) && guest_cpuid_has(vcpu, x86_feature))
> +	unsigned int x86_leaf = __feature_leaf(x86_feature);
> +
> +	reverse_cpuid_check(x86_leaf);
> +	vcpu->arch.cpu_caps[x86_leaf] &= ~__feature_bit(x86_feature);
> +}
> +
> +static __always_inline void guest_cpu_cap_change(struct kvm_vcpu *vcpu,
> +						 unsigned int x86_feature,
> +						 bool guest_has_cap)
> +{
> +	if (guest_has_cap)
>  		guest_cpu_cap_set(vcpu, x86_feature);
> +	else
> +		guest_cpu_cap_clear(vcpu, x86_feature);
> +}

Let's not have this function, it's just not worth it IMHO.

> +
> +static __always_inline void guest_cpu_cap_restrict(struct kvm_vcpu *vcpu,
> +						   unsigned int x86_feature)
> +{
> +	if (!kvm_cpu_cap_has(x86_feature))
> +		guest_cpu_cap_clear(vcpu, x86_feature);
>  }

The purpose of this function is also very hard to decipher.

If we initialize guest_caps = host_caps & guest_cpuid then we won't
need this function.

>  
>  static __always_inline bool guest_cpu_cap_has(struct kvm_vcpu *vcpu,
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 8a99a73b6ee5..5827328e30f1 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4315,14 +4315,14 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	 * XSS on VM-Enter/VM-Exit.  Failure to do so would effectively give
>  	 * the guest read/write access to the host's XSS.
>  	 */
> -	if (boot_cpu_has(X86_FEATURE_XSAVE) &&
> -	    boot_cpu_has(X86_FEATURE_XSAVES) &&
> -	    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE))
> -		guest_cpu_cap_set(vcpu, X86_FEATURE_XSAVES);
> +	guest_cpu_cap_change(vcpu, X86_FEATURE_XSAVES,
> +			     boot_cpu_has(X86_FEATURE_XSAVE) &&
> +			     boot_cpu_has(X86_FEATURE_XSAVES) &&
> +			     guest_cpuid_has(vcpu, X86_FEATURE_XSAVE));

In theory this change does change behavior, now the X86_FEATURE_XSAVE will
be set iff the condition is true, but before it was set *if* the condition was true.

>  
> -	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_NRIPS);
> -	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_TSCRATEMSR);
> -	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_LBRV);
> +	guest_cpu_cap_restrict(vcpu, X86_FEATURE_NRIPS);
> +	guest_cpu_cap_restrict(vcpu, X86_FEATURE_TSCRATEMSR);
> +	guest_cpu_cap_restrict(vcpu, X86_FEATURE_LBRV);

One of the main reasons I don't like governed features is this manual list.
I want to reach the point that one won't need to add anything manually, unless there
is a good reason to do so, and there are only a few exceptions when the guest cap is set,
while the host's isn't.

>  
>  	/*
>  	 * Intercept VMLOAD if the vCPU mode is Intel in order to emulate that
> @@ -4330,12 +4330,12 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	 * SVM on Intel is bonkers and extremely unlikely to work).
>  	 */
>  	if (!guest_cpuid_is_intel(vcpu))
> -		guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
> +		guest_cpu_cap_restrict(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
>  
> -	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_PAUSEFILTER);
> -	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_PFTHRESHOLD);
> -	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_VGIF);
> -	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_VNMI);
> +	guest_cpu_cap_restrict(vcpu, X86_FEATURE_PAUSEFILTER);
> +	guest_cpu_cap_restrict(vcpu, X86_FEATURE_PFTHRESHOLD);
> +	guest_cpu_cap_restrict(vcpu, X86_FEATURE_VGIF);
> +	guest_cpu_cap_restrict(vcpu, X86_FEATURE_VNMI);
>  
>  	svm_recalc_instruction_intercepts(vcpu, svm);
>  
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 6328f0d47c64..5a056ad1ae55 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7757,9 +7757,11 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	 */
>  	if (boot_cpu_has(X86_FEATURE_XSAVE) &&
>  	    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE))
> -		guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_XSAVES);
> +		guest_cpu_cap_restrict(vcpu, X86_FEATURE_XSAVES);
> +	else
> +		guest_cpu_cap_clear(vcpu, X86_FEATURE_XSAVES);
>  
> -	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_VMX);
> +	guest_cpu_cap_restrict(vcpu, X86_FEATURE_VMX);
>  
>  	vmx_setup_uret_msrs(vmx);
>  


Best regards,
	Maxim Levitsky



