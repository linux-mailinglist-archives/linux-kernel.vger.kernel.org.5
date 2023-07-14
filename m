Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6717536CE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbjGNJlw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jul 2023 05:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbjGNJls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:41:48 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B0B1989
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:41:45 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5700b15c12fso15885067b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689327704; x=1691919704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvsgLCUoUYBwVIo5eyZX62ki0sLhfFVAuP7bUgSk5YE=;
        b=gwKKHPsZCo7N6OglpxMUJbxAZTCOag0hJmklAKjab9/G4nm/HNJ2nQ+3NzTLnOIVly
         Wc8+TRkm9x3ZsAlptqePc2zZ+w3RMe3p7tmHh39l0lwtM3lIzpX0nFUyxSNvj9w25zoL
         gUhd+z/6+8+Z0E8MVLZJWa8jmn3DU8G1+KP5YNHhjvaCGcjD+e6ItEIsqOI6aqauRbSa
         BevSP5QABmnWVEhcX8y1gmxKKV381zNqKqVxm754UZlhv9l10hgn7n8YaBwc4/Mtfs+/
         Z2bkIOkTOlLP82X7DRrY07SiiXtwelSuK+/5gW/XYlu+mEDWYpVgcgLDA21iJQR/yhpM
         K7Hg==
X-Gm-Message-State: ABy/qLakSu/k73VQgAVhy1JSPbd/PqQhc1+qlvvHNbQ0jCTc/dwvllCc
        Fv2XPG8udUse3cSsD4NwGzC/GufoJjBvmMKe
X-Google-Smtp-Source: APBJJlGh7nWS9Sbgo7su7PrGhtsrH075KFF8rrPk+nfLnIVQEv74f7JQS0wveMmBG9KVV+DYduu51A==
X-Received: by 2002:a0d:c341:0:b0:562:1060:f2c9 with SMTP id f62-20020a0dc341000000b005621060f2c9mr4980883ywd.13.1689327704353;
        Fri, 14 Jul 2023 02:41:44 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id j12-20020a81920c000000b0056d2a19ad91sm2200954ywg.103.2023.07.14.02.41.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 02:41:43 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-cae693192d1so1632636276.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:41:43 -0700 (PDT)
X-Received: by 2002:a25:b44:0:b0:bd7:545e:ab41 with SMTP id
 65-20020a250b44000000b00bd7545eab41mr3609366ybl.27.1689327702982; Fri, 14 Jul
 2023 02:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689252746.git.geert@linux-m68k.org> <54deec2ec533e90544faa8c60a0c2518c58f3e9c.1689252746.git.geert@linux-m68k.org>
 <87r0pau99o.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87r0pau99o.fsf@minerva.mail-host-address-is-not-set>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Jul 2023 11:41:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVAXPqjSNGMrZQ2g8FNNL4f7PbdoUCi17g9YOdoqmjFpQ@mail.gmail.com>
Message-ID: <CAMuHMdVAXPqjSNGMrZQ2g8FNNL4f7PbdoUCi17g9YOdoqmjFpQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] drm/ssd130x: Fix pitch calculation in ssd130x_fb_blit_rect()
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
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

Hi Javier,

On Fri, Jul 14, 2023 at 11:34 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > The page height must be taken into account only for vertical coordinates
> > and heights, not for horizontal coordinates and widths.
> >
> > Fixes: 179a790aaf2a0127 ("drm/ssd130x: Set the page height value in the device info data")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

> > --- a/drivers/gpu/drm/solomon/ssd130x.c
> > +++ b/drivers/gpu/drm/solomon/ssd130x.c
> > @@ -596,7 +596,7 @@ static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb, const struct iosys_m
> >       rect->y1 = round_down(rect->y1, page_height);
> >       rect->y2 = min_t(unsigned int, round_up(rect->y2, page_height), ssd130x->height);
> >
> > -     dst_pitch = DIV_ROUND_UP(drm_rect_width(rect), page_height);
> > +     dst_pitch = DIV_ROUND_UP(drm_rect_width(rect), 8);
> >
>
> That's true for ssd130x controllers that use R1, but when doing that
> change one of my goals was to prepare the driver for supporting the
> ssd132x family that use a 16-grayscale pixel format (R4).
>
> For those controllers, the pixels are encoded in 4-bit and each page
> has two pixels. So for those controllers the dst_pitch will need to
> be DIV_ROUND_UP(drm_rect_width(rect), 2) instead since the width is
> not 8 in that case.
>
> So I would prefer to skip this patch from your set, because otherwise
> we will need to revert it when adding support for SSD132x controllers.

My point is that the 8 as used here is related to the number of bits per pixel,
not to the page height.  The page height might also be impacted by the
number of bits per pixel, but that is orthogonal.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
