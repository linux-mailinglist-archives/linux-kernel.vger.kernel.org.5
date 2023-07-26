Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFF37635CE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjGZMEa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 08:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGZME1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:04:27 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D871FAA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:04:26 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6b9d68a7abaso5293334a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690373066; x=1690977866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8EFa5XQd76ZWyggXmDp/7dYxuK3+nTVxrOJ5ZnejRg=;
        b=D77IPW98frQ6lcbelUA6c1NWiqfsVhuh2u11NopcP6uZ/XdvMmocd+KjEuPNNUR9vn
         KDG1/rpKpRb+G1e2Y+UGcDQ3YUwG8fvLKGLWQT62eAwHvafy1w6ZpkbxCCpl1anartZc
         DcWcDe7LUGASyN2NdwXbx6m7EWHn8Yzeapmkm1I+HVZpXgjiG+9fX2WzPg8nfkwc7wLG
         ssjYzJULCQEvHaQFJTRin1CK/17DHbVOx0B2x4xyq732UapGhLX0giJ2vkMXt9Ok2GJj
         jMekvS5oK/VsFvFvmL2ndmPgeZUF6M8G6lMSMt//wmsVqrnqZQ28hIC81SFdtNaE37SV
         9JGg==
X-Gm-Message-State: ABy/qLYeTmpORPL7dxxGcdJBy4gl5undW4MUvBE5fFsGSkFm7sRQTUCZ
        kUfo/pe09gAiV2ndparTSvM7mKUCQ+BTOQ==
X-Google-Smtp-Source: APBJJlEK9i9XrZAjiTS3mcDdcvnUdmU+HPfOzudAXZqZFkDEkv5vI1E8b0L9NTnYwxHTOCHDenwvpA==
X-Received: by 2002:a05:6870:56a9:b0:17f:7388:4c69 with SMTP id p41-20020a05687056a900b0017f73884c69mr2505527oao.30.1690373065971;
        Wed, 26 Jul 2023 05:04:25 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id i199-20020a816dd0000000b005774338d039sm1810429ywc.96.2023.07.26.05.04.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 05:04:25 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5839f38342fso60333687b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:04:25 -0700 (PDT)
X-Received: by 2002:a05:6902:523:b0:ced:974a:1aae with SMTP id
 y3-20020a056902052300b00ced974a1aaemr1534872ybs.58.1690373065221; Wed, 26 Jul
 2023 05:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230726105433.389740-1-javierm@redhat.com> <20230726105433.389740-2-javierm@redhat.com>
In-Reply-To: <20230726105433.389740-2-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jul 2023 14:04:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1ECG44BMOb5zK_N1cZCpjoKmms2p_80+_F72HH0NBEA@mail.gmail.com>
Message-ID: <CAMuHMdX1ECG44BMOb5zK_N1cZCpjoKmms2p_80+_F72HH0NBEA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] drm/ssd130x: Allocate buffer in the plane's
 .atomic_check() callback
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Wed, Jul 26, 2023 at 12:55 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Drivers are not allowed to fail after drm_atomic_helper_swap_state() has
> been called and the new atomic state is stored into the current sw state.
>
> Since the struct ssd130x_device .data_array is allocated in the encoder's
> .atomic_enable callback, the operation can fail and this is after the new
> state has been stored. So it can break an atomic mode settings assumption.
>
> Fix this by having custom helpers to allocate, duplicate and destroy the
> plane state, that will take care of allocating and freeing these buffers.
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>
> Changes in v5:
> - Add collected tags from Maxime and Geert.
> - Update commit message to not mention the kernel oops (Geert Uytterhoeven).
> - Drop Reported-by and Fixes tags (Geert Uytterhoeven).
> - Update comment about buffer and data_array fields (Geert Uytterhoeven).
> - Remove superfluous NULL check in ssd130x_fb_blit_rect() (Geert Uytterhoeven).
> - Reset .buffer to NULL if .data_array allocation fails (Geert Uytterhoeven).
> - Inline buffer alloc/free helper functions (Geert Uytterhoeven).

Thanks for the update!

> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c

> @@ -535,7 +550,8 @@ static int ssd130x_update_rect(struct ssd130x_device *ssd130x, struct drm_rect *
>         return ret;
>  }
>
> -static void ssd130x_clear_screen(struct ssd130x_device *ssd130x)
> +static void ssd130x_clear_screen(struct ssd130x_device *ssd130x,
> +                                struct ssd130x_plane_state *ssd130x_state)
>  {
>         struct drm_rect fullscreen = {
>                 .x1 = 0,
> @@ -544,21 +560,21 @@ static void ssd130x_clear_screen(struct ssd130x_device *ssd130x)
>                 .y2 = ssd130x->height,
>         };
>
> -       ssd130x_update_rect(ssd130x, &fullscreen);
> +       ssd130x_update_rect(ssd130x, ssd130x_state, &fullscreen);

I've just realized another issue: since 49d7d581ceaf4cf8 ("drm/ssd130x:
Don't allocate buffers on each plane update"). this no longer
clears the screens, but just updates the hardware with the data in
ssd130x_device.buffer, i.e. with the last image shown.
So this should at least clear all of ssd130x_device.buffer before
calling ssd130x_update_rect().

As it's a bit pointless to transpose a black image, a better fix would
be to just clear ssd130x.data_array, and call the low-level hardware
functions like ssd130x_update_rect() does.

>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
