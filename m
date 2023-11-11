Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A817E89DE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 09:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjKKIba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 03:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjKKIb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 03:31:28 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47254469D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 00:31:25 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507f1c29f25so3806801e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 00:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699691483; x=1700296283; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CnzMPSuSkDs43Z3P5R9j6n7+bWlsIBEP8r17ky0zTro=;
        b=cV9L0FL/5lKZyX18sKNTuhEvl2Nchv1x80QKBd4EDvSrGJkrvHjKU8JHdqgmHDWAhH
         +8noZ3z1EmsM2i6qyDlgZGfVFbY+kTbFqIN+hSXBnPpko58IiXYS3M+7YVKUYotY4RzC
         MmUnJhRptvgo5MR0NZoGMMqMklNyuiwGuLMoe+sfVk+bGG+znHCn66/zNUpLGtJ+ZEqq
         YxzspKdqLZydaD6Of4Ca4F7zTqkWmelCWMExSkjDpmurk1tNmmAf4O0jm+lGMR5xW1jl
         sNqeS+XSRQPNzbbRpmcCl6KK5KNOBfi4p0lKZT0ey6kFR6hxZWH3kzdIhuQtihkU6E/P
         7DqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699691483; x=1700296283;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CnzMPSuSkDs43Z3P5R9j6n7+bWlsIBEP8r17ky0zTro=;
        b=GWZkb1WdxIteB4nCh3EN1s/OirLRquF4aCQfKNOoIMVvvm54htGbO7vwakBk8BPFr9
         qjwXyUgLTXyPbLieN70+unI/p8tOV+9SmW1YvKZxL/Lx6w/cx2g4QV6toFUSs3TIeO38
         bOgtiG+CwbcyQTkSXlWHYkYeoauvV9a1WuS4rzLKDSmRpTs5ULVURBy3ogyE+FFYmQVA
         7BPNTV7hJprQQTXGTNZLq2hTpxR2DMvjrvL0R5ksALaLHcCFjx8N3schn5AJbh+wAUev
         haUnxHnldkM0H5kfLYrQFVefJecHiuc9RmCww7bHGGuwgl2BsX16FV6zn4roksycDPCI
         bE/g==
X-Gm-Message-State: AOJu0Yxzip/U+15RDyeEhVSLcCLGLPYh/taQjK6pgLTA04p2sqR3B4aG
        SVT2qn37e5NOZuMhxrYGeLR6K94nK/45xLAsgo8=
X-Google-Smtp-Source: AGHT+IELK3Jp5o8QXO7eI93fMAFpbKC2f3FagLHhgYb/6DMOHmsvKBQnhpOM1YShIk5J/joBlvbrofzWhq+QJPHovzY=
X-Received: by 2002:a19:3809:0:b0:50a:6375:d5f1 with SMTP id
 f9-20020a193809000000b0050a6375d5f1mr804587lfa.60.1699691483119; Sat, 11 Nov
 2023 00:31:23 -0800 (PST)
MIME-Version: 1.0
References: <20231111042926.52990-1-amworsley@gmail.com> <20231111042926.52990-2-amworsley@gmail.com>
In-Reply-To: <20231111042926.52990-2-amworsley@gmail.com>
From:   Andrew Worsley <amworsley@gmail.com>
Date:   Sat, 11 Nov 2023 19:31:11 +1100
Message-ID: <CA+Y=x3mF4jFX7PiJQ-1Gk9zyBE1mwZaF_GLYjSspT+mxtMn4GQ@mail.gmail.com>
Subject: Re: [PATCH] Fix failure of simpledrm probe when trying to grab FB
 from the EFI-based Framebuffer
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR FIRMWARE FRAMEBUFFERS" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's inline - part of the email - not an attachment?

I can see it in the copy that went to me...

Andrew

On Sat, 11 Nov 2023 at 15:30, Andrew Worsley <amworsley@gmail.com> wrote:
>
>    The simpledrm.c does not call aperture_remove_conflicting_devices() in it's probe
>    function as the drivers/video/aperture.c documentation says it should. Consequently
>    it's request for the FB memory fails.
>
> ...
> [    3.085302] simple-framebuffer bd58dc000.framebuffer: [drm] *ERROR* could not acquire memory range [??? 0xffff6e1d8629d580-0x2a5000001a7 flags 0x0]: -16
> [    3.086433] simple-framebuffer: probe of bd58dc000.framebuffer failed with error -16
> ...
>
>    In my case no driver provided /dev/dri/card0 device is available on boot up and X
>    fails to start as per this from X start up log.
>
> ...
> [     5.616] (WW) Falling back to old probe method for modesetting
> [     5.616] (EE) open /dev/dri/card0: No such file or directory
> ...
>
>    Fault confirmed and fixed on Asahi 6.5.0 kernel with both CONFIG_FB_EFI and
>    CONFIG_DRM_SIMPLEDRM config options set.
>
> Signed-off-by: Andrew Worsley <amworsley@gmail.com>
> ---
>  drivers/gpu/drm/tiny/simpledrm.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
> index 5fefc895bca2..e55a536b04cf 100644
> --- a/drivers/gpu/drm/tiny/simpledrm.c
> +++ b/drivers/gpu/drm/tiny/simpledrm.c
> @@ -8,6 +8,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/aperture.h>
>
>  #include <drm/drm_aperture.h>
>  #include <drm/drm_atomic.h>
> @@ -828,6 +829,13 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>         if (mem) {
>                 void *screen_base;
>
> +               ret = aperture_remove_conflicting_devices(mem->start, resource_size(mem),
> +                       DRIVER_NAME);
> +               if (ret) {
> +                       drm_err(dev, "aperture_remove_conflicting_devices: failed:%d\n",
> +                           __func__, ret);
> +                       return ERR_PTR(ret);
> +               }
>                 ret = devm_aperture_acquire_from_firmware(dev, mem->start, resource_size(mem));
>                 if (ret) {
>                         drm_err(dev, "could not acquire memory range %pr: %d\n", mem, ret);
> @@ -848,6 +856,13 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>                 if (!res)
>                         return ERR_PTR(-EINVAL);
>
> +               ret = aperture_remove_conflicting_devices(res->start, resource_size(res),
> +                       DRIVER_NAME);
> +               if (ret) {
> +                       drm_err(dev, "aperture_remove_conflicting_devices: failed:%d\n",
> +                           __func__, ret);
> +                       return ERR_PTR(ret);
> +               }
>                 ret = devm_aperture_acquire_from_firmware(dev, res->start, resource_size(res));
>                 if (ret) {
>                         drm_err(dev, "could not acquire memory range %pr: %d\n", res, ret);
> --
> 2.42.0
>
