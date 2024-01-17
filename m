Return-Path: <linux-kernel+bounces-28427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7712C82FE68
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D08B28896E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D92017D9;
	Wed, 17 Jan 2024 01:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuewKqV4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AFD10E9;
	Wed, 17 Jan 2024 01:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705455161; cv=none; b=RE7RnPxq+p4Mo7PHOJMf7lV4GSQUDUNeuBqu1zqXdHKWUen13XVUCJm71lXZvLhndcsgDgYvJxecB40UkkJEP+NsjLcSeF2tGSYIr4g/pGYWOLcTM6MQaGT+zGHY/zk7pTRW/9jfF4Li1DJoi4XpBZgf1LF/S1akqBmFGPz5C2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705455161; c=relaxed/simple;
	bh=KMX42xQoye46HN6psn1ykOIXRqnr81MlkGw6l8j7zxM=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=TOnpkVEjd9lf8k6JDbOstNXgWmpDeWM7kdPn2Qc66K7cv2M6CW0cev8+F+4bTEaL0HgW8no6oijVItz6b4P+j51edqMIGEp7dfWUCozCLWVSCEOEeVeJosCBX+pM1uRnHdo8wgRC1bc81nP+Rkh7QjmT0+d5Y8DQQ20+lVzPWaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuewKqV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEBBC43390;
	Wed, 17 Jan 2024 01:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705455160;
	bh=KMX42xQoye46HN6psn1ykOIXRqnr81MlkGw6l8j7zxM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TuewKqV46VERoEtL7fYhO9Jij+yXWN+6IO0fKL6PilJK2R9jZDzdnyqmzwL/4SZOh
	 kzJBQDxEYv0myNHGxtJasVdXJdOvhDWbZ53CjRIwTUrA4jSNNZt1RTfAn7JSE1Rm//
	 4S2fFSKukYwymSoBcy3USqitypB4U7I7bE0kMdTjD5Hvs3iS3dzo6Zw5oW863nwsIf
	 xFrkknBv5uZhzJtBb+FMBPJ3/IW+cfFwGLSWX7CBzS3RdFkKNYyFNZtnu7WpOBEEDr
	 7o1iP98QdAwxlX6Uz9mPVDo5lM/p27S4kATXeI7dDmMhWkGEWxbR88+lF7BaqYsKtI
	 GuYd9iQqFk37A==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bd6d5f2076so1956469b6e.0;
        Tue, 16 Jan 2024 17:32:40 -0800 (PST)
X-Gm-Message-State: AOJu0YzN9bJ8zyAhgWIbJV6CtqFfXUlCi2zuoOLCGnvsuI9IOC+GlOFi
	uK0E9Gy4IoNhZZmtr1Bprbous9BbSrxUYBBYf3s=
X-Google-Smtp-Source: AGHT+IFPjadK4xTxOjertdYKtFOgeChQA0W2GZ02GgRcYG1WxXdwamk/BKQjC0CrgQciiM3NgTd/LvJTxiKj/0MeFeY=
X-Received: by 2002:a05:6871:e406:b0:206:79a3:ce0b with SMTP id
 py6-20020a056871e40600b0020679a3ce0bmr8631528oac.8.1705455160295; Tue, 16 Jan
 2024 17:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNAR_wgQBs-q9NH1icb_FPBoVMNEhQpvV8qzH2dFsrDS0pQ@mail.gmail.com>
 <20240114080711.5109-1-jtornosm@redhat.com>
In-Reply-To: <20240114080711.5109-1-jtornosm@redhat.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 17 Jan 2024 10:32:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNARX==sMKVTGXutGMmMkfg1idGUYLhBLZvKZ0psdwmiUvQ@mail.gmail.com>
Message-ID: <CAK7LNARX==sMKVTGXutGMmMkfg1idGUYLhBLZvKZ0psdwmiUvQ@mail.gmail.com>
Subject: Re: [PATCH V5 2/2] rpm-pkg: avoid install/remove the running kernel
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: dcavalca@meta.com, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nathan@kernel.org, ndesaulniers@google.com, 
	nicolas@fjasle.eu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2024 at 5:07=E2=80=AFPM Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> Normally, upper tools and scripts are checking if we want to modify the
> running kernel but not always. Check install and remove operation that
> affect the running kernel to avoid possible issues.
>
> Tested with Fedora 38, Fedora 39, RHEL 9, Oracle Linux 9.3,
> openSUSE Tumbleweed and openMandrive ROME, using dnf/zypper and rpm tools=
.
>
> cc: stable@vger.kernel.org
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>  scripts/package/kernel.spec | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index 74542af8cbfe..216514cbf5f6 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
> @@ -69,6 +69,12 @@ ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}=
/lib/modules/%{KERNELRELEA
>  %clean
>  rm -rf %{buildroot}
>
> +%pre
> +if [ $(uname -r) =3D=3D %{KERNELRELEASE} ];then
> +echo "same kernel release is running" > /dev/stderr


What is the problem with this?






> +exit 1
> +fi
> +
>  %post
>  if [ -x /usr/bin/kernel-install ]; then
>  /usr/bin/kernel-install add %{KERNELRELEASE} /lib/modules/%{KERNELRELEAS=
E}/vmlinuz
> @@ -85,6 +91,10 @@ fi
>  done
>
>  %preun
> +if [ $(uname -r) =3D=3D %{KERNELRELEASE} ];then
> +echo "same kernel release is running" > /dev/stderr
> +exit 1
> +fi
>  if [ -x /sbin/new-kernel-pkg ]; then
>  new-kernel-pkg --remove %{KERNELRELEASE} --rminitrd --initrdfile=3D/boot=
/initramfs-%{KERNELRELEASE}.img
>  elif [ -x /usr/bin/kernel-install ]; then
> --
> 2.43.0
>
>


--=20
Best Regards
Masahiro Yamada

