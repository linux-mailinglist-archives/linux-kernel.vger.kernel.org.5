Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6EA7E4829
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344088AbjKGSWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344056AbjKGSWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:22:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2331B0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699381292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sds6ydhRM76Ih9NP6DrxTnDzxVIOrfMyTi3/n3q+3yY=;
        b=DZCjc+jgoSZapHJOcCK1bARqAocIXHR2dkUUOMhVZ2eosT4vmYknJnCCD3aRzV7kdAnBB8
        yyUI46tEeavl7cBzDCe5qiFYMKK7nZ1Js9L+lkhibRSq1V0aTM0/KWNhRYbdhSHygXKrtr
        QWwOAeiaAZkqUy1sz4XuVE5YNtGX99Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-GgNcZXQSNISEGjLB_JzrZA-1; Tue, 07 Nov 2023 13:21:31 -0500
X-MC-Unique: GgNcZXQSNISEGjLB_JzrZA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40845fe2d1cso39435145e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 10:21:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699381290; x=1699986090;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sds6ydhRM76Ih9NP6DrxTnDzxVIOrfMyTi3/n3q+3yY=;
        b=bdYav13GuUrdfHfRaPyv3P5/BvXeTNOJz11aiP/E0km+IRRd1HuBikAgdktez8BA+e
         2UNOpyL5NM2+sbVGZwOczTG+BtP4x352guMeiAhgL7e3udQVsMBaO5cnhU3WcUeFXPjM
         oIv48QEt2YIu55CQrzzWnElCVIvaMek7Sr6RCnquc4r1OywsXK1VbkTWCg4PSPMhDnFJ
         tHaP9QcwxQCxyMCrW3xULM4WvUoJ07a0Ivr+EKXi2uCC9uz53rOwrvZVrLIQi851qw+v
         VI92mZ8MYzzYH1SuhrpJ8jkGQUh4CyIjfYtYICj5SUtNZiZYgaNdn+1khryf4jA+wqtj
         sZ4Q==
X-Gm-Message-State: AOJu0Yw1k/MlQoZWmdkLkNKOOUi1MhhLftwodGK/kbhjHVMS34J5CU6Z
        kfx67NVBEmzmlwQ1urWHyKVKPzqXBrU42cnCP5LtlLKhcC1s0BdtnN5LU73zaS18JusPbbAEhuf
        gwo6eNJ9dXywkMMYv4P1VsGEa
X-Received: by 2002:a05:6000:2a5:b0:32f:7a65:da66 with SMTP id l5-20020a05600002a500b0032f7a65da66mr27671104wry.44.1699381289935;
        Tue, 07 Nov 2023 10:21:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuznJxNynYkO9slS06rtEpCayJe6NLTZJfhoJ6OrUX+1CrJPkYh3L0/eC7XadqoE3XJkKvxg==
X-Received: by 2002:a05:6000:2a5:b0:32f:7a65:da66 with SMTP id l5-20020a05600002a500b0032f7a65da66mr27671093wry.44.1699381289690;
        Tue, 07 Nov 2023 10:21:29 -0800 (PST)
Received: from starship ([89.237.99.95])
        by smtp.gmail.com with ESMTPSA id d2-20020adfe2c2000000b00327cd5e5ac1sm3022535wrj.1.2023.11.07.10.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:21:29 -0800 (PST)
Message-ID: <66b737135fd8a12f8b79ef22a9b1cef8f9c56496.camel@redhat.com>
Subject: Re: [PATCH 07/14] KVM: x86: hyper-v: Introduce
 kvm_hv_nested_transtion_tlb_flush() helper
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 07 Nov 2023 20:21:27 +0200
In-Reply-To: <20231025152406.1879274-8-vkuznets@redhat.com>
References: <20231025152406.1879274-1-vkuznets@redhat.com>
         <20231025152406.1879274-8-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-25 at 17:23 +0200, Vitaly Kuznetsov wrote:
> As a preparation to making Hyper-V emulation optional, introduce a helper
> to handle pending KVM_REQ_HV_TLB_FLUSH requests.
> 
> No functional change intended.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.h     | 12 ++++++++++++
>  arch/x86/kvm/svm/nested.c | 10 ++--------
>  arch/x86/kvm/vmx/nested.c | 10 ++--------
>  3 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
> index ddb1d0b019e6..75dcbe598fbc 100644
> --- a/arch/x86/kvm/hyperv.h
> +++ b/arch/x86/kvm/hyperv.h
> @@ -246,6 +246,18 @@ static inline int kvm_hv_verify_vp_assist(struct kvm_vcpu *vcpu)
>  	return kvm_hv_get_assist_page(vcpu);
>  }
>  
> +static inline void kvm_hv_nested_transtion_tlb_flush(struct kvm_vcpu *vcpu, bool tdp_enabled)
> +{
> +	/*
> +	 * KVM_REQ_HV_TLB_FLUSH flushes entries from either L1's VP_ID or
> +	 * L2's VP_ID upon request from the guest. Make sure we check for
> +	 * pending entries in the right FIFO upon L1/L2 transition as these
> +	 * requests are put by other vCPUs asynchronously.
> +	 */
> +	if (to_hv_vcpu(vcpu) && tdp_enabled)
> +		kvm_make_request(KVM_REQ_HV_TLB_FLUSH, vcpu);
> +}
> +
>  int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu);
>  
>  #endif
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 3fea8c47679e..74c04102ef01 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -487,14 +487,8 @@ static void nested_save_pending_event_to_vmcb12(struct vcpu_svm *svm,
>  
>  static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
>  {
> -	/*
> -	 * KVM_REQ_HV_TLB_FLUSH flushes entries from either L1's VP_ID or
> -	 * L2's VP_ID upon request from the guest. Make sure we check for
> -	 * pending entries in the right FIFO upon L1/L2 transition as these
> -	 * requests are put by other vCPUs asynchronously.
> -	 */
> -	if (to_hv_vcpu(vcpu) && npt_enabled)
> -		kvm_make_request(KVM_REQ_HV_TLB_FLUSH, vcpu);
> +	/* Handle pending Hyper-V TLB flush requests */
> +	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
>  
>  	/*
>  	 * TODO: optimize unconditional TLB flush/MMU sync.  A partial list of
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index c5ec0ef51ff7..382c0746d069 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -1139,14 +1139,8 @@ static void nested_vmx_transition_tlb_flush(struct kvm_vcpu *vcpu,
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  
> -	/*
> -	 * KVM_REQ_HV_TLB_FLUSH flushes entries from either L1's VP_ID or
> -	 * L2's VP_ID upon request from the guest. Make sure we check for
> -	 * pending entries in the right FIFO upon L1/L2 transition as these
> -	 * requests are put by other vCPUs asynchronously.
> -	 */
> -	if (to_hv_vcpu(vcpu) && enable_ept)
> -		kvm_make_request(KVM_REQ_HV_TLB_FLUSH, vcpu);
> +	/* Handle pending Hyper-V TLB flush requests */
> +	kvm_hv_nested_transtion_tlb_flush(vcpu, enable_ept);
>  
>  	/*
>  	 * If vmcs12 doesn't use VPID, L1 expects linear and combined mappings


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

