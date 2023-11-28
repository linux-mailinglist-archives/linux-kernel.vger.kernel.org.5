Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9547FB2E1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343746AbjK1Hgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343885AbjK1HgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:36:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85041D64
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701156966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dsdX9JWACBEXSXLe6/UFcpYHlYKNddh0vSmdD6PItQ0=;
        b=DRSTe3AJD+EV/njZcwbuzYrqKv4/Aih6tmlA1wIzAxz8oykBqSrDCPTnMIs/iiTjAnj/IT
        E/QRMioGRCtNhzp4Ncmy3SxFub5c/dCeq209qOaGySoOxnuVsR+aotjYnQTcKqhagivBok
        Jer84wrYj/1BewkI06rHUBpkNapV1PM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-hbxQd84dNbiDG-1FQ40WPw-1; Tue, 28 Nov 2023 02:36:04 -0500
X-MC-Unique: hbxQd84dNbiDG-1FQ40WPw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b2be01a2dso29780105e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156963; x=1701761763;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dsdX9JWACBEXSXLe6/UFcpYHlYKNddh0vSmdD6PItQ0=;
        b=JjHEqHP5DzWu+pQKiGMw1QWxx3II5LnBGssr4uqeVUjas/wtnxjl+2qSsZZ3gBns/W
         nsRoHb8EknvC2iFf0Ov8p+WcSshmGzrFsMVqAQ2JWi0UKiZuVtLlLBVQZVJunuBKF9VF
         gz7dakqKsaezRVrUhfpOpx2w8Q8FYpzZINuptYg05Ftnty9yCCEbVltC0yocKG9tJMmF
         W0M56d3qenGCgR0IqScUXHFxwd8J2KdF9e1HJFdP3TIVn1tu3uy7GpT/OJ6Pq4khK/GC
         7tPN9yORNp2zaItxda77IcdjFrugxAtWMHsgoW/BlU15e4jANyjsnkyi8TolU4/sUFME
         9z8g==
X-Gm-Message-State: AOJu0YwQuHwYJrReSvyQ90fM8APDyg1GP8YSHgCF+dlaRhePPQIoqbA6
        EoQrDHO7WmpjG0knpiAje1sGMWrH0ilQleSZ6pq2kYo6XdNoc+ArQnb1WWut2uBGWLZPnZF/UCH
        jZ8DIRXsQwI0Uzatfc7M0YhSh
X-Received: by 2002:a05:600c:290:b0:40b:377a:2ac1 with SMTP id 16-20020a05600c029000b0040b377a2ac1mr10104660wmk.20.1701156963678;
        Mon, 27 Nov 2023 23:36:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAOpVyXJnyHDBx5SdhWAQsdciuEWUKK9zbiujUHqCWUzkEMj7vCi7I9Y4a12hutDtc/rzKcw==
X-Received: by 2002:a05:600c:290:b0:40b:377a:2ac1 with SMTP id 16-20020a05600c029000b0040b377a2ac1mr10104637wmk.20.1701156963320;
        Mon, 27 Nov 2023 23:36:03 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id bh5-20020a05600c3d0500b00405d9a950a2sm17293024wmb.28.2023.11.27.23.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:36:03 -0800 (PST)
Message-ID: <69c10848d4a4f36ab71ca518f4b23d4dee377572.camel@redhat.com>
Subject: Re: [RFC 16/33] KVM: x86/mmu: Expose R/W/X flags during memory
 fault exits
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk,
        jgowans@amazon.com, corbert@lwn.net, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, x86@kernel.org,
        linux-doc@vger.kernel.org
Date:   Tue, 28 Nov 2023 09:36:00 +0200
In-Reply-To: <20231108111806.92604-17-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
         <20231108111806.92604-17-nsaenz@amazon.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-08 at 11:17 +0000, Nicolas Saenz Julienne wrote:
> Include the fault's read, write and execute status when exiting to
> user-space.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---
>  arch/x86/kvm/mmu/mmu.c   | 4 ++--
>  include/linux/kvm_host.h | 9 +++++++--
>  include/uapi/linux/kvm.h | 6 ++++++
>  3 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 4e02d506cc25..feca077c0210 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4300,8 +4300,8 @@ static inline u8 kvm_max_level_for_order(int order)
>  static void kvm_mmu_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
>  					      struct kvm_page_fault *fault)
>  {
> -	kvm_prepare_memory_fault_exit(vcpu, fault->gfn << PAGE_SHIFT,
> -				      PAGE_SIZE, fault->write, fault->exec,
> +	kvm_prepare_memory_fault_exit(vcpu, fault->gfn << PAGE_SHIFT, PAGE_SIZE,
> +				      fault->write, fault->exec, fault->user,
>  				      fault->is_private);
>  }
>  
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 71e1e8cf8936..631fd532c97a 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2367,14 +2367,19 @@ static inline void kvm_account_pgtable_pages(void *virt, int nr)
>  static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
>  						 gpa_t gpa, gpa_t size,
>  						 bool is_write, bool is_exec,
> -						 bool is_private)
> +						 bool is_read, bool is_private)

It almost feels like there is a need for a struct to hold all of those parameters.

>  {
>  	vcpu->run->exit_reason = KVM_EXIT_MEMORY_FAULT;
>  	vcpu->run->memory_fault.gpa = gpa;
>  	vcpu->run->memory_fault.size = size;
>  
> -	/* RWX flags are not (yet) defined or communicated to userspace. */
>  	vcpu->run->memory_fault.flags = 0;
> +	if (is_read)
> +		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_READ;
> +	if (is_write)
> +		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_WRITE;
> +	if (is_exec)
> +		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_EXECUTE;
>  	if (is_private)
>  		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_PRIVATE;
>  }
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 03f5c08fd7aa..0ddffb8b0c99 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -533,7 +533,13 @@ struct kvm_run {
>  		} notify;
>  		/* KVM_EXIT_MEMORY_FAULT */
>  		struct {
> +#define KVM_MEMORY_EXIT_FLAG_READ	(1ULL << 0)
> +#define KVM_MEMORY_EXIT_FLAG_WRITE	(1ULL << 1)
> +#define KVM_MEMORY_EXIT_FLAG_EXECUTE	(1ULL << 2)
>  #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
> +#define KVM_MEMORY_EXIT_NO_ACCESS                            \
> +	(KVM_MEMORY_EXIT_FLAG_NR | KVM_MEMORY_EXIT_FLAG_NW | \
> +	 KVM_MEMORY_EXIT_FLAG_NX)
>  			__u64 flags;
>  			__u64 gpa;
>  			__u64 size;


I don't think that KVM_MEMORY_EXIT_FLAG_NR, KVM_MEMORY_EXIT_FLAG_NW, KVM_MEMORY_EXIT_FLAG_NX are defined anywhere.
Also why KVM_MEMORY_EXIT_NO_ACCESS is needed - userspace can infer it from the lack of other access flags.

Best regards,
	Maxim Levitsky

