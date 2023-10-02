Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4147B5D8C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbjJBXJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjJBXJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:09:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DC6AC;
        Mon,  2 Oct 2023 16:09:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8FAC433C8;
        Mon,  2 Oct 2023 23:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696288145;
        bh=gu0kj3Vk49NUDMDYLH9k8+xKFSohRBsIFcK4rRhjEUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lgZ41VgPd/ElBPwEA8nqF4reKV4tw4t1f1QtPTGDsUQ3nNWaH/g9ahzQ74CcYhPgg
         KKqUlOyfAWUqeJAy7BF7oiZlBf46YiE8L/oVkVvJNgD9XwlWRhnmjvvx7oyolyKA5D
         Vjn8wbgE+IAzrRQZ0DxZ+iVKaKUBGiCkS7Bx4QeHXXQTl1SSleU4TCRnJ8L4BuW3xX
         pgCgt37pFE+XPnZL3cwYwL3U/tgrJ/EWoVo7XlkruI94G5eFeiSVUItWeKK0yq3kRt
         c1TAeJLbNYEP8x/46uBAt94k4mh5bbfxl+DxUyTfXxtBMFYYD91XdZldHK3VOam1KZ
         urE3rpatkPcJw==
Date:   Mon, 2 Oct 2023 16:09:03 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH] kbuild: rpm-build: generate kernel.spec in
 rpmbuild/SPECS/
Message-ID: <20231002230903.GB1029006@dev-arch.thelio-3990X>
References: <20230930103847.1272324-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930103847.1272324-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 07:38:47PM +0900, Masahiro Yamada wrote:
> kernel.spec is the last piece that resides outside the rpmbuild/
> directory. Move all RPM-related files to rpmbuild/ consistently.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  .gitignore                 | 1 -
>  Makefile                   | 2 +-
>  scripts/Makefile.package   | 8 ++++----
>  scripts/package/mkspec     | 6 ++++++
>  scripts/remove-stale-files | 2 +-
>  5 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 0bbae167bf93..98274e1160d7 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -74,7 +74,6 @@ modules.order
>  #
>  # RPM spec file (make rpm-pkg)
>  #
> -/kernel.spec
>  /rpmbuild/
>  
>  #
> diff --git a/Makefile b/Makefile
> index 3de08c780c74..9e77a58207a8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1486,7 +1486,7 @@ MRPROPER_FILES += include/config include/generated          \
>  		  certs/signing_key.pem \
>  		  certs/x509.genkey \
>  		  vmlinux-gdb.py \
> -		  kernel.spec rpmbuild \
> +		  rpmbuild \
>  		  rust/libmacros.so
>  
>  # clean - Delete most, but leave enough to build external modules
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 2bcab02da965..05b8c3e29aac 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -69,9 +69,9 @@ $(linux-tarballs): .tmp_HEAD FORCE
>  # ---------------------------------------------------------------------------
>  
>  quiet_cmd_mkspec = GEN     $@
> -      cmd_mkspec = $(srctree)/scripts/package/mkspec > $@
> +      cmd_mkspec = $(srctree)/scripts/package/mkspec $@
>  
> -kernel.spec: FORCE
> +rpmbuild/SPECS/kernel.spec: FORCE
>  	$(call cmd,mkspec)
>  
>  PHONY += rpm-sources
> @@ -88,8 +88,8 @@ srcrpm-pkg: private build-type := s
>  binrpm-pkg: private build-type := b
>  
>  rpm-pkg srcrpm-pkg: rpm-sources
> -rpm-pkg srcrpm-pkg binrpm-pkg: kernel.spec
> -	+$(strip rpmbuild -b$(build-type) kernel.spec \
> +rpm-pkg srcrpm-pkg binrpm-pkg: rpmbuild/SPECS/kernel.spec
> +	+$(strip rpmbuild -b$(build-type) rpmbuild/SPECS/kernel.spec \
>  	--define='_topdir $(abspath rpmbuild)' \
>  	$(if $(filter a b, $(build-type)), \
>  		--target $(UTS_MACHINE)-linux --build-in-place --noprep --define='_smp_mflags %{nil}' \
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index d41608efb747..ce201bfa8377 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -9,6 +9,12 @@
>  #	Patched for non-x86 by Opencon (L) 2002 <opencon@rio.skydome.net>
>  #
>  
> +output=$1
> +
> +mkdir -p "$(dirname "${output}")"
> +
> +exec >"${output}"
> +
>  if grep -q CONFIG_MODULES=y include/config/auto.conf; then
>  echo '%define with_devel %{?_without_devel: 0} %{?!_without_devel: 1}'
>  else
> diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
> index 8b1a636f8543..385610fe3936 100755
> --- a/scripts/remove-stale-files
> +++ b/scripts/remove-stale-files
> @@ -38,4 +38,4 @@ rm -rf include/ksym
>  
>  find . -name '*.usyms' | xargs rm -f
>  
> -rm -f binkernel.spec
> +rm -f *.spec
> -- 
> 2.39.2
> 
