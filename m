Return-Path: <linux-kernel+bounces-11339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CFC81E4D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE441C21C46
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 04:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8E71E48F;
	Tue, 26 Dec 2023 04:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIJwJjnd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E7A18EBE;
	Tue, 26 Dec 2023 04:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570CBC433C8;
	Tue, 26 Dec 2023 04:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703563368;
	bh=VFtaTsNzp3ptvfryn6wsPbPQyNhhITeXxCesm41Cr7g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TIJwJjndd8hxk7YW/VNgTJlBQbz9XpgK1KOrWJLRFKZ+hFt0rWj3lJNpR9JgodWL2
	 txxmdJTTvcP6fn3js/zg3vIaPLIiT1/Zcgc99rOpm3fjwVDHeXBvncr1KAvOZog9m2
	 P32jhLtY3Pj7T5ih11DAi8LVrY1ZPT1DQUQCMsxkOEZVNpBJU2IX+c2rIkklRskL/l
	 Ez1k++nkftMBmIANRwEQhUem6h/uOh+lFtOz+OLIhhZrmMO0JHj9wkwgp9nYI37g2X
	 PyeHfHJTyquc9Jf943ioNcEZWUjeZY2qZeb9mq7/iempOTx92P0f/fLstEQ5It61RK
	 T1uegRWIu91IA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-204520717b3so1967769fac.0;
        Mon, 25 Dec 2023 20:02:48 -0800 (PST)
X-Gm-Message-State: AOJu0Yz4iMPPETy4IWcE66nDH1lG6TpHjRSj6AupAiSxj04RU+jfDX6F
	5+XTBAliMZOy6nXOHJqP+HyDe2jXbLF8twogD/g=
X-Google-Smtp-Source: AGHT+IEyBIbSHRen5qHShaCMvS+CmJjO5RWG9JXt2gw4B6vX61FOisb6UVUQQAc4/jtFI0yWk+/vbufZIetDO6RZX64=
X-Received: by 2002:a05:6870:c10d:b0:203:b44f:9036 with SMTP id
 f13-20020a056870c10d00b00203b44f9036mr7611819oad.60.1703563367641; Mon, 25
 Dec 2023 20:02:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNASf7cOiWpcMsycVSBOg4Xp-dmUnAvGqdw5wAYR=KBzdig@mail.gmail.com>
 <20231219201719.1967948-1-jtornosm@redhat.com>
In-Reply-To: <20231219201719.1967948-1-jtornosm@redhat.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 26 Dec 2023 13:02:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR_wgQBs-q9NH1icb_FPBoVMNEhQpvV8qzH2dFsrDS0pQ@mail.gmail.com>
Message-ID: <CAK7LNAR_wgQBs-q9NH1icb_FPBoVMNEhQpvV8qzH2dFsrDS0pQ@mail.gmail.com>
Subject: Re: [PATCH v4] rpm-pkg: simplify installkernel %post
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: dcavalca@meta.com, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nathan@kernel.org, ndesaulniers@google.com, 
	nicolas@fjasle.eu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 5:17=E2=80=AFAM Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> The new installkernel application that is now included in systemd-udev
> package allows installation although destination files are already presen=
t
> in the boot directory of the kernel package, but is failing with the
> implemented workaround for the old installkernel application from grubby
> package.
>
> For the new installkernel application, as Davide says:
> <<The %post currently does a shuffling dance before calling installkernel=
.
> This isn't actually necessary afaict, and the current implementation
> ends up triggering downstream issues such as
> https://github.com/systemd/systemd/issues/29568
> This commit simplifies the logic to remove the shuffling. For reference,
> the original logic was added in commit 3c9c7a14b627("rpm-pkg: add %post
> section to create initramfs and grub hooks").>>
>
> But we need to keep the old behavior as well, because the old installkern=
el
> application from grubby package, does not allow this simplification and
> we need to be backward compatible to avoid issues with the different
> packages.
>
> Mimic Fedora shipping process and store vmlinuz, config amd System.map
> in the module directory instead of the boot directory. In this way, we wi=
ll
> avoid the commented problem for all the cases, because the new destinatio=
n
> files are not going to exist in the boot directory of the kernel package.
>
> Replace installkernel tool with kernel-install tool, because the latter i=
s
> more complete. Suitable manual actions are added as a default if tool is =
not
> present (unusual).


This paragraph should be reworded,
and the corresponding code should be fixed.


This patch works for fedora 38 and fedora 39,
but may break openSUSE tumbleweed, at least.



The kernel-install itself does not copy files,
but invoked scripts in /usr/lib/kernel/install.d/


In Fedora,

/usr/lib/kernel/install.d/20-grub.install

copies those files to /boot/.



In openSUSE, the 'udev' package provides
/usr/bin/kernel-install,
but /usr/lib/kernel/install.d/20-grub.install
is missing.


masahiro@ea071f1f0504:~> rpm -qpl udev-254.5-8.1.x86_64.rpm | grep kernel
/usr/bin/kernel-install
/usr/lib/kernel
/usr/lib/kernel/install.conf
/usr/lib/kernel/install.d
/usr/lib/kernel/install.d/50-depmod.install
/usr/lib/kernel/install.d/90-loaderentry.install
/usr/lib/kernel/install.d/90-uki-copy.install
/usr/lib/systemd/system/sockets.target.wants/systemd-udevd-kernel.socket
/usr/lib/systemd/system/systemd-udevd-kernel.socket
/usr/share/bash-completion/completions/kernel-install
/usr/share/man/man8/kernel-install.8.gz
/usr/share/man/man8/systemd-udevd-kernel.socket.8.gz
/usr/share/zsh/site-functions/_kernel-install



In openSUSE with the udev package installed,
none of vmlinuz, config, System.map is copied
to the /boot directory.




Applying the following on top should fix the regression,
although I did not test any other RPM-based distros.



diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index afef3b0f6a3d..eb5cc440216b 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -71,12 +71,13 @@ rm -rf %{buildroot}

 %post
 if [ -x /usr/bin/kernel-install ]; then
-kernel-install add %{KERNELRELEASE} /lib/modules/%{KERNELRELEASE}/vmlinuz
-else
-cp /lib/modules/%{KERNELRELEASE}/vmlinuz /boot/vmlinuz-%{KERNELRELEASE}
-cp /lib/modules/%{KERNELRELEASE}/System.map /boot/System.map-%{KERNELRELEA=
SE}
-cp /lib/modules/%{KERNELRELEASE}/config /boot/config-%{KERNELRELEASE}
+    /usr/bin/kernel-install add %{KERNELRELEASE}
/lib/modules/%{KERNELRELEASE}/vmlinuz
 fi
+for file in vmlinuz System.map config; do
+    if [ ! -e "/boot/${file}-%{KERNELRELEASE}" ]; then
+        cp "/lib/modules/%{KERNELRELEASE}/${file}"
"/boot/${file}-%{KERNELRELEASE}"
+    fi
+done

 %preun
 if [ -x /sbin/new-kernel-pkg ]; then












>
> cc: stable@vger.kernel.org
> Co-Developed-by: Davide Cavalca <dcavalca@meta.com>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
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
>  %{make} %{makeflags} KERNELRELEASE=3D%{KERNELRELEASE} KBUILD_BUILD_VERSI=
ON=3D%{release}
>
>  %install
> -mkdir -p %{buildroot}/boot
> -cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KER=
NELRELEASE}
> +mkdir -p %{buildroot}/lib/modules/%{KERNELRELEASE}
> +cp $(%{make} %{makeflags} -s image_name) %{buildroot}/lib/modules/%{KERN=
ELRELEASE}/vmlinuz
>  %{make} %{makeflags} INSTALL_MOD_PATH=3D%{buildroot} modules_install
>  %{make} %{makeflags} INSTALL_HDR_PATH=3D%{buildroot}/usr headers_install
> -cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
> -cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
> +cp System.map %{buildroot}/lib/modules/%{KERNELRELEASE}
> +cp .config %{buildroot}/lib/modules/%{KERNELRELEASE}/config
>  ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KER=
NELRELEASE}/build
>  %if %{with_devel}
>  %{make} %{makeflags} run-command KBUILD_RUN_COMMAND=3D'${srctree}/script=
s/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE=
}'
> @@ -70,12 +70,12 @@ ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot=
}/lib/modules/%{KERNELRELEA
>  rm -rf %{buildroot}
>
>  %post
> -if [ -x /sbin/installkernel -a -r /boot/vmlinuz-%{KERNELRELEASE} -a -r /=
boot/System.map-%{KERNELRELEASE} ]; then
> -cp /boot/vmlinuz-%{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm
> -cp /boot/System.map-%{KERNELRELEASE} /boot/.System.map-%{KERNELRELEASE}-=
rpm
> -rm -f /boot/vmlinuz-%{KERNELRELEASE} /boot/System.map-%{KERNELRELEASE}
> -/sbin/installkernel %{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm=
 /boot/.System.map-%{KERNELRELEASE}-rpm
> -rm -f /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELE=
ASE}-rpm
> +if [ -x /usr/bin/kernel-install ]; then
> +kernel-install add %{KERNELRELEASE} /lib/modules/%{KERNELRELEASE}/vmlinu=
z
> +else
> +cp /lib/modules/%{KERNELRELEASE}/vmlinuz /boot/vmlinuz-%{KERNELRELEASE}
> +cp /lib/modules/%{KERNELRELEASE}/System.map /boot/System.map-%{KERNELREL=
EASE}
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


--=20
Best Regards
Masahiro Yamada

