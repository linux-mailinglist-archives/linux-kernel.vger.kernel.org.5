Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9337EE25E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345239AbjKPOJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjKPOJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:09:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEB2B7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:09:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7492C433CA;
        Thu, 16 Nov 2023 14:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700143766;
        bh=rB/Mvb26W5AmN+4f3AC1SZzpW+ppLKByhsjYNB+6EEI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nE6+snsgpW57FufOCRNrLAGFfnNrWJwNYXcujeLqmsBTGpvYPlVOALApRz8fjQNiU
         7ZeYNzUp+Z5nwQIXMoOaAMNb7uk2XtO6UCBaCKo9U0lRj93evUBs7++lUaGa9WMLhE
         EsshxHFYHOXCsUeKziJUY2U0IO/mFjLCVKv7iBjXvvNank9zzvb3XtMQBT56uvNZdg
         KvqQhZS3iewwuPlgG9J3FU+FdFj1sD4U4qf5H0oApIlRrp6G42uC3djNWvlnVjrKL7
         Am0ylm9fIQTO1cfjcRuMNjHdQsrE/CE5IgGIgfhSOLD6WkIF4fHcL+jiN/Zu2m8jNp
         TmCcwg5oMdNvg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso1212853e87.1;
        Thu, 16 Nov 2023 06:09:26 -0800 (PST)
X-Gm-Message-State: AOJu0YwmfeCKkWYD7Eso+vzdWMLe9i3rKhBG75C/WwI0/MVqlQDv/nHx
        dAXON72fQUJZZ4/wCcphfqHN7BfJoNPReCqzMA==
X-Google-Smtp-Source: AGHT+IF7gDkr6pEi03Hb9UwjLZa47pD91Fnz4Fp7cHW/kBh/T6uc0tj4XfOUNICPJrE/drrXl0Z/LnFaN0b6C8r6Xqg=
X-Received: by 2002:a19:f811:0:b0:507:c7ae:32cc with SMTP id
 a17-20020a19f811000000b00507c7ae32ccmr11147917lff.41.1700143764953; Thu, 16
 Nov 2023 06:09:24 -0800 (PST)
MIME-Version: 1.0
References: <20231113085305.1823455-1-javierm@redhat.com> <CAL_JsqKHTN5hfd4qpg5RXbmQLKZNVywDkSj9mxvfGmjrcChQQg@mail.gmail.com>
 <87jzqi59bt.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87jzqi59bt.fsf@minerva.mail-host-address-is-not-set>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 16 Nov 2023 08:09:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJM9+cbNviwuKGB5+3YbyAP3UH+TxCxsU5nUtX-iRGP2w@mail.gmail.com>
Message-ID: <CAL_JsqJM9+cbNviwuKGB5+3YbyAP3UH+TxCxsU5nUtX-iRGP2w@mail.gmail.com>
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

On Thu, Nov 16, 2023 at 3:36=E2=80=AFAM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Rob Herring <robh@kernel.org> writes:
>
> Hello Rob,
>
> > On Mon, Nov 13, 2023 at 2:53=E2=80=AFAM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
> >>
> >> Some DT platforms use EFI to boot and in this case the EFI Boot Servic=
es
> >> may register a EFI_GRAPHICS_OUTPUT_PROTOCOL handle, that will later be
> >> queried by the Linux EFI stub to fill the global struct screen_info da=
ta.
> >>
> >> The data is used by the Generic System Framebuffers (sysfb) framework =
to
> >> add a platform device with platform data about the system framebuffer.
> >>
> >> But if there is a "simple-framebuffer" node in the DT, the OF core wil=
l
> >> also do the same and add another device for the system framebuffer.
> >>
> >> This could lead for example, to two platform devices ("simple-framebuf=
fer"
> >> and "efi-framebuffer") to be added and matched with their correspondin=
g
> >> drivers. So both efifb and simpledrm will be probed, leading to follow=
ing:
> >>
> >> [    0.055752] efifb: framebuffer at 0xbd58dc000, using 16000k, total =
16000k
> >> [    0.055755] efifb: mode is 2560x1600x32, linelength=3D10240, pages=
=3D1
> >> [    0.055758] efifb: scrolling: redraw
> >> [    0.055759] efifb: Truecolor: size=3D2:10:10:10, shift=3D30:20:10:0
> >> ...
> >> [    3.295896] simple-framebuffer bd58dc000.framebuffer: [drm] *ERROR*
> >> could not acquire memory range [??? 0xffff79f30a29ee40-0x2a5000001a7
> >> flags 0x0]: -16
> >> [    3.298018] simple-framebuffer: probe of bd58dc000.framebuffer
> >> failed with error -16
> >>
> >> To prevent the issue, make the OF core to disable sysfb if there is a =
node
> >> with a "simple-framebuffer" compatible. That way only this device will=
 be
> >> registered and sysfb would not attempt to register another one using t=
he
> >> screen_info data even if this has been filled.
> >>
> >> This seems the correct thing to do in this case because:
> >>
> >> a) On a DT platform, the DTB is the single source of truth since is wh=
at
> >>    describes the hardware topology. Even if EFI Boot Services are used=
 to
> >>    boot the machine.
> >
> > This is the opposite of what we do for memory and memory reservations.
> > EFI is the source of truth for those.
> >
> > This could also lead to an interesting scenario. As simple-framebuffer
> > can define its memory in a /reserved-memory node, but that is ignored
> > in EFI boot. Probably would work, but only because EFI probably
> > generates its memory map table from the /reserved-memory nodes.
> >
>
> I see. So what would be the solution then? Ignoring creating a platform
> device for "simple-framebuffer" if booted using EFI and have an EFI-GOP?

Shrug. I don't really know anything more about EFI FB, but I would
guess it can't support handling resources like clocks, power domains,
regulators, etc. that simple-fb can. So if a platform needs those, do
we say they should not setup EFI-GOP? Or is there a use case for
having both? Clients that don't muck with resources can use EFI-GOP
and those that do use simple-fb. For example, does/can grub use
EFI-GOP, but not simple-fb?

Rob
