Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4503975133A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjGLWIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGLWIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:08:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48014A2;
        Wed, 12 Jul 2023 15:08:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D89E56194D;
        Wed, 12 Jul 2023 22:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1F9C433C8;
        Wed, 12 Jul 2023 22:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689199714;
        bh=n1sLIZMWC53t14JryI8HLSMlrC0CKeIy7qfgbIH/v5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kpbE/4043LTfs6VPKcXbvySW9/Tyr/KIdeXibYO3ElLPe/e83KPC/JbmUWWfgtUAM
         TnHdpJBvbAbXRwqmzAS+O77QBsCw9pwOwHi37lTcZcGH+ennzbP5G2kIbCFVvhJi0G
         Rg7Gdz1hqQ8MmdkOY+tuzb+nYdOLJbR8VZthvh9A4xa2gbnlY22irQxgKvJBDS2DFx
         wD4c3UBY8t8br+drO7yXstNENqgqivPyFfINJgtRdn1G6s9trTzSkY5cWl2C5iXkIJ
         YZRAT53p8p7f8RljUefxQ7DAmkSU2NOA/ox6CpYmwzDNk0gBlVcqNrcmNppZGSfDoj
         LTkFMWqLPmqYg==
Date:   Wed, 12 Jul 2023 15:08:32 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     j@jannau.net
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: rpm-pkg: Add dtbs support
Message-ID: <20230712220832.GA669032@dev-arch.thelio-3990X>
References: <20230712-kbuild_rpm_dtbs-v1-1-99693e8faaaf@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712-kbuild_rpm_dtbs-v1-1-99693e8faaaf@jannau.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 08:42:20AM +0200, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
> 
> Based on the dtbs support in builddeb. Both Fedora and openSUSE kernel
> rpm install their dtbs in "/boot/dtb-${KERNELRELEASE}". There seems no
> other popular rpm based distributions which would benefit from dtbs
> support and are not derived from those two.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Seems reasonable to me. I verified this works for at least arm64 and
x86_64.

$ rpm -qlp rpmbuild/RPMS/aarch64/kernel-6.5.0_rc1_next_20230712_00001_g5899d64b0f1b-1.aarch64.rpm | grep -q '^/boot/dtb'
/boot/dtb-6.5.0-rc1-next-20230712-00001-g5899d64b0f1b
/boot/dtb-6.5.0-rc1-next-20230712-00001-g5899d64b0f1b/allwinner
/boot/dtb-6.5.0-rc1-next-20230712-00001-g5899d64b0f1b/allwinner/sun50i-a100-allwinner-perf1.dtb
...

$ rpm -qlp rpmbuild/RPMS/x86_64/kernel-6.5.0_rc1_next_20230712_00001_g5899d64b0f1b-1.x86_64.rpm | grep -q '^/boot/dtb'

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  scripts/package/mkspec | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index 8049f0e2c110..a170b0c0a93f 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -28,6 +28,14 @@ else
>  	M=DEL
>  fi
>  
> +# Only some architectures with OF support have the dtbs_install target
> +if grep -q CONFIG_OF_EARLY_FLATTREE=y include/config/auto.conf && \
> +   [ -d "${srctree}/arch/${SRCARCH}/boot/dts" ]; then
> +	D=
> +else
> +	D=DEL
> +fi
> +
>  __KERNELRELEASE=$(echo $KERNELRELEASE | sed -e "s/-/_/g")
>  EXCLUDES="$RCS_TAR_IGNORE --exclude=*vmlinux* --exclude=*.mod \
>  --exclude=*.o --exclude=*.ko --exclude=*.cmd --exclude=Documentation \
> @@ -38,6 +46,8 @@ EXCLUDES="$RCS_TAR_IGNORE --exclude=*vmlinux* --exclude=*.mod \
>  # Labels:
>  #  $S: this line is enabled only when building source package
>  #  $M: this line is enabled only when CONFIG_MODULES is enabled
> +#  $D: this line is enabled only when CONFIG_OF_EARLY_FLATTREE is enabled and
> +#      the arch has a dts directory
>  sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
>  	Name: kernel
>  	Summary: The Linux Kernel
> @@ -103,6 +113,7 @@ $S
>  	%endif
>  $M	$MAKE %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} modules_install
>  	$MAKE %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
> +$D	$MAKE %{?_smp_mflags} INSTALL_DTBS_PATH=%{buildroot}/boot/dtb-${KERNELRELEASE} dtbs_install
>  	cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
>  	cp .config %{buildroot}/boot/config-$KERNELRELEASE
>  $S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/build
> 
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230712-kbuild_rpm_dtbs-d055a3780bbe
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 
