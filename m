Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277507FB306
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343876AbjK1Hnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjK1Hnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:43:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A5A183
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701157425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lzkCjq1Pr3G6+48rSu2hJkxqLKhRFqoHTPX5jmg05LI=;
        b=iAtPLN4/XAGTMjUJeb7nyADX8jOglo5ekaJ3XQmvNWYr3TGmM/plrGC26A0xDzPqyPsfug
        fGftP6dwkgR/EMhBDR034XmACk5VW0KCZevy0DVrxWqxRweHOGJ7iK0zbpqsvX4yxgoThS
        8FwprrZ10MWP5RZ5uOUgHmDJjoT9NQE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-ZiTWXejyOEqNiFpT37pK_A-1; Tue, 28 Nov 2023 02:43:41 -0500
X-MC-Unique: ZiTWXejyOEqNiFpT37pK_A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c8749e1c2dso43497511fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:43:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701157420; x=1701762220;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lzkCjq1Pr3G6+48rSu2hJkxqLKhRFqoHTPX5jmg05LI=;
        b=W5hptVDkD3RXqGrOn7YBhPqYjUqOBOUCldDjcgioryCQFy7eyusU/iMHcW7VT2WEwM
         cOIGxdrWSwQdxVAaolKV36KAVlNvG1kAibbt7bNLZD2p8aInWWWINfscPxZE/AzPIQB+
         fv1aEcQ9X/UgxExTQE4kLQu75MhI+x4P9Ha2FopjTtEb7/OCNxx/zmBy6F1/Hx49ay4y
         pFdsvi9PVm3og7ynRo68uEX+m1RN28Z71aMY01mW3b9JjYrmAcuaYNbvOktu+X8H8t2m
         1radz0fLCycvfaQhBBlM54odODwtsqRwffjngtjrMEwPjNusZvGOtXcj5ofte8T1wkdh
         cgyw==
X-Gm-Message-State: AOJu0YyU9GnW3ziSbX+dH00LcAZ1vlAMBvPme86XdYeLwDfHzGDpkpAb
        r2f7C4Y0ao3Pa4foVGd25LXfBWilGdrsHla5JoSLlhJigL88z3IBra+vqSuOvSireWTe80xtuKx
        b4j0Ql58w/d0znFzV5j68VAu6
X-Received: by 2002:a2e:2245:0:b0:2c9:9fbf:52b1 with SMTP id i66-20020a2e2245000000b002c99fbf52b1mr4598008lji.13.1701157420316;
        Mon, 27 Nov 2023 23:43:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjzV+IxmefpgSrd19SOQHqieab0h0JslyRj7/06WT0K0hRYoN59U9CMVG8uqipgy8hVt5sdg==
X-Received: by 2002:a2e:2245:0:b0:2c9:9fbf:52b1 with SMTP id i66-20020a2e2245000000b002c99fbf52b1mr4597992lji.13.1701157420001;
        Mon, 27 Nov 2023 23:43:40 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id bg9-20020a05600c3c8900b0040836519dd9sm16509486wmb.25.2023.11.27.23.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:43:39 -0800 (PST)
Message-ID: <9efb185b80e88d32a5c57f10f361e144004193c3.camel@redhat.com>
Subject: Re: [RFC 20/33] KVM: x86/mmu: Decouple hugepage_has_attrs() from
 struct kvm's mem_attr_array
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk,
        jgowans@amazon.com, corbert@lwn.net, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, x86@kernel.org,
        linux-doc@vger.kernel.org
Date:   Tue, 28 Nov 2023 09:43:37 +0200
In-Reply-To: <20231108111806.92604-21-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
         <20231108111806.92604-21-nsaenz@amazon.com>
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
> Decouple hugepage_has_attrs() from struct kvm's mem_attr_array to
> allow other memory attribute sources to use the function.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 4ace2f8660b0..c0fd3afd6be5 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -7290,19 +7290,19 @@ static void hugepage_set_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
>  	lpage_info_slot(gfn, slot, level)->disallow_lpage |= KVM_LPAGE_MIXED_FLAG;
>  }
>  
> -static bool hugepage_has_attrs(struct kvm *kvm, struct kvm_memory_slot *slot,
> -			       gfn_t gfn, int level, unsigned long attrs)
> +static bool hugepage_has_attrs(struct xarray *mem_attr_array,
> +			       struct kvm_memory_slot *slot, gfn_t gfn,
> +			       int level, unsigned long attrs)
>  {
>  	const unsigned long start = gfn;
>  	const unsigned long end = start + KVM_PAGES_PER_HPAGE(level);
>  
>  	if (level == PG_LEVEL_2M)
> -		return kvm_range_has_memory_attributes(&kvm->mem_attr_array,
> -						       start, end, attrs);
> +		return kvm_range_has_memory_attributes(mem_attr_array, start, end, attrs);
>  
>  	for (gfn = start; gfn < end; gfn += KVM_PAGES_PER_HPAGE(level - 1)) {
>  		if (hugepage_test_mixed(slot, gfn, level - 1) ||
> -		    attrs != kvm_get_memory_attributes(&kvm->mem_attr_array, gfn))
> +		    attrs != kvm_get_memory_attributes(mem_attr_array, gfn))
>  			return false;
>  	}
>  	return true;
> @@ -7344,7 +7344,8 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
>  			 * misaligned address regardless of memory attributes.
>  			 */
>  			if (gfn >= slot->base_gfn) {
> -				if (hugepage_has_attrs(kvm, slot, gfn, level, attrs))
> +				if (hugepage_has_attrs(&kvm->mem_attr_array,
> +						       slot, gfn, level, attrs))
>  					hugepage_clear_mixed(slot, gfn, level);
>  				else
>  					hugepage_set_mixed(slot, gfn, level);
> @@ -7366,7 +7367,8 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
>  		 */
>  		if (gfn < range->end &&
>  		    (gfn + nr_pages) <= (slot->base_gfn + slot->npages)) {
> -			if (hugepage_has_attrs(kvm, slot, gfn, level, attrs))
> +			if (hugepage_has_attrs(&kvm->mem_attr_array, slot, gfn,
> +					       level, attrs))
>  				hugepage_clear_mixed(slot, gfn, level);
>  			else
>  				hugepage_set_mixed(slot, gfn, level);
> @@ -7405,7 +7407,7 @@ void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
>  			unsigned long attrs =
>  				kvm_get_memory_attributes(&kvm->mem_attr_array, gfn);
>  
> -			if (hugepage_has_attrs(kvm, slot, gfn, level, attrs))
> +			if (hugepage_has_attrs(&kvm->mem_attr_array, slot, gfn, level, attrs))
>  				hugepage_clear_mixed(slot, gfn, level);
>  			else
>  				hugepage_set_mixed(slot, gfn, level);

hugepage_has_attrs is also not a name that conveys the meaning of what it does IMHO,
but I don't know a better name to be honest.

Same remarks as for other two patches apply here as well.

Best regards,
	Maxim Levitsky

