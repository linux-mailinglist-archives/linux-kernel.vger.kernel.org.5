Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33717DD5AF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376547AbjJaR6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347030AbjJaR6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2306F118
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698775040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jwM6l4UP2hePaKuVtl/torPOAgeleMKMhh2GlXx3fG0=;
        b=i5TBoDILMCH2UdO/kki7Ms540ZaGZj1ceCPbOfG6xEVQvoCsPtHJgOyTiBB6Thsqb+T+VR
        V7L10xNCWjRu80JcXcK64PduqJREJEeT/FmX2jYhkIKnYv+yc/X9rhAahI+v0rCdXvpuZE
        lx9wY2oZsMYd9UntyRv4bSn1hVKdq3k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-9rmsSW4wOQOg8NaxvKY-Tw-1; Tue, 31 Oct 2023 13:57:18 -0400
X-MC-Unique: 9rmsSW4wOQOg8NaxvKY-Tw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40853e14f16so44139505e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698775037; x=1699379837;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jwM6l4UP2hePaKuVtl/torPOAgeleMKMhh2GlXx3fG0=;
        b=Nmq5hk0JToVvn3AJHnz/GXWDYOb5TPcpcpsga2FqvDrFftNlF+ctyysrQP+I7bMmDS
         pp66b7oQp9TUjuK69L94+sI51+HEopJkfCSct+Ch+m3e3pjZIEVAj2Ov0kAklxnrq3Qr
         nOXA6qbJSl7r7KfovAQU+jQ8+CWf75sUZfN5O2q6QT74f0GQ0UFd0tbbZgTLeoP1L3mY
         dWsHeG9a45cM9yHdY5UDD38fk1cjqaAK4qL5x6ytAjSVz+sLHk7lnTmrUWvAtx9roHo2
         gEqkGMn4ZkLaqWQvKKz3d/0EyEWH/kDHUClzaIUUaWkC6bhmGgFxv3Z9XESZj96b1/5r
         V3zA==
X-Gm-Message-State: AOJu0YwwldStYC2GWXHyjsi7dzQdYqKqZyGtj/fD4G0x/xDsc/heeqbl
        rveWVzr2R8+j5+3yaplNKH1rrQyz8nM9t07txwWIsJjMR2uiSSGLX3w/PGlQPxkqJgCNmbWhrjv
        sO+cHrI4xrU+jJK27FpdNc4Gs
X-Received: by 2002:a05:600c:1913:b0:408:3c10:ad47 with SMTP id j19-20020a05600c191300b004083c10ad47mr10919174wmq.40.1698775037580;
        Tue, 31 Oct 2023 10:57:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGldAPCxh5HZ96ed5VhGrfk/0fS3sb6eA8cyFdWcD3ew/QHd5flUQgCQuE/1xqBkV/N5rawsQ==
X-Received: by 2002:a05:600c:1913:b0:408:3c10:ad47 with SMTP id j19-20020a05600c191300b004083c10ad47mr10919162wmq.40.1698775037220;
        Tue, 31 Oct 2023 10:57:17 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id l12-20020adffe8c000000b0030647449730sm2017630wrr.74.2023.10.31.10.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:57:16 -0700 (PDT)
Message-ID: <2b17583bad87cfd11cd7bc1f824869669833a072.camel@redhat.com>
Subject: Re: [PATCH v6 24/25] KVM: nVMX: Introduce new VMX_BASIC bit for
 event error_code delivery to L1
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Tue, 31 Oct 2023 19:57:14 +0200
In-Reply-To: <20230914063325.85503-25-weijiang.yang@intel.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-25-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> Per SDM description(Vol.3D, Appendix A.1):
> "If bit 56 is read as 1, software can use VM entry to deliver a hardware
> exception with or without an error code, regardless of vector"
> 
> Modify has_error_code check before inject events to nested guest. Only
> enforce the check when guest is in real mode, the exception is not hard
> exception and the platform doesn't enumerate bit56 in VMX_BASIC, in all
> other case ignore the check to make the logic consistent with SDM.
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 22 ++++++++++++++--------
>  arch/x86/kvm/vmx/nested.h |  5 +++++
>  2 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index c5ec0ef51ff7..78a3be394d00 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -1205,9 +1205,9 @@ static int vmx_restore_vmx_basic(struct vcpu_vmx *vmx, u64 data)
>  {
>  	const u64 feature_and_reserved =
>  		/* feature (except bit 48; see below) */
> -		BIT_ULL(49) | BIT_ULL(54) | BIT_ULL(55) |
> +		BIT_ULL(49) | BIT_ULL(54) | BIT_ULL(55) | BIT_ULL(56) |
>  		/* reserved */
> -		BIT_ULL(31) | GENMASK_ULL(47, 45) | GENMASK_ULL(63, 56);
> +		BIT_ULL(31) | GENMASK_ULL(47, 45) | GENMASK_ULL(63, 57);
>  	u64 vmx_basic = vmcs_config.nested.basic;
>  
>  	if (!is_bitwise_subset(vmx_basic, data, feature_and_reserved))
> @@ -2846,12 +2846,16 @@ static int nested_check_vm_entry_controls(struct kvm_vcpu *vcpu,
>  		    CC(intr_type == INTR_TYPE_OTHER_EVENT && vector != 0))
>  			return -EINVAL;
>  
> -		/* VM-entry interruption-info field: deliver error code */
> -		should_have_error_code =
> -			intr_type == INTR_TYPE_HARD_EXCEPTION && prot_mode &&
> -			x86_exception_has_error_code(vector);
> -		if (CC(has_error_code != should_have_error_code))
> -			return -EINVAL;
> +		if (!prot_mode || intr_type != INTR_TYPE_HARD_EXCEPTION ||
> +		    !nested_cpu_has_no_hw_errcode_cc(vcpu)) {
> +			/* VM-entry interruption-info field: deliver error code */
> +			should_have_error_code =
> +				intr_type == INTR_TYPE_HARD_EXCEPTION &&
> +				prot_mode &&
> +				x86_exception_has_error_code(vector);
> +			if (CC(has_error_code != should_have_error_code))
> +				return -EINVAL;
> +		}
>  
>  		/* VM-entry exception error code */
>  		if (CC(has_error_code &&
> @@ -6968,6 +6972,8 @@ static void nested_vmx_setup_basic(struct nested_vmx_msrs *msrs)
>  
>  	if (cpu_has_vmx_basic_inout())
>  		msrs->basic |= VMX_BASIC_INOUT;
> +	if (cpu_has_vmx_basic_no_hw_errcode())
> +		msrs->basic |= VMX_BASIC_NO_HW_ERROR_CODE_CC;
>  }
>  
>  static void nested_vmx_setup_cr_fixed(struct nested_vmx_msrs *msrs)
> diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
> index b4b9d51438c6..26842da6857d 100644
> --- a/arch/x86/kvm/vmx/nested.h
> +++ b/arch/x86/kvm/vmx/nested.h
> @@ -284,6 +284,11 @@ static inline bool nested_cr4_valid(struct kvm_vcpu *vcpu, unsigned long val)
>  	       __kvm_is_valid_cr4(vcpu, val);
>  }
>  
> +static inline bool nested_cpu_has_no_hw_errcode_cc(struct kvm_vcpu *vcpu)
> +{
> +	return to_vmx(vcpu)->nested.msrs.basic & VMX_BASIC_NO_HW_ERROR_CODE_CC;
> +}
> +
>  /* No difference in the restrictions on guest and host CR4 in VMX operation. */
>  #define nested_guest_cr4_valid	nested_cr4_valid
>  #define nested_host_cr4_valid	nested_cr4_valid

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




