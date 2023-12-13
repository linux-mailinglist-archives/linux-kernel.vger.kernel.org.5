Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503518121A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbjLMWkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjLMWkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:40:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F9C111
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702507224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U6q+SujD6T+0deWVz0gmo5g4QASJTJJ5VQOUwvjSYJk=;
        b=MZy7C13rUA8xtbdBueinfeqCEFrRGPCuID0gTR/4CDOQdmjoe7VE+AkVislmci2YIuDw4B
        /AEZA3lMevUb3U0K8VaJRdcGBXT9eQx/vx/TLiSBzYFMAm/4O1pS9lLfGYfCWD6ttyRa3N
        inzj7Cge4n1mM69AV3aVZduZXgAUjJU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-N9tP6_86NX6VW8dUv98Tnw-1; Wed, 13 Dec 2023 17:40:22 -0500
X-MC-Unique: N9tP6_86NX6VW8dUv98Tnw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3334286b720so6218553f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507221; x=1703112021;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U6q+SujD6T+0deWVz0gmo5g4QASJTJJ5VQOUwvjSYJk=;
        b=tA4A13kBWxBejjsrta73JfsscKSkjowOKryBCyk89tluYO26FL8iTfbu2hcBQfCeME
         nodq8rTU6Mt/lzG5l3n0zOQeWm7n129Q63RNiY50A7NuTjIbpLkxACyOa3DvhjsaMv5A
         2ythwJpeYOKy/441PuEx9vIzyxi7L/z8n5Fp196sxBAauoJ5BdEhdTdGkbsVc7iW+AwV
         EoBnvWxqZnFRfjn+QBHFrsv33RI+2O1CuVY9pJkhSmYf1Llc1KtyVtx3vlxMIbdMK554
         6okP+61PkHN33rpNu1aABv4bMIf/pgcLvE9H910CBgJI/cbsz/ghgjXoe9lFAhUTChjS
         Z1Rw==
X-Gm-Message-State: AOJu0YzkvQxMYZc8jxlNSe3k5Lz58RO7cG3O8kSotMkZPbwwe9i1conM
        +4ntmU7GapVtN3tJAQUVsxLsU3fSOZvHhyYCCWcZ8JCB9eOtfDZ9B1w+otqqxENnRu0VyThlTCv
        7674Jy2DB2kJKJVbqM1Idzp3N5ZlC19ah
X-Received: by 2002:a05:600c:1649:b0:40c:328f:e0ec with SMTP id o9-20020a05600c164900b0040c328fe0ecmr2082715wmn.310.1702507221201;
        Wed, 13 Dec 2023 14:40:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQCGkL5TGtKZoyg8vvA0GfoknejAmJIQbtGc5w1kZf8ypAOMUXwoxjQJA9XmdBve+KRVtdig==
X-Received: by 2002:a05:600c:1649:b0:40c:328f:e0ec with SMTP id o9-20020a05600c164900b0040c328fe0ecmr2082713wmn.310.1702507220970;
        Wed, 13 Dec 2023 14:40:20 -0800 (PST)
Received: from starship ([77.137.131.62])
        by smtp.gmail.com with ESMTPSA id be9-20020a05600c1e8900b0040596352951sm24529011wmb.5.2023.12.13.14.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:40:20 -0800 (PST)
Message-ID: <61530aa466a038efb0e648da002432d02a9692a3.camel@redhat.com>
Subject: Re: [PATCH v2 2/3] KVM: X86: Add a capability to configure bus
 frequency for APIC timer
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        erdemaktas@google.com, Sean Christopherson <seanjc@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Jim Mattson <jmattson@google.com>
Date:   Thu, 14 Dec 2023 00:40:18 +0200
In-Reply-To: <88774b9dc566c89141bf75aef341fdf7e238e60b.1699936040.git.isaku.yamahata@intel.com>
References: <cover.1699936040.git.isaku.yamahata@intel.com>
         <88774b9dc566c89141bf75aef341fdf7e238e60b.1699936040.git.isaku.yamahata@intel.com>
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

On Mon, 2023-11-13 at 20:35 -0800, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Add KVM_CAP_X86_BUS_FREQUENCY_CONTROL capability to configure the core
> crystal clock (or processor's bus clock) for APIC timer emulation.  Allow
> KVM_ENABLE_CAPABILITY(KVM_CAP_X86_BUS_FREQUENCY_CONTROL) to set the
> frequency.
> 
> TDX virtualizes CPUID[0x15] for the core crystal clock to be 25MHz.  The
> x86 KVM hardcodes its frequency for APIC timer to be 1GHz.  This mismatch
> causes the vAPIC timer to fire earlier than the guest expects. [1] The KVM
> APIC timer emulation uses hrtimer, whose unit is nanosecond.  Make the
> parameter configurable for conversion from the TMICT value to nanosecond.
> 
> This patch doesn't affect the TSC deadline timer emulation.  The TSC
> deadline emulation path records its expiring TSC value and calculates the
> expiring time in nanoseconds.  The APIC timer emulation path calculates the
> TSC value from the TMICT register value and uses the TSC deadline timer
> path.  This patch touches the APIC timer-specific code but doesn't touch
> common logic.

Nitpick: To be honest IMHO the paragraph about tsc deadline is redundant, because by definition (x86 spec)
the tsc deadline timer doesn't use APIC bus frequency.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

> 
> [1] https://lore.kernel.org/lkml/20231006011255.4163884-1-vannapurve@google.com/
> Reported-by: Vishal Annapurve <vannapurve@google.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
> Changes v2:
> - Add check if vcpu isn't created.
> - Add check if lapic chip is in-kernel emulation.
> - Fix build error for i386
> - Add document to api.rst
> - typo in the commit message
> ---
>  Documentation/virt/kvm/api.rst | 14 ++++++++++++++
>  arch/x86/kvm/x86.c             | 35 ++++++++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h       |  1 +
>  3 files changed, 50 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 7025b3751027..cc976df2651e 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -7858,6 +7858,20 @@ This capability is aimed to mitigate the threat that malicious VMs can
>  cause CPU stuck (due to event windows don't open up) and make the CPU
>  unavailable to host or other VMs.
>  
> +7.34 KVM_CAP_X86_BUS_FREQUENCY_CONTROL
> +--------------------------------------
> +
> +:Architectures: x86
> +:Target: VM
> +:Parameters: args[0] is the value of apic bus clock frequency
> +:Returns: 0 on success, -EINVAL if args[0] contains invalid value for the
> +          frequency, or -ENXIO if virtual local APIC isn't enabled by
> +          KVM_CREATE_IRQCHIP, or -EBUSY if any vcpu is created.
> +
> +This capability sets the APIC bus clock frequency (or core crystal clock
> +frequency) for kvm to emulate APIC in the kernel.  The default value is 1000000
> +(1GHz).
> +
>  8. Other capabilities.
>  ======================
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a9f4991b3e2e..a8fb862c4f8e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4625,6 +4625,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_ENABLE_CAP:
>  	case KVM_CAP_VM_DISABLE_NX_HUGE_PAGES:
>  	case KVM_CAP_IRQFD_RESAMPLE:
> +	case KVM_CAP_X86_BUS_FREQUENCY_CONTROL:
>  		r = 1;
>  		break;
>  	case KVM_CAP_EXIT_HYPERCALL:
> @@ -6616,6 +6617,40 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  		}
>  		mutex_unlock(&kvm->lock);
>  		break;
> +	case KVM_CAP_X86_BUS_FREQUENCY_CONTROL: {
> +		u64 bus_frequency = cap->args[0];
> +		u64 bus_cycle_ns;
> +
> +		if (!bus_frequency)
> +			return -EINVAL;
> +		/* CPUID[0x15] only support 32bits.  */
> +		if (bus_frequency != (u32)bus_frequency)
> +			return -EINVAL;
> +
> +		/* Cast to avoid 64bit division on 32bit platform. */
> +		bus_cycle_ns = 1000000000UL / (u32)bus_frequency;
> +		if (!bus_cycle_ns)
> +			return -EINVAL;
> +
> +		r = 0;
> +		mutex_lock(&kvm->lock);
> +		/*
> +		 * Don't allow to change the frequency dynamically during vcpu
> +		 * running to avoid potentially bizarre behavior.
> +		 */
> +		if (kvm->created_vcpus)
> +			r = -EBUSY;
> +		/* This is for in-kernel vAPIC emulation. */
> +		else if (!irqchip_in_kernel(kvm))
> +			r = -ENXIO;
> +
> +		if (!r) {
> +			kvm->arch.apic_bus_cycle_ns = bus_cycle_ns;
> +			kvm->arch.apic_bus_frequency = bus_frequency;
> +		}
> +		mutex_unlock(&kvm->lock);
> +		return r;
> +	}
>  	default:
>  		r = -EINVAL;
>  		break;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 211b86de35ac..d74a057df173 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1201,6 +1201,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE 228
>  #define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
>  #define KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES 230
> +#define KVM_CAP_X86_BUS_FREQUENCY_CONTROL 231
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  


