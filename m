Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBA77FF8AF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346634AbjK3RqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjK3RqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:46:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A57197
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701366376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vg7FQUhH1bp/4aBDJKaF0HS+7XR0RmUcrDXUDZg2Qqw=;
        b=TwHpQCHfigVsEpZBu7ktwJwvZ/PxC/onCpNkMoy8h/PzTzLNx5ZknT6EYmtzWDaWHP9FQL
        liqaMux2L6ee6hUl9wmSWDktuD69feRUjh46gqpowtLVG5q+HKVNMZJ/f5YjRbz2PgUcNy
        qJ1WelGyvnDophtpHlXnloKk6sgdLRk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-krVGNWgZO3Wa5q_ZShgR_g-1; Thu, 30 Nov 2023 12:46:14 -0500
X-MC-Unique: krVGNWgZO3Wa5q_ZShgR_g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b546fd830so9738735e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:46:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701366373; x=1701971173;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vg7FQUhH1bp/4aBDJKaF0HS+7XR0RmUcrDXUDZg2Qqw=;
        b=dyGnUWTWRDSupkOcKpzyzRtvZPDD9jZRyt5pLZq06xRmneQJPWQ2bB7q6+ikE8+Kq+
         ZprQkA8iSL6nTEkt3xQSzeDBq30ZoE4JrMungSg18TfhIEvS8jBuKlw0L0GeSId1kO8m
         uz8mDwt/LP+LZSutUiC53UwuUcqWaXA9vZDOJSKYRHjJnd2iINgl/Plp9Iuu/tOcg+6X
         S5bw9RUGM3avFHvhaFkfBOTIq3DDQ0dIpq9d+PGhqM19GV9jc7uo7ybN73cjK6qXqLPp
         jzhRvZ0U7UFxH9282rylxgejw2rwobKSrYvXs/SSvYant9k3aHluSoMXMOc4P52jNqoM
         CoKw==
X-Gm-Message-State: AOJu0Yy98g/j1W5BCkBYIqtHojT5m1TwfiB0XOrv7oKdef4QgHiJKlr9
        DZ17rdi1TYBtf+HT9gFo3txgrO1sSdYM93os38+vG6CHtSiLk4JECnhu9SklexoUDP1KVJFE6bS
        A5xd2/tyrlGvHw9lPKtGaNENeSsMcRyMk
X-Received: by 2002:a50:f60f:0:b0:54b:fea4:c57f with SMTP id c15-20020a50f60f000000b0054bfea4c57fmr5344edn.25.1701365906752;
        Thu, 30 Nov 2023 09:38:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpDjeF/sufV646oy68VsCAXZtRSgpL2qetDDSjPs2/Nq5Eagnb89phtm84qwH2mKTnZJMOUQ==
X-Received: by 2002:a19:f805:0:b0:50b:c6c7:a777 with SMTP id a5-20020a19f805000000b0050bc6c7a777mr21212lff.41.1701365586343;
        Thu, 30 Nov 2023 09:33:06 -0800 (PST)
Received: from starship ([5.28.147.32])
        by smtp.gmail.com with ESMTPSA id cf31-20020a056512281f00b0050bc6bd5231sm212171lfb.253.2023.11.30.09.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:33:05 -0800 (PST)
Message-ID: <3c16bb90532fbd2ec95b5a3d42a93bbbf77c4d37.camel@redhat.com>
Subject: Re: [PATCH v7 04/26] x86/fpu/xstate: Introduce
 XFEATURE_MASK_KERNEL_DYNAMIC xfeature set
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Thu, 30 Nov 2023 19:33:03 +0200
In-Reply-To: <20231124055330.138870-5-weijiang.yang@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-5-weijiang.yang@intel.com>
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

On Fri, 2023-11-24 at 00:53 -0500, Yang Weijiang wrote:
> Define new XFEATURE_MASK_KERNEL_DYNAMIC set including the features can be

I am not sure though that this name is correct, but I don't know if I can
suggest a better name.

> optionally enabled by kernel components, i.e., the features are required by
> specific kernel components. Currently it's used by KVM to configure guest
> dedicated fpstate for calculating the xfeature and fpstate storage size etc.
> 
> The kernel dynamic xfeatures now only contain XFEATURE_CET_KERNEL, which is
> supported by host as they're enabled in xsaves/xrstors operating xfeature set
> (XCR0 | XSS), but the relevant CPU feature, i.e., supervisor shadow stack, is
> not enabled in host kernel so it can be omitted for normal fpstate by default.
> 
> Remove the kernel dynamic feature from fpu_kernel_cfg.default_features so that
> the bits in xstate_bv and xcomp_bv are cleared and xsaves/xrstors can be
> optimized by HW for normal fpstate.
> 
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/include/asm/fpu/xstate.h | 5 ++++-
>  arch/x86/kernel/fpu/xstate.c      | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
> index 3b4a038d3c57..a212d3851429 100644
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -46,9 +46,12 @@
>  #define XFEATURE_MASK_USER_RESTORE	\
>  	(XFEATURE_MASK_USER_SUPPORTED & ~XFEATURE_MASK_PKRU)
>  
> -/* Features which are dynamically enabled for a process on request */
> +/* Features which are dynamically enabled per userspace request */
>  #define XFEATURE_MASK_USER_DYNAMIC	XFEATURE_MASK_XTILE_DATA
>  
> +/* Features which are dynamically enabled per kernel side request */

I suggest to explain this a bit better. How about something like that:

"Kernel features that are not enabled by default for all processes, but can
be still used by some processes, for example to support guest virtualization"

But feel free to keep it as is or propose something else. IMHO this will
be confusing this way or another.


Another question: kernel already has a notion of 'independent features'
which are currently kernel features that are enabled in IA32_XSS but not present in 'fpu_kernel_cfg.max_features'

Currently only 'XFEATURE_LBR' is in this set. These features are saved/restored manually
from independent buffer (in case of LBRs, perf code cares for this).

Does it make sense to add CET_S to there as well instead of having XFEATURE_MASK_KERNEL_DYNAMIC, and maybe rename the
'XFEATURE_MASK_INDEPENDENT' to something like 'XFEATURES_THE_KERNEL_DOESNT_CARE_ABOUT'
(terrible name, but you might think of a better name)


> +#define XFEATURE_MASK_KERNEL_DYNAMIC	XFEATURE_MASK_CET_KERNEL
> +
>  /* All currently supported supervisor features */
>  #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID | \
>  					    XFEATURE_MASK_CET_USER | \
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index b57d909facca..ba4172172afd 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -824,6 +824,7 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
>  	/* Clean out dynamic features from default */
>  	fpu_kernel_cfg.default_features = fpu_kernel_cfg.max_features;
>  	fpu_kernel_cfg.default_features &= ~XFEATURE_MASK_USER_DYNAMIC;
> +	fpu_kernel_cfg.default_features &= ~XFEATURE_MASK_KERNEL_DYNAMIC;
>  
>  	fpu_user_cfg.default_features = fpu_user_cfg.max_features;
>  	fpu_user_cfg.default_features &= ~XFEATURE_MASK_USER_DYNAMIC;



Best regards,
	Maxim Levitsky



