Return-Path: <linux-kernel+bounces-16755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF92824360
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2D5286EF7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C512D224E5;
	Thu,  4 Jan 2024 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoim6jWi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12775225AF;
	Thu,  4 Jan 2024 14:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE15C433C7;
	Thu,  4 Jan 2024 14:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704377618;
	bh=5vBZUdnVGG54e1EEHK8EIcIM6ks58SMSIsV6NIeU8EM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eoim6jWidQUlAKXMoFo2AKkzo0fTFyfpgISn6i7YGiWDfDr1P53cADXJ7H03Vj18B
	 3qQePXmFX9Bgary2Aaqzz05x+fgtWEEFZw+L16y/H3Gh6b4U1d9kYevBwt8hapFq48
	 mRA5QfJZxLT6mtbKWsnV0xuWr/Ae5tp9o/3t8LKVYkxbTAONv0vlKceaFClFYIvrPm
	 6hX7e95gFqf6fHa4Sy0Nos6OiDadnb4hsN+idkz6dpDLOup/1sB7sUHk4y+9D3Tt6g
	 fX8Do4Z/rcR5cQVkDvBpAXU1IpZQoBBojIGC4WKGxfyR9GZMsWTWSvXzrPZ9pu1s+p
	 RFJaJ7SFRd0vQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-204301f2934so291209fac.1;
        Thu, 04 Jan 2024 06:13:38 -0800 (PST)
X-Gm-Message-State: AOJu0Yw7BVYdWbJ7BZ3SCL2kxxYrm82Z7hUCrnBBd1QYqucn2uawe49j
	wNSoHPPI1OvPVV4yUuLhfuBaHeote3ai9N2H1R8=
X-Google-Smtp-Source: AGHT+IEYIyc45VILFYGKdvn3cy03LLuf6ZCG1ABtaafRtjq37IrcYXoPs5dEMs7aJd4hnoKhAUGHWChoMz4iE37O8mA=
X-Received: by 2002:a05:6870:9720:b0:203:2b71:dad5 with SMTP id
 n32-20020a056870972000b002032b71dad5mr709423oaq.8.1704377617843; Thu, 04 Jan
 2024 06:13:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703042081.git.kevinmbecause@gmail.com> <941a566eb114701685dc44f708f81891b3bd085b.1703042082.git.kevinmbecause@gmail.com>
 <CAK7LNAQX+h-a3yBEOqXG2_7mw+6bS5NmJ=UYAEt=oghQvi4W2Q@mail.gmail.com> <d5989a0b-f46f-fb49-8d44-1822d69bc4cf@gmail.com>
In-Reply-To: <d5989a0b-f46f-fb49-8d44-1822d69bc4cf@gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 4 Jan 2024 23:13:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT1SbgvqjP5p8ZbACZ4prhP8LVdenWBNisdh15f_Dk9LQ@mail.gmail.com>
Message-ID: <CAK7LNAT1SbgvqjP5p8ZbACZ4prhP8LVdenWBNisdh15f_Dk9LQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: Enable decompression for use by
 EXTRA_FIRMWARE The build system can currently only compress files. This patch
 adds the functionality to decompress files. Decompression is needed for
 building firmware files into the kernel if those files are compressed on the
 filesystem. Compressed firmware files are in use by Gentoo, Fedora, Arch, and others.
To: Kevin Martin <kevinmbecause@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 4:04=E2=80=AFPM Kevin Martin <kevinmbecause@gmail.co=
m> wrote:
>
>
> On Wed, 3 Jan 2024, Masahiro Yamada wrote:
>
> > On Wed, Dec 20, 2023 at 7:26=E2=80=AFPM Kevin Martin <kevinmbecause@gma=
il.com> wrote:
> > >
> > > Signed-off-by: Kevin Martin <kevinmbecause@gmail.com>
> > > ---
> > >  scripts/Makefile.lib | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > index 1a965fe68..d043be3dc 100644
> > > --- a/scripts/Makefile.lib
> > > +++ b/scripts/Makefile.lib
> > > @@ -523,6 +523,9 @@ quiet_cmd_xzkern_with_size =3D XZKERN  $@
> > >  quiet_cmd_xzmisc =3D XZMISC  $@
> > >        cmd_xzmisc =3D cat $(real-prereqs) | $(XZ) --check=3Dcrc32 --l=
zma2=3Ddict=3D1MiB > $@
> > >
> > > +quiet_cmd_xzdec =3D XZDEC   $@
> > > +      cmd_xzdec =3D cat $(real-prereqs) | $(XZ) --decompress > $@
> > > +
> >
> >
> >
> > Please do not fork the meaningless 'cat' process.
> >
> > This should be a single process to take just one input file.
> >
> >     cmd_xzdec =3D $(XZ) --decompress --stdout $< > $@
> >
> >
> >
> >
> > Commit d3dd3b5a29bb9582957451531fed461628dfc834
> > was a very bad commit.
> >
> > The 'cat' and compression/decompression must be
> > separate rules.
> >
> > We should not repeat the mistake in the past.
> >
>
> Would it be preferable to change all of the compression rules or just the
> new decompression rules?


I do not require you to change the existing code.

For decompression, it is unlikely that the recipe
takes multiple input files.
So, 'cat' is unneeded.




> I could change just the new ones and then begin working on a different
> patch to clean up the 'cat' processes in the compression rules.



If you get rid of the 'cat', you need to refactor the user code.
arch/x86/boot/compressed/Makefile relies on 'cat' and 'compress',
but please double-check no other Makefile uses it.


Also, you might need some research about the potential
impact onto the reproducible builds.
Without 'cat |', the compressed archive might encode
the timestamp of the original file.
GZIP records the timestamp in the header.




>
> >
> >
> > >  # ZSTD
> > >  # ------------------------------------------------------------------=
---------
> > >  # Appends the uncompressed size of the data using size_append. The .=
zst
> > > @@ -548,6 +551,9 @@ quiet_cmd_zstd22 =3D ZSTD22  $@
> > >  quiet_cmd_zstd22_with_size =3D ZSTD22  $@
> > >        cmd_zstd22_with_size =3D { cat $(real-prereqs) | $(ZSTD) -22 -=
-ultra; $(size_append); } > $@
> > >
> > > +quiet_cmd_zstddec =3D ZSTDDEC $@
> > > +      cmd_zstddec =3D cat $(real-prereqs) | $(ZSTD) --decompress > $=
@
> > > +
> >
> >
> > Same here.
> > Please make this a single process:
> >
> >    cmd_zstddec =3D $(ZSTD) --decompress --force --output=3D$@ $<
> >
> >
> >
> >
> >
> >
> > One small concern in the future is, if we end up with adding
> > quiet_cmd_bzip2dec, we will run out of the 7-column of the short log.
> >
> >  quiet_cmd_bzip2dec =3D BZIP2DEC$@
> >
> > We can increase the column size if needed, so I do not think
> > it is a big issue.
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > >  # ASM offsets
> > >  # ------------------------------------------------------------------=
---------
> > >
> > > --
> > > 2.41.0
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
> >



--=20
Best Regards
Masahiro Yamada

