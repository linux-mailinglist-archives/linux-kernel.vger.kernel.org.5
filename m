Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45297DC4CF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 04:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbjJaDTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 23:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjJaDTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 23:19:02 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E3498
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 20:18:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507a55302e0so7369900e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 20:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698722338; x=1699327138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNQLwo49Px+6WCj/W2NTIYzN6i7OOT1g2UlISqpXweI=;
        b=YXXmjtiZfM0IYhnTtZ6/jyWIOK2egCHGREdyABHttBSLsyyHypz0qM7u25ogD+b+zb
         FQjSDPByq3cv3yTOe1rh1CvJD131yFX9rGqpz+TLBi/aDWZMTos3A+60csJvmkpaPTcw
         Yz0TUXsKHYIDfWjljcH/GwuLFdkMAGPcb9uTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698722338; x=1699327138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNQLwo49Px+6WCj/W2NTIYzN6i7OOT1g2UlISqpXweI=;
        b=EAgKp79o+jRHXC1SZ0d/zrO8GJwEPD3KyeUe6ZJb1OBARv3JP2+9o7vqNm07x0w7wN
         ddNDyC6KKI+76Tq4yWIgl2Wfo5zDNSTnzDCqPCtG2HWT8fHOD5eKsJwiGFmJM+X1yqEG
         TXlE9lBMnP+wFfFzc/V3DzvsI6EsuZvrFY4nN1THmmQ8fbNsoJjWMLmGRibm8SUyIgy+
         w6gfU7WRuTZHxQQZVREYo1aS5C1HMKBC8mrhoosqK/O57rUhbMq6qIow8ewntgJQPG1o
         GWp9hL9Smu96STesrXrEBSbJ84UoWJpEzbrML+QUDVdykafLMI23TQynFUfhdnonyOX0
         xjBA==
X-Gm-Message-State: AOJu0YxzVTWTtZiPYBy1MvVbQ39NnVBJesMjKdxgu8FtDYYXlqW+pNvo
        qg2M7puVgvCf9lMhFgOEtO0rP9cZCrZeeXDt/7+eNZatthwfGjyS
X-Google-Smtp-Source: AGHT+IG70+RAy2D5Z99ro2HsB5kY+gz5hD4sy61Te8tVYIoK+ihDLf3y0canUC3TaqjFMHD0D2J28xsHskYVMTUQ5Ec=
X-Received: by 2002:ac2:4435:0:b0:500:a378:db71 with SMTP id
 w21-20020ac24435000000b00500a378db71mr8153669lfl.57.1698722337994; Mon, 30
 Oct 2023 20:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231030132257.85379-1-angelogioacchino.delregno@collabora.com> <20231030132257.85379-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231030132257.85379-2-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 31 Oct 2023 11:18:46 +0800
Message-ID: <CAGXv+5EhRUz6qptSzhzbcq4-qQKDzN5xFtS0WMNUCOH5JSL0Jw@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/panfrost: Implement ability to turn on/off GPU
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 9:23=E2=80=AFPM AngeloGioacchino Del Regno
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
> issues when turning on and off clocks aggressively (in PM runtime),
> with the GPU locking up and unable to soft reset, eventually resulting
> in a full system lockup.
>
> Doing this only for full system sleep never showed issues in 3 days
> of testing by suspending and resuming the system continuously.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
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

Nit: I'd just use bitfields. They are easier to set and get without
extra macros, and the naming would be self-explanatory. Unless you
expect a need to do mask checking (though the compiler might be able
to optimize this).

ChenYu

>  };
>
>  struct panfrost_device {
> --
> 2.42.0
>
