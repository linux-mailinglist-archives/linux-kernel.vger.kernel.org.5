Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C517FE00D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbjK2TCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 14:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbjK2TCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 14:02:18 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1E7211C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:01:20 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a00a9c6f283so15679666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701284479; x=1701889279; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zeJS0+YXgcV8K2msfYPrZc7s+u+FFHEg7gVWXomud/s=;
        b=OD3XxVK33Jk4FAMbrbrcD5SIos1Wq3jYnO+UrQYXjUGimH9LEBs0EmZo8HKwDvjkWo
         7xMY5cvOo9ObxvdZ0WHJoqylxbhCzfXz4fqpD5Rd+6Ha0G0fd2fzCAY4+ycoJT4YsNFn
         f7x8+YUyDOyWcL9cT0vhxsElQge7hR3RhX99E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701284479; x=1701889279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zeJS0+YXgcV8K2msfYPrZc7s+u+FFHEg7gVWXomud/s=;
        b=Z+bdHfSTtfDU+CP8enAh02zzwpdW5EEOH7NenJ2IpIF6+eFOGF+9XBE5Qh5AvGm5Af
         3gALDMBMVBEv8YUkvXZFgT6ZESkR8cQmh3pGMiN4oA/VuEVdlD6NaBZWYZG5qSyxlt09
         QD2fibOrZkrieKllQQfhVDjaWp/C12qBZM2ilzCjgcg4jDbSqq7vB+NBPlb8vSxZrXLW
         8njaLBV4SrF9axf+uxDKQInE8Bv/9rI1X3Bz5k/MDX2/Gt54RALuZklSwvEMJB7+jumD
         szyVjEUPWBKd2g2++NTP4TDhwvJrEJguuj0Esp5tFf2MMrkDg6VqMZfXaah0z4/fYsCX
         2bAw==
X-Gm-Message-State: AOJu0YxlAFpeLJQOvmVMoVp6OAbyukOs3w/vpcJ2q9wHu34bdU/p9ir3
        ZCmXhkb7K/NYY3KRDit81eZpxch3Cgofx59mdJfZLQ==
X-Google-Smtp-Source: AGHT+IFzwRelFfkIF8gvXqwP74fx2aLRF2MAfYe7wE5lNvZPbUHxwREC9GHnF7sxAQdl2nWuYhXn0vint48cvgP9igs=
X-Received: by 2002:a17:906:7245:b0:a01:e916:3584 with SMTP id
 n5-20020a170906724500b00a01e9163584mr12542566ejk.54.1701284479022; Wed, 29
 Nov 2023 11:01:19 -0800 (PST)
MIME-Version: 1.0
References: <20231129172200.430674-1-sjg@chromium.org> <20231129172200.430674-3-sjg@chromium.org>
 <03595817-4698-46d3-b2d8-3bc40c7e723e@pengutronix.de>
In-Reply-To: <03595817-4698-46d3-b2d8-3bc40c7e723e@pengutronix.de>
From:   Simon Glass <sjg@chromium.org>
Date:   Wed, 29 Nov 2023 12:00:59 -0700
Message-ID: <CAPnjgZ1e4cryN=Q8XufrdEcJoHfW5n-aN-F3pr2mTWA_0c5-Gg@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad,

On Wed, 29 Nov 2023 at 11:35, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Simon,
>
> On 29.11.23 18:21, Simon Glass wrote:
> > Add a script which produces a Flat Image Tree (FIT), a single file
> > containing the built kernel and associated devicetree files.
> > Compression defaults to gzip which gives a good balance of size and
> > performance.
>
> Thanks for working on this. I think it's useful to have the kernel
> generate a FIT image out of the box. More complex use cases are always
> free to call mkimage with a custom ITS.
>
>
> > The files compress from about 86MB to 24MB using this approach.
> >
> > The FIT can be used by bootloaders which support it, such as U-Boot
> > and Linuxboot. It permits automatic selection of the correct
> > devicetree, matching the compatible string of the running board with
> > the closest compatible string in the FIT. There is no need for
> > filenames or other workarounds.
> >
> > Add a 'make image.fit' build target for arm64, as well.
>
> not that it matters much, but should this maybe called Image.fit
> as the other Image types are capitalized too?
>
> >  EFI_ZBOOT_PAYLOAD    := Image
> >  EFI_ZBOOT_BFD_TARGET := elf64-littleaarch64
> >  EFI_ZBOOT_MACH_TYPE  := ARM64
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 1a965fe68e01..e1c06ca3c847 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -496,6 +496,19 @@ quiet_cmd_uimage = UIMAGE  $@
> >                       -a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \
> >                       -n '$(UIMAGE_NAME)' -d $< $@
>
> Doesn't hardcoding a load address and entry address here defeat the point
> of having FIT as generic portable image format?
>
> At least barebox will try to place the kernel image at physical address 0 and
> will exit with an error message if no SDRAM is located at that address.
> The recommendation in that case is to omit load and entry address altogether
> to have barebox find a suitable location, but I see now that the FIT specification
> requires a load and entry address. What would happen if U-Boot tries to load this
> FIT image on a board that has no DRAM at address 0?

The 'kernel_noload' type indicates that the load/exec address are ignored.

>
> Please Cc me on subsequent revisions. I am interested in testing that this works for barebox
> too.

There has been some discussion about this recently in U-Boot too,
along with a series [1] which you could try if you like.

The FIT spec[2] does not provide enough detail on exactly what
kernel_noload means and we should improve this at some point.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=382849
[2] https://github.com/open-source-firmware/flat-image-tree



>
> Thanks,
> Ahmad
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>
