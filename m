Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8607DD4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376353AbjJaRqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376356AbjJaRqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A890CA6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698774332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nsqX9xIozpxrFjn9bgXzPuhVrC9mJojAb6DKsmTZrEA=;
        b=P4v38jEg2K4qRW1QXk0xdEyOrM2U0Ls2uNtT9tq4K3GXb7ZDxgpksPfVmb/HHyCzclMUK3
        729bj7XS2sjr/J/IsiEXvwZWCuJjXYWoz3AqtLovRrDGg0XO92GlqDH3ftS4Kz+zM6A6IS
        Wnfz2+tSFXJMysGXqMF/rcz81BxMbGc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-0y42xYW_M1Wpc1MAtg3ElA-1; Tue, 31 Oct 2023 13:45:31 -0400
X-MC-Unique: 0y42xYW_M1Wpc1MAtg3ElA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32ddd6f359eso3026896f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774330; x=1699379130;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nsqX9xIozpxrFjn9bgXzPuhVrC9mJojAb6DKsmTZrEA=;
        b=TyJYn+w5F4dhTEM7tyzHAF6frlBJx8K07Et6j2dwOKGZp1Xh305cB+o/mTjz77rOht
         ase5Mlgoszu+jRR2g0J4745FIk3kBl0RUd8KN4vcUwdEHYocj90Mydpsg/D8oQqZvsjI
         CmWueQ6mal0jhh9WjIdnkvEI4Pa6soEtPfRRAiC57HGma9oOBz4w0VPhB5MueEDJXs4E
         GAj5HVGl2rugpYHnO1tN2c8M9LTeSJWBZI+4OQHX6IzKeOurlHr9DTYu75IbvPzNGSjb
         nEPb1VAu+N35nT9+OIU3rixbqgHRdzgp3GfYftbJHYkO3KPm0KzGpyMIa1RQM/q3jauJ
         AcEQ==
X-Gm-Message-State: AOJu0YwuED+RTOlCJgD5GnDNzAtQ1RgUQ8QNovCC3jfkCRmnKvr6l6Sh
        AHMSKBii68QccYpkKSnJ+xseLKp2gxJjqGWiy0OFkmNiOMtCLY6V0YTkWlBYxMPL2NjVqJU6X45
        7AHDLkkTH2wShIrDcmBp4IuV0
X-Received: by 2002:a5d:5381:0:b0:32d:b081:ff4b with SMTP id d1-20020a5d5381000000b0032db081ff4bmr9542195wrv.61.1698774329989;
        Tue, 31 Oct 2023 10:45:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7rX0YtPzATdhrp7cLf4HEFOTy+fm1uvqM4FXDeww5r48+eGRQttcNcK7HibYzay6OT4srbQ==
X-Received: by 2002:a5d:5381:0:b0:32d:b081:ff4b with SMTP id d1-20020a5d5381000000b0032db081ff4bmr9542176wrv.61.1698774329627;
        Tue, 31 Oct 2023 10:45:29 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id i18-20020adff312000000b0032d893d8dc8sm1995420wro.2.2023.10.31.10.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:45:29 -0700 (PDT)
Message-ID: <d756d60b8a31dc25c63f5e2806608ea9fbc90d37.camel@redhat.com>
Subject: Re: [PATCH v6 07/25] x86/fpu/xstate: Tweak guest fpstate to support
 kernel dynamic xfeatures
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Tue, 31 Oct 2023 19:45:26 +0200
In-Reply-To: <20230914063325.85503-8-weijiang.yang@intel.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-8-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> The guest fpstate is sized with fpu_kernel_cfg.default_size (by preceding
> fix) and the kernel dynamic xfeatures are not taken into account, so add
> the support and tweak fpstate xfeatures and size accordingly.
> 
> Below configuration steps are currently enforced to get guest fpstate:
> 1) User space sets thread group xstate permits via arch_prctl().
> 2) User space creates vcpu thread.
> 3) User space enables guest dynamic xfeatures.
> 
> In #1, guest fpstate size (i.e., __state_size [1]) is induced from
> (fpu_kernel_cfg.default_features | user dynamic xfeatures) [2].
> In #2, guest fpstate size is calculated with fpu_kernel_cfg.default_size
> and fpstate->size is set to the same. fpstate->xfeatures is set to
> fpu_kernel_cfg.default_features.
> In #3, guest fpstate is re-allocated as [1] and fpstate->xfeatures is
> set to [2].
> 
> By adding kernel dynamic xfeatures in above #1 and #2, guest xstate area
> size is expanded to hold (fpu_kernel_cfg.default_features | kernel dynamic
> _xfeatures | user dynamic xfeatures)[3], and guest fpstate->xfeatures is
> set to [3]. Then host xsaves/xrstors can act on all guest xfeatures.
> 
> The user_* fields remain unchanged for compatibility of non-compacted KVM
> uAPIs.
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kernel/fpu/core.c   | 56 +++++++++++++++++++++++++++++-------
>  arch/x86/kernel/fpu/xstate.c |  2 +-
>  arch/x86/kernel/fpu/xstate.h |  2 ++
>  3 files changed, 49 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index a42d8ad26ce6..e5819b38545a 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -33,6 +33,8 @@ DEFINE_STATIC_KEY_FALSE(__fpu_state_size_dynamic);
>  DEFINE_PER_CPU(u64, xfd_state);
>  #endif
>  
> +extern unsigned int xstate_calculate_size(u64 xfeatures, bool compacted);
> +
>  /* The FPU state configuration data for kernel and user space */
>  struct fpu_state_config	fpu_kernel_cfg __ro_after_init;
>  struct fpu_state_config fpu_user_cfg __ro_after_init;
> @@ -193,8 +195,6 @@ void fpu_reset_from_exception_fixup(void)
>  }
>  
>  #if IS_ENABLED(CONFIG_KVM)
> -static void __fpstate_reset(struct fpstate *fpstate, u64 xfd);
> -
>  static void fpu_init_guest_permissions(struct fpu_guest *gfpu)
>  {
>  	struct fpu_state_perm *fpuperm;
> @@ -215,28 +215,64 @@ static void fpu_init_guest_permissions(struct fpu_guest *gfpu)
>  	gfpu->perm = perm & ~FPU_GUEST_PERM_LOCKED;
>  }
>  
> -bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
> +static struct fpstate *__fpu_alloc_init_guest_fpstate(struct fpu_guest *gfpu)
>  {
> +	bool compacted = cpu_feature_enabled(X86_FEATURE_XCOMPACTED);
> +	unsigned int gfpstate_size, size;
>  	struct fpstate *fpstate;
> -	unsigned int size;
> +	u64 xfeatures;
> +
> +	/*
> +	 * fpu_kernel_cfg.default_features includes all enabled xfeatures
> +	 * except those dynamic xfeatures. Compared with user dynamic
> +	 * xfeatures, the kernel dynamic ones are enabled for guest by
> +	 * default, so add the kernel dynamic xfeatures back when calculate
> +	 * guest fpstate size.
> +	 *
> +	 * If the user dynamic xfeatures are enabled, the guest fpstate will
> +	 * be re-allocated to hold all guest enabled xfeatures, so omit user
> +	 * dynamic xfeatures here.
> +	 */
> +	xfeatures = fpu_kernel_cfg.default_features |
> +		    fpu_kernel_dynamic_xfeatures;


This is roughly what I had in mind when I was reviewing the previous patch,
however for the sake of not hard-coding even more of the KVM policy here,
I would let the KVM tell which dynamic kernel features it wants to enable
as a parameter of this function, or even better *which* features it wants
to enable.


> +
> +	gfpstate_size = xstate_calculate_size(xfeatures, compacted);
>  
> -	size = fpu_kernel_cfg.default_size +
> -	       ALIGN(offsetof(struct fpstate, regs), 64);
> +	size = gfpstate_size + ALIGN(offsetof(struct fpstate, regs), 64);
>  
>  	fpstate = vzalloc(size);
>  	if (!fpstate)
> -		return false;
> +		return NULL;
> +	/*
> +	 * Initialize sizes and feature masks, use fpu_user_cfg.*
> +	 * for user_* settings for compatibility of exiting uAPIs.
> +	 */
> +	fpstate->size		= gfpstate_size;
> +	fpstate->xfeatures	= xfeatures;
> +	fpstate->user_size	= fpu_user_cfg.default_size;
> +	fpstate->user_xfeatures	= fpu_user_cfg.default_features;
> +	fpstate->xfd		= 0;
>  
> -	/* Leave xfd to 0 (the reset value defined by spec) */
> -	__fpstate_reset(fpstate, 0);
>  	fpstate_init_user(fpstate);
>  	fpstate->is_valloc	= true;
>  	fpstate->is_guest	= true;
>  
>  	gfpu->fpstate		= fpstate;
> -	gfpu->xfeatures		= fpu_user_cfg.default_features;
> +	gfpu->xfeatures		= xfeatures;
>  	gfpu->perm		= fpu_user_cfg.default_features;
>  
> +	return fpstate;
> +}


I think that this code will break, later when permission api is called by the KVM,
because it will overwrite the fpstate->user_size and with fpstate->size
assuming that all kernel dynamic features are enabled/disabled (depending
on Sean's patch).


> +
> +bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
> +{
> +	struct fpstate *fpstate;
> +
> +	fpstate = __fpu_alloc_init_guest_fpstate(gfpu);
> +
> +	if (!fpstate)
> +		return false;
> +

What is the point of the __fpu_alloc_init_guest_fpstate / fpu_alloc_guest_fpstate split,
since there is only one caller?


Best regards,
	Maxim Levitsky

>  	/*
>  	 * KVM sets the FP+SSE bits in the XSAVE header when copying FPU state
>  	 * to userspace, even when XSAVE is unsupported, so that restoring FPU
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index c5d903b4df4d..87149aba6f11 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -561,7 +561,7 @@ static bool __init check_xstate_against_struct(int nr)
>  	return true;
>  }
>  
> -static unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
> +unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
>  {
>  	unsigned int topmost = fls64(xfeatures) -  1;
>  	unsigned int offset = xstate_offsets[topmost];
> diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
> index a4ecb04d8d64..9c6e3ca05c5c 100644
> --- a/arch/x86/kernel/fpu/xstate.h
> +++ b/arch/x86/kernel/fpu/xstate.h
> @@ -10,6 +10,8 @@
>  DECLARE_PER_CPU(u64, xfd_state);
>  #endif
>  
> +extern u64 fpu_kernel_dynamic_xfeatures;
> +
>  static inline void xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
>  {
>  	/*







