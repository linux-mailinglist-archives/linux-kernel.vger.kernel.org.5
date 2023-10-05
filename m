Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAB47BA3EB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjJEQAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbjJEP50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:57:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2480655A3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696513987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmjmV2FL8ELc9fhvem7XqWCaaiXwmt6kD+gkjkkdF+o=;
        b=VWgy9CiEMsl84viLi0IGu2glFxqLWTI7umGqHpqfHtNDRHtM37b/Kj3Ftw71oGbE8W0R/r
        HLRMuZREEiIohw/D0rpQmzoYQI82+ohI6Z6+ny7SU0Vgh0jCaMBDWz662gNnuTDm3RFfYL
        bQLWwv1bsqvnvgqn/DTEldReQO0so5M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-h1Pp44gsNiykjZAlvKACSw-1; Thu, 05 Oct 2023 08:52:20 -0400
X-MC-Unique: h1Pp44gsNiykjZAlvKACSw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so6381425e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 05:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696510339; x=1697115139;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zmjmV2FL8ELc9fhvem7XqWCaaiXwmt6kD+gkjkkdF+o=;
        b=blEhZfpyJu9LCJt/e5OAEVIGd/whgyT3RyQ7MCqhyzfFg+MBuSGpiTRcNpGOumG98q
         Y27QdZHBRMpUy04LZnawf2hGB/ISw4Y87kG03lU+CmUieGp55EtYllgRkm0uRcUBSZSh
         KYxC2C7ibFOwF8z9d6H0he2T8s9pmsfc6g12iFaVhsoPiO4iMQbxWW3ah/tKOFilNZoN
         jMMrG4XzHCjx+03dCpJg6cstzn+gI4xgoKiMUx36+yLePRIE6tVkIvGWlgA4+a3IFAnO
         GEayG8kj2HJY9RSuDarqZBGC13CGd1pKOYKWc/T8c5D00fBPmtyVGZmVG3JoXfTliT8X
         F32g==
X-Gm-Message-State: AOJu0YzOdqOZ29Tz70uN5xNSHGq/u2OeREjg4bY4uIHYxPtfBdYMDWTj
        hJ5ZoO9hOQ1pazkFt3mHJUO1Zs6FLov66RnE/r0Qfreu/xx6cq5wzj/h/qy47QV3iFLnfbsw35Q
        rxVf5TwbPzMkoTPchObKQCpsW
X-Received: by 2002:a1c:7c17:0:b0:3fe:ba7:f200 with SMTP id x23-20020a1c7c17000000b003fe0ba7f200mr5396607wmc.20.1696510338931;
        Thu, 05 Oct 2023 05:52:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxwrlRRVC5KgOB6WbF1XYVweDYi+0tB1CX4lseGUm0j72BT+/pFJ39YKJShc6AHamwCvT6eg==
X-Received: by 2002:a1c:7c17:0:b0:3fe:ba7:f200 with SMTP id x23-20020a1c7c17000000b003fe0ba7f200mr5396595wmc.20.1696510338583;
        Thu, 05 Oct 2023 05:52:18 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id z7-20020a7bc7c7000000b003fee567235bsm3734745wmk.1.2023.10.05.05.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 05:52:18 -0700 (PDT)
Message-ID: <1d9377235ada012bc09e1864c4ef7522b8ef02fd.camel@redhat.com>
Subject: Re: [PATCH 08/10] KVM: SVM: WARN if KVM attempts to create AVIC
 backing page with user APIC
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     kvm@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Thu, 05 Oct 2023 15:52:16 +0300
In-Reply-To: <20230815213533.548732-9-seanjc@google.com>
References: <20230815213533.548732-1-seanjc@google.com>
         <20230815213533.548732-9-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

У вт, 2023-08-15 у 14:35 -0700, Sean Christopherson пише:
> WARN if KVM attempts to allocate a vCPU's AVIC backing page without an
> in-kernel local APIC.  avic_init_vcpu() bails early if the APIC is not
> in-kernel, and KVM disallows enabling an in-kernel APIC after vCPUs have
> been created, i.e. it should be impossible to reach
> avic_init_backing_page() without the vAPIC being allocated.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/avic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 522feaa711b4..3b2d00d9ca9b 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -300,7 +300,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
>  		return 0;
>  	}
>  
> -	if (!vcpu->arch.apic->regs)
> +	if (WARN_ON_ONCE(!vcpu->arch.apic->regs))
>  		return -EINVAL;
>  
>  	if (kvm_apicv_activated(vcpu->kvm)) {

As I said I prefer this to be folded with patch that adds the avic_init_backing_page().

Best regards,
	Maxim Levitsky

