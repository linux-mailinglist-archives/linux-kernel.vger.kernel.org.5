Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217EB7FB2AA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjK1H0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbjK1H0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:26:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE37D45
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701156368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C5IfKQ0g84TQ0CBoWOqqFsM6EdM4fH6opAzeKUDu0Ps=;
        b=FWOV07JuCOAKwrMiEhXvEtZWEtdas78DC5YKWX+tWkt56o36na6Zqn9n600kvPvLPZ9CNL
        kVt63Yp++8HGoZjQkEhSAwUHvjXBGr/j33EtGfe08WcA+IrQaGkD6eUjvKNH2+rW2xOcCX
        0uIFmxRn8S+D5i7fEYPDo49RoDwLcXw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-FI3WizTRMw2095VuWuqw0g-1; Tue, 28 Nov 2023 02:26:06 -0500
X-MC-Unique: FI3WizTRMw2095VuWuqw0g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-332ed7c0955so2919816f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:26:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156366; x=1701761166;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5IfKQ0g84TQ0CBoWOqqFsM6EdM4fH6opAzeKUDu0Ps=;
        b=Z8HGbdKtuXekdObz+Vn5VQrFhhbD20umqHQuLt/A2nyaO1AOcy8iBHUGokVR5Q4tZ0
         xdZ6fmBNoHWpwxjjEe58JeOCcTKE1zZnM/+vVBhRD1oKhqiZlUdNYstSAHjf1Uah/VPe
         uyJjfHRFNhbOt1czHEjnJ3i/85dOSzRTyOAngwCSevhi0jnAbBvKsnUDQL6RBmTgvTve
         Y9VQIx0Wm0m3VG8Amb3kAqzQigUSGdu/ooZR62Jq/0yQ+5KRzKUqm7fZiXrFt/FTAb/O
         rXiyyHVRAPQcbZLMM7Zfrm3yhD1VZaRTdTDsAuL11J184WqsxtpknVXU0S4Hay5U5ChY
         WjUg==
X-Gm-Message-State: AOJu0Yyl/rpygTdr2RspfNo6DCl2W7J77r1HY51oTRLbupIRJybXXJeN
        M5thY7HDM6aWiImaM3pzR53bfvNnU5hZ4mHSth4L719jQL03BpNQJqgSdWcZu+NgsoY1aezIWkt
        zsQwGNTutUL+AJ5KM/3xNr3wH
X-Received: by 2002:a05:6000:181b:b0:332:ca1e:679f with SMTP id m27-20020a056000181b00b00332ca1e679fmr9682388wrh.52.1701156365793;
        Mon, 27 Nov 2023 23:26:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaJGFX6B/K1UfnpX1yOqrEoYh9k4p+2e/D0ADxJMH+MoA3HjH19LZOIpIrTtOHL2qAxvn/VA==
X-Received: by 2002:a05:6000:181b:b0:332:ca1e:679f with SMTP id m27-20020a056000181b00b00332ca1e679fmr9682371wrh.52.1701156365500;
        Mon, 27 Nov 2023 23:26:05 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id k24-20020a5d5258000000b00332d04514b9sm13962130wrc.95.2023.11.27.23.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:26:05 -0800 (PST)
Message-ID: <e85f7a3542f6ec2bd9fb378c5da699f544dfd805.camel@redhat.com>
Subject: Re: [RFC 10/33] KVM: x86: hyper-v: Introduce KVM_HV_GET_VSM_STATE
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk,
        jgowans@amazon.com, corbert@lwn.net, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, x86@kernel.org,
        linux-doc@vger.kernel.org
Date:   Tue, 28 Nov 2023 09:26:03 +0200
In-Reply-To: <20231108111806.92604-11-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
         <20231108111806.92604-11-nsaenz@amazon.com>
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

On Wed, 2023-11-08 at 11:17 +0000, Nicolas Saenz Julienne wrote:
> HVCALL_GET_VP_REGISTERS exposes the VTL call hypercall page entry
> offsets to the guest. This hypercall is implemented in user-space while
> the hypercall page patching happens in-kernel. So expose it as part of
> the partition wide VSM state.
> 
> NOTE: Alternatively there is the option of sharing this information
> through a VTL KVM device attribute (the device is introduced in
> subsequent patches).
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---
>  arch/x86/include/uapi/asm/kvm.h |  5 +++++
>  arch/x86/kvm/hyperv.c           |  8 ++++++++
>  arch/x86/kvm/hyperv.h           |  2 ++
>  arch/x86/kvm/x86.c              | 18 ++++++++++++++++++
>  include/uapi/linux/kvm.h        |  4 ++++
>  5 files changed, 37 insertions(+)
> 
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index f73d137784d7..370483d5d5fd 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -570,4 +570,9 @@ struct kvm_apic_id_groups {
>  	__u8 n_bits; /* nr of bits used to represent group in the APIC ID */
>  };
>  
> +/* for KVM_HV_GET_VSM_STATE */
> +struct kvm_hv_vsm_state {
> +	__u64 vsm_code_page_offsets;
> +};
> +
>  #endif /* _ASM_X86_KVM_H */
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 2cf430f6ddd8..caaa859932c5 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2990,3 +2990,11 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>  
>  	return 0;
>  }
> +
> +int kvm_vm_ioctl_get_hv_vsm_state(struct kvm *kvm, struct kvm_hv_vsm_state *state)
> +{
> +	struct kvm_hv* hv = &kvm->arch.hyperv;
> +
> +	state->vsm_code_page_offsets = hv->vsm_code_page_offsets.as_u64;
> +	return 0;
> +}
> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
> index 5433107e7cc8..b3d1113efe82 100644
> --- a/arch/x86/kvm/hyperv.h
> +++ b/arch/x86/kvm/hyperv.h
> @@ -261,4 +261,6 @@ static inline bool kvm_hv_vsm_enabled(struct kvm *kvm)
>         return kvm->arch.hyperv.hv_enable_vsm;
>  }
>  
> +int kvm_vm_ioctl_get_hv_vsm_state(struct kvm *kvm, struct kvm_hv_vsm_state *state);
> +
>  #endif
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b0512e433032..57f9c58e1e32 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7132,6 +7132,24 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>  		r = kvm_vm_ioctl_set_apic_id_groups(kvm, &groups);
>  		break;
>  	}
> +	case KVM_HV_GET_VSM_STATE: {
> +		struct kvm_hv_vsm_state vsm_state;
> +
> +		r = -EINVAL;
> +		if (!kvm_hv_vsm_enabled(kvm))
> +			goto out;
> +
> +		r = kvm_vm_ioctl_get_hv_vsm_state(kvm, &vsm_state);
> +		if (r)
> +			goto out;
> +
> +		r = -EFAULT;
> +		if (copy_to_user(argp, &vsm_state, sizeof(vsm_state)))
> +			goto out;
> +
> +		r = 0;
> +		break;
> +	}
>  	default:
>  		r = -ENOTTY;
>  	}
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 168b6ac6ebe5..03f5c08fd7aa 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -2316,4 +2316,8 @@ struct kvm_create_guest_memfd {
>  #define KVM_GUEST_MEMFD_ALLOW_HUGEPAGE		(1ULL << 0)
>  
>  #define KVM_SET_APIC_ID_GROUPS _IOW(KVMIO, 0xd7, struct kvm_apic_id_groups)
> +
> +/* Get/Set Hyper-V VSM state. Available with KVM_CAP_HYPERV_VSM */
> +#define KVM_HV_GET_VSM_STATE _IOR(KVMIO, 0xd5, struct kvm_hv_vsm_state)
> +
>  #endif /* __LINUX_KVM_H */

Looks reasonable but if we do hypercall patching in userspace as I suggested,
we might not need this.

Best regards,
	Maxim Levitsky





