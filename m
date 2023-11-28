Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A617FB2FC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343867AbjK1Hlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjK1Hlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:41:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C10D45
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701157312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hj+ePaztyH38XwsDFKaGQMIHjoROMLLdxOGdK4dpGbY=;
        b=hUxMCTkMISE2SWzZEmNMvXS0vL2sRjoBMCKLvs0LTnxhbK7AwFSIxJppCoi/1LsBwojktS
        uw1QZUo0LDNM272miIEUfNMcUnOe1iRnAKYdLkqwr1A586hY8FWAHltE6iKvGcWkirk9u+
        nK3m/sAHUko6D9n1sVj8oiYc9uZhkxA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-69d2PhgyN0e6jowimbnZWA-1; Tue, 28 Nov 2023 02:41:51 -0500
X-MC-Unique: 69d2PhgyN0e6jowimbnZWA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c9b79125f8so1114991fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:41:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701157309; x=1701762109;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hj+ePaztyH38XwsDFKaGQMIHjoROMLLdxOGdK4dpGbY=;
        b=W3DBgBES3DbdZlrGNm07gIAnsMhCRpSevDeTaoXQzLjVFwQ4c6BmSqOrNG5gxrWChu
         J8g3fgZsn7WdYKtGnJemikDxE/rZWL/FtHMjTIOX/X/YMppdTZIOXXpw7aqnYrtcXEiG
         cI8WtfuisZoQbKJcKFPVFG7AmBH3njKxcRlfad81xtwPouUBNr0GhlYsukUBC6ExYX22
         B5HwCvtRhatDb2kx5mLuVJ5FEvnU9Uv9ozsIlVeNMLzo849vTpVXnDhMplmtI6ed9oRT
         7OZzGKrJHXEJ6fC4DpghgOVdRWB4/k3PFCNvcOSOZ7hEWAS/dMn0yahH7XfX7rQ1UurL
         fqGA==
X-Gm-Message-State: AOJu0YydgnPi+ROhLMIgrRSKgi24Sbc7H8lk+2uypujhYl9x91CBxw8J
        vY/IpIEtTi++SI5eL/G9ENEDWhSctDFukj318xCPjtjZYgkcKrNIWfqv5KCPtcAa8Z6PsYqQ1TU
        43aCuWrxeOqR8oGmgzsxplq00nx7qjBxj
X-Received: by 2002:a2e:9e8a:0:b0:2b9:412a:111d with SMTP id f10-20020a2e9e8a000000b002b9412a111dmr9369584ljk.42.1701157309358;
        Mon, 27 Nov 2023 23:41:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3FE3J5y8X/hBV92oAOBL8IN3pj8MBH48Z78QOogI1DEahZHBZbEG4Kbce22YYj3CMRPt4sQ==
X-Received: by 2002:a2e:9e8a:0:b0:2b9:412a:111d with SMTP id f10-20020a2e9e8a000000b002b9412a111dmr9369570ljk.42.1701157309050;
        Mon, 27 Nov 2023 23:41:49 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id q19-20020a05600c46d300b0040b35195e54sm16408634wmo.5.2023.11.27.23.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:41:48 -0800 (PST)
Message-ID: <24f037ee4547a1726e358900a63755f5db0e6f39.camel@redhat.com>
Subject: Re: [RFC 18/33] KVM: x86: Decouple kvm_get_memory_attributes() from
 struct kvm's mem_attr_array
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk,
        jgowans@amazon.com, corbert@lwn.net, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, x86@kernel.org,
        linux-doc@vger.kernel.org
Date:   Tue, 28 Nov 2023 09:41:46 +0200
In-Reply-To: <20231108111806.92604-19-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
         <20231108111806.92604-19-nsaenz@amazon.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-08 at 11:17 +0000, Nicolas Saenz Julienne wrote:
> Decouple kvm_get_memory_attributes() from struct kvm's mem_attr_array to
> allow other memory attribute sources to use the function.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---
>  arch/x86/kvm/mmu/mmu.c   | 5 +++--
>  include/linux/kvm_host.h | 8 +++++---
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index a1fbb905258b..96421234ca88 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -7301,7 +7301,7 @@ static bool hugepage_has_attrs(struct kvm *kvm, struct kvm_memory_slot *slot,
>  
>  	for (gfn = start; gfn < end; gfn += KVM_PAGES_PER_HPAGE(level - 1)) {
>  		if (hugepage_test_mixed(slot, gfn, level - 1) ||
> -		    attrs != kvm_get_memory_attributes(kvm, gfn))
> +		    attrs != kvm_get_memory_attributes(&kvm->mem_attr_array, gfn))
>  			return false;
>  	}
>  	return true;
> @@ -7401,7 +7401,8 @@ void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
>  		 * be manually checked as the attributes may already be mixed.
>  		 */
>  		for (gfn = start; gfn < end; gfn += nr_pages) {
> -			unsigned long attrs = kvm_get_memory_attributes(kvm, gfn);
> +			unsigned long attrs =
> +				kvm_get_memory_attributes(&kvm->mem_attr_array, gfn);
>  
>  			if (hugepage_has_attrs(kvm, slot, gfn, level, attrs))
>  				hugepage_clear_mixed(slot, gfn, level);
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 631fd532c97a..4242588e3dfb 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2385,9 +2385,10 @@ static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
>  }
>  
>  #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> -static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
> +static inline unsigned long
> +kvm_get_memory_attributes(struct xarray *mem_attr_array, gfn_t gfn)
>  {
> -	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
> +	return xa_to_value(xa_load(mem_attr_array, gfn));
>  }

Can we wrap the 'struct xarray *' with a struct even if it will have a single member
to make it clearer what type the 'kvm_get_memory_attributes' receives.
Also maybe rename this to something like 'kvm_get_memory_attributes_for_gfn'?

>  
>  bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> @@ -2400,7 +2401,8 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
>  static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>  {
>  	return IS_ENABLED(CONFIG_KVM_PRIVATE_MEM) &&
> -	       kvm_get_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +	       kvm_get_memory_attributes(&kvm->mem_attr_array, gfn) &
> +		       KVM_MEMORY_ATTRIBUTE_PRIVATE;
>  }
>  #else
>  static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)


Also if we go with VM per VTL approach, we won't need this, each VM can already have its own memory attributes.

Best regards,
	Maxim Levitsky



