Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1537C4CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjJKINg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Oct 2023 04:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjJKINa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:13:30 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EE6D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:13:25 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d9a58aa4983so1805651276.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697012005; x=1697616805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7G9GTAzI4rCAAUwmLLyOfe0+LekJewZJGLAtbwyBuMM=;
        b=UMwCERTQiKyuZuPIS99BHoDidYm5yHjDZerASjd4/9OGxpwmKuUL8jUIvhPlBSSE8r
         0b0QN7LPDtCaKsgJm95uxczqZyk/HhA1D3YBsVHSsSrTanK3bvPi/awhx3YVlIIIs4dG
         TPAdvdFIjuQ8N7nGLlwGl5wH4hfk7N/Rx0kfqfG4u9QZGivw4E4lQhAkaagKlwOtb2FX
         xiqaCypi8ejERjw4nJXldVWnp0SUJMNuzwPibhfIN6NcA5Yegjf9/6HaR+Tp7qiWfQUz
         fu98XS/tqQq8iZfKrDbBnEt+fOSrJCWYDKt+K8qedPxYMfklaQRAwkaUWpURp98MUGn5
         nfTw==
X-Gm-Message-State: AOJu0Yw1Mj1zFVkt8/eb4GME4QchYKg0xLtGBVr8wInOeksPuhkt/Rmd
        pRvbbNZcoDgvIET/YX/6htppZZoPq9atAQ==
X-Google-Smtp-Source: AGHT+IGClBICYhcCZEgLe/YQGAVuPzdcevjb7zKq+SUuVfByEsVIQddeuwI108ouTVRrGiMmXPBOOw==
X-Received: by 2002:a05:6902:4e9:b0:d9a:68a5:975a with SMTP id w9-20020a05690204e900b00d9a68a5975amr3585278ybs.15.1697012004730;
        Wed, 11 Oct 2023 01:13:24 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id u74-20020a25ab50000000b00d7481ed7e45sm4376852ybi.56.2023.10.11.01.13.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 01:13:24 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a7ab31fb8bso27442717b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:13:24 -0700 (PDT)
X-Received: by 2002:a81:af4b:0:b0:5a7:af65:4ec6 with SMTP id
 x11-20020a81af4b000000b005a7af654ec6mr5764617ywj.32.1697012004282; Wed, 11
 Oct 2023 01:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231009183522.543918-1-javierm@redhat.com> <20231009183522.543918-8-javierm@redhat.com>
In-Reply-To: <20231009183522.543918-8-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 Oct 2023 10:13:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVnJPBfcaPSpeONuz0dPsWUD69_GnWXwbs9VPgN+fhmtw@mail.gmail.com>
Message-ID: <CAMuHMdVnJPBfcaPSpeONuz0dPsWUD69_GnWXwbs9VPgN+fhmtw@mail.gmail.com>
Subject: Re: [PATCH 7/8] drm/ssd13xx: Add support for the SSD132x OLED
 controller family
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
> The Solomon SSD132x controllers (such as the SSD1322, SSD1325 and SSD1327)
> are used by 16 grayscale dot matrix OLED panels, extend the driver to also
> support this chip family.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for your patch!

> --- a/drivers/gpu/drm/solomon/ssd13xx.c
> +++ b/drivers/gpu/drm/solomon/ssd13xx.c

> @@ -631,9 +821,12 @@ static int ssd13xx_fb_blit_rect(struct drm_framebuffer *fb,
>         unsigned int dst_pitch;
>         int ret = 0;
>
> -       /* Align y to display page boundaries */
> -       rect->y1 = round_down(rect->y1, SSD130X_PAGE_HEIGHT);
> -       rect->y2 = min_t(unsigned int, round_up(rect->y2, SSD130X_PAGE_HEIGHT), ssd13xx->height);
> +       if (ssd13xx->device_info->family_id == SSD130X_FAMILY) {
> +               /* Align y to display page boundaries */
> +               rect->y1 = round_down(rect->y1, SSD130X_PAGE_HEIGHT);
> +               rect->y2 = min_t(unsigned int, round_up(rect->y2, SSD130X_PAGE_HEIGHT),
> +                                ssd13xx->height);
> +       }

Don't you need to align to page boundaries (2 pixels per page)
on SSD132X?

This should be handled through ssd13xx_funcs instead of a family check.

>
>         dst_pitch = drm_format_info_min_pitch(fi, 0, drm_rect_width(rect));
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
