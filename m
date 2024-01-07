Return-Path: <linux-kernel+bounces-18847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C778263EC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 12:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1BC1C20B9C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 11:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6CC12E49;
	Sun,  7 Jan 2024 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpMl/DAp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D980812E43;
	Sun,  7 Jan 2024 11:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68363C433CB;
	Sun,  7 Jan 2024 11:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704627658;
	bh=KQJUCEC7wnTKCIo50Pged7pb30CnSsqMSPKxkjd8bV8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jpMl/DApy9BflKzi/bigEcrcHyqTABTsL2n2Skq287wk0/NRw8HGW7HRCuMx5My2C
	 RuM8Sp37+3FLZeysf6m8O0nBrZ/YR/zAZaBntzAXbjxgLv8iW2+SA55XfcEWKGlwYd
	 rA3g4A94YULCjM0Oc17KQIpzIlG+XQjOa603IIyUTD3rDw3DTqEUjoMDb6P9woV2xn
	 fJNPx0beXH7B1obp9ur0QUQ4Ie4/D+d1BwWaBbNLGnph7tBXUR/WoPTzORueBLmWrv
	 r/NbzGtQNg6oZ/vcYacu1LCH4Og0uVZkrqHJPUuJqiuLFqSZuaaGkOakjVhWKS5fEv
	 3Q5GhenWVjdjA==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbd6e37af4so1072428b6e.1;
        Sun, 07 Jan 2024 03:40:58 -0800 (PST)
X-Gm-Message-State: AOJu0YxOZGD057PI6NNRhs3coD84EvYsBj869hka5wzAmf6UcPO6Pnpe
	p45fnj13kprwK+N6HgOO7cO32UZHEWOBkWFh7dk=
X-Google-Smtp-Source: AGHT+IFFrzGJgGnlrrI4ZRi8Ec3xtEL3bM945qmS5f4mAGwC42G6tiP05ogTLF7dempm+ERA4cDea3TXpn4t+eIPQ4k=
X-Received: by 2002:a05:6871:5226:b0:204:6141:746a with SMTP id
 ht38-20020a056871522600b002046141746amr2306962oac.2.1704627657681; Sun, 07
 Jan 2024 03:40:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704353568.git.kevinmbecause@gmail.com> <941a566eb114701685dc44f708f81891b3bd085b.1704353568.git.kevinmbecause@gmail.com>
In-Reply-To: <941a566eb114701685dc44f708f81891b3bd085b.1704353568.git.kevinmbecause@gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 7 Jan 2024 20:40:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQe3xpJwOBzKEhTPSV4sL1kjU7dHn8-wfvxCFHRXBpxQQ@mail.gmail.com>
Message-ID: <CAK7LNAQe3xpJwOBzKEhTPSV4sL1kjU7dHn8-wfvxCFHRXBpxQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kbuild: Enable decompression for use by EXTRA_FIRMWARE
To: Kevin Martin <kevinmbecause@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 3:11=E2=80=AFPM Kevin Martin <kevinmbecause@gmail.co=
m> wrote:
>
> The build system can currently only compress files. This patch adds the
> functionality to decompress files. Decompression is needed for building
> firmware files into the kernel if those files are compressed on the
> filesystem. Compressed firmware files are in use by Gentoo, Fedora, Arch,
> and others.
>
> Signed-off-by: Kevin Martin <kevinmbecause@gmail.com>
> ---
> Changes in v2:
> - Skipped running 'cat' and now just pass the file names directly.
> - Added '--quiet' since 'zstd' started printing the status of each file
> now that it knows the file names.
>


Acked-by: Masahiro Yamada <masahiroy@kernel.org>



>  scripts/Makefile.lib | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 1a965fe68..d043be3dc 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -523,6 +523,9 @@ quiet_cmd_xzkern_with_size =3D XZKERN  $@
>  quiet_cmd_xzmisc =3D XZMISC  $@
>        cmd_xzmisc =3D cat $(real-prereqs) | $(XZ) --check=3Dcrc32 --lzma2=
=3Ddict=3D1MiB > $@
>
> +quiet_cmd_xzdec =3D XZDEC   $@
> +      cmd_xzdec =3D $(XZ) --decompress --stdout $< > $@
> +
>  # ZSTD
>  # ----------------------------------------------------------------------=
-----
>  # Appends the uncompressed size of the data using size_append. The .zst
> @@ -548,6 +551,9 @@ quiet_cmd_zstd22 =3D ZSTD22  $@
>  quiet_cmd_zstd22_with_size =3D ZSTD22  $@
>        cmd_zstd22_with_size =3D { cat $(real-prereqs) | $(ZSTD) -22 --ult=
ra; $(size_append); } > $@
>
> +quiet_cmd_zstddec =3D ZSTDDEC $@
> +      cmd_zstddec =3D $(ZSTD) --decompress --force --quiet -o $@ $<
> +
>  # ASM offsets
>  # ----------------------------------------------------------------------=
-----
>
> --
> 2.41.0
>


--=20
Best Regards
Masahiro Yamada

