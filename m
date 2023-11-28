Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE26F7FB2EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343813AbjK1Hjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjK1Hjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:39:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE86E1BD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701157194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kLrNRkdD5Hr4y2mW5Po+XDD+kga+nzWJCxtSKJ7NmZ4=;
        b=dsJMezrRMQeLbPQx3sg1YKRBxEGwrNOJAVh1xZzKec/LDUEijP1DUJKygc/GrgUrox/+z+
        ucyrNu/ERu5kCHTUwN35R0vbV/vsrOYPckiid0wU4mnRg2tmvLtymMOSqVLkTuEitDrhCo
        19TT5jj9qy0LEcv0OmB3U19VYh1gVfQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-vkZmuBv5PLSVcw-rDmyvwg-1; Tue, 28 Nov 2023 02:39:53 -0500
X-MC-Unique: vkZmuBv5PLSVcw-rDmyvwg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b2977d6baso30184325e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701157192; x=1701761992;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kLrNRkdD5Hr4y2mW5Po+XDD+kga+nzWJCxtSKJ7NmZ4=;
        b=QnlCKyavFX2IaZTb5SETMjnsAADClA1uXHAulXPI99ZeAWginXBsfYOqgfvXNRl4dA
         CSIEJ0oF9ZuE6VzCbpFWxIOCPsikZuIApUi8WHR1FwqTNoT/jj39b6XLsEJtUw5li4EP
         /bjuP3KIJFqpM86JvlXpplcqBgSX2cV3WIrHC+HV9+m5EL3a2xZUe5f46+q6wWeXOA0r
         wjCV/IdZD0fKfLlq7MZfXFj71EvanQGES2e6yiFBJW+Deg01Z2VEoDzBqIPhZEc1z5R7
         fMGvElwnxbcWw/3KTb5W5v4GVrSq+KryEZVNDZsBAJt4mooISak00nLQJ+xaXbajtYxK
         u8VA==
X-Gm-Message-State: AOJu0Yzq2N7JagXfBK+rQVQtMDwL4LlmbuyGGruRvZ/9yKSPNmjaGMUE
        3rEYBjzjfPBViKCZEbyXHjfaV7T7ChapHPLm1ePakm5NX8vTIBBkRA1Kw+9B//AKy08abrVOH93
        3zcX8lUN8OmH7piE4xqjfHdgM
X-Received: by 2002:adf:da45:0:b0:333:d38:9cf8 with SMTP id r5-20020adfda45000000b003330d389cf8mr703326wrl.23.1701157192441;
        Mon, 27 Nov 2023 23:39:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERlzB4vdViVC/ZzK0126j8AEfeNbvrpu7qTpdFP9K+CAsLwSGT0XYxI2khjFZG7X1sLqDpUg==
X-Received: by 2002:adf:da45:0:b0:333:d38:9cf8 with SMTP id r5-20020adfda45000000b003330d389cf8mr703318wrl.23.1701157192138;
        Mon, 27 Nov 2023 23:39:52 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d4a8e000000b00332e073f12bsm14064219wrq.19.2023.11.27.23.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:39:51 -0800 (PST)
Message-ID: <31cd6a37f565e07f3890027b3b3305a225f84956.camel@redhat.com>
Subject: Re: [RFC 17/33] KVM: x86/mmu: Allow setting memory attributes if
 VSM enabled
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk,
        jgowans@amazon.com, corbert@lwn.net, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, x86@kernel.org,
        linux-doc@vger.kernel.org
Date:   Tue, 28 Nov 2023 09:39:49 +0200
In-Reply-To: <20231108111806.92604-18-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
         <20231108111806.92604-18-nsaenz@amazon.com>
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
> VSM is also a user of memory attributes, so let it use
> kvm_set_mem_attributes().
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index feca077c0210..a1fbb905258b 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -7265,7 +7265,8 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
>  	 * Zapping SPTEs in this case ensures KVM will reassess whether or not
>  	 * a hugepage can be used for affected ranges.
>  	 */
> -	if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm)))
> +	if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm) &&
> +			 !kvm_hv_vsm_enabled(kvm)))
>  		return false;

IMHO on the long term, memory attributes should either be always enabled,
or the above check should became more generic.

But otherwise this patch looks reasonable.

>  
>  	return kvm_unmap_gfn_range(kvm, range);
> @@ -7322,7 +7323,8 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
>  	 * a range that has PRIVATE GFNs, and conversely converting a range to
>  	 * SHARED may now allow hugepages.
>  	 */
> -	if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm)))
> +	if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm) &&
> +			 !kvm_hv_vsm_enabled(kvm)))
>  		return false;
>  
>  	/*

Best regards,
	Maxim Levitsky

