Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949C67ABAE2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjIVVHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjIVVHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE50EC1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 14:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695416815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nbdcwv5Or6Z2+lA87iZfowKftkAW8aJRElWE3un3JwU=;
        b=KLajG4gKDassIufPK45aIOcx6HdadZV0++RmncxXt2cW3bsg1iEd4axKziwvyPNTPaeCHg
        9sjXSN7yZf0XkXqkMc/xTScKX2ucJqqEkHE7w/tBsgMl4UHXPROqQsS5ZRmyelYXdkodRP
        J95rFLt5WqFFq83vGvUscb0HUB0CxvE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-zp3Vnnl1NvuDiNyL76qPQw-1; Fri, 22 Sep 2023 17:06:52 -0400
X-MC-Unique: zp3Vnnl1NvuDiNyL76qPQw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-412190efed6so30702981cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 14:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695416812; x=1696021612;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nbdcwv5Or6Z2+lA87iZfowKftkAW8aJRElWE3un3JwU=;
        b=ta4nAzNtG83I67iK8C9J7ECsTbJg2+GhBDjEu2/zY/ZVB4K9OTiTl+VKx+uSsFDCbC
         du80q2uTVztJF6J48B41y7UeKX6vsYJQLrFGQpRqUXuwVj/xozhpNzUrj65Jm25vlfFc
         yODMMYK6bw4bqI4HYHa1yt1A3zBbA3U5VA0WQ9QijOlcTq/H15742FFV8NRfAHOgG3xM
         81Gk9B8W/s1Z5YNpaMTv5+vKOXHhcU6Pre7hJnTNGujBb5L7Q3CSCepBe3Zdw4QqsvaQ
         X7NLaxR/v+W0aGwKfRuiWSZKRntNtmzJUgNPLQTvE2jG0P2bsP3HdwegkekH57kElCwG
         5Z5g==
X-Gm-Message-State: AOJu0YwRkNyWnd59zVhkQsTdbFBaq0R/J8h5XvLpFE/C2gg0mVkFRG8i
        IVW3E8COPFY+EyYXbVxJq91aoFmVzHkV/tqRKtGHljYYxGNDb4rneTnnTLAvNtOW56xltAk2L8R
        KvxBejHgnn1xaKDdSuCyAPdN7
X-Received: by 2002:ac8:5fd6:0:b0:405:5b23:d0ea with SMTP id k22-20020ac85fd6000000b004055b23d0eamr717400qta.16.1695416811974;
        Fri, 22 Sep 2023 14:06:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO77hOhRgl+P8D05v+uElLGmY0PJDkHzsfs38llOhEzF3MZ4ZCYCENWWZ4uGBMCz8o7uGGFw==
X-Received: by 2002:ac8:5fd6:0:b0:405:5b23:d0ea with SMTP id k22-20020ac85fd6000000b004055b23d0eamr717384qta.16.1695416811681;
        Fri, 22 Sep 2023 14:06:51 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id t15-20020ac8738f000000b0040324785e4csm1737173qtp.13.2023.09.22.14.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 14:06:51 -0700 (PDT)
Message-ID: <2f7fbd1b606b4d08b8c8c6eefff5898c8faa697c.camel@redhat.com>
Subject: Re: [RFT PATCH v2 04/12] drm/nouveau: Call
 drm_atomic_helper_shutdown() or equiv at shutdown time
From:   Lyude Paul <lyude@redhat.com>
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     airlied@gmail.com, bskeggs@redhat.com, daniel@ffwll.ch,
        kherbst@redhat.com, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org
Date:   Fri, 22 Sep 2023 17:06:50 -0400
In-Reply-To: <20230921122641.RFT.v2.4.Ie7588ec6e0f93e8bc700e76b265ad1a7ad6b15ad@changeid>
References: <20230921192749.1542462-1-dianders@chromium.org>
         <20230921122641.RFT.v2.4.Ie7588ec6e0f93e8bc700e76b265ad1a7ad6b15ad@changeid>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

actually very glad to see this because I think I've seen one bug in the wil=
d
as a result of things not getting shut down :)

Reviewed-by: Lyude Paul <lyude@redhat.com>
Tested-by: Lyude Paul <lyude@redhat.com>

On Thu, 2023-09-21 at 12:26 -0700, Douglas Anderson wrote:
> Based on grepping through the source code this driver appears to be
> missing a call to drm_atomic_helper_shutdown() (or
> drm_helper_force_disable_all() if not using atomic) at system shutdown
> time. Among other things, this means that if a panel is in use that it
> won't be cleanly powered off at system shutdown time.
>=20
> The fact that we should call drm_atomic_helper_shutdown() in the case
> of OS shutdown/restart comes straight out of the kernel doc "driver
> instance overview" in drm_drv.c.
>=20
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This commit is only compile-time tested. I made my best guess about
> how to fit this into the existing code. If someone wishes a different
> style, please yell.
>=20
> (no changes since v1)
>=20
>  drivers/gpu/drm/nouveau/nouveau_display.c  |  9 +++++++++
>  drivers/gpu/drm/nouveau/nouveau_display.h  |  1 +
>  drivers/gpu/drm/nouveau/nouveau_drm.c      | 13 +++++++++++++
>  drivers/gpu/drm/nouveau/nouveau_drv.h      |  1 +
>  drivers/gpu/drm/nouveau/nouveau_platform.c |  6 ++++++
>  5 files changed, 30 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/=
nouveau/nouveau_display.c
> index d8c92521226d..05c3688ccb76 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_display.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_display.c
> @@ -642,6 +642,15 @@ nouveau_display_fini(struct drm_device *dev, bool su=
spend, bool runtime)
>  	disp->fini(dev, runtime, suspend);
>  }
> =20
> +void
> +nouveau_display_shutdown(struct drm_device *dev)
> +{
> +	if (drm_drv_uses_atomic_modeset(dev))
> +		drm_atomic_helper_shutdown(dev);
> +	else
> +		drm_helper_force_disable_all(dev);
> +}
> +
>  static void
>  nouveau_display_create_properties(struct drm_device *dev)
>  {
> diff --git a/drivers/gpu/drm/nouveau/nouveau_display.h b/drivers/gpu/drm/=
nouveau/nouveau_display.h
> index 2ab2ddb1eadf..9df62e833cda 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_display.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_display.h
> @@ -47,6 +47,7 @@ void nouveau_display_destroy(struct drm_device *dev);
>  int  nouveau_display_init(struct drm_device *dev, bool resume, bool runt=
ime);
>  void nouveau_display_hpd_resume(struct drm_device *dev);
>  void nouveau_display_fini(struct drm_device *dev, bool suspend, bool run=
time);
> +void nouveau_display_shutdown(struct drm_device *dev);
>  int  nouveau_display_suspend(struct drm_device *dev, bool runtime);
>  void nouveau_display_resume(struct drm_device *dev, bool runtime);
>  int  nouveau_display_vblank_enable(struct drm_crtc *crtc);
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index 50589f982d1a..8ecfd66b7aab 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -879,6 +879,18 @@ nouveau_drm_remove(struct pci_dev *pdev)
>  	pci_disable_device(pdev);
>  }
> =20
> +void
> +nouveau_drm_device_shutdown(struct drm_device *dev)
> +{
> +	nouveau_display_shutdown(dev);
> +}
> +
> +static void
> +nouveau_drm_shutdown(struct pci_dev *pdev)
> +{
> +	nouveau_drm_device_shutdown(pci_get_drvdata(pdev));
> +}
> +
>  static int
>  nouveau_do_suspend(struct drm_device *dev, bool runtime)
>  {
> @@ -1346,6 +1358,7 @@ nouveau_drm_pci_driver =3D {
>  	.id_table =3D nouveau_drm_pci_table,
>  	.probe =3D nouveau_drm_probe,
>  	.remove =3D nouveau_drm_remove,
> +	.shutdown =3D nouveau_drm_shutdown,
>  	.driver.pm =3D &nouveau_pm_ops,
>  };
> =20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouv=
eau/nouveau_drv.h
> index 3666a7403e47..aa936cabb6cf 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drv.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
> @@ -327,6 +327,7 @@ struct drm_device *
>  nouveau_platform_device_create(const struct nvkm_device_tegra_func *,
>  			       struct platform_device *, struct nvkm_device **);
>  void nouveau_drm_device_remove(struct drm_device *dev);
> +void nouveau_drm_device_shutdown(struct drm_device *dev);
> =20
>  #define NV_PRINTK(l,c,f,a...) do {                                      =
       \
>  	struct nouveau_cli *_cli =3D (c);                                      =
  \
> diff --git a/drivers/gpu/drm/nouveau/nouveau_platform.c b/drivers/gpu/drm=
/nouveau/nouveau_platform.c
> index 23cd43a7fd19..b2e82a96411c 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_platform.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_platform.c
> @@ -50,6 +50,11 @@ static int nouveau_platform_remove(struct platform_dev=
ice *pdev)
>  	return 0;
>  }
> =20
> +static void nouveau_platform_shutdown(struct platform_device *pdev)
> +{
> +	nouveau_drm_device_shutdown(platform_get_drvdata(pdev));
> +}
> +
>  #if IS_ENABLED(CONFIG_OF)
>  static const struct nvkm_device_tegra_func gk20a_platform_data =3D {
>  	.iommu_bit =3D 34,
> @@ -94,4 +99,5 @@ struct platform_driver nouveau_platform_driver =3D {
>  	},
>  	.probe =3D nouveau_platform_probe,
>  	.remove =3D nouveau_platform_remove,
> +	.shutdown =3D nouveau_platform_shutdown,
>  };

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

