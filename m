Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3A77A9AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjIUSrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIUSrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:47:11 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71841EE85C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:46:58 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50437c618b4so69926e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695322014; x=1695926814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SgMdBTw9y+aSwwtmwk5xQ1ZAPfF4LIv2yTZ0dNleis=;
        b=bEYq42Jp85vYo5TynDJGUNbKZhRls/p8AT5NxM9YCEmpcUqVPQ+bV9s1sUdBr3r6Lf
         Phzt4xlJ25cv4SuC36xdUTEnAJI9XDAJpaA6tfsMRoeG+MbENTHBMZuB+bX2yZijGPh+
         2YOrHDCzPqX/zgAA7ulpNR3eSJSwyWUOy4HwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322014; x=1695926814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SgMdBTw9y+aSwwtmwk5xQ1ZAPfF4LIv2yTZ0dNleis=;
        b=bzpZDNLuWOPTw7ZffbfHaECK4qVKYEr5Ali3uw3m8+19dOqaq72UMGWp/364wtUHoo
         cKeNe64LrckYSXE0+KHKymw5/KJ4mKkztcBeHNZtkoriDLVHD5jspK2CCfTscsmFDHm7
         LsWiArLgUzK+QTaW1+CggPa9gQk8BePlDNm46LbM52AGXUXq0jF/stbXv600cphW9wRq
         OKU8gkaUml5TmT8HfCResuwDedVH1AX9JnsUsV/OSBRf83a5R2LPwo4TrgrMLtHflSUB
         SQkZ6L97L+ouKIuh9oDq8GUanlJB0N/1A6IYOZGms1GUpJbJ3bJlcXMwzYW4gHHgVPO6
         dxTA==
X-Gm-Message-State: AOJu0YxE9raCOb9viQ/Z1znk62un7k+FsEOKMK/JMnfSu42kx6HI16pV
        GgVOPB4N7NTvzraTWen83hWuQVe34NEFvkcCNcf5qT9U
X-Google-Smtp-Source: AGHT+IGiplyU3DUroxsazK7h3PaY+lJFIjo+sAkMvztZ+1L6u1WOmghiP0GTNOGn2Q/glib7oFw4uw==
X-Received: by 2002:ac2:5e65:0:b0:502:fdca:2ea6 with SMTP id a5-20020ac25e65000000b00502fdca2ea6mr5262343lfr.61.1695322014703;
        Thu, 21 Sep 2023 11:46:54 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id m29-20020a056512015d00b0050234d02e64sm397826lfo.15.2023.09.21.11.46.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 11:46:54 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-502f29ed596so658e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:46:54 -0700 (PDT)
X-Received: by 2002:a05:600c:1ca4:b0:405:320a:44f9 with SMTP id
 k36-20020a05600c1ca400b00405320a44f9mr98844wms.5.1695321993367; Thu, 21 Sep
 2023 11:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230901234015.566018-1-dianders@chromium.org> <20230901163944.RFT.2.I9115e5d094a43e687978b0699cc1fe9f2a3452ea@changeid>
In-Reply-To: <20230901163944.RFT.2.I9115e5d094a43e687978b0699cc1fe9f2a3452ea@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 Sep 2023 11:46:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WRqe7twJ+eLb3DavumknCxWFK5ey007fLuWkCBrzzyPQ@mail.gmail.com>
Message-ID: <CAD=FV=WRqe7twJ+eLb3DavumknCxWFK5ey007fLuWkCBrzzyPQ@mail.gmail.com>
Subject: Re: [RFT PATCH 2/6] drm: Call drm_atomic_helper_shutdown() at
 shutdown time for misc drivers
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     airlied@gmail.com, airlied@redhat.com, alain.volmat@foss.st.com,
        alexander.deucher@amd.com, alexandre.belloni@bootlin.com,
        alison.wang@nxp.com, bbrezillon@kernel.org,
        christian.koenig@amd.com, claudiu.beznea@microchip.com,
        daniel@ffwll.ch, drawat.floss@gmail.com, javierm@redhat.com,
        jernej.skrabec@gmail.com, jfalempe@redhat.com, jstultz@google.com,
        kong.kongxinwei@hisilicon.com, kraxel@redhat.com,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, liviu.dudau@arm.com,
        nicolas.ferre@microchip.com, paul.kocialkowski@bootlin.com,
        sam@ravnborg.org, samuel@sholland.org,
        spice-devel@lists.freedesktop.org, stefan@agner.ch,
        suijingfeng@loongson.cn, sumit.semwal@linaro.org,
        tiantao6@hisilicon.com, tomi.valkeinen@ideasonboard.com,
        tzimmermann@suse.de, virtualization@lists.linux-foundation.org,
        wens@csie.org, xinliang.liu@linaro.org, yongqin.liu@linaro.org,
        zackr@vmware.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 1, 2023 at 4:40=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> Based on grepping through the source code these drivers appear to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown
> time. Among other things, this means that if a panel is in use that it
> won't be cleanly powered off at system shutdown time.
>
> The fact that we should call drm_atomic_helper_shutdown() in the case
> of OS shutdown/restart comes straight out of the kernel doc "driver
> instance overview" in drm_drv.c.
>
> All of the drivers in this patch were fairly straightforward to fix
> since they already had a call to drm_atomic_helper_shutdown() at
> remove/unbind time but were just lacking one at system shutdown. The
> only hitch is that some of these drivers use the component model to
> register/unregister their DRM devices. The shutdown callback is part
> of the original device. The typical solution here, based on how other
> DRM drivers do this, is to keep track of whether the device is bound
> based on drvdata. In most cases the drvdata is the drm_device, so we
> can just make sure it is NULL when the device is not bound. In some
> drivers, this required minor code changes. To make things simpler,
> drm_atomic_helper_shutdown() has been modified to consider a NULL
> drm_device as a noop in the patch ("drm/atomic-helper:
> drm_atomic_helper_shutdown(NULL) should be a noop").
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This commit is only compile-time tested.
>
> Note that checkpatch yells that "drivers/gpu/drm/tiny/cirrus.c" is
> marked as 'obsolete', but it seems silly not to include the fix if
> it's already been written. If someone wants me to take that out,
> though, I can.
>
>  drivers/gpu/drm/arm/display/komeda/komeda_drv.c | 9 +++++++++
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 7 +++++++
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.h | 1 +
>  drivers/gpu/drm/arm/hdlcd_drv.c                 | 6 ++++++
>  drivers/gpu/drm/arm/malidp_drv.c                | 6 ++++++
>  drivers/gpu/drm/ast/ast_drv.c                   | 6 ++++++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c    | 6 ++++++
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c       | 8 ++++++++
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 6 ++++++
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c         | 6 ++++++
>  drivers/gpu/drm/logicvc/logicvc_drm.c           | 9 +++++++++
>  drivers/gpu/drm/loongson/lsdc_drv.c             | 6 ++++++
>  drivers/gpu/drm/mcde/mcde_drv.c                 | 9 +++++++++
>  drivers/gpu/drm/omapdrm/omap_drv.c              | 8 ++++++++
>  drivers/gpu/drm/qxl/qxl_drv.c                   | 7 +++++++
>  drivers/gpu/drm/sti/sti_drv.c                   | 7 +++++++
>  drivers/gpu/drm/sun4i/sun4i_drv.c               | 6 ++++++
>  drivers/gpu/drm/tiny/bochs.c                    | 6 ++++++
>  drivers/gpu/drm/tiny/cirrus.c                   | 6 ++++++
>  19 files changed, 125 insertions(+)

This has been about 3 weeks now and it feels like that's enough bake
time and several people have managed to test it (thanks!). Landing in
drm-misc-next:

ce3d99c83495 drm: Call drm_atomic_helper_shutdown() at shutdown time
for misc drivers
