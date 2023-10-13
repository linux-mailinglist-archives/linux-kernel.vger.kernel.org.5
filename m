Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C2C7C8A61
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjJMQLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjJMQLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:11:34 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5564A4EFD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:09:20 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7d261a84bso35917607b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697213330; x=1697818130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5jpQKDWlX2FMxNrIBcRrOyniIIs22PEbqHRQyt5DVnY=;
        b=OS/P6lnipweaR9lkIl2sv/lVVCO/HW8DzlkJurqfmlsTCcRwOC7G1FacUVRXdk7EFC
         fWi4MxicySmAkNK850XetT65hgXDWKOJdPFZNxzuovKPPOxtkoBmQKD3PZ8GSNsQ6n50
         J1YMOyxUSd5vBeCYl1Zpgsmp300vexSETUGu2nE/LOdn/QEelN7bSetYElcdua4S8EMG
         e2HpmgCkxSnEtKr0zYQ0G/9Vrkq7gFLwpMu0/z6t8v83lZ2g82r+I2+5fUVe4+bG2rYQ
         NQV9ByJmvYLCxq8GGzbgJPSNl2Ce/oMfgbIh5/42kMnhUuMV960Ka3wWvDYtX1pHRKJf
         Tj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697213330; x=1697818130;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jpQKDWlX2FMxNrIBcRrOyniIIs22PEbqHRQyt5DVnY=;
        b=kCLs8XDXCE2DKm6fQxv6am7b6l7S9rY2kUksYhgdue+UzpPb+XbfyvKMnFgizbEzab
         RMcYadLKMz1y7upALGlBxGGopwWcWKMKE2DoUEz+y6O0BJpz4REnMqOCbzYm4xKrIc5z
         bxvsbspwDrQHtBnul1y/R6lFci3GIvzIfZ12UWIoXns5O1+eLDRx/YvOggGeYWOVheOE
         9Umm+EhcQ8o2+V+6MaVHFdjDI/vpSkp3f27xAKjt/Bs5CA0kVIIUS/Gbh6Q7VqGo3RXU
         bP+Y8BqWCo2SZiCFScHVErvNCEPi6D+4QSVx1R0y4GF6gaq3sEBMSj/4Awvn1V9q4y5O
         E+GQ==
X-Gm-Message-State: AOJu0Yw4w1HGv+g7Klgz6CoZ+PZkcFdYC1uPrTQ5cvPgAkbl27dZO1vZ
        qweq9Ik59hrpmJ8xRj5FzvEyp9nmXKk=
X-Google-Smtp-Source: AGHT+IGr+qhBt8pjxzcVd1SRmV9WwBcC/LddWp+eOz/KUseqJ6SHMrtLAjMeiKp99TKb7WRh7jqSjWC2AUY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:138d:b0:d9a:4e29:6353 with SMTP id
 x13-20020a056902138d00b00d9a4e296353mr268090ybu.0.1697213330411; Fri, 13 Oct
 2023 09:08:50 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:08:48 -0700
In-Reply-To: <20231012152542.1355621-1-pbonzini@redhat.com>
Mime-Version: 1.0
References: <20231012152542.1355621-1-pbonzini@redhat.com>
Message-ID: <ZSlrkKHT_U64raV4@google.com>
Subject: Re: [PATCH] KVM: MIPS: fix -Wunused-but-set-variable warning
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=" <philmd@linaro.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023, Paolo Bonzini wrote:
> The variable is completely unused, remove it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/mips/kvm/mmu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
> index 7b2ac1319d70..467ee6b95ae1 100644
> --- a/arch/mips/kvm/mmu.c
> +++ b/arch/mips/kvm/mmu.c
> @@ -592,7 +592,7 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
>  	gfn_t gfn = gpa >> PAGE_SHIFT;
>  	int srcu_idx, err;
>  	kvm_pfn_t pfn;
> -	pte_t *ptep, entry, old_pte;
> +	pte_t *ptep, entry;
>  	bool writeable;
>  	unsigned long prot_bits;
>  	unsigned long mmu_seq;
> @@ -664,7 +664,6 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
>  	entry = pfn_pte(pfn, __pgprot(prot_bits));
>  
>  	/* Write the PTE */
> -	old_pte = *ptep;
>  	set_pte(ptep, entry);

Heh, 7 year old bug gets two fixes within a few days :-)

https://lore.kernel.org/all/20231010085434.2678144-1-chenhuacai@loongson.cn
