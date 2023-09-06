Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4EE793994
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbjIFKLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjIFKLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:11:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ECA1713
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 03:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693995058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hv8DYu7MTr4kuGV37i9sTqxH6eTvGFMuruIX7/nBGWo=;
        b=fzpEpczDwAQ4iW0XBRFn+aGDbqXHVjq5V7p1jyNlg+V2ynipNCixXQKGRpD8bN0tZDA9gc
        kkak29rdcVWwPrNRxyIjZzhJ4LluKWxQEQPkA64QrJKuyt+bqmc7AWjEmBjkblmmjKWoJv
        rxD2JfI00cIla5l3QdvMohRXeEHLLKs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-J5pm6bi9PvS7uP-0x22kLw-1; Wed, 06 Sep 2023 06:10:56 -0400
X-MC-Unique: J5pm6bi9PvS7uP-0x22kLw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2bceb2b3024so36386881fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 03:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693995055; x=1694599855;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hv8DYu7MTr4kuGV37i9sTqxH6eTvGFMuruIX7/nBGWo=;
        b=KSgmKrWTRv0d9UYyvHuYaDjJSELvoFMTO1ln6ZitNwE+czy7ByuEMBB9AyVFXMiowO
         0gADHGzMrJwveaNz/Ck3WbczgEVTSB4FF4DPHylKP8iFxAoh/icOochOtQMKLKn7Z5Rh
         o3tYA5KSS9ELwbtgDzlWYh4QVgi91uupygATGYa3NZaH0BGv1aBZu4+gwiQ8nG0FreXf
         IkzGbmYHeMjUO8e5BT8+Qbna42Ck/WR1ti+eqyVshBB5OMNjky4krgRq7trJA2Puj9Xi
         drg61qxS3x8XrTULR4VPJ+PUOxa1xO6k8LMfAB1ed4ehs+kTFkiMrS6uEoXeEuDuecq2
         T4xA==
X-Gm-Message-State: AOJu0YxujZFLQA68pRMOI3860YNIpXP9HKMjFW1wU4cAJ31RSxv620ar
        zwxIdO7aag7/ucOWPCR8XdVM5rdcuQtJpcWw4cABXklofozdsHMiRArTTPPfbIe3xUM8/uOVn4F
        XofwWz7kU4jQg9c8sBrlSLsl8
X-Received: by 2002:a2e:870d:0:b0:2bc:b9c7:7ba8 with SMTP id m13-20020a2e870d000000b002bcb9c77ba8mr1821975lji.43.1693995054991;
        Wed, 06 Sep 2023 03:10:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlEOBg4YUUo+ApwkDK41eZQoOWRKWT9hoI43BTnkb2886b1jJOEBUZMQKvCBA2uq3yLQagdg==
X-Received: by 2002:a2e:870d:0:b0:2bc:b9c7:7ba8 with SMTP id m13-20020a2e870d000000b002bcb9c77ba8mr1821960lji.43.1693995054655;
        Wed, 06 Sep 2023 03:10:54 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n17-20020a7bcbd1000000b003fee777fd84sm19425278wmi.41.2023.09.06.03.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:10:54 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 4/7] fbdev/core: Move logo functions into separate
 source file
In-Reply-To: <20230829142109.4521-5-tzimmermann@suse.de>
References: <20230829142109.4521-1-tzimmermann@suse.de>
 <20230829142109.4521-5-tzimmermann@suse.de>
Date:   Wed, 06 Sep 2023 12:10:53 +0200
Message-ID: <87fs3r4no2.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Move the fbdev function for displaying boot-up logos into their
> own file fb_logo.c. The file can later be build depending on the
> state of CONFIG_LOGO. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/fbdev/core/Makefile      |   1 +
>  drivers/video/fbdev/core/fb_internal.h |   6 +
>  drivers/video/fbdev/core/fb_logo.c     | 533 +++++++++++++++++++++++++
>  drivers/video/fbdev/core/fbmem.c       | 524 ------------------------
>  include/linux/fb.h                     |   5 -
>  5 files changed, 540 insertions(+), 529 deletions(-)
>  create mode 100644 drivers/video/fbdev/core/fb_logo.c
>
> diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
> index edfde2948e5c..adce31155e92 100644
> --- a/drivers/video/fbdev/core/Makefile
> +++ b/drivers/video/fbdev/core/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_FB_NOTIFY)           += fb_notify.o
>  obj-$(CONFIG_FB_CORE)             += fb.o
>  fb-y                              := fb_info.o \
> +                                     fb_logo.o \

Maybe instead of adding this unconditionally you could only add it when
CONFIG_LOGO is enabled ?

[...]

> diff --git a/drivers/video/fbdev/core/fb_logo.c b/drivers/video/fbdev/core/fb_logo.c
> new file mode 100644
> index 000000000000..76ba5a2bebae
> --- /dev/null
> +++ b/drivers/video/fbdev/core/fb_logo.c
> @@ -0,0 +1,533 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/export.h>
> +#include <linux/fb.h>
> +#include <linux/linux_logo.h>
> +
> +bool fb_center_logo __read_mostly;
> +int fb_logo_count __read_mostly = -1;
> +
> +#ifdef CONFIG_LOGO

[...]

> +#else
> +int fb_prepare_logo(struct fb_info *info, int rotate)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL(fb_prepare_logo);
> +
> +int fb_show_logo(struct fb_info *info, int rotate)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL(fb_show_logo);

I would move the CONFIG_LOGO #ifdefery to the header file and make these a
static inline function, instead of having the stubs here and exporting
symbols for functions that are a no-op.

I think that will also fix the issues that the robot complained about.

Other than that, the patch looks good to me.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

