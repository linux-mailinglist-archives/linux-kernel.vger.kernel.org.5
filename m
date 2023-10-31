Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5BC7DD580
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376313AbjJaRwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344752AbjJaRwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594FFDA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698774710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xbwj2dHsP/n+I+LAOQsG7ONUc0ESdKd5+R45/k2Elyo=;
        b=HL8crrerbM5UiZBlF1jN3KQBQCnWQsJz1kL4BLwd8JSNbvXjpSI5Qd2FTuKqOhuOgx+GIt
        zbvFzZLqs/q1VmXSvxBzAp/vrEoWgIvMf9p0BK7mex3PToyGZjrpdKoDPw2Qvpo2RjGhGJ
        I0AFmq1k0IkaQlJwiVwLay+BqwS1mjI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-UJrI9aeaNHWUll5kh69YeA-1; Tue, 31 Oct 2023 13:51:48 -0400
X-MC-Unique: UJrI9aeaNHWUll5kh69YeA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507a3ae32b2so6687101e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774707; x=1699379507;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xbwj2dHsP/n+I+LAOQsG7ONUc0ESdKd5+R45/k2Elyo=;
        b=IQCUzZKHC7XdRwetLmo3TBboOCvhj15zpVKwr96K+dmsV0DnoRI2Xbc6mkearwzg03
         MZyokyuiW3vJ943i2mMejPJqVFtWS4EmgkPbdzjdvztG0/EuU3+UimxXLvN0UyeFyU3B
         LMZk//tm9GOzlbpwGy8BfyW8NKjJ0pQ9niuPgW3z4wZjvg19HOT3qNsa7iQm6IA2qF4R
         5yVnbr4J/jfN84jfoOdxQjfYskyslD8k/VoNpkorfjvXM1ZYaCIv0dFSMxUM6LVLj1Ko
         FgI3mzdtWdPzxZ05UMSNODbm4fJw2oohhURERaooClwK9C9hOs5vuxzJOXSCL5jzeQiq
         MbvQ==
X-Gm-Message-State: AOJu0YxhnVOVUBJOyMdY6cfcvQHLTp+KMY6UNoQ2B/VS4i8IHot8lYyL
        95ssz8/XjAr8R83fgsiulfbfnwfKVAXYxYzJB4cQPKu8Y0gQtsQ5nEAteAOFy9vepyoTZcQweOp
        xrydLfll6SoUr87iDLnOqWzl5
X-Received: by 2002:a05:6512:2244:b0:500:9a45:62f with SMTP id i4-20020a056512224400b005009a45062fmr13447427lfu.8.1698774707305;
        Tue, 31 Oct 2023 10:51:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/mKI2hI672a/XC9nfk/tDqx1adzvdlvFxrfqaU6yv9qO6rsdPtvQ8KNgldfudTeaeOOBwHQ==
X-Received: by 2002:a05:6512:2244:b0:500:9a45:62f with SMTP id i4-20020a056512224400b005009a45062fmr13447401lfu.8.1698774706896;
        Tue, 31 Oct 2023 10:51:46 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id y17-20020adff6d1000000b0032f7d7ec4adsm2013882wrp.92.2023.10.31.10.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:51:46 -0700 (PDT)
Message-ID: <2b1973ee44498039c97d4d11de3a93b0f3b1d2d8.camel@redhat.com>
Subject: Re: [PATCH v6 14/25] KVM: x86: Load guest FPU state when access
 XSAVE-managed MSRs
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Tue, 31 Oct 2023 19:51:44 +0200
In-Reply-To: <20230914063325.85503-15-weijiang.yang@intel.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-15-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Load the guest's FPU state if userspace is accessing MSRs whose values
> are managed by XSAVES. Introduce two helpers, kvm_{get,set}_xstate_msr(),
> to facilitate access to such kind of MSRs.
> 
> If MSRs supported in kvm_caps.supported_xss are passed through to guest,
> the guest MSRs are swapped with host's before vCPU exits to userspace and
> after it re-enters kernel before next VM-entry.
> 
> Because the modified code is also used for the KVM_GET_MSRS device ioctl(),
> explicitly check @vcpu is non-null before attempting to load guest state.
> The XSS supporting MSRs cannot be retrieved via the device ioctl() without
> loading guest FPU state (which doesn't exist).
> 
> Note that guest_cpuid_has() is not queried as host userspace is allowed to
> access MSRs that have not been exposed to the guest, e.g. it might do
> KVM_SET_MSRS prior to KVM_SET_CPUID2.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Yang Weijiang <weijiang.yang@intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/x86.c | 30 +++++++++++++++++++++++++++++-
>  arch/x86/kvm/x86.h | 24 ++++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 66edbed25db8..a091764bf1d2 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -133,6 +133,9 @@ static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
>  static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
>  
>  static DEFINE_MUTEX(vendor_module_lock);
> +static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
> +static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu);
> +
>  struct kvm_x86_ops kvm_x86_ops __read_mostly;
>  
>  #define KVM_X86_OP(func)					     \
> @@ -4372,6 +4375,22 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  }
>  EXPORT_SYMBOL_GPL(kvm_get_msr_common);
>  
> +static const u32 xstate_msrs[] = {
> +	MSR_IA32_U_CET, MSR_IA32_PL0_SSP, MSR_IA32_PL1_SSP,
> +	MSR_IA32_PL2_SSP, MSR_IA32_PL3_SSP,
> +};
> +
> +static bool is_xstate_msr(u32 index)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(xstate_msrs); i++) {
> +		if (index == xstate_msrs[i])
> +			return true;
> +	}
> +	return false;
> +}

The name 'xstate_msr' IMHO is not clear.

How about naming it 'guest_fpu_state_msrs', together with adding a comment like that:

"These msrs are context switched together with the rest of the guest FPU state,
on exit/entry to/from userspace

There is also an assumption that loading guest values while the host kernel runs,
doesn't cause harm to the host kernel"


But if you prefer something else, its fine with me, but I do appreciate to have some
comment attached to 'xstate_msr' at least.

> +
>  /*
>   * Read or write a bunch of msrs. All parameters are kernel addresses.
>   *
> @@ -4382,11 +4401,20 @@ static int __msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs *msrs,
>  		    int (*do_msr)(struct kvm_vcpu *vcpu,
>  				  unsigned index, u64 *data))
>  {
> +	bool fpu_loaded = false;
>  	int i;
>  
> -	for (i = 0; i < msrs->nmsrs; ++i)
> +	for (i = 0; i < msrs->nmsrs; ++i) {
> +		if (vcpu && !fpu_loaded && kvm_caps.supported_xss &&
> +		    is_xstate_msr(entries[i].index)) {

A comment here about why this is done, will also be appreciated:

"Userspace requested us to read a MSR which value resides in the guest FPU state.
Load this state temporarily to CPU to read/update it."

> +			kvm_load_guest_fpu(vcpu);
> +			fpu_loaded = true;
> +		}
>  		if (do_msr(vcpu, entries[i].index, &entries[i].data))
>  			break;
> +	}

And maybe here too:

"If KVM loaded the guest FPU state, unload to it to restore the original userspace FPU state
and to update the guest FPU state in case it was modified."

> +	if (fpu_loaded)
> +		kvm_put_guest_fpu(vcpu);
>  
>  	return i;
>  }
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 1e7be1f6ab29..9a8e3a84eaf4 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -540,4 +540,28 @@ int kvm_sev_es_string_io(struct kvm_vcpu *vcpu, unsigned int size,
>  			 unsigned int port, void *data,  unsigned int count,
>  			 int in);
>  
> +/*
> + * Lock and/or reload guest FPU and access xstate MSRs. For accesses initiated
> + * by host, guest FPU is loaded in __msr_io(). For accesses initiated by guest,
> + * guest FPU should have been loaded already.
> + */
> +
> +static inline void kvm_get_xstate_msr(struct kvm_vcpu *vcpu,
> +				      struct msr_data *msr_info)
> +{
> +	KVM_BUG_ON(!vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm);
> +	kvm_fpu_get();
> +	rdmsrl(msr_info->index, msr_info->data);
> +	kvm_fpu_put();
> +}
> +
> +static inline void kvm_set_xstate_msr(struct kvm_vcpu *vcpu,
> +				      struct msr_data *msr_info)
> +{
> +	KVM_BUG_ON(!vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm);
> +	kvm_fpu_get();
> +	wrmsrl(msr_info->index, msr_info->data);
> +	kvm_fpu_put();
> +}

These functions are not used in the patch. I think they should be added later
when used.

Best regards,
	Maxim Levitsky

> +
>  #endif





