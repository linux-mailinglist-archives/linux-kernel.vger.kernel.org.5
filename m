Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E083D7F0824
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 18:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjKSRgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 12:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjKSRgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 12:36:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C74131
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700415406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSZWaEcrttfVUQAUXiV/dZPRnPufWlgpAWqh2E7JRwk=;
        b=YNrX/hwAEI94nIDHc/Zc5/k63q8000OQjgGGLVFs+O+HZoj6ON+UghOxemtuPFc2X4nyiW
        lGl9nCLJ2rNiGBhdt1ztYMhZKecPutZYMdXAZAqO5N0aYZSGFMRbE9/v3gNosZ7nyDHrVP
        8WdYncOLBKHghPrPqusH1JIYw18LKus=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-XYyHwtvJNw-8Xm2KfD1F8Q-1; Sun, 19 Nov 2023 12:36:45 -0500
X-MC-Unique: XYyHwtvJNw-8Xm2KfD1F8Q-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5091368e043so4023511e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:36:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700415403; x=1701020203;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zSZWaEcrttfVUQAUXiV/dZPRnPufWlgpAWqh2E7JRwk=;
        b=TVUti1HJvh9UyDCsDbvDQ8fCbLcANc/YtwKGJGjLZIgIxHO7TyWzS+H0l1rJIZA2Fg
         ELacSxG90YCT+4beau1JP/Gyd6CIkIhMgke4vCFtyi4ra7qlXVyyrU/wovPCNcpI50aw
         w5XuIvgz7Nywthti7hph88DU+LQHfQXtvQj6CFflsu1OqzjryvfPm5q2gmOnHTvBtHnw
         KiaUR/3W2ZkC8DIEHTpmXYLln/+1FO/l9v9ihoxnXBuIIsMNH9r1Zb7P4v+kBEOcCACg
         AEHCSwqM/h67rqhxQCnj81Xkx6Y44MD3KpxgLMtOYBcbWZmhfsJBtV5nqAOhBNm2Tm1A
         cH7w==
X-Gm-Message-State: AOJu0YzysrWWfMx8eRD3HF81iD7dfCjLT/m6aGbPbEmrcytx9AzlrByt
        AL1ODHA+rhPi0bCsH0d0R+3ezUTEMha27KnlQuFVSOAHd1z8NdPSsKSU+iLbSM/G3DSHIXM6aIC
        XUSAymUwvLVWZ48yVt2YYRfq2
X-Received: by 2002:a05:6512:11cf:b0:509:cbfa:917d with SMTP id h15-20020a05651211cf00b00509cbfa917dmr3440279lfr.37.1700415403728;
        Sun, 19 Nov 2023 09:36:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuRmqU0kDIKtxILH0KaovH9AaYwyddjLh71/hWyKYE45ZzBTjIXARO/xDEA0LFMXYuEZ4+BA==
X-Received: by 2002:a05:6512:11cf:b0:509:cbfa:917d with SMTP id h15-20020a05651211cf00b00509cbfa917dmr3440274lfr.37.1700415403356;
        Sun, 19 Nov 2023 09:36:43 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id dm8-20020a0560000bc800b00332c08f828bsm3869295wrb.74.2023.11.19.09.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 09:36:43 -0800 (PST)
Message-ID: <9b6645bbe95ef98327c922822b7a4ff6b0b80bad.camel@redhat.com>
Subject: Re: [PATCH 9/9] KVM: x86: Restrict XSAVE in cpu_caps based on KVM
 capabilities
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 19 Nov 2023 19:36:41 +0200
In-Reply-To: <20231110235528.1561679-10-seanjc@google.com>
References: <20231110235528.1561679-1-seanjc@google.com>
         <20231110235528.1561679-10-seanjc@google.com>
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

On Fri, 2023-11-10 at 15:55 -0800, Sean Christopherson wrote:
> Restrict XSAVE in guest cpu_caps so that XSAVES dependencies on XSAVE are
> automatically handled instead of manually checking for host and guest
> XSAVE support.  Aside from modifying XSAVE in cpu_caps, this should be a
> glorified nop as KVM doesn't query guest XSAVE support (which is also why
> it wasn't/isn't a bug to leave XSAVE set in guest CPUID).
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/svm.c | 2 +-
>  arch/x86/kvm/vmx/vmx.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 9e3a9191dac1..6fe2d7bf4959 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4315,8 +4315,8 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	 * XSS on VM-Enter/VM-Exit.  Failure to do so would effectively give
>  	 * the guest read/write access to the host's XSS.
>  	 */
> +	guest_cpu_cap_restrict(vcpu, X86_FEATURE_XSAVE);
>  	guest_cpu_cap_change(vcpu, X86_FEATURE_XSAVES,
> -			     boot_cpu_has(X86_FEATURE_XSAVE) &&
>  			     boot_cpu_has(X86_FEATURE_XSAVES) &&
>  			     guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVE));
>  
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 815692dc0aff..7645945af5c5 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7752,8 +7752,8 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	 * to the guest.  XSAVES depends on CR4.OSXSAVE, and CR4.OSXSAVE can be
>  	 * set if and only if XSAVE is supported.
>  	 */
> -	if (boot_cpu_has(X86_FEATURE_XSAVE) &&
> -	    guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVE))
> +	guest_cpu_cap_restrict(vcpu, X86_FEATURE_XSAVE);
> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVE))
>  		guest_cpu_cap_restrict(vcpu, X86_FEATURE_XSAVES);
>  	else
>  		guest_cpu_cap_clear(vcpu, X86_FEATURE_XSAVES);

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




