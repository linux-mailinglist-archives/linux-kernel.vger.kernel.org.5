Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA88C7FE4B0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343765AbjK3APW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 19:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjK3APU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:15:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947081A3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 16:15:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD04C433C8;
        Thu, 30 Nov 2023 00:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701303326;
        bh=ch03Q1LGdvw/5c+P9u9UGxtKgAgW7sEGwUb5IoivJ2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LaOgQGHYkG7GwGuNB/tgApTrq5b0Zwit7TrJGyioetvXKN/uUlcyEuC331mHgnEnz
         yUhAFGh1JPqoGUjxNIfV5DaeuabXoht1Bhg7CgUWRv0kuhzlGHYfHsqHCp4mEePjHd
         8HT0p5x8Ap0Nn4ALSdJ8u2rKNlUzJmLFSRZsM1HSLls97Z1IGR3X/33AWdTFcWjjUm
         5mS9hxT8UfIe0M/+rjq7+mUM0jbZPluVzdVNyYvsjWO3jqZFaiBnDlgP6gr/S3Yig0
         rqG4ZyRH2T2nbo9DOxillsmRuRLtRaFT6zIvmLzkMZNjGrFbjOctv4eUemPSkJO4VY
         S6+zbU4oR05CQ==
Date:   Wed, 29 Nov 2023 17:15:24 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: support W=c and W=e shorthands for Kconfig
Message-ID: <20231130001524.GA2513828@dev-arch.thelio-3990X>
References: <20231123090540.485309-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123090540.485309-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 06:05:40PM +0900, Masahiro Yamada wrote:
> KCONFIG_WARN_UNKNOWN_SYMBOLS=1 and KCONFIG_WERROR=1 are descriptive
> and suitable in scripting, but it is tedious to type them from the
> command line.
> 
> Associate them with KBUILD_EXTRA_WARN (and the W= shorthand).
> 
> Support a new letter 'c' for KBUILD_EXTRA_WARN to enable extra checks
> in Kconfig. You can still manage compiler warnings (W=1) and Kconfig
> warnings (W=c) independently.
> 
> Reuse the letter 'e' to turn Kconfig warnings into errors.
> 
> As usual, you can combine multiple letters in KCONFIG_EXTRA_WARN.
> 
>   $ KCONFIG_WARN_UNKNOWN_SYMBOLS=1 KCONFIG_WERROR=1 make defconfig
> 
> can be shortened to:
> 
>   $ KBUILD_EXTRA_WARN=ce make defconfig
> 
> or, even shorter:
> 
>   $ make W=ce defconfig
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Seems reasonable to me.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  Makefile                   | 10 ++++++++++
>  scripts/Makefile.extrawarn |  9 ---------
>  scripts/kconfig/Makefile   |  8 ++++++++
>  3 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index f128a1a1b1a0..91947f722b77 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -155,6 +155,15 @@ endif
>  
>  export KBUILD_EXTMOD
>  
> +# backward compatibility
> +KBUILD_EXTRA_WARN ?= $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)
> +
> +ifeq ("$(origin W)", "command line")
> +  KBUILD_EXTRA_WARN := $(W)
> +endif
> +
> +export KBUILD_EXTRA_WARN
> +
>  # Kbuild will save output files in the current working directory.
>  # This does not need to match to the root of the kernel source tree.
>  #
> @@ -1659,6 +1668,7 @@ help:
>  	@echo  '		1: warnings which may be relevant and do not occur too often'
>  	@echo  '		2: warnings which occur quite often but may still be relevant'
>  	@echo  '		3: more obscure warnings, can most likely be ignored'
> +	@echo  '		c: extra checks in the configuration stage (Kconfig)'
>  	@echo  '		e: warnings are being treated as errors'
>  	@echo  '		Multiple levels can be combined with W=12 or W=123'
>  	@$(if $(dtstree), \
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 2fe6f2828d37..3f94915fab37 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -80,15 +80,6 @@ KBUILD_CFLAGS += $(call cc-option,-Werror=designated-init)
>  # Warn if there is an enum types mismatch
>  KBUILD_CFLAGS += $(call cc-option,-Wenum-conversion)
>  
> -# backward compatibility
> -KBUILD_EXTRA_WARN ?= $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)
> -
> -ifeq ("$(origin W)", "command line")
> -  KBUILD_EXTRA_WARN := $(W)
> -endif
> -
> -export KBUILD_EXTRA_WARN
> -
>  #
>  # W=1 - warnings which may be relevant and do not occur too often
>  #
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 4eee155121a8..322c061b464d 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -27,6 +27,14 @@ KCONFIG_DEFCONFIG_LIST += \
>  endif
>  KCONFIG_DEFCONFIG_LIST += arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)
>  
> +ifneq ($(findstring c, $(KBUILD_EXTRA_WARN)),)
> +export KCONFIG_WARN_UNKNOWN_SYMBOLS=1
> +endif
> +
> +ifneq ($(findstring e, $(KBUILD_EXTRA_WARN)),)
> +export KCONFIG_WERROR=1
> +endif
> +
>  # We need this, in case the user has it in its environment
>  unexport CONFIG_
>  
> -- 
> 2.40.1
> 
