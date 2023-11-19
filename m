Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E867F081E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 18:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjKSRfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 12:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjKSRfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 12:35:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5721EB3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700415335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xliBDg8pP7F2Yj3xf/oIT4SDk7CsfUP0pIU9lszae9E=;
        b=Kvb/rKxdWeZHOi0RcTJ394E8Hbnph0VSl+XYO54WqIr7C3x7RrCkr7W2CIOw3vCWHV6WM1
        J2aPUxHcKz+QRvbzFLHE4UfLXj5wZIyhjoyLwRbIbQb8XhNpft5nsdAh6c6naWTWbUOY43
        TpSEawWNryKwEMucjYobyVtWtqMiaAo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-JvQG1eB1OX-UPLfQaj_csw-1; Sun, 19 Nov 2023 12:35:33 -0500
X-MC-Unique: JvQG1eB1OX-UPLfQaj_csw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32fd5f7b674so1772801f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700415332; x=1701020132;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xliBDg8pP7F2Yj3xf/oIT4SDk7CsfUP0pIU9lszae9E=;
        b=lxSTvnvk/7lsaXTekjivVch0nSlCORKcRsrjkbIwMx6kJqr9u29BI+qR5iPmxYCX6m
         iQw8ehDF66HOsyL0f9FpD+/KpKJO6kGMpl0bXMRfbWmmpHnIKMZ+TlrTabzqLreUVfLu
         3sXiPw6jQDAmbkU5hILOaypBBkJO2pI7X3a73LZcRPXaHe/Rjas1ZiQO0u2RNfvUKH68
         Vg6FwT9qUh7nTSK+v2UAwBdAkb3QX2DnDp9SuoeD1CEGM0B5EL/YX3iaXggpXdoRlmk6
         OIwvXy0y4D/YZpYuYnO7k75eF+GJ3d6J+WysmFWUPWyeXqwSAIl3Ein8baSCD6r6UHvr
         NK5Q==
X-Gm-Message-State: AOJu0Yy/6H3+uHJtGSavmDmA3h5i9HvnwVBJdlu7sFeYPZ09bgQmTnms
        p7tF6LVMYHNyhvJM29BY7rCfQXG/MSMT6VgM7OZShYk4VaD00ADP+jwLXUNYkt0k/E4uqIFSasH
        ELmJLKh8EsLMgMurYeeZO4TGb
X-Received: by 2002:a5d:4522:0:b0:32f:9a76:ea05 with SMTP id j2-20020a5d4522000000b0032f9a76ea05mr3191866wra.60.1700415332702;
        Sun, 19 Nov 2023 09:35:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3wQ6H0c7WartGxUG52lOv9rIoPhr1Jr9gv/ApKkb6QVMccTdXF4/SmX9o9Nygal15t5LUJg==
X-Received: by 2002:a5d:4522:0:b0:32f:9a76:ea05 with SMTP id j2-20020a5d4522000000b0032f9a76ea05mr3191859wra.60.1700415332352;
        Sun, 19 Nov 2023 09:35:32 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id m10-20020a5d4a0a000000b00331702ab6acsm5861099wrq.7.2023.11.19.09.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 09:35:32 -0800 (PST)
Message-ID: <4484647425e2dbf92c76a173b7b14e346f60362d.camel@redhat.com>
Subject: Re: [PATCH 6/9] KVM: x86: Update guest cpu_caps at runtime for
 dynamic CPUID-based features
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 19 Nov 2023 19:35:30 +0200
In-Reply-To: <20231110235528.1561679-7-seanjc@google.com>
References: <20231110235528.1561679-1-seanjc@google.com>
         <20231110235528.1561679-7-seanjc@google.com>
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
> When updating guest CPUID entries to emulate runtime behavior, e.g. when
> the guest enables a CR4-based feature that is tied to a CPUID flag, also
> update the vCPU's cpu_caps accordingly.  This will allow replacing all
> usage of guest_cpuid_has() with guest_cpu_cap_has().
> 
> Take care not to update guest capabilities when KVM is updating CPUID
> entries that *may* become the vCPU's CPUID, e.g. if userspace tries to set
> bogus CPUID information.  No extra call to update cpu_caps is needed as
> the cpu_caps are initialized from the incoming guest CPUID, i.e. will
> automatically get the updated values.
> 
> Note, none of the features in question use guest_cpu_cap_has() at this
> time, i.e. aside from settings bits in cpu_caps, this is a glorified nop.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 48 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 34 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 36bd04030989..37a991439fe6 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -262,31 +262,48 @@ static u64 cpuid_get_supported_xcr0(struct kvm_cpuid_entry2 *entries, int nent)
>  	return (best->eax | ((u64)best->edx << 32)) & kvm_caps.supported_xcr0;
>  }
>  
> +static __always_inline void kvm_update_feature_runtime(struct kvm_vcpu *vcpu,
> +						       struct kvm_cpuid_entry2 *entry,
> +						       unsigned int x86_feature,
> +						       bool has_feature)
> +{
> +	if (entry)
> +		cpuid_entry_change(entry, x86_feature, has_feature);
> +
> +	if (vcpu)
> +		guest_cpu_cap_change(vcpu, x86_feature, has_feature);
> +}
> +
>  static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *entries,
>  				       int nent)
>  {
>  	struct kvm_cpuid_entry2 *best;
> +	struct kvm_vcpu *caps = vcpu;
> +
> +	/*
> +	 * Don't update vCPU capabilities if KVM is updating CPUID entries that
> +	 * are coming in from userspace!
> +	 */
> +	if (entries != vcpu->arch.cpuid_entries)
> +		caps = NULL;

I think that this should be decided by the caller. Just a boolean will suffice.

Or even better: since the userspace CPUID update is really not important in terms of performance,
why to special case it? 

Even if these guest caps are later overwritten, I don't see why we
need to avoid updating them, and in fact introduce a small risk of them not being consistent
with the other cpu caps.

With this we can avoid having the 'cap' variable which is *very* confusing as well.


>  
>  	best = cpuid_entry2_find(entries, nent, 1, KVM_CPUID_INDEX_NOT_SIGNIFICANT);
> -	if (best) {
> -		/* Update OSXSAVE bit */
> -		if (boot_cpu_has(X86_FEATURE_XSAVE))
> -			cpuid_entry_change(best, X86_FEATURE_OSXSAVE,
> +
> +	if (boot_cpu_has(X86_FEATURE_XSAVE))
> +		kvm_update_feature_runtime(caps, best, X86_FEATURE_OSXSAVE,
>  					   kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE));
>  
> -		cpuid_entry_change(best, X86_FEATURE_APIC,
> -			   vcpu->arch.apic_base & MSR_IA32_APICBASE_ENABLE);
> +	kvm_update_feature_runtime(caps, best, X86_FEATURE_APIC,
> +				   vcpu->arch.apic_base & MSR_IA32_APICBASE_ENABLE);
>  
> -		if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT))
> -			cpuid_entry_change(best, X86_FEATURE_MWAIT,
> -					   vcpu->arch.ia32_misc_enable_msr &
> -					   MSR_IA32_MISC_ENABLE_MWAIT);
> -	}
> +	if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT))
> +		kvm_update_feature_runtime(caps, best, X86_FEATURE_MWAIT,
> +					   vcpu->arch.ia32_misc_enable_msr & MSR_IA32_MISC_ENABLE_MWAIT);
>  
>  	best = cpuid_entry2_find(entries, nent, 7, 0);
> -	if (best && boot_cpu_has(X86_FEATURE_PKU))
> -		cpuid_entry_change(best, X86_FEATURE_OSPKE,
> -				   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
> +	if (boot_cpu_has(X86_FEATURE_PKU))
> +		kvm_update_feature_runtime(caps, best, X86_FEATURE_OSPKE,
> +					   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
>  
>  	best = cpuid_entry2_find(entries, nent, 0xD, 0);
>  	if (best)
> @@ -353,6 +370,9 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	 * Reset guest capabilities to userspace's guest CPUID definition, i.e.
>  	 * honor userspace's definition for features that don't require KVM or
>  	 * hardware management/support (or that KVM simply doesn't care about).
> +	 *
> +	 * Note, KVM has already done runtime updates on guest CPUID, i.e. this
> +	 * will also correctly set runtime features in guest CPU capabilities.
>  	 */
>  	for (i = 0; i < NR_KVM_CPU_CAPS; i++) {
>  		const struct cpuid_reg cpuid = reverse_cpuid[i];


Best regards,
	Maxim Levitsky

