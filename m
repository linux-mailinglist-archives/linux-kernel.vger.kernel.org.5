Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B56E776414
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjHIPjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbjHIPit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:38:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F9E3C3A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:37:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64B5A63EB9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A0EC433C7;
        Wed,  9 Aug 2023 15:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691595477;
        bh=WtwZJ1Fe2B9YZNQyWrRTevJYcAwGYbXVhx6d93V0dH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jeKVVoRe03yN2mg6Ns582tsXkMjzwQfmj2HWfEgnb25JctXW++eASY8RCpKpe9mfJ
         3pRGggNgMBLK+XBci8sj8av1+4dH6gSMFkEaYy4lEbkX2wgwDpWju3VEaNtkLWD1if
         YESyDKppTByV7p22M+/u7dYKLVOCwBNOUg6ST2CM+0uXmFK7ustv49LN8yLNfDP/t4
         v1lkyz9NfWjDNkoiVysBFIkj+TNZkhyfkXnAbrImnKuBaXn0KY8vyZ69/f5bIpZg1B
         HZuffKh+ViTC4vccvGQkjCi5XsI6me2P11urUN91wKTEUuZ/UyAaR1F/HWOEWrVocs
         HYD7fzr+oBnmw==
Date:   Wed, 9 Aug 2023 08:37:55 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     boris.brezillon@collabora.com, ndesaulniers@google.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        trix@redhat.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        naresh.kamboju@linaro.org, dakr@redhat.com
Subject: Re: [PATCH 1/2] drm/exec: use unique instead of local label
Message-ID: <20230809153755.GA832145@dev-arch.thelio-3990X>
References: <20230731123625.3766-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230731123625.3766-1-christian.koenig@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Can this be applied to drm-misc? Other drivers are starting to make use
of this API and our builds with clang-17 and clang-18 have been broken
for some time due to this.

Cheers,
Nathan

On Mon, Jul 31, 2023 at 02:36:24PM +0200, Christian König wrote:
> GCC forbids to jump to labels in loop conditions and a new clang
> check stumbled over this.
> 
> So instead using a local label inside the loop condition use an
> unique label outside of it.
> 
> Fixes: commit 09593216bff1 ("drm: execution context for GEM buffers v7")
> Link: https://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html
> Link: https://github.com/ClangBuiltLinux/linux/issues/1890
> Link: https://github.com/llvm/llvm-project/commit/20219106060208f0c2f5d096eb3aed7b712f5067
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> CC: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  include/drm/drm_exec.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
> index 73205afec162..e0462361adf9 100644
> --- a/include/drm/drm_exec.h
> +++ b/include/drm/drm_exec.h
> @@ -3,6 +3,7 @@
>  #ifndef __DRM_EXEC_H__
>  #define __DRM_EXEC_H__
>  
> +#include <linux/compiler.h>
>  #include <linux/ww_mutex.h>
>  
>  #define DRM_EXEC_INTERRUPTIBLE_WAIT	BIT(0)
> @@ -74,13 +75,12 @@ struct drm_exec {
>   * Since labels can't be defined local to the loops body we use a jump pointer
>   * to make sure that the retry is only used from within the loops body.
>   */
> -#define drm_exec_until_all_locked(exec)				\
> -	for (void *__drm_exec_retry_ptr; ({			\
> -		__label__ __drm_exec_retry;			\
> -__drm_exec_retry:						\
> -		__drm_exec_retry_ptr = &&__drm_exec_retry;	\
> -		(void)__drm_exec_retry_ptr;			\
> -		drm_exec_cleanup(exec);				\
> +#define drm_exec_until_all_locked(exec)					\
> +__PASTE(__drm_exec_, __LINE__):						\
> +	for (void *__drm_exec_retry_ptr; ({				\
> +		__drm_exec_retry_ptr = &&__PASTE(__drm_exec_, __LINE__);\
> +		(void)__drm_exec_retry_ptr;				\
> +		drm_exec_cleanup(exec);					\
>  	});)
>  
>  /**
> -- 
> 2.34.1
> 
