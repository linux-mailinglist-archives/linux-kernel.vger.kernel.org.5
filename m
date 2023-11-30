Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843DD7FFAB0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376282AbjK3TBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjK3TBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:01:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BE910E3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701370910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3AqnBDxV2gEvZjzBaw7nkpO0oqJkea/7sHU3mX1Py/Y=;
        b=dtGKLW2lyKd3ppglJVCn6Gox9JRBjaVB1iVxTFyq+IwomsQkx7FLzDfZfQVt8t+Xk0UWMF
        xecqU6EHo7177+PiDzWf9QcUfw91JrqnBMF8GMxGn8p0ZAt953rmZzgatKAnzbwES5ERf7
        Bdk6//ECx1ZIwWcY42Zec3ywTeCeJCI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-QCAMMt78Oo2CbGZl9IXZhw-1; Thu, 30 Nov 2023 14:01:43 -0500
X-MC-Unique: QCAMMt78Oo2CbGZl9IXZhw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5411d71889aso1024209a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:01:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701370902; x=1701975702;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3AqnBDxV2gEvZjzBaw7nkpO0oqJkea/7sHU3mX1Py/Y=;
        b=BclAojnV+gjibmk8RaFbAEBJhGUvVEwv9BtYBBurC52EuRTSc0azVpD0uxOW+zNhoK
         6zTzhdzxfgxn+N7lynV4jgm0bEJbwr20ymN2X/e+W5V3iz8bzBpJc984nITgRR7IWp7Z
         0lXZ9EXf84VlE+QAZTdn7FuNs87+UMHGQ39STitdK6Z6tklHJ/MSO1++iQiR+kfRYOf+
         epU+tTZH5653KGek14VYsJjH2LMtFMFCL1tR3Af381pCVzjoXB/UPn/hxbszuGY2s6vb
         bxKCSZKl/c7JBWKuuHxZ6WO86O1YAm/rNHza7In+YnkXV9f4Fk2LWLbi2EW7E6872bpA
         mpOA==
X-Gm-Message-State: AOJu0YwUrHhQaPN6FPXyKX4buieX2/Vir4EkG0zyd82smzZhhFjKjshP
        4jRBulfVXpz7t/5fr8tJyTSrF6Lu++Hl0PRBU5i0FGe1Bl1Q+TOhv6MJexhp77Oi8eeddDLbUGx
        bToN/lfhTe+6du8/IySgn0h1ERcFXkfta
X-Received: by 2002:a50:bb65:0:b0:53f:ef96:b2ee with SMTP id y92-20020a50bb65000000b0053fef96b2eemr3923ede.22.1701370901878;
        Thu, 30 Nov 2023 11:01:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7a9itJvIEBQTtAwvdJ4UOEQ6akN1jXEG3duLT0l8cpKuXcZyunVpYem1b18Tq7sXOcp/qtA==
X-Received: by 2002:a05:6512:3a91:b0:50b:c043:6285 with SMTP id q17-20020a0565123a9100b0050bc0436285mr19553lfu.49.1701365370778;
        Thu, 30 Nov 2023 09:29:30 -0800 (PST)
Received: from starship ([5.28.147.32])
        by smtp.gmail.com with ESMTPSA id r25-20020ac25f99000000b0050bc7a7a491sm209983lfe.191.2023.11.30.09.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:29:30 -0800 (PST)
Message-ID: <533fd2330aa6a854b61eea6828dbeff9f6e3ffb4.camel@redhat.com>
Subject: Re: [PATCH v7 05/26] x86/fpu/xstate: Introduce fpu_guest_cfg for
 guest FPU configuration
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Thu, 30 Nov 2023 19:29:28 +0200
In-Reply-To: <20231124055330.138870-6-weijiang.yang@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-6-weijiang.yang@intel.com>
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

On Fri, 2023-11-24 at 00:53 -0500, Yang Weijiang wrote:
> Define new fpu_guest_cfg to hold all guest FPU settings so that it can
> differ from generic kernel FPU settings, e.g., enabling CET supervisor
> xstate by default for guest fpstate while it's remained disabled in
> kernel FPU config.
> 
> The kernel dynamic xfeatures are specifically used by guest fpstate now,
> add the mask for guest fpstate so that guest_perm.__state_permit ==
> (fpu_kernel_cfg.default_xfeature | XFEATURE_MASK_KERNEL_DYNAMIC). And
> if guest fpstate is re-allocated to hold user dynamic xfeatures, the
> resulting permissions are consumed before calculate new guest fpstate.
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/include/asm/fpu/types.h |  2 +-
>  arch/x86/kernel/fpu/core.c       | 14 +++++++++++---
>  arch/x86/kernel/fpu/xstate.c     | 10 ++++++++++
>  3 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
> index c6fd13a17205..306825ad6bc0 100644
> --- a/arch/x86/include/asm/fpu/types.h
> +++ b/arch/x86/include/asm/fpu/types.h
> @@ -602,6 +602,6 @@ struct fpu_state_config {
>  };
>  
>  /* FPU state configuration information */
> -extern struct fpu_state_config fpu_kernel_cfg, fpu_user_cfg;
> +extern struct fpu_state_config fpu_kernel_cfg, fpu_user_cfg, fpu_guest_cfg;
>  
>  #endif /* _ASM_X86_FPU_H */
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index a21a4d0ecc34..516af626bf6a 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -33,9 +33,10 @@ DEFINE_STATIC_KEY_FALSE(__fpu_state_size_dynamic);
>  DEFINE_PER_CPU(u64, xfd_state);
>  #endif
>  
> -/* The FPU state configuration data for kernel and user space */
> +/* The FPU state configuration data for kernel, user space and guest. */
>  struct fpu_state_config	fpu_kernel_cfg __ro_after_init;
>  struct fpu_state_config fpu_user_cfg __ro_after_init;
> +struct fpu_state_config fpu_guest_cfg __ro_after_init;
>  
>  /*
>   * Represents the initial FPU state. It's mostly (but not completely) zeroes,
> @@ -536,8 +537,15 @@ void fpstate_reset(struct fpu *fpu)
>  	fpu->perm.__state_perm		= fpu_kernel_cfg.default_features;
>  	fpu->perm.__state_size		= fpu_kernel_cfg.default_size;
>  	fpu->perm.__user_state_size	= fpu_user_cfg.default_size;
> -	/* Same defaults for guests */
> -	fpu->guest_perm = fpu->perm;
> +
> +	/* Guest permission settings */
> +	fpu->guest_perm.__state_perm	= fpu_guest_cfg.default_features;
> +	fpu->guest_perm.__state_size	= fpu_guest_cfg.default_size;
> +	/*
> +	 * Set guest's __user_state_size to fpu_user_cfg.default_size so that
> +	 * existing uAPIs can still work.
> +	 */
> +	fpu->guest_perm.__user_state_size = fpu_user_cfg.default_size;
>  }
>  
>  static inline void fpu_inherit_perms(struct fpu *dst_fpu)
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index ba4172172afd..aa8f8595cd41 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -681,6 +681,7 @@ static int __init init_xstate_size(void)
>  {
>  	/* Recompute the context size for enabled features: */
>  	unsigned int user_size, kernel_size, kernel_default_size;
> +	unsigned int guest_default_size;
>  	bool compacted = cpu_feature_enabled(X86_FEATURE_XCOMPACTED);
>  
>  	/* Uncompacted user space size */
> @@ -702,13 +703,18 @@ static int __init init_xstate_size(void)
>  	kernel_default_size =
>  		xstate_calculate_size(fpu_kernel_cfg.default_features, compacted);
>  
> +	guest_default_size =
> +		xstate_calculate_size(fpu_guest_cfg.default_features, compacted);
> +
>  	if (!paranoid_xstate_size_valid(kernel_size))
>  		return -EINVAL;
>  
>  	fpu_kernel_cfg.max_size = kernel_size;
>  	fpu_user_cfg.max_size = user_size;
> +	fpu_guest_cfg.max_size = kernel_size;
>  
>  	fpu_kernel_cfg.default_size = kernel_default_size;
> +	fpu_guest_cfg.default_size = guest_default_size;
>  	fpu_user_cfg.default_size =
>  		xstate_calculate_size(fpu_user_cfg.default_features, false);
>  
> @@ -829,6 +835,10 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
>  	fpu_user_cfg.default_features = fpu_user_cfg.max_features;
>  	fpu_user_cfg.default_features &= ~XFEATURE_MASK_USER_DYNAMIC;
>  
> +	fpu_guest_cfg.max_features = fpu_kernel_cfg.max_features;
> +	fpu_guest_cfg.default_features = fpu_guest_cfg.max_features;
> +	fpu_guest_cfg.default_features &= ~XFEATURE_MASK_USER_DYNAMIC;
> +
>  	/* Store it for paranoia check at the end */
>  	xfeatures = fpu_kernel_cfg.max_features;
>  

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

