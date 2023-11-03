Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DE77DFEAC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 06:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjKCFNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 01:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKCFNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 01:13:04 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED651A4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 22:12:58 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso23831741fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 22:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698988377; x=1699593177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nn1qLD9vHXNL2fzUzW9TiHQVVHyoRzfM0xQyXA2NHEA=;
        b=njndTbCoBMNzomjxklLUK4cF4hic3WtuekcuT5H4kaquymYd36rFYhk9vBaA2+wB2f
         dI+aLswvpEcYb9kA0Tzsyyrsm0jHYsl3ElfDIdfRFVwypOhRiuajyiN8+wqNxjcH+OJm
         sXT+Ev62gUi0CUqbuCG79BFImgNz9mZEWON2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698988377; x=1699593177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nn1qLD9vHXNL2fzUzW9TiHQVVHyoRzfM0xQyXA2NHEA=;
        b=nEf9RAliB4PK0L61z7foSI5UPRRhpBVBUmyQtrCKdSxbCv2ThbWwd9u7iosUP3jN4Z
         2BATNAeA4LNMoz/pEQePsMq/j/9PaUf0Z/nHlHRs2rmUpMYJbrwi3M5gUIebOa+hYKG+
         7NII22zJVc8ESOOYZEaSpVj+fjAd7qQRxTy1A92ZTytglQEhQu3/QbtD9q9F84jDNRQF
         ZwB2wqkM2zLC+CDwA+sITKXbF7nr2xFQNqnieuvBnK8SvMC9wWvhDFK/gSrwelHPAynb
         8CXOhHgS+LxTG9cdp8Mgih//uGGMNEhDjmIIbjLbcHPLVZMt8vGBT1IE6JOkCyfH5QcY
         KQqA==
X-Gm-Message-State: AOJu0Yzr4UbMRWLNN0N7B9Z6oHjchI//gDAOh7TO/JBBp7MJi7LA5yds
        NrT3vXlAmbuzxMOspd/rQD+nsA2wikj2C1+RwQKNjQ==
X-Google-Smtp-Source: AGHT+IF9MB1uceS9yyoXZyzYv0UhO0V7UARkFbRH7bMYHXMlG9qVjbGvMAAM+itJTqlyKhS9ktxlCfTUKb740JWY4ms=
X-Received: by 2002:a05:6512:3b8c:b0:509:4ab2:3635 with SMTP id
 g12-20020a0565123b8c00b005094ab23635mr3359299lfv.59.1698988376012; Thu, 02
 Nov 2023 22:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231102142643.75288-1-angelogioacchino.delregno@collabora.com> <20231102142643.75288-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231102142643.75288-4-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 3 Nov 2023 13:12:44 +0800
Message-ID: <CAGXv+5FHwhQuDf+JCSPg_q+eV1Qb37e6bN7djO5GUSbB5pBv_A@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] drm/panfrost: Implement ability to turn on/off GPU
 clocks in suspend
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     boris.brezillon@collabora.com, robh@kernel.org,
        steven.price@arm.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 10:26=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Currently, the GPU is being internally powered off for runtime suspend
> and turned back on for runtime resume through commands sent to it, but
> note that the GPU doesn't need to be clocked during the poweroff state,
> hence it is possible to save some power on selected platforms.
>
> Add suspend and resume handlers for full system sleep and then add
> a new panfrost_gpu_pm enumeration and a pm_features variable in the
> panfrost_compatible structure: BIT(GPU_PM_CLK_DIS) will be used to
> enable this power saving technique only on SoCs that are able to
> safely use it.
>
> Note that this was implemented only for the system sleep case and not
> for runtime PM because testing on one of my MediaTek platforms showed
> issues when turning on and off clocks aggressively (in PM runtime)
> resulting in a full system lockup.
>
> Doing this only for full system sleep never showed issues during my
> testing by suspending and resuming the system continuously for more
> than 100 cycles.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>
> Note: Even after fixing the panfrost_power_off() function, I'm still
> getting issues with turning off the clocks at .runtime_suspend() but
> this time, instead of getting a GPU lockup, the entire SoC will deadlock
> bringing down the entire system with it (so it's even worst!) :-)

IIRC the power domain controller also manages some bus isolation bits
that prevent SoC lockup when the clock is disabled. Would reversing
the runtime PM calls and the clock calls help?

ChenYu

>  drivers/gpu/drm/panfrost/panfrost_device.c | 61 ++++++++++++++++++++--
>  drivers/gpu/drm/panfrost/panfrost_device.h | 11 ++++
>  2 files changed, 68 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 28f7046e1b1a..2022ed76a620 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -403,7 +403,7 @@ void panfrost_device_reset(struct panfrost_device *pf=
dev)
>         panfrost_job_enable_interrupts(pfdev);
>  }
>
> -static int panfrost_device_resume(struct device *dev)
> +static int panfrost_device_runtime_resume(struct device *dev)
>  {
>         struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
>
> @@ -413,7 +413,7 @@ static int panfrost_device_resume(struct device *dev)
>         return 0;
>  }
>
> -static int panfrost_device_suspend(struct device *dev)
> +static int panfrost_device_runtime_suspend(struct device *dev)
>  {
>         struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
>
> @@ -426,5 +426,58 @@ static int panfrost_device_suspend(struct device *de=
v)
>         return 0;
>  }
>
> -EXPORT_GPL_RUNTIME_DEV_PM_OPS(panfrost_pm_ops, panfrost_device_suspend,
> -                             panfrost_device_resume, NULL);
> +static int panfrost_device_resume(struct device *dev)
> +{
> +       struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> +       int ret;
> +
> +       if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> +               ret =3D clk_enable(pfdev->clock);
> +               if (ret)
> +                       return ret;
> +
> +               if (pfdev->bus_clock) {
> +                       ret =3D clk_enable(pfdev->bus_clock);
> +                       if (ret)
> +                               goto err_bus_clk;
> +               }
> +       }
> +
> +       ret =3D pm_runtime_force_resume(dev);
> +       if (ret)
> +               goto err_resume;
> +
> +       return 0;
> +
> +err_resume:
> +       if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS) && pfdev->bus_=
clock)
> +               clk_disable(pfdev->bus_clock);
> +err_bus_clk:
> +       if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
> +               clk_disable(pfdev->clock);
> +       return ret;
> +}
> +
> +static int panfrost_device_suspend(struct device *dev)
> +{
> +       struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret =3D pm_runtime_force_suspend(dev);
> +       if (ret)
> +               return ret;
> +
> +       if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> +               clk_disable(pfdev->clock);
> +
> +               if (pfdev->bus_clock)
> +                       clk_disable(pfdev->bus_clock);
> +       }
> +
> +       return 0;
> +}
> +
> +EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) =3D {
> +       RUNTIME_PM_OPS(panfrost_device_runtime_suspend, panfrost_device_r=
untime_resume, NULL)
> +       SYSTEM_SLEEP_PM_OPS(panfrost_device_suspend, panfrost_device_resu=
me)
> +};
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm=
/panfrost/panfrost_device.h
> index 1ef38f60d5dc..d7f179eb8ea3 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -25,6 +25,14 @@ struct panfrost_perfcnt;
>  #define NUM_JOB_SLOTS 3
>  #define MAX_PM_DOMAINS 5
>
> +/**
> + * enum panfrost_gpu_pm - Supported kernel power management features
> + * @GPU_PM_CLK_DIS:  Allow disabling clocks during system suspend
> + */
> +enum panfrost_gpu_pm {
> +       GPU_PM_CLK_DIS,
> +};
> +
>  struct panfrost_features {
>         u16 id;
>         u16 revision;
> @@ -75,6 +83,9 @@ struct panfrost_compatible {
>
>         /* Vendor implementation quirks callback */
>         void (*vendor_quirk)(struct panfrost_device *pfdev);
> +
> +       /* Allowed PM features */
> +       u8 pm_features;
>  };
>
>  struct panfrost_device {
> --
> 2.42.0
>
