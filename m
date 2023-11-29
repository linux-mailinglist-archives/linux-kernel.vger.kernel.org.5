Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD637FE010
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjK2TD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 14:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbjK2TDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 14:03:13 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8954A10FD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:03:10 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bca79244fso206006e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701284589; x=1701889389; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eqFuufKBS903oC+09D1OgJlE8YGZvK320Etdppu6ukQ=;
        b=OLxi/U9XBNwHTtVxzR3ob93N6V3VET6+XiUhjek4TZASdl1k+KBqk/qk7IoenpU/Uy
         IkzvqGyyteioAAIRemANxOQeJIHV7jmoJJp4ib71axLBQ2obiivVZHZ/DNZ+htpfSZ3o
         Ej78sGPZ++yXwnsDSwE7tGXpBEBCAUZFDPLDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701284589; x=1701889389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqFuufKBS903oC+09D1OgJlE8YGZvK320Etdppu6ukQ=;
        b=SiA+3KDwbwaYuYykPl2tUP4PzOwopOwMQoogT6tHfM5E7/x9mSAhGb252DypYQ7Ai2
         Y/5/Lz48EbReBkEohSmmAnnQqyK+xbXs+zRWrK9nNrDjm5xQorUKf+cE4WvDioNbWgN+
         lrR/8QQOQjmfNin8GNf9B/F8fpMvdkryxdn4aee11o3nvi3ln/1m3qCaFijuqu17FN6D
         zP+awX0jDbCsaIrB9hFh/c/Gf86w3n+7Z8fga/pH8nxUCTAE8pKtOHelM+HDtiD3W60R
         g3CaEkl7Q3MPgd71rHYmFRWSKGB8EWiKGFTeLFpXomyhQ/xQf9EgbwouWJ3qj5cpfNMW
         UGOA==
X-Gm-Message-State: AOJu0YwKjKdyMkJieZeSbIUQTWapdnJPjfsOk62BOs/KITp4LnEbtq7j
        oaI23Od9cTrIIf0z8sdQrgcI5CeFshIVOPwd6fQeZg==
X-Google-Smtp-Source: AGHT+IFVXUrZjpsbk8/VnzdMqcgpeht/p4RMDUy/Er0zzFvjxFoqfqyI6+x7cYid7etTRdTN+BrdV820tcBQ82gj6bM=
X-Received: by 2002:a05:6512:2343:b0:509:455c:9e3d with SMTP id
 p3-20020a056512234300b00509455c9e3dmr12103134lfu.18.1701284588464; Wed, 29
 Nov 2023 11:03:08 -0800 (PST)
MIME-Version: 1.0
References: <20231129172200.430674-1-sjg@chromium.org> <20231129172200.430674-3-sjg@chromium.org>
 <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de>
In-Reply-To: <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de>
From:   Simon Glass <sjg@chromium.org>
Date:   Wed, 29 Nov 2023 12:02:57 -0700
Message-ID: <CAPnjgZ25xoXsi74XYY0E8ucQiowQqPdZgUHrfVNAYWKZEYODHg@mail.gmail.com>
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

On Wed, 29 Nov 2023 at 11:59, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hi,
>
> a few more comments after decompiling the FIT image:
>
> On 29.11.23 18:21, Simon Glass wrote:
> > +    with fsw.add_node('kernel'):
> > +        fsw.property_string('description', args.name)
> > +        fsw.property_string('type', 'kernel_noload')
>
> The specification only says no loading done, but doesn't explain what it
> means for a bootloader to _not_ load an image. Looking into the U-Boot commit
> b9b50e89d317 ("image: Implement IH_TYPE_KERNEL_NOLOAD") that introduces this,
> apparently no loading means ignoring load and entry address?
>
> I presume missing load and entry is something older U-Boot versions
> were unhappy about? Please let me know if the semantics are as I understood,
> so I can prepare a barebox patch supporting it.

Oh, see my previous email.

>
> > +        fsw.property_string('arch', args.arch)
> > +        fsw.property_string('os', args.os)
> > +        fsw.property_string('compression', args.compress)
> > +        fsw.property('data', data)
> > +        fsw.property_u32('load', 0)
> > +        fsw.property_u32('entry', 0)
> > +
> > +
> > +def finish_fit(fsw, entries):
> > +    """Finish the FIT ready for use
> > +
> > +    Writes the /configurations node and subnodes
> > +
> > +    Args:
> > +        fsw (libfdt.FdtSw): Object to use for writing
> > +        entries (list of tuple): List of configurations:
> > +            str: Description of model
> > +            str: Compatible stringlist
> > +    """
> > +    fsw.end_node()
> > +    seq = 0
> > +    with fsw.add_node('configurations'):
> > +        for model, compat in entries:
> > +            seq += 1
> > +            with fsw.add_node(f'conf-{seq}'):
> > +                fsw.property('compatible', bytes(compat))
>
> The specification says that this is the root U-Boot compatible,
> which I presume to mean the top-level compatible, which makes sense to me.
>
> The code here though adds all compatible strings from the device tree though,
> is this intended?

Yes, since it saves needing to read in each DT just to get the
compatible stringlist.

>
> > +        fsw.property_string('description', model)
> > +        fsw.property_string('type', 'flat_dt')
> > +        fsw.property_string('arch', arch)
> > +        fsw.property_string('compression', compress)
> > +        fsw.property('compatible', bytes(compat))
>
> I think I've never seen a compatible for a fdt node before.
> What use does this serve?

It indicates the machine that the DT is for.

Regards,
Simon
