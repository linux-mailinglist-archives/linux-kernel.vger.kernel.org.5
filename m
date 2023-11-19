Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB837F0819
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 18:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjKSRdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 12:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjKSRdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 12:33:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DA7137
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700415186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bGwBPAT+9iPn9FyAJmqTJpBz0lhkFdp1EboyOFP7JO8=;
        b=GEF40cfKl2dF5X42fRCBbUbFD8VPH5+g0ib6EkNobuZ2+v7u1VVXTTmDl7fZt78dUtoK+9
        sy2LvoUWo/sWJ5hJiFKuPPcFFvvHBnkvZ/zTntVoV1SLk/7MfqN1KLVo+gvt91AoQRLkB5
        0WQQxzsHDD+vW80VpEchwfLQ6mUkgWo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-SNPoOUhBPDWWgC0HEuVu3w-1; Sun, 19 Nov 2023 12:33:05 -0500
X-MC-Unique: SNPoOUhBPDWWgC0HEuVu3w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-408695c377dso8598935e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700415184; x=1701019984;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bGwBPAT+9iPn9FyAJmqTJpBz0lhkFdp1EboyOFP7JO8=;
        b=RYtKdAIBtJ3igjZK9JlPzbREPKMsZuYGOIH1SP1Q2FuPlLkyrl6Wwd57swhRFDug3W
         P7S3pkA8wSx4IYHGfYhKYSrmKzsKww12muYDLZlvGiLLc/UmAJA45GV5sTYN/LH7zY4y
         KhCrcbAKrKt4Y75f25+oCcB7RNQJscZr4AlP1t/mdycqCXqNHBB/juLflG4SNyiMi0jW
         hCse4feN5dwssA4DwlUQxZ0yXgiO0kSSlPVya5U/gwYi9JLA2Oo6bEv3Wd7QSwWqOqaM
         mb/R4xwaHACnEJVk8p97LIuijdI+22La1qUK/xzHFut/3eLpHjG53sInoWSy623om4FE
         ObTQ==
X-Gm-Message-State: AOJu0Yzk/DDjM1VgVAPXboUlA+v+YSkfnMSOmDQMi/BDZyMosAbqrAfq
        rRD+FjIFNS+1hRs5+JhZvV5/g3Yc/3zdA0aks0BOKTCdnb6Sjci4z2Bew3D9Lt95lvPZmgI3d2i
        dB9l4BJ0h22jz6teEghh5qx+B
X-Received: by 2002:a05:600c:1c85:b0:405:39b4:3145 with SMTP id k5-20020a05600c1c8500b0040539b43145mr4342320wms.2.1700415183959;
        Sun, 19 Nov 2023 09:33:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEwowleSE1HT+eTey8xjaU0nHGjxwnEn4bjwoQAHpzSw+fIjq/Rrupk3zgDka3oUADjycGyw==
X-Received: by 2002:a05:600c:1c85:b0:405:39b4:3145 with SMTP id k5-20020a05600c1c8500b0040539b43145mr4342311wms.2.1700415183630;
        Sun, 19 Nov 2023 09:33:03 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d5606000000b00331698cb263sm8361056wrv.103.2023.11.19.09.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 09:33:03 -0800 (PST)
Message-ID: <8c518aae88a6db2347813985ea4e7c2ccee585da.camel@redhat.com>
Subject: Re: [PATCH 4/9] KVM: x86: Avoid double CPUID lookup when updating
 MWAIT at runtime
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 19 Nov 2023 19:33:01 +0200
In-Reply-To: <20231110235528.1561679-5-seanjc@google.com>
References: <20231110235528.1561679-1-seanjc@google.com>
         <20231110235528.1561679-5-seanjc@google.com>
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

On Fri, 2023-11-10 at 15:55 -0800, Sean Christopherson wrote:
> Move the handling of X86_FEATURE_MWAIT during CPUID runtime updates to
> utilize the lookup done for other CPUID.0x1 features.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 5cf3d697ecb3..6777780be6ae 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -276,6 +276,11 @@ static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_e
>  
>  		cpuid_entry_change(best, X86_FEATURE_APIC,
>  			   vcpu->arch.apic_base & MSR_IA32_APICBASE_ENABLE);
> +
> +		if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT))
> +			cpuid_entry_change(best, X86_FEATURE_MWAIT,
> +					   vcpu->arch.ia32_misc_enable_msr &
> +					   MSR_IA32_MISC_ENABLE_MWAIT);
>  	}
>  
>  	best = cpuid_entry2_find(entries, nent, 7, 0);
> @@ -296,14 +301,6 @@ static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_e
>  	if (kvm_hlt_in_guest(vcpu->kvm) && best &&
>  		(best->eax & (1 << KVM_FEATURE_PV_UNHALT)))
>  		best->eax &= ~(1 << KVM_FEATURE_PV_UNHALT);
> -
> -	if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT)) {
> -		best = cpuid_entry2_find(entries, nent, 0x1, KVM_CPUID_INDEX_NOT_SIGNIFICANT);
> -		if (best)
> -			cpuid_entry_change(best, X86_FEATURE_MWAIT,
> -					   vcpu->arch.ia32_misc_enable_msr &
> -					   MSR_IA32_MISC_ENABLE_MWAIT);
> -	}
>  }
>  
>  void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

