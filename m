Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E50A8065E3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376424AbjLFDy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFDyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:54:55 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED411BF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 19:55:01 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5d7346442d4so40176587b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 19:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701834900; x=1702439700; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BsR8qY+uS6/BsLD1U3jPPzDAagYHPNv5M9ReQzqjMkA=;
        b=UXm8uYZ/Xl/VBZ/flQFs+9dAjL8MxLfaV1SwXude+vyG7dViCJ20LbYT4CQUaXdQFr
         fetTd2xYcTrMmRoc2jpfsvdKFz+fBWlPhE4CEIuG1FJ7VLs5Iu3/o6sr2F61CeOPnDky
         7TVjn+/jo9MjtLIgnTeHDtHwyNNDRS6XzCia8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701834900; x=1702439700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsR8qY+uS6/BsLD1U3jPPzDAagYHPNv5M9ReQzqjMkA=;
        b=p9me7O5YRBeEMWgSb/KbRgjqd4o+9hGpNzG5RkJHAkFgikUNVkD4hgpC8ymhEf/Mkl
         vpvSqYR/WiOPAudXcq8gZLUS0kdSGgXh91hoEyiDPbKtSaLtZy6QIWBnspNAkJNwANV7
         BKT05ocWELxZnZD4JVU0Xf4mHdfiMfJkiBanV30eigf111pjxrG5zxw3KPxDWFxfXvpy
         ywkQ0ubMtXuKj2ut+Wy+BgLupoDFcvA+wDtAOReFIJySfPyBZnlAX4sEEXHHBvQx9WyC
         qdWX2brlbOfzCvnGQCpUKA/OA8o/9z2D2Ym0FmDEgrKfvs3j2i7WNRAGkpCmTgPwTlrP
         0x/g==
X-Gm-Message-State: AOJu0YxtPaG2tDLzZguiuy2Ta4JiCHAZyYGMT/mawh+N+LYHfjZ/AwmZ
        xFh6xbs/5kMtGmfUQylq2PlsfADzpIqirBbrGm8fMw==
X-Google-Smtp-Source: AGHT+IHoRbTJaveVc4lI5CNcK45wkIN9hGVufXmpLxm2ne2EuM6HpHaABsrXS8hPPj5d6lQhPotGKPmzPUEdXOur9Ro=
X-Received: by 2002:a81:6dce:0:b0:5d7:3104:5649 with SMTP id
 i197-20020a816dce000000b005d731045649mr174139ywc.3.1701834900083; Tue, 05 Dec
 2023 19:55:00 -0800 (PST)
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org> <20231202035511.487946-3-sjg@chromium.org>
 <92a3e3b4-6f4d-4ca4-947f-db905f328d4c@pengutronix.de>
In-Reply-To: <92a3e3b4-6f4d-4ca4-947f-db905f328d4c@pengutronix.de>
From:   Simon Glass <sjg@chromium.org>
Date:   Tue, 5 Dec 2023 20:54:41 -0700
Message-ID: <CAPnjgZ3QZh3+2PtmSvje=KAw1n1o_jmhgC1ZnhM9JBoEjLG+fQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Tom Rini <trini@konsulko.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, workflows@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
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

Hi Ahmad,

On Tue, 5 Dec 2023 at 04:48, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Simon,
>
> On 02.12.23 04:54, Simon Glass wrote:
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
> >
> > Add a 'make image.fit' build target for arm64, as well. Use
> > FIT_COMPRESSION to select a different algorithm.
> >
> > The FIT can be examined using 'dumpimage -l'.
> >
> > This features requires pylibfdt (use 'pip install libfdt'). It also
> > requires compression utilities for the algorithm being used. Supported
> > compression options are the same as the Image.xxx files. For now there
> > is no way to change the compression other than by editing the rule for
> > $(obj)/image.fit
> >
> > While FIT supports a ramdisk / initrd, no attempt is made to support
> > this here, since it must be built separately from the Linux build.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> kernel_noload support is now in barebox next branch and I tested this
> series against it:
>
> Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de> # barebox
>

OK great thank you.

> > +"""Build a FIT containing a lot of devicetree files
> > +
> > +Usage:
> > +    make_fit.py -A arm64 -n 'Linux-6.6' -O linux
> > +        -f arch/arm64/boot/image.fit -k /tmp/kern/arch/arm64/boot/image.itk
> > +        /tmp/kern/arch/arm64/boot/dts/ -E -c gzip
> > +
> > +Creates a FIT containing the supplied kernel and a directory containing the
> > +devicetree files.
> > +
> > +Use -E to generate an external FIT (where the data is placed after the
> > +FIT data structure). This allows parsing of the data without loading
> > +the entire FIT.
> > +
> > +Use -c to compress the data, using bzip2, gzip, lz4, lzma, lzo and
> > +zstd algorithms.
> > +
> > +The resulting FIT can be booted by bootloaders which support FIT, such
> > +as U-Boot, Linuxboot, Tianocore, etc.
>
> Feel free to add barebox to the list. Did you check whether Linuxboot and
> Tianocore support kernel_noload?

Only what I was told by people in those projects. They may not even
look at the load address, but I am not an expert on that.

>
> > +        fsw.property_u32('load', 0)
> > +        fsw.property_u32('entry', 0)
>
> I still think load and entry dummy values are confusing and should be dropped.

This is what the spec requires at present. But I agree we should
change it. I will dig into that at some point to see what is needed.

>
> > +    with fsw.add_node(f'fdt-{seq}'):
> > +        # Get the compatible / model information
> > +        with open(fname, 'rb') as inf:
> > +            data = inf.read()
> > +        fdt = libfdt.FdtRo(data)
> > +        model = fdt.getprop(0, 'model').as_str()
> > +        compat = fdt.getprop(0, 'compatible')
> > +
> > +        fsw.property_string('description', model)
> > +        fsw.property_string('type', 'flat_dt')
> > +        fsw.property_string('arch', arch)
> > +        fsw.property_string('compression', compress)
> > +        fsw.property('compatible', bytes(compat))
> > +
> > +        with open(fname, 'rb') as inf:
> > +            compressed = compress_data(inf, compress)
> > +        fsw.property('data', compressed)
> > +    return model, compat
>
> After Doug's elaboration, extracting multiple compatibles is fine by me.

OK good.

Regards,
Simon
