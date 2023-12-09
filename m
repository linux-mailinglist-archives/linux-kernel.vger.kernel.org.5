Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9344D80B489
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 14:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjLINOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 08:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLINOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 08:14:09 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288B313A
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 05:14:13 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ca0715f0faso40050151fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 05:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702127651; x=1702732451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAnV5/VTJKO+oXGb78o4eRSh3GZ7EBZgVLaL6KtYl8o=;
        b=KXAPKAVAc7wNlN5y2GrIBSNRaMkgKppLh4IRUh4onAQGpPBkV9FbAkZfkt8b1tz/Ty
         THon9jcecnDyGQS4mZQnZiGXd3ZZjoMJOnX4ZRTAmN4e+Py1vRIyzAVib/g0hgaMoeOP
         /bptrp2dcSKiX3K5Mgo+itzxLU9YhXwUnKLgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702127651; x=1702732451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAnV5/VTJKO+oXGb78o4eRSh3GZ7EBZgVLaL6KtYl8o=;
        b=JAczMayQHeD2xu8jRT37tgi1uIZkZR0k/wkYLCGForLwD6LeuJLykhCB+ybltq3qHV
         w7x02ScYWP2a7XqhFiTEU85QFllCxI2I4/cRulpOjN06Cz9H0RUo9xF7ehHzK2FPVqPp
         9odf3boLR0J0OUP/XkhrzHkWLOHHYeT/N7njBfS+KIwsg76M2UmWsCfvotnTgGvNTQHG
         ez57hRU/byU0dOK8nYgKoNEooMn2arNEH6pme8mXuQ+CtBvt6tFpBBvnjLrxZ4W2gLGN
         W0Xvx4y5i5AAR2gmQCjcu1rpoOhBRVxq82r80a+Sd3yw4j0FGVeKgu0CCaIfoA5d53JX
         Htbg==
X-Gm-Message-State: AOJu0YyMGXK9tBYDG80Y26LEhV7o7nIrwbRnF3vz8fN+EjhKNa8w7f6G
        CX+20s1kBaj3K8kNUY0fUBMnr4OAuYvG0mDCyU5Xxw==
X-Google-Smtp-Source: AGHT+IGeCP4QFN7ZgQJeFnN7faugEryNKJ80Nvg0QuCcVgGBL3GaaL9QrMygC+jl/dS1Ke3ms4zU355E0zK8lA+JEz0=
X-Received: by 2002:ac2:4acf:0:b0:50b:f8d8:b176 with SMTP id
 m15-20020ac24acf000000b0050bf8d8b176mr648422lfp.124.1702127651029; Sat, 09
 Dec 2023 05:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org> <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com> <20231207142723.GA3187877@google.com>
 <20231207143814.GD15521@pendragon.ideasonboard.com>
In-Reply-To: <20231207143814.GD15521@pendragon.ideasonboard.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Sat, 9 Dec 2023 22:13:59 +0900
Message-ID: <CAGXv+5Go_0pEVAOLQmRCc_a9-YUtZEmBfXtMuBupX_nb9iqwbw@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Simon Glass <sjg@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Tom Rini <trini@konsulko.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 11:38=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Thu, Dec 07, 2023 at 10:27:23PM +0800, Chen-Yu Tsai wrote:
> > On Sun, Dec 03, 2023 at 05:34:01PM +0200, Laurent Pinchart wrote:
> > > Hi Simon,
> > >
> > > Thank you for the patch.
> > >
> > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> > > > Add a script which produces a Flat Image Tree (FIT), a single file
> > > > containing the built kernel and associated devicetree files.
> > > > Compression defaults to gzip which gives a good balance of size and
> > > > performance.
> > > >
> > > > The files compress from about 86MB to 24MB using this approach.
> > > >
> > > > The FIT can be used by bootloaders which support it, such as U-Boot
> > > > and Linuxboot. It permits automatic selection of the correct
> > > > devicetree, matching the compatible string of the running board wit=
h
> > > > the closest compatible string in the FIT. There is no need for
> > > > filenames or other workarounds.
> > > >
> > > > Add a 'make image.fit' build target for arm64, as well. Use
> > > > FIT_COMPRESSION to select a different algorithm.
> > > >
> > > > The FIT can be examined using 'dumpimage -l'.
> > > >
> > > > This features requires pylibfdt (use 'pip install libfdt'). It also
> > > > requires compression utilities for the algorithm being used. Suppor=
ted
> > > > compression options are the same as the Image.xxx files. For now th=
ere
> > > > is no way to change the compression other than by editing the rule =
for
> > > > $(obj)/image.fit
> > > >
> > > > While FIT supports a ramdisk / initrd, no attempt is made to suppor=
t
> > > > this here, since it must be built separately from the Linux build.
> > >
> > > FIT images are very useful, so I think this is a very welcome additio=
n
> > > to the kernel build system. It can get tricky though: given the
> > > versatile nature of FIT images, there can't be any
> > > one-size-fits-them-all solution to build them, and striking the right
> > > balance between what makes sense for the kernel and the features that
> > > users may request will probably lead to bikeshedding. As we all love
> > > bikeshedding, I thought I would start selfishly, with a personal use
> > > case :-) This isn't a yak-shaving request though, I don't see any rea=
son
> > > to delay merging this series.
> > >
> > > Have you envisioned building FIT images with a subset of DTBs, or add=
ing
> > > DTBOs ? Both would be fairly trivial extensions to this script by
> > > extending the supported command line arguments. It would perhaps be m=
ore
> > > difficult to integrate in the kernel build system though. This leads =
me
> > > to a second question: would you consider merging extensions to this
> > > script if they are not used by the kernel build system, but meant for
> > > users who manually invoke the script ? More generally, is the script
> >
> > We'd also be interested in some customization, though in a different wa=
y.
> > We imagine having a rule file that says X compatible string should map
> > to A base DTB, plus B and C DTBO for the configuration section. The bas=
e
> > DTB would carry all common elements of some device, while the DTBOs
> > carry all the possible second source components, like different display
> > panels or MIPI cameras for instance. This could drastically reduce the
> > size of FIT images in ChromeOS by deduplicating all the common stuff.
>
> Do you envision the "mapping" compatible string mapping to a config
> section in the FIT image, that would bundle the base DTB and the DTBOs ?

That's exactly the idea. The mapping compatible string could be untied
from the base board's compatible string if needed (which we probably do).

So something like:

config {
    config-1 {
        compatible =3D "google,krane-sku0";
        fdt =3D "krane-baseboard", "krane-sku0-overlay";
    };
};

With "krane-sku0-overlay" being an overlay that holds the differences
between the SKUs, in this case the display panel and MIPI camera (not
upstreamed) that applies to SKU0 in particular.

Sorry for not giving a more concrete idea.


ChenYu

> > > meant to be used stand-alone as well, in which case its command line
> > > arguments need to remain backward-compatible, or do you see it as bei=
ng
> > > internal to the kernel ?
> >
> > [...]
> >
> > ChenYu
>
> --
> Regards,
>
> Laurent Pinchart
