Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1422D7FB2D6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343778AbjK1Hey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbjK1Heq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:34:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91C68E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701156891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Af4R3R0mC73NeF28UK2gUhxOsO8EQNBm/EtMet76tN8=;
        b=gbAfr97/CecAnCi7KA/O9L1oUnaoSbC7TIMjsGowSGhgGW6L8pRTuKrHvQkILBCUzP6BpJ
        X9BGZgrACqWZjHhx8P6PzIlWTxNbkxgc2ILvSRiemMXIRAl4JBMS4B5SAqkIpCOTy9iU+C
        K21pXWNMVVNxNE/8uz+F6c6suxXeGxc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-HSll2ZnJMumqgjSUMO2Tzw-1; Tue, 28 Nov 2023 02:34:47 -0500
X-MC-Unique: HSll2ZnJMumqgjSUMO2Tzw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50abbf4ee79so5488861e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156886; x=1701761686;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Af4R3R0mC73NeF28UK2gUhxOsO8EQNBm/EtMet76tN8=;
        b=JrBVsmxBqfkR5qi2ZkoCYhCNMB7vSBMUtzt2LQRSxwgYnmXjwvhZ1L60RCNJzRFmmM
         qmrY/M97edP7P39B09UnNBPOHCZ0FKTo75IQJQ1LgBE8+HdGuuN9INOeNrzf2jVmKbzX
         y8apivEPqbqGPoEV5azLPVPWT0ftaVKn+r6FK0NTq35cpx0GoTNWQ70QWicePWnqUqcf
         Y15q8xwYnoJgeIg0OKabzJ7pEEezPFL+kuWd/SJmnzfilW7vXnQMHb25iVpHOYWXc9/D
         n0e3Q7K4OcGiM02WzLHzefHvxhk0k6z6r0DW9w6uPmdTyc59fsDiymN3fG4zfoTG0VAZ
         Ar9Q==
X-Gm-Message-State: AOJu0YzpJL5m+XNdDx8zc/zl82g+X9+PrlNIFRZkWglAcQYWiJJZdOhR
        BfHSbzfJcHy2JSnowhz1j74/KLI9yVGkuw+TAu32smTJdRjOL7yHSUCIAMytZ/I/VNpazsR6yLl
        YF1wlzYoliUYKgvhSBVbE9KhP
X-Received: by 2002:a05:6512:124a:b0:50b:b505:4f4f with SMTP id fb10-20020a056512124a00b0050bb5054f4fmr3321280lfb.33.1701156886271;
        Mon, 27 Nov 2023 23:34:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4mUGubmaDvDINFkQm2EatID8OHN179Us3EEdFYWLdprOFopXHoieMVKbKo+nPjj8TopAfRw==
X-Received: by 2002:a05:6512:124a:b0:50b:b505:4f4f with SMTP id fb10-20020a056512124a00b0050bb5054f4fmr3321274lfb.33.1701156886088;
        Mon, 27 Nov 2023 23:34:46 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id bd11-20020a05600c1f0b00b0040b4e44cf8dsm719001wmb.47.2023.11.27.23.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:34:45 -0800 (PST)
Message-ID: <2abdad452c601461869365fa804fa02a6a50df0a.camel@redhat.com>
Subject: Re: [RFC 15/33] KVM: x86/mmu: Introduce infrastructure to handle
 non-executable faults
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk,
        jgowans@amazon.com, corbert@lwn.net, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, x86@kernel.org,
        linux-doc@vger.kernel.org
Date:   Tue, 28 Nov 2023 09:34:43 +0200
In-Reply-To: <20231108111806.92604-16-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
         <20231108111806.92604-16-nsaenz@amazon.com>
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
> The upcoming per-VTL memory protections support needs to fault in
> non-executable memory. Introduce a new attribute in struct
> kvm_page_fault, map_executable, to control whether the gfn range should
> be mapped as executable.
> 
> No functional change intended.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---
>  arch/x86/kvm/mmu/mmu.c          | 6 +++++-
>  arch/x86/kvm/mmu/mmu_internal.h | 2 ++
>  arch/x86/kvm/mmu/tdp_mmu.c      | 8 ++++++--
>  3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 2afef86863fb..4e02d506cc25 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3245,6 +3245,7 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
>  	struct kvm_mmu_page *sp;
>  	int ret;
>  	gfn_t base_gfn = fault->gfn;
> +	unsigned access = ACC_ALL;
>  
>  	kvm_mmu_hugepage_adjust(vcpu, fault);
>  
> @@ -3274,7 +3275,10 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
>  	if (WARN_ON_ONCE(it.level != fault->goal_level))
>  		return -EFAULT;
>  
> -	ret = mmu_set_spte(vcpu, fault->slot, it.sptep, ACC_ALL,
> +	if (!fault->map_executable)
> +		access &= ~ACC_EXEC_MASK;
> +
> +	ret = mmu_set_spte(vcpu, fault->slot, it.sptep, access,
>  			   base_gfn, fault->pfn, fault);
>  	if (ret == RET_PF_SPURIOUS)
>  		return ret;


> diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> index b66a7d47e0e4..bd62c4d5d5f1 100644
> --- a/arch/x86/kvm/mmu/mmu_internal.h
> +++ b/arch/x86/kvm/mmu/mmu_internal.h
> @@ -239,6 +239,7 @@ struct kvm_page_fault {
>  	kvm_pfn_t pfn;
>  	hva_t hva;
>  	bool map_writable;
> +	bool map_executable;
>  
>  	/*
>  	 * Indicates the guest is trying to write a gfn that contains one or
> @@ -298,6 +299,7 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>  		.req_level = PG_LEVEL_4K,
>  		.goal_level = PG_LEVEL_4K,
>  		.is_private = kvm_mem_is_private(vcpu->kvm, cr2_or_gpa >> PAGE_SHIFT),
> +		.map_executable = true,
>  	};
>  	int r;
>  
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 6cd4dd631a2f..46f3e72ab770 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -957,14 +957,18 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
>  	u64 new_spte;
>  	int ret = RET_PF_FIXED;
>  	bool wrprot = false;
> +	unsigned access = ACC_ALL;
>  
>  	if (WARN_ON_ONCE(sp->role.level != fault->goal_level))
>  		return RET_PF_RETRY;
>  
> +	if (!fault->map_executable)
> +		access &= ~ACC_EXEC_MASK;
> +
>  	if (unlikely(!fault->slot))
> -		new_spte = make_mmio_spte(vcpu, iter->gfn, ACC_ALL);
> +		new_spte = make_mmio_spte(vcpu, iter->gfn, access);
>  	else
> -		wrprot = make_spte(vcpu, sp, fault->slot, ACC_ALL, iter->gfn,
> +		wrprot = make_spte(vcpu, sp, fault->slot, access, iter->gfn,
>  					 fault->pfn, iter->old_spte, fault->prefetch, true,
>  					 fault->map_writable, &new_spte);

Overall this patch makes sense but I don't know the mmu well enough to be sure
that there are no corner cases which are not handeled here.

>  


Best regards,
	Maxim Levitsky

