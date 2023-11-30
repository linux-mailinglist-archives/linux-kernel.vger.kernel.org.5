Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8EF7FFB0C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376341AbjK3TTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjK3TS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:18:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B141B1A4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701371945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ROI9QsVBebZ2z46uwx8HAg7XDg30OxxOQZ6JWNYVYc=;
        b=hZjRjnulxF4DcNZlP2rHsM2fLqi7/b/XTxQRgCAIFh+LlpdlqrvE4n3BbnIiNWYpFgAPjK
        EOdgNPdPixL7srjB/sdpc9ADpT3FsZEIpxVmFNlowS6G8i/4aLlzbtBG7V5cnEztGrIdt2
        W/Vg4U7Xbm8hjcNuyzx2CAMu9beI3gg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-uB6Xh8-AMjC6FLMqRpIFVQ-1; Thu, 30 Nov 2023 14:19:00 -0500
X-MC-Unique: uB6Xh8-AMjC6FLMqRpIFVQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-54366567af4so1783977a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371937; x=1701976737;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ROI9QsVBebZ2z46uwx8HAg7XDg30OxxOQZ6JWNYVYc=;
        b=cjO302y6DnNU1d1NBcwjtPynYFLByeOwRx2zNhV+bb+0igDzpg5HC7bUuXN2UZ+N+1
         y+Xs0Dm49HZ4jZ+YbqqsMi7CCA7BkQY3InqAmvdY7ArYekeNF7cg0eXEHK8ftFwO9n0j
         1axO5rM7waJohwl5xdnZRoPsSi0ddLeiRXvAxTmEynXUt4fwMdGWsmtmWBaihkfkvKUk
         ES3J+QHz+DdbKlW/9fLw3AB/TQjeFPB5TKoCLQ0U60zrNZNIlMglbyhv1wN/t9Tf0CkL
         2jv1I5ysUh+5SQwwww+H4xM4uU6bPgyzI08PYJVaVecohNvsas/rG7NjifVpN8iSVpJT
         FJxA==
X-Gm-Message-State: AOJu0Yx0IGTsECrbEH/CsEvUxdtMcUfn6cAhzKOLjjel3FN5my9+QTEj
        mrO5iYm/wfyxRxYFxBxKI0d8ylcxZmKwaLiBAIC2UgurrA5txJMMNXJ7t0aZQ5BYT57Z5yGyeor
        pIGaxd1hjfS6IazxHKwim8+n9BryuPlkA
X-Received: by 2002:aa7:d4d1:0:b0:54b:3f0c:7fe0 with SMTP id t17-20020aa7d4d1000000b0054b3f0c7fe0mr12643edr.6.1701371936832;
        Thu, 30 Nov 2023 11:18:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4QjnJOrbKfLEuFMzMmje8PoqSYFHn0lGEviE5VHDMLAbPObRw2OxFYlFP3L4fHrNjcg39jA==
X-Received: by 2002:a05:6512:50b:b0:50b:d552:267c with SMTP id o11-20020a056512050b00b0050bd552267cmr42172lfb.3.1701365812565;
        Thu, 30 Nov 2023 09:36:52 -0800 (PST)
Received: from starship ([5.28.147.32])
        by smtp.gmail.com with ESMTPSA id v13-20020a056512048d00b0050bbdf9616bsm214270lfq.217.2023.11.30.09.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:36:52 -0800 (PST)
Message-ID: <156f037f96407f77dd71373be504da50b78f671c.camel@redhat.com>
Subject: Re: [PATCH v7 10/26] KVM: x86: Refine xsave-managed guest
 register/MSR reset handling
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Thu, 30 Nov 2023 19:36:49 +0200
In-Reply-To: <20231124055330.138870-11-weijiang.yang@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-11-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-24 at 00:53 -0500, Yang Weijiang wrote:
> Tweak the code a bit to facilitate resetting more xstate components in
> the future, e.g., adding CET's xstate-managed MSRs.
> 
> No functional change intended.
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/x86.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b9c2c0cd4cf5..16b4f2dd138a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12132,6 +12132,11 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>  		static_branch_dec(&kvm_has_noapic_vcpu);
>  }
>  
> +static inline bool is_xstate_reset_needed(void)
> +{
> +	return kvm_cpu_cap_has(X86_FEATURE_MPX);
> +}
> +
>  void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  {
>  	struct kvm_cpuid_entry2 *cpuid_0x1;
> @@ -12189,7 +12194,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  	kvm_async_pf_hash_reset(vcpu);
>  	vcpu->arch.apf.halted = false;
>  
> -	if (vcpu->arch.guest_fpu.fpstate && kvm_mpx_supported()) {
> +	if (vcpu->arch.guest_fpu.fpstate && is_xstate_reset_needed()) {
>  		struct fpstate *fpstate = vcpu->arch.guest_fpu.fpstate;
>  
>  		/*
> @@ -12199,8 +12204,12 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  		if (init_event)
>  			kvm_put_guest_fpu(vcpu);
>  
> -		fpstate_clear_xstate_component(fpstate, XFEATURE_BNDREGS);
> -		fpstate_clear_xstate_component(fpstate, XFEATURE_BNDCSR);
> +		if (kvm_cpu_cap_has(X86_FEATURE_MPX)) {
> +			fpstate_clear_xstate_component(fpstate,
> +						       XFEATURE_BNDREGS);
> +			fpstate_clear_xstate_component(fpstate,
> +						       XFEATURE_BNDCSR);
> +		}
>  
>  		if (init_event)
>  			kvm_load_guest_fpu(vcpu);

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

