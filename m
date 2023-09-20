Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55907A8DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjITUhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjITUhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:37:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A92FB9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:37:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d84acda47aeso405877276.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695242262; x=1695847062; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ke8Z55Fzu2JKAUQugjnNSN+yilI9hv8hL0qCM2xQHoo=;
        b=JBgzipvxH4GpmAsPpkmBXsJ2OynGNULO/ECE5o8ZtF8PPnEasLeKDo99fYYWL34RFI
         Avp+gZ/q81y/fb6LwsYzj72VLnZE/na6geNE4CsBhLvd+RoLV/8cfsqZuPqdrnm+CKTg
         CXZp75nNA7ZIbVeoR43E6AKPSP4xOJq4+Aeh+csccnLYigsA54WhH7hWdLXTSOMlRd2c
         BBsbpItfWY7rJD2FPMAKAP2vAtYPrNd/eblMSUNmdi1owfs3zVaNw39BDibjs/iCs702
         1Z6ITxnwOBoOkQhis/VSE2Q8Zz6fSW1uqkCeP39xDDosiKLcQY9gi7IIxjJ1Psq7SBUX
         oqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695242262; x=1695847062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ke8Z55Fzu2JKAUQugjnNSN+yilI9hv8hL0qCM2xQHoo=;
        b=mG4mkwny783Q3x+ciaFGKQrMs75LOS/M3R27Iz+72OK6pk+dLUPrWds4vianrROi5m
         tXTO9BzmO0nk8+qXXmFn3tZ1JLGm8Vhyrs0xvYdg2rhZvoijbRJBMy960Hv3kgbstI8x
         m7v5JptkZFtFwnQy+RcEHzKSlrAr/dvuOmYQNhZVjCGTDnIymtJrEGdK2nquQaomwN1K
         R+VbiApS2GNjhQ4A3f/BHPGRSeitCASFxUENBBidiFEmQDlPk+HXhwzfKN/v++vtmO5N
         w/HWLwm/2sbS6E6Qd/VnYEj4KlON4hZ08hMlUa5uKTtalmcJy1pJ6Ar+KD/T+t+Ptsvb
         gs1A==
X-Gm-Message-State: AOJu0YzLUhj59ITOCQvGaoi189QvcYxoyUJm+7qghZZHyCat9OUFmd28
        CQD2JY9A6to9W5Zz/i2q3A9lZD+/iNA=
X-Google-Smtp-Source: AGHT+IH8CNIWITFsrgppaygErXmKK03IDLuJcOpZJ7gFWKpVHRpldBqCXG7nsBI/YtgK51P/0FDFxn70SaY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ca8b:0:b0:d77:bcce:eb11 with SMTP id
 a133-20020a25ca8b000000b00d77bcceeb11mr53094ybg.10.1695242262250; Wed, 20 Sep
 2023 13:37:42 -0700 (PDT)
Date:   Wed, 20 Sep 2023 13:37:40 -0700
In-Reply-To: <20230912002703.3924521-2-acdunlap@google.com>
Mime-Version: 1.0
References: <20230912002703.3924521-1-acdunlap@google.com> <20230912002703.3924521-2-acdunlap@google.com>
Message-ID: <ZQtYFAA9vD7gJM1t@google.com>
Subject: Re: [PATCH v2 1/2] x86/sev-es: Allow copy_from_kernel_nofault in
 earlier boot
From:   Sean Christopherson <seanjc@google.com>
To:     Adam Dunlap <acdunlap@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Peter Gonda <pgonda@google.com>,
        David Rientjes <rientjes@google.com>,
        Khalid ElMously <khalid.elmously@canonical.com>,
        Jacob Xu <jacobhxu@google.com>
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

On Mon, Sep 11, 2023, Adam Dunlap wrote:
> Previously, if copy_from_kernel_nofault was called before
> boot_cpu_data.x86_virt_bits was set up, then it would trigger undefined
> behavior due to a shift by 64. This ended up causing boot failures in
> the latest version of ubuntu2204 in the gcp project when using SEV-SNP.
> Specifically, this function is called during an early #VC handler which
> is triggered by a cpuid to check if nx is implemented.

Why not stuff boot_cpu_data.x86_virt_bits to a "default" value that is guaranteed
to be accurate (or at least safe) for the purposes of the early boot code.  I.e.
set it to 48 for 64-bit kernels.

That'd avoid the extra conditional, and would avoid laying whack-a-mole with
anything else that consumes x86_virt_bits.

> Fixes: 1aa9aa8ee517 ("x86/sev-es: Setup GHCB-based boot #VC handler")
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Adam Dunlap <acdunlap@google.com>
> ---
>  arch/x86/mm/maccess.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/mm/maccess.c b/arch/x86/mm/maccess.c
> index 5a53c2cc169c..6993f026adec 100644
> --- a/arch/x86/mm/maccess.c
> +++ b/arch/x86/mm/maccess.c
> @@ -9,12 +9,21 @@ bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
>  	unsigned long vaddr = (unsigned long)unsafe_src;
>  
>  	/*
> -	 * Range covering the highest possible canonical userspace address
> -	 * as well as non-canonical address range. For the canonical range
> -	 * we also need to include the userspace guard page.
> +	 * Do not allow userspace addresses.  This disallows
> +	 * normal userspace and the userspace guard page:
>  	 */
> -	return vaddr >= TASK_SIZE_MAX + PAGE_SIZE &&
> -	       __is_canonical_address(vaddr, boot_cpu_data.x86_virt_bits);
> +	if (vaddr < TASK_SIZE_MAX + PAGE_SIZE)
> +		return false;
> +
> +	/*
> +	 * Allow everything during early boot before 'x86_virt_bits'
> +	 * is initialized.  Needed for instruction decoding in early
> +	 * exception handlers.
> +	 */
> +	if (!boot_cpu_data.x86_virt_bits)
> +		return true;
> +
> +	return __is_canonical_address(vaddr, boot_cpu_data.x86_virt_bits);
>  }
>  #else
>  bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
> -- 
> 2.42.0.283.g2d96d420d3-goog
> 
