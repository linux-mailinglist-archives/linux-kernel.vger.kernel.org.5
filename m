Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E36B767318
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjG1RSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbjG1RSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:18:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EB730D4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9C90621B2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF95BC433C8;
        Fri, 28 Jul 2023 17:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690564680;
        bh=cv/PDocAmxbGFwdA+baufqPji8T3ipwDf7Jyfbvf32c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rp68SqAMtcXPF33g9ZwvZAV27WFZERhO6B6y8qniOYuaCg78BnEezs/Fp3U/T3Rfd
         YXjXtdwMDdxkzdDV9gSqO/9S1Lj0YO4rcdeGNFts0ufq3VI3FWktGgEXT/d9InCSzI
         88U3X9u5x1BBrA0Bu2ofG03x8UVE12IAo6OOQ116oQUqnYexC+osAAknRUP2dHnYPg
         Y05se9EQDxWD2VPrf593NRT+NGlLOyUdFWia/gpVnphCe9bDoCuvLFZcGQjLh5SA65
         /8OLqYZtuA7YVSJwJY2BSPdSnTcZn55r3FTvFcHJUDRZNj/K7alTvd1mnzbiiDJtRJ
         LJYlUO+Ela+FA==
Date:   Fri, 28 Jul 2023 10:17:57 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     ndesaulniers@google.com
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Tom Rix <trix@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Naresh Kamboju <naresh.kamboju@linaro.org>,
        christian.koenig@amd.com, boris.brezillon@collabora.com,
        dakr@redhat.com, alexander.deucher@amd.com
Subject: Re: [PATCH v2] drm: fix indirect goto into statement expression UB
Message-ID: <20230728171757.GA433645@dev-arch.thelio-3990X>
References: <20230727-amdgpu-v2-1-7fc66bc52bf6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727-amdgpu-v2-1-7fc66bc52bf6@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ people from trailers of 09593216bff1

On Thu, Jul 27, 2023 at 03:50:58PM -0700, ndesaulniers@google.com wrote:
> A new diagnostic in clang-17 now produces the following build error:
> 
> drivers/gpu/drm/tests/drm_exec_test.c:41:3: error: cannot jump from this
> indirect goto statement to one of its possible targets
>    41 |                 drm_exec_retry_on_contention(&exec);
>       |                 ^
> include/drm/drm_exec.h:96:4: note: expanded from macro
> 'drm_exec_retry_on_contention'
>    96 |                         goto *__drm_exec_retry_ptr;
>       |                         ^
> drivers/gpu/drm/tests/drm_exec_test.c:39:2: note: possible target of
> indirect goto statement
>    39 |         drm_exec_until_all_locked(&exec) {
>       |         ^
> include/drm/drm_exec.h:79:33: note: expanded from macro
> 'drm_exec_until_all_locked'
>    79 |                 __label__ __drm_exec_retry;
> drivers/gpu/drm/tests/drm_exec_test.c:39:2: note: jump enters a
> statement expression
> 
> The GCC manually currently states that:

          ^ manual

> >> Jumping into a statement expression with a computed goto (see Labels
> >> as Values) has undefined behavior.
> 
> So the diagnostic appears correct, even if codegen happened to produce
> working code.
> 
> Looking closer at this code, while the original combination of statement
> expression, local label, and computed/indirect goto GNU C expressions
> were clever, a simple while loop and continue block might have sufficed.
> 
> This approach might not work as expected if drm_exec_until_all_locked
> "loops" can be nested, but that doesn't appear to be an existing use
> case in the codebase.
> 
> Fixes: commit 09593216bff1 ("drm: execution context for GEM buffers v7")
> Link: https://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html
> Link: https://github.com/ClangBuiltLinux/linux/issues/1890
> Link: https://github.com/llvm/llvm-project/commit/20219106060208f0c2f5d096eb3aed7b712f5067
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the patch!

Tested-by: Nathan Chancellor <nathan@kernel.org> # build

> ---
> Changes in v2:
> Fix the continue to be outside of the do while
> - Link to v1: https://lore.kernel.org/r/20230727-amdgpu-v1-1-a95690e75388@google.com
> ---
>  include/drm/drm_exec.h | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
> index 73205afec162..fa1cc5c3d021 100644
> --- a/include/drm/drm_exec.h
> +++ b/include/drm/drm_exec.h
> @@ -70,18 +70,8 @@ struct drm_exec {
>   * Core functionality of the drm_exec object. Loops until all GEM objects are
>   * locked and no more contention exists. At the beginning of the loop it is
>   * guaranteed that no GEM object is locked.
> - *
> - * Since labels can't be defined local to the loops body we use a jump pointer
> - * to make sure that the retry is only used from within the loops body.
>   */
> -#define drm_exec_until_all_locked(exec)				\
> -	for (void *__drm_exec_retry_ptr; ({			\
> -		__label__ __drm_exec_retry;			\
> -__drm_exec_retry:						\
> -		__drm_exec_retry_ptr = &&__drm_exec_retry;	\
> -		(void)__drm_exec_retry_ptr;			\
> -		drm_exec_cleanup(exec);				\
> -	});)
> +#define drm_exec_until_all_locked(exec)	while(drm_exec_cleanup(exec))
>  
>  /**
>   * drm_exec_retry_on_contention - restart the loop to grap all locks
> @@ -90,11 +80,10 @@ __drm_exec_retry:						\
>   * Control flow helper to continue when a contention was detected and we need to
>   * clean up and re-start the loop to prepare all GEM objects.
>   */
> -#define drm_exec_retry_on_contention(exec)			\
> -	do {							\
> -		if (unlikely(drm_exec_is_contended(exec)))	\
> -			goto *__drm_exec_retry_ptr;		\
> -	} while (0)
> +#define drm_exec_retry_on_contention(exec)		\
> +	if (unlikely(drm_exec_is_contended(exec)))	\
> +		continue;				\
> +	do {} while (0)
>  
>  /**
>   * drm_exec_is_contended - check for contention
> 
> ---
> base-commit: 451cc82bd11eb6a374f4dbcfc1cf007eafea91ab
> change-id: 20230727-amdgpu-93c0e5302951
> 
> Best regards,
> -- 
> Nick Desaulniers <ndesaulniers@google.com>
> 
