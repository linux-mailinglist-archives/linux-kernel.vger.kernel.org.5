Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19247532F9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbjGNHSx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jul 2023 03:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbjGNHSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:18:31 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88972D50
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:18:29 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-579dd20b1c8so13965167b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689319109; x=1691911109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAao7P7chUwnMdkU8LunFgLkqh5TGQLJMNbk3gX+1fs=;
        b=heKxjZoedJ2rr+o+yQvVJIiIBZwLawnb9y2YDXQX9Vxs3DuKMBujB3opYGhR9eRR79
         3Fk10jvQibX44mJS7GuWKwhD1tOUuJbLsimKRT0www7ygMqnPo3RhatMJl71oDWWtBiU
         gHkYozvyDA+rzjGq75CnCN4t2sKvCOtQSRrava6dMdKMaG/B9J3YgrbcOI6RdwmVM3T1
         N1lpqBWVHT8UYR83etfyX8Y3Lbd7AyDZNS1j2z32CuApXcJ6S/yjitm+oVVfFhnqAwOD
         Fc1TY6t8dcGIzOiJPueXIp0t75XZhFtFkvsuRfmVWrxTaacSd0FiPEj3GhpHd8h1I/ur
         ORZA==
X-Gm-Message-State: ABy/qLY01VnASxFn4S50uAwnkAN0am+t0GfKt1S3u+xMndjF8d/6SZ4+
        FepgYPM95jmFju8yxkb954z7aKphCoz9ZzcG
X-Google-Smtp-Source: APBJJlEMFXRJzE8EaUy9eR4hhALb+REh33CebzFi3fFp4VynCJ53e+6178v5w0+3K56wIGAJT6p57w==
X-Received: by 2002:a0d:f145:0:b0:561:e8d7:ac6b with SMTP id a66-20020a0df145000000b00561e8d7ac6bmr4029498ywf.49.1689319108781;
        Fri, 14 Jul 2023 00:18:28 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id i66-20020a816d45000000b0057060bb2874sm2199235ywc.37.2023.07.14.00.18.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 00:18:28 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-cacc3f97ee9so1523625276.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:18:28 -0700 (PDT)
X-Received: by 2002:a25:1854:0:b0:c6b:ffe2:1431 with SMTP id
 81-20020a251854000000b00c6bffe21431mr3074682yby.24.1689319107977; Fri, 14 Jul
 2023 00:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230713163213.1028952-1-javierm@redhat.com>
In-Reply-To: <20230713163213.1028952-1-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Jul 2023 09:18:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXbboXGYVezzw3_TEu8U6WR=q2x2NjD-aqeF91-DXOD3Q@mail.gmail.com>
Message-ID: <CAMuHMdXbboXGYVezzw3_TEu8U6WR=q2x2NjD-aqeF91-DXOD3Q@mail.gmail.com>
Subject: Re: [PATCH] drm/ssd130x: Fix an oops when attempting to update a
 disabled plane
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
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

On Thu, Jul 13, 2023 at 6:32 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Geert reports that the following NULL pointer dereference happens for him
> after commit 49d7d581ceaf ("drm/ssd130x: Don't allocate buffers on each
> plane update"):
>
>     [drm] Initialized ssd130x 1.0.0 20220131 for 0-003c on minor 0
>     ssd130x-i2c 0-003c: [drm] surface width(128), height(32), bpp(1)
>     and format(R1   little-endian (0x20203152))
>     Unable to handle kernel NULL pointer dereference at virtual address 00000000
>     Oops [#1]
>     CPU: 0 PID: 1 Comm: swapper Not tainted
>     6.5.0-rc1-orangecrab-02219-g0a529a1e4bf4 #565
>     epc : ssd130x_update_rect.isra.0+0x13c/0x340
>      ra : ssd130x_update_rect.isra.0+0x2bc/0x340
>     ...
>     status: 00000120 badaddr: 00000000 cause: 0000000f
>     [<c0303d90>] ssd130x_update_rect.isra.0+0x13c/0x340
>     [<c0304200>] ssd130x_primary_plane_helper_atomic_update+0x26c/0x284
>     [<c02f8d54>] drm_atomic_helper_commit_planes+0xfc/0x27c
>     [<c02f9314>] drm_atomic_helper_commit_tail+0x5c/0xb4
>     [<c02f94fc>] commit_tail+0x190/0x1b8
>     [<c02f99fc>] drm_atomic_helper_commit+0x194/0x1c0
>     [<c02c5d00>] drm_atomic_commit+0xa4/0xe4
>     [<c02cce40>] drm_client_modeset_commit_atomic+0x244/0x278
>     [<c02ccef0>] drm_client_modeset_commit_locked+0x7c/0x1bc
>     [<c02cd064>] drm_client_modeset_commit+0x34/0x64
>     [<c0301a78>] __drm_fb_helper_restore_fbdev_mode_unlocked+0xc4/0xe8
>     [<c0303424>] drm_fb_helper_set_par+0x38/0x58
>     [<c027c410>] fbcon_init+0x294/0x534
>     ...
>
> The problem is that fbcon calls fbcon_init() which triggers a DRM modeset
> and this leads to drm_atomic_helper_commit_planes() attempting to commit
> the atomic state for all planes, even the ones whose CRTC is not enabled.
>
> Since the primary plane buffer is allocated in the encoder .atomic_enable
> callback, this happens after that initial modeset commit and leads to the
> mentioned NULL pointer dereference.
>
> Fix this by not using the default drm_atomic_helper_commit_tail() helper,
> but instead the drm_atomic_helper_commit_tail_rpm() function that doesn't
> attempt to commit the atomic state for planes related to inactive CRTCs.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c
> @@ -795,6 +795,10 @@ static const struct drm_mode_config_funcs ssd130x_mode_config_funcs = {
>         .atomic_commit = drm_atomic_helper_commit,
>  };
>
> +static const struct drm_mode_config_helper_funcs ssd130x_mode_config_helpers = {
> +       .atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,

The docs say this is intended for drivers that support runtime_pm or
need the CRTC to be enabled to perform a commit.  Might be worthwhile
to add basic Runtime PM, so the I2C controller can go to sleep when
the display is not used.

> +};
> +
>  static const uint32_t ssd130x_formats[] = {
>         DRM_FORMAT_XRGB8888,
>  };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
