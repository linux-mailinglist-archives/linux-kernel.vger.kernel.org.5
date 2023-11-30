Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154287FF8DC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346676AbjK3Ryb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjK3Rya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:54:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4118610F4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701366875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7eitlarlwhMxm0lW+w9tSXOARC6Bn5ryc9RJgB/kwkE=;
        b=HnQV+TQLcVVz0Sjqvs/j0K/7ziPRNtbGN218ihkh0QMGnOK0pG+/G3F6O5IgOwXd9u+JSc
        Zq/+nawyq6tLRDNOKCTwqi+ARURtylH8rrcCBQlYvznpw0Sq/e+3VZJ3ADT3oNIWT+IxEh
        pY8OJbl9uKmloQOYsiYS6PI5oRmMLMo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-Y7zytKtcN5mbhQ02KsGL2w-1; Thu, 30 Nov 2023 12:54:33 -0500
X-MC-Unique: Y7zytKtcN5mbhQ02KsGL2w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b296a4450so9084555e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701366873; x=1701971673;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7eitlarlwhMxm0lW+w9tSXOARC6Bn5ryc9RJgB/kwkE=;
        b=W0DG3YOzBqkaCPZRp1AJZzAWxcG+u70MLu5UUcAEk+0XTUjyzSRg6Jj9W5ONHnrxdL
         KVG+nuTx+u9QipnZZavV7u+5rFe2c24HDLQu13afAQtJ+lkXoIZwtSGZ5/UwjMjQNbux
         b2LIrJuI3dWY3IiFl7wCbp7VtuV+JCYUOZXf9Y7YBZSF1b9pygrfFuNaqY2rYtuH1cn8
         nOnKuCStvpeKQ4T0l5qu7kUP1Jfbx20YbJffVEwte6gtlAcmLQRZlRITzamxSxPI3pyw
         fMC6hJOXaekVMOalxK49buzP7ZC+AuFT0CFmh+3coFSqEzuMmOo6OH8pAFv/JLNCWg4a
         LMKQ==
X-Gm-Message-State: AOJu0Yx7Eawg2U8pAGq2yvvKfDK6e9VIdv9ipoIGm8YQKWaC3wJ/xGF2
        Sl2Llz8zPgG5eoaqSLwLSqz1AxXW2KN3+mGT2eucaSU1Qzms16/e1CBy81jXux4dTnHCAp/naKm
        0ilPgjdQFEoMIhHMw2diX4jI4
X-Received: by 2002:a05:6512:62:b0:50b:c0bb:b48b with SMTP id i2-20020a056512006200b0050bc0bbb48bmr18079lfo.43.1701365882098;
        Thu, 30 Nov 2023 09:38:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmaqf02q2LGwnzMqG0KjaMy2J1+za+mBLnUKCC2fDN9U5JRT2w+c9ihZ+W3Sq9h9dsalb0/w==
X-Received: by 2002:a05:6512:62:b0:50b:c0bb:b48b with SMTP id i2-20020a056512006200b0050bc0bbb48bmr17514lfo.43.1701365869643;
        Thu, 30 Nov 2023 09:37:49 -0800 (PST)
Received: from starship ([5.28.147.32])
        by smtp.gmail.com with ESMTPSA id f20-20020a05651232d400b0050bc9731ed6sm213486lfg.276.2023.11.30.09.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:37:49 -0800 (PST)
Message-ID: <f86f12b69c1c1ca9f5172e7340c0253d4533fbc1.camel@redhat.com>
Subject: Re: [PATCH v7 13/26] KVM: x86: Refresh CPUID on write to guest
 MSR_IA32_XSS
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Date:   Thu, 30 Nov 2023 19:37:46 +0200
In-Reply-To: <20231124055330.138870-14-weijiang.yang@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-14-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-24 at 00:53 -0500, Yang Weijiang wrote:
> Update CPUID.(EAX=0DH,ECX=1).EBX to reflect current required xstate size
> due to XSS MSR modification.
> CPUID(EAX=0DH,ECX=1).EBX reports the required storage size of all enabled
> xstate features in (XCR0 | IA32_XSS). The CPUID value can be used by guest
> before allocate sufficient xsave buffer.
> 
> Note, KVM does not yet support any XSS based features, i.e. supported_xss
> is guaranteed to be zero at this time.
> 
> Opportunistically modify XSS write access logic as:
> If XSAVES is not enabled in the guest CPUID, forbid setting IA32_XSS msr
> to anything but 0, even if the write is host initiated.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  3 ++-
>  arch/x86/kvm/cpuid.c            | 15 ++++++++++++++-
>  arch/x86/kvm/x86.c              | 16 ++++++++++++----
>  3 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 499bd42e3a32..f536102f1eca 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -756,7 +756,6 @@ struct kvm_vcpu_arch {
>  	bool at_instruction_boundary;
>  	bool tpr_access_reporting;
>  	bool xfd_no_write_intercept;
> -	u64 ia32_xss;
>  	u64 microcode_version;
>  	u64 arch_capabilities;
>  	u64 perf_capabilities;
> @@ -812,6 +811,8 @@ struct kvm_vcpu_arch {
>  
>  	u64 xcr0;
>  	u64 guest_supported_xcr0;
> +	u64 guest_supported_xss;
> +	u64 ia32_xss;
>  
>  	struct kvm_pio_request pio;
>  	void *pio_data;
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 0351e311168a..1d9843b34196 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -275,7 +275,8 @@ static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_e
>  	best = cpuid_entry2_find(entries, nent, 0xD, 1);
>  	if (best && (cpuid_entry_has(best, X86_FEATURE_XSAVES) ||
>  		     cpuid_entry_has(best, X86_FEATURE_XSAVEC)))
> -		best->ebx = xstate_required_size(vcpu->arch.xcr0, true);
> +		best->ebx = xstate_required_size(vcpu->arch.xcr0 |
> +						 vcpu->arch.ia32_xss, true);
>  
>  	best = __kvm_find_kvm_cpuid_features(vcpu, entries, nent);
>  	if (kvm_hlt_in_guest(vcpu->kvm) && best &&
> @@ -312,6 +313,17 @@ static u64 vcpu_get_supported_xcr0(struct kvm_vcpu *vcpu)
>  	return (best->eax | ((u64)best->edx << 32)) & kvm_caps.supported_xcr0;
>  }
>  
> +static u64 vcpu_get_supported_xss(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_cpuid_entry2 *best;
> +
> +	best = kvm_find_cpuid_entry_index(vcpu, 0xd, 1);
> +	if (!best)
> +		return 0;
> +
> +	return (best->ecx | ((u64)best->edx << 32)) & kvm_caps.supported_xss;
> +}
> +
>  static bool kvm_cpuid_has_hyperv(struct kvm_cpuid_entry2 *entries, int nent)
>  {
>  	struct kvm_cpuid_entry2 *entry;
> @@ -358,6 +370,7 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	}
>  
>  	vcpu->arch.guest_supported_xcr0 = vcpu_get_supported_xcr0(vcpu);
> +	vcpu->arch.guest_supported_xss = vcpu_get_supported_xss(vcpu);
>  
>  	kvm_update_pv_runtime(vcpu);
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index f7d4cc61bc55..649a100ffd25 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3901,20 +3901,28 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  			vcpu->arch.ia32_tsc_adjust_msr += adj;
>  		}
>  		break;
> -	case MSR_IA32_XSS:
> -		if (!msr_info->host_initiated &&
> -		    !guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))
> +	case MSR_IA32_XSS: {
> +		/*
> +		 * If KVM reported support of XSS MSR, even guest CPUID doesn't
> +		 * support XSAVES, still allow userspace to set default value(0)
> +		 * to this MSR.
> +		 */
> +		if (!guest_cpuid_has(vcpu, X86_FEATURE_XSAVES) &&
> +		    !(msr_info->host_initiated && data == 0))
>  			return 1;
>  		/*
>  		 * KVM supports exposing PT to the guest, but does not support
>  		 * IA32_XSS[bit 8]. Guests have to use RDMSR/WRMSR rather than
>  		 * XSAVES/XRSTORS to save/restore PT MSRs.
>  		 */
> -		if (data & ~kvm_caps.supported_xss)
> +		if (data & ~vcpu->arch.guest_supported_xss)
>  			return 1;
> +		if (vcpu->arch.ia32_xss == data)
> +			break;
>  		vcpu->arch.ia32_xss = data;
>  		kvm_update_cpuid_runtime(vcpu);
>  		break;
> +	}
>  	case MSR_SMI_COUNT:
>  		if (!msr_info->host_initiated)
>  			return 1;

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


