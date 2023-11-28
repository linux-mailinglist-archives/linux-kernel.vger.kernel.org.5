Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653F57FB2A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbjK1HZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343911AbjK1HZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:25:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FC0137
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701156311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iANepy4LcEVc0PFmyCqY5MwriaBXl1P+qYoxDZZLGVY=;
        b=MV6Zcbo97EGBOiAUYD5mOluyifyrUXrfFxeZUNEK9UfEMOJc/buBb5J32SmxsLt2dZGqIA
        1dEj4TU7Jit0Ohnmb8d1QHhhRAjwuXz1mDEIPgICVnqEld4ullaO5AuSfPZdnEK+OAajFf
        T9NBiXPrCSfk80EV+omvFXNlso97QyM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-62nFpD1EMOKz0ml8vVNqXQ-1; Tue, 28 Nov 2023 02:25:06 -0500
X-MC-Unique: 62nFpD1EMOKz0ml8vVNqXQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-332ee6c2a1aso2558776f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156306; x=1701761106;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iANepy4LcEVc0PFmyCqY5MwriaBXl1P+qYoxDZZLGVY=;
        b=j/w3SzSZdZME6T2micJINOV+CQn9Sm/eTHPN17oBvV3h1IqBsEnFrYoVqnXgmEBvMo
         2WeRziEVgLA0VyfioDm2iGEu5RkCbv7hzrxHD9XLkPDL4iZUBM46Q9UTxyMeOV8rTAYA
         eTxZmzKAG8w64bkFN1v4+jOZKb5TUN3eNUyECKjx/l0Vlu5IkImKRuecNgDxDKIOf5HU
         SNJpgeoY0k/8cWyEQbBUPE7Vlh4pGRiD9ki5C0xZ+PxGQGtUp2c/sQGy7TWRyhxR19vZ
         XSVXsq3RXZ+rg2e9KH9Au8d6zPLxPBUipMfTfu18gwPJSsYISxGUeBHgltKUEO2WHTHt
         Visw==
X-Gm-Message-State: AOJu0YzNe+HixoLTfvV0scbKCm4fBFXuBCVvInpx7l6cQ6QFCMwTcD3v
        v1jzmnkNjITQbYu4h0UHD1pJToMm5/aqwEvMEWvvDuW5ySDuIssFBJ9rclkcNEfSG9f1/BRR3C/
        LLEHTzy/0/qBMVZkVpPbhiKm7
X-Received: by 2002:a5d:464f:0:b0:32d:bb4a:525c with SMTP id j15-20020a5d464f000000b0032dbb4a525cmr10101807wrs.14.1701156305898;
        Mon, 27 Nov 2023 23:25:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0QQYA/ChFd9v/3X2VV1Y1Nh7hNFAIVNaVFuTH1R2mIuDpnEA9cp9CcfXyFdGFcLHjPhMM+Q==
X-Received: by 2002:a5d:464f:0:b0:32d:bb4a:525c with SMTP id j15-20020a5d464f000000b0032dbb4a525cmr10101791wrs.14.1701156305564;
        Mon, 27 Nov 2023 23:25:05 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id d21-20020adf9b95000000b003316ad360c1sm14269010wrc.24.2023.11.27.23.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:25:05 -0800 (PST)
Message-ID: <c9d68c7f42a5ea936179b676bdf0970062d4f3a7.camel@redhat.com>
Subject: Re: [RFC 09/33] KVM: x86: hyper-v: Introduce per-VTL vcpu helpers
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk,
        jgowans@amazon.com, corbert@lwn.net, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, x86@kernel.org,
        linux-doc@vger.kernel.org
Date:   Tue, 28 Nov 2023 09:25:03 +0200
In-Reply-To: <20231108111806.92604-10-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
         <20231108111806.92604-10-nsaenz@amazon.com>
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

On Wed, 2023-11-08 at 11:17 +0000, Nicolas Saenz Julienne wrote:
> Introduce two helper functions. The first one queries a vCPU's VTL
> level, the second one, given a struct kvm_vcpu and VTL pair, returns the
> corresponding 'sibling' struct kvm_vcpu at the right VTL.
> 
> We keep track of each VTL's state by having a distinct struct kvm_vpcu
> for each level. VTL-vCPUs that belong to the same guest CPU share the
> same physical APIC id, but belong to different APIC groups where the
> apic group represents the vCPU's VTL.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---
>  arch/x86/kvm/hyperv.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
> index 2bfed69ba0db..5433107e7cc8 100644
> --- a/arch/x86/kvm/hyperv.h
> +++ b/arch/x86/kvm/hyperv.h
> @@ -23,6 +23,7 @@
>  
>  #include <linux/kvm_host.h>
>  #include "x86.h"
> +#include "lapic.h"
>  
>  /* "Hv#1" signature */
>  #define HYPERV_CPUID_SIGNATURE_EAX 0x31237648
> @@ -83,6 +84,23 @@ static inline struct kvm_hv_syndbg *to_hv_syndbg(struct kvm_vcpu *vcpu)
>  	return &vcpu->kvm->arch.hyperv.hv_syndbg;
>  }
>  
> +static inline struct kvm_vcpu *kvm_hv_get_vtl_vcpu(struct kvm_vcpu *vcpu, int vtl)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	u32 target_id = kvm_apic_id(vcpu);
> +
> +	kvm_apic_id_set_group(kvm, vtl, &target_id);
> +	if (vcpu->vcpu_id == target_id)
> +		return vcpu;
> +
> +	return kvm_get_vcpu_by_id(kvm, target_id);
> +}

> +
> +static inline u8 kvm_hv_get_active_vtl(struct kvm_vcpu *vcpu)
> +{
> +	return kvm_apic_group(vcpu);
> +}
> +
>  static inline u32 kvm_hv_get_vpindex(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);


Ideally I'll prefer the kernel to not know the VTL mapping at all but rather,
that each vCPU be assigned to an apic group / namespace and has its assigned VTL.

Then the kernel works in this way:

* Regular APIC IPI -> send it to the apic namespace to which the sender belongs or if we go with the idea of using
  multiple VMs, then this will work unmodified.

* Hardware interrupt -> send it to the vCPU/VM which userspace configured it to send via GSI mappings.

* HyperV IPI -> if same VTL as the vCPU assigned VTL -> deal with it the same as with regular IPI
             -> otherwise exit to the userspace.

* Page fault -> if related to violation of current VTL protection,
  exit to userspace, and the userspace can then queue the SynIC message, and wakeup the higher VTL.


Best regards,
	Maxim Levitsky



