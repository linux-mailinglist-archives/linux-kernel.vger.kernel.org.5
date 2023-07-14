Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D0D7536B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbjGNJgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjGNJf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:35:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01481173F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689327256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tomnXjxAClsXXjmt2CtXXzFMGlnovEg82VMD7EM7NSg=;
        b=hF0WDDcUmwmTZVSAfeTDswSUreLSl7NOenbhc/1WM+04hZklrszZbE07ploZ6PIEhfcJ1+
        CLHpexTaBecpj4PVTNsGvaT6JMiaQSJSpaep+J5z3hpicuabYfkZI+B7jdTcRJT5n4yGKS
        LhLNXWwGdlqko+rOXZBELBU0GYgDBYY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-i5nVsJtwNIuCQaPYqHzd6Q-1; Fri, 14 Jul 2023 05:34:15 -0400
X-MC-Unique: i5nVsJtwNIuCQaPYqHzd6Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-313e6020882so1135696f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689327254; x=1691919254;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tomnXjxAClsXXjmt2CtXXzFMGlnovEg82VMD7EM7NSg=;
        b=XEE4mT+3tLdTRQN1wL8O5Hg+UkvHMTb5OAeAKcJXBvNj/TyNFNkHqdBxIp5AFDRr7w
         5oi0bfdGu1TRh8huRj3ZRm0wuPDoShiwpru3u+2mlQ3tIW8IJc3TyRSXAnQgCIDJGxTg
         PM6HI9pXaNbuR4HtMR1a7NFo0iR4OjYOhlGfAkNxwkBXrqxIzryG6xkVzNH8hWDyBVMw
         pr/EM9l8pqFz6T41Ob6OUdYwJ5IZu+hAYo7lXibdLPgjcacUl4EzP3z5YQIZh6uWK8bI
         5mrICTxJw2GwuEYdyLJYg6T6KlAZspmQdic/2HXb6ZRb5uaG3WUy4jHNHJORTUXJxa1g
         jQTg==
X-Gm-Message-State: ABy/qLakA/P09WHI98ItKr2ewcrjCCYqduJIvrAYVsxGUPvVojt5wNov
        jymd78OKUQpSnyqFRbUbG9V0QKDcQcbHHzZpMIlukyjgQ2kY4YaQfWFlIdc+HPfFZwAJ/F53gqf
        6+Vko2thWAaYwcegsD54Vvd50P3OGG7SP
X-Received: by 2002:adf:ef04:0:b0:314:385d:3f32 with SMTP id e4-20020adfef04000000b00314385d3f32mr1868991wro.29.1689327253972;
        Fri, 14 Jul 2023 02:34:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGlN1baoTS0XRh4Lep0MfIU2RSnGLx0MemZn1GdGq2pOjqBhMm1RbYRqPn3kOwZi4UbTW1kfQ==
X-Received: by 2002:adf:ef04:0:b0:314:385d:3f32 with SMTP id e4-20020adfef04000000b00314385d3f32mr1868979wro.29.1689327253654;
        Fri, 14 Jul 2023 02:34:13 -0700 (PDT)
Received: from localhost ([91.126.32.244])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c230c00b003f90b9b2c31sm990232wmo.28.2023.07.14.02.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 02:34:12 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/8] drm/ssd130x: Fix pitch calculation in
 ssd130x_fb_blit_rect()
In-Reply-To: <54deec2ec533e90544faa8c60a0c2518c58f3e9c.1689252746.git.geert@linux-m68k.org>
References: <cover.1689252746.git.geert@linux-m68k.org>
 <54deec2ec533e90544faa8c60a0c2518c58f3e9c.1689252746.git.geert@linux-m68k.org>
Date:   Fri, 14 Jul 2023 11:34:11 +0200
Message-ID: <87r0pau99o.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert,

Thanks for your patch!

> The page height must be taken into account only for vertical coordinates
> and heights, not for horizontal coordinates and widths.
>
> Fixes: 179a790aaf2a0127 ("drm/ssd130x: Set the page height value in the device info data")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/gpu/drm/solomon/ssd130x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
> index afb08a8aa9fcdaf2..b4c376962629580b 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c
> @@ -596,7 +596,7 @@ static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb, const struct iosys_m
>  	rect->y1 = round_down(rect->y1, page_height);
>  	rect->y2 = min_t(unsigned int, round_up(rect->y2, page_height), ssd130x->height);
>  
> -	dst_pitch = DIV_ROUND_UP(drm_rect_width(rect), page_height);
> +	dst_pitch = DIV_ROUND_UP(drm_rect_width(rect), 8);
>

That's true for ssd130x controllers that use R1, but when doing that
change one of my goals was to prepare the driver for supporting the
ssd132x family that use a 16-grayscale pixel format (R4).

For those controllers, the pixels are encoded in 4-bit and each page
has two pixels. So for those controllers the dst_pitch will need to
be DIV_ROUND_UP(drm_rect_width(rect), 2) instead since the width is
not 8 in that case.

So I would prefer to skip this patch from your set, because otherwise
we will need to revert it when adding support for SSD132x controllers.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

