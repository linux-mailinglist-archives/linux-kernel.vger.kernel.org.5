Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E547ECF62
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjKOTsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbjKOTsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:48:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8828E1AB;
        Wed, 15 Nov 2023 11:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=0CMykeQup+UcIXwLhRxd6ite3nv0zt1069OA+3hbP0Q=; b=t6AnYRFJPAtg1Cacp/8EbyRXN9
        G3nX2VuCjMsM7wBmvwx+bxLvsGdxWF3P8c51k0ubkoZx1RsipJvigEwTrY5FnCLjuVxPqTo0cCcz3
        LaY7msDUZ0FgrVZAf4wlCQ9fm8e+lpr0nLdYLupNHfGiSALppIOk/NnGQWFDgSKLpGuOZA0ZRquCd
        vuWBmAXc/TrOFExXydIgGJYNmUtA/88KIA7+A2n+V8Jf28aTX37I85toPBWi+vijBTNaczrrnjZVM
        Ebi+DPmwNCxUZ2MytyIzrmyqUahFDLDkXbahPraYzRu0aTuIuAYXjGO2jaC/ocLoI6pNJW4HcqqcS
        PcY6k65Q==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r3Lre-001cFD-18;
        Wed, 15 Nov 2023 19:47:54 +0000
Message-ID: <0f74ba84-a0fb-41cb-b22c-943f47c631da@infradead.org>
Date:   Wed, 15 Nov 2023 11:47:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LoongArch: KVM: Fix build due to API changes
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Tianrui Zhao <zhaotianrui@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>
Cc:     kvm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20231115090735.2404866-1-chenhuacai@loongson.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231115090735.2404866-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/23 01:07, Huacai Chen wrote:
> Commit 8569992d64b8f750e34b7858eac ("KVM: Use gfn instead of hva for
> mmu_notifier_retry") replaces mmu_invalidate_retry_hva() usage with
> mmu_invalidate_retry_gfn() for X86, LoongArch also need similar changes
> to fix build.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/loongarch/kvm/mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
> index 80480df5f550..9463ebecd39b 100644
> --- a/arch/loongarch/kvm/mmu.c
> +++ b/arch/loongarch/kvm/mmu.c
> @@ -627,7 +627,7 @@ static bool fault_supports_huge_mapping(struct kvm_memory_slot *memslot,
>   *
>   * There are several ways to safely use this helper:
>   *
> - * - Check mmu_invalidate_retry_hva() after grabbing the mapping level, before
> + * - Check mmu_invalidate_retry_gfn() after grabbing the mapping level, before
>   *   consuming it.  In this case, mmu_lock doesn't need to be held during the
>   *   lookup, but it does need to be held while checking the MMU notifier.
>   *
> @@ -807,7 +807,7 @@ static int kvm_map_page(struct kvm_vcpu *vcpu, unsigned long gpa, bool write)
>  
>  	/* Check if an invalidation has taken place since we got pfn */
>  	spin_lock(&kvm->mmu_lock);
> -	if (mmu_invalidate_retry_hva(kvm, mmu_seq, hva)) {
> +	if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn)) {
>  		/*
>  		 * This can happen when mappings are changed asynchronously, but
>  		 * also synchronously if a COW is triggered by

-- 
~Randy
