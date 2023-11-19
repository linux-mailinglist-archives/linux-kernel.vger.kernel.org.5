Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7C37F0820
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 18:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjKSRfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 12:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjKSRfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 12:35:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F78115
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700415346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3okOyMxyER+1UcLcyJrkl/ivMZnxpI75V+9VEqz4llI=;
        b=FmW/OTdlQ8qdwwBH6ruR01LLmVBOdZnFoXTF1Q3IbrB8JrLkoToyaTZ1anjweEEm+Ks7Hn
        PVqKz41Ynt4MjXdtPPhSzh+t8kKBSn2nOCS02b8JYGTEpgNYi7aaUWRftD6y2pKokRqeLm
        Pg06j+b0KDPmNYHZb0vXwfGLkpoAhHY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-fq6mEnELMf6-_go1-EaEkQ-1; Sun, 19 Nov 2023 12:35:44 -0500
X-MC-Unique: fq6mEnELMf6-_go1-EaEkQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c53ea92642so32001721fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700415343; x=1701020143;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3okOyMxyER+1UcLcyJrkl/ivMZnxpI75V+9VEqz4llI=;
        b=SYW4Gbe3DgPcSpMIK8tnzObZG5+8ZVTzdL11Nzbm0oChb+60RDGhKx/+BEQ9AtDIs7
         2L/WfmLRHB9eSmce+WUZKsv1tUdsC2M/wvNMwH2P/IiEGZ8DMWynVYAjVhXvYFQn0keN
         J2lZ791NEOKpNUXJFaH5gXCLdCkmUiHQBS0hhcPAffFrRVytbQe8Bg+Jt0ygjFW/Y4r/
         mHBUfr8hm89uUjEGRAnUd4dYSkEaGXQjyem/WwXcZR2zZFpHL+NAt1ML21GTNBHvQXXR
         Fy75s9332IxcjXg0xurI0Vm5ZuyobXS9Df3TMS8qj7TafLtoJKSNWmkpu1lkdwjYerNh
         GapQ==
X-Gm-Message-State: AOJu0YyKhLXDeeIk54zC36DOcfaV+re89f4XSwoIwWvv+1FdrQsmtjPN
        vlWTS3ECDJ86zLYFFd54YHTWEK44lR0QeD6hew9g7eMpvd+pK6k2wykNxCbK/NNm96vVgdGZJ1W
        dTvrsl320Pni3UdTmp9Xv4Kax
X-Received: by 2002:a2e:9b18:0:b0:2c8:7192:800 with SMTP id u24-20020a2e9b18000000b002c871920800mr3134540lji.51.1700415343491;
        Sun, 19 Nov 2023 09:35:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1D/pZYBnGnvh++rCaYFlneml3ZmOhl6osF8W+ugDq2SFLA+hrWYaO4SLyH2RCXs8cFD5JUg==
X-Received: by 2002:a2e:9b18:0:b0:2c8:7192:800 with SMTP id u24-20020a2e9b18000000b002c871920800mr3134533lji.51.1700415343158;
        Sun, 19 Nov 2023 09:35:43 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id c20-20020a7bc854000000b0040a43d458c9sm14662541wml.25.2023.11.19.09.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 09:35:42 -0800 (PST)
Message-ID: <325fd3126a72c926b9d8d0ee060f90ce6d8a582e.camel@redhat.com>
Subject: Re: [PATCH 7/9] KVM: x86: Shuffle code to prepare for dropping
 guest_cpuid_has()
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 19 Nov 2023 19:35:40 +0200
In-Reply-To: <20231110235528.1561679-8-seanjc@google.com>
References: <20231110235528.1561679-1-seanjc@google.com>
         <20231110235528.1561679-8-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-10 at 15:55 -0800, Sean Christopherson wrote:
> Move the implementations of guest_has_{spec_ctrl,pred_cmd}_msr() down
> below guest_cpu_cap_has() so that their use of guest_cpuid_has() can be
> replaced with calls to guest_cpu_cap_has().
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.h | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index 1707ef10b269..bebf94a69630 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -163,21 +163,6 @@ static inline int guest_cpuid_stepping(struct kvm_vcpu *vcpu)
>  	return x86_stepping(best->eax);
>  }
>  
> -static inline bool guest_has_spec_ctrl_msr(struct kvm_vcpu *vcpu)
> -{
> -	return (guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) ||
> -		guest_cpuid_has(vcpu, X86_FEATURE_AMD_STIBP) ||
> -		guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) ||
> -		guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD));
> -}
> -
> -static inline bool guest_has_pred_cmd_msr(struct kvm_vcpu *vcpu)
> -{
> -	return (guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) ||
> -		guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBPB) ||
> -		guest_cpuid_has(vcpu, X86_FEATURE_SBPB));
> -}
> -
>  static inline bool supports_cpuid_fault(struct kvm_vcpu *vcpu)
>  {
>  	return vcpu->arch.msr_platform_info & MSR_PLATFORM_INFO_CPUID_FAULT;
> @@ -298,4 +283,19 @@ static __always_inline bool guest_cpu_cap_has(struct kvm_vcpu *vcpu,
>  	return vcpu->arch.cpu_caps[x86_leaf] & __feature_bit(x86_feature);
>  }
>  
> +static inline bool guest_has_spec_ctrl_msr(struct kvm_vcpu *vcpu)
> +{
> +	return (guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) ||
> +		guest_cpuid_has(vcpu, X86_FEATURE_AMD_STIBP) ||
> +		guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) ||
> +		guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD));
> +}
> +
> +static inline bool guest_has_pred_cmd_msr(struct kvm_vcpu *vcpu)
> +{
> +	return (guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) ||
> +		guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBPB) ||
> +		guest_cpuid_has(vcpu, X86_FEATURE_SBPB));
> +}
> +
>  #endif
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

