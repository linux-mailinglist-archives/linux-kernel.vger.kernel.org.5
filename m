Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE5B7F081B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 18:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjKSRd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 12:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjKSRdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 12:33:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445091A1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700415199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BJ5/P1hMR2md3N3SnJ8/RD2V4pYxtTfoSa35OnUgrmE=;
        b=Zp6qNgdul1p3JbXst8baQwMTOMziSlnkBJc7MNpAzL4kDUyJrndS2GddKJY9l1eQUI/1lc
        jGFgcfH2jrAAm9aw1eyN+/qOYw3I9q3oI9Kz4jrHm0Ng+0ElbF/2K/e/ml4qEOkGf4fTdO
        BvLJLLaZVnzIQeespnEBUMuoeFH3r2g=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-cBFk7qpuPK2Dk9xSY03SAQ-1; Sun, 19 Nov 2023 12:33:16 -0500
X-MC-Unique: cBFk7qpuPK2Dk9xSY03SAQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507bd5f4b2dso3629974e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700415195; x=1701019995;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJ5/P1hMR2md3N3SnJ8/RD2V4pYxtTfoSa35OnUgrmE=;
        b=XoX+LHNPsZGkwv2BUKr8eKk3g130Y3i/eoeU0xUaKGjkkLOy52ubG82KD32vF4szVo
         agPfTtc3dpV8Ty4px+1/eW05+nbOkt4mAYG3O2PlJvtaXBfEIyV0fON42DX1tOJx1dry
         LIVxIImL8CIKOOBYBk7n7ZY67iIFTkxqhnYWBHDy+mGuHnguNvD4QVRblOVn4uVrRhKy
         V5++gZechnbo3jC1pMVwuzRoqPJGjA5a0+s+9ifWGm2o2pefybh0Q4es1PLGNGKyTgHx
         EE+AzU12g21DGpPxKKV7+V7CIAzqH+mVxewYKqWrq3ePz7kSQmxKlzTxEHZIg1EmgBMZ
         vQzQ==
X-Gm-Message-State: AOJu0YxtLIeL8A5B54DfOP1Cpq1ZNzFnpxz+YFYbK0USX/+Ymflfhlg6
        NJTi2dU7pA54SPMszY64Ru9CossBe5KJZXN6jt/qUB/4inj3wy6OQKv6DauxDp3hu6ruoJBWJPO
        xsflaVZXs8n48MPd27xXM5P7g
X-Received: by 2002:a05:6512:5ce:b0:50a:40b6:2d32 with SMTP id o14-20020a05651205ce00b0050a40b62d32mr3359404lfo.54.1700415195084;
        Sun, 19 Nov 2023 09:33:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZ1GRryURuL0SD5yTRUtiL11CZ0hD0YLCJ927i0Y7aWv6qoa6xLN8QeyBVV2cFreruPfklyA==
X-Received: by 2002:a05:6512:5ce:b0:50a:40b6:2d32 with SMTP id o14-20020a05651205ce00b0050a40b62d32mr3359399lfo.54.1700415194821;
        Sun, 19 Nov 2023 09:33:14 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id d16-20020adffbd0000000b003313902cef5sm8556911wrs.93.2023.11.19.09.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 09:33:14 -0800 (PST)
Message-ID: <5adae6067e0d05a4421616f9153bc865cd200a15.camel@redhat.com>
Subject: Re: [PATCH 5/9] KVM: x86: Drop unnecessary check that
 cpuid_entry2_find() returns right leaf
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 19 Nov 2023 19:33:11 +0200
In-Reply-To: <20231110235528.1561679-6-seanjc@google.com>
References: <20231110235528.1561679-1-seanjc@google.com>
         <20231110235528.1561679-6-seanjc@google.com>
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
> Drop an unnecessary check that cpuid_entry2_find() returns the correct
> leaf when getting CPUID.0x7.0x0 to update X86_FEATURE_OSPKE, as
> cpuid_entry2_find() never returns an entry for the wrong function.  And
> not that it matters, but cpuid_entry2_find() will always return a precise
> match for CPUID.0x7.0x0 since the index is significant.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 6777780be6ae..36bd04030989 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -284,7 +284,7 @@ static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_e
>  	}
>  
>  	best = cpuid_entry2_find(entries, nent, 7, 0);
> -	if (best && boot_cpu_has(X86_FEATURE_PKU) && best->function == 0x7)
> +	if (best && boot_cpu_has(X86_FEATURE_PKU))
>  		cpuid_entry_change(best, X86_FEATURE_OSPKE,
>  				   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
>  

Makes sense.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

