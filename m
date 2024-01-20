Return-Path: <linux-kernel+bounces-31930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A490083368D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27E68B21CB0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE66314F7C;
	Sat, 20 Jan 2024 21:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilwNI162"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C0014F73
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 21:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705787329; cv=none; b=aYv0o4ssg7qgwCvn0N+M1sCbCtfV7chCVCtUUcC5DTnMgEdDEjK7zne1oF1YsSUsUnZhYO3xYaH0roqNeNYSjVn4g3vzxTSbTaHLTZYjlSl23jZS4sGEk74u8j2BdxeydN3d4CvAH+qMmZHnjShgh3OSt/pL7TBPSm51Gi5NEc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705787329; c=relaxed/simple;
	bh=w1FzR7rXZDAG95Z4hhOQkThbbze/zcwVMYt1WGmSrk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LU1XaCFCSS+EFALdbWKYUCbNVN1abfmHLYpH8MawWvwEGESGCvY7SIeugV9fm98JnmhC8Up/ioterNhbStVxlzIN4OuKpYbFha6TTWFaP0G3TLUqdwmPAkQQTd/pHHV3HPH++XO4fztb1KWLss3D/Gx8TT15mGJuRTxYpY6kl0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilwNI162; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7913C433B2
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 21:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705787328;
	bh=w1FzR7rXZDAG95Z4hhOQkThbbze/zcwVMYt1WGmSrk0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ilwNI162FBpkwnKRHDOoUYOVHZfV77D3iZOoRj31PgMyJ1/Wg2bonK0B7XcAOL27w
	 nw0THXMEKmFPbyB1YSVxA59V6rjiE/c7/AJrOHxuelLHCzmKd2/9NMin3zz2Fm0RsH
	 +Pv9Timk/yW4qihHPVkZmiSsDBpqpJpsXWtqv7Fim7D+34d59PkrbmDyaVwivA70nI
	 KZDIEVAOGUwXiTe4wiQ8hzRrGpppffVQ0gNvSb3tK7anugV4VmH+1Ggg8F5qznKmJ/
	 Wuliwx9dK5qHHrfNtx373wRFO1JQLTmW7D2IxzUWj7zUh2U+aVxSLOfpK6Z0rVTWQN
	 59zYOhrwHDgZw==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5989d8decbfso1294160eaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 13:48:48 -0800 (PST)
X-Gm-Message-State: AOJu0YyuZOzB05fT15PCgIpJ9XIHjXe2fSqz0/sIQQiW4jUaOB1jO6eS
	U5/n+6sBBa3eiarla1JSHF/2shEDqm+ZRGlrI42FS7t7HYwDwoD2TfVL0rZU/Qy69qFmzHENliL
	JkIHht3T+paxl/G5EDiqqOsrgmJM=
X-Google-Smtp-Source: AGHT+IEx9PcXx/mfn28Guw9vSLfimEoqe9scEQf7uCCkYLu2lzRy4aA+upl+phU74jIfgxmU+HKxCxrMPVW5TFISuEU=
X-Received: by 2002:a05:6870:3309:b0:210:c8f8:2a43 with SMTP id
 x9-20020a056870330900b00210c8f82a43mr2032544oae.108.1705787328227; Sat, 20
 Jan 2024 13:48:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117125807.1058477-1-masahiroy@kernel.org>
In-Reply-To: <20231117125807.1058477-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 21 Jan 2024 06:48:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAStoCja1gnoFmsKikbzGZmKTcTu+Vc7v9zg8B9hwsH+iQ@mail.gmail.com>
Message-ID: <CAK7LNAStoCja1gnoFmsKikbzGZmKTcTu+Vc7v9zg8B9hwsH+iQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: compat_vdso: install compat_vdso.so.dbg to /lib/modules/*/vdso/
To: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 9:58=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> 'make vdso_install' installs debug vdso files to /lib/modules/*/vdso/.
>
> Only for the compat vdso on riscv, the installation destination differs;
> compat_vdso.so.dbg is installed to /lib/module/*/compat_vdso/.
>
> To follow the standard install destination and simplify the vdso_install
> logic, change the install destination to standard /lib/modules/*/vdso/.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---


Ping?
(in case "yet more RISC-V updates" happens)




>
>  arch/riscv/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index a74be78678eb..5cbe596345c1 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -146,7 +146,7 @@ endif
>  endif
>
>  vdso-install-y                 +=3D arch/riscv/kernel/vdso/vdso.so.dbg
> -vdso-install-$(CONFIG_COMPAT)  +=3D arch/riscv/kernel/compat_vdso/compat=
_vdso.so.dbg:../compat_vdso/compat_vdso.so
> +vdso-install-$(CONFIG_COMPAT)  +=3D arch/riscv/kernel/compat_vdso/compat=
_vdso.so.dbg
>
>  ifneq ($(CONFIG_XIP_KERNEL),y)
>  ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
> --
> 2.40.1
>


--=20
Best Regards
Masahiro Yamada

