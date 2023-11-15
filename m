Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0937ED214
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344235AbjKOUec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjKOUeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:34:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F443BC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:34:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0EEC433C9;
        Wed, 15 Nov 2023 20:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700080467;
        bh=EU1ORu8L0oCIrg7KaHoD9GBXRRT/HQ6jol7CgcdHKlo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rZiuEsiD/gyMZ37hWE4hC2+icyLyXIgSvGbKoA+XtY2kFPqY0jrGPBLFPuwEGTFHC
         2fNCq1cUovUcYFrdYcKwnCSFmnQXcyaf7AU44s987CpP7grIxH/AOTI045dDv06X//
         YqShp87/EVmMLMRU/EdXQE9XpngHzH3ibukhc9imjWTeHP2qBNFTrpj2yc3CGNe8kE
         OntgNDHBQZuczCVouwpfbXr/uDYHvlFlSsMDhqIjJGRbULt6QyFbhIlzod4l9M8HTT
         BWd3CqLoTdrCvSU+OKoOwQfXwUKOrJ+0HB98Zrs/FDsl9IOZ5+e9r/5xpQUG9urSQL
         R3VUfuvWO1R+g==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50797cf5b69so57498e87.2;
        Wed, 15 Nov 2023 12:34:27 -0800 (PST)
X-Gm-Message-State: AOJu0YxomVC4ovN/HUdRQoQOCjmXFAWvF4sjyMjZLIHyG5fdqeGjeh7H
        wtdHKMdoHSrBiwI3Whf9KpTeVIGgoG4F3R6nsg==
X-Google-Smtp-Source: AGHT+IE0S0tK/GSU6Wv5fUjZc4pGvPrcHf9BeEhRUDhIFnZWd7FL+/kFO75KxRbZi65Q9ml6nHbs3chKQp0jaiE+FqY=
X-Received: by 2002:ac2:4907:0:b0:507:cb61:2054 with SMTP id
 n7-20020ac24907000000b00507cb612054mr9866660lfi.49.1700080466108; Wed, 15 Nov
 2023 12:34:26 -0800 (PST)
MIME-Version: 1.0
References: <20231113085305.1823455-1-javierm@redhat.com>
In-Reply-To: <20231113085305.1823455-1-javierm@redhat.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 15 Nov 2023 14:34:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKHTN5hfd4qpg5RXbmQLKZNVywDkSj9mxvfGmjrcChQQg@mail.gmail.com>
Message-ID: <CAL_JsqKHTN5hfd4qpg5RXbmQLKZNVywDkSj9mxvfGmjrcChQQg@mail.gmail.com>
Subject: Re: [RFC PATCH] of/platform: Disable sysfb if a simple-framebuffer
 node is found
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Andrew Worsley <amworsley@gmail.com>,
        Hector Martin <marcan@marcan.st>,
        Sergio Lopez <slp@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 2:53=E2=80=AFAM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Some DT platforms use EFI to boot and in this case the EFI Boot Services
> may register a EFI_GRAPHICS_OUTPUT_PROTOCOL handle, that will later be
> queried by the Linux EFI stub to fill the global struct screen_info data.
>
> The data is used by the Generic System Framebuffers (sysfb) framework to
> add a platform device with platform data about the system framebuffer.
>
> But if there is a "simple-framebuffer" node in the DT, the OF core will
> also do the same and add another device for the system framebuffer.
>
> This could lead for example, to two platform devices ("simple-framebuffer=
"
> and "efi-framebuffer") to be added and matched with their corresponding
> drivers. So both efifb and simpledrm will be probed, leading to following=
:
>
> [    0.055752] efifb: framebuffer at 0xbd58dc000, using 16000k, total 160=
00k
> [    0.055755] efifb: mode is 2560x1600x32, linelength=3D10240, pages=3D1
> [    0.055758] efifb: scrolling: redraw
> [    0.055759] efifb: Truecolor: size=3D2:10:10:10, shift=3D30:20:10:0
> ...
> [    3.295896] simple-framebuffer bd58dc000.framebuffer: [drm] *ERROR*
> could not acquire memory range [??? 0xffff79f30a29ee40-0x2a5000001a7
> flags 0x0]: -16
> [    3.298018] simple-framebuffer: probe of bd58dc000.framebuffer
> failed with error -16
>
> To prevent the issue, make the OF core to disable sysfb if there is a nod=
e
> with a "simple-framebuffer" compatible. That way only this device will be
> registered and sysfb would not attempt to register another one using the
> screen_info data even if this has been filled.
>
> This seems the correct thing to do in this case because:
>
> a) On a DT platform, the DTB is the single source of truth since is what
>    describes the hardware topology. Even if EFI Boot Services are used to
>    boot the machine.

This is the opposite of what we do for memory and memory reservations.
EFI is the source of truth for those.

This could also lead to an interesting scenario. As simple-framebuffer
can define its memory in a /reserved-memory node, but that is ignored
in EFI boot. Probably would work, but only because EFI probably
generates its memory map table from the /reserved-memory nodes.

Rob
