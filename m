Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607117B5D97
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbjJBXNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjJBXNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:13:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE41DB4;
        Mon,  2 Oct 2023 16:12:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23B4C433C7;
        Mon,  2 Oct 2023 23:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696288378;
        bh=QpsjepJRRnfhetgwl5KFi+10Gk78WLVJJwQQ9BNE95o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYHeAIRbDhoCcOWwQ/a0kTl3pIN8FBh0tQW+alPxeZL0jnzRTw8NXJTIhscEbHSZP
         0f3whN14VnqD75XsMWiP9N6IoF4IeOsifuRNcIAy8ZTukBBbr9H7tKDhWRVOCVLTrB
         dYRY6AIUmu7kY48/OyY9nCSkbOms/3sjOJiOGbKvq5RIOTihhyoeKvnyNRo24zTV4q
         8dqoHXYUkFcy5QX7YjmueX4XhYulI+k0GxF/AZpugWFNxvWGNbJX2cW2YJHatWGSsd
         bhBHclrb2kr5WkJgSm/do0inH3Dc3Tjggo+MIQV9fM6wbYhQZdl8I6KWUDbSAbFhO2
         cI5KZypI6AwVQ==
Date:   Mon, 2 Oct 2023 16:12:56 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH] kbuild: remove stale code for 'source' symlink in
 packaging scripts
Message-ID: <20231002231256.GA1269812@dev-arch.thelio-3990X>
References: <20231001140339.1707548-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001140339.1707548-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 11:03:39PM +0900, Masahiro Yamada wrote:
> Since commit d8131c2965d5 ("kbuild: remove $(MODLIB)/source symlink"),
> modules_install does not create the 'source' symlink.
> 
> Remove the stale code from builddeb and kernel.spec.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  scripts/package/builddeb    | 1 -
>  scripts/package/kernel.spec | 3 ---
>  2 files changed, 4 deletions(-)
> 
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index bf3f8561aa68..d7dd0d04c70c 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -64,7 +64,6 @@ install_linux_image () {
>  
>  	${MAKE} -f ${srctree}/Makefile INSTALL_MOD_PATH="${pdir}" modules_install
>  	rm -f "${pdir}/lib/modules/${KERNELRELEASE}/build"
> -	rm -f "${pdir}/lib/modules/${KERNELRELEASE}/source"
>  
>  	# Install the kernel
>  	if [ "${ARCH}" = um ] ; then
> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index ac3f2ee6d7a0..3eee0143e0c5 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
> @@ -68,7 +68,6 @@ cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KERNELRELEA
>  cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
>  cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
>  ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/build
> -ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/source
>  %if %{with_devel}
>  %{make} %{makeflags} run-command KBUILD_RUN_COMMAND='${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
>  %endif
> @@ -101,7 +100,6 @@ fi
>  %defattr (-, root, root)
>  /lib/modules/%{KERNELRELEASE}
>  %exclude /lib/modules/%{KERNELRELEASE}/build
> -%exclude /lib/modules/%{KERNELRELEASE}/source
>  /boot/*
>  
>  %files headers
> @@ -113,5 +111,4 @@ fi
>  %defattr (-, root, root)
>  /usr/src/kernels/%{KERNELRELEASE}
>  /lib/modules/%{KERNELRELEASE}/build
> -/lib/modules/%{KERNELRELEASE}/source
>  %endif
> -- 
> 2.39.2
> 
