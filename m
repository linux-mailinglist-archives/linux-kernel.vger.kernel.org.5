Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E548127C5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443134AbjLNGMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjLNGMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:12:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF5793
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:12:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEBFC433C9;
        Thu, 14 Dec 2023 06:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702534364;
        bh=9NH6UvRuHPOIXsOUHoQ27tZM1UxiQVD/81UJjq3YJcE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cp7dDSj7oz67U+z+fuND7kfCs1jRX/kt4P3jkG+6s/ZVOK5zfvFHeDrvpHe/aHUy2
         4yByhA1m5sF9OEBaMqn+hSfzJXsK7u8C82W46YLkqQVi/NZKmWkrQ/aCvTn53OOf2R
         O9UnzooawWCoJ9sLjTcBUTB9yvZghA5lDCD3kqKckj2lGrBkUxqdIRfEleUlgerUjs
         o4fjqmAzrXLlHtNvRw57Tr0m4aVlwFFbWcOirbxOlyrhJJb+t0XBR8jA4FE9ro1Ln0
         QbImQD7eFSd9AUnIimI221AqfA81YzBQofUUEVUob+YOnGsE3OcnMdeKl9P51FSFwt
         ncQ/VBNWXtpTg==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5916c6b2e0fso487982eaf.3;
        Wed, 13 Dec 2023 22:12:44 -0800 (PST)
X-Gm-Message-State: AOJu0Yy//SuOU9R4vuQPS2QHjIRAFFrU4GwIRtDsCl/LP2VLsL4+e4UT
        uKwNrjl4d04kUeRYq3WMt1bKtOA2ZeQZk3OjqMw=
X-Google-Smtp-Source: AGHT+IGrH+7gE85pMbdS3yJ5VwFOon33FHA9Ev6L1OetzcgFJ6FSnUh+EQV7d37elY/QW/TmYWuhp6QnA5I+ZJAOYVA=
X-Received: by 2002:a05:687c:2246:b0:203:27d1:e164 with SMTP id
 yu6-20020a05687c224600b0020327d1e164mr2324708oab.12.1702534364022; Wed, 13
 Dec 2023 22:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org> <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com> <20231207142723.GA3187877@google.com>
 <20231207143814.GD15521@pendragon.ideasonboard.com> <CAGXv+5Go_0pEVAOLQmRCc_a9-YUtZEmBfXtMuBupX_nb9iqwbw@mail.gmail.com>
 <20231209152946.GC13421@pendragon.ideasonboard.com> <CAMuHMdVMZs6mnwWBgFwktO=8o=QzROv60cfZe085MhD6HxQjpQ@mail.gmail.com>
 <CAGXv+5Est3FL-XcEL-vB-6zVNas0mqb2cNYa==Yb7W2SQU9xVQ@mail.gmail.com>
In-Reply-To: <CAGXv+5Est3FL-XcEL-vB-6zVNas0mqb2cNYa==Yb7W2SQU9xVQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 14 Dec 2023 15:12:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNATyD-PeNbaLTjJmU9=koqqE+V6QvFe09c2VrXopWvjpcw@mail.gmail.com>
Message-ID: <CAK7LNATyD-PeNbaLTjJmU9=koqqE+V6QvFe09c2VrXopWvjpcw@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Glass <sjg@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
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
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 1:03=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> On Sun, Dec 10, 2023 at 1:31=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> >
> > Hi Laurent,
> >
> > On Sat, Dec 9, 2023 at 4:29=E2=80=AFPM Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com> wrote:
> > > On Sat, Dec 09, 2023 at 10:13:59PM +0900, Chen-Yu Tsai wrote:
> > > > On Thu, Dec 7, 2023 at 11:38=E2=80=AFPM Laurent Pinchart
> > > > <laurent.pinchart@ideasonboard.com> wrote:
> > > > > On Thu, Dec 07, 2023 at 10:27:23PM +0800, Chen-Yu Tsai wrote:
> > > > > > On Sun, Dec 03, 2023 at 05:34:01PM +0200, Laurent Pinchart wrot=
e:
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
. Supported
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
> > > > > > >
> > > > > > > FIT images are very useful, so I think this is a very welcome=
 addition
> > > > > > > to the kernel build system. It can get tricky though: given t=
he
> > > > > > > versatile nature of FIT images, there can't be any
> > > > > > > one-size-fits-them-all solution to build them, and striking t=
he right
> > > > > > > balance between what makes sense for the kernel and the featu=
res that
> > > > > > > users may request will probably lead to bikeshedding. As we a=
ll love
> > > > > > > bikeshedding, I thought I would start selfishly, with a perso=
nal use
> > > > > > > case :-) This isn't a yak-shaving request though, I don't see=
 any reason
> > > > > > > to delay merging this series.
> > > > > > >
> > > > > > > Have you envisioned building FIT images with a subset of DTBs=
, or adding
> > > > > > > DTBOs ? Both would be fairly trivial extensions to this scrip=
t by
> > > > > > > extending the supported command line arguments. It would perh=
aps be more
> > > > > > > difficult to integrate in the kernel build system though. Thi=
s leads me
> > > > > > > to a second question: would you consider merging extensions t=
o this
> > > > > > > script if they are not used by the kernel build system, but m=
eant for
> > > > > > > users who manually invoke the script ? More generally, is the=
 script
> > > > > >
> > > > > > We'd also be interested in some customization, though in a diff=
erent way.
> > > > > > We imagine having a rule file that says X compatible string sho=
uld map
> > > > > > to A base DTB, plus B and C DTBO for the configuration section.=
 The base
> > > > > > DTB would carry all common elements of some device, while the D=
TBOs
> > > > > > carry all the possible second source components, like different=
 display
> > > > > > panels or MIPI cameras for instance. This could drastically red=
uce the
> > > > > > size of FIT images in ChromeOS by deduplicating all the common =
stuff.
> > > > >
> > > > > Do you envision the "mapping" compatible string mapping to a conf=
ig
> > > > > section in the FIT image, that would bundle the base DTB and the =
DTBOs ?
> > > >
> > > > That's exactly the idea. The mapping compatible string could be unt=
ied
> > > > from the base board's compatible string if needed (which we probabl=
y do).
> > > >
> > > > So something like:
> > > >
> > > > config {
> > > >     config-1 {
> > > >         compatible =3D "google,krane-sku0";
> > > >         fdt =3D "krane-baseboard", "krane-sku0-overlay";
> > > >     };
> > > > };
> > > >
> > > > With "krane-sku0-overlay" being an overlay that holds the differenc=
es
> > > > between the SKUs, in this case the display panel and MIPI camera (n=
ot
> > > > upstreamed) that applies to SKU0 in particular.
> > >
> > > The kernel DT makefiles already contain information on what overlays =
to
> > > apply to what base boards, in order to test the overlays and produce
> > > "full" DTBs. Maybe that information could be leveraged to create the
> > > configurations in the FIT image ?
> >
> > Although the "full" DTBs created may only be a subset of all possible
> > combinations (I believe Rob just started with creating one "full" DTB
> > for each overlay, cfr. the additions I made in commit a09c3e105a208580
> > ("arm64: dts: renesas: Apply overlays to base dtbs")), that could
> > definitely be a start.
> >
> > Now, since the kernel build system already creates "full" DTBs, does
> > that mean that all of the base DTBs, overlays, and "full" DTBs will
> > end up in the FIT image?
>
> I suppose we could add an option to the packing tool to be able to _not_
> add the "full" DTBs if they can also be assembled with a base DTB and
> overlays. Think of it as a firmware compatibility option: if the firmware
> supports overlays, then you almost always want the deconstructed parts,
> not the fully assembled ones. Vice versa.
>
> If we don't we could end up with two configurations that have the same
> compatible string?


Right.

We would end up with such situations because applying
an overlay does not change the compatible string.



With this code in arch/arm64/boot/dts/ti/Makefile:

k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs :=3D \
      k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtb=
o
k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs :=3D \
      k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo




$ fdtdump  arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb
2>/dev/null| head -n15 | tail -n2
    model =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier board";
    compatible =3D "tq,am642-tqma6442l-mbax4xxl", "tq,am642-tqma6442l",
"ti,am642";


$ fdtdump  arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl-wlan.dtb
2>/dev/null| head -n15 | tail -n2
    model =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier board";
    compatible =3D "tq,am642-tqma6442l-mbax4xxl", "tq,am642-tqma6442l",
"ti,am642";





These two go into image.fit, but one of them is completely dead
since there is no way to distinguish them.


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





I agree with Chen-Yu.

FIT should not include full DTBs.

Bootloaders should assemble the final DTB
from base and overlays on-the-fly.


The FIT spec allows the "fdt" property to list
multiple image nodes.


o config-1
 |- description =3D "configuration description"
 |- kernel =3D "kernel sub-node unit name"
 |- fdt =3D "fdt sub-node unit-name" [, "fdt overlay sub-node unit-name", .=
..]
 |- loadables =3D "loadables sub-node unit-name"
 |- script =3D "
 |- compatible =3D "vendor











>
> ChenYu
>
>
> > Gr{oetje,eeting}s,
> >
> >                         Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker=
. But
> > when I'm talking to journalists I just say "programmer" or something li=
ke that.
> >                                 -- Linus Torvalds



--
Best Regards
Masahiro Yamada
