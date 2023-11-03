Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537197E016C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346818AbjKCI67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346539AbjKCI6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:58:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2B0D46
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 01:58:46 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50949b7d7ffso2196631e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 01:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699001924; x=1699606724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpja5pDDFxtVY86Bh/msPN1vq4hMql2vt1zs/3+McHU=;
        b=mUg4zMbOUwSBGSTxnX+W29oqBWEEbg07xDE3eQodo30aPRG2pFWNMUkJdU3msCS69f
         l1s/nPbwQMsoQF0ofNTNiivotTXseBu5O19aW0A1yfXWa/eQ0jqrF9zf8+BM+GLycVjo
         3ZVdtvINfCmA/em3ZqNHvfqh0F2QZiswD28T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699001924; x=1699606724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpja5pDDFxtVY86Bh/msPN1vq4hMql2vt1zs/3+McHU=;
        b=uXi1Mwq4HlIj4/xh62YYQRYTh8SVgBt64kr8/8yh+pM6htAy7IYm06Wk6A0+9o/C4e
         kphZAO8sRxNVNNdk0hD4YznPZ1qbbii5JDEN7mZjQXrBR5gUm5AV1qjYG+m2Qe8t36TX
         sFm4F/wSkeQJVWBVS5QgoXLwOdLbXZ1ZUfjASqUIeJZFVpJGzbIQr3JotOxzDYbitgPp
         YCm5PhvLufGYLu1nRXxw9K0+SSggoS9DOrvzkLf12nn5ra+HzoBpaEdC8WFXkldNcA7i
         UFIL1G2Sn82bwXUn0R5PY+bcIwEAyhz6ssACAs/hp3y7XjhFy4HyLip0o4e0H9f11Czq
         cHPw==
X-Gm-Message-State: AOJu0YxN7kTqOgberi/jgURTA4BStDTCZceouBY9nk6mc4sh7Ag69coM
        TskwHFzHZ5FVI1Dvbe3iUlO3lkgXjPjKCvmOEwRoILTYt0L2jiJa
X-Google-Smtp-Source: AGHT+IECy7AraONKdQn+XwWDJPrpeClg9sVBr+83yBLkEAupT9WQiihp/He8w49fGlKVEtuTNALrHXiKFHWZNi77tY8=
X-Received: by 2002:a19:430d:0:b0:507:9d70:b297 with SMTP id
 q13-20020a19430d000000b005079d70b297mr14535011lfa.60.1699001924308; Fri, 03
 Nov 2023 01:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231102142643.75288-1-angelogioacchino.delregno@collabora.com>
 <20231102142643.75288-4-angelogioacchino.delregno@collabora.com>
 <CAGXv+5FHwhQuDf+JCSPg_q+eV1Qb37e6bN7djO5GUSbB5pBv_A@mail.gmail.com> <71826cf2-460d-48d1-85d3-735646db1e2a@collabora.com>
In-Reply-To: <71826cf2-460d-48d1-85d3-735646db1e2a@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 3 Nov 2023 16:58:33 +0800
Message-ID: <CAGXv+5FzYrthgjbDU4WFtY-kyLUK14NZQn5OO9mUyrLeYB+vJA@mail.gmail.com>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 4:54=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 03/11/23 06:12, Chen-Yu Tsai ha scritto:
> > On Thu, Nov 2, 2023 at 10:26=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Currently, the GPU is being internally powered off for runtime suspend
> >> and turned back on for runtime resume through commands sent to it, but
> >> note that the GPU doesn't need to be clocked during the poweroff state=
,
> >> hence it is possible to save some power on selected platforms.
> >>
> >> Add suspend and resume handlers for full system sleep and then add
> >> a new panfrost_gpu_pm enumeration and a pm_features variable in the
> >> panfrost_compatible structure: BIT(GPU_PM_CLK_DIS) will be used to
> >> enable this power saving technique only on SoCs that are able to
> >> safely use it.
> >>
> >> Note that this was implemented only for the system sleep case and not
> >> for runtime PM because testing on one of my MediaTek platforms showed
> >> issues when turning on and off clocks aggressively (in PM runtime)
> >> resulting in a full system lockup.
> >>
> >> Doing this only for full system sleep never showed issues during my
> >> testing by suspending and resuming the system continuously for more
> >> than 100 cycles.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@c=
ollabora.com>
> >> ---
> >>
> >> Note: Even after fixing the panfrost_power_off() function, I'm still
> >> getting issues with turning off the clocks at .runtime_suspend() but
> >> this time, instead of getting a GPU lockup, the entire SoC will deadlo=
ck
> >> bringing down the entire system with it (so it's even worst!) :-)
> >
> > IIRC the power domain controller also manages some bus isolation bits
> > that prevent SoC lockup when the clock is disabled. Would reversing
> > the runtime PM calls and the clock calls help?
> >
>
> Thanks for the reminder, but I tested that already... that doesn't work.
>
> There's one more thing I tried: on the MFG iospace, there are debug regis=
ters
> that you can poll to check if all bus transactions are finished (so, if t=
he bus
> is idle).
> During local testing, I even hacked in that, and even with the actual bus=
 being
> completely idle, it still freezes... and also checked some more in downst=
ream
> code (for Dimensity 9200, kernel 5.10) if there was any other "trick" tha=
t I
> could make use of, but to no avail.
>
> I'd propose to get at least this power saving upstreamed, then perhaps in=
 the
> future we can somehow revisit this to implement some more aggressive powe=
r
> management code?
> We're still getting a generous power saving with this one, I'd say...
>
> Anyway, I expect us to be effectively able to be more aggressive here, bu=
t I
> also expect that to take quite a bit of time (and probably some help from
> MediaTek as well)...

Sounds good to me.

> Angelo
>
> > ChenYu
> >
> >>   drivers/gpu/drm/panfrost/panfrost_device.c | 61 ++++++++++++++++++++=
--
> >>   drivers/gpu/drm/panfrost/panfrost_device.h | 11 ++++
> >>   2 files changed, 68 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/=
drm/panfrost/panfrost_device.c
> >> index 28f7046e1b1a..2022ed76a620 100644
> >> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> >> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> >> @@ -403,7 +403,7 @@ void panfrost_device_reset(struct panfrost_device =
*pfdev)
> >>          panfrost_job_enable_interrupts(pfdev);
> >>   }
> >>
> >> -static int panfrost_device_resume(struct device *dev)
> >> +static int panfrost_device_runtime_resume(struct device *dev)
> >>   {
> >>          struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> >>
> >> @@ -413,7 +413,7 @@ static int panfrost_device_resume(struct device *d=
ev)
> >>          return 0;
> >>   }
> >>
> >> -static int panfrost_device_suspend(struct device *dev)
> >> +static int panfrost_device_runtime_suspend(struct device *dev)
> >>   {
> >>          struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> >>
> >> @@ -426,5 +426,58 @@ static int panfrost_device_suspend(struct device =
*dev)
> >>          return 0;
> >>   }
> >>
> >> -EXPORT_GPL_RUNTIME_DEV_PM_OPS(panfrost_pm_ops, panfrost_device_suspen=
d,
> >> -                             panfrost_device_resume, NULL);
> >> +static int panfrost_device_resume(struct device *dev)
> >> +{
> >> +       struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> >> +       int ret;
> >> +
> >> +       if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> >> +               ret =3D clk_enable(pfdev->clock);
> >> +               if (ret)
> >> +                       return ret;
> >> +
> >> +               if (pfdev->bus_clock) {
> >> +                       ret =3D clk_enable(pfdev->bus_clock);
> >> +                       if (ret)
> >> +                               goto err_bus_clk;
> >> +               }
> >> +       }
> >> +
> >> +       ret =3D pm_runtime_force_resume(dev);
> >> +       if (ret)
> >> +               goto err_resume;
> >> +
> >> +       return 0;
> >> +
> >> +err_resume:
> >> +       if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS) && pfdev->b=
us_clock)
> >> +               clk_disable(pfdev->bus_clock);
> >> +err_bus_clk:
> >> +       if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
> >> +               clk_disable(pfdev->clock);
> >> +       return ret;
> >> +}
> >> +
> >> +static int panfrost_device_suspend(struct device *dev)
> >> +{
> >> +       struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> >> +       int ret;
> >> +
> >> +       ret =3D pm_runtime_force_suspend(dev);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> >> +               clk_disable(pfdev->clock);
> >> +
> >> +               if (pfdev->bus_clock)
> >> +                       clk_disable(pfdev->bus_clock);
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) =3D {
> >> +       RUNTIME_PM_OPS(panfrost_device_runtime_suspend, panfrost_devic=
e_runtime_resume, NULL)
> >> +       SYSTEM_SLEEP_PM_OPS(panfrost_device_suspend, panfrost_device_r=
esume)
> >> +};
> >> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/=
drm/panfrost/panfrost_device.h
> >> index 1ef38f60d5dc..d7f179eb8ea3 100644
> >> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> >> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> >> @@ -25,6 +25,14 @@ struct panfrost_perfcnt;
> >>   #define NUM_JOB_SLOTS 3
> >>   #define MAX_PM_DOMAINS 5
> >>
> >> +/**
> >> + * enum panfrost_gpu_pm - Supported kernel power management features
> >> + * @GPU_PM_CLK_DIS:  Allow disabling clocks during system suspend
> >> + */
> >> +enum panfrost_gpu_pm {
> >> +       GPU_PM_CLK_DIS,
> >> +};
> >> +
> >>   struct panfrost_features {
> >>          u16 id;
> >>          u16 revision;
> >> @@ -75,6 +83,9 @@ struct panfrost_compatible {
> >>
> >>          /* Vendor implementation quirks callback */
> >>          void (*vendor_quirk)(struct panfrost_device *pfdev);
> >> +
> >> +       /* Allowed PM features */
> >> +       u8 pm_features;
> >>   };
> >>
> >>   struct panfrost_device {
> >> --
> >> 2.42.0
> >>
>
