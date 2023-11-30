Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E3C7FFC81
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376760AbjK3Ual (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjK3Uae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:30:34 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9A51711
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:30:40 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a00cbb83c82so199830666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701376239; x=1701981039; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j1kEoDVz8FmA118BIct7BasaUqEKiq39maAWu6XgfrY=;
        b=CpFPyt1F1w6ken91peQku/clTFntwKIYj+QVeApvEoQ6+tEb3EDrUekIXWkRCkI1oi
         MKNUdA1sQxc6q1SFJ8KSbi+K6g0GM3oh60Iy+N25It8Z+Hw4mrxPmH/b91sWXW3jTwGq
         yOmC3ROPLfQWGMOPU7z9FGDzZ9Gb4qotV3fXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701376239; x=1701981039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1kEoDVz8FmA118BIct7BasaUqEKiq39maAWu6XgfrY=;
        b=f4ozGIxLkOxd8xEW02iH7DP7Qw5dIMcGUEmHuTGBsry12KdH9sedDHnbqW0B/IWc4c
         aJphCwNcYPBpgVjXXx74saUd1Rbx1jc6ETuVInmPSdx+bwMFEV+5xi/NmjlbS7XlUWvu
         bbAsOQhfsHkqQ0aO0FW0s3y4XbcTolT+Lz76+o/jXnV4qekapXzkIyCB6Qun0N9oU5hO
         hOewOtTp8vZfjPQsAxc2PiDYVyOVo8KdOXzLjwc9LT//nSdNv3khRdTPBH99XWIsfGyb
         YOncuVyCmCjOBvjuDxuWcSS7Vzh6ZAsDu4xPoaj92hVi0fTYxP7swA6J/GHeGTKQW9R2
         nS4A==
X-Gm-Message-State: AOJu0Yz0HOZcSYjuAgtStqk/sggD7Tyo7nt3Tv3xw8XaExNItQJVwc5D
        SvvSNyAOl4nJisFNlpyPCUQxo4eff6vhw4pY2TZu6z9cAN6/smXrJZE=
X-Google-Smtp-Source: AGHT+IFIp7jl3Xe9SuGYh3OvQzZO3AxM5rdMcalwjeJ+luXeVJXVWymrXe3jpNkDnguFqELGcbxrl9p2GVcMiT0/cuQ=
X-Received: by 2002:a17:907:509d:b0:a0d:31:b455 with SMTP id
 fv29-20020a170907509d00b00a0d0031b455mr69707ejc.20.1701376238985; Thu, 30 Nov
 2023 12:30:38 -0800 (PST)
MIME-Version: 1.0
References: <20231129172200.430674-1-sjg@chromium.org> <20231129172200.430674-3-sjg@chromium.org>
 <03595817-4698-46d3-b2d8-3bc40c7e723e@pengutronix.de>
In-Reply-To: <03595817-4698-46d3-b2d8-3bc40c7e723e@pengutronix.de>
From:   Simon Glass <sjg@chromium.org>
Date:   Thu, 30 Nov 2023 13:30:25 -0700
Message-ID: <CAPnjgZ0G5DAFZj+nxVxMvNOg_wQKxwu06NAarUdVjurPYZ+tcw@mail.gmail.com>
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

I missed this comment earlier. I believe Image is intended to refer to
a raw image, with the other extensions being compressed versions of
these. So I believe it would be confusing for the FIT version to have
a capital I.

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
>
> Please Cc me on subsequent revisions. I am interested in testing that this works for barebox
> too.

I have added you.

Regards,
Simon
