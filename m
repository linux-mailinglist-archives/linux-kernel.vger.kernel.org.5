Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0626812970
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443354AbjLNHeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbjLNHeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:34:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF40111
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:34:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D6AC433CC;
        Thu, 14 Dec 2023 07:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702539255;
        bh=0sJX63hk23OFUCPWAXphdE2kSZZfa5lWGWce7cbs/GA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uTwxK+Ca4TqHHzHH5wnc6B4C7Bo1qFHxy6q8FxW6v2gFQxgRaPvPwY3hzFXVOsmsi
         l4ILMD3Qh9W755sLOoJbSo1UgolZwZr8ztzlHkp13buZvOXKPWF6TApZgyuartauwP
         swqGjyOhc5Yg8W7Ie/MbvuZsuKnnZSZ4un8INECzVB57R60CWseHYqf5epFO9sKjrs
         yHPqY52VoC5eM25lADy9PXGuO5FPCKYPCfJWzOVR+/j7+C+d3rm02zlLYf4MdGh6bZ
         H+VIJybzHPWEjbjobpkvTvEv/OnU2AD5Ih5p2RmQCfqy4NornyruZ3mUB+a33skdb7
         T/QuwdlHlGowA==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6da2db096bcso149280a34.0;
        Wed, 13 Dec 2023 23:34:15 -0800 (PST)
X-Gm-Message-State: AOJu0Yxjp1jQLEF23JvR47vB4nXwLe1owvT4dymU+3tAvFIGgB6Wqp/x
        NC5ruIyFtkYBXwe/iu4KPaic8psZQ+ZyxWVBpMM=
X-Google-Smtp-Source: AGHT+IEMKnC6FlP9GRM63r+EHiC1p5vnRxH1XqjV7YGVctzAInZpA1YMwKlOfYOhwnCGD4xlWnFt7aMoiCFn0edAslc=
X-Received: by 2002:a05:6808:1491:b0:3b9:fabb:f66b with SMTP id
 e17-20020a056808149100b003b9fabbf66bmr3911157oiw.2.1702539255076; Wed, 13 Dec
 2023 23:34:15 -0800 (PST)
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org> <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com> <20231207142723.GA3187877@google.com>
 <20231207143814.GD15521@pendragon.ideasonboard.com> <CAGXv+5Go_0pEVAOLQmRCc_a9-YUtZEmBfXtMuBupX_nb9iqwbw@mail.gmail.com>
 <20231209152946.GC13421@pendragon.ideasonboard.com> <CAMuHMdVMZs6mnwWBgFwktO=8o=QzROv60cfZe085MhD6HxQjpQ@mail.gmail.com>
 <CAGXv+5Est3FL-XcEL-vB-6zVNas0mqb2cNYa==Yb7W2SQU9xVQ@mail.gmail.com> <CAK7LNATyD-PeNbaLTjJmU9=koqqE+V6QvFe09c2VrXopWvjpcw@mail.gmail.com>
In-Reply-To: <CAK7LNATyD-PeNbaLTjJmU9=koqqE+V6QvFe09c2VrXopWvjpcw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 14 Dec 2023 16:33:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR7Fm-1yaZmyH78vG5yNbbW2Avjj5F63u+aST6JQoMd5A@mail.gmail.com>
Message-ID: <CAK7LNAR7Fm-1yaZmyH78vG5yNbbW2Avjj5F63u+aST6JQoMd5A@mail.gmail.com>
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

On Thu, Dec 14, 2023 at 3:12=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, Dec 14, 2023 at 1:03=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org>=
 wrote:
> >
> > On Sun, Dec 10, 2023 at 1:31=E2=80=AFAM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > >
> > > Hi Laurent,
> > >
> > > On Sat, Dec 9, 2023 at 4:29=E2=80=AFPM Laurent Pinchart
> > > <laurent.pinchart@ideasonboard.com> wrote:
> > > > On Sat, Dec 09, 2023 at 10:13:59PM +0900, Chen-Yu Tsai wrote:
> > > > > On Thu, Dec 7, 2023 at 11:38=E2=80=AFPM Laurent Pinchart
> > > > > <laurent.pinchart@ideasonboard.com> wrote:
> > > > > > On Thu, Dec 07, 2023 at 10:27:23PM +0800, Chen-Yu Tsai wrote:
> > > > > > > On Sun, Dec 03, 2023 at 05:34:01PM +0200, Laurent Pinchart wr=
ote:
> > > > > > > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote=
:
> > > > > > > > > Add a script which produces a Flat Image Tree (FIT), a si=
ngle file
> > > > > > > > > containing the built kernel and associated devicetree fil=
es.
> > > > > > > > > Compression defaults to gzip which gives a good balance o=
f size and
> > > > > > > > > performance.
> > > > > > > > >
> > > > > > > > > The files compress from about 86MB to 24MB using this app=
roach.
> > > > > > > > >
> > > > > > > > > The FIT can be used by bootloaders which support it, such=
 as U-Boot
> > > > > > > > > and Linuxboot. It permits automatic selection of the corr=
ect
> > > > > > > > > devicetree, matching the compatible string of the running=
 board with
> > > > > > > > > the closest compatible string in the FIT. There is no nee=
d for
> > > > > > > > > filenames or other workarounds.
> > > > > > > > >
> > > > > > > > > Add a 'make image.fit' build target for arm64, as well. U=
se
> > > > > > > > > FIT_COMPRESSION to select a different algorithm.
> > > > > > > > >
> > > > > > > > > The FIT can be examined using 'dumpimage -l'.
> > > > > > > > >
> > > > > > > > > This features requires pylibfdt (use 'pip install libfdt'=
). It also
> > > > > > > > > requires compression utilities for the algorithm being us=
ed. Supported
> > > > > > > > > compression options are the same as the Image.xxx files. =
For now there
> > > > > > > > > is no way to change the compression other than by editing=
 the rule for
> > > > > > > > > $(obj)/image.fit
> > > > > > > > >
> > > > > > > > > While FIT supports a ramdisk / initrd, no attempt is made=
 to support
> > > > > > > > > this here, since it must be built separately from the Lin=
ux build.
> > > > > > > >
> > > > > > > > FIT images are very useful, so I think this is a very welco=
me addition
> > > > > > > > to the kernel build system. It can get tricky though: given=
 the
> > > > > > > > versatile nature of FIT images, there can't be any
> > > > > > > > one-size-fits-them-all solution to build them, and striking=
 the right
> > > > > > > > balance between what makes sense for the kernel and the fea=
tures that
> > > > > > > > users may request will probably lead to bikeshedding. As we=
 all love
> > > > > > > > bikeshedding, I thought I would start selfishly, with a per=
sonal use
> > > > > > > > case :-) This isn't a yak-shaving request though, I don't s=
ee any reason
> > > > > > > > to delay merging this series.
> > > > > > > >
> > > > > > > > Have you envisioned building FIT images with a subset of DT=
Bs, or adding
> > > > > > > > DTBOs ? Both would be fairly trivial extensions to this scr=
ipt by
> > > > > > > > extending the supported command line arguments. It would pe=
rhaps be more
> > > > > > > > difficult to integrate in the kernel build system though. T=
his leads me
> > > > > > > > to a second question: would you consider merging extensions=
 to this
> > > > > > > > script if they are not used by the kernel build system, but=
 meant for
> > > > > > > > users who manually invoke the script ? More generally, is t=
he script
> > > > > > >
> > > > > > > We'd also be interested in some customization, though in a di=
fferent way.
> > > > > > > We imagine having a rule file that says X compatible string s=
hould map
> > > > > > > to A base DTB, plus B and C DTBO for the configuration sectio=
n. The base
> > > > > > > DTB would carry all common elements of some device, while the=
 DTBOs
> > > > > > > carry all the possible second source components, like differe=
nt display
> > > > > > > panels or MIPI cameras for instance. This could drastically r=
educe the
> > > > > > > size of FIT images in ChromeOS by deduplicating all the commo=
n stuff.
> > > > > >
> > > > > > Do you envision the "mapping" compatible string mapping to a co=
nfig
> > > > > > section in the FIT image, that would bundle the base DTB and th=
e DTBOs ?
> > > > >
> > > > > That's exactly the idea. The mapping compatible string could be u=
ntied
> > > > > from the base board's compatible string if needed (which we proba=
bly do).
> > > > >
> > > > > So something like:
> > > > >
> > > > > config {
> > > > >     config-1 {
> > > > >         compatible =3D "google,krane-sku0";
> > > > >         fdt =3D "krane-baseboard", "krane-sku0-overlay";
> > > > >     };
> > > > > };
> > > > >
> > > > > With "krane-sku0-overlay" being an overlay that holds the differe=
nces
> > > > > between the SKUs, in this case the display panel and MIPI camera =
(not
> > > > > upstreamed) that applies to SKU0 in particular.
> > > >
> > > > The kernel DT makefiles already contain information on what overlay=
s to
> > > > apply to what base boards, in order to test the overlays and produc=
e
> > > > "full" DTBs. Maybe that information could be leveraged to create th=
e
> > > > configurations in the FIT image ?
> > >
> > > Although the "full" DTBs created may only be a subset of all possible
> > > combinations (I believe Rob just started with creating one "full" DTB
> > > for each overlay, cfr. the additions I made in commit a09c3e105a20858=
0
> > > ("arm64: dts: renesas: Apply overlays to base dtbs")), that could
> > > definitely be a start.
> > >
> > > Now, since the kernel build system already creates "full" DTBs, does
> > > that mean that all of the base DTBs, overlays, and "full" DTBs will
> > > end up in the FIT image?
> >
> > I suppose we could add an option to the packing tool to be able to _not=
_
> > add the "full" DTBs if they can also be assembled with a base DTB and
> > overlays. Think of it as a firmware compatibility option: if the firmwa=
re
> > supports overlays, then you almost always want the deconstructed parts,
> > not the fully assembled ones. Vice versa.
> >
> > If we don't we could end up with two configurations that have the same
> > compatible string?
>
>
> Right.
>
> We would end up with such situations because applying
> an overlay does not change the compatible string.
>
>
>
> With this code in arch/arm64/boot/dts/ti/Makefile:
>
> k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs :=3D \
>       k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.d=
tbo
> k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs :=3D \
>       k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-wlan.dtb=
o
>
>
>
>
> $ fdtdump  arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb
> 2>/dev/null| head -n15 | tail -n2
>     model =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier board";
>     compatible =3D "tq,am642-tqma6442l-mbax4xxl", "tq,am642-tqma6442l",
> "ti,am642";
>
>
> $ fdtdump  arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl-wlan.dtb
> 2>/dev/null| head -n15 | tail -n2
>     model =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier board";
>     compatible =3D "tq,am642-tqma6442l-mbax4xxl", "tq,am642-tqma6442l",
> "ti,am642";
>
>
>
>
>
> These two go into image.fit, but one of them is completely dead
> since there is no way to distinguish them.
>
>
> $ fdtdump  arch/arm64/boot/image.fit
>
>         ...
>
>         conf-10 {
>             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> "tq,am642-tqma6442l", "ti,am642";
>             description =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier=
 board";
>             fdt =3D "fdt-10";
>             kernel =3D "kernel";
>         };
>
>         ...
>
>         conf-25 {
>             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> "tq,am642-tqma6442l", "ti,am642";
>             description =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier=
 board";
>             fdt =3D "fdt-25";
>             kernel =3D "kernel";
>         };
>
>
>
>
>
> I agree with Chen-Yu.
>
> FIT should not include full DTBs.
>
> Bootloaders should assemble the final DTB
> from base and overlays on-the-fly.
>
>
> The FIT spec allows the "fdt" property to list
> multiple image nodes.
>
>
> o config-1
>  |- description =3D "configuration description"
>  |- kernel =3D "kernel sub-node unit name"
>  |- fdt =3D "fdt sub-node unit-name" [, "fdt overlay sub-node unit-name",=
 ...]
>  |- loadables =3D "loadables sub-node unit-name"
>  |- script =3D "
>  |- compatible =3D "vendor





This is a question for U-Boot (and barebox).




   images {
          base {
                ...
          };

          addon1 {
                ...
          };

          addon2 {
                ...
          };
    };

    configurations {
          ...
          fdt =3D "base", "addon1", "addon2";
    };




Is U-Boot's "bootm" command able to dynamically construct
the full DTB from "base" + "addon1" + "addon2"
and pass to the kernel?



When I used overlay from U-Boot command line last time,
I typed complicated commands, following this manual:
https://docs.u-boot.org/en/latest/usage/fdt_overlays.html




One more question to confirm if I can use this
for my practical use-cases.

Is U-Boot able to handle FIT (includes kernel + DTs)
and a separate initrd?

  # bootm  <fit-address>:<conf-name>  <ramdisk-address>


Presumably, it would be difficult to inject initramdisk
into image.fit later, so I am hoping bootm would work like that,
but I did not delve into U-Boot code.



If it works, is it possible to verify the integrity of initrd?
The kernel and DTs inside FIT will be verified, but not sure
if it is possible for ramdisk.





--=20
Best Regards
Masahiro Yamada
