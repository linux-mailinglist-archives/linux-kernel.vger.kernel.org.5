Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAACE8092C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjLGUxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGUxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:53:08 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080E511D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:53:14 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1db6c63028so157572466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 12:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701982392; x=1702587192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oWIflf5hcpue6wGtlwNE/HkT4tbMsQSgIfDnrjtjjfg=;
        b=c8B/JvlL241AVApFlMOMEU71qJxiM19TKArDurZrBANlu7YBhDBXwSgkbfua/d8XtZ
         WfB9iTKD4UeUFE/1G8xm+4RNZWPdz87iSzi6rbarvzt1/pdZX4+ZJvEF8One39Dx8RGH
         iiFln6d4IqKX/xXVK6Rwv2ppGNiVpwEFRMGos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701982392; x=1702587192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWIflf5hcpue6wGtlwNE/HkT4tbMsQSgIfDnrjtjjfg=;
        b=TuLsdm8+mXmwsQyUQf5Ju3EkzBfFmVeKsPORbl3BkMNZrv4zGQN0r7zDiSTKsyGUJ0
         oGdluly2MxpioY6jDBFLn21DMVCFA3fr1QN2Zxo0rNdW4avMUGfN29Zf4/DMPBPxQRLV
         ry02ARcUjBxU1bFJuVmxh2zdumG5121iacDAtqP7Fic/WqxvQg3W/VTvkWYTrSqZwEFs
         UN2q5081JFI1lDHXtOuZAlY68PyMxgbZThKZm7wQsBbMISmavVsIFZQ0+yQcV9PeibsW
         xVsGYAjVtB/LIg2PsAwxSn50fRAPMqYCxokmg2SP/aV/KDZVAeywLU6x3UXeLUv/V0iD
         e5TA==
X-Gm-Message-State: AOJu0YzVyDPIH6QB4JSPycf3KgIXqchpzWu2drce83FyLsA6VNqxLClG
        /d+Ok6RzKVaO+zTJSH0Mha+hOQllb/dN/hpP0yt78Q==
X-Google-Smtp-Source: AGHT+IGlqecBeKpKJsPolkl+LHqMluq7H92QsuDLPCGLyyt/tYoOLIFC7+pQZSilRLUlakLEfiXMyZjPKdw0aG6O2m4=
X-Received: by 2002:a17:907:2948:b0:a19:a19a:eac0 with SMTP id
 et8-20020a170907294800b00a19a19aeac0mr1471204ejc.121.1701982392232; Thu, 07
 Dec 2023 12:53:12 -0800 (PST)
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org> <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com> <20231207142723.GA3187877@google.com>
 <20231207143814.GD15521@pendragon.ideasonboard.com>
In-Reply-To: <20231207143814.GD15521@pendragon.ideasonboard.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Thu, 7 Dec 2023 13:52:53 -0700
Message-ID: <CAPnjgZ1q3yBeyYfjLumJ03HR7JM1xwN7sMbNJqfUWpsVxFTs4Q@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
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
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 7 Dec 2023 at 07:38, Laurent Pinchart
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
> > > > devicetree, matching the compatible string of the running board with
> > > > the closest compatible string in the FIT. There is no need for
> > > > filenames or other workarounds.
> > > >
> > > > Add a 'make image.fit' build target for arm64, as well. Use
> > > > FIT_COMPRESSION to select a different algorithm.
> > > >
> > > > The FIT can be examined using 'dumpimage -l'.
> > > >
> > > > This features requires pylibfdt (use 'pip install libfdt'). It also
> > > > requires compression utilities for the algorithm being used. Supported
> > > > compression options are the same as the Image.xxx files. For now there
> > > > is no way to change the compression other than by editing the rule for
> > > > $(obj)/image.fit
> > > >
> > > > While FIT supports a ramdisk / initrd, no attempt is made to support
> > > > this here, since it must be built separately from the Linux build.
> > >
> > > FIT images are very useful, so I think this is a very welcome addition
> > > to the kernel build system. It can get tricky though: given the
> > > versatile nature of FIT images, there can't be any
> > > one-size-fits-them-all solution to build them, and striking the right
> > > balance between what makes sense for the kernel and the features that
> > > users may request will probably lead to bikeshedding. As we all love
> > > bikeshedding, I thought I would start selfishly, with a personal use
> > > case :-) This isn't a yak-shaving request though, I don't see any reason
> > > to delay merging this series.
> > >
> > > Have you envisioned building FIT images with a subset of DTBs, or adding
> > > DTBOs ? Both would be fairly trivial extensions to this script by
> > > extending the supported command line arguments. It would perhaps be more
> > > difficult to integrate in the kernel build system though. This leads me
> > > to a second question: would you consider merging extensions to this
> > > script if they are not used by the kernel build system, but meant for
> > > users who manually invoke the script ? More generally, is the script
> >
> > We'd also be interested in some customization, though in a different way.
> > We imagine having a rule file that says X compatible string should map
> > to A base DTB, plus B and C DTBO for the configuration section. The base
> > DTB would carry all common elements of some device, while the DTBOs
> > carry all the possible second source components, like different display
> > panels or MIPI cameras for instance. This could drastically reduce the
> > size of FIT images in ChromeOS by deduplicating all the common stuff.
>
> Do you envision the "mapping" compatible string mapping to a config
> section in the FIT image, that would bundle the base DTB and the DTBOs ?
>
> > > meant to be used stand-alone as well, in which case its command line
> > > arguments need to remain backward-compatible, or do you see it as being
> > > internal to the kernel ?

It is great to see all this discussion! I did send a proposal to the
U-Boot ML about extensions but it was mixed up with other things, so
I'll start a new thread.

For now, I am really just waiting for this to be applied, before
talking too much about future possibilities.

Regards,
SImon
