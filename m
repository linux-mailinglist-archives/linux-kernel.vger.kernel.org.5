Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8EE7FE4B5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343759AbjK3AQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 19:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjK3AQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:16:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D03E198
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 16:17:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC830C433C8;
        Thu, 30 Nov 2023 00:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701303422;
        bh=Hatbq/cs0qtcAoVpae9FtcGGNw3zYfE2KT3JQ8+1QDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xi8nwewdeNmsDoGVjPSs22j08Sg6/MQYvc9337TgQRt8JFmC4Ua91ewiCB8tG1iAO
         ygi+RUKQSr9FHlUJBOPsPlwS3UwYE7U9DUvX44xTmUapPeQZ6LilDXK43GXGM4l+02
         d1he2k1h8mcVBi8MsSMyuLsHDv5c/k5gAuZLUVqUTWpKdm4M9ySAUfletWF9cZY+re
         IPzc3qgoiMD6lQ55aIdHZ2+JTjcCjn7BxNV/uk0QMfkyPEXLsOdM67m3/aj3SPIbny
         PP4p5rYiTSSUR4zi6eBUA2dpYGroBiUOx3Iut0WVzxYtiGDJRV7iDg0kiSa8PBmMGl
         wq9YOiDOghV1A==
Date:   Wed, 29 Nov 2023 17:17:00 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH 1/3] modpost: move __attribute__((format(printf, 2, 3)))
 to modpost.h
Message-ID: <20231130001700.GB2513828@dev-arch.thelio-3990X>
References: <20231125103116.797608-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125103116.797608-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 07:31:14PM +0900, Masahiro Yamada wrote:
> This attribute must be added to the function declaration in a header
> for comprehensive checking of all the callsites.
> 
> Fixes: 6d9a89ea4b06 ("kbuild: declare the modpost error functions as printf like")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  scripts/mod/modpost.c | 3 +--
>  scripts/mod/modpost.h | 3 ++-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index cb6406f485a9..ca0a90158f85 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -60,8 +60,7 @@ static unsigned int nr_unresolved;
>  
>  #define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
>  
> -void __attribute__((format(printf, 2, 3)))
> -modpost_log(enum loglevel loglevel, const char *fmt, ...)
> +void modpost_log(enum loglevel loglevel, const char *fmt, ...)
>  {
>  	va_list arglist;
>  
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index 69baf014da4f..9fe974dc1a52 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -197,7 +197,8 @@ enum loglevel {
>  	LOG_FATAL
>  };
>  
> -void modpost_log(enum loglevel loglevel, const char *fmt, ...);
> +void __attribute__((format(printf, 2, 3)))
> +modpost_log(enum loglevel loglevel, const char *fmt, ...);
>  
>  /*
>   * warn - show the given message, then let modpost continue running, still
> -- 
> 2.40.1
> 
