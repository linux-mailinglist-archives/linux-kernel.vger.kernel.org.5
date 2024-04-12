Return-Path: <linux-kernel+bounces-143320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6068A3731
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE04DB226CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223672E62F;
	Fri, 12 Apr 2024 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LuOPdjst"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75B1433D5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954577; cv=none; b=T4yXuP0ZH+A/UeECuOExgXb+OJAeh1GPrcp83KxwBMpVVk6BHIPLI+WSClUjv0MdNZJ1ZlZcHlP/NMYQodFHb2MPaEpN/wcQEAxOMJxTt7kWGm2nd8Ig1ewyleST2jktDE6xCFWppLSabC0SL2+dMflS17Bvy2Md85vZWxw1paM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954577; c=relaxed/simple;
	bh=J85Au1+EGwbBZq1rpAsUbtk/iRvaIU4GOBpDvc7u2QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eq8oS5AcXo13wRdnLjJAFDolwii+SbAjbkJH9o9cXj9fs6VbxbB1qDbhcSjCMiz+7/NNsX6YRS36li+Ln7B6SXGvSUrojFqnkCa01zVkslZUdUiDVE9K+2knibfpAC9QkMrtOFFudAk0laSvYkpLyBVZDL7K+lO7x63oYvmxz9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LuOPdjst; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e424bd30fbso10709425ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712954575; x=1713559375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OK8rKoUkQPD7clWTz5JNPeyB8DiO1KapbhHZGBnPwVA=;
        b=LuOPdjstagMNDYFqkNTjobPkmlqJPRdrM17LkLae8qWwwO/d0BjLlHEDXHBrMYHmKm
         LpzuFp92CbvcNwdCq/gy0oZd9GiEk46hqSfwEjI+7/wsg4yHzGbvzdO6gHt5tjwYj9Zq
         yCldMITOBgiktfizMKtjYIaolWKecSMrDWxsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712954575; x=1713559375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OK8rKoUkQPD7clWTz5JNPeyB8DiO1KapbhHZGBnPwVA=;
        b=oS7b9GeckkQtWle8oDWVH+Xs2OtR/8YDry/TJhWtqI4Wheras0BJTeoP+smXXxNXJg
         3nFzbMrlN7ihPCpbRN5Glt3FqtNUpZTI2xl1KUQFUY3UEmlsdbr6x1k+rgRAnEdErgBw
         4YdSs3rQY4xAu8KFE2WZAj/0gyLVPwfdfOziqd4OzkEuP8W4r1uZGsBgwHDYZtX/zjJh
         9QI/1hoOPhH6imC9eXqVvOA4bE31kKQYFm4FHp4TrdRvEnMI2GIj180XfmkedMQ6pfdk
         TI+sTsTwfSpdVkDHTgzq6lU/ympBzGlItW0gy54Rp2qNnLCT3i/IbttNgbcrxjMYs0QE
         B+aA==
X-Forwarded-Encrypted: i=1; AJvYcCXabYJpvZqcDkdkPQC5J+JOT3JA7Ndf9Y9t1gZU/52Sa7ytRwFWFv5nHQcWyc0hJJOkfmlwIdxe6XLE+wP7EtR2W26igCM9lR6EadOv
X-Gm-Message-State: AOJu0Yxoy0mPEUvEzzZ03cJaoA5lSrnwyryGLWTAkDWC/SuNAA+xCl3O
	9aA4NW1mS50qQD76JX6Cx6pVKliEfyXURhyQDx70U+o91MLH4nbIhiKWsp2YNcfrvCRX92N33dJ
	l9WGHTnO9yAKX9X7noc7TMcfUMJ6bzTd+8P5V
X-Google-Smtp-Source: AGHT+IGvWLQ9M9g+BbhWyW6/OkthS05jBy0U4kOMYl32CiNaIdA/Bgb3c8R2RlbJBAd+bdDx4ApIgS6LyjEEmNgicYY=
X-Received: by 2002:a17:903:24d:b0:1e4:9ad7:2211 with SMTP id
 j13-20020a170903024d00b001e49ad72211mr4358093plh.45.1712954575082; Fri, 12
 Apr 2024 13:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119110842.772606-1-abailon@baylibre.com> <20240119110842.772606-4-abailon@baylibre.com>
In-Reply-To: <20240119110842.772606-4-abailon@baylibre.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Fri, 12 Apr 2024 16:42:44 -0400
Message-ID: <CAEXTbpd+HRj_ar3UnCSkCMbELSLraAgET9G3a3_7u9fPkdKNVg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] thermal: Add support of multi sensors to thermal_of
To: Alexandre Bailon <abailon@baylibre.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Fri, Apr 12, 2024 at 4:23=E2=80=AFPM Alexandre Bailon <abailon@baylibre.=
com> wrote:
>
> This updates thermal_of to support more than one sensor.
> If during the registration we find another thermal zone referencing
> this sensors and some other, then we create the multi sensor thermal
> zone (if it doesn't exist) and register the sensor to it.
>
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  drivers/thermal/thermal_of.c | 139 +++++++++++++++++++++++++++++++++++
>  1 file changed, 139 insertions(+)
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 1e0655b63259..3f36d8a3d8e8 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -441,12 +441,146 @@ static void thermal_of_zone_unregister(struct ther=
mal_zone_device *tz)
>         struct thermal_trip *trips =3D tz->trips;
>         struct thermal_zone_device_ops *ops =3D tz->ops;
>
> +       thermal_multi_sensor_unregister(tz);
>         thermal_zone_device_disable(tz);
>         thermal_zone_device_unregister(tz);
>         kfree(trips);
>         kfree(ops);
>  }
>
> +int thermal_of_get_sensor_id(struct device_node *tz_np,
> +                           struct device_node *sensor_np,
> +                           int phandle_index, u32 *id)
> +{
> +       struct of_phandle_args sensor_specs;
> +       int ret;
> +
> +       ret =3D of_parse_phandle_with_args(tz_np,
> +                                        "thermal-sensors",
> +                                        "#thermal-sensor-cells",
> +                                        phandle_index,
> +                                        &sensor_specs);
> +       if (ret)
> +               return ret;
> +
> +       if (sensor_specs.np !=3D sensor_np) {
> +               of_node_put(sensor_specs.np);
> +               return -ENODEV;
> +       }
> +
> +       if (sensor_specs.args_count > 1)
> +               pr_warn("%pOFn: too many cells in sensor specifier %d\n",
> +                       sensor_specs.np, sensor_specs.args_count);
> +
> +       *id =3D sensor_specs.args_count ? sensor_specs.args[0] : 0;
> +       of_node_put(sensor_specs.np);
> +
> +       return 0;
> +}
> +
> +static int thermal_of_has_sensor_id(struct device_node *tz_np,
> +                                   struct device_node *sensor_np,
> +                                   u32 sensor_id)
> +{
> +       int count;
> +       int i;
> +
> +       count =3D of_count_phandle_with_args(tz_np,
> +                                          "thermal-sensors",
> +                                          "#thermal-sensor-cells");
> +       if (count <=3D 0)
> +               return -ENODEV;
> +
> +       for (i =3D 0; i < count; i++) {
> +               int ret;
> +               u32 id;
> +
> +               ret =3D thermal_of_get_sensor_id(tz_np, sensor_np, i, &id=
);
> +               if (ret)
> +                       return ret;

We should just `continue` here or handle -ENODEV differently. The
current implementation doesn't support a thermal zone references
sensors from different nodes.

> +
> +               if (id =3D=3D sensor_id)
> +                       return i;
> +
> +       }
> +
> +       return -ENODEV;
> +}
> +
> +static int thermal_of_register_mutli_sensor(struct device_node *sensor, =
int id,
> +                                           struct thermal_zone_device *t=
z,
> +                                           struct device_node *tz_np)
> +{
> +       struct device_node *child;
> +       u32 *coeff;
> +       int ret;
> +       int i;
> +
> +       /*
> +        * Go through all the thermal zone and check if the sensor is
> +        * referenced. If so, find or create a multi sensor thermal zone
> +        * and register the sensor to it.
> +        */
> +       for_each_available_child_of_node(of_get_parent(tz_np), child) {
> +               int count;
> +               int index;
> +               int offset;
> +
> +               /* Skip the tz that is currently registering */
> +               if (child =3D=3D tz_np)
> +                       continue;

of_thermal_zone_find() simply returns the first thermal zone
containing the sensor, so there's no guarantee that tz here is the
currently registering thermal zone. Maybe we should make
of_thermal_zone_find() only return thermal zones with only one sensor
attached?

> +
> +               /* Test if the sensor is referenced by a tz*/
> +               index =3D thermal_of_has_sensor_id(child, sensor, id);
> +               if (index < 0)
> +                       continue;
> +
> +               /*
> +                * Get the coefficients and offset and assign them to the
> +                * multi sensor thermal zone.
> +                */
> +               count =3D of_count_phandle_with_args(child,
> +                                                  "thermal-sensors",
> +                                                  "#thermal-sensor-cells=
");
> +               coeff =3D kmalloc_array(count, sizeof(*coeff), GFP_KERNEL=
);
> +               if (!coeff)
> +                       goto err;
> +
> +               for (i =3D 0; i < count; i++) {
> +                       ret =3D of_property_read_u32_index(child,
> +                                                        "coefficients",
> +                                                        i, coeff + i);
> +                       if (ret)
> +                               coeff[i] =3D 1;
> +               }
> +
> +               ret =3D of_property_read_u32_index(child, "coefficients",
> +                                                count, &offset);
> +               if (ret)
> +                       offset =3D 0;
> +
> +               /* Make sure the coeff and offset won't cause an overflow=
 */
> +               ret =3D thermal_multi_sensor_validate_coeff(coeff, count,=
 offset);
> +               if (ret)
> +                       goto err_free_coeff;
> +
> +               ret =3D thermal_multi_sensor_register(child->name, tz,
> +                                                        coeff[index]);

The indentation of this line is wrong.

> +               if (ret)
> +                       goto err_free_coeff;
> +               kfree(coeff);
> +       }
> +
> +       return 0;
> +
> +err_free_coeff:
> +       kfree(coeff);
> +err:
> +       thermal_multi_sensor_unregister(tz);
> +
> +       return ret;
> +}
> +
>  /**
>   * thermal_of_zone_register - Register a thermal zone with device node
>   * sensor
> @@ -528,6 +662,11 @@ static struct thermal_zone_device *thermal_of_zone_r=
egister(struct device_node *
>                 return ERR_PTR(ret);
>         }
>
> +       /* Register the sensor to all other thermal zone referencing it *=
/
> +       ret =3D thermal_of_register_mutli_sensor(sensor, id, tz, np);
> +       if (ret)
> +               pr_warn("Failed to register a sensor to a multi sensor tz=
\n");
> +
>         return tz;
>
>  out_kfree_trips:
> --
> 2.41.0
>

Best regards,
Pin-yen

