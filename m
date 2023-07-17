Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4882A756E82
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjGQUqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQUp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:45:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC19F10C7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:45:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71CF961254
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1D1C433C8;
        Mon, 17 Jul 2023 20:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689626756;
        bh=UsXsfjVL9REDWcNWMHiUI6cTNSdXjR9CSQ/6ZyhFjy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=il+XQKSjT3nn4U1R4HkC5syT0/BiDp0SRWQ8Vg1tWBr2j9+/O7ByTu5Fa3FkVrJxe
         vHfFFIPcpDVFs8K7DwSnWsJ2kYat2EvVhL7Hiv64bBEqW0bt7jHnYEB5wmIw+Ss0VO
         OeSrRmS3DcneJnpUQ5uksTdCiAmOtFTj//8yRCBwSlpj4yDwbKcZLmrKJ407P1DHYj
         QpI/31QeBYsaLe2MXCynGBQK8hTI1L6IRMnBKqYuV3Xn42aojQlZYnCkTjiz375ZRc
         ByfsEeW9YEIgwOTubLu5amXdeOmHpTROJeiRlsbtpLgTLdUEyeo+bLBN2az0aLAOnZ
         1KVGNZrL6BbGw==
Date:   Mon, 17 Jul 2023 13:45:54 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jakob Koschel <jkl820.git@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] arch: enable HAS_LTO_CLANG with KASAN and KCOV
Message-ID: <20230717204554.GB2212488@dev-arch.thelio-3990X>
References: <20230717-enable-kasan-lto1-v1-1-471e706a5c4e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717-enable-kasan-lto1-v1-1-471e706a5c4e@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakob,

On Mon, Jul 17, 2023 at 10:09:27PM +0200, Jakob Koschel wrote:
> Both KASAN and KCOV had issues with LTO_CLANG if DEBUG_INFO is enabled.
> With LTO inlinable function calls are required to have debug info if
> they are inlined into a function that has debug info.
> 
> Starting with LLVM 17 this will be fixed ([1],[2]) and enabling LTO with
> KASAN/KCOV and DEBUG_INFO doesn't cause linker errors anymore.
> 
> Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
> Link: https://github.com/llvm/llvm-project/commit/913f7e93dac67ecff47bade862ba42f27cb68ca9
> Link: https://github.com/llvm/llvm-project/commit/4a8b1249306ff11f229320abdeadf0c215a00400

Thanks for seeing this to completion, especially with the LLVM fixes in
tow! One small nit below, other than that:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Normally, I would not say that comment alone is worth a v2 but I think
in this case, I will say it is because neither Nick nor I pick up
patches directly, so this will need to be picked up by either Kees Cook
(who has generally handled clang LTO patches because he ferried in the
initial LTO series to mainline) or Andrew Morton.

Would you mind addressing my comment and sending a v2 to them directly
(they can figure out who will take it) with us on CC in case we need to
poke them? Their addresses should be in MAINTAINERS.

Cheers,
Nathan

> ---
>  arch/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index aff2746c8af2..61263ff92271 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -745,7 +745,8 @@ config HAS_LTO_CLANG
>  	depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
>  	depends on ARCH_SUPPORTS_LTO_CLANG
>  	depends on !FTRACE_MCOUNT_USE_RECORDMCOUNT
> -	depends on !KASAN || KASAN_HW_TAGS

Consider linking back to either your fixes in LLVM or
https://github.com/ClangBuiltLinux/linux/issues/1721 so that we have a
paper trail of why these version checks are here :)

> +	depends on (!KASAN || KASAN_HW_TAGS || CLANG_VERSION >= 170000) || !DEBUG_INFO
> +	depends on (!KCOV || CLANG_VERSION >= 170000) || !DEBUG_INFO
>  	depends on !GCOV_KERNEL
>  	help
>  	  The compiler and Kconfig options support building with Clang's
> 
> ---
> base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
> change-id: 20230717-enable-kasan-lto1-656754c76241
> 
> Best regards,
> -- 
> Jakob Koschel <jkl820.git@gmail.com>
> 
