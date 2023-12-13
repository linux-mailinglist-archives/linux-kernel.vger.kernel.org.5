Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12B481219E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442822AbjLMWjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjLMWjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:39:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB73CD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702507188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wm5p9I7UJkzSD0p8OE27VhydPzQpwjBdq8jwEHxdPN4=;
        b=hrS/6Ha7t2N1VdUdGJ5IgRe7iOLaZVQOFZxALFWbyxb+8MxWjOsQ+h73fON7uJsX/nKEKT
        HKyS3CLY7urGDMWEHXPKAP9YYms76Atx2pPZzPaJFsqQsmmHu5gjUYybwcHPXn8SLBFBsT
        iJdckcyp35eQTqQL2IbO9nKtra1A44M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-mclK2i5iO9mkz-Sx23z9sA-1; Wed, 13 Dec 2023 17:39:47 -0500
X-MC-Unique: mclK2i5iO9mkz-Sx23z9sA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33342edbd15so4936301f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:39:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507185; x=1703111985;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wm5p9I7UJkzSD0p8OE27VhydPzQpwjBdq8jwEHxdPN4=;
        b=P+5iIufoHYkBAW6WcLMPemoTVwCtIuR+iGbtTVPSQZACuye2kJUpBpUVQz6+V4h64F
         QUylNfY4tsSLpSVPu91WSmNPQWLZ6ldYLcOG+Zbe0gwUZ6pPxZyxnnbMGLypok2xEv8A
         /BCXZJ/zMm9/gXhn/VfxTQWfgRqRSfUTl6KNWDcAPLK0qhWhwvuHo0IyjdKqg1wYA+Hq
         ElIksaLiWdnoXG1gAJarMdY6Bmm1k3s5Ir2p1X/CeyeUCsGQNDDPkNWJbbTNPJVlSIrC
         X+9kG3rP6HgoMiSQzCx2IIn1x9nL1507BvG1LqagooMZvFT0TZuDA1Woo+cb1AFBKgZh
         W6RQ==
X-Gm-Message-State: AOJu0YxBA3BazK5ifzZC/IC4oZDRqM4FGN+Imgu4dr3xb7PTKiWj3Z1J
        RJZp0O28/XbjJJt2rynjsSSuXsuTTTVp8ivVaRhOhLAN9uO6tJacuzG1kuBniifBdjKGeblsS91
        Dal7O1nQ6gD+668yyBZg7p+cH
X-Received: by 2002:adf:f789:0:b0:336:3896:3212 with SMTP id q9-20020adff789000000b0033638963212mr1056500wrp.42.1702507184831;
        Wed, 13 Dec 2023 14:39:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2YvVojA6u3l32cs2cxNmacCsVUAdngyGOO/S6aUI/fOAWaC28mwX0n+N+OTer5XvsMi+22w==
X-Received: by 2002:adf:f789:0:b0:336:3896:3212 with SMTP id q9-20020adff789000000b0033638963212mr1056492wrp.42.1702507184522;
        Wed, 13 Dec 2023 14:39:44 -0800 (PST)
Received: from starship ([77.137.131.62])
        by smtp.gmail.com with ESMTPSA id s18-20020a5d4ed2000000b00336421f1818sm1882905wrv.112.2023.12.13.14.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:39:44 -0800 (PST)
Message-ID: <938efd3cfcb25d828deab0cc0ba797177cc69602.camel@redhat.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: Make the hardcoded APIC bus frequency
 vm variable
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        erdemaktas@google.com, Sean Christopherson <seanjc@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Jim Mattson <jmattson@google.com>
Date:   Thu, 14 Dec 2023 00:39:42 +0200
In-Reply-To: <1c12f378af7de16d7895f8badb18c3b1715e9271.1699936040.git.isaku.yamahata@intel.com>
References: <cover.1699936040.git.isaku.yamahata@intel.com>
         <1c12f378af7de16d7895f8badb18c3b1715e9271.1699936040.git.isaku.yamahata@intel.com>
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

On Mon, 2023-11-13 at 20:35 -0800, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> TDX virtualizes the advertised APIC bus frequency to be 25MHz. 

Can you explain a bit better why TDX needs this? I am not familiar
with TDX well enough yet to fully understand.

AFAIK, the guest writes the TMICT, that makes the KVM set up a HR timer,
and KVM is free to use any apic frequency to determine the deadline of that timer,
and then once the HR timer fires, KVM injects an interrupt to the guest.

Are some parts of this process overridden by the TDX?

I am sure that there is a good reason to do this, but I would be very happy
to see a detailed explanation in the changelog for future readers who
might know nothing about TDX.


>  The KVM
> hardcodedes it to be 1GHz.  This mismatch causes the vAPIC timer to fire
> earlier than the TDX guest expects.

Here too, what do you mean by "TDX guest expects"? Is the APIC frequency
given to the guest using some TDX specific way like HV_X64_MSR_APIC_FREQUENCY? 

>   In order to reconcile this mismatch,
> make the frequency configurable for the user space VMM.  As the first step,
> Replace the constants with the VM value in struct kvm.



> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
> Changes v2:
> - no change
> ---
>  arch/x86/include/asm/kvm_host.h | 2 ++
>  arch/x86/kvm/hyperv.c           | 2 +-
>  arch/x86/kvm/lapic.c            | 6 ++++--
>  arch/x86/kvm/lapic.h            | 4 ++--
>  arch/x86/kvm/x86.c              | 2 ++
>  5 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index d7036982332e..f2b1c6b3fb11 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1334,6 +1334,8 @@ struct kvm_arch {
>  
>  	u32 default_tsc_khz;
>  	bool user_set_tsc;
> +	u64 apic_bus_cycle_ns;
> +	u64 apic_bus_frequency;
>  
>  	seqcount_raw_spinlock_t pvclock_sc;
>  	bool use_master_clock;
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 238afd7335e4..995ce2c74ce0 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1687,7 +1687,7 @@ static int kvm_hv_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
>  		data = (u64)vcpu->arch.virtual_tsc_khz * 1000;
>  		break;
>  	case HV_X64_MSR_APIC_FREQUENCY:
> -		data = APIC_BUS_FREQUENCY;
> +		data = vcpu->kvm->arch.apic_bus_frequency;
>  		break;
>  	default:
>  		kvm_pr_unimpl_rdmsr(vcpu, msr);
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 245b20973cae..73956b0ac1f1 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1542,7 +1542,8 @@ static u32 apic_get_tmcct(struct kvm_lapic *apic)
>  		remaining = 0;
>  
>  	ns = mod_64(ktime_to_ns(remaining), apic->lapic_timer.period);
> -	return div64_u64(ns, (APIC_BUS_CYCLE_NS * apic->divide_count));
> +	return div64_u64(ns, (apic->vcpu->kvm->arch.apic_bus_cycle_ns *
> +			      apic->divide_count));
>  }
>  
>  static void __report_tpr_access(struct kvm_lapic *apic, bool write)
> @@ -1960,7 +1961,8 @@ static void start_sw_tscdeadline(struct kvm_lapic *apic)
>  
>  static inline u64 tmict_to_ns(struct kvm_lapic *apic, u32 tmict)
>  {
> -	return (u64)tmict * APIC_BUS_CYCLE_NS * (u64)apic->divide_count;
> +	return (u64)tmict * apic->vcpu->kvm->arch.apic_bus_cycle_ns *
> +		(u64)apic->divide_count;
>  }
>  
>  static void update_target_expiration(struct kvm_lapic *apic, uint32_t old_divisor)
> diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
> index 0a0ea4b5dd8c..3a425ea2a515 100644
> --- a/arch/x86/kvm/lapic.h
> +++ b/arch/x86/kvm/lapic.h
> @@ -16,8 +16,8 @@
>  #define APIC_DEST_NOSHORT		0x0
>  #define APIC_DEST_MASK			0x800
>  
> -#define APIC_BUS_CYCLE_NS       1
> -#define APIC_BUS_FREQUENCY      (1000000000ULL / APIC_BUS_CYCLE_NS)
> +#define APIC_BUS_CYCLE_NS_DEFAULT	1
> +#define APIC_BUS_FREQUENCY_DEFAULT	(1000000000ULL / APIC_BUS_CYCLE_NS_DEFAULT)
>  
>  #define APIC_BROADCAST			0xFF
>  #define X2APIC_BROADCAST		0xFFFFFFFFul
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 2c924075f6f1..a9f4991b3e2e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12466,6 +12466,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
>  
>  	kvm->arch.default_tsc_khz = max_tsc_khz ? : tsc_khz;
> +	kvm->arch.apic_bus_cycle_ns = APIC_BUS_CYCLE_NS_DEFAULT;
> +	kvm->arch.apic_bus_frequency = APIC_BUS_FREQUENCY_DEFAULT;
>  	kvm->arch.guest_can_read_msr_platform_info = true;
>  	kvm->arch.enable_pmu = enable_pmu;
>  

Only one minor nitpick: We might not need 'apic_bus_frequency' and instead have
it calculated from apic_bus_cycle_ns? (to have single source of truth)

Frequency is only used by HV_X64_MSR_APIC_FREQUENCY, and I don't think that HyperV guests read
this MSR often, nor that a division will make a dent in the emulation time of this msr,
even if they do.

But if you prefer, I won't mind either.

Best regards,
	Maxim Levitsky




