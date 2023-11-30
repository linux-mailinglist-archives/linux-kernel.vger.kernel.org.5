Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BE77FF865
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346414AbjK3Rg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjK3Rg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:36:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D545A10D1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701365793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uf3Ss8OAEWvNG8bOfwQMtLxEfVJoUheXU7f8sA0Je4M=;
        b=AAHaLoHVQLkGnY4g30trGyP6aqqBw5XBZMpWgPOjxQFWJUaEuW+HNagtA3+3Si4OMdjWhm
        37Sq36GFgFpLBdTP2Jh0hLqktJ/gOP5MB1TWCDwVeCHjuD4IfOz/eHx1uex7mcja4fxRHG
        3aZc3z1r2ulLwTJV84G/YCmJke8/7Fs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-xBy_ctIzOnekhqJvk60qSg-1; Thu, 30 Nov 2023 12:36:31 -0500
X-MC-Unique: xBy_ctIzOnekhqJvk60qSg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c9d707de25so654651fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701365790; x=1701970590;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uf3Ss8OAEWvNG8bOfwQMtLxEfVJoUheXU7f8sA0Je4M=;
        b=F3KwZME7cGopQgLNZQLeHBGUsE1ypZ3qAq7poZTuzWhO/mAAeUixVhpnnM4f2sED7T
         Mynza8xTlivApdxndBBn/T7dqrDIVYzFoL2VF4+r+7Ialjuj8P0BKHUAEMnrRHLGcaie
         KsS2ZdJE9zi8pD3MyavdaSrxvpwWNNjcVdJI5Hlf+1TS8ySkBgMm1401QEIcLVWTjmK5
         aRuSSmzj85jT87OEsn/g+UkZiuURtLsbhxny3myAjXpLJbGcOckBqU/XNGw0Bj/lajiF
         sdkwUelKLiB2dlAhBSIAXzau/ydTybxgi9blKOgKHusKRuZy/I/lEiPzAc7wOdtcptsQ
         zOag==
X-Gm-Message-State: AOJu0YwNLfq1DcCsVcHBovVZomC6QiEIP/5ySMcw4w8BC27zbMLRovFo
        8nCqKoPwCHK5MeB3iWcCdm0KDPW8Gf4yeWWy+6LiDBBiAyO6O5wBM+E6RdMylfIO0vjVIsBar29
        JlTiQS67pmCgIFA0IO7YO68JWnW1yuF2L
X-Received: by 2002:a2e:9083:0:b0:2b9:412a:111d with SMTP id l3-20020a2e9083000000b002b9412a111dmr6556ljg.42.1701365789706;
        Thu, 30 Nov 2023 09:36:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExhvZ3xoy34KD/kfCKvq7DxJbGWwzQscJxZr25xdZlOmm9bJQSkcAj8siZ+c1DsISgYLI8iA==
X-Received: by 2002:a2e:9083:0:b0:2b9:412a:111d with SMTP id l3-20020a2e9083000000b002b9412a111dmr6402ljg.42.1701365787477;
        Thu, 30 Nov 2023 09:36:27 -0800 (PST)
Received: from starship ([5.28.147.32])
        by smtp.gmail.com with ESMTPSA id h6-20020a2ea486000000b002c505a6a398sm199616lji.89.2023.11.30.09.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:36:27 -0800 (PST)
Message-ID: <e1469c732e179dfd7870d0f4ba69f791af0b5d57.camel@redhat.com>
Subject: Re: [PATCH v7 06/26] x86/fpu/xstate: Create guest fpstate with
 guest specific config
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Thu, 30 Nov 2023 19:36:24 +0200
In-Reply-To: <20231124055330.138870-7-weijiang.yang@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-7-weijiang.yang@intel.com>
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
> Use fpu_guest_cfg to calculate guest fpstate settings, open code for
> __fpstate_reset() to avoid using kernel FPU config.
> 
> Below configuration steps are currently enforced to get guest fpstate:
> 1) Kernel sets up guest FPU settings in fpu__init_system_xstate().
> 2) User space sets vCPU thread group xstate permits via arch_prctl().
> 3) User space creates guest fpstate via __fpu_alloc_init_guest_fpstate()
>    for vcpu thread.
> 4) User space enables guest dynamic xfeatures and re-allocate guest
>    fpstate.
> 
> By adding kernel dynamic xfeatures in above #1 and #2, guest xstate area
> size is expanded to hold (fpu_kernel_cfg.default_features | kernel dynamic
> xfeatures | user dynamic xfeatures), then host xsaves/xrstors can operate
> for all guest xfeatures.
> 
> The user_* fields remain unchanged for compatibility with KVM uAPIs.
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kernel/fpu/core.c   | 48 ++++++++++++++++++++++++++++--------
>  arch/x86/kernel/fpu/xstate.c |  2 +-
>  arch/x86/kernel/fpu/xstate.h |  1 +
>  3 files changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 516af626bf6a..985eaf8b55e0 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -194,8 +194,6 @@ void fpu_reset_from_exception_fixup(void)
>  }
>  
>  #if IS_ENABLED(CONFIG_KVM)
> -static void __fpstate_reset(struct fpstate *fpstate, u64 xfd);
> -
>  static void fpu_init_guest_permissions(struct fpu_guest *gfpu)
>  {
>  	struct fpu_state_perm *fpuperm;
> @@ -216,25 +214,55 @@ static void fpu_init_guest_permissions(struct fpu_guest *gfpu)
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
>  
> -	size = fpu_user_cfg.default_size + ALIGN(offsetof(struct fpstate, regs), 64);
> +	/*
> +	 * fpu_guest_cfg.default_features includes all enabled xfeatures
> +	 * except the user dynamic xfeatures. If the user dynamic xfeatures
> +	 * are enabled, the guest fpstate will be re-allocated to hold all
> +	 * guest enabled xfeatures, so omit user dynamic xfeatures here.
> +	 */

This is a very good comment to have, although I don't think there is any way
to ensure that the whole thing is not utterly confusing.....


> +	gfpstate_size = xstate_calculate_size(fpu_guest_cfg.default_features,
> +					      compacted);
> +
> +	size = gfpstate_size + ALIGN(offsetof(struct fpstate, regs), 64);
> +
>  	fpstate = vzalloc(size);
>  	if (!fpstate)
> -		return false;
> +		return NULL;
> +	/*
> +	 * Initialize sizes and feature masks, use fpu_user_cfg.*
> +	 * for user_* settings for compatibility of exiting uAPIs.
> +	 */
> +	fpstate->size		= gfpstate_size;
> +	fpstate->xfeatures	= fpu_guest_cfg.default_features;

> +	fpstate->user_size	= fpu_user_cfg.default_size;
> +	fpstate->user_xfeatures	= fpu_user_cfg.default_features;

The whole thing makes my head spin like the good old CD/DVD writers used to ....

So just to summarize this is what we have:


KERNEL FPU CONFIG

/* 
   all known and CPU supported user and supervisor features except 
   - "dynamic" kernel features" (CET_S)
   - "independent" kernel features (XFEATURE_LBR)
*/
fpu_kernel_cfg.max_features;

/* 
   all known and CPU supported user and supervisor features except 
    - "dynamic" kernel features" (CET_S)
    - "independent" kernel features (arch LBRs)
    - "dynamic" userspace features (AMX state)
*/
fpu_kernel_cfg.default_features;


// size of compacted buffer with 'fpu_kernel_cfg.max_features'
fpu_kernel_cfg.max_size;


// size of compacted buffer with 'fpu_kernel_cfg.default_features'
fpu_kernel_cfg.default_size;


USER FPU CONFIG

/*
   all known and CPU supported user features
*/
fpu_user_cfg.max_features;

/*
   all known and CPU supported user features except
   - "dynamic" userspace features (AMX state)
*/
fpu_user_cfg.default_features;

// size of non compacted buffer with 'fpu_user_cfg.max_features'
fpu_user_cfg.max_size;

// size of non compacted buffer with 'fpu_user_cfg.default_features'
fpu_user_cfg.default_size;


GUEST FPU CONFIG
/* 
   all known and CPU supported user and supervisor features except 
   - "independent" kernel features (XFEATURE_LBR)
*/
fpu_guest_cfg.max_features;

/* 
   all known and CPU supported user and supervisor features except 
    - "independent" kernel features (arch LBRs)
    - "dynamic" userspace features (AMX state)
*/
fpu_guest_cfg.default_features;

// size of compacted buffer with 'fpu_guest_cfg.max_features'
fpu_guest_cfg.max_size;

// size of compacted buffer with 'fpu_guest_cfg.default_features'
fpu_guest_cfg.default_size;



---


So in essence, guest FPU config is guest kernel fpu config and that is why 
'fpu_user_cfg.default_size' had to be used above.

How about that we have fpu_guest_kernel_config and fpu_guest_user_config instead
to make the whole horrible thing maybe even more complicated but at least a bit more orthogonal? 

Best regards,
	Maxim Levitsky





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
> -	gfpu->perm		= fpu_user_cfg.default_features;
> +	gfpu->xfeatures		= fpu_guest_cfg.default_features;
> +	gfpu->perm		= fpu_guest_cfg.default_features;
> +
> +	return fpstate;
> +}
> +
> +bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
> +{
> +	struct fpstate *fpstate;
> +
> +	fpstate = __fpu_alloc_init_guest_fpstate(gfpu);
> +
> +	if (!fpstate)
> +		return false;
>  
>  	/*
>  	 * KVM sets the FP+SSE bits in the XSAVE header when copying FPU state
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index aa8f8595cd41..253944cb2298 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -559,7 +559,7 @@ static bool __init check_xstate_against_struct(int nr)
>  	return true;
>  }
>  
> -static unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
> +unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
>  {
>  	unsigned int topmost = fls64(xfeatures) -  1;
>  	unsigned int offset = xstate_offsets[topmost];
> diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
> index 3518fb26d06b..c032acb56306 100644
> --- a/arch/x86/kernel/fpu/xstate.h
> +++ b/arch/x86/kernel/fpu/xstate.h
> @@ -55,6 +55,7 @@ extern void fpu__init_cpu_xstate(void);
>  extern void fpu__init_system_xstate(unsigned int legacy_size);
>  
>  extern void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
> +extern unsigned int xstate_calculate_size(u64 xfeatures, bool compacted);
>  
>  static inline u64 xfeatures_mask_supervisor(void)
>  {




