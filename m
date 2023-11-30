Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E2B7FF933
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346199AbjK3SRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjK3SR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:17:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DD7D6C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701368255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CrFEpIsAN5CLxammhD+GAJP9cPsbGGrmnZDHNVsmekk=;
        b=IRUxCG0hGwUQVZejq7gsGv1XZx/OLIprkTRxKsCmmxhIuFgYGzJKVaOSOb035pRcOivPMA
        z1ETQjLBCYGRTk/KoOTgwe3BY305ToBwN2hngdla+31UO5oG0w/+6MeQp5hpqJ9wAG9auI
        1y0aas7erTGZLMWHZxOc4yaVZylByRI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-sG5CK5UePAilhZfOe9nvHg-1; Thu, 30 Nov 2023 13:17:34 -0500
X-MC-Unique: sG5CK5UePAilhZfOe9nvHg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50bc7296f75so1415814e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701368252; x=1701973052;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CrFEpIsAN5CLxammhD+GAJP9cPsbGGrmnZDHNVsmekk=;
        b=Y5/3Lv8z66Hgm6YbvGTZPSjw3BdBKo8o1N2DYxotBR1eemKr6Z6upfEROzD0uWusN1
         oD2GGSlo0q4XWsVyJE33d0zDZQPO2UQckIXRrKfe7SomqFiUErlaIrK+t3Gg8Zt49iyH
         yVAQdKr8Rj0Y3t6PppmMHUX7pipb5OM382NiaWKq18VNWGKOJPu55qrr7c6Vpn/ONUYD
         rBvRXXkDIbLeDycO/CbvAsrhCVcsKcj7EbdiXXevyW6nWSpOihTfi1jaHoU7EFf1qjMF
         DG1NfHdExrmIhh8HNP20Ejz5tUOw5cK4WgImKbpW3mXm6Wn0SBiO/LYtvSYI5D+7FRZl
         KrgA==
X-Gm-Message-State: AOJu0YyjiwxU2JDjkeWIQslLyhclah9LpOgg1udTW1rPyCxzTpchrRt9
        Uf43Ed5gNSRKEzqY2WJ4/EBOJ/MQmNWIQVUiaW7XstBjwVGG6wcIAzMCr00WWhKbtkfeLxE4BaG
        fzYvZkroqgvynV4Lrob4/ZVVCyDAWtyXQ
X-Received: by 2002:a05:6512:39c5:b0:50b:c027:70f with SMTP id k5-20020a05651239c500b0050bc027070fmr286lfu.21.1701368252298;
        Thu, 30 Nov 2023 10:17:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDeqYIAaVd/veLSsPan4ItHCmZAXYpV0ezMbb4/NCI3nQ4Fjl7Bmf1Eq8wWcU569Tv8r8zRw==
X-Received: by 2002:a17:906:15c:b0:9e7:8ad0:a471 with SMTP id 28-20020a170906015c00b009e78ad0a471mr171135ejh.12.1701366013091;
        Thu, 30 Nov 2023 09:40:13 -0800 (PST)
Received: from starship ([5.28.147.32])
        by smtp.gmail.com with ESMTPSA id 6-20020ac24846000000b0050bc56dd0acsm213436lfy.184.2023.11.30.09.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:40:11 -0800 (PST)
Message-ID: <fe7d8df5b6774a83c38b8a6dc244782c943c84b7.camel@redhat.com>
Subject: Re: [PATCH v7 17/26] KVM: x86: Report KVM supported CET MSRs as
 to-be-saved
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Thu, 30 Nov 2023 19:40:09 +0200
In-Reply-To: <20231124055330.138870-18-weijiang.yang@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-18-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-24 at 00:53 -0500, Yang Weijiang wrote:
> Add CET MSRs to the list of MSRs reported to userspace if the feature,
> i.e. IBT or SHSTK, associated with the MSRs is supported by KVM.
> 
> SSP can only be read via RDSSP. Writing even requires destructive and
> potentially faulting operations such as SAVEPREVSSP/RSTORSSP or
> SETSSBSY/CLRSSBSY. Let the host use a pseudo-MSR that is just a wrapper
> for the GUEST_SSP field of the VMCS.
> 
> Suggested-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/include/uapi/asm/kvm_para.h |  1 +
>  arch/x86/kvm/vmx/vmx.c               |  2 ++
>  arch/x86/kvm/x86.c                   | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
> index 6e64b27b2c1e..9864bbcf2470 100644
> --- a/arch/x86/include/uapi/asm/kvm_para.h
> +++ b/arch/x86/include/uapi/asm/kvm_para.h
> @@ -58,6 +58,7 @@
>  #define MSR_KVM_ASYNC_PF_INT	0x4b564d06
>  #define MSR_KVM_ASYNC_PF_ACK	0x4b564d07
>  #define MSR_KVM_MIGRATION_CONTROL	0x4b564d08
> +#define MSR_KVM_SSP	0x4b564d09
>  
>  struct kvm_steal_time {
>  	__u64 steal;
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index be20a60047b1..d3d0d74fef70 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7009,6 +7009,8 @@ static bool vmx_has_emulated_msr(struct kvm *kvm, u32 index)
>  	case MSR_AMD64_TSC_RATIO:
>  		/* This is AMD only.  */
>  		return false;
> +	case MSR_KVM_SSP:
> +		return kvm_cpu_cap_has(X86_FEATURE_SHSTK);
>  	default:
>  		return true;
>  	}
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 44b8cf459dfc..74d2d00a1681 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1476,6 +1476,9 @@ static const u32 msrs_to_save_base[] = {
>  
>  	MSR_IA32_XFD, MSR_IA32_XFD_ERR,
>  	MSR_IA32_XSS,
> +	MSR_IA32_U_CET, MSR_IA32_S_CET,
> +	MSR_IA32_PL0_SSP, MSR_IA32_PL1_SSP, MSR_IA32_PL2_SSP,
> +	MSR_IA32_PL3_SSP, MSR_IA32_INT_SSP_TAB,
>  };
>  
>  static const u32 msrs_to_save_pmu[] = {
> @@ -1576,6 +1579,7 @@ static const u32 emulated_msrs_all[] = {
>  
>  	MSR_K7_HWCR,
>  	MSR_KVM_POLL_CONTROL,
> +	MSR_KVM_SSP,
>  };
>  
>  static u32 emulated_msrs[ARRAY_SIZE(emulated_msrs_all)];
> @@ -7371,6 +7375,20 @@ static void kvm_probe_msr_to_save(u32 msr_index)
>  		if (!kvm_caps.supported_xss)
>  			return;
>  		break;
> +	case MSR_IA32_U_CET:
> +	case MSR_IA32_S_CET:
> +		if (!kvm_cpu_cap_has(X86_FEATURE_SHSTK) &&
> +		    !kvm_cpu_cap_has(X86_FEATURE_IBT))
> +			return;
> +		break;
> +	case MSR_IA32_INT_SSP_TAB:
> +		if (!kvm_cpu_cap_has(X86_FEATURE_LM))
> +			return;
> +		fallthrough;
> +	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
> +		if (!kvm_cpu_cap_has(X86_FEATURE_SHSTK))
> +			return;
> +		break;
>  	default:
>  		break;
>  	}

I still think that pseudo MSR is a hack that might backfire,
but I am not going to argue much about this.

Best regards,
	Maxim Levitsky


