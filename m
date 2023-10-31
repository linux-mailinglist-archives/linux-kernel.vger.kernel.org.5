Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96D77DD538
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376493AbjJaRsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376487AbjJaRsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE42DF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698774449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YGq193LtBbfYWxLteF7JwAWgv8pm+P/KLCPfheg7LiM=;
        b=D5ewZFrrOguPTItseNFCrjRe3wg6KqM7hPBCj3B0WvgITuPu8Fj2oWn3yiyLvIj7eRZlcv
        LnPBHTI06wNjYT/deBHWPlRr0K3QEoKLuEbciQaQrWAzdiQTEyzB8PkjifykT/kCWm2eiF
        4TRAWDaj2n0M+9ctna8KuuyUH2NGCyo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-G56q-I8xOmiMZKVwNwBQhg-1; Tue, 31 Oct 2023 13:47:22 -0400
X-MC-Unique: G56q-I8xOmiMZKVwNwBQhg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507cafb69e8so6370793e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774441; x=1699379241;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YGq193LtBbfYWxLteF7JwAWgv8pm+P/KLCPfheg7LiM=;
        b=JGw9x+XAUJ6yidKMLHLrD9h2KH9F7OEjAjnpRybl5l+yfbMECU+yV8pfnlbxrbrhDm
         h+lwCvpEoSgKShVGsOTnsCojUl9q5lqdAwUbqyqOrKyn2VPdsWe4ykCmEMdQPs/znZ4D
         IKZr9tYfmM01cp2eojZbEQriWAcYwky0i4aEPqEoM8Q1M3gUB5TEGLtrrNel7So/gAwJ
         ksNkBcmT8M7tvjesonWfiWLy6NqNdOEwbybxdcKdvAD0UIAUQ2qnpSG+K1xt8TSFJgbt
         21JTNimeJhe1oX3ABSTiwS+C6t3c4lCrq+AjtJZrFt4lViycLxFBx8Ia73XW1jCUgVVF
         Hy4g==
X-Gm-Message-State: AOJu0Yx50lIWmwnSgy51sz2DHsG0auWDeNSlTlx/az1ghan2LpQPvmHe
        oFw42PLQJ6uVpv6WO7eVz/reWwleIZjRJuKQ11umJozCLjihQqmBt4ZXyQZTYv1G1HBkTpvkj01
        MOTNxhGSoCHiZpmCe7jClMJxLjYPfvlFX
X-Received: by 2002:a19:a411:0:b0:502:fff9:64da with SMTP id q17-20020a19a411000000b00502fff964damr9806286lfc.53.1698774441070;
        Tue, 31 Oct 2023 10:47:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr4+e3yKcsTlIJFrosy++mDAX9Uum8J6H9NAhaA9CLQBuU5y9jo8eO0pSEv7wj5sQ4lmH25Q==
X-Received: by 2002:a19:a411:0:b0:502:fff9:64da with SMTP id q17-20020a19a411000000b00502fff964damr9806266lfc.53.1698774440720;
        Tue, 31 Oct 2023 10:47:20 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id b17-20020a5d4b91000000b0032dba85ea1bsm2012068wrt.75.2023.10.31.10.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:47:20 -0700 (PDT)
Message-ID: <e10fb116aa67509f7a63660a6b0731e28935c820.camel@redhat.com>
Subject: Re: [PATCH v6 11/25] KVM: x86: Report XSS as to-be-saved if there
 are supported features
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Tue, 31 Oct 2023 19:47:18 +0200
In-Reply-To: <20230914063325.85503-12-weijiang.yang@intel.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-12-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Add MSR_IA32_XSS to list of MSRs reported to userspace if supported_xss
> is non-zero, i.e. KVM supports at least one XSS based feature.


I can't believe that CET is the first supervisor feature that KVM supports...

Ah, now I understand why:

1. XSAVES on AMD can't really be intercepted (other than clearing CR4.OSXSAVE bit, which isn't an option if you want to support AVX for example)
   On VMX however you can intercept XSAVES and even intercept it only when it touches specific bits of state that you don't want the guest to read/write
   freely.

2. Even if it was possible to intercept it, guests use XSAVES on every context switch if available and emulating it might be costly.

3. Emulating XSAVES is also not that easy to do correctly.

However XSAVES touches various MSRs, thus letting the guest use it unintercepted means giving access to host MSRs,
which might be wrong security wise in some cases.

Thus I see that KVM hardcodes the IA32_XSS to 0, and that makes the XSAVES work exactly like XSAVE.

And for some features which would benefit from XSAVES state components,
KVM likely won't even be able to do so due to this limitation.
(this is allowed thankfully by the CPUID), forcing the guests to use rdmsr/wrmsr instead.


However it is possible to enable IA32_XSS bits in case the msrs XSAVES reads/writes can't do harm to the host, and then KVM
can context switch these MSRs when the guest exits and that is what is done here with CET.

If you think that a short summary of the above can help the future reader to understand why IA32_XSS support is added only now,
it might be a good idea to add a few lines to the changelog of this patch.

> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/x86.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e0b55c043dab..1258d1d6dd52 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1464,6 +1464,7 @@ static const u32 msrs_to_save_base[] = {
>  	MSR_IA32_UMWAIT_CONTROL,
>  
>  	MSR_IA32_XFD, MSR_IA32_XFD_ERR,
> +	MSR_IA32_XSS,
>  };
>  
>  static const u32 msrs_to_save_pmu[] = {
> @@ -7195,6 +7196,10 @@ static void kvm_probe_msr_to_save(u32 msr_index)
>  		if (!(kvm_get_arch_capabilities() & ARCH_CAP_TSX_CTRL_MSR))
>  			return;
>  		break;
> +	case MSR_IA32_XSS:
> +		if (!kvm_caps.supported_xss)
> +			return;
> +		break;
>  	default:
>  		break;
>  	}


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky





