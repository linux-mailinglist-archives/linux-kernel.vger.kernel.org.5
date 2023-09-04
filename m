Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1ED77917A5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351276AbjIDM4t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Sep 2023 08:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238314AbjIDM4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:56:48 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3683189;
        Mon,  4 Sep 2023 05:56:44 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-56cae50792fso93892eaf.1;
        Mon, 04 Sep 2023 05:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693832204; x=1694437004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwUNZ8XDJgKW0fZT9OLuV5qQA3P+QbavqZqYpV+ByCE=;
        b=YIJn3FaIk95P9OYzmhmd5n0zafiKLjZp5OTzjPtpNipgQpmREQUKGnHjWMwmAznwE3
         3FbTBt4Ut456kQvdJ5BPbLPexsE/Hw/5CHixJP/sYWmUi+IyC7gtRQJUkxk9sqT6WWlR
         jCE+k0m0PAWxhAh3T8tC7IqJPEmv+XomE3CnVg1SDx3RdmOvX8sA+7deMvv+Ir7Ikx0g
         hYIX8ZimcTZoRyAzaICWdvwuyG1dSx8DztGOqdCyn7aYl0u8yKhQmFeiSm9hAbYX6Ff4
         qKZ0wxGrC0Gqi+gg/2gGLrFX+2RQob/KlMzmJ24ooibAMbrWFu99f10djvSCcBN+TRQ3
         mfwg==
X-Gm-Message-State: AOJu0Yy8A8zq6OSZvnsTZGCDukW74uoTqig1qTcHyMQQ5gxHSqKGR//D
        yW0/vs0KHpXctL2zClNxobVKFhjqddAev2i6X6Q=
X-Google-Smtp-Source: AGHT+IFcx7uOzoUx0fgNk7l/l3nThQI9qNWuhiaDPOyqHVx3f3WoRSPr0B7twGtcmzQQGk5MeIAFd9IufqngKNXKgT0=
X-Received: by 2002:a4a:d508:0:b0:56e:6532:467a with SMTP id
 m8-20020a4ad508000000b0056e6532467amr7723021oos.1.1693832204003; Mon, 04 Sep
 2023 05:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <1870450.tdWV9SEqCh@kreacher> <8272147.T7Z3S40VBb@kreacher>
In-Reply-To: <8272147.T7Z3S40VBb@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Sep 2023 14:56:33 +0200
Message-ID: <CAJZ5v0h_0xe6L_ASBfcxktXbHD_0HWAVyAWKfgQ2nTkzsRzapA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] thermal: Use thermal_tripless_zone_device_register()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 8:36 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> All of the remaining callers of thermal_zone_device_register()
> can use thermal_tripless_zone_device_register(), so make them
> do so in order to allow the former to be dropped.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Due to the lack of negative feedback, I'm going to assume that this
patch in particular and the entire series in general is fine with
everyone in the CC.

> ---
>  drivers/power/supply/power_supply_core.c                |    4 ++--
>  drivers/thermal/armada_thermal.c                        |    5 +++--
>  drivers/thermal/dove_thermal.c                          |    4 ++--
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c |    6 +++---
>  drivers/thermal/kirkwood_thermal.c                      |    4 ++--
>  drivers/thermal/spear_thermal.c                         |    4 ++--
>  6 files changed, 14 insertions(+), 13 deletions(-)
>
> Index: linux-pm/drivers/power/supply/power_supply_core.c
> ===================================================================
> --- linux-pm.orig/drivers/power/supply/power_supply_core.c
> +++ linux-pm/drivers/power/supply/power_supply_core.c
> @@ -1305,8 +1305,8 @@ static int psy_register_thermal(struct p
>
>         /* Register battery zone device psy reports temperature */
>         if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
> -               psy->tzd = thermal_zone_device_register(psy->desc->name,
> -                               0, 0, psy, &psy_tzd_ops, NULL, 0, 0);
> +               psy->tzd = thermal_tripless_zone_device_register(psy->desc->name,
> +                               psy, &psy_tzd_ops, NULL);
>                 if (IS_ERR(psy->tzd))
>                         return PTR_ERR(psy->tzd);
>                 ret = thermal_zone_device_enable(psy->tzd);
> Index: linux-pm/drivers/thermal/armada_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/armada_thermal.c
> +++ linux-pm/drivers/thermal/armada_thermal.c
> @@ -876,8 +876,9 @@ static int armada_thermal_probe(struct p
>                 /* Wait the sensors to be valid */
>                 armada_wait_sensor_validity(priv);
>
> -               tz = thermal_zone_device_register(priv->zone_name, 0, 0, priv,
> -                                                 &legacy_ops, NULL, 0, 0);
> +               tz = thermal_tripless_zone_device_register(priv->zone_name,
> +                                                          priv, &legacy_ops,
> +                                                          NULL);
>                 if (IS_ERR(tz)) {
>                         dev_err(&pdev->dev,
>                                 "Failed to register thermal zone device\n");
> Index: linux-pm/drivers/thermal/dove_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/dove_thermal.c
> +++ linux-pm/drivers/thermal/dove_thermal.c
> @@ -139,8 +139,8 @@ static int dove_thermal_probe(struct pla
>                 return ret;
>         }
>
> -       thermal = thermal_zone_device_register("dove_thermal", 0, 0,
> -                                              priv, &ops, NULL, 0, 0);
> +       thermal = thermal_tripless_zone_device_register("dove_thermal", priv,
> +                                                       &ops, NULL);
>         if (IS_ERR(thermal)) {
>                 dev_err(&pdev->dev,
>                         "Failed to register thermal zone device\n");
> Index: linux-pm/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ linux-pm/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -609,9 +609,9 @@ static int int3400_thermal_probe(struct
>
>         evaluate_odvp(priv);
>
> -       priv->thermal = thermal_zone_device_register("INT3400 Thermal", 0, 0,
> -                                               priv, &int3400_thermal_ops,
> -                                               &int3400_thermal_params, 0, 0);
> +       priv->thermal = thermal_tripless_zone_device_register("INT3400 Thermal", priv,
> +                                                             &int3400_thermal_ops,
> +                                                             &int3400_thermal_params);
>         if (IS_ERR(priv->thermal)) {
>                 result = PTR_ERR(priv->thermal);
>                 goto free_art_trt;
> Index: linux-pm/drivers/thermal/kirkwood_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/kirkwood_thermal.c
> +++ linux-pm/drivers/thermal/kirkwood_thermal.c
> @@ -71,8 +71,8 @@ static int kirkwood_thermal_probe(struct
>         if (IS_ERR(priv->sensor))
>                 return PTR_ERR(priv->sensor);
>
> -       thermal = thermal_zone_device_register("kirkwood_thermal", 0, 0,
> -                                              priv, &ops, NULL, 0, 0);
> +       thermal = thermal_tripless_zone_device_register("kirkwood_thermal",
> +                                                       priv, &ops, NULL);
>         if (IS_ERR(thermal)) {
>                 dev_err(&pdev->dev,
>                         "Failed to register thermal zone device\n");
> Index: linux-pm/drivers/thermal/spear_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/spear_thermal.c
> +++ linux-pm/drivers/thermal/spear_thermal.c
> @@ -122,8 +122,8 @@ static int spear_thermal_probe(struct pl
>         stdev->flags = val;
>         writel_relaxed(stdev->flags, stdev->thermal_base);
>
> -       spear_thermal = thermal_zone_device_register("spear_thermal", 0, 0,
> -                               stdev, &ops, NULL, 0, 0);
> +       spear_thermal = thermal_tripless_zone_device_register("spear_thermal",
> +                                                             stdev, &ops, NULL);
>         if (IS_ERR(spear_thermal)) {
>                 dev_err(&pdev->dev, "thermal zone device is NULL\n");
>                 ret = PTR_ERR(spear_thermal);
>
>
>
