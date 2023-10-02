Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54117B5DA4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbjJBXP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237204AbjJBXP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:15:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50562E6;
        Mon,  2 Oct 2023 16:15:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91108C433C7;
        Mon,  2 Oct 2023 23:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696288553;
        bh=lSiGxXGfOMMW+vaDORMWY1xisMeaS70s4hEUGF6SHVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rh/ojyV1bWJsPWeSx4MYd13toiqc4VeLGbNMl7/ynM7JzMPSjvbMOTFEY8KqaIoVj
         +CSSAmmAZiOdmVTkwCwjnWY7MjJ7+RAvS+M6ScAuxJU6z2tX/IYhvIRpeYRjWVzKpr
         YxtKG64HgYziULOc6F1SuZEYzMsu15s+hrSypIqmaEP3IQ20eIOX4zZVL79XYM4Lu+
         qH5DcacNnYypydKOFuckqBcGUxkcTvMnht3WhN9+cdaAYo2uHLofM6jrUdQblr8fpV
         7nwlBBghnbZdFAX8z1GSQChjEk/6j7rzlMqFz3y8oRJkrEvpe30342c9kCDCWjQ9cf
         NJG+CqvSDg3jQ==
Date:   Mon, 2 Oct 2023 16:15:51 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH] kbuild: make binrpm-pkg always produce kernel-devel
 package
Message-ID: <20231002231551.GB1269812@dev-arch.thelio-3990X>
References: <20231001123822.1659773-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001123822.1659773-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 09:38:22PM +0900, Masahiro Yamada wrote:
> The generation of the kernel-devel package is disabled for binrpm-pkg
> presumably because it was quite big (>= 200MB) and took a long time to
> package.
> 
> Commit fe66b5d2ae72 ("kbuild: refactor kernel-devel RPM package and
> linux-headers Deb package") reduced the package size to 12MB, and now
> it is quick to build. It won't hurt to have binrpm-pkg generate it by
> default.
> 
> If you want to skip the kernel-devel package generation, you can pass
> RPMOPTS='--without devel':
> 
>   $ make binrpm-pkg RPMOPTS='--without devel'
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  scripts/Makefile.package | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 05b8c3e29aac..3addd1c0b989 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -94,8 +94,6 @@ rpm-pkg srcrpm-pkg binrpm-pkg: rpmbuild/SPECS/kernel.spec
>  	$(if $(filter a b, $(build-type)), \
>  		--target $(UTS_MACHINE)-linux --build-in-place --noprep --define='_smp_mflags %{nil}' \
>  		$$(rpm -q rpm >/dev/null 2>&1 || echo --nodeps)) \
> -	$(if $(filter b, $(build-type)), \
> -		--without devel) \
>  	$(RPMOPTS))
>  
>  # deb-pkg srcdeb-pkg bindeb-pkg
> -- 
> 2.39.2
> 
