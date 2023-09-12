Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E06A79DC29
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbjILWsI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 18:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbjILWrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:47:51 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F359A1BC2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:47:36 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9aa0495f9cfso69642166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694558855; x=1695163655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPQmiOiJEVpUypTzrtCNWvG84b8X0egdVXAFfU36T2Y=;
        b=Agx+xtZpsIR0T3A/SBqLvQ9lyZLc3RE7jjTPnaVu1vs4g1h5VKSDZyJ8q4X6yrf/BM
         7eWhg/rdx51/mVIVlCKXu28GJ90EelvgNubesUTsqi1PpekHu9vl23ZIIfwUWqp+CF04
         kV7N9jpMrC2uE7PlOfsPit0cwEdIi8IfQ7WxhMj3ToaPstKcZ1u9lXir9LDX591N7Dj8
         ZFQ7flxk26TboalBokeo4DqQFNeklxnPt5di96pqYuwtzllxYyduBRnzVYrZZE8ofBZ8
         NHN6kzKiQ+F3Mj7eBdrcQIkkVFgmrPboECjubRJymadk4V8+fviF96YAWJAfmdib7WKB
         3AyQ==
X-Gm-Message-State: AOJu0YzF+EEaV0ZYS1bulks4KYCL/YTU/HThfgeFmwpWNcaFOgOBd0Nr
        gzhEqOkyXkXcHG9UI5dMgYrNPA6amj2C5uJr
X-Google-Smtp-Source: AGHT+IF1eegdCHmzznp9G+kVOu2KnYyUL6E/a94S13odlIpg9KV3rsZf5A8/nF4b5buXXX/EPQM83Q==
X-Received: by 2002:a17:906:5399:b0:9ad:7d5c:6b5c with SMTP id g25-20020a170906539900b009ad7d5c6b5cmr1528234ejo.3.1694558854287;
        Tue, 12 Sep 2023 15:47:34 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id i18-20020a17090671d200b0099cf840527csm7462066ejk.153.2023.09.12.15.47.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 15:47:33 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-99c93638322so71830266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:47:33 -0700 (PDT)
X-Received: by 2002:a17:907:96a4:b0:9a5:c38d:6b75 with SMTP id
 hd36-20020a17090796a400b009a5c38d6b75mr5511540ejc.15.1694558853578; Tue, 12
 Sep 2023 15:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230912-simpledrm-multiple-power-domains-v2-1-01b66bfb1980@jannau.net>
In-Reply-To: <20230912-simpledrm-multiple-power-domains-v2-1-01b66bfb1980@jannau.net>
From:   Neal Gompa <neal@gompa.dev>
Date:   Tue, 12 Sep 2023 18:46:56 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8i4P8r-5EUikS=6wy5_3OvufeLzfLWkB+SgMq-nkpArA@mail.gmail.com>
Message-ID: <CAEg-Je8i4P8r-5EUikS=6wy5_3OvufeLzfLWkB+SgMq-nkpArA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/simpledrm: Add support for multiple "power-domains"
To:     j@jannau.net
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 4:22 PM Janne Grunau via B4 Relay
<devnull+j.jannau.net@kernel.org> wrote:
>
> From: Janne Grunau <j@jannau.net>
>
> Multiple power domains need to be handled explicitly in each driver. The
> driver core can not handle it automatically since it is not aware of
> power sequencing requirements the hardware might have. This is not a
> problem for simpledrm since everything is expected to be powered on by
> the bootloader. simpledrm has just ensure it remains powered on during
> its lifetime.
> This is required on Apple silicon M2 and M2 Pro/Max/Ultra desktop
> systems. The HDMI output initialized by the bootloader requires keeping
> the display controller and a DP phy power domain on.
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Changes in v2:
> - removed broken drm_err() log statement only ment for debugging
> - removed commented cast
> - use correct format spcifier for 'int' in log statement
> - add 'continue;' after failure to get device for power_domain
> - use drm_warn() in non fatal error cases
> - removed duplicate PTR_ERR conversion
> - Link to v1: https://lore.kernel.org/r/20230910-simpledrm-multiple-power-domains-v1-1-f8718aefc685@jannau.net
> ---
>  drivers/gpu/drm/tiny/simpledrm.c | 105 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>
> diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
> index ff86ba1ae1b8..9c597461d1e2 100644
> --- a/drivers/gpu/drm/tiny/simpledrm.c
> +++ b/drivers/gpu/drm/tiny/simpledrm.c
> @@ -6,6 +6,7 @@
>  #include <linux/of_address.h>
>  #include <linux/platform_data/simplefb.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/regulator/consumer.h>
>
>  #include <drm/drm_aperture.h>
> @@ -227,6 +228,12 @@ struct simpledrm_device {
>         unsigned int regulator_count;
>         struct regulator **regulators;
>  #endif
> +       /* power-domains */
> +#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
> +       int pwr_dom_count;
> +       struct device **pwr_dom_devs;
> +       struct device_link **pwr_dom_links;
> +#endif
>
>         /* simplefb settings */
>         struct drm_display_mode mode;
> @@ -468,6 +475,101 @@ static int simpledrm_device_init_regulators(struct simpledrm_device *sdev)
>  }
>  #endif
>
> +#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
> +/*
> + * Generic power domain handling code.
> + *
> + * Here we handle the power-domains properties of our "simple-framebuffer"
> + * dt node. This is only necessary if there is more than one power-domain.
> + * A single power-domains is handled automatically by the driver core. Multiple
> + * power-domains have to be handled by drivers since the driver core can't know
> + * the correct power sequencing. Power sequencing is not an issue for simpledrm
> + * since the bootloader has put the power domains already in the correct state.
> + * simpledrm has only to ensure they remain active for its lifetime.
> + *
> + * When the driver unloads, we detach from the power-domains.
> + *
> + * We only complain about errors here, no action is taken as the most likely
> + * error can only happen due to a mismatch between the bootloader which set
> + * up the "simple-framebuffer" dt node, and the PM domain providers in the
> + * device tree. Chances are that there are no adverse effects, and if there are,
> + * a clean teardown of the fb probe will not help us much either. So just
> + * complain and carry on, and hope that the user actually gets a working fb at
> + * the end of things.
> + */
> +static void simpledrm_device_detach_genpd(void *res)
> +{
> +       int i;
> +       struct simpledrm_device *sdev = res;
> +
> +       if (sdev->pwr_dom_count <= 1)
> +               return;
> +
> +       for (i = sdev->pwr_dom_count - 1; i >= 0; i--) {
> +               if (!sdev->pwr_dom_links[i])
> +                       device_link_del(sdev->pwr_dom_links[i]);
> +               if (!IS_ERR_OR_NULL(sdev->pwr_dom_devs[i]))
> +                       dev_pm_domain_detach(sdev->pwr_dom_devs[i], true);
> +       }
> +}
> +
> +static int simpledrm_device_attach_genpd(struct simpledrm_device *sdev)
> +{
> +       struct device *dev = sdev->dev.dev;
> +       int i;
> +
> +       sdev->pwr_dom_count = of_count_phandle_with_args(dev->of_node, "power-domains",
> +                                                        "#power-domain-cells");
> +       /*
> +        * Single power-domain devices are handled by driver core nothing to do
> +        * here. The same for device nodes without "power-domains" property.
> +        */
> +       if (sdev->pwr_dom_count <= 1)
> +               return 0;
> +
> +       sdev->pwr_dom_devs = devm_kcalloc(dev, sdev->pwr_dom_count,
> +                                              sizeof(*sdev->pwr_dom_devs),
> +                                              GFP_KERNEL);
> +       if (!sdev->pwr_dom_devs)
> +               return -ENOMEM;
> +
> +       sdev->pwr_dom_links = devm_kcalloc(dev, sdev->pwr_dom_count,
> +                                               sizeof(*sdev->pwr_dom_links),
> +                                               GFP_KERNEL);
> +       if (!sdev->pwr_dom_links)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < sdev->pwr_dom_count; i++) {
> +               sdev->pwr_dom_devs[i] = dev_pm_domain_attach_by_id(dev, i);
> +               if (IS_ERR(sdev->pwr_dom_devs[i])) {
> +                       int ret = PTR_ERR(sdev->pwr_dom_devs[i]);
> +                       if (ret == -EPROBE_DEFER) {
> +                               simpledrm_device_detach_genpd(sdev);
> +                               return ret;
> +                       }
> +                       drm_warn(&sdev->dev,
> +                                "pm_domain_attach_by_id(%u) failed: %d\n", i, ret);
> +                       continue;
> +               }
> +
> +               sdev->pwr_dom_links[i] = device_link_add(dev,
> +                                                        sdev->pwr_dom_devs[i],
> +                                                        DL_FLAG_STATELESS |
> +                                                        DL_FLAG_PM_RUNTIME |
> +                                                        DL_FLAG_RPM_ACTIVE);
> +               if (!sdev->pwr_dom_links[i])
> +                       drm_warn(&sdev->dev, "failed to link power-domain %d\n", i);
> +       }
> +
> +       return devm_add_action_or_reset(dev, simpledrm_device_detach_genpd, sdev);
> +}
> +#else
> +static int simpledrm_device_attach_genpd(struct simpledrm_device *sdev)
> +{
> +       return 0;
> +}
> +#endif
> +
>  /*
>   * Modesetting
>   */
> @@ -651,6 +753,9 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>         if (ret)
>                 return ERR_PTR(ret);
>         ret = simpledrm_device_init_regulators(sdev);
> +       if (ret)
> +               return ERR_PTR(ret);
> +       ret = simpledrm_device_attach_genpd(sdev);
>         if (ret)
>                 return ERR_PTR(ret);
>
>
> ---
> base-commit: 15d30b46573d75f5cb58cfacded8ebab9c76a2b0
> change-id: 20230910-simpledrm-multiple-power-domains-f41efa6ad9bc
>
> Best regards,
> --
> Janne Grunau <j@jannau.net>
>
>

Reviewed-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
