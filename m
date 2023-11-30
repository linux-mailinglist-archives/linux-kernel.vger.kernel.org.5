Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3608A7FE4D7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjK3AcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 19:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjK3AcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:32:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200971A6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 16:32:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C58FC433C7;
        Thu, 30 Nov 2023 00:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701304329;
        bh=sWTZRFs3LpzmxPcfO3M2aIt9v0k5GfKcQDamobqt17I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3FK9HcPl3lhLpfF6lkcbEeA2aI0sYUCtwwghlEFKnuLYH6krMrGR81GpJY3MmJbT
         80nRU8sIxCxJ9H5HfLmLQYqg0Zo56C8IxbToyb5Z4W7dO2ayMmXduy2zq7/LS4oGUe
         Cpkq5Tkd3qhwKt8O6W6WND6FWlpBPgPme9TePxSkCwxA/UDNDFysFcjrsC9BrehP7f
         IQM93kmasmjIu36h2mNO/7mbqm3u+ORiwCEONIh9nPKzwL9Cmv8amSnGHFx6lSyWBL
         b9R589WnaarzVSV548Q91I5rgRxVYBwarANnrPu770SVphzPxnntt6A7gmiTHT5Hw5
         JOJA7mgCVp3LQ==
Date:   Wed, 29 Nov 2023 17:32:07 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH 3/3] modpost: move exit(1) for fatal() to modpost.h
Message-ID: <20231130003207.GD2513828@dev-arch.thelio-3990X>
References: <20231125103116.797608-1-masahiroy@kernel.org>
 <20231125103116.797608-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125103116.797608-3-masahiroy@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 07:31:16PM +0900, Masahiro Yamada wrote:
> fatal() never returns, but compilers are not aware of this fact because
> exit(1) is called within the modpost_log() definition.
> 
> Move exit(1) to the fatal() macro so that compilers can identify
> unreachable code flows.
> 
> Remove the initializer for 'taddr' in section_rel(), as compilers now
> recognize this is not an uninitialized bug.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

While I did not see any warnings when testing, it seems like this patch
should come before patch 2 to avoid any potential problems from dropping
the unreachable code (since the compiler won't be able to infer that
fatal() is __noreturn without this change); doesn't really matter though
so:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  scripts/mod/modpost.c | 4 +---
>  scripts/mod/modpost.h | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 013fc5031bc7..696c583a14ec 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -84,8 +84,6 @@ void modpost_log(enum loglevel loglevel, const char *fmt, ...)
>  	vfprintf(stderr, fmt, arglist);
>  	va_end(arglist);
>  
> -	if (loglevel == LOG_FATAL)
> -		exit(1);
>  	if (loglevel == LOG_ERROR)
>  		error_occurred = true;
>  }
> @@ -1415,7 +1413,7 @@ static void section_rel(struct module *mod, struct elf_info *elf,
>  
>  	for (rel = start; rel < stop; rel++) {
>  		Elf_Sym *tsym;
> -		Elf_Addr taddr = 0, r_offset;
> +		Elf_Addr taddr, r_offset;
>  		unsigned int r_type, r_sym;
>  		void *loc;
>  
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index 9fe974dc1a52..aaa67b24775e 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -215,4 +215,4 @@ modpost_log(enum loglevel loglevel, const char *fmt, ...);
>   */
>  #define warn(fmt, args...)	modpost_log(LOG_WARN, fmt, ##args)
>  #define error(fmt, args...)	modpost_log(LOG_ERROR, fmt, ##args)
> -#define fatal(fmt, args...)	modpost_log(LOG_FATAL, fmt, ##args)
> +#define fatal(fmt, args...)	do { modpost_log(LOG_FATAL, fmt, ##args); exit(1); } while (1)
> -- 
> 2.40.1
> 
