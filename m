Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E717FE4D0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjK3A3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 19:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK3A3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:29:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869E4BC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 16:29:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC47FC433C8;
        Thu, 30 Nov 2023 00:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701304185;
        bh=su3U2MKiTuvW1OU+U/J2IQYwdENWTmkzyZ8QyZdNEjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0/QhCngEgjxDfCEsM0SUqf+OQqLGtQXXDLmbfsUSXufruvxp6uB1B0n4JJ3pmdNE
         Oqm7YIITtoRNHLBu3PgfJ1a/gLIglbtkfybhJQpJDv7JddHTzSoqPXs0GVxCVyV4hx
         wv6CsENk5fUnSGGX6DHldk+B2EhE5RrREjA3WPaNBSCiarKLba+lVQ9co9e9chmwBV
         eTs5K/EP+Qy+PtmTyivnwSGtLGSLBwFP1gRE/ZwtDZ1AvsM1tOQNPXMKKeTtDKaT4V
         LoQXIMoFjmfWB+bB56e/uv1AFOHzkFJMPvQYLgZOvKKuR/gjNcDNHSg2i8hgufkIGO
         VzfgT6jznDWvA==
Date:   Wed, 29 Nov 2023 17:29:43 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH 2/3] modpost: remove unreachable code after fatal()
Message-ID: <20231130002943.GC2513828@dev-arch.thelio-3990X>
References: <20231125103116.797608-1-masahiroy@kernel.org>
 <20231125103116.797608-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125103116.797608-2-masahiroy@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 07:31:15PM +0900, Masahiro Yamada wrote:
> fatal() never returns. Remove unreachable code.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  scripts/mod/modpost.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index ca0a90158f85..013fc5031bc7 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -473,11 +473,9 @@ static int parse_elf(struct elf_info *info, const char *filename)
>  		fatal("%s: not relocatable object.", filename);
>  
>  	/* Check if file offset is correct */
> -	if (hdr->e_shoff > info->size) {
> +	if (hdr->e_shoff > info->size)
>  		fatal("section header offset=%lu in file '%s' is bigger than filesize=%zu\n",
>  		      (unsigned long)hdr->e_shoff, filename, info->size);
> -		return 0;
> -	}
>  
>  	if (hdr->e_shnum == SHN_UNDEF) {
>  		/*
> @@ -515,12 +513,11 @@ static int parse_elf(struct elf_info *info, const char *filename)
>  		const char *secname;
>  		int nobits = sechdrs[i].sh_type == SHT_NOBITS;
>  
> -		if (!nobits && sechdrs[i].sh_offset > info->size) {
> +		if (!nobits && sechdrs[i].sh_offset > info->size)
>  			fatal("%s is truncated. sechdrs[i].sh_offset=%lu > sizeof(*hrd)=%zu\n",
>  			      filename, (unsigned long)sechdrs[i].sh_offset,
>  			      sizeof(*hdr));
> -			return 0;
> -		}
> +
>  		secname = secstrings + sechdrs[i].sh_name;
>  		if (strcmp(secname, ".modinfo") == 0) {
>  			if (nobits)
> -- 
> 2.40.1
> 
