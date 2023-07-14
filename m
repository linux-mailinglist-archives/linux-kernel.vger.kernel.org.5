Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6CD75371A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjGNJvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjGNJvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6681BD4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689328215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tBjp82gLLLlocN70gzT39Xi/h+/6LoHEroJf4qpzUyQ=;
        b=Vg/STtZ0aJv8jCD9kFc5pmA6vETyBGgIPTpPBjAioD5tO0Io1QmWJ1cj/iHcL7Q2/11wMt
        8HwESYrkWL1SGHomRwxQAu3k/2A7/ZAQfAD+O++a8uhR6hRqwjZtzSPo3twBfZWAnhgUDq
        FU2fMXMzu+cwN8G6kp3AzYHV/74aBx0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-dAtySRrUNHmm1ql7wZKQwg-1; Fri, 14 Jul 2023 05:50:14 -0400
X-MC-Unique: dAtySRrUNHmm1ql7wZKQwg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-315998d6e7fso1013033f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689328213; x=1691920213;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBjp82gLLLlocN70gzT39Xi/h+/6LoHEroJf4qpzUyQ=;
        b=kSb9HSLbxJe9u5InDJgbs80stXB8dzr6yd7hg9ClnCfKnxd1HjvXJCIA6ydaNLNDns
         aHI6vJYWc5cUDMzIVL/qgISOGcBejuFtHZLd4KuLilc9wK6l2mXAXgh63zBcmX6jqJHq
         65nQINi8JUFdnZMB1hWMg4mqz4ZJ/O7840CGkPoVgA/hip0Ch80Ecw028JIZm+tBNp86
         uqf15sm51AEdXfWsYsOKGCNLTPvFSUrFc3W8vXoAPdSGFNcSa5QhlkLHAZyJyACjgpHP
         AWcv9hcGjESE9meYzUHmQpgGL5kMPrPRoq5BKhoPEPTEgGqseL9lRfkayDvuIbiCAxMX
         5P5w==
X-Gm-Message-State: ABy/qLbToOOzqHShv/5u1iUXjLkp43lp8JT1X68gnsZFaNiZPWr2miq2
        4bux7SsSrYNOmDHdOucKXNCG2tw/nx4l4xaIAn3KepwjetctNaMunN+HxqHWpM1/Nun/EWTF932
        QNpAg3AWQt+7T6ItBDQKZ2Wdc
X-Received: by 2002:adf:ea10:0:b0:314:35ce:a0e7 with SMTP id q16-20020adfea10000000b0031435cea0e7mr3545416wrm.16.1689328213582;
        Fri, 14 Jul 2023 02:50:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFh1wPKblkmTBw8OQ1NLIUngbHtYwtP+MmS66mPVwKsVEsfrpflPboxtBmMk3of1k+PN6KJlg==
X-Received: by 2002:adf:ea10:0:b0:314:35ce:a0e7 with SMTP id q16-20020adfea10000000b0031435cea0e7mr3545397wrm.16.1689328213266;
        Fri, 14 Jul 2023 02:50:13 -0700 (PDT)
Received: from localhost ([91.126.32.244])
        by smtp.gmail.com with ESMTPSA id g12-20020a5d46cc000000b0031455482d1fsm10372260wrs.47.2023.07.14.02.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 02:50:12 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/8] drm/dumb-buffers: Fix drm_mode_create_dumb() for
 bpp < 8
In-Reply-To: <5ba8ac5e465121b646a59487dc75b27017e0c769.1689252746.git.geert@linux-m68k.org>
References: <cover.1689252746.git.geert@linux-m68k.org>
 <5ba8ac5e465121b646a59487dc75b27017e0c769.1689252746.git.geert@linux-m68k.org>
Date:   Fri, 14 Jul 2023 11:50:11 +0200
Message-ID: <87o7keu8j0.fsf@minerva.mail-host-address-is-not-set>
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

> drm_mode_create_dumb() calculates the number of characters per pixel
> from the number of bits per pixel by rounding up, which is not correct
> as the actual value of cpp may be non-integer.  While we do not need to
> care here about complex formats like YUV, bpp < 8 is a valid use case.
>
>   - The overflow check for the buffer width is not correct if bpp < 8.
>     However, it doesn't hurt, as widths larger than U32_MAX / 8 should
>     not happen for real anyway.  Add a comment to clarify.
>   - Calculating the stride from the number of characters per pixel is
>     not correct.  Fix this by calculating it from the number of bits per
>     pixel instead.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Why is drm_mode_create_dumb.size __u64?  The test for "args->height >

I don't think can be changed since is a DRM_IOCTL_MODE_CREATE_DUMB uAPI ?

> U32_MAX / stride" rejects all sizes not fitting in __u32 anyway.

Hmm, wonder if should be U64_MAX instead ?

> ---
>  drivers/gpu/drm/drm_dumb_buffers.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_dumb_buffers.c b/drivers/gpu/drm/drm_dumb_buffers.c
> index 70032bba1c97e787..21a04c32a5e3d785 100644
> --- a/drivers/gpu/drm/drm_dumb_buffers.c
> +++ b/drivers/gpu/drm/drm_dumb_buffers.c
> @@ -71,10 +71,11 @@ int drm_mode_create_dumb(struct drm_device *dev,
>  	/* overflow checks for 32bit size calculations */
>  	if (args->bpp > U32_MAX - 8)
>  		return -EINVAL;
> +	/* Incorrect (especially if bpp < 8), but doesn't hurt much */
>  	cpp = DIV_ROUND_UP(args->bpp, 8);
>  	if (cpp > U32_MAX / args->width)
>  		return -EINVAL;
> -	stride = cpp * args->width;
> +	stride = DIV_ROUND_UP(args->bpp * args->width, 8);
>  	if (args->height > U32_MAX / stride)
>  		return -EINVAL;
>  

Good catch.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

