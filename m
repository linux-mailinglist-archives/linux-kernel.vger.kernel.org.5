Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED0A7FFBF2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376585AbjK3UHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjK3UHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:07:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9A510F8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701374841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rvL/GRiB3ohW1/RXmKMbz07n0kcGAk0YLHsA8KF+86I=;
        b=Oe2608juHYbrik11HiIco3nAZ4A7qfGQNIGabqEXfSVIC4oqOO7L8Bhs0i/4Z0T3QmDcZd
        u8EReOlhUXzv1Y1zLfn/4KxF0DJxhATwNr4NRMlAKnpeILkZN5f7gf1gDhjdiVvLPVc8kI
        lnwddbHTftidc7qExb14Z8ttMqcIwbY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-Bhz7OoEHOmC6X2pJebCyXQ-1; Thu, 30 Nov 2023 15:07:19 -0500
X-MC-Unique: Bhz7OoEHOmC6X2pJebCyXQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a18907682bfso104410966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701374838; x=1701979638;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rvL/GRiB3ohW1/RXmKMbz07n0kcGAk0YLHsA8KF+86I=;
        b=bJd2mK2WdLutIOqyAc4plLl4qSpwYlfV5R4hR5fyZmPE9CWyrhTwbOTcxitBS5cFJX
         EN0/8f7olDfiQ4fNTuw6rFovQIE0uB/V6/kXt9DXzKxh8hoh+yoMmRKiOzWxCl7ZZaIW
         9cZO3QgDUz5gYEKFWsHpAheklm/Vj4RlnulrgGFBaeIkHUifIYroQK5AqiXeHwTyfRDH
         eqKCw1IiKkKKlaO3CcicDW/WM3U6qRQ41RMUByGCEIo8YojSIF0sc81INNVDrPGb8TX9
         QwT/RSY7b0fAvZsAX+tSqtOUDrskE7pWvIepXUnONdC88CtDrBnDcE17+nTZWUem+NrX
         VVlQ==
X-Gm-Message-State: AOJu0YxmjaAzha+/9ywqS1FSkVFASOi/5ZGJed4CmoRu2QFHnXqgtpef
        OYQiWgXU5o7of84nsMpFXeCEe0KW+ZXOU/2LhkvJm9MNdb69qtxqHulzb30MAlRJijutn7LzXr8
        J42GkelpelSZAEw7R1TROKjcilVKGdQRT
X-Received: by 2002:a17:906:1043:b0:a19:a1ba:da4a with SMTP id j3-20020a170906104300b00a19a1bada4amr47415ejj.113.1701374838437;
        Thu, 30 Nov 2023 12:07:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyKvgHz7todxCgJJegCikLcKqPimvWknXUdQe2aeHXvFyHNzcrR9oL14XVeBMt7QmSk55gZQ==
X-Received: by 2002:a05:6512:368a:b0:50b:d3ac:2889 with SMTP id d10-20020a056512368a00b0050bd3ac2889mr1039lfs.44.1701366099951;
        Thu, 30 Nov 2023 09:41:39 -0800 (PST)
Received: from starship ([5.28.147.32])
        by smtp.gmail.com with ESMTPSA id h23-20020ac25977000000b0050a765b7e81sm213944lfp.236.2023.11.30.09.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:41:39 -0800 (PST)
Message-ID: <cfe2b18af68ed258ded12f1aa58bea467e380d8e.camel@redhat.com>
Subject: Re: [PATCH v7 20/26] KVM: VMX: Emulate read and write to CET MSRs
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Thu, 30 Nov 2023 19:41:37 +0200
In-Reply-To: <20231124055330.138870-21-weijiang.yang@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-21-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-24 at 00:53 -0500, Yang Weijiang wrote:
> Add emulation interface for CET MSR access. The emulation code is split
> into common part and vendor specific part. The former does common checks
> for MSRs, e.g., accessibility, data validity etc., then pass the operation
> to either XSAVE-managed MSRs via the helpers or CET VMCS fields.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 18 +++++++++
>  arch/x86/kvm/x86.c     | 88 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index f6ad5ba5d518..554f665e59c3 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2111,6 +2111,15 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		else
>  			msr_info->data = vmx->pt_desc.guest.addr_a[index / 2];
>  		break;
> +	case MSR_IA32_S_CET:
> +		msr_info->data = vmcs_readl(GUEST_S_CET);
> +		break;
> +	case MSR_KVM_SSP:
> +		msr_info->data = vmcs_readl(GUEST_SSP);
> +		break;
> +	case MSR_IA32_INT_SSP_TAB:
> +		msr_info->data = vmcs_readl(GUEST_INTR_SSP_TABLE);
> +		break;
>  	case MSR_IA32_DEBUGCTLMSR:
>  		msr_info->data = vmcs_read64(GUEST_IA32_DEBUGCTL);
>  		break;
> @@ -2420,6 +2429,15 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		else
>  			vmx->pt_desc.guest.addr_a[index / 2] = data;
>  		break;
> +	case MSR_IA32_S_CET:
> +		vmcs_writel(GUEST_S_CET, data);
> +		break;
> +	case MSR_KVM_SSP:
> +		vmcs_writel(GUEST_SSP, data);
> +		break;
> +	case MSR_IA32_INT_SSP_TAB:
> +		vmcs_writel(GUEST_INTR_SSP_TABLE, data);
> +		break;
>  	case MSR_IA32_PERF_CAPABILITIES:
>  		if (data && !vcpu_to_pmu(vcpu)->version)
>  			return 1;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 74d2d00a1681..5792ed16e61b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1847,6 +1847,36 @@ bool kvm_msr_allowed(struct kvm_vcpu *vcpu, u32 index, u32 type)
>  }
>  EXPORT_SYMBOL_GPL(kvm_msr_allowed);
>  
> +#define CET_US_RESERVED_BITS		GENMASK(9, 6)
> +#define CET_US_SHSTK_MASK_BITS		GENMASK(1, 0)
> +#define CET_US_IBT_MASK_BITS		(GENMASK_ULL(5, 2) | GENMASK_ULL(63, 10))
> +#define CET_US_LEGACY_BITMAP_BASE(data)	((data) >> 12)
> +
> +static bool is_set_cet_msr_allowed(struct kvm_vcpu *vcpu, u32 index, u64 data,
> +				   bool host_initiated)
> +{
> +	bool msr_ctrl = index == MSR_IA32_S_CET || index == MSR_IA32_U_CET;
> +
> +	if (guest_can_use(vcpu, X86_FEATURE_SHSTK))
> +		return true;
> +
> +	if (msr_ctrl && guest_can_use(vcpu, X86_FEATURE_IBT))
> +		return true;
> +
> +	/*
> +	 * If KVM supports the MSR, i.e. has enumerated the MSR existence to
> +	 * userspace, then userspace is allowed to write '0' irrespective of
> +	 * whether or not the MSR is exposed to the guest.
> +	 */
> +	if (!host_initiated || data)
> +		return false;
> +
> +	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK))
> +		return true;
> +
> +	return msr_ctrl && kvm_cpu_cap_has(X86_FEATURE_IBT);

This is reasonable.

> +}
> +
>  /*
>   * Write @data into the MSR specified by @index.  Select MSR specific fault
>   * checks are bypassed if @host_initiated is %true.
> @@ -1906,6 +1936,43 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
>  
>  		data = (u32)data;
>  		break;
> +	case MSR_IA32_U_CET:
> +	case MSR_IA32_S_CET:
> +		if (!is_set_cet_msr_allowed(vcpu, index, data, host_initiated))
> +			return 1;
> +		if (data & CET_US_RESERVED_BITS)
> +			return 1;
> +		if (!guest_can_use(vcpu, X86_FEATURE_SHSTK) &&
> +		    (data & CET_US_SHSTK_MASK_BITS))
> +			return 1;
> +		if (!guest_can_use(vcpu, X86_FEATURE_IBT) &&
> +		    (data & CET_US_IBT_MASK_BITS))
> +			return 1;
> +		if (!IS_ALIGNED(CET_US_LEGACY_BITMAP_BASE(data), 4))
> +			return 1;
> +		/* IBT can be suppressed iff the TRACKER isn't WAIT_ENDBR. */
> +		if ((data & CET_SUPPRESS) && (data & CET_WAIT_ENDBR))
> +			return 1;
> +		break;
> +	case MSR_IA32_INT_SSP_TAB:
> +		if (!is_set_cet_msr_allowed(vcpu, index, data, host_initiated) ||
> +		    !guest_cpuid_has(vcpu, X86_FEATURE_LM))
> +			return 1;
> +		if (is_noncanonical_address(data, vcpu))
> +			return 1;
> +		break;
> +	case MSR_KVM_SSP:
> +		if (!host_initiated)
> +			return 1;
> +		fallthrough;
> +	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
> +		if (!is_set_cet_msr_allowed(vcpu, index, data, host_initiated))
> +			return 1;
> +		if (is_noncanonical_address(data, vcpu))
> +			return 1;
> +		if (!IS_ALIGNED(data, 4))
> +			return 1;
> +		break;
>  	}
>  
>  	msr.data = data;
> @@ -1949,6 +2016,19 @@ static int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
>  		    !guest_cpuid_has(vcpu, X86_FEATURE_RDPID))
>  			return 1;
>  		break;
> +	case MSR_IA32_INT_SSP_TAB:
> +		if (!guest_can_use(vcpu, X86_FEATURE_SHSTK) ||
> +		    !guest_cpuid_has(vcpu, X86_FEATURE_LM))
> +			return 1;
> +		break;
> +	case MSR_KVM_SSP:
> +		if (!host_initiated)
> +			return 1;
> +		fallthrough;
> +	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
> +		if (!guest_can_use(vcpu, X86_FEATURE_SHSTK))
> +			return 1;
> +		break;
>  	}
>  
>  	msr.index = index;
> @@ -4118,6 +4198,10 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		vcpu->arch.guest_fpu.xfd_err = data;
>  		break;
>  #endif
> +	case MSR_IA32_U_CET:
> +	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
> +		kvm_set_xstate_msr(vcpu, msr_info);
> +		break;
>  	default:
>  		if (kvm_pmu_is_valid_msr(vcpu, msr))
>  			return kvm_pmu_set_msr(vcpu, msr_info);
> @@ -4475,6 +4559,10 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		msr_info->data = vcpu->arch.guest_fpu.xfd_err;
>  		break;
>  #endif
> +	case MSR_IA32_U_CET:
> +	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
> +		kvm_get_xstate_msr(vcpu, msr_info);
> +		break;
>  	default:
>  		if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
>  			return kvm_pmu_get_msr(vcpu, msr_info);

Overall looks OK to me, although I still object to the idea of having the MSR_KVM_SSP.

Best regards,
	Maxim Levitsky


