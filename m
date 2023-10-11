Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DE17C4CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjJKIKT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Oct 2023 04:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjJKIKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:10:14 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00791D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:10:03 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d89ba259964so7170876276.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697011802; x=1697616602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfwG+aQG5ziiDADRicTEYU9GeL07cKra21rSjb2Z7tI=;
        b=Nw2gda0uQdb65RiOtMrUEX7AKvYL9b9/FtR1vwAOjI4NYNnG7QSMaobriFVQ5m0XQ4
         7uL9qnbdQPFSqp4zkaJd+R3su9SLPP5IyEUCSXA/tsPtDhROCvNYjPEA8aUkBS91zsSW
         32lDG9+3FFrz89RTQRQEQxi2hD5wTTC9C8QR22tHDcT9VBTkQ6Sxt6E3JCGPMSUxM1k5
         woQSMTPRve7xwHVz7gx2sWyCTsXGs9BJxKR+d23jIyJJcPMk20NbpOcMPVkBRrvV4EF0
         FTCIn/5efBRaf8+vVfBmI1OQzOhPoS5axYg55YXA99ELkv+1VQ9eqlFD/XUkEsgENXky
         YKiQ==
X-Gm-Message-State: AOJu0YyFC2Rmm0clTbTu+k71JPxx8G950LYbQi3KABbcyaRRgFH+/Po1
        q7ovQoV5pzMEtthu28RVBy6uUT5WL5IkTA==
X-Google-Smtp-Source: AGHT+IGwciaLtSWA7KvEQ2IY74L0X59s9YX/W81keRg2JnYlswAdMbDkP5oV7ui9VqjWAeNeG7RfQg==
X-Received: by 2002:a5b:20d:0:b0:d15:7402:f7cd with SMTP id z13-20020a5b020d000000b00d157402f7cdmr19029027ybl.27.1697011802522;
        Wed, 11 Oct 2023 01:10:02 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 63-20020a251942000000b00d7ba4c5e31fsm4348899ybz.39.2023.10.11.01.10.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 01:10:02 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5a7c93507d5so15497057b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:10:01 -0700 (PDT)
X-Received: by 2002:a81:6c17:0:b0:59f:7dbe:5492 with SMTP id
 h23-20020a816c17000000b0059f7dbe5492mr23750753ywc.9.1697011801664; Wed, 11
 Oct 2023 01:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231009183522.543918-1-javierm@redhat.com> <20231009183522.543918-6-javierm@redhat.com>
In-Reply-To: <20231009183522.543918-6-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 Oct 2023 10:09:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX0gvW4Y5ppWi=qF6mZF00m4G-fP1-Wg+sKW43Ku5fz9A@mail.gmail.com>
Message-ID: <CAMuHMdX0gvW4Y5ppWi=qF6mZF00m4G-fP1-Wg+sKW43Ku5fz9A@mail.gmail.com>
Subject: Re: [PATCH 5/8] drm/ssd13xx: Add a per controller family functions table
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
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

Hi Javier,

On Mon, Oct 9, 2023 at 8:36 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> To allow the driver to decouple the common logic in the function callbacks
> from the behaviour that is specific of a given Solomon controller family.
>
> For this, include a chip family to the device info and add fields to the
> driver-private device struct, to store the hardware buffer maximum size,
> the intermediate buffer maximum size and pixel format, and a set of per
> chip family function handlers.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for your patch!

> --- a/drivers/gpu/drm/solomon/ssd13xx.c
> +++ b/drivers/gpu/drm/solomon/ssd13xx.c
> @@ -104,6 +104,7 @@ const struct ssd13xx_deviceinfo ssd13xx_variants[] = {
>                 .default_width = 132,
>                 .default_height = 64,
>                 .page_mode_only = 1,
> +               .family_id = SSD130X_FAMILY,

Why not store &ssd13xx_family_funcs[SSD130X_FAMILY]?

>         },
>         [SSD1305_ID] = {
>                 .default_vcomh = 0x34,

> @@ -602,6 +605,15 @@ static void ssd13xx_clear_screen(struct ssd13xx_device *ssd13xx, u8 *data_array)
>         }
>  }
>
> +static const struct ssd13xx_funcs ssd13xx_family_funcs[] = {
> +       [SSD130X_FAMILY] = {
> +               .init = ssd130x_init,
> +               .update_rect = ssd130x_update_rect,
> +               .clear_screen = ssd130x_clear_screen,
> +               .fmt_convert = drm_fb_xrgb8888_to_mono,
> +       },
> +};
> +
>  static int ssd13xx_fb_blit_rect(struct drm_framebuffer *fb,
>                                 const struct iosys_map *vmap,
>                                 struct drm_rect *rect, u8 *buf,

> @@ -1195,11 +1198,38 @@ static int ssd13xx_get_resources(struct ssd13xx_device *ssd13xx)
>         return 0;
>  }
>
> +static int ssd13xx_set_buffer_sizes(struct ssd13xx_device *ssd13xx,
> +                                   enum ssd13xx_family_ids family_id)
> +{
> +       const struct drm_format_info *fi;
> +       unsigned int buffer_pitch;
> +
> +       switch (family_id) {
> +       case SSD130X_FAMILY:
> +               unsigned int pages = DIV_ROUND_UP(ssd13xx->height, SSD130X_PAGE_HEIGHT);
> +
> +               ssd13xx->data_array_size = ssd13xx->width * pages;
> +
> +               fi = drm_format_info(DRM_FORMAT_R1);
> +               break;
> +       }

Please don't mix ssd13xx_funcs[family_id] and switch (family_id).
The switch() could be replaced by an extra function pointer in
ssd13xx_funcs, and by storing fi in ssd13xx_funcs, too.

Note that you don't really need the full drm_format_info, the number
of bits per pixel is sufficient.  But having the drm_format_info is
nice, as fmt_convert() will need it later when adding support for
fbdev emulation using R1 or R4 ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
