Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602BD7C4C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345117AbjJKHkC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Oct 2023 03:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344709AbjJKHkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:40:00 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644DE98
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:39:58 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5a7c95b8d14so15788377b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697009997; x=1697614797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/X15NrvY+cErHcD0y7I5v3H188ScfV0hu8n5YeLnxfI=;
        b=a90zCRxcWFVsHZFm9ArweUCeZOYwa79w8yjyW/22I/o/vTnpmjyOK3XHnPSsrkgREH
         7QZS8chVoJdFBCuzFZb80qmfZ50W7kDsdKRcv9MwnlsXk+DLhitn6+51JscXEX9973GR
         zkueJUEBEXlZeTmFvxq2ya6tcjii8dBuRoWjh0Rd0JMO12iAq8B19qdQA0NKJQjG77UG
         kMGYpC+0nL6jjI6SFMrbmnrzswNseZ96KLc0QrFm/cHoU4KjJDYWzQjwJanZz7UbbRPh
         84M7enoSM0xZGGuoEIk7FNFjsQSJOI2p1BB57cM+Pr9Xtu/Lh5pt0FeLOF9w07topa/E
         jVdg==
X-Gm-Message-State: AOJu0Yw+XXhVm2H/XUDUHHZ7m4GBXk9hL8XtQ2OIsXk//5Qo+jVfRhbI
        W63EiAPDvdtVEkI9Nn5V8YnesgUQtnId3A==
X-Google-Smtp-Source: AGHT+IG0vX85FGholTIVGaYFbfnWlBQPdcj9HCy48ngJBJ0kk9tsN0EmnwYP7zHyoxoFMVfJmnQwlg==
X-Received: by 2002:a5b:342:0:b0:d88:a049:e901 with SMTP id q2-20020a5b0342000000b00d88a049e901mr18560527ybp.7.1697009997362;
        Wed, 11 Oct 2023 00:39:57 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 63-20020a251942000000b00d7ba4c5e31fsm4337980ybz.39.2023.10.11.00.39.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 00:39:56 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a7af45084eso27144447b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:39:56 -0700 (PDT)
X-Received: by 2002:a0d:f4c7:0:b0:583:3c54:6d89 with SMTP id
 d190-20020a0df4c7000000b005833c546d89mr20550083ywf.44.1697009996484; Wed, 11
 Oct 2023 00:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231009183522.543918-1-javierm@redhat.com> <20231009183522.543918-4-javierm@redhat.com>
In-Reply-To: <20231009183522.543918-4-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 Oct 2023 09:39:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWSOcgV-qseaidUKcJswiJzr2+JQqB=k6tasaUXiEyiHw@mail.gmail.com>
Message-ID: <CAMuHMdWSOcgV-qseaidUKcJswiJzr2+JQqB=k6tasaUXiEyiHw@mail.gmail.com>
Subject: Re: [PATCH 3/8] drm/ssd13xx: Replace .page_height field in device
 info with a constant
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 8:36 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> This deemed useful to avoid hardcoding a page height and allow to support
> other Solomon controller families, but dividing the screen in pages seems
> to be something that is specific to the SSD130x chip family.
>
> For example, SSD132x chip family divides the screen in segments (columns)
> and common outputs (rows), so the concept of screen pages does not exist
> for the SSD132x family.
>
> Let's drop this field from the device info struct and just use a constant
> SSD130X_PAGE_HEIGHT macro to define the page height. While being there,
> replace hardcoded 8 values in places where it is used as the page height.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

> --- a/drivers/gpu/drm/solomon/ssd13xx.c
> +++ b/drivers/gpu/drm/solomon/ssd13xx.c

> @@ -465,13 +462,13 @@ static int ssd13xx_update_rect(struct ssd13xx_device *ssd13xx,
>         unsigned int width = drm_rect_width(rect);
>         unsigned int height = drm_rect_height(rect);
>         unsigned int line_length = DIV_ROUND_UP(width, 8);
> -       unsigned int page_height = ssd13xx->device_info->page_height;
> +       unsigned int page_height = SSD130X_PAGE_HEIGHT;
>         unsigned int pages = DIV_ROUND_UP(height, page_height);
>         struct drm_device *drm = &ssd13xx->drm;
>         u32 array_idx = 0;
>         int ret, i, j, k;
>
> -       drm_WARN_ONCE(drm, y % 8 != 0, "y must be aligned to screen page\n");
> +       drm_WARN_ONCE(drm, y % page_height != 0, "y must be aligned to screen page\n");
>
>         /*
>          * The screen is divided in pages, each having a height of 8
> @@ -503,27 +500,32 @@ static int ssd13xx_update_rect(struct ssd13xx_device *ssd13xx,
>          */
>
>         if (!ssd13xx->page_address_mode) {
> +               u8 page_start;
> +
>                 /* Set address range for horizontal addressing mode */
>                 ret = ssd13xx_set_col_range(ssd13xx, ssd13xx->col_offset + x, width);
>                 if (ret < 0)
>                         return ret;
>
> -               ret = ssd13xx_set_page_range(ssd13xx, ssd13xx->page_offset + y / 8, pages);
> +               page_start = ssd13xx->page_offset + y / page_height;
> +               ret = ssd13xx_set_page_range(ssd13xx, page_start, pages);
>                 if (ret < 0)
>                         return ret;
>         }
>
>         for (i = 0; i < pages; i++) {
> -               int m = 8;
> +               int m = page_height;
>
>                 /* Last page may be partial */
> -               if (8 * (y / 8 + i + 1) > ssd13xx->height)
> -                       m = ssd13xx->height % 8;
> +               if (page_height * (y / page_height + i + 1) > ssd13xx->height)
> +                       m = ssd13xx->height % page_height;
> +
>                 for (j = 0; j < width; j++) {
>                         u8 data = 0;
>
>                         for (k = 0; k < m; k++) {
> -                               u8 byte = buf[(8 * i + k) * line_length + j / 8];
> +                               u32 idx = (page_height * i + k) * line_length + j / 8;

Nit: I would use unsigned int for idx, as that matches all other
variables involved.
But given array_idx is u32, too, u32 may makes sense.

> +                               u8 byte = buf[idx];
>                                 u8 bit = (byte >> (j % 8)) & 1;
>
>                                 data |= bit << k;

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
