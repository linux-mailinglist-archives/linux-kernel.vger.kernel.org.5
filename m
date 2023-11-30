Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E787FF340
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346161AbjK3PNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346053AbjK3PNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:13:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EAA198
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:13:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EFAC433C8;
        Thu, 30 Nov 2023 15:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701357195;
        bh=myWQia6fhUNAoIbKogEMdzyxJa5+F95VagADayo2ZsE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aw1cA1vb3s+YGPMjLLGTcPkhkPJzDfK6PQHSlnjkBgX/H8l0Cu2Yd5L4RrxObLSVW
         wiH9uM2j/XLxV5L/Ezarwau3hcjXSCSIiTrbozsT9wjnXjZSP0POJU5YjkCtv77Nvn
         wBoI4NHJDWr9s8rsgXyIdchBgNpTbN7m46vrdKJD1MR91NKMEj6DFw129JHdavELsF
         /kX7+2m/daWVKHq9QQhQ1sZtBmSqQ39vgB/q+MtsSGUs3lFWsVen03iOd/vP05d3iX
         S0+kVhiwlfR2FZeGgCwodkrwrO/1VQ8UHHzJOVoklverYp7JNx5FBdzp4eT5W7bLBY
         pHRRdeLd1S9Ug==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1fa2b8f7f27so499746fac.0;
        Thu, 30 Nov 2023 07:13:15 -0800 (PST)
X-Gm-Message-State: AOJu0YwMYX4s4N4YHQw/P5uWXlGTAy/7Rnd7jG3OFa1mVMcnpbZxtS+P
        8afc/jwthzTtx88yOw1U0EZeIIFoWPqeqDURmDk=
X-Google-Smtp-Source: AGHT+IEW+K2lD/B2JE4Lr0+Sk7l1d6EqA4tooaxvtrrBERAYgC8JMsuQkDEI5Uq9Bu24CYAB0+6UiX9/c42YFJFFSuA=
X-Received: by 2002:a05:6870:3452:b0:1fa:dd5f:77b9 with SMTP id
 i18-20020a056870345200b001fadd5f77b9mr138085oah.19.1701357194465; Thu, 30 Nov
 2023 07:13:14 -0800 (PST)
MIME-Version: 1.0
References: <20231129172200.430674-1-sjg@chromium.org> <20231129172200.430674-3-sjg@chromium.org>
 <ZWhFtcrZV2FYQ_D6@bergen.fjasle.eu>
In-Reply-To: <ZWhFtcrZV2FYQ_D6@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 1 Dec 2023 00:12:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNARNw0czgf-YE5mvA__tCGi=6wi-03p9LfJVEBfJZ_EYqg@mail.gmail.com>
Message-ID: <CAK7LNARNw0czgf-YE5mvA__tCGi=6wi-03p9LfJVEBfJZ_EYqg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Simon Glass <sjg@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Tom Rini <trini@konsulko.com>,
        lkml <linux-kernel@vger.kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 5:26=E2=80=AFPM Nicolas Schier <nicolas@fjasle.eu> =
wrote:
>
> Simon,
>
> thanks for the patch!  Below are some nitpicks and bike-shedding
> questions.
>
> On Wed 29 Nov 2023 10:21:53 GMT, Simon Glass wrote:
> > Add a script which produces a Flat Image Tree (FIT), a single file
> > containing the built kernel and associated devicetree files.
> > Compression defaults to gzip which gives a good balance of size and
> > performance.
> >
> > The files compress from about 86MB to 24MB using this approach.
> >
> > The FIT can be used by bootloaders which support it, such as U-Boot
> > and Linuxboot. It permits automatic selection of the correct
> > devicetree, matching the compatible string of the running board with
> > the closest compatible string in the FIT. There is no need for
> > filenames or other workarounds.
>
> Have you thought about updating the arch/mips ITB rules to also use the
> new scripts/make_fit.py?  Or is the FIT/ITB format for mips different
> from the one for arm64?



I recommend not touching MIPS at this moment
because this tool simply picks up *.dtb files
that exist under arch/*/boot/dts/, some of which
may be stale files.




Think of this scenario:


[1] Enable CONFIG_ARCH_FOO and build

   foo.dtb

will be created.


[2] Next, disable CONFIG_ARCH_FOO and
    enable CONFIG_ARCH_BAR, and build.

   bar.dtb

will be created.


This script will pick up both foo.dtb and bar.dtb
although foo.dtb is a left-over from the previous build.



Without cleaning, stale *.dtb will accumulate
and unwanted files will be included in image.fit.



Currently, MIPS hard-codes its files.
It always works in a deterministic way.




I do not request Simon to implement everything perfectly
because I know that would require much more effort.

We could do something like modules.order to list out the
dtb files from the current build, but I am not asking for it
in this patchset.



But, you are right. This tool is not arm64-specific at all
(and that is the reason why I think the MAINTAINERS
entry is a little odd)
Perhaps it can be applicable to MIPS after everything
works correctly.







> >  ARM ARCHITECTED TIMER DRIVER
> >  M:   Mark Rutland <mark.rutland@arm.com>
> >  M:   Marc Zyngier <maz@kernel.org>
> > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > index 1bd4fae6e806..18e092de7cdb 100644
> > --- a/arch/arm64/Makefile
> > +++ b/arch/arm64/Makefile
> > @@ -36,6 +36,8 @@ ifeq ($(CONFIG_BROKEN_GAS_INST),y)
> >  $(warning Detected assembler with broken .inst; disassembly will be un=
reliable)
> >  endif
> >
> > +KBUILD_DTBS      :=3D dtbs
>
> Might you want to use tabs here as in the lines below?



This should not exist in the first place.


  image.fit: dtbs


is better.









--
Best Regards
Masahiro Yamada
