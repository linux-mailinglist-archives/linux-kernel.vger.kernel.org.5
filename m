Return-Path: <linux-kernel+bounces-7344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB56C81A632
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4381C24A34
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BC047A42;
	Wed, 20 Dec 2023 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwcTyknq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC1732196;
	Wed, 20 Dec 2023 17:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC7FC433C8;
	Wed, 20 Dec 2023 17:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703092698;
	bh=g1rTCThkSp1acELq4RZ+QEedzsyKvoFj9tnpHzcVM9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VwcTyknqCdbHPZUP8Nmae2djHIFfiBsWIZ3YBQLhQpo0C3bTjnHktpXqpCuxeeWlj
	 3Unb6HzsaES3sb0wxaYtgEf8jRCRMlIUP/RmZ/ux+8B02RFnETHg5HP/EVHSDO1ayW
	 lYdlyqyWtfOKWOsmDssYzGZpgMYrF5gQYaocVvQuqYS1PE0qH0wJBmEwXwUbceHEYm
	 WO+aNSzY/PqSUo/f8Zxz2RMugTA71eZhSNMbEUzPLQWYLFfCFK2FXRXhxJMOW5gHnU
	 q2j0NZkJr6Ck488U8od3uifr4xBWhzv8Fpl9x11U+ZaiOpHTh8f30Oz4HruHFqJqP8
	 C7/h5/fhMLzJQ==
Date: Wed, 20 Dec 2023 10:18:16 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: masahiroy@kernel.org, dcavalca@meta.com, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, ndesaulniers@google.com,
	nicolas@fjasle.eu, stable@vger.kernel.org
Subject: Re: [PATCH v4] rpm-pkg: simplify installkernel %post
Message-ID: <20231220171816.GA95936@dev-arch.thelio-3990X>
References: <CAK7LNASf7cOiWpcMsycVSBOg4Xp-dmUnAvGqdw5wAYR=KBzdig@mail.gmail.com>
 <20231219201719.1967948-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219201719.1967948-1-jtornosm@redhat.com>

On Tue, Dec 19, 2023 at 09:17:19PM +0100, Jose Ignacio Tornos Martinez wrote:
> The new installkernel application that is now included in systemd-udev
> package allows installation although destination files are already present
> in the boot directory of the kernel package, but is failing with the
> implemented workaround for the old installkernel application from grubby
> package.
> 
> For the new installkernel application, as Davide says:
> <<The %post currently does a shuffling dance before calling installkernel.
> This isn't actually necessary afaict, and the current implementation
> ends up triggering downstream issues such as
> https://github.com/systemd/systemd/issues/29568
> This commit simplifies the logic to remove the shuffling. For reference,
> the original logic was added in commit 3c9c7a14b627("rpm-pkg: add %post
> section to create initramfs and grub hooks").>>
> 
> But we need to keep the old behavior as well, because the old installkernel
> application from grubby package, does not allow this simplification and
> we need to be backward compatible to avoid issues with the different
> packages.
> 
> Mimic Fedora shipping process and store vmlinuz, config amd System.map
> in the module directory instead of the boot directory. In this way, we will
> avoid the commented problem for all the cases, because the new destination
> files are not going to exist in the boot directory of the kernel package.
> 
> Replace installkernel tool with kernel-install tool, because the latter is
> more complete. Suitable manual actions are added as a default if tool is not
> present (unusual).
> 
> cc: stable@vger.kernel.org
> Co-Developed-by: Davide Cavalca <dcavalca@meta.com>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Still works for me on Fedora 39, thanks for the fix!

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> V1 -> V2:
> - Complete to be backward compatible with the previous installkernel
> application.
> V2 -> V3:
> - Follow the suggestions from Masahiro Yamada and change the installation
> V3 -> V4:
> - Make the patch applicable to linux-kbuild/for-next (ia64 support was
> already removed).
> 
>  scripts/package/kernel.spec | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index 89298983a169..17e7196c9be1 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
> @@ -55,12 +55,12 @@ patch -p1 < %{SOURCE2}
>  %{make} %{makeflags} KERNELRELEASE=%{KERNELRELEASE} KBUILD_BUILD_VERSION=%{release}
>  
>  %install
> -mkdir -p %{buildroot}/boot
> -cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KERNELRELEASE}
> +mkdir -p %{buildroot}/lib/modules/%{KERNELRELEASE}
> +cp $(%{make} %{makeflags} -s image_name) %{buildroot}/lib/modules/%{KERNELRELEASE}/vmlinuz
>  %{make} %{makeflags} INSTALL_MOD_PATH=%{buildroot} modules_install
>  %{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
> -cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
> -cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
> +cp System.map %{buildroot}/lib/modules/%{KERNELRELEASE}
> +cp .config %{buildroot}/lib/modules/%{KERNELRELEASE}/config
>  ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/build
>  %if %{with_devel}
>  %{make} %{makeflags} run-command KBUILD_RUN_COMMAND='${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
> @@ -70,12 +70,12 @@ ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEA
>  rm -rf %{buildroot}
>  
>  %post
> -if [ -x /sbin/installkernel -a -r /boot/vmlinuz-%{KERNELRELEASE} -a -r /boot/System.map-%{KERNELRELEASE} ]; then
> -cp /boot/vmlinuz-%{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm
> -cp /boot/System.map-%{KERNELRELEASE} /boot/.System.map-%{KERNELRELEASE}-rpm
> -rm -f /boot/vmlinuz-%{KERNELRELEASE} /boot/System.map-%{KERNELRELEASE}
> -/sbin/installkernel %{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
> -rm -f /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
> +if [ -x /usr/bin/kernel-install ]; then
> +kernel-install add %{KERNELRELEASE} /lib/modules/%{KERNELRELEASE}/vmlinuz
> +else
> +cp /lib/modules/%{KERNELRELEASE}/vmlinuz /boot/vmlinuz-%{KERNELRELEASE}
> +cp /lib/modules/%{KERNELRELEASE}/System.map /boot/System.map-%{KERNELRELEASE}
> +cp /lib/modules/%{KERNELRELEASE}/config /boot/config-%{KERNELRELEASE}
>  fi
>  
>  %preun
> @@ -94,7 +94,6 @@ fi
>  %defattr (-, root, root)
>  /lib/modules/%{KERNELRELEASE}
>  %exclude /lib/modules/%{KERNELRELEASE}/build
> -/boot/*
>  
>  %files headers
>  %defattr (-, root, root)
> -- 
> 2.43.0
> 

