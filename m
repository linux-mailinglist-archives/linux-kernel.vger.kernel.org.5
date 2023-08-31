Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B4078E771
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbjHaH4o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Aug 2023 03:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjHaH4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:56:43 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60811A3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:56:39 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-58df8cab1f2so6888627b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693468599; x=1694073399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52E1H+CStLtbMwxlYSENmQFJDY+5NaKvwrzRLoKXXlQ=;
        b=iX4caWzJGUpXtaKEP95EtZtbTcM68SUktQtUi9kTurmxN9GB63XC2jigCqASD+rWk1
         UpsAu2LdBHRPIgqd4rDbfBFM8kUvwARcBtbuLLoVytCko4zBh1RuqOwTDYmEEEoFCjTG
         Tg2BFvJ06klvxdb/rgaZJ0bBNgqhvcM8IZnDRVDjOxsak6ClcPoLfrQ0OcAqLGAT4dBe
         RGMQoZB0xtBx2d/Vk2he+Ww+cN0ywT5WkZ2txLaeRRb91qTiMBLPyIBSXJBkukgx4ttg
         ZE6M2c5dHHVRzYQUm9/cmJKWUSQvf1Hk5W351FY+VUMwW25oe0k0FZkj8/TNk0FWhwpI
         K/jg==
X-Gm-Message-State: AOJu0YzXO5yimk+gY6Kz/DM2zALpVpFHfxKs6XoFV4AjAjccpJDzru2t
        nz97U1jyjlUrAOhgfW4SbvWYSBeauBmWww==
X-Google-Smtp-Source: AGHT+IGk+B2vG/THrnzl3n13Zmgzabgz0rtp9z+B0/T2J2CdJVboVJ/VEE1r870MaZEZdnaLGzFwwA==
X-Received: by 2002:a0d:fb81:0:b0:592:ffc:c787 with SMTP id l123-20020a0dfb81000000b005920ffcc787mr4625696ywf.30.1693468598809;
        Thu, 31 Aug 2023 00:56:38 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id t76-20020a0dea4f000000b005922c29c025sm261588ywe.108.2023.08.31.00.56.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 00:56:37 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d7b91422da8so318374276.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:56:37 -0700 (PDT)
X-Received: by 2002:a25:7356:0:b0:d7b:37de:2f6e with SMTP id
 o83-20020a257356000000b00d7b37de2f6emr4801334ybc.39.1693468587194; Thu, 31
 Aug 2023 00:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692888745.git.geert@linux-m68k.org> <16d488639e99f43ca3977ee7b8f76fc26c34aa86.1692888745.git.geert@linux-m68k.org>
 <1a98bb80-9990-dc65-5f14-066315a7e7d8@suse.de>
In-Reply-To: <1a98bb80-9990-dc65-5f14-066315a7e7d8@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 31 Aug 2023 09:56:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWmHsfOwSa_Owm2rShsMrmMSfa6eVkFz8Y0K_DmhxxZ4A@mail.gmail.com>
Message-ID: <CAMuHMdWmHsfOwSa_Owm2rShsMrmMSfa6eVkFz8Y0K_DmhxxZ4A@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] drm/dumb-buffers: Fix drm_mode_create_dumb() for
 bpp < 8
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Aug 31, 2023 at 9:40 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 24.08.23 um 17:08 schrieb Geert Uytterhoeven:
> > drm_mode_create_dumb() calculates the number of characters per pixel
> > from the number of bits per pixel by rounding up, which is not correct
> > as the actual value of cpp may be non-integer.  While we do not need to
> > care here about complex formats like YUV, bpp < 8 is a valid use case.
> >
> >    - The overflow check for the buffer width is not correct if bpp < 8.
> >      However, it doesn't hurt, as widths larger than U32_MAX / 8 should
> >      not happen for real anyway.  Add a comment to clarify.
> >    - Calculating the stride from the number of characters per pixel is
> >      not correct.  Fix this by calculating it from the number of bits per
> >      pixel instead.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> > Tested-by: Javier Martinez Canillas <javierm@redhat.com>
> > ---
> > v2:
> >    - Add Reviewed-by, Tested-by.
> > ---
> >   drivers/gpu/drm/drm_dumb_buffers.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/drm_dumb_buffers.c b/drivers/gpu/drm/drm_dumb_buffers.c
> > index 70032bba1c97e787..21a04c32a5e3d785 100644
> > --- a/drivers/gpu/drm/drm_dumb_buffers.c
> > +++ b/drivers/gpu/drm/drm_dumb_buffers.c
> > @@ -71,10 +71,11 @@ int drm_mode_create_dumb(struct drm_device *dev,
> >       /* overflow checks for 32bit size calculations */
> >       if (args->bpp > U32_MAX - 8)
> >               return -EINVAL;
> > +     /* Incorrect (especially if bpp < 8), but doesn't hurt much */
> >       cpp = DIV_ROUND_UP(args->bpp, 8);
> >       if (cpp > U32_MAX / args->width)
> >               return -EINVAL;
>
> At first, I was confused by this.

Me too ;-)

> So I'd really prefer to outright
> delete this code. As you say, it's incorrect and doesn't add anything.
> The concept of cpp is somewhat wrong anyway.
>
> > -     stride = cpp * args->width;
> > +     stride = DIV_ROUND_UP(args->bpp * args->width, 8);
>
> Do we need an overflow check for (bpp * width < U32_MAX) ?

I think I thought it would be covered by the above, but on more thought,
that is indeed not true.

So perhaps drop the cpp code above, and test bpp instead:

    -        cpp = DIV_ROUND_UP(args->bpp, 8);
    -        if (cpp > U32_MAX / args->width)
    +        if (args->bpp > U32_MAX / args->width)
                     return -EINVAL;

That would preclude a very wide buffer with height 1, though.

BTW, in v1 I also had this question:

    Why is drm_mode_create_dumb.size __u64?  The test for "args->height >
    U32_MAX / stride" rejects all sizes not fitting in __u32 anyway.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
