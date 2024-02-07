Return-Path: <linux-kernel+bounces-56791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B1084CF39
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1B0282529
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BEE81AC6;
	Wed,  7 Feb 2024 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UsmwfAgI"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FCB811FF
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324417; cv=none; b=gklWBHN9pZlCpENMcCJLLIT9h0K8f9OmOVGsg35EePAq20P9O7anED85HH1MhZmlsaO+Vh+ATaV4BNn84BUv64XbMfHHiD3HgyJ1qaQLJdVJqJONDv+FkEX/bNg21pDIfy1ppe1z+ucG/ohMhw6AE6EyS0lcTn2BMbi2LcI2gRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324417; c=relaxed/simple;
	bh=+Fa/C2EFMdajM2niFcCCxdI1KyXT1Ta8Qi2ernG2B2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DzZsCb4TXe6GF06ZjDPuemqrw+up2C++bUwDyuTU26PkW+23ZBF18iOsGITjt0SQ92ShUNIIrLOqALoeIEgq53QRvrD6oS1eEensueHaasENRfk3NXi6RNr6J5dQ3NRnyhsVHBY/U3Ch3vgoCxlqH6JUJeGpIEqIvuMh7pWXmHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UsmwfAgI; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-511616b73ddso1448789e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 08:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707324413; x=1707929213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RwTwttuqjzWEt3bOhHlHwf+AU7J+iXmyu2hTR/Dt/U=;
        b=UsmwfAgIyFZDSNeE9gQZtTwHOqOdvj6V6/HuQ4pSv63KAJjSHEHhLjf+hD/4gkeApy
         eAZumvcGaoGE2xSAE36WrEa+7ZcjK0YmoCpcW7amZJE28sc+ez+GW10Jifh209/AAomW
         l0J0LH74yjo2rKBQQ1mW/XL6X5wXzJiWMMwMYMIBVKGbsQoYnteGlKhHVF9uZznjcn+R
         hRJluHT2xGDH25eayahEXcYyWjgvE9oTlge39/Kgi8/xP2Mx0567AkUCgrWoefg1WYQc
         vgF6YrmYOwUzJxhU3oq8zL7yBpH7o5QAW8Xyx7GfDBceK38hROeOOLrePoyVJqmnfv2d
         0afA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324413; x=1707929213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RwTwttuqjzWEt3bOhHlHwf+AU7J+iXmyu2hTR/Dt/U=;
        b=rxvnfS4EE4HGrBeUt6nFg2KNkFcBmb5zNv4XfR0HA67nKxeBbxzVlOBuCYXZPbRs3G
         JOsgS3NqX9XzRtUa5mQJtBNK8qEtbEqTP4DK20JYVX5uxt3ztp/od0TQr58GtdWL+iBY
         2cAVx3sJaesc3QoLos1L3hRAy7gu7YitmYl47uNDBNc21h0JoELSo5Qi1/15FwLIhAxr
         RgQ85NNRfqSwiqt0p7RXT2lZhHl4G7OfvJmoNVHwDx0RlZ4TFdwFqvieSNCMv/n1gBAg
         dfSJTJjpd7DALJp5UouvMWqqMEniiqmRKceHAVd9VCaK0Ijh22kcfgFZ6Q07H2YpezEn
         xERw==
X-Gm-Message-State: AOJu0YxLE1h7lipV9kW+VI3/WWfl4O1OL/kWYDhvk9UDihHbgHYqrAX6
	4yFRGLOATgx8z73RERWO9dm7ayuNxxAPHMuPukMVEfZjBJun0ewtnvlRr/9uzENR9Z50SSkuiP9
	BgKVbv+x4RJo3Hv1BxKmPReQ0NfvSsVlMUfeo
X-Google-Smtp-Source: AGHT+IH1SP9WBf7biw6iJHKM04dN4i/9cwKqfZrHQPB6RJEhqG5aAdQyWQ2d5bhGeUpPPiVLDf18GEIGRgZ+8w08z40=
X-Received: by 2002:ac2:4a90:0:b0:511:3a11:166c with SMTP id
 l16-20020ac24a90000000b005113a11166cmr3905357lfp.34.1707324413182; Wed, 07
 Feb 2024 08:46:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207100619.3947442-1-pranavpp@google.com> <20240207100619.3947442-2-pranavpp@google.com>
In-Reply-To: <20240207100619.3947442-2-pranavpp@google.com>
From: Pranav Prasad <pranavpp@google.com>
Date: Wed, 7 Feb 2024 08:46:42 -0800
Message-ID: <CACkwYU1TWqb_3=NcCU1N+Va_x0TrdLgTXuT7UYqC+xqarTVG8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] alarmtimer: Create alarmtimer sysfs to make duration
 of kernel suspend check configurable
To: tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, Kelly Rossmoyer <krossmo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please ignore this patch, submitting v2 with some more suggested fixes.

Pranav

On Wed, Feb 7, 2024 at 2:06=E2=80=AFAM Pranav Prasad <pranavpp@google.com> =
wrote:
>
> Currently, the alarmtimer_suspend does not allow the kernel
> to suspend if the next alarm is within 2 seconds.
> Create alarmtimer sysfs to make the value of 2 seconds configurable.
> This allows flexibility to provide a different value based on the
> type of device running the Linux kernel. As a data point, about 40% of
> kernel suspend failures in a subset of Android devices were due to
> this check. A differently configured value can avoid these suspend
> failures which performs a lot of additional work affecting the
> power consumption of these Android devices.
>
> Signed-off-by: Pranav Prasad <pranavpp@google.com>
> Signed-off-by: Kelly Rossmoyer <krossmo@google.com>
> ---
>  kernel/time/alarmtimer.c | 61 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> index 4657cb8e8b1f..e5d2e560b4c1 100644
> --- a/kernel/time/alarmtimer.c
> +++ b/kernel/time/alarmtimer.c
> @@ -33,6 +33,8 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/alarmtimer.h>
>
> +static const char alarmtimer_group_name[] =3D "alarmtimer";
> +
>  /**
>   * struct alarm_base - Alarm timer bases
>   * @lock:              Lock for syncrhonized access to the base
> @@ -63,6 +65,56 @@ static struct rtc_timer              rtctimer;
>  static struct rtc_device       *rtcdev;
>  static DEFINE_SPINLOCK(rtcdev_lock);
>
> +/* Duration to check for soonest alarm during kernel suspend */
> +static u64 suspend_check_duration_ns =3D 2 * NSEC_PER_SEC;
> +
> +static ssize_t suspend_check_duration_show(struct kobject *kobj,
> +                       struct kobj_attribute *attr, char *buf)
> +{
> +       return sysfs_emit(buf, "%llu\n", suspend_check_duration_ns);
> +}
> +
> +static ssize_t suspend_check_duration_store(struct kobject *kobj,
> +                       struct kobj_attribute *attr, const char *buf, siz=
e_t n)
> +{
> +       u64 val;
> +
> +       if (kstrtou64(buf, 10, &val))
> +               return -EINVAL;
> +
> +       suspend_check_duration_ns =3D val;
> +
> +       return n;
> +}
> +
> +static struct kobj_attribute suspend_check_duration =3D
> +                       __ATTR_RW(suspend_check_duration);
> +
> +static struct attribute *alarmtimer_attrs[] =3D {
> +       &suspend_check_duration.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group alarmtimer_attr_group =3D {
> +       .name   =3D alarmtimer_group_name,
> +       .attrs  =3D alarmtimer_attrs,
> +};
> +
> +/**
> + * alarmtimer_sysfs_add - Adds sysfs attributes for alarmtimer
> + *
> + * Returns 0 if successful, non-zero value for error.
> + */
> +static int alarmtimer_sysfs_add(void)
> +{
> +       int ret =3D sysfs_create_group(kernel_kobj, &alarmtimer_attr_grou=
p);
> +
> +       if (ret)
> +               pr_warn("[%s] failed to create a sysfs group\n", __func__=
);
> +
> +       return ret;
> +}
> +
>  /**
>   * alarmtimer_get_rtcdev - Return selected rtcdevice
>   *
> @@ -98,8 +150,11 @@ static int alarmtimer_rtc_add_device(struct device *d=
ev)
>
>         pdev =3D platform_device_register_data(dev, "alarmtimer",
>                                              PLATFORM_DEVID_AUTO, NULL, 0=
);
> -       if (!IS_ERR(pdev))
> +       if (!IS_ERR(pdev)) {
>                 device_init_wakeup(&pdev->dev, true);
> +               if (alarmtimer_sysfs_add())
> +                       pr_warn("[%s] Failed to add alarmtimer sysfs attr=
ibutes\n", __func__);
> +       }
>
>         spin_lock_irqsave(&rtcdev_lock, flags);
>         if (!IS_ERR(pdev) && !rtcdev) {
> @@ -279,8 +334,8 @@ static int alarmtimer_suspend(struct device *dev)
>         if (min =3D=3D 0)
>                 return 0;
>
> -       if (ktime_to_ns(min) < 2 * NSEC_PER_SEC) {
> -               pm_wakeup_event(dev, 2 * MSEC_PER_SEC);
> +       if (ktime_to_ns(min) < suspend_check_duration_ns) {
> +               pm_wakeup_event(dev, suspend_check_duration_ns/NSEC_PER_M=
SEC);
>                 return -EBUSY;
>         }
>
> --
> 2.43.0.594.gd9cf4e227d-goog
>

