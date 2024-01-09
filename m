Return-Path: <linux-kernel+bounces-20940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE758287A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC66D1F232EA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5A539AC8;
	Tue,  9 Jan 2024 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSiKu9sm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27E739851;
	Tue,  9 Jan 2024 14:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CA0C43390;
	Tue,  9 Jan 2024 14:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704808939;
	bh=ySGWGM6KAkW2Wvf68TJ4tX2XgT/a98DZvuxdIxEnpFg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QSiKu9smlPJRTZ5t2XfwSf201qynpyqIXrjx2VivuJqP+AxM9kA3+HMzIAv6H0Q7S
	 kkSsSg4uq+IzBGkq1BkauN/kmxjau2SUxLmvu91qLuxLpD9AY2NLpAbxSVuDtGtozt
	 DlxXZ92Qt/+2uafPOuXWTEYN95m3Bd6uRwCdBE206GrgqNHUuG5ex74X/tQlavj6nG
	 m1qGsGL0SVmX5Z+adZKVfi16ZfqA2hn847LFRPnU3GW5pNSe+7/+BOxbwv5QWrJvwJ
	 V4+LU3C2eKnRE9fZhQ1HV7SHD7Pf+pJFrEe9XOk04NocNe9bEaxXDvhTHw2FJTtzPs
	 z6PeZsLKUdp/A==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-204dfd7a89aso1387101fac.1;
        Tue, 09 Jan 2024 06:02:19 -0800 (PST)
X-Gm-Message-State: AOJu0YzFqwlDRlComlDnvKZSiBcBrLNJdW5EunJ6qGnyFtkKJHiEan7X
	iDmRUxmD51Bx/GOPHXDJWJkOYsXn5VJecRxJnHQ=
X-Google-Smtp-Source: AGHT+IFlTnlM5PnQAacW9Sy3tlgTzLI2sRSd9sbzVX2G3fIH3OgI3KNJpyEpr0ABbrCkSjtQP8yf/hVfXgpGMPs7EdA=
X-Received: by 2002:a05:6870:170e:b0:203:bb46:fb67 with SMTP id
 h14-20020a056870170e00b00203bb46fb67mr305930oae.43.1704808938423; Tue, 09 Jan
 2024 06:02:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org> <20231202035511.487946-3-sjg@chromium.org>
 <20231213121353.GA31326@willie-the-truck> <CAFLszTjfmSx1YMqzb2TsQf7sP4KrcQB=X7DY_HxRQp0J5HAppQ@mail.gmail.com>
In-Reply-To: <CAFLszTjfmSx1YMqzb2TsQf7sP4KrcQB=X7DY_HxRQp0J5HAppQ@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 9 Jan 2024 23:01:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQRCDC03e=TVO=k4FuD2a2RdTy7yLr3UptQjVCX7pM1CA@mail.gmail.com>
Message-ID: <CAK7LNAQRCDC03e=TVO=k4FuD2a2RdTy7yLr3UptQjVCX7pM1CA@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To: Simon Glass <sjg@chromium.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, U-Boot Mailing List <u-boot@lists.denx.de>, 
	Nicolas Schier <nicolas@fjasle.eu>, Tom Rini <trini@konsulko.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,


On Wed, Jan 3, 2024 at 8:47=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Masahiro,
>
> On Wed, Dec 13, 2023 at 5:14=E2=80=AFAM Will Deacon <will@kernel.org> wro=
te:
> >
> > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> > > Add a script which produces a Flat Image Tree (FIT), a single file
> > > containing the built kernel and associated devicetree files.
> > > Compression defaults to gzip which gives a good balance of size and
> > > performance.
> > >
> > > The files compress from about 86MB to 24MB using this approach.
> > >
> > > The FIT can be used by bootloaders which support it, such as U-Boot
> > > and Linuxboot. It permits automatic selection of the correct
> > > devicetree, matching the compatible string of the running board with
> > > the closest compatible string in the FIT. There is no need for
> > > filenames or other workarounds.
> > >
> > > Add a 'make image.fit' build target for arm64, as well. Use
> > > FIT_COMPRESSION to select a different algorithm.
> > >
> > > The FIT can be examined using 'dumpimage -l'.
> > >
> > > This features requires pylibfdt (use 'pip install libfdt'). It also
> > > requires compression utilities for the algorithm being used. Supporte=
d
> > > compression options are the same as the Image.xxx files. For now ther=
e
> > > is no way to change the compression other than by editing the rule fo=
r
> > > $(obj)/image.fit
> > >
> > > While FIT supports a ramdisk / initrd, no attempt is made to support
> > > this here, since it must be built separately from the Linux build.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v9:
> > > - Move the compression control into Makefile.lib
> > >
> > > Changes in v8:
> > > - Drop compatible string in FDT node
> > > - Correct sorting of MAINTAINERS to before ARM64 PORT
> > > - Turn compress part of the make_fit.py comment in to a sentence
> > > - Add two blank lines before parse_args() and setup_fit()
> > > - Use 'image.fit: dtbs' instead of BUILD_DTBS var
> > > - Use '$(<D)/dts' instead of '$(dir $<)dts'
> > > - Add 'mkimage' details Documentation/process/changes.rst
> > > - Allow changing the compression used
> > > - Tweak cover letter since there is only one clean-up patch
> > >
> > > Changes in v7:
> > > - Add Image as a dependency of image.fit
> > > - Drop kbuild tag
> > > - Add dependency on dtbs
> > > - Drop unnecessary path separator for dtbs
> > > - Rebase to -next
> > >
> > > Changes in v5:
> > > - Drop patch previously applied
> > > - Correct compression rule which was broken in v4
> > >
> > > Changes in v4:
> > > - Use single quotes for UIMAGE_NAME
> > >
> > > Changes in v3:
> > > - Drop temporary file image.itk
> > > - Drop patch 'Use double quotes for image name'
> > > - Drop double quotes in use of UIMAGE_NAME
> > > - Drop unnecessary CONFIG_EFI_ZBOOT condition for help
> > > - Avoid hard-coding "arm64" for the DT architecture
> > >
> > > Changes in v2:
> > > - Drop patch previously applied
> > > - Add .gitignore file
> > > - Move fit rule to Makefile.lib using an intermediate file
> > > - Drop dependency on CONFIG_EFI_ZBOOT
> > > - Pick up .dtb files separately from the kernel
> > > - Correct pylint too-many-args warning for write_kernel()
> > > - Include the kernel image in the file count
> > > - Add a pointer to the FIT spec and mention of its wide industry usag=
e
> > > - Mention the kernel version in the FIT description
> > >
> > >  Documentation/process/changes.rst |   9 +
> > >  MAINTAINERS                       |   7 +
> > >  arch/arm64/Makefile               |   7 +-
> > >  arch/arm64/boot/.gitignore        |   1 +
> > >  arch/arm64/boot/Makefile          |   6 +-
> > >  scripts/Makefile.lib              |  16 ++
> > >  scripts/make_fit.py               | 291 ++++++++++++++++++++++++++++=
++
> > >  7 files changed, 334 insertions(+), 3 deletions(-)
> > >  create mode 100755 scripts/make_fit.py
> >
> > I'll need Masahiro's Ack on the scripts/ changes before I can take this
> > one.
>
> Any thoughts on this request, please?
>
> Regards,
> Simon
>



As I mentioned before, I am concerned with having
the same "compatible" entries, with different contents,
as you use the "compatible" string as an ID to selecting
the target config node, right?





$ fdtdump  arch/arm64/boot/image.fit

        ...

        conf-10 {
            compatible =3D "tq,am642-tqma6442l-mbax4xxl",
"tq,am642-tqma6442l", "ti,am642";
            description =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier b=
oard";
            fdt =3D "fdt-10";
            kernel =3D "kernel";
        };

        ...

        conf-25 {
            compatible =3D "tq,am642-tqma6442l-mbax4xxl",
"tq,am642-tqma6442l", "ti,am642";
            description =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier b=
oard";
            fdt =3D "fdt-25";
            kernel =3D "kernel";
        };












--=20
Best Regards
Masahiro Yamada

