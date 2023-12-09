Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8302E80B53C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 17:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjLIQbN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 9 Dec 2023 11:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLIQbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 11:31:11 -0500
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73E710C9;
        Sat,  9 Dec 2023 08:31:17 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5d7a47d06eeso29556207b3.1;
        Sat, 09 Dec 2023 08:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702139476; x=1702744276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U39lWSDPg+0DYbB9pP+NhpXAadyQEt+SNRQFJQQg5DE=;
        b=SWAPg+ezyWdqecaewoMy9cQguXOMP+wRs8Is7or8KioI8A1PLvfTyl/EF8T5oNKyhY
         QabSqAQ8kw+Z+dsS7K1X4unlrWBuxjMy+356CnHQkKjjGo632sia4AaJv7yxH4QJWCgS
         D8Btzevk6iTud0qnxOH8T9yASK4floNUJ32ldPGNSkbZCLw6qngKc1lydyukeo+taarJ
         QHenrQ/ZfiXDnp/MsHNtwuOJcMeU00Umb5OnmXrpVfXme8AgMm6AHctiDwaYzLupG6hD
         QFUwA1YaNp2yHBuVpYuDWSfNmzwUbzOj48BbYX5wxTPJwFpTPzYhNcSAnnJYDW73Aawa
         bWfQ==
X-Gm-Message-State: AOJu0YwmXmdmmT6GviOT9em08FxncfHJ6ZPVB0XY5hRwmQlafRdVtHai
        0QahJDmMJlT8/SLkFjhHQWVPB3cvSVzGlA==
X-Google-Smtp-Source: AGHT+IFCdTqPpW2deVlJtEIVu7QcKsVC/gaEBTMSTQWA9zTTAMilp89UddZ/G2KBs6zu8xkFAI10Aw==
X-Received: by 2002:a81:6555:0:b0:5cb:6131:280a with SMTP id z82-20020a816555000000b005cb6131280amr1470716ywb.0.1702139476632;
        Sat, 09 Dec 2023 08:31:16 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id v82-20020a814855000000b005d427fea43bsm1579173ywa.48.2023.12.09.08.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 08:31:16 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5cbcfdeaff3so29706567b3.0;
        Sat, 09 Dec 2023 08:31:15 -0800 (PST)
X-Received: by 2002:a0d:dd53:0:b0:5d1:1bab:5902 with SMTP id
 g80-20020a0ddd53000000b005d11bab5902mr1316761ywe.15.1702139474962; Sat, 09
 Dec 2023 08:31:14 -0800 (PST)
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org> <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com> <20231207142723.GA3187877@google.com>
 <20231207143814.GD15521@pendragon.ideasonboard.com> <CAGXv+5Go_0pEVAOLQmRCc_a9-YUtZEmBfXtMuBupX_nb9iqwbw@mail.gmail.com>
 <20231209152946.GC13421@pendragon.ideasonboard.com>
In-Reply-To: <20231209152946.GC13421@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 9 Dec 2023 17:31:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVMZs6mnwWBgFwktO=8o=QzROv60cfZe085MhD6HxQjpQ@mail.gmail.com>
Message-ID: <CAMuHMdVMZs6mnwWBgFwktO=8o=QzROv60cfZe085MhD6HxQjpQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, Simon Glass <sjg@chromium.org>,
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Sat, Dec 9, 2023 at 4:29 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Sat, Dec 09, 2023 at 10:13:59PM +0900, Chen-Yu Tsai wrote:
> > On Thu, Dec 7, 2023 at 11:38 PM Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com> wrote:
> > > On Thu, Dec 07, 2023 at 10:27:23PM +0800, Chen-Yu Tsai wrote:
> > > > On Sun, Dec 03, 2023 at 05:34:01PM +0200, Laurent Pinchart wrote:
> > > > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> > > > > > Add a script which produces a Flat Image Tree (FIT), a single file
> > > > > > containing the built kernel and associated devicetree files.
> > > > > > Compression defaults to gzip which gives a good balance of size and
> > > > > > performance.
> > > > > >
> > > > > > The files compress from about 86MB to 24MB using this approach.
> > > > > >
> > > > > > The FIT can be used by bootloaders which support it, such as U-Boot
> > > > > > and Linuxboot. It permits automatic selection of the correct
> > > > > > devicetree, matching the compatible string of the running board with
> > > > > > the closest compatible string in the FIT. There is no need for
> > > > > > filenames or other workarounds.
> > > > > >
> > > > > > Add a 'make image.fit' build target for arm64, as well. Use
> > > > > > FIT_COMPRESSION to select a different algorithm.
> > > > > >
> > > > > > The FIT can be examined using 'dumpimage -l'.
> > > > > >
> > > > > > This features requires pylibfdt (use 'pip install libfdt'). It also
> > > > > > requires compression utilities for the algorithm being used. Supported
> > > > > > compression options are the same as the Image.xxx files. For now there
> > > > > > is no way to change the compression other than by editing the rule for
> > > > > > $(obj)/image.fit
> > > > > >
> > > > > > While FIT supports a ramdisk / initrd, no attempt is made to support
> > > > > > this here, since it must be built separately from the Linux build.
> > > > >
> > > > > FIT images are very useful, so I think this is a very welcome addition
> > > > > to the kernel build system. It can get tricky though: given the
> > > > > versatile nature of FIT images, there can't be any
> > > > > one-size-fits-them-all solution to build them, and striking the right
> > > > > balance between what makes sense for the kernel and the features that
> > > > > users may request will probably lead to bikeshedding. As we all love
> > > > > bikeshedding, I thought I would start selfishly, with a personal use
> > > > > case :-) This isn't a yak-shaving request though, I don't see any reason
> > > > > to delay merging this series.
> > > > >
> > > > > Have you envisioned building FIT images with a subset of DTBs, or adding
> > > > > DTBOs ? Both would be fairly trivial extensions to this script by
> > > > > extending the supported command line arguments. It would perhaps be more
> > > > > difficult to integrate in the kernel build system though. This leads me
> > > > > to a second question: would you consider merging extensions to this
> > > > > script if they are not used by the kernel build system, but meant for
> > > > > users who manually invoke the script ? More generally, is the script
> > > >
> > > > We'd also be interested in some customization, though in a different way.
> > > > We imagine having a rule file that says X compatible string should map
> > > > to A base DTB, plus B and C DTBO for the configuration section. The base
> > > > DTB would carry all common elements of some device, while the DTBOs
> > > > carry all the possible second source components, like different display
> > > > panels or MIPI cameras for instance. This could drastically reduce the
> > > > size of FIT images in ChromeOS by deduplicating all the common stuff.
> > >
> > > Do you envision the "mapping" compatible string mapping to a config
> > > section in the FIT image, that would bundle the base DTB and the DTBOs ?
> >
> > That's exactly the idea. The mapping compatible string could be untied
> > from the base board's compatible string if needed (which we probably do).
> >
> > So something like:
> >
> > config {
> >     config-1 {
> >         compatible = "google,krane-sku0";
> >         fdt = "krane-baseboard", "krane-sku0-overlay";
> >     };
> > };
> >
> > With "krane-sku0-overlay" being an overlay that holds the differences
> > between the SKUs, in this case the display panel and MIPI camera (not
> > upstreamed) that applies to SKU0 in particular.
>
> The kernel DT makefiles already contain information on what overlays to
> apply to what base boards, in order to test the overlays and produce
> "full" DTBs. Maybe that information could be leveraged to create the
> configurations in the FIT image ?

Although the "full" DTBs created may only be a subset of all possible
combinations (I believe Rob just started with creating one "full" DTB
for each overlay, cfr. the additions I made in commit a09c3e105a208580
("arm64: dts: renesas: Apply overlays to base dtbs")), that could
definitely be a start.

Now, since the kernel build system already creates "full" DTBs, does
that mean that all of the base DTBs, overlays, and "full" DTBs will
end up in the FIT image?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
