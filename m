Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D9C7523B4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbjGMN1K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 09:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbjGMN0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:26:48 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51177173B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:26:19 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1b0606bee45so581107fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689254765; x=1691846765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bg9WT8GiqVL500V6bD8ca2KAHdtJ4A5XuJqJli1xLtc=;
        b=GV96dK0eS1OTVXqoMDvb84dif4NfeEEC3mPBmOUygp/MTCYix+qBFz03p43/nClIeg
         /4OLT3htqt8aNsk5RYe8BVv3PQiaUsxHbwqqjsh5AMJAf8Ve74M/r8CglYE1/E7oxwgJ
         /Md/Ytu8ovR9ZVqKJNIrkyN0CiD6LWSZ0s4odssjalLn9/9vf/Wl9IukGaU0bX+xYJbk
         SuEGriWyp7ckZXsDC4ZkO02w6izXEuiB+uY1ouRcvVDuaqyiIGYdhIqWdA5MllD8ktsu
         XpiRli8r2SnCnA2Ben8mbcrpbMDva8JgcHJqrmY5338i/yrJ0sHCaLHGaQFFPLoAucuE
         aTWw==
X-Gm-Message-State: ABy/qLYteIaVgY76Sgy2zctr0WDpI9LFs5tmds1iNqmJhwwjpZeqDt7X
        6MSXZ234SIraxhccmdy96DwoBmOcJ9tyvYzr
X-Google-Smtp-Source: APBJJlHo6uFhEuwtkNADqDUgNbzxuEI82N5X7wTjA/6E90deIq3TGb4H8730q4nvf9XAwkkHC6srsQ==
X-Received: by 2002:a05:6870:fb87:b0:1b3:7f59:c681 with SMTP id kv7-20020a056870fb8700b001b37f59c681mr1772952oab.46.1689254765230;
        Thu, 13 Jul 2023 06:26:05 -0700 (PDT)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com. [209.85.160.45])
        by smtp.gmail.com with ESMTPSA id i19-20020a4a8d93000000b005660ed0becesm2858752ook.39.2023.07.13.06.26.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 06:26:04 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1b06ea7e7beso596309fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:26:04 -0700 (PDT)
X-Received: by 2002:a05:6870:589b:b0:1b0:40b0:114c with SMTP id
 be27-20020a056870589b00b001b040b0114cmr2014075oab.43.1689254764671; Thu, 13
 Jul 2023 06:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230609170941.1150941-1-javierm@redhat.com> <20230609170941.1150941-5-javierm@redhat.com>
 <CAMuHMdVXhi52KfpCmnum+9t74UWP+AOLE95xQU6VV6Nz=VHk1Q@mail.gmail.com> <87fs5sgdfh.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87fs5sgdfh.fsf@minerva.mail-host-address-is-not-set>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Jul 2023 15:25:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWmJjGX+s=z0bBMDz0=zqZJHrGhkzWyRkmstS0eW9aiTg@mail.gmail.com>
Message-ID: <CAMuHMdWmJjGX+s=z0bBMDz0=zqZJHrGhkzWyRkmstS0eW9aiTg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] drm/ssd130x: Don't allocate buffers on each plane update
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Thu, Jul 13, 2023 at 3:21 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > On Fri, Jun 9, 2023 at 7:09 PM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
> >> The resolutions for these panels are fixed and defined in the Device Tree,
> >> so there's no point to allocate the buffers on each plane update and that
> >> can just be done once.
> >>
> >> Let's do the allocation and free on the encoder enable and disable helpers
> >> since that's where others initialization and teardown operations are done.
> >>
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> ---
> >>
> >> (no changes since v1)
> >
> > Thanks for your patch, which is now commit 49d7d581ceaf4cf8
> > ("drm/ssd130x: Don't allocate buffers on each plane update") in
> > drm-misc/for-linux-next.
> >
> >> --- a/drivers/gpu/drm/solomon/ssd130x.c
> >> +++ b/drivers/gpu/drm/solomon/ssd130x.c
> >> @@ -701,14 +709,22 @@ static void ssd130x_encoder_helper_atomic_enable(struct drm_encoder *encoder,
> >>                 return;
> >>
> >>         ret = ssd130x_init(ssd130x);
> >> -       if (ret) {
> >> -               ssd130x_power_off(ssd130x);
> >> -               return;
> >> -       }
> >> +       if (ret)
> >> +               goto power_off;
> >> +
> >> +       ret = ssd130x_buf_alloc(ssd130x);
> >
> > This appears to be too late, causing a NULL pointer dereference:
> >
>
> Thanks for reporting this issue.
>
> > [   59.302761] [<c0303d90>] ssd130x_update_rect.isra.0+0x13c/0x340
> > [   59.304231] [<c0304200>]
> > ssd130x_primary_plane_helper_atomic_update+0x26c/0x284
> > [   59.305716] [<c02f8d54>] drm_atomic_helper_commit_planes+0xfc/0x27c
> >
>
> I wonder how this could be too late. I thought that the encoder
> .atomic_enable callback would be called before any plane .atomic_update.
>
> > Bailing out from ssd130x_update_rect() when data_array is still NULL
> > fixes that.
> >
>
> Maybe we can add that with a drm_WARN() ? I still want to understand how
> a plane update can happen before an encoder enable.

Full log is:

    ssd130x-i2c 0-003c: supply vcc not found, using dummy regulator
    [drm] Initialized ssd130x 1.0.0 20220131 for 0-003c on minor 0
    ssd130x-i2c 0-003c: [drm] surface width(128), height(32), bpp(1)
and format(R1   little-endian (0x20203152))
    Unable to handle kernel NULL pointer dereference at virtual address 00000000
    Oops [#1]
    CPU: 0 PID: 1 Comm: swapper Not tainted
6.5.0-rc1-orangecrab-02219-g0a529a1e4bf4 #565
    epc : ssd130x_update_rect.isra.0+0x13c/0x340
     ra : ssd130x_update_rect.isra.0+0x2bc/0x340
    epc : c0303d90 ra : c0303f10 sp : c182b5b0
     gp : c06d37f0 tp : c1828000 t0 : 00000064
     t1 : 00000000 t2 : 00000000 s0 : c182b600
     s1 : c2044000 a0 : 00000000 a1 : 00000000
     a2 : 00000008 a3 : a040f080 a4 : 00000000
     a5 : 00000000 a6 : 00001000 a7 : 00000008
     s2 : 00000004 s3 : 00000080 s4 : c2045000
     s5 : 00000010 s6 : 00000080 s7 : 00000000
     s8 : 00000000 s9 : a040f000 s10: 00000008
     s11: 00000000 t3 : 00000153 t4 : c2050ef4
     t5 : c20447a0 t6 : 00000080
    status: 00000120 badaddr: 00000000 cause: 0000000f
    [<c0303d90>] ssd130x_update_rect.isra.0+0x13c/0x340
    [<c0304200>] ssd130x_primary_plane_helper_atomic_update+0x26c/0x284
    [<c02f8d54>] drm_atomic_helper_commit_planes+0xfc/0x27c
    [<c02f9314>] drm_atomic_helper_commit_tail+0x5c/0xb4
    [<c02f94fc>] commit_tail+0x190/0x1b8
    [<c02f99fc>] drm_atomic_helper_commit+0x194/0x1c0
    [<c02c5d00>] drm_atomic_commit+0xa4/0xe4
    [<c02cce40>] drm_client_modeset_commit_atomic+0x244/0x278
    [<c02ccef0>] drm_client_modeset_commit_locked+0x7c/0x1bc
    [<c02cd064>] drm_client_modeset_commit+0x34/0x64
    [<c0301a78>] __drm_fb_helper_restore_fbdev_mode_unlocked+0xc4/0xe8
    [<c0303424>] drm_fb_helper_set_par+0x38/0x58
    [<c027c410>] fbcon_init+0x294/0x534
    [<c02af188>] visual_init+0xac/0x114
    [<c02b1834>] do_bind_con_driver.isra.0+0x1bc/0x39c
    [<c02b2fcc>] do_take_over_console+0x128/0x1b4
    [<c027ad24>] do_fbcon_takeover+0x74/0xfc
    [<c027e704>] fbcon_fb_registered+0x168/0x1b4
    [<c0275c84>] register_framebuffer+0x180/0x238
    [<c03017a4>] __drm_fb_helper_initial_config_and_unlock+0x328/0x538
    [<c0303844>] drm_fb_helper_initial_config+0x40/0x54
    [<c0300818>] drm_fbdev_generic_client_hotplug+0x98/0xdc
    [<c0300c5c>] drm_fbdev_generic_setup+0x9c/0x178
    [<c0304fa0>] ssd130x_probe+0x5e0/0x788
    [<c030522c>] ssd130x_i2c_probe+0x4c/0x70
    [<c0358464>] i2c_device_probe+0x120/0x1f0
    [<c030e5a4>] really_probe+0xb8/0x30c
    [<c030e974>] __driver_probe_device+0x17c/0x1c8
    [<c030ea0c>] driver_probe_device+0x4c/0x140
    [<c030ebe4>] __device_attach_driver+0xe4/0x150
    [<c030ccc4>] bus_for_each_drv+0x8c/0x100
    [<c030f034>] __device_attach+0x12c/0x1ac
    [<c030f3e0>] device_initial_probe+0x18/0x28
    [<c030cf14>] bus_probe_device+0xcc/0xd0
    [<c030b274>] device_add+0x5d8/0x7b4
    [<c030b474>] device_register+0x24/0x38
    [<c0358f24>] i2c_new_client_device+0x1a8/0x2b8
    [<c035b960>] of_i2c_register_devices+0xdc/0x164
    [<c0359750>] i2c_register_adapter+0x1b8/0x56c
    [<c0359eb0>] i2c_add_adapter+0x94/0x100
    [<c035d47c>] __i2c_bit_add_bus+0xc0/0x460
    [<c035d838>] i2c_bit_add_bus+0x1c/0x2c
    [<c035da20>] litex_i2c_probe+0x108/0x164
    [<c0310de4>] platform_probe+0x54/0xb0
    [<c030e5a4>] really_probe+0xb8/0x30c
    [<c030e974>] __driver_probe_device+0x17c/0x1c8
    [<c030ea0c>] driver_probe_device+0x4c/0x140
    [<c030ed74>] __driver_attach+0x124/0x1f4
    [<c030c880>] bus_for_each_dev+0x84/0xf4
    [<c030f4f8>] driver_attach+0x28/0x38
    [<c030d174>] bus_add_driver+0x120/0x214
    [<c030fc90>] driver_register+0x70/0x15c
    [<c0311d98>] __platform_driver_register+0x28/0x38
    [<c0520958>] litex_i2c_driver_init+0x24/0x34
    [<c0507fe8>] do_one_initcall+0x80/0x238
    [<c05083d4>] kernel_init_freeable+0x1b4/0x238
    [<c04fdd9c>] kernel_init+0x24/0x144
    [<c00022d8>] ret_from_fork+0x10/0x24

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
