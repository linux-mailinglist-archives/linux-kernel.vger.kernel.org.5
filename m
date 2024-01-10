Return-Path: <linux-kernel+bounces-22269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6542C829BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3E1285012
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B0F48CFE;
	Wed, 10 Jan 2024 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="NEpBw8bW"
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B521848CCC;
	Wed, 10 Jan 2024 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed, 10 Jan 2024 14:47:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1704894462; bh=yB/d2HBtnseonB7gGBWG1ceZe3XwB4h+dT4pG9J/Hkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NEpBw8bWwaEvX3bs+RKmpaWjUKiFQqIPS65q2o8+nw4Zy6cd/1ifPSziEVblFJo7B
	 id9zHit1+ZEcMwYN05xMoZHJjgQycuMz7NTD1TFLRu88G10vfJnRbVF6I1GAEgCLIy
	 DsyiOnAO+Y8Mlm14US57ETtHI8nHlC8EG0AtsKRU=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 91B4B802B0;
	Wed, 10 Jan 2024 14:47:42 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id 35D9718105E; Wed, 10 Jan 2024 14:47:42 +0100 (CET)
Date: Wed, 10 Jan 2024 14:47:42 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] kbuild: deb-pkg: build binary-arch in parallel
Message-ID: <ZZ6f_rO4MQBm6Ews@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
References: <20231230135200.1058873-1-masahiroy@kernel.org>
 <20231230135200.1058873-4-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231230135200.1058873-4-masahiroy@kernel.org>
Organization: AVM GmbH
X-purgate-ID: 149429::1704894462-7066B92C-BAACA115/0/0
X-purgate-type: clean
X-purgate-size: 4687
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Sat, Dec 30, 2023 at 10:51:59PM +0900, Masahiro Yamada wrote:
> 'make deb-pkg' builds build-arch in parallel, but binary-arch serially.
> 
> Given that all binary packages are independent of one another, they can
> be built in parallel.
> 
> I am uncertain whether debian/files is robust against a race condition.
> Just in case, make dh_gencontrol (dpkg-gencontrol) output to separate
> debian/*.files, which are then concatenated into debian/files.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/package/builddeb     | 40 ++++++++++--------------------------
>  scripts/package/debian/rules | 35 +++++++++++++++++++++++++++----
>  2 files changed, 42 insertions(+), 33 deletions(-)
> 
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index bf96a3c24608..d31b16afe0db 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -24,18 +24,6 @@ if_enabled_echo() {
>  	fi
>  }
>  
> -create_package() {
> -	export DH_OPTIONS="-p${1}"
> -
> -	dh_installdocs
> -	dh_installchangelogs
> -	dh_compress
> -	dh_fixperms
> -	dh_gencontrol
> -	dh_md5sums
> -	dh_builddeb -- ${KDEB_COMPRESS:+-Z$KDEB_COMPRESS}
> -}
> -
>  install_linux_image () {
>  	pname=$1
>  	pdir=debian/$1
> @@ -161,21 +149,15 @@ install_libc_headers () {
>  	mv "$pdir/usr/include/asm" "$pdir/usr/include/${DEB_HOST_MULTIARCH}"
>  }
>  
> -rm -f debian/files
> +package=$1
>  
> -packages_enabled=$(dh_listpackages)
> -
> -for package in ${packages_enabled}
> -do
> -	case ${package} in
> -	*-dbg)
> -		install_linux_image_dbg "${package}";;
> -	linux-image-*|user-mode-linux-*)
> -		install_linux_image "${package}";;
> -	linux-libc-dev)
> -		install_libc_headers "${package}";;
> -	linux-headers-*)
> -		install_kernel_headers "${package}";;
> -	esac
> -	create_package "${package}"
> -done
> +case "${package}" in
> +*-dbg)
> +	install_linux_image_dbg "${package}";;
> +linux-image-*|user-mode-linux-*)
> +	install_linux_image "${package}";;
> +linux-libc-dev)
> +	install_libc_headers "${package}";;
> +linux-headers-*)
> +	install_kernel_headers "${package}";;
> +esac
> diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
> index b3f80f62236c..407f46a4a655 100755
> --- a/scripts/package/debian/rules
> +++ b/scripts/package/debian/rules
> @@ -19,12 +19,39 @@ revision = $(lastword $(subst -, ,$(shell dpkg-parsechangelog -S Version)))
>  CROSS_COMPILE ?= $(filter-out $(DEB_BUILD_GNU_TYPE)-, $(DEB_HOST_GNU_TYPE)-)
>  make-opts = ARCH=$(ARCH) KERNELRELEASE=$(KERNELRELEASE) KBUILD_BUILD_VERSION=$(revision) $(addprefix CROSS_COMPILE=,$(CROSS_COMPILE))
>  
> +binary-targets := $(addprefix binary-, image image-dbg headers libc-dev)
> +
> +all-packages = $(shell dh_listpackages)
> +image-package = $(filter linux-image-% user-%, $(filter-out %-dbg, $(all-packages)))
> +image-dbg-package = $(filter %-dbg, $(all-packages))
> +libc-dev-package = $(filter linux-libc-dev, $(all-packages))
> +headers-package = $(filter linux-headers-%, $(all-packages))
> +
> +mk-files = $(patsubst binary-%,debian/%.files,$1)
> +package = $($(@:binary-%=%-package))
> +DH_OPTIONS = -p$(package)
> +
> +define binary
> +	$(Q)+$(MAKE) $(make-opts) run-command KBUILD_RUN_COMMAND='+$$(srctree)/scripts/package/builddeb $(package)'
> +	$(Q)dh_installdocs $(DH_OPTIONS)
> +	$(Q)dh_installchangelogs $(DH_OPTIONS)
> +	$(Q)dh_compress $(DH_OPTIONS)
> +	$(Q)dh_fixperms $(DH_OPTIONS)
> +	$(Q)dh_gencontrol $(DH_OPTIONS) -- -f$(call mk-files,$@)
> +	$(Q)dh_md5sums $(DH_OPTIONS)
> +	$(Q)dh_builddeb $(DH_OPTIONS) -- $(addprefix -Z,$(KDEB_COMPRESS))
> +endef
> +
> +.PHONY: $(binary-targets)
> +$(binary-targets): build-arch
> +	$(Q)truncate -s0 $(call mk-files,$@)
> +	$(if $(package),$(binary))
> +
>  .PHONY: binary binary-indep binary-arch
>  binary: binary-arch binary-indep
>  binary-indep: build-indep
> -binary-arch: build-arch
> -	$(Q)$(MAKE) $(make-opts) \
> -	run-command KBUILD_RUN_COMMAND='+$$(srctree)/scripts/package/builddeb'
> +binary-arch: $(binary-targets)
> +	$(Q)cat $(call mk-files,$^) > debian/files
>  
>  .PHONY: build build-indep build-arch
>  build: build-arch build-indep
> @@ -35,7 +62,7 @@ build-arch:
>  
>  .PHONY: clean
>  clean:
> -	$(Q)rm -rf debian/files debian/linux-* debian/deb-env.vars*
> +	$(Q)rm -rf debian/files debian/linux-* debian/deb-env.vars* debian/*.files
>  	$(Q)$(MAKE) ARCH=$(ARCH) clean
>  
>  # If DEB_HOST_ARCH is empty, it is likely that debian/rules was executed
> -- 
> 2.40.1
> 

Thanks, looks good to me.

Reviewed-by: Nicolas Schier <n.schier@avm.de>

