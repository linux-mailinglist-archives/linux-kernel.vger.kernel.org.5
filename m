Return-Path: <linux-kernel+bounces-27285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F6B82ED4B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D61028569B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888431A599;
	Tue, 16 Jan 2024 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2kyqoKz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89EF1A58B;
	Tue, 16 Jan 2024 11:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D2AC433C7;
	Tue, 16 Jan 2024 11:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705402865;
	bh=VhwDL3RVVRvjZm9EKpeTMkUVJ50Ng4cKI1vqO1YAXs0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b2kyqoKzlVYBmMLSk/cso/xPCijzR4O/K2pp43h7eBoVGitzw4lVg/JBSuKS9jdmt
	 p7JThLZ5dakHKCUgqkpRlNjHLzDrHxH+Hwp13CWNtPB/8SbWbVWa1me2BosbhWM3Pi
	 s97s2laKsL0gZwzhXD7R0XI0qETI2lOiufCJa5JQCo98NJx8QoBj6QCCPcXGWXOK0E
	 ydabhHbwRIh47yH28+ADtdSQocSFvuRIKyNPsYxFNrybL3BmuxAg0dwuzt9wkyc3fU
	 aDh8LI3odnIUh6a4bBrNKRNMSSez8wqC9ZuS9KVuRUrEh70rOui+2vNdyOU6T4Vdyq
	 N8r+B/qq37dKA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-204520717b3so6729721fac.0;
        Tue, 16 Jan 2024 03:01:05 -0800 (PST)
X-Gm-Message-State: AOJu0YyNlvDitihsp6pZQi5zmUyu5hdC2FW83NVZm43INIwWIiQSmOZh
	cOSRKppLnS0Xrv5Rt52Rrnn0BZ/oWcCbWmrCv6M=
X-Google-Smtp-Source: AGHT+IEL8EwdMmde1vrN7fySBHukjD+Uf77eyaDclUxHmyrFBPfrCsC8Xff+PWhu506xnlRr4IYmPKh1lewDV7uw1Ow=
X-Received: by 2002:a05:6870:c085:b0:205:6728:92c5 with SMTP id
 c5-20020a056870c08500b00205672892c5mr9527038oad.3.1705402864710; Tue, 16 Jan
 2024 03:01:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115001606.15477-1-richard.weiyang@gmail.com>
In-Reply-To: <20240115001606.15477-1-richard.weiyang@gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 16 Jan 2024 20:00:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNATtqFOOdG0niydTecrf2u9TZG7wFhM7Mq6jy0nOfhVwAg@mail.gmail.com>
Message-ID: <CAK7LNATtqFOOdG0niydTecrf2u9TZG7wFhM7Mq6jy0nOfhVwAg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: take vmlinux.[ao] out of single-targets
To: Wei Yang <richard.weiyang@gmail.com>
Cc: nathan@kernel.org, nicolas@fjasle.eu, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 9:17=E2=80=AFAM Wei Yang <richard.weiyang@gmail.com=
> wrote:
>
> For current kernel, when we make vmlinux.a or vmlinux.o, following
> message would display.
>
> $make vmlinux.o
> /dir/to/kernel/Makefile:1887: warning: overriding recipe for target 'vmli=
nux.o'
> /dir/to/kernel/Makefile:1138: warning: ignoring old recipe for target 'vm=
linux.o'
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
> make[2]: Nothing to be done for 'vmlinux.o'.
>
> The reason is vmlinux.[ao] is treated as single target, while the rule
> is written in root Makefile.
>
> This patch fixes this by take them out of single-targets.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Masahiro Yamada <masahiroy@kernel.org>
> CC: Miguel Ojeda <ojeda@kernel.org>
> CC: Nathan Chancellor <nathan@kernel.org>
> ---


Not all targets can be built by the single-target.

Just do not do "make vmlinux.o".









>  Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index f1b2fd977275..66fb08f6d971 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -280,6 +280,7 @@ no-dot-config-targets :=3D $(clean-targets) \
>  no-sync-config-targets :=3D $(no-dot-config-targets) %install modules_si=
gn kernelrelease \
>                           image_name
>  single-targets :=3D %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.rsi %.s %.=
symtypes %/
> +no-single-targets :=3D vmlinux.o vmlinux.a
>
>  config-build   :=3D
>  mixed-build    :=3D
> @@ -315,11 +316,14 @@ ifeq ($(KBUILD_EXTMOD),)
>  endif
>
>  # We cannot build single targets and the others at the same time
> -ifneq ($(filter $(single-targets), $(MAKECMDGOALS)),)
> +ifneq ($(filter-out $(no-single-targets), $(filter $(single-targets), $(=
MAKECMDGOALS))),)
>         single-build :=3D 1
>         ifneq ($(filter-out $(single-targets), $(MAKECMDGOALS)),)
>                 mixed-build :=3D 1
>         endif
> +       ifneq ($(filter $(no-single-targets), $(MAKECMDGOALS)),)
> +               mixed-build :=3D 1
> +       endif
>  endif
>
>  # For "make -j clean all", "make -j mrproper defconfig all", etc.
> --
> 2.34.1
>


--=20
Best Regards
Masahiro Yamada

