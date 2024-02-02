Return-Path: <linux-kernel+bounces-50092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C76F847418
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F6B1C22EE6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521FC148FEE;
	Fri,  2 Feb 2024 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RUreNNTC"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652801482E3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889673; cv=none; b=EClKNvv9erw0/SwLpd7v5IBSfexltUWku2OwCbqNNg+P+jEEtzxIj0H25+3Tdr5gXVHlhrNDUHNJ4LCrQ6/jnUr5M5WA5/NJ/Mr2534s+LlUCAKjz6Rrbody4RnKGKIRvZGHKk9w1SzXutPm93B6hP85DyuVguk2BWd+8WaHwM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889673; c=relaxed/simple;
	bh=KuN876f57JsaySOWS9+9L785PXShwmedFiw9mxkee68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bn8bbdch/0of4TszGdOWSaxptK87rOK9ZwBxtypxfhOgxlwiWRhvlOlYQf91BHqoOe/AGrh9DvCO9zmQz63ekOYIcW8LdPiZE9u7SMuaJ7KsP6rnzPat8/kuiaiyj5jz9LMS/C+WoYCEvgLufC61LeoMmsTa3kHD3PSMeRXuLsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RUreNNTC; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-21920f89441so398623fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 08:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706889670; x=1707494470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWOWYYEAxtKEbCbBz7L28/OQ2XY0i2cVeG9NC/yetZM=;
        b=RUreNNTC8k+8+a1BjaZ5a2hQhJcTZGMkFtCCyAGbNbzooboxz8RfyTnKdJx3oFHJx6
         QZNrqzOGaEhhi287TWQNz2KNGgomQapz+Mapjl3H2lzVWXLrFPZBS+OV7FcWgklsFvrM
         Ug79iwywDpGIe+q+wsrwtDzqdbwPTDc49GMe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706889670; x=1707494470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWOWYYEAxtKEbCbBz7L28/OQ2XY0i2cVeG9NC/yetZM=;
        b=Gc0VaU+WmEv2iX0uRV3x92cG9Y4FrE9sUkc7dAfAL5EC9szaGbTMiYUL3xscVhF5bK
         cKZTgxoT7yGqyUWmFfpq9zAg6JjGFJ0KTiXq4pwXKcw4XEhRXagSbcaMrMLNjftyODp6
         8sJLcgJjPke1jR9ePbWMV6+aNygjMLBU27Z0NDR9EKSGqjpXvco+a8eZy5sheLGk24fQ
         gyoOoMGZL4KIReGiIqlmEU/39mTIiGx++kpc5E2KO2UoWZ0OhhpeWVfzSFB8gGz9llmg
         Dv80gDNzelOxBoXjWEyp/mGB3sBLtUGAHLB0ts7yovm3U0fzgI3aFYcy3zkYD/5jR7zt
         YsFw==
X-Gm-Message-State: AOJu0Yyy0NX+iKjtfCkRBFR7vBv4bbORxbwbvI9U2gh7oSi0jb3rtb62
	XTcbSsxvKVkZoWcwLnQNWU4TXVpzJpNmnZRJ2YI96vj+vEYDKNrxcIiPnnAPrV8OTKElax2NyC0
	zA+XiqariNlK9VDDaPYBlsDtcKydwe6wwYJ8C
X-Google-Smtp-Source: AGHT+IGkfsdQlA+htwDeD7zH3WjVhxGzYd3xt2y1hGo9/Xb3yR38PfLF0lt60z2VvCERYfrrO1dHkdBi+J+oKwjqgVQ=
X-Received: by 2002:a05:6870:d10c:b0:219:4033:a21c with SMTP id
 e12-20020a056870d10c00b002194033a21cmr98007oac.33.1706889668519; Fri, 02 Feb
 2024 08:01:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org> <20231202035511.487946-3-sjg@chromium.org>
 <20231213121353.GA31326@willie-the-truck> <CAFLszTjfmSx1YMqzb2TsQf7sP4KrcQB=X7DY_HxRQp0J5HAppQ@mail.gmail.com>
 <CAK7LNAQRCDC03e=TVO=k4FuD2a2RdTy7yLr3UptQjVCX7pM1CA@mail.gmail.com>
 <20240109143349.GR1610741@bill-the-cat> <CAFLszTjwhy24UiT6kUJABMC1Xn0h9Q1q9fYpZZJg9DX8Vss9cA@mail.gmail.com>
 <CAFLszTjPAHd6RdO1mvatXC=yRS+h=sgJ_pMdyEnkROTx7yRpog@mail.gmail.com> <CAK7LNARsY6-rrx=sNFq6oFqpqf0s5S_=3DrUsCOS7zF0BXcoTg@mail.gmail.com>
In-Reply-To: <CAK7LNARsY6-rrx=sNFq6oFqpqf0s5S_=3DrUsCOS7zF0BXcoTg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 2 Feb 2024 09:00:57 -0700
Message-ID: <CAFLszTgYMrj2AhYdAXBjGACQjehvVBnJ2EsKg2TO7c50Dp_ukQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
	U-Boot Mailing List <u-boot@lists.denx.de>, Nicolas Schier <nicolas@fjasle.eu>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	workflows@vger.kernel.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Tue, 30 Jan 2024 at 02:16, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, Jan 26, 2024 at 1:04=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi,
> >
> > On Wed, 17 Jan 2024 at 06:14, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Masahiro, Tom,
> > >
> > > On Tue, 9 Jan 2024 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Jan 09, 2024 at 11:01:42PM +0900, Masahiro Yamada wrote:
> > > > > Hi Simon,
> > > > >
> > > > >
> > > > > On Wed, Jan 3, 2024 at 8:47=E2=80=AFAM Simon Glass <sjg@chromium.=
org> wrote:
> > > > > >
> > > > > > Hi Masahiro,
> > > > > >
> > > > > > On Wed, Dec 13, 2023 at 5:14=E2=80=AFAM Will Deacon <will@kerne=
l.org> wrote:
> > > > > > >
> > > > > > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> > > > > > > > Add a script which produces a Flat Image Tree (FIT), a sing=
le file
> > > > > > > > containing the built kernel and associated devicetree files=
.
> > > > > > > > Compression defaults to gzip which gives a good balance of =
size and
> > > > > > > > performance.
> > > > > > > >
> > > > > > > > The files compress from about 86MB to 24MB using this appro=
ach.
> > > > > > > >
> > > > > > > > The FIT can be used by bootloaders which support it, such a=
s U-Boot
> > > > > > > > and Linuxboot. It permits automatic selection of the correc=
t
> > > > > > > > devicetree, matching the compatible string of the running b=
oard with
> > > > > > > > the closest compatible string in the FIT. There is no need =
for
> > > > > > > > filenames or other workarounds.
> > > > > > > >
> > > > > > > > Add a 'make image.fit' build target for arm64, as well. Use
> > > > > > > > FIT_COMPRESSION to select a different algorithm.
> > > > > > > >
> > > > > > > > The FIT can be examined using 'dumpimage -l'.
> > > > > > > >
> > > > > > > > This features requires pylibfdt (use 'pip install libfdt').=
 It also
> > > > > > > > requires compression utilities for the algorithm being used=
 Supported
> > > > > > > > compression options are the same as the Image.xxx files. Fo=
r now there
> > > > > > > > is no way to change the compression other than by editing t=
he rule for
> > > > > > > > $(obj)/image.fit
> > > > > > > >
> > > > > > > > While FIT supports a ramdisk / initrd, no attempt is made t=
o support
> > > > > > > > this here, since it must be built separately from the Linux=
 build.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Changes in v9:
> > > > > > > > - Move the compression control into Makefile.lib
> > > > > > > >
> > > > > > > > Changes in v8:
> > > > > > > > - Drop compatible string in FDT node
> > > > > > > > - Correct sorting of MAINTAINERS to before ARM64 PORT
> > > > > > > > - Turn compress part of the make_fit.py comment in to a sen=
tence
> > > > > > > > - Add two blank lines before parse_args() and setup_fit()
> > > > > > > > - Use 'image.fit: dtbs' instead of BUILD_DTBS var
> > > > > > > > - Use '$(<D)/dts' instead of '$(dir $<)dts'
> > > > > > > > - Add 'mkimage' details Documentation/process/changes.rst
> > > > > > > > - Allow changing the compression used
> > > > > > > > - Tweak cover letter since there is only one clean-up patch
> > > > > > > >
> > > > > > > > Changes in v7:
> > > > > > > > - Add Image as a dependency of image.fit
> > > > > > > > - Drop kbuild tag
> > > > > > > > - Add dependency on dtbs
> > > > > > > > - Drop unnecessary path separator for dtbs
> > > > > > > > - Rebase to -next
> > > > > > > >
> > > > > > > > Changes in v5:
> > > > > > > > - Drop patch previously applied
> > > > > > > > - Correct compression rule which was broken in v4
> > > > > > > >
> > > > > > > > Changes in v4:
> > > > > > > > - Use single quotes for UIMAGE_NAME
> > > > > > > >
> > > > > > > > Changes in v3:
> > > > > > > > - Drop temporary file image.itk
> > > > > > > > - Drop patch 'Use double quotes for image name'
> > > > > > > > - Drop double quotes in use of UIMAGE_NAME
> > > > > > > > - Drop unnecessary CONFIG_EFI_ZBOOT condition for help
> > > > > > > > - Avoid hard-coding "arm64" for the DT architecture
> > > > > > > >
> > > > > > > > Changes in v2:
> > > > > > > > - Drop patch previously applied
> > > > > > > > - Add .gitignore file
> > > > > > > > - Move fit rule to Makefile.lib using an intermediate file
> > > > > > > > - Drop dependency on CONFIG_EFI_ZBOOT
> > > > > > > > - Pick up .dtb files separately from the kernel
> > > > > > > > - Correct pylint too-many-args warning for write_kernel()
> > > > > > > > - Include the kernel image in the file count
> > > > > > > > - Add a pointer to the FIT spec and mention of its wide ind=
ustry usage
> > > > > > > > - Mention the kernel version in the FIT description
> > > > > > > >
> > > > > > > >  Documentation/process/changes.rst |   9 +
> > > > > > > >  MAINTAINERS                       |   7 +
> > > > > > > >  arch/arm64/Makefile               |   7 +-
> > > > > > > >  arch/arm64/boot/.gitignore        |   1 +
> > > > > > > >  arch/arm64/boot/Makefile          |   6 +-
> > > > > > > >  scripts/Makefile.lib              |  16 ++
> > > > > > > >  scripts/make_fit.py               | 291 ++++++++++++++++++=
++++++++++++
> > > > > > > >  7 files changed, 334 insertions(+), 3 deletions(-)
> > > > > > > >  create mode 100755 scripts/make_fit.py
> > > > > > >
> > > > > > > I'll need Masahiro's Ack on the scripts/ changes before I can=
 take this
> > > > > > > one.
> > > > > >
> > > > > > Any thoughts on this request, please?
> > > > > >
> > > > > > Regards,
> > > > > > Simon
> > > > > >
> > > > >
> > > > >
> > > > >
> > > > > As I mentioned before, I am concerned with having
> > > > > the same "compatible" entries, with different contents,
> > > > > as you use the "compatible" string as an ID to selecting
> > > > > the target config node, right?
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > $ fdtdump  arch/arm64/boot/image.fit
> > > > >
> > > > >         ...
> > > > >
> > > > >         conf-10 {
> > > > >             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> > > > > "tq,am642-tqma6442l", "ti,am642";
> > > > >             description =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL=
 carrier board";
> > > > >             fdt =3D "fdt-10";
> > > > >             kernel =3D "kernel";
> > > > >         };
> > > > >
> > > > >         ...
> > > > >
> > > > >         conf-25 {
> > > > >             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> > > > > "tq,am642-tqma6442l", "ti,am642";
> > > > >             description =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL=
 carrier board";
> > > > >             fdt =3D "fdt-25";
> > > > >             kernel =3D "kernel";
> > > > >         };
> > > >
> > > > I had asked Rob a while ago about if having the same compatible for=
 two
> > > > functionally different machines is a feature, or a bug, and I don't
> > > > think either of us fully agreed either way. I'd be leaning towards
> > > > saying the above example is a bug in the dts files, it's just not b=
een a
> > > > bug people have worried about before due to (sadly) how little the
> > > > top-level compatible has been used.
> > >
> > > Yes I believe this is a bug in the files.
> > >
> > > What should the script do in this case? Print a warning, perhaps?
> >
> > Is there anything I should do here? Would a warning be helpful, or
> > just confusing?
>
>
>
> I do not think it is useful.
> You would almost always get a warning, and there is no way to fix it.
>
>
>
> With arm64 defconfig, image.fit will include a thousand DTBs.
>
>
> The config node of my board was listed 214th.
> (I found it by fdtdump)
>
>
> Then, I learned
>
>   >  bootm  ${loadaddr}#conf-214
>
> is the correct command to boot my board.
>
>
> Of course, the "214" will be different in the future.
>
> The node names, conf-*, are useless.
>
>
>
> Only the useful way is to enable CONFIG_FIT_BEST_MATCH in U-Boot,
> but this relies on the uniqueness of a compatible string,
> which is not true.

See my other email, but I think this is a problem we should fix.

>
> (I do not know how to do it in barebox)
>
>
>
>
>
> I think using the file name as a config node
> mitigates the issue because a file name is
> considered unique.
>
>
> For example, with composite DTBs:
>
> imx8mm-venice-gw72xx-0x-imx219-dtbs :=3D imx8mm-venice-gw72xx-0x.dtb
> imx8mm-venice-gw72xx-0x-imx219.dtbo
> imx8mm-venice-gw72xx-0x-rpidsi-dtbs :=3D imx8mm-venice-gw72xx-0x.dtb
> imx8mm-venice-gw72xx-0x-rpidsi.dtbo
>
>
>
>
> configurations {
>       imx8mm-venice-gw72xx-0x-imx219 {
>             ...
>       };
>
>       imx8mm-venice-gw72xx-0x-rpidsi {
>             ...
>       }
> };
>
>
>
> Then, we can distinguish them by node, even if they have
> the same compatible string.
> At least we can do
>
>   > bootm  ${loadaddr}#imx8mm-venice-gw72xx-0x-imx219
>
>

Sure, but the goal with FIT is to be able to boot with the correct dtb
automatically. What you have above would require some sort of boot
script, or some other information about the configuration-node name.

>
>
> For the issue including stale DTBs, you can use my patch:
> [PATCH 1/4] kbuild: create a list of all built DTB files
> (https://lore.kernel.org/linux-kbuild/CAK7LNASOxi-gzve+_d-sCW9z_eEJ5TMMnz=
PEvN2Nj2AwgVjF9g@mail.gmail.com/T/#ma3595627a96a04554a78cbbd22056831e13db26=
0)
>
>
> You can change scripts/make_fit.py to take
> the DTB files instead of the directory to search.
>
> Optionally, you can support '@' syntax to
> take command arguments from a file.
>
>
> scripts/make_fit.py ... @arch/$(SRCARCH)/boot/dts/dtbs-list

Thank you for doing that. I will take a look and send v10.

>
>
>
>
>
>
> For the separate base and overlays support,
> you can use my patch as a base:
> [PATCH 3/4] kbuild: create a list of base and overlays for each DTB
> (https://lore.kernel.org/linux-kbuild/CAK7LNASOxi-gzve+_d-sCW9z_eEJ5TMMnz=
PEvN2Nj2AwgVjF9g@mail.gmail.com/T/#m32c5bdde9098901b7c7776b932827493a05c82d=
5)
>
>
>
>
>
> Lastly, you do not need to require mkimage for
> args.external.
> You can simply concatenate files.

Yes, that's true. Do you think there is a problem with using mkimage?

Regards,
Simon

