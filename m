Return-Path: <linux-kernel+bounces-4244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C40518179A3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540F11F21BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300775D74B;
	Mon, 18 Dec 2023 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKHgRJoH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781281DA2F;
	Mon, 18 Dec 2023 18:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9930EC433CC;
	Mon, 18 Dec 2023 18:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702924050;
	bh=/TVSQiDIX8kODu4AUjr1OiZf1rMZqMfh2MQF2mylbTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tKHgRJoHvMlSmZg2h/mxHtF0PQuQm9gPTPP8CpWiMhiuDE1VphdavZynngVAl1vpp
	 TFhLVEOrHTfNqkcV/U7Ya9D1U7lsiu5ZjoF0Qx+mwuxljc3rWM5gJ7jgWHJGAHr/jI
	 58/vNfgI9wagy72R5cjw3gYWW/ezU66IAp8ZAv2Gy+BDvYe31psQ9MmFj0T2vYv1rL
	 gK2JBEdBPwQHqtOnvrXPN+sLkSK1V46DXHIzsYDShMlthzzUVMpG8FyDZg/m7IOxDY
	 UC2p/ITNDhXBy5duPYIGvrLAsxhju1W1tThRu8UMTkTsmtTR/rHBg2HH9R2x1OgULL
	 jV2nlXDTHTSjg==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-203ba1328d1so979743fac.0;
        Mon, 18 Dec 2023 10:27:30 -0800 (PST)
X-Gm-Message-State: AOJu0YwLQqcBnl63MDOsZr+lYIUsHCyIsowFKvdEF7rw5G3zQT7yjIlN
	ta+TOgwfxQK/UOsQdU6rahhWnhqaAFhzf5rRqzQ=
X-Google-Smtp-Source: AGHT+IF4v+0QJKdoI1SOpEoLmySnmpriMLsi5/V6hSoQs0SbaiBhcVUhHoc/dryAO3Jf5I0YUDlb3QOcS43z5rxlx4c=
X-Received: by 2002:a05:6870:55d4:b0:203:821e:1635 with SMTP id
 qk20-20020a05687055d400b00203821e1635mr4779009oac.18.1702924049941; Mon, 18
 Dec 2023 10:27:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108000749.GA3723879@dev-arch.thelio-3990X> <20231212171044.1108464-1-jtornosm@redhat.com>
In-Reply-To: <20231212171044.1108464-1-jtornosm@redhat.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 19 Dec 2023 03:26:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNATu-4TSSWpyFyVQYrkS++fUQbfp2tVjEpf3oZBV8ihq8w@mail.gmail.com>
Message-ID: <CAK7LNATu-4TSSWpyFyVQYrkS++fUQbfp2tVjEpf3oZBV8ihq8w@mail.gmail.com>
Subject: Re: [PATCH v2] rpm-pkg: simplify installkernel %post
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: nathan@kernel.org, dcavalca@meta.com, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 2:10=E2=80=AFAM Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> A new installkernel application is now included in systemd-udev package
> and it has been improved to allow simplifications.
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
> packages. So the easiest solution is to check the package that provides
> the installkernel application, and simplify (and fix for this
> application at the same time), only if the package is systemd-udev.
>
> cc: stable@vger.kernel.org
> Co-Developed-by: Davide Cavalca <dcavalca@meta.com>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> V1 -> V2:
> - Complete to be backward compatible with the previous installkernel
> application.
>




I do not think this is the right fix.

The root cause is, vmlinuz and System.map already exist
in the destination before running installkernel.

Fedora ships vmlinux, config, System.map in the module directory.
Why don't you mimic it?


Change the %install section to install them to
/lib/modules/%{KERNELRELEASE}/.


Then, change %post section to copy them to /boot/.



If you take care of an unusual case where installkernel
is not found, you can support manual copy as a fallback.

%post
if [ -x /sbin/installkernel ]; then
    /sbin/installkernel %{KERNELRELEASE} \
       /lib/modules/%{KERNELRELEASE}/vmlinuz \
       /lib/modules/%{KERNELRELEASE}/System.map
else
    cp /lib/modules/%{KERNELRELEASE}/vmlinuz /boot/vmlinuz-%{KERNELRELEAE}
    cp /lib/modules/%{KERNELRELEASE}/System.map /boot/System.map-%{KERNELRE=
LEAE}
    cp /lib/modules/%{KERNELRELEASE}/config /boot/config-%{KERNELRELEAE}
fi


The ugly shuffling will go away, and this should work for
both fedora 38 and 39.

Maybe, you can also convert the installkernel syntax to
kernel-install while you are here.











>  scripts/package/kernel.spec | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index 3eee0143e0c5..d4276ddb6645 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
> @@ -77,12 +77,16 @@ rm -rf %{buildroot}
>
>  %post
>  if [ -x /sbin/installkernel -a -r /boot/vmlinuz-%{KERNELRELEASE} -a -r /=
boot/System.map-%{KERNELRELEASE} ]; then
> +if [ $(rpm -qf /sbin/installkernel --queryformat "%{n}") =3D systemd-ude=
v ];then
> +/sbin/installkernel %{KERNELRELEASE} /boot/vmlinuz-%{KERNELRELEASE} /boo=
t/System.map-%{KERNELRELEASE}
> +else
>  cp /boot/vmlinuz-%{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm
>  cp /boot/System.map-%{KERNELRELEASE} /boot/.System.map-%{KERNELRELEASE}-=
rpm
>  rm -f /boot/vmlinuz-%{KERNELRELEASE} /boot/System.map-%{KERNELRELEASE}
>  /sbin/installkernel %{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm=
 /boot/.System.map-%{KERNELRELEASE}-rpm
>  rm -f /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELE=
ASE}-rpm
>  fi
> +fi
>
>  %preun
>  if [ -x /sbin/new-kernel-pkg ]; then
> --
> 2.43.0
>


--
Best Regards


Masahiro Yamada

