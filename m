Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076F17E9C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjKMMfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKMMf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:35:29 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB46CD55;
        Mon, 13 Nov 2023 04:35:25 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so7224029a12.0;
        Mon, 13 Nov 2023 04:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699878924; x=1700483724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sqJNnVUISV8ConHJRlGZ/JEIE4MyLgnfqLghRwViRxM=;
        b=TULh3rytxFF35uu6vX44slI8G9eeZ0T8GApNXcpZXxP37SOM4rWejE9abnLEmQGzNT
         mtXzvEKApYyAZu7NfMQNgz1uPMr4z+Jrrbui8L6hI6xE8ro+5DFg/18Mj20BXiU2UAXH
         3rKRDsEjrswqFWhlqEbY4wAlfXsQ8KP30sP4knJdkGggfy1wKPi/PvSSMNO4rp1BR3Wo
         Fdx9SuiCxqiXVmPanJhBTmDtriyr3i0ttagpzEM4nfi4pauRf/ZKcdhjIrT37aqmwLWO
         l3R2dEP7Y3FkDbgB9JZYb3HZnMlLNqFdw9tZJW9G5CUOOUk1/UafGVG2r+MJ9rKb65jU
         2WgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699878924; x=1700483724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqJNnVUISV8ConHJRlGZ/JEIE4MyLgnfqLghRwViRxM=;
        b=FBXIvIvVLcBI3emjBFmMK6PGXqV6AN3Ag9Xrow99XNtS5GE0FEKPoENLxLYujJs5Qw
         zNsbryaVQ2GRgG6UYDi/UFx8pnu9mDlEXLSEmnzjyAfkzuRsIDf28Yy7pRsGxlmzMhzf
         FbqtjR6R5r4mrqJMoK/O2mKNq/aJJrwQbu0COV7sVeIlQ7y+vAtn77hnXfLW9+ca+V6i
         08vvycuF0KPDtti6SSOJfZkyngSRdiGFusyYHfNohJNa+6LBeHKa6WQCLr0EfcaYZs8X
         /Q3oW01faAZjdcQO9cCWI/Vgwib1ca3sBsmE79rnEjc6791dz15OjeVTOVDIjbDDDfQb
         EBCg==
X-Gm-Message-State: AOJu0Yx3JBjQ6Dj1FM3eJjRB6hstZ/Rr7S3yBVtQUMWj6hvxI0ploY6l
        cWsT1MnUgmA4AcGLvgorQMzjjATOfwiRA4H7E7Y=
X-Google-Smtp-Source: AGHT+IGDNu9XaR6qzbagXlfw/e4IMYemMCmpWBxJJ4MgXyWOk4jaKiMzD+SDoi1Hio1tCexm0N7XL20Ga2toGWiaOkI=
X-Received: by 2002:aa7:d699:0:b0:53e:21f6:d784 with SMTP id
 d25-20020aa7d699000000b0053e21f6d784mr5646548edr.8.1699878924092; Mon, 13 Nov
 2023 04:35:24 -0800 (PST)
MIME-Version: 1.0
References: <20231113085305.1823455-1-javierm@redhat.com> <9f3d3c8d-fbf1-485b-9c2a-4d442733954d@suse.de>
In-Reply-To: <9f3d3c8d-fbf1-485b-9c2a-4d442733954d@suse.de>
From:   Andrew Worsley <amworsley@gmail.com>
Date:   Mon, 13 Nov 2023 23:35:12 +1100
Message-ID: <CA+Y=x3khfKx_oQYABMSCAPOEuDWyZ+MyTHK=JufH8fC-m6z7Xw@mail.gmail.com>
Subject: Re: [RFC PATCH] of/platform: Disable sysfb if a simple-framebuffer
 node is found
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        Hector Martin <marcan@marcan.st>,
        Sergio Lopez <slp@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2023 at 20:18, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
>
>
> Am 13.11.23 um 09:51 schrieb Javier Martinez Canillas:
> > Some DT platforms use EFI to boot and in this case the EFI Boot Services
> > may register a EFI_GRAPHICS_OUTPUT_PROTOCOL handle, that will later be
> > queried by the Linux EFI stub to fill the global struct screen_info data.
> >
> > The data is used by the Generic System Framebuffers (sysfb) framework to
> > add a platform device with platform data about the system framebuffer.
> >
> > But if there is a "simple-framebuffer" node in the DT, the OF core will
> > also do the same and add another device for the system framebuffer.
> >
> > This could lead for example, to two platform devices ("simple-framebuffer"
> > and "efi-framebuffer") to be added and matched with their corresponding
> > drivers. So both efifb and simpledrm will be probed, leading to following:
> >
> > [    0.055752] efifb: framebuffer at 0xbd58dc000, using 16000k, total 16000k
> > [    0.055755] efifb: mode is 2560x1600x32, linelength=10240, pages=1
> > [    0.055758] efifb: scrolling: redraw
> > [    0.055759] efifb: Truecolor: size=2:10:10:10, shift=30:20:10:0
> > ...
> > [    3.295896] simple-framebuffer bd58dc000.framebuffer: [drm] *ERROR*
> > could not acquire memory range [??? 0xffff79f30a29ee40-0x2a5000001a7
> > flags 0x0]: -16
> > [    3.298018] simple-framebuffer: probe of bd58dc000.framebuffer
> > failed with error -16
> >
> > To prevent the issue, make the OF core to disable sysfb if there is a node
> > with a "simple-framebuffer" compatible. That way only this device will be
> > registered and sysfb would not attempt to register another one using the
> > screen_info data even if this has been filled.
> >
> > This seems the correct thing to do in this case because:
> >
> > a) On a DT platform, the DTB is the single source of truth since is what
> >     describes the hardware topology. Even if EFI Boot Services are used to
> >     boot the machine.
> >
> > b) The of_platform_default_populate_init() function is called in the
> >     arch_initcall_sync() initcall level while the sysfb_init() function
> >     is called later in the subsys_initcall() initcall level.
> >
> > Reported-by: Andrew Worsley <amworsley@gmail.com>
> > Closes: https://lore.kernel.org/all/20231111042926.52990-2-amworsley@gmail.com
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> > ---
> >
> >   drivers/of/platform.c | 18 ++++++++++++++++--
> >   1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index f235ab55b91e..0a692fdfef59 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -20,6 +20,7 @@
> >   #include <linux/of_irq.h>
> >   #include <linux/of_platform.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/sysfb.h>
> >
> >   #include "of_private.h"
> >
> > @@ -621,8 +622,21 @@ static int __init of_platform_default_populate_init(void)
> >               }
> >
> >               node = of_get_compatible_child(of_chosen, "simple-framebuffer");
> > -             of_platform_device_create(node, NULL, NULL);
> > -             of_node_put(node);
> > +             if (node) {
> > +                     /*
> > +                      * Since a "simple-framebuffer" device is already added
> > +                      * here, disable the Generic System Framebuffers (sysfb)
> > +                      * to prevent it from registering another device for the
> > +                      * system framebuffer later (e.g: using the screen_info
> > +                      * data that may had been filled as well).
> > +                      *
> > +                      * This can happen for example on DT systems that do EFI
> > +                      * booting and may provide a GOP handle to the EFI stub.
> > +                      */
> > +                     sysfb_disable();
> > +                     of_platform_device_create(node, NULL, NULL);
> > +                     of_node_put(node);
> > +             }
> >
> >               /* Populate everything else. */
> >               of_platform_default_populate(NULL, NULL, NULL);
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)

I applied the patch and just the simpledrm driver is probed (the efifb is not):

grep -i -E 'drm|efifb' --color -C3 dmesg-6.5.0-asahi-00780-gf5aadc85a34d.txt
[    2.621433] systemd-journald[276]: varlink-21: Changing state
idle-server \xe2\x86\x92 pending-disconnect
[    2.621437] systemd-journald[276]: varlink-21: Changing state
pending-disconnect \xe2\x86\x92 processing-disconnect
[    2.621439] systemd-journald[276]: varlink-21: Changing state
processing-disconnect \xe2\x86\x92 disconnected
[    2.878828] [drm] Initialized simpledrm 1.0.0 20200625 for
bd58dc000.framebuffer on minor 0
[    2.909764] Console: switching to colour frame buffer device 160x50
[    2.915628] tas2770 1-0031: Property ti,imon-slot-no is missing
setting default slot
[    2.915631] tas2770 1-0031: Property ti,vmon-slot-no is missing
setting default slot
--
[    2.921407] cs42l42 2-0048: supply VCP not found, using dummy regulator
[    2.921412] cs42l42 2-0048: supply VD_FILT not found, using dummy regulator
[    2.921416] cs42l42 2-0048: supply VL not found, using dummy regulator
[    2.934530] simple-framebuffer bd58dc000.framebuffer: [drm] fb0:
simpledrmdrmfb frame buffer device
[    2.938437] cs42l42 2-0048: CS42L42 Device ID (42A83). Expected 42A42
[    2.944183] cs42l83 2-0048: supply VA not found, using dummy regulator
[    2.944769] cs42l83 2-0048: supply VP not found, using dummy regulator

I am wondering if the drm_aperture_remove_framebuffers() shouldn't be
called in the probe function anyway
as it ends up overriding the efifb one as wanted and handles the case
the simpledrm (CONFIG_DRM_SIMPLEDRM)
is not present.
Perhaps there is an accepted principle that such kernels *should* fail
to set up a FB?

Andrew
