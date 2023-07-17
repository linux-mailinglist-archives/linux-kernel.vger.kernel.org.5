Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A0B755EEF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjGQJEe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 05:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGQJEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:04:33 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3869DE55
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:04:32 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-57722942374so45426797b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689584671; x=1692176671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBuZRI7F/H2C0zseA6/qfKbTJuHceDqhSk1/NhSUIjI=;
        b=V8yX+scEEIJfkOCLs7ZQ96iMZ+vlEhdM29VihWlpflMe7L0GLcbyMvJFCP4uXdAr8W
         1Is0oxNGFuEy0ae6ziiXTgrlascygAu+lQwj5KgXQ7paK3fL0BBqFEZ9n4E6KN+QWNxk
         1Xg2C6Xnrq/nRozPPTT0M/nL4oZPj1hLRkrV9Y2lpp8m7MprXQFjLzPlZ0ZIy/Bpa12f
         Oq5QwgtvWvTeUKZifqoWtvgNJtv1uLds4gw/rwcpjCS+YXSFKlOKlrn5OMkZJk2QMR0d
         Q8RarUm1RlOQXzCTWAEJJE5QDGytnEgjLtOugiMQlyKBynV+4O4gvAOd0P4U8UMTIBg3
         IDtA==
X-Gm-Message-State: ABy/qLZrj18Z8FUTWlT34KvNRcHedrHS5nvTOwgY+vvu3vKmJ8ma29oj
        a0Fq3jnr2SHxnSiJjDSzPL1YfF8yDMU2tg==
X-Google-Smtp-Source: APBJJlEc+JHnl77pbiTii1IEjUb+iZ0r/+3SRoP5w/7PyUc7rtS/kgWM/MHu4xw8QQjBosGT018mOg==
X-Received: by 2002:a81:4954:0:b0:577:617c:8cd with SMTP id w81-20020a814954000000b00577617c08cdmr12110684ywa.35.1689584671044;
        Mon, 17 Jul 2023 02:04:31 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id a5-20020a0dd805000000b005832ca42ba6sm1014428ywe.3.2023.07.17.02.04.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 02:04:30 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-bdd069e96b5so4502457276.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:04:30 -0700 (PDT)
X-Received: by 2002:a25:abc5:0:b0:c24:4536:170c with SMTP id
 v63-20020a25abc5000000b00c244536170cmr12584321ybi.0.1689584670645; Mon, 17
 Jul 2023 02:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230713163213.1028952-1-javierm@redhat.com> <bbbb18e0-5de1-5155-c6b2-52a2b1d75898@suse.de>
In-Reply-To: <bbbb18e0-5de1-5155-c6b2-52a2b1d75898@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jul 2023 11:04:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVuLBTBymfEXDgHsDVavH6Ggq53fPep0T=dEWbztBWkjw@mail.gmail.com>
Message-ID: <CAMuHMdVuLBTBymfEXDgHsDVavH6Ggq53fPep0T=dEWbztBWkjw@mail.gmail.com>
Subject: Re: [PATCH] drm/ssd130x: Fix an oops when attempting to update a
 disabled plane
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Jul 17, 2023 at 10:48 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 13.07.23 um 18:32 schrieb Javier Martinez Canillas:
> > Geert reports that the following NULL pointer dereference happens for him
> > after commit 49d7d581ceaf ("drm/ssd130x: Don't allocate buffers on each
> > plane update"):
> >
> >      [drm] Initialized ssd130x 1.0.0 20220131 for 0-003c on minor 0
> >      ssd130x-i2c 0-003c: [drm] surface width(128), height(32), bpp(1)
> >      and format(R1   little-endian (0x20203152))
> >      Unable to handle kernel NULL pointer dereference at virtual address 00000000
> >      Oops [#1]
> >      CPU: 0 PID: 1 Comm: swapper Not tainted
> >      6.5.0-rc1-orangecrab-02219-g0a529a1e4bf4 #565
> >      epc : ssd130x_update_rect.isra.0+0x13c/0x340
> >       ra : ssd130x_update_rect.isra.0+0x2bc/0x340
> >      ...
> >      status: 00000120 badaddr: 00000000 cause: 0000000f
> >      [<c0303d90>] ssd130x_update_rect.isra.0+0x13c/0x340
> >      [<c0304200>] ssd130x_primary_plane_helper_atomic_update+0x26c/0x284
> >      [<c02f8d54>] drm_atomic_helper_commit_planes+0xfc/0x27c
> >      [<c02f9314>] drm_atomic_helper_commit_tail+0x5c/0xb4
> >      [<c02f94fc>] commit_tail+0x190/0x1b8
> >      [<c02f99fc>] drm_atomic_helper_commit+0x194/0x1c0
> >      [<c02c5d00>] drm_atomic_commit+0xa4/0xe4
> >      [<c02cce40>] drm_client_modeset_commit_atomic+0x244/0x278
> >      [<c02ccef0>] drm_client_modeset_commit_locked+0x7c/0x1bc
> >      [<c02cd064>] drm_client_modeset_commit+0x34/0x64
> >      [<c0301a78>] __drm_fb_helper_restore_fbdev_mode_unlocked+0xc4/0xe8
> >      [<c0303424>] drm_fb_helper_set_par+0x38/0x58
> >      [<c027c410>] fbcon_init+0x294/0x534
> >      ...
> >
> > The problem is that fbcon calls fbcon_init() which triggers a DRM modeset
> > and this leads to drm_atomic_helper_commit_planes() attempting to commit
> > the atomic state for all planes, even the ones whose CRTC is not enabled.
> >
> > Since the primary plane buffer is allocated in the encoder .atomic_enable
> > callback, this happens after that initial modeset commit and leads to the
> > mentioned NULL pointer dereference.
> >
> > Fix this by not using the default drm_atomic_helper_commit_tail() helper,
> > but instead the drm_atomic_helper_commit_tail_rpm() function that doesn't
> > attempt to commit the atomic state for planes related to inactive CRTCs.
> >
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

> > --- a/drivers/gpu/drm/solomon/ssd130x.c
> > +++ b/drivers/gpu/drm/solomon/ssd130x.c
> > @@ -795,6 +795,10 @@ static const struct drm_mode_config_funcs ssd130x_mode_config_funcs = {
> >       .atomic_commit = drm_atomic_helper_commit,
> >   };
> >
> > +static const struct drm_mode_config_helper_funcs ssd130x_mode_config_helpers = {
> > +     .atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
> > +};
> > +
>
> After some discussion on IRC, I'd suggest to allocate the buffer
> somewhere within probe. So it will always be there when the plane code runs.
>
> A full fix would be to allocate the buffer memory as part of the plane
> state and/or the plane's atomic_check. That's a bit more complicated if
> you want to shared the buffer memory across plane updates.

Note that actually two buffers are involved: data_array (monochrome,
needed for each update), and buffer (R8, only needed when converting
from XR24 to R1).

For the former, I agree, as it's always needed.
For the latter, I'm afraid it would set a bad example: while allocating
a possibly-unused buffer doesn't hurt for small displays, it would
mean wasting 1 MiB in e.g. the repaper driver (once it has gained
support for R1 ;^).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
