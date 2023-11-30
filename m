Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFA27FFBB1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbjK3Toi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjK3Toi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:44:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BD4D67
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701373483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LPhpj/A0n+X4U7+YF4qn5WwPaR+rmzk/ZuOqptCZK6E=;
        b=MgH4igkdigDBNRxVUFWdb/0VPrixZVZpQ/IfhxPTjtKS/sD74gDC7jhRKUgpF3oUPQsVTa
        2OL1mt2HROtHH6yCOZNBmiwRaI7SoAejcXoov9+nooESEjGK1a88l/xhDwLsA9AGgY7fUO
        aquY9F/UiDX0AOK2jt+eJcvcgUEAVAs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-JoRODroSMom2kTYjRo2M4A-1; Thu, 30 Nov 2023 14:44:42 -0500
X-MC-Unique: JoRODroSMom2kTYjRo2M4A-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-543f45ab457so986957a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701373480; x=1701978280;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LPhpj/A0n+X4U7+YF4qn5WwPaR+rmzk/ZuOqptCZK6E=;
        b=ocZ/65OIgYd8OZHwv/t4gZ5DbMeyMdaxbugUeBa1lCPkA07YTBAyBZhmMVUD3uAkdA
         cnyZOYK+/cGlLSrCsDG6flb0HPeUa6G2+CGpqp0CUeGPtHKwrh1ABhOnJh3miIXjNRcd
         0+r8lsF74Jbm/vXW/lLQuzilmmfjVh8tbdR5kJyntiPicl3WT7FSRYJCTElZ95ll7y8f
         xyKEUS+pELFYGfXJUuJ8aKfSYKPd6gbU3fEnfYnk2UAdYOn4Szi8Sq0JVTlnKjPxZQEo
         OEABemXgB89wGtnB4719VjCE0+aLfeuZyudvltVAtJKHfI8Olpil3IYw5NOb1qUEuf+z
         qvew==
X-Gm-Message-State: AOJu0YyX4dyHBDFtIJfsMXRMxBCGZSRiykTMIPi58lOMtCa34AbuTxih
        7TKkUdNosvYCAlGAbvDMoJWu9p9Mgvpao0GqasbQh8qpJMp+H70c/t2dVn5yPX8J0Ghse6IFhXz
        NCEFq0LRiKL38YFW8F2wdZDhfSXSzUEvx
X-Received: by 2002:a50:c307:0:b0:544:a153:cd19 with SMTP id a7-20020a50c307000000b00544a153cd19mr19830edb.41.1701373480490;
        Thu, 30 Nov 2023 11:44:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZelmu7uaSeXSssVnLywvQIGoRpU1YHk/jvrg5YamPvbTcEuIUmu8QD5HyLuAP/iFyPFU75Q==
X-Received: by 2002:a2e:3207:0:b0:2c9:c5a6:62d8 with SMTP id y7-20020a2e3207000000b002c9c5a662d8mr17958ljy.0.1701366288443;
        Thu, 30 Nov 2023 09:44:48 -0800 (PST)
Received: from starship ([5.28.147.32])
        by smtp.gmail.com with ESMTPSA id h15-20020a2e9ecf000000b002c9c22c52e4sm188158ljk.103.2023.11.30.09.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:44:48 -0800 (PST)
Message-ID: <393d82243b7f44731439717be82b20fbeda45c77.camel@redhat.com>
Subject: Re: [PATCH v7 22/26] KVM: VMX: Set up interception for CET MSRs
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Thu, 30 Nov 2023 19:44:45 +0200
In-Reply-To: <20231124055330.138870-23-weijiang.yang@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-23-weijiang.yang@intel.com>
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
> Enable/disable CET MSRs interception per associated feature configuration.
> Shadow Stack feature requires all CET MSRs passed through to guest to make
> it supported in user and supervisor mode while IBT feature only depends on
> MSR_IA32_{U,S}_CETS_CET to enable user and supervisor IBT.
> 
> Note, this MSR design introduced an architectural limitation of SHSTK and
> IBT control for guest, i.e., when SHSTK is exposed, IBT is also available
> to guest from architectual perspective since IBT relies on subset of SHSTK
> relevant MSRs.
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 554f665e59c3..e484333eddb0 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -699,6 +699,10 @@ static bool is_valid_passthrough_msr(u32 msr)
>  	case MSR_LBR_CORE_TO ... MSR_LBR_CORE_TO + 8:
>  		/* LBR MSRs. These are handled in vmx_update_intercept_for_lbr_msrs() */
>  		return true;
> +	case MSR_IA32_U_CET:
> +	case MSR_IA32_S_CET:
> +	case MSR_IA32_PL0_SSP ... MSR_IA32_INT_SSP_TAB:
> +		return true;
>  	}
>  
>  	r = possible_passthrough_msr_slot(msr) != -ENOENT;
> @@ -7766,6 +7770,42 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
>  		vmx->pt_desc.ctl_bitmask &= ~(0xfULL << (32 + i * 4));
>  }
>  
> +static void vmx_update_intercept_for_cet_msr(struct kvm_vcpu *vcpu)
> +{
> +	bool incpt;
> +
> +	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
> +		incpt = !guest_cpuid_has(vcpu, X86_FEATURE_SHSTK);
> +
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_U_CET,
> +					  MSR_TYPE_RW, incpt);
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_S_CET,
> +					  MSR_TYPE_RW, incpt);
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL0_SSP,
> +					  MSR_TYPE_RW, incpt);
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL1_SSP,
> +					  MSR_TYPE_RW, incpt);
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL2_SSP,
> +					  MSR_TYPE_RW, incpt);
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL3_SSP,
> +					  MSR_TYPE_RW, incpt);
> +		if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
> +			vmx_set_intercept_for_msr(vcpu, MSR_IA32_INT_SSP_TAB,
> +						  MSR_TYPE_RW, incpt);
> +		if (!incpt)
> +			return;
> +	}
> +
> +	if (kvm_cpu_cap_has(X86_FEATURE_IBT)) {
> +		incpt = !guest_cpuid_has(vcpu, X86_FEATURE_IBT);
> +
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_U_CET,
> +					  MSR_TYPE_RW, incpt);
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_S_CET,
> +					  MSR_TYPE_RW, incpt);
> +	}
> +}
> +
>  static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> @@ -7843,6 +7883,8 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  
>  	/* Refresh #PF interception to account for MAXPHYADDR changes. */
>  	vmx_update_exception_bitmap(vcpu);
> +
> +	vmx_update_intercept_for_cet_msr(vcpu);
>  }
>  
>  static u64 vmx_get_perf_capabilities(void)

My review feedback from the previous patch still applies as well,

I still think that we should either try a best effort approach to plug
this virtualization hole, or we at least should fail guest creation
if the virtualization hole is present as I said:

"Another, much simpler option is to fail the guest creation if the shadow stack + indirect branch tracking
state differs between host and the guest, unless both are disabled in the guest.
(in essence don't let the guest be created if (2) or (3) happen)"

Please at least tell me what do you think about this.

Best regards,
	Maxim Levitsky


