Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA29753986
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbjGNLc0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jul 2023 07:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjGNLcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:32:24 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BC42D79
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:32:23 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso1680146276.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689334343; x=1691926343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GHsf3+kOYGZ8Tt4qW6cXRgWp6sPt9tasFL1Jg1Sjy8=;
        b=lAa7aCYuMjPzF3DzJPrspG+QO6YAEMoLB94GFxTAWWbs058ssBu9w4Cj8E9kCCG0iN
         Fz8mFOh5VbuA6JxyKCx0k7b3eqS6YFLA5jmJG9H8yuZwZPIXfIuyeLzfP5y6axJsdW0R
         9QDDjcO6unzHWrXOBwjIDxgTulFCaTd02bhTWgFH4uwHsPRzedPh1IpBDlBxyr0d0g1c
         VV4p2qHmk+xNW7iB76AWaxkJR6Zf2DF6Xrjvj3FTPXp10B9hkxV7uX/OLpMMAsW7LX0U
         qTVBDQ783au0naiIDS4DQ9kENHkY9xbAKWZIlha4MDwAguTfYnv9VCCcRxdUCgJWTUhe
         r0fA==
X-Gm-Message-State: ABy/qLazzgLJkFauoyew4XJ9bgdry/zwMTF1C1KyNBoybO3QPn5Nfm++
        NKYPcZ4vOVyyf147XBzZhANtYDXGajH07A==
X-Google-Smtp-Source: APBJJlGhYo3fnO49TKxAvSgpgRqPQjEgjIW52wcpeDZ2DB1vOcUrKQJNB4ftJOmnZkDNc8RrHygmWw==
X-Received: by 2002:a25:8507:0:b0:c65:9103:4a54 with SMTP id w7-20020a258507000000b00c6591034a54mr3747727ybk.65.1689334342753;
        Fri, 14 Jul 2023 04:32:22 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id x126-20020a25ce84000000b00caec634aaeasm764242ybe.50.2023.07.14.04.32.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 04:32:22 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso1680128276.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:32:22 -0700 (PDT)
X-Received: by 2002:a25:4090:0:b0:bff:242b:78d0 with SMTP id
 n138-20020a254090000000b00bff242b78d0mr3970572yba.34.1689334342130; Fri, 14
 Jul 2023 04:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689252746.git.geert@linux-m68k.org> <00790d022752b672a28256db7b9393eca0801b99.1689252746.git.geert@linux-m68k.org>
 <87cz0uu6wq.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87cz0uu6wq.fsf@minerva.mail-host-address-is-not-set>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Jul 2023 13:32:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUSUFd0WaaEU7UsbODxPuJzetg-rP-1E7ZWz9d58rLBqQ@mail.gmail.com>
Message-ID: <CAMuHMdUSUFd0WaaEU7UsbODxPuJzetg-rP-1E7ZWz9d58rLBqQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] drm/fb-helper: Pass buffer format via drm_fb_helper_surface_size
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Fri, Jul 14, 2023 at 12:25 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > drm_fb_helper_single_fb_probe() first calls drm_fb_helper_find_sizes(),
> > followed by drm_fbdev_generic_helper_fb_probe():
> >   - The former tries to find a suitable buffer format, taking into
> >     account limitations of the whole display pipeline,
> >   - The latter just calls drm_mode_legacy_fb_format() again.
> >
> > Simplify this by passing the buffer format between these functions
> > via a new buffer format member in the drm_fb_helper_surface_size
> > structure.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
>
> [...]
>
> > -     drm_dbg_kms(dev, "surface width(%d), height(%d) and bpp(%d)\n",
> > +     drm_info(dev, "surface width(%d), height(%d), bpp(%d) and format(%p4cc)\n",
>
> You are promoting a debug printout here to info but that change is not
> mentioned in the commit message. If you think this will be useful, maybe
> do it as a separate patch ?

Oops, that was unintentional.  Will fix in v2.

> The rest of the patch looks good to me though.
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
