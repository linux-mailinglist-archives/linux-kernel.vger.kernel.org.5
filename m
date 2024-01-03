Return-Path: <linux-kernel+bounces-15484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D71822C97
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562E51C231EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF0019458;
	Wed,  3 Jan 2024 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p927EiUJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EED199D4;
	Wed,  3 Jan 2024 12:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FD0C433C7;
	Wed,  3 Jan 2024 12:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704283266;
	bh=o2dAs2OCmFquqklmdlyVNlYXJ9T6CR2vVomexr9kU0Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p927EiUJR51MIAoJ5s8qXCCflJvFLdKtfxCtG1neOOekGrfMpsE65djxDp36XKwEu
	 PS1hxnkgYbP5LWFizMhnDvNuHUtEeMp/pUuLCK+1KFWagUqF6QodfxKmw2Wkvo07vx
	 nK9zg+ItOeVyzc4IRdB2LEws+Un2q4Q+KkrGItsk5z7W/aegNI3R72XQ7crx42d5gE
	 1+rYAFq3yiTVmvpklopqW7OWZF8ADC95winYaIx2BfATmgKltTPD5t/5TJsO3MSW7c
	 Kr25+WKAJQBwNyFjyCaaIvhzSyhMZEknahc9uAoz9u9tet/oweCGbEax122j5ECd3Z
	 x4DizpZek0dJg==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6dbb7d80df8so7046411a34.1;
        Wed, 03 Jan 2024 04:01:06 -0800 (PST)
X-Gm-Message-State: AOJu0YxV+bWm9ByVSxrgmiH32xeydjolAvwGioFo3q802wCOrm2ojzXb
	HlHTPdJecediu9oLV++9xVpQRhMmh2hhskZVsUU=
X-Google-Smtp-Source: AGHT+IGl1DxhuEmn0KdPY/JObJacHMgMVyZn8R/DQcgzxIBZXxrllEtDZNDBj05y1YJn4JoiV2aCgeH5190xaqi/WAQ=
X-Received: by 2002:a05:6870:15c2:b0:203:e8e:b384 with SMTP id
 k2-20020a05687015c200b002030e8eb384mr22777819oad.85.1704283266120; Wed, 03
 Jan 2024 04:01:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703042081.git.kevinmbecause@gmail.com> <941a566eb114701685dc44f708f81891b3bd085b.1703042082.git.kevinmbecause@gmail.com>
In-Reply-To: <941a566eb114701685dc44f708f81891b3bd085b.1703042082.git.kevinmbecause@gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 3 Jan 2024 21:00:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQX+h-a3yBEOqXG2_7mw+6bS5NmJ=UYAEt=oghQvi4W2Q@mail.gmail.com>
Message-ID: <CAK7LNAQX+h-a3yBEOqXG2_7mw+6bS5NmJ=UYAEt=oghQvi4W2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: Enable decompression for use by
 EXTRA_FIRMWARE The build system can currently only compress files. This patch
 adds the functionality to decompress files. Decompression is needed for
 building firmware files into the kernel if those files are compressed on the
 filesystem. Compressed firmware files are in use by Gentoo, Fedora, Arch, and others.
To: Kevin Martin <kevinmbecause@gmail.com>
Cc: joeyzerocrash@protonmail.com, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 7:26=E2=80=AFPM Kevin Martin <kevinmbecause@gmail.c=
om> wrote:
>
> Signed-off-by: Kevin Martin <kevinmbecause@gmail.com>
> ---
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
> +      cmd_xzdec =3D cat $(real-prereqs) | $(XZ) --decompress > $@
> +



Please do not fork the meaningless 'cat' process.

This should be a single process to take just one input file.

    cmd_xzdec =3D $(XZ) --decompress --stdout $< > $@




Commit d3dd3b5a29bb9582957451531fed461628dfc834
was a very bad commit.

The 'cat' and compression/decompression must be
separate rules.

We should not repeat the mistake in the past.



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
> +      cmd_zstddec =3D cat $(real-prereqs) | $(ZSTD) --decompress > $@
> +


Same here.
Please make this a single process:

   cmd_zstddec =3D $(ZSTD) --decompress --force --output=3D$@ $<






One small concern in the future is, if we end up with adding
quiet_cmd_bzip2dec, we will run out of the 7-column of the short log.

 quiet_cmd_bzip2dec =3D BZIP2DEC$@

We can increase the column size if needed, so I do not think
it is a big issue.










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

