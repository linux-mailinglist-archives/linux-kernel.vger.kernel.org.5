Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8D87FFBC7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376525AbjK3Tsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjK3Tsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:48:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FB5D5C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701373719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k1xrIynOc3yDB69n1RULdeleHvHvjuBPS0rAizzwpeI=;
        b=M2oKjm4ccom4wL1ImNHsY9Mrq70GsbpXWQXGawgH+SgRwsbnOhn0aJlXlHrRQvIdaNuhf4
        Av7PeFibBaE3d89ZbD6/ogXLqWBHhBFQMHihuYLWZpe3X3dqZy0sV6P/temgNUYg5BcVkv
        QurnWYZWjF7ReBGdcj48tzqbyvslJYQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-x-LINzGwNuGJND3vEySJUg-1; Thu, 30 Nov 2023 14:48:37 -0500
X-MC-Unique: x-LINzGwNuGJND3vEySJUg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a172dfcf438so112549266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:48:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701373716; x=1701978516;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k1xrIynOc3yDB69n1RULdeleHvHvjuBPS0rAizzwpeI=;
        b=XGKm5udxLLdKozn4/O9RJ3bZYUpSqjdMQQSAH8tYXT7VoUCSZOps7ZTB+a5GigUo35
         ds54BdHI/vWVQCsAlyQooQ25fqiA8u21JJRY+fOa+kpa0livxBW4Ug1HEu4Swz8sPTxC
         TIAqBmEdU0NKyt9VY20ZmpePamTsBXucml45L8OcBf4WgKnKz/AwfVd+nts8LGekCSHj
         5NU8qf4hlLb3GqVbLCDC6qG31lc5jdGa4OOLKsQEqLWDCdJxpYEG+h5EE2i0JL0uDbwh
         UCAs0GE+dWwKjkllVsvzClbR60JxF0dwX3ktapLyY1CszmteklxRkkHW0GnK5OufEbi5
         hCMg==
X-Gm-Message-State: AOJu0YxjcfDxCnH4kHI9cMKMs9CyLBzdjvHmlw8+ecx6wikwrqVQ1qHl
        7yYqs3C6Ngk06TK8ynuv6NWM6YsE367IYW3TCEN4C3Mw77BfSD+ZXQoTKFDg3QizaGAQt5BRZNw
        DbFtxksHBP0/rbsfZFGDUARvaY8NUVudx
X-Received: by 2002:a17:907:76c9:b0:a19:a19b:c6ff with SMTP id kf9-20020a17090776c900b00a19a19bc6ffmr38152ejc.79.1701373716394;
        Thu, 30 Nov 2023 11:48:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnZwxybDBa9d+1jyY55F9oLhZyquCMf4W1j/ajoNAp6Waooi/h9c1ywSFaPfo9Hba4Ac3Jdg==
X-Received: by 2002:a19:4f06:0:b0:509:4ab3:a8a3 with SMTP id d6-20020a194f06000000b005094ab3a8a3mr48861lfb.22.1701366035828;
        Thu, 30 Nov 2023 09:40:35 -0800 (PST)
Received: from starship ([5.28.147.32])
        by smtp.gmail.com with ESMTPSA id o12-20020ac24e8c000000b0050bbf6b1f74sm213812lfr.232.2023.11.30.09.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:40:29 -0800 (PST)
Message-ID: <8ff392a0c2ddbd622fd86b1c6eaab38eefeb05c3.camel@redhat.com>
Subject: Re: [PATCH v7 19/26] KVM: x86: Use KVM-governed feature framework
 to track "SHSTK/IBT enabled"
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Thu, 30 Nov 2023 19:40:26 +0200
In-Reply-To: <20231124055330.138870-20-weijiang.yang@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-20-weijiang.yang@intel.com>
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
> Use the governed feature framework to track whether X86_FEATURE_SHSTK
> and X86_FEATURE_IBT features can be used by userspace and guest, i.e.,
> the features can be used iff both KVM and guest CPUID can support them.
> 
> TODO: remove this patch once Sean's refactor to "KVM-governed" framework
> is upstreamed. See the work here [*].
> 
> [*]: https://lore.kernel.org/all/20231110235528.1561679-1-seanjc@google.com/
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/governed_features.h | 2 ++
>  arch/x86/kvm/vmx/vmx.c           | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kvm/governed_features.h b/arch/x86/kvm/governed_features.h
> index 423a73395c10..db7e21c5ecc2 100644
> --- a/arch/x86/kvm/governed_features.h
> +++ b/arch/x86/kvm/governed_features.h
> @@ -16,6 +16,8 @@ KVM_GOVERNED_X86_FEATURE(PAUSEFILTER)
>  KVM_GOVERNED_X86_FEATURE(PFTHRESHOLD)
>  KVM_GOVERNED_X86_FEATURE(VGIF)
>  KVM_GOVERNED_X86_FEATURE(VNMI)
> +KVM_GOVERNED_X86_FEATURE(SHSTK)
> +KVM_GOVERNED_X86_FEATURE(IBT)
>  
>  #undef KVM_GOVERNED_X86_FEATURE
>  #undef KVM_GOVERNED_FEATURE
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index d3d0d74fef70..f6ad5ba5d518 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7762,6 +7762,8 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_XSAVES);
>  
>  	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_VMX);
> +	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_SHSTK);
> +	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_IBT);
>  
>  	vmx_setup_uret_msrs(vmx);
>  

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

