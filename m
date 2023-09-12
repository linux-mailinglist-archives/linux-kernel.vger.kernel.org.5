Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C67E79DA2B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjILUh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjILUh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 852471BE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694551000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jmUI45+6EVj+Kwlgk9vFbEhiSU7sjy2egj4BAvZP6Ys=;
        b=DeEoEn9VYKhcmBo2VtxrYeaeijPaNPjsoAPtPBht+RAe19GsMjJjHaMPQkA3vgAAtTsZBz
        jntmwbjMdl5sEV0UOhyZ/JCIICZ/ojA/el/LpVQjOTIL8o4DMlve/nKBEVIz3iVwAlYJPy
        GW7Jw1oYKzs+AeI2mEpmYN9bk3051I8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-nTqLvPlSMT-wh9_DDlHfCA-1; Tue, 12 Sep 2023 16:36:39 -0400
X-MC-Unique: nTqLvPlSMT-wh9_DDlHfCA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-267f666104aso220458a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694550998; x=1695155798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmUI45+6EVj+Kwlgk9vFbEhiSU7sjy2egj4BAvZP6Ys=;
        b=fpup6376DhX2XcqQGJLNM3hqnM1/uyjiqFLA6PF8J1HmhWbkh6v5zKajozg1Y45mV9
         mpkwZ5J9eGwNVYGIRBhNHtFMA5oid7KPGR/9TXR0+ucqdFKOLURNigdqpgH5Y3bKRX6V
         aRPN3BD17b17o1JP8j4jyDIvcpM9ZsR4MfDTva2f/qYIBCZYE3vUs6Wme/cQ2k4hVMlA
         vlmkzpDcvd2wDAx3RFj6utJrrwBtQntreMJ5QlU4k7gxsWT38e59dHxCSt+3FvKPSAra
         yLAh0NxhuX1N6dxBnZCxcRG+9pNaAw11ew6W67mkeDfLPp4jX1ywK4j1E/NKNUKtb+2m
         FBiA==
X-Gm-Message-State: AOJu0YyHHBmVmsJ+3zX6tw4AvbdWxi9RpzDXKRTheDfTQ4PJ5Cf9xyP0
        dmgyWXF7hdv11YvpV3m0O8bFfabo+bFMZQW8qs4axlmzgM8c73vShaSevtndbJEk0OyXtoCY3cI
        pJp5dmIbh99+d85OLjBdPB3XrZ0gCS71rkSBD+3r/
X-Received: by 2002:a17:90a:cc0e:b0:271:78a0:8ab2 with SMTP id b14-20020a17090acc0e00b0027178a08ab2mr4405365pju.24.1694550998147;
        Tue, 12 Sep 2023 13:36:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmQhaGvp1VhOkGT2XahtSZDgOt2QiYoJ6GOki4JEK6bZNbMlefKB8QCZg/b9mop+4h+DbOKAIaBamVyWjNK/w=
X-Received: by 2002:a17:90a:cc0e:b0:271:78a0:8ab2 with SMTP id
 b14-20020a17090acc0e00b0027178a08ab2mr4405346pju.24.1694550997706; Tue, 12
 Sep 2023 13:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230912-simpledrm-multiple-power-domains-v2-1-01b66bfb1980@jannau.net>
In-Reply-To: <20230912-simpledrm-multiple-power-domains-v2-1-01b66bfb1980@jannau.net>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Tue, 12 Sep 2023 21:36:00 +0100
Message-ID: <CAOgh=Fx-ei8RPDpK5kCQWCgW6epf+fSmNRTkebozDXPNwFx2bA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/simpledrm: Add support for multiple "power-domains"
To:     j@jannau.net
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sept 2023 at 21:30, Janne Grunau via B4 Relay
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

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

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

