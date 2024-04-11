Return-Path: <linux-kernel+bounces-141591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FBA8A2065
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5EEBB21928
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316A11CF96;
	Thu, 11 Apr 2024 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dH6DWJCr"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69321C294
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712868408; cv=none; b=fmuHmyXXHPWDbApmUrVFqhx19m9oyxe6CkVwLJXKqNYfwASkk9wErGhX7YrdTQUUUvdNpOIIGv/hkO6x2l/RNjTOgEADBjtO3DP6bYaV0FsCnioSIPWf40a4Fq2X9mNNkK+0rvEXJBlowxuKC3hodEzodh2pbbSGNRKdcJJAPyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712868408; c=relaxed/simple;
	bh=OxJotFEVcyZpSuyTpPU36bAgJGIAZrz7JYB5vj7LE9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rN3iNIe+n/TPBnhLslz5NUJIJbBbPqCSHLiPSFB2lgaLglkBKrPLv7FTFbfXp389OA0soferDaW6l2g95ukO1ELHoSVja0RemEGMfrWOYDE4/9N+/zyYevGab+frXJp28K4XTIuqWXlUHFnnJJ4zu31/bxO7T8/sk7YMalkr+pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dH6DWJCr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e0bfc42783so2139185ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712868406; x=1713473206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIDVajEu5qVpvE8z50G25VfbDDiky2dkQVswDqavWmw=;
        b=dH6DWJCrC+i1iUnJMQRQkwJxsPfSkNFJSkl+ZQJvoCD9JVQHbAggzl2BU1qP5Cyc01
         CvBhxTo4G8Zn8Aoj+6azRThSB9NcePVpk7kXXRU5aetAAyet9crrb+9bP0L7ojtXo/Wb
         DjLrwqJJgo/APvVYqMnJoeKxm6GNrPMGPD01s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712868406; x=1713473206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIDVajEu5qVpvE8z50G25VfbDDiky2dkQVswDqavWmw=;
        b=cxZSgJd57iJ0h3aJ0ImhCdh7NHgtKwqzTSo73VnlxPovex6DwuIUDJKZO5/gyHK+dr
         7IT+1lFaszihrUSNzk0oj8PZ1Ub9mFU/JbhLENijYuqyFYL0Ey7xItX+5NyuGGZcvRQL
         UKtcI5wysJS48SBiJtm6T2Z9ZNz93QHECxT2SZt9KWiiM2taNOSQ/2fG9WbYsPB/5lzK
         2telyXdJ1r9ScXXp4M6MGnv3tFHl1E1pNzVmbhv6A6m+kgDq1m0e6dES7gVIfSHQIRXX
         J04oNU47ORI6TpL1z2fWmguAyDLcJchGNmjuHLQNm8mfVvD0oXufSFWDEELgrDQbSJrP
         9CYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKHn6t+I8rvmkjLL1IEpyviGTR9MRl6UOT4Tp6/mdBE4JmeguRLK6n0KtjOx5ZoOsBD4xhebYCkrwyCQvkjnth2ZouJ476v7uHdWR1
X-Gm-Message-State: AOJu0YwReZ/1U01sNI27PoLsdjhlNF1HGmxRUH2G+xTEy9f7/5+Vy69L
	3eWBsqJj4g76a9Pp0hc3w7RwNp3vac4GvHac3bCoVJcKxDWRXA7Q6rxzUjxqZoqGrvlpVkXhtjF
	s6sYqD0UScxwB4872OuyfV3sFlkKNNdOpF3lVvY9QKUFnYw8rg0AxepQ=
X-Google-Smtp-Source: AGHT+IHaPFmbWl4CRobBCOwnVbN1ApnbwICulL1MHyiOpyCXRJEfB/+tR9nlXdoQX2nVlx/a/PWkPUPCTsjRQkCZQqs=
X-Received: by 2002:a17:902:ecc7:b0:1e5:2885:2 with SMTP id
 a7-20020a170902ecc700b001e528850002mr558906plh.68.1712868406134; Thu, 11 Apr
 2024 13:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119110842.772606-1-abailon@baylibre.com> <20240119110842.772606-3-abailon@baylibre.com>
In-Reply-To: <20240119110842.772606-3-abailon@baylibre.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Thu, 11 Apr 2024 16:46:35 -0400
Message-ID: <CAEXTbpeJ=3kxeKy4rXUfNEO==XYQ2DQx+ex2nLNkur_X6p1VVQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] thermal: Add support of multi sensors to thermal_core
To: Alexandre Bailon <abailon@baylibre.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hsin-Te Yuan <yuanhsinte@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Thu, Apr 11, 2024 at 4:34=E2=80=AFPM Alexandre Bailon <abailon@baylibre.=
com> wrote:
>
> This adds support of multi sensors to thermal.
> Currently, this only support the get_temp operation.
> This returns an average temperature of all the sensors.
> If defined, a coefficient is applied to the value read from the sensor
> before computing the average.
>
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  drivers/thermal/Makefile        |   1 +
>  drivers/thermal/thermal_core.h  |   7 ++
>  drivers/thermal/thermal_multi.c | 178 ++++++++++++++++++++++++++++++++
>  3 files changed, 186 insertions(+)
>  create mode 100644 drivers/thermal/thermal_multi.c
>
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index c934cab309ae..757289a406f7 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -6,6 +6,7 @@ CFLAGS_thermal_core.o           :=3D -I$(src)
>  obj-$(CONFIG_THERMAL)          +=3D thermal_sys.o
>  thermal_sys-y                  +=3D thermal_core.o thermal_sysfs.o
>  thermal_sys-y                  +=3D thermal_trip.o thermal_helpers.o
> +thermal_sys-y                  +=3D thermal_multi.o
>
>  # netlink interface to manage the thermal framework
>  thermal_sys-$(CONFIG_THERMAL_NETLINK)          +=3D thermal_netlink.o
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_cor=
e.h
> index 0a3b3ec5120b..26e83a5c8298 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -138,6 +138,13 @@ ssize_t weight_show(struct device *, struct device_a=
ttribute *, char *);
>  ssize_t weight_store(struct device *, struct device_attribute *, const c=
har *,
>                      size_t);
>
> +/* Multi sensors */
> +int thermal_multi_sensor_validate_coeff(int *coeff, int count, int offse=
t);
> +int thermal_multi_sensor_register(const char *name,
> +       struct thermal_zone_device *sensor_tz, int coeff);
> +void thermal_multi_sensor_unregister(struct thermal_zone_device *sensor_=
tz);
> +
> +
>  #ifdef CONFIG_THERMAL_STATISTICS
>  void thermal_cooling_device_stats_update(struct thermal_cooling_device *=
cdev,
>                                          unsigned long new_state);
> diff --git a/drivers/thermal/thermal_multi.c b/drivers/thermal/thermal_mu=
lti.c
> new file mode 100644
> index 000000000000..a5a4f1f2d594
> --- /dev/null
> +++ b/drivers/thermal/thermal_multi.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +#include <linux/types.h>
> +#include <linux/string.h>
> +
> +#include "thermal_core.h"
> +
> +struct sensor_interface {
> +       struct thermal_zone_device *tz;
> +       int coeff;
> +
> +       struct list_head node;
> +};
> +
> +struct multi_sensor_thermal_zone {
> +       struct thermal_zone_device *tz;
> +       struct mutex sensors_lock;
> +       struct list_head sensors;
> +
> +       struct list_head node;
> +};
> +
> +static DEFINE_MUTEX(multi_tz_mutex);
> +static LIST_HEAD(multi_tz_list);
> +
> +#define TJ_MAX 120000
> +
> +static int multi_sensor_get_temp(struct thermal_zone_device *tz, int *te=
mp)
> +{
> +       struct multi_sensor_thermal_zone *multi_tz =3D tz->devdata;
> +       struct sensor_interface *sensor;
> +       int accumulated_temp =3D 0;
> +       u32 accumulated_coeff;

Should we initialize accumulated_coeff to 0 as well?

> +       int ret;
> +
> +       mutex_lock(&multi_tz->sensors_lock);
> +
> +       if (list_empty(&multi_tz->sensors)) {
> +               mutex_unlock(&multi_tz->sensors_lock);
> +               return -ENODEV;
> +       }
> +
> +       list_for_each_entry(sensor, &multi_tz->sensors, node) {
> +               ret =3D thermal_zone_get_temp(sensor->tz, temp);
> +               if (ret) {
> +                       mutex_unlock(&multi_tz->sensors_lock);
> +                       return ret;
> +               }
> +
> +               accumulated_temp +=3D *temp * sensor->coeff;
> +               accumulated_coeff +=3D sensor->coeff;
> +       }
> +
> +       mutex_unlock(&multi_tz->sensors_lock);
> +
> +       *temp =3D accumulated_temp / accumulated_coeff;
> +       return ret;
> +}
> +
> +struct thermal_zone_device_ops multi_sensor_ops =3D {
> +       .get_temp =3D multi_sensor_get_temp,
> +};
> +
> +int thermal_multi_sensor_validate_coeff(int *coeff, int count, int offse=
t)
> +{
> +       int max_accumulated_temp =3D 0;
> +       int i;
> +
> +       for (i =3D 0; i < count; i++) {
> +               max_accumulated_temp +=3D TJ_MAX * coeff[i];
> +               if (max_accumulated_temp < 0)
> +                       return -EOVERFLOW;
> +       }
> +
> +       max_accumulated_temp +=3D offset;
> +       return max_accumulated_temp < 0 ? -EOVERFLOW : 0;
> +}
> +
> +static struct thermal_zone_device *multi_sensor_tz_alloc(const char *nam=
e)
> +{
> +       struct thermal_zone_device *tz;
> +       struct thermal_zone_params tzp =3D {};
> +       struct multi_sensor_thermal_zone *multi_tz;
> +
> +       tz =3D thermal_zone_get_zone_by_name(name);
> +       if (!IS_ERR(tz)) {
> +               mutex_unlock(&multi_tz_mutex);
> +               return tz;
> +       }
> +
> +       multi_tz =3D kzalloc(sizeof(*multi_tz), GFP_KERNEL);
> +       if (!multi_tz)
> +               return ERR_PTR(-ENOMEM);
> +       mutex_init(&multi_tz->sensors_lock);
> +       INIT_LIST_HEAD(&multi_tz->sensors);
> +
> +       tzp.no_hwmon =3D true;
> +       tzp.slope =3D 1;
> +       tzp.offset =3D 0;
> +
> +       tz =3D thermal_tripless_zone_device_register(name, multi_tz,
> +                                                  &multi_sensor_ops, &tz=
p);
> +       if (IS_ERR(tz)) {
> +               kfree(multi_tz);
> +       } else {
> +               multi_tz->tz =3D tz;
> +               list_add(&multi_tz->node, &multi_tz_list);
> +       }
> +
> +       return tz;
> +}
> +
> +int thermal_multi_sensor_register(const char *name,
> +       struct thermal_zone_device *sensor_tz, int coeff)
> +{
> +       struct thermal_zone_device *tz;
> +       struct multi_sensor_thermal_zone *multi_tz;
> +       struct sensor_interface *sensor;
> +
> +       mutex_lock(&multi_tz_mutex);
> +
> +       tz =3D multi_sensor_tz_alloc(name);
> +       if (IS_ERR(tz)) {
> +               mutex_unlock(&multi_tz_mutex);
> +               return PTR_ERR(tz);
> +       }
> +       multi_tz =3D  tz->devdata;
> +
> +       sensor =3D kzalloc(sizeof(*sensor), GFP_KERNEL);
> +       if (!sensor) {
> +               mutex_unlock(&multi_tz_mutex);
> +               return -ENOMEM;
> +       }
> +
> +       sensor->tz =3D sensor_tz;
> +       sensor->coeff =3D coeff;
> +       mutex_lock(&multi_tz->sensors_lock);
> +       list_add(&sensor->node, &multi_tz->sensors);
> +       mutex_unlock(&multi_tz->sensors_lock);
> +
> +       thermal_zone_device_enable(tz);
> +
> +       mutex_unlock(&multi_tz_mutex);
> +
> +       return 0;
> +}
> +
> +void thermal_multi_sensor_unregister(struct thermal_zone_device *sensor_=
tz)
> +{
> +       struct multi_sensor_thermal_zone *multi_tz;
> +       struct sensor_interface *sensor, *tmp;
> +
> +       mutex_lock(&multi_tz_mutex);
> +       list_for_each_entry(multi_tz, &multi_tz_list, node) {
> +               mutex_lock(&multi_tz->sensors_lock);
> +               list_for_each_entry_safe(sensor, tmp, &multi_tz->sensors,=
 node) {
> +                       if (sensor->tz =3D=3D sensor_tz) {
> +                               list_del(&sensor->node);
> +                               kfree(sensor);
> +                               break;
> +                       }
> +               }
> +
> +               if (list_empty(&multi_tz->sensors)) {
> +                       thermal_zone_device_unregister(multi_tz->tz);
> +                       mutex_unlock(&multi_tz->sensors_lock);
> +                       kfree(multi_tz);
> +               } else {
> +                       mutex_unlock(&multi_tz->sensors_lock);
> +               }
> +       }
> +       mutex_unlock(&multi_tz_mutex);
> +}
> --
> 2.41.0
>

By the way, may I know why min/max aggregation is dropped in this
version? I thought that checking max temperature is the most direct
approach to protect the hardware and the users from high temperature.

Best regards,
Pin-yen

