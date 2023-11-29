Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19E27FE050
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjK2T1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 14:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjK2T1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 14:27:46 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDAEA2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:27:52 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a178e82a445so16512166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701286070; x=1701890870; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6gR6QlSoTlyq04eRwNKCnLLqDlXv6VkMGmXKmkbAaQ0=;
        b=YIKd2P8k4sSMCmJtAiaRX/RXoHwSEE0jNkpZy69FznQzOS1y8AWKOAlHZEhf90qKqG
         0qIgyp/EHkAVsEi/r4HZl0XbafWUCyhBF3qjyFLNJ3O6qtew+Yvl20lW6nvgB9aiKEUF
         w/pB6sC7iE90vxTNzTCV9hbpW7aBSUCh5roIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701286070; x=1701890870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gR6QlSoTlyq04eRwNKCnLLqDlXv6VkMGmXKmkbAaQ0=;
        b=QJn/CbDtNtyg1Zo0+wtOUJ5knJeHBd9+VW9vnLBSZunrV8bVXT7YV0rypf/R4FbX4s
         dNuc96MwGWzPV9MjhyLhTS7/P81FmJR9adWqB/aqH2ehiDcMrwygQlE5VNn3G4vFFpX1
         dWRZwfA2T9Dpv0NGfGycrVsLCF4SyL69D3Rr5JycpeVyygKaqIcyp0TEyczuMHvwFr2t
         Kqe3mNDyLdEm6f5UoY+QwEO4AQGk0UtwBt1ppiufD6gLofC/9RiNq6WgmJjQTds3QItL
         UvKAMgWMAO7ZT3jpN3rLphn92cFavtxx7sbXcax9KiW6VpX77opAVwlS73paiAeaVItF
         4bLQ==
X-Gm-Message-State: AOJu0YwLHqpoMmjzc6tekJ8KhYbazo0HyFa4uJMxw0WZTkhteEgsUUwa
        3z633ioZBc3Xsm7ffTkPpdsQR7FhiWtVmA4ouQDcRA==
X-Google-Smtp-Source: AGHT+IFHd0lnsDfy+Z0LdFjR7oopIOyEOsVSQwIRDwzAaCAHJiPxmbCa0ilD2wIXfA2WW2IAWhTwgbrifbGP3/TbFI4=
X-Received: by 2002:a17:906:ccc5:b0:a11:d323:c1bc with SMTP id
 ot5-20020a170906ccc500b00a11d323c1bcmr5061259ejb.19.1701286070318; Wed, 29
 Nov 2023 11:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20231129172200.430674-1-sjg@chromium.org> <20231129172200.430674-3-sjg@chromium.org>
 <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de> <CAPnjgZ25xoXsi74XYY0E8ucQiowQqPdZgUHrfVNAYWKZEYODHg@mail.gmail.com>
 <875f0dbc-1d78-4901-91b2-6ad152bcea5a@pengutronix.de>
In-Reply-To: <875f0dbc-1d78-4901-91b2-6ad152bcea5a@pengutronix.de>
From:   Simon Glass <sjg@chromium.org>
Date:   Wed, 29 Nov 2023 12:27:38 -0700
Message-ID: <CAPnjgZ0UCkm5QCx+JXe1ggSshozPnOLB6cN=UoJyMn6S4wfFkg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rini <trini@konsulko.com>,
        lkml <linux-kernel@vger.kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad,

On Wed, 29 Nov 2023 at 12:15, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Simon,
>
> On 29.11.23 20:02, Simon Glass wrote:
> > Hi Ahmad,
> >
> > On Wed, 29 Nov 2023 at 11:59, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>
> >> Hi,
> >>
> >> a few more comments after decompiling the FIT image:
> >>
> >> On 29.11.23 18:21, Simon Glass wrote:
> >>> +    with fsw.add_node('kernel'):
> >>> +        fsw.property_string('description', args.name)
> >>> +        fsw.property_string('type', 'kernel_noload')
> >>
> >> The specification only says no loading done, but doesn't explain what it
> >> means for a bootloader to _not_ load an image. Looking into the U-Boot commit
> >> b9b50e89d317 ("image: Implement IH_TYPE_KERNEL_NOLOAD") that introduces this,
> >> apparently no loading means ignoring load and entry address?
> >>
> >> I presume missing load and entry is something older U-Boot versions
> >> were unhappy about? Please let me know if the semantics are as I understood,
> >> so I can prepare a barebox patch supporting it.
> >
> > Oh, see my previous email.
>
> Thanks.
>
> >
> >>
> >>> +        fsw.property_string('arch', args.arch)
> >>> +        fsw.property_string('os', args.os)
> >>> +        fsw.property_string('compression', args.compress)
> >>> +        fsw.property('data', data)
> >>> +        fsw.property_u32('load', 0)
> >>> +        fsw.property_u32('entry', 0)
> >>> +
> >>> +
> >>> +def finish_fit(fsw, entries):
> >>> +    """Finish the FIT ready for use
> >>> +
> >>> +    Writes the /configurations node and subnodes
> >>> +
> >>> +    Args:
> >>> +        fsw (libfdt.FdtSw): Object to use for writing
> >>> +        entries (list of tuple): List of configurations:
> >>> +            str: Description of model
> >>> +            str: Compatible stringlist
> >>> +    """
> >>> +    fsw.end_node()
> >>> +    seq = 0
> >>> +    with fsw.add_node('configurations'):
> >>> +        for model, compat in entries:
> >>> +            seq += 1
> >>> +            with fsw.add_node(f'conf-{seq}'):
> >>> +                fsw.property('compatible', bytes(compat))
> >>
> >> The specification says that this is the root U-Boot compatible,
> >> which I presume to mean the top-level compatible, which makes sense to me.
> >>
> >> The code here though adds all compatible strings from the device tree though,
> >> is this intended?
> >
> > Yes, since it saves needing to read in each DT just to get the
> > compatible stringlist.
>
> The spec reads as if only one string (root) is supposed to be in the list.
> The script adds all compatibles though. This is not really useful as a bootloader
> that's compatible with e.g. fsl,imx8mm would just take the first device tree
> with that SoC, which is most likely to be wrong. It would be better to just
> specify the top-level compatible, so the bootloader fails instead of taking
> the first DT it finds.

We do need to have a list, since we have to support different board revs, etc.

>
> >>> +        fsw.property_string('description', model)
> >>> +        fsw.property_string('type', 'flat_dt')
> >>> +        fsw.property_string('arch', arch)
> >>> +        fsw.property_string('compression', compress)
> >>> +        fsw.property('compatible', bytes(compat))
> >>
> >> I think I've never seen a compatible for a fdt node before.
> >> What use does this serve?
> >
> > It indicates the machine that the DT is for.
>
> Who makes use of this information?

U-Boot uses it, I believe. There is an optimisation to use this
instead of reading the DT itself.

Regards,
Simon
