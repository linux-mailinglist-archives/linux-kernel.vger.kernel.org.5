Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAEC7AE6E2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjIZHcm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Sep 2023 03:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjIZHcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:32:39 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92996E5;
        Tue, 26 Sep 2023 00:32:31 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d8181087dc9so9026402276.3;
        Tue, 26 Sep 2023 00:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695713548; x=1696318348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laJcIFxy0JToS9GpnmSBInlVg5g0YUWZWpaVsSmKGfk=;
        b=QW3hJPcHZzIoV5qzWuCehKLudwvsJWtO8D6Qtd6YDhaECsf2bukXwri+2CzPwnYSD/
         2cnhzzCpM+WkOzmuBLyFXNGqYSSpER2LY/68n/8hebkIAJxEMFOPjdZv1IE2KFCDi6Xt
         Lu78utj82b0xEqGx3MYhTiZTQ21HswYnuqPsUtkZwhD35Ru2skAyl2Z0E5HTf2v9eniD
         JiFEleAKryWhqDoo0NPRi5QP34EGOINxfSATxKKDJNQ8YecTQ6W7IAXVrsSebJzj6Zol
         Hd4xVHmyk7b/D2oMh265Z52p9lQGUCh83xiNx9bpKepTR5f/L2+XDyV4SJlC24jDlIAI
         K9ug==
X-Gm-Message-State: AOJu0Yyu3p6AxYePWi7zNJmk+B6EyLzmT11HgtAsEwtQ6IfUaTd6tOlU
        k3JpTdmD+A7bQ7uQl0HYMbzWlVxbDaZztQ==
X-Google-Smtp-Source: AGHT+IGHymYyG3gwoXj5ghVlpSqNfPqX7k1/xWKkTmPniqQg9xFGFq3deyvvh5GBHH4W/CadbjlkOg==
X-Received: by 2002:a5b:3c1:0:b0:d81:69f9:61ea with SMTP id t1-20020a5b03c1000000b00d8169f961eamr7686319ybp.46.1695713547818;
        Tue, 26 Sep 2023 00:32:27 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 186-20020a2506c3000000b00d7e96c6eaf5sm1516088ybg.46.2023.09.26.00.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 00:32:27 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59f82ad1e09so38188547b3.0;
        Tue, 26 Sep 2023 00:32:26 -0700 (PDT)
X-Received: by 2002:a81:4ed1:0:b0:59c:a68:d36b with SMTP id
 c200-20020a814ed1000000b0059c0a68d36bmr9368709ywb.20.1695713546672; Tue, 26
 Sep 2023 00:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230912-simpledrm-multiple-power-domains-v2-1-01b66bfb1980@jannau.net>
 <ff8e4a01-9a58-45bf-a743-08f4f6027251@suse.de>
In-Reply-To: <ff8e4a01-9a58-45bf-a743-08f4f6027251@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Sep 2023 09:32:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV9Ahp2ACYfRbnnnMbn9Cps939uwCQM+Md_PcCKYG=piw@mail.gmail.com>
Message-ID: <CAMuHMdV9Ahp2ACYfRbnnnMbn9Cps939uwCQM+Md_PcCKYG=piw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/simpledrm: Add support for multiple "power-domains"
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     j@jannau.net, Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
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

CC genpd

On Mon, Sep 18, 2023 at 10:24 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 12.09.23 um 22:22 schrieb Janne Grunau via B4 Relay:
> > From: Janne Grunau <j@jannau.net>
> >
> > Multiple power domains need to be handled explicitly in each driver. The
> > driver core can not handle it automatically since it is not aware of
> > power sequencing requirements the hardware might have. This is not a
> > problem for simpledrm since everything is expected to be powered on by
> > the bootloader. simpledrm has just ensure it remains powered on during
> > its lifetime.
> > This is required on Apple silicon M2 and M2 Pro/Max/Ultra desktop
> > systems. The HDMI output initialized by the bootloader requires keeping
> > the display controller and a DP phy power domain on.
> >
> > Signed-off-by: Janne Grunau <j@jannau.net>

Thanks for your patch, which is now commit 61df9ca231075e70
("drm/simpledrm: Add support for multiple "power-domains"") in
drm-misc/for-linux-next.

> As a simpledrm patch:
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> Do you want to wait for another review from  someone with
> power-management expertise?

Yeah, why not? Let's CC them, so they become aware...

> Do we need a similar patch for ofdrm?
>
> Best regards
> Thomas
>
> > ---
> > Changes in v2:
> > - removed broken drm_err() log statement only ment for debugging
> > - removed commented cast
> > - use correct format spcifier for 'int' in log statement
> > - add 'continue;' after failure to get device for power_domain
> > - use drm_warn() in non fatal error cases
> > - removed duplicate PTR_ERR conversion
> > - Link to v1: https://lore.kernel.org/r/20230910-simpledrm-multiple-power-domains-v1-1-f8718aefc685@jannau.net
> > ---
> >   drivers/gpu/drm/tiny/simpledrm.c | 105 +++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 105 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
> > index ff86ba1ae1b8..9c597461d1e2 100644
> > --- a/drivers/gpu/drm/tiny/simpledrm.c
> > +++ b/drivers/gpu/drm/tiny/simpledrm.c
> > @@ -6,6 +6,7 @@
> >   #include <linux/of_address.h>
> >   #include <linux/platform_data/simplefb.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/pm_domain.h>
> >   #include <linux/regulator/consumer.h>
> >
> >   #include <drm/drm_aperture.h>
> > @@ -227,6 +228,12 @@ struct simpledrm_device {
> >       unsigned int regulator_count;
> >       struct regulator **regulators;
> >   #endif
> > +     /* power-domains */
> > +#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
> > +     int pwr_dom_count;
> > +     struct device **pwr_dom_devs;
> > +     struct device_link **pwr_dom_links;
> > +#endif
> >
> >       /* simplefb settings */
> >       struct drm_display_mode mode;
> > @@ -468,6 +475,101 @@ static int simpledrm_device_init_regulators(struct simpledrm_device *sdev)
> >   }
> >   #endif
> >
> > +#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
> > +/*
> > + * Generic power domain handling code.
> > + *
> > + * Here we handle the power-domains properties of our "simple-framebuffer"
> > + * dt node. This is only necessary if there is more than one power-domain.
> > + * A single power-domains is handled automatically by the driver core. Multiple
> > + * power-domains have to be handled by drivers since the driver core can't know
> > + * the correct power sequencing. Power sequencing is not an issue for simpledrm
> > + * since the bootloader has put the power domains already in the correct state.
> > + * simpledrm has only to ensure they remain active for its lifetime.
> > + *
> > + * When the driver unloads, we detach from the power-domains.
> > + *
> > + * We only complain about errors here, no action is taken as the most likely
> > + * error can only happen due to a mismatch between the bootloader which set
> > + * up the "simple-framebuffer" dt node, and the PM domain providers in the
> > + * device tree. Chances are that there are no adverse effects, and if there are,
> > + * a clean teardown of the fb probe will not help us much either. So just
> > + * complain and carry on, and hope that the user actually gets a working fb at
> > + * the end of things.
> > + */
> > +static void simpledrm_device_detach_genpd(void *res)
> > +{
> > +     int i;
> > +     struct simpledrm_device *sdev = res;
> > +
> > +     if (sdev->pwr_dom_count <= 1)
> > +             return;
> > +
> > +     for (i = sdev->pwr_dom_count - 1; i >= 0; i--) {
> > +             if (!sdev->pwr_dom_links[i])
> > +                     device_link_del(sdev->pwr_dom_links[i]);
> > +             if (!IS_ERR_OR_NULL(sdev->pwr_dom_devs[i]))
> > +                     dev_pm_domain_detach(sdev->pwr_dom_devs[i], true);
> > +     }
> > +}
> > +
> > +static int simpledrm_device_attach_genpd(struct simpledrm_device *sdev)
> > +{
> > +     struct device *dev = sdev->dev.dev;
> > +     int i;
> > +
> > +     sdev->pwr_dom_count = of_count_phandle_with_args(dev->of_node, "power-domains",
> > +                                                      "#power-domain-cells");
> > +     /*
> > +      * Single power-domain devices are handled by driver core nothing to do
> > +      * here. The same for device nodes without "power-domains" property.
> > +      */
> > +     if (sdev->pwr_dom_count <= 1)
> > +             return 0;
> > +
> > +     sdev->pwr_dom_devs = devm_kcalloc(dev, sdev->pwr_dom_count,
> > +                                            sizeof(*sdev->pwr_dom_devs),
> > +                                            GFP_KERNEL);
> > +     if (!sdev->pwr_dom_devs)
> > +             return -ENOMEM;
> > +
> > +     sdev->pwr_dom_links = devm_kcalloc(dev, sdev->pwr_dom_count,
> > +                                             sizeof(*sdev->pwr_dom_links),
> > +                                             GFP_KERNEL);
> > +     if (!sdev->pwr_dom_links)
> > +             return -ENOMEM;
> > +
> > +     for (i = 0; i < sdev->pwr_dom_count; i++) {
> > +             sdev->pwr_dom_devs[i] = dev_pm_domain_attach_by_id(dev, i);
> > +             if (IS_ERR(sdev->pwr_dom_devs[i])) {
> > +                     int ret = PTR_ERR(sdev->pwr_dom_devs[i]);
> > +                     if (ret == -EPROBE_DEFER) {
> > +                             simpledrm_device_detach_genpd(sdev);
> > +                             return ret;
> > +                     }
> > +                     drm_warn(&sdev->dev,
> > +                              "pm_domain_attach_by_id(%u) failed: %d\n", i, ret);
> > +                     continue;
> > +             }
> > +
> > +             sdev->pwr_dom_links[i] = device_link_add(dev,
> > +                                                      sdev->pwr_dom_devs[i],
> > +                                                      DL_FLAG_STATELESS |
> > +                                                      DL_FLAG_PM_RUNTIME |
> > +                                                      DL_FLAG_RPM_ACTIVE);
> > +             if (!sdev->pwr_dom_links[i])
> > +                     drm_warn(&sdev->dev, "failed to link power-domain %d\n", i);
> > +     }
> > +
> > +     return devm_add_action_or_reset(dev, simpledrm_device_detach_genpd, sdev);
> > +}
> > +#else
> > +static int simpledrm_device_attach_genpd(struct simpledrm_device *sdev)
> > +{
> > +     return 0;
> > +}
> > +#endif
> > +
> >   /*
> >    * Modesetting
> >    */
> > @@ -651,6 +753,9 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
> >       if (ret)
> >               return ERR_PTR(ret);
> >       ret = simpledrm_device_init_regulators(sdev);
> > +     if (ret)
> > +             return ERR_PTR(ret);
> > +     ret = simpledrm_device_attach_genpd(sdev);
> >       if (ret)
> >               return ERR_PTR(ret);
> >
> >
> > ---
> > base-commit: 15d30b46573d75f5cb58cfacded8ebab9c76a2b0
> > change-id: 20230910-simpledrm-multiple-power-domains-f41efa6ad9bc

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
