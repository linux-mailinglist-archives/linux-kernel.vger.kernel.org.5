Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF947DD57D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbjJaRwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbjJaRwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:52:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D9F91
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698774680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8SueeyoA5l3+NPz+H4PFR4IPPiYp17+NNZKETDXfz4I=;
        b=QMBDZHMlLFmSTUTcz8eHvRay5bDFcUoRW7ZDZtjR7TQOrlYr+UIXThRWeeEVlimUfm8Lf3
        clBT1/Oh4WD2fPskDVDun6xYKLtmd+YS4EyiqZTUXzKYXwPj0A/bs5JdaapkWFeQAAmgTM
        jBNlzz3K+Yhk7hYRWOkN2frPU4MmL9w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-MbmDDLvvOuui58MXBnOdDg-1; Tue, 31 Oct 2023 13:51:17 -0400
X-MC-Unique: MbmDDLvvOuui58MXBnOdDg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32f7943913aso1722745f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774676; x=1699379476;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8SueeyoA5l3+NPz+H4PFR4IPPiYp17+NNZKETDXfz4I=;
        b=WhIp31S9PBqDA06yzTDiYwlEATXRSI6JxiOV5tlAaKo9C0unwPGWeXTN2udE5LxL5A
         tjX169NUUdljy34A5vzjh3Pvj9HXkrkpokiDh1hHy9VwcXGDUrMEieF7QIf8U/XehhAo
         erWn/SIp63zLOb1ybPMk55aLGmv5jmTD3nusKh97xK0TxvPuTcUfV71Gf5WwJ16iXTCH
         UdNc8RTqXStZI5ay8XGWlT49v6wzCBEAmZ7LhwUea2Bdj9DcHMK69/oy7qi+f+UdRs6C
         w9bdiDP1cBdcows0kJNw+GzQkaJ3BuC3dvl3J8bhIKjmS/gOUWMbcFz89aojkTYo2ZEB
         iPGg==
X-Gm-Message-State: AOJu0YxNVzYDIEyGiWUv92T4k3tmnOtu3sa5zYTLwMRW+3CgGSysxTtq
        OAjOfqF4RK45jyklvB7jecKIh+5njgJncmPMnrlaJoZtw61tVMcjorrGJdTlwP/kNjQbSii5i4d
        /il1m6LhvYuFHmUhxTmik1RG8
X-Received: by 2002:a5d:47af:0:b0:32f:8085:73f8 with SMTP id 15-20020a5d47af000000b0032f808573f8mr6478776wrb.18.1698774676367;
        Tue, 31 Oct 2023 10:51:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkCbM75bWqZ+oLxgMQHEz9Csq8A+q8FpCePzqItnI8N2+bPrxGlu1MWWo57WPrcTxgXvbQpA==
X-Received: by 2002:a5d:47af:0:b0:32f:8085:73f8 with SMTP id 15-20020a5d47af000000b0032f808573f8mr6478757wrb.18.1698774676021;
        Tue, 31 Oct 2023 10:51:16 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id w7-20020a5d5447000000b003176c6e87b1sm2018881wrv.81.2023.10.31.10.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:51:15 -0700 (PDT)
Message-ID: <3f704ac87db03493a1d1bf8b7ae74b5a586ddbaf.camel@redhat.com>
Subject: Re: [PATCH v6 13/25] KVM: x86: Initialize kvm_caps.supported_xss
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Tue, 31 Oct 2023 19:51:13 +0200
In-Reply-To: <20230914063325.85503-14-weijiang.yang@intel.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-14-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> Set original kvm_caps.supported_xss to (host_xss & KVM_SUPPORTED_XSS) if
> XSAVES is supported. host_xss contains the host supported xstate feature
> bits for thread FPU context switch, KVM_SUPPORTED_XSS includes all KVM
> enabled XSS feature bits, the resulting value represents the supervisor
> xstates that are available to guest and are backed by host FPU framework
> for swapping {guest,host} XSAVE-managed registers/MSRs.
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/x86.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9a616d84bd39..66edbed25db8 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -226,6 +226,8 @@ static struct kvm_user_return_msrs __percpu *user_return_msrs;
>  				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
>  				| XFEATURE_MASK_PKRU | XFEATURE_MASK_XTILE)
>  
> +#define KVM_SUPPORTED_XSS     0
> +
>  u64 __read_mostly host_efer;
>  EXPORT_SYMBOL_GPL(host_efer);
>  
> @@ -9515,12 +9517,13 @@ static int __kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
>  		host_xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
>  		kvm_caps.supported_xcr0 = host_xcr0 & KVM_SUPPORTED_XCR0;
>  	}
> +	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
> +		rdmsrl(MSR_IA32_XSS, host_xss);
> +		kvm_caps.supported_xss = host_xss & KVM_SUPPORTED_XSS;
> +	}
>  
>  	rdmsrl_safe(MSR_EFER, &host_efer);
>  
> -	if (boot_cpu_has(X86_FEATURE_XSAVES))
> -		rdmsrl(MSR_IA32_XSS, host_xss);
> -
>  	kvm_init_pmu_capability(ops->pmu_ops);
>  
>  	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




