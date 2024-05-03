Return-Path: <linux-kernel+bounces-167499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BACC88BAA75
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9BF1F22E26
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A843D14F9E4;
	Fri,  3 May 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="IngonnQe"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D442414A601
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730687; cv=none; b=CZmpmZMA7LdX3QhjWek2FqzvhwRAvUNivBgJHLg60P7wRvSMaV0nLMs9qu8f37BXzUWBehEEZgoUZ+XEQWKB07b90skAYe01BwwF+pgVImX3qFVUBZv2ht3qqjjX5gvsu2V5WqW4vn1aZXTWrr1sp0CY4kB5J9nzzs0PNtLjK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730687; c=relaxed/simple;
	bh=0+YSlkTwDhNov3WDl9Km2TVb4OVZ78zyZDK3LhEbKHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZgDOKNEZG7QFxtTcbo2CrPcJMQM3OXWR4BHfs+UOD2Tk4Th5n++eq5EdfdI6ByJ9U3iTtxCon9tFn8qhAO6a4ZgrVBzvsdYHsluBoVsnJMX65H9ceSPfvq3IWCfd5wEQrVFdIUTMc58s0Gdo2s9KH8dj0/lXmqqhSXPXI+oGk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=IngonnQe; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8b519e438so7038537a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 03:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1714730684; x=1715335484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QlRc6XuAJnnqxkQVx8zMCJjFKjputAg62Lw6STArfI=;
        b=IngonnQeHE7E2Vf31V3CTlpv0OlkZHUoFHqiDxRQcOSaA07GSUBxfU3zkzbdGfJDcz
         jql1YYG1hTQjYIRNwQ1GIcj98rK+ehv4H/APl91QVKf0CH0enIx/JayiMpQndqmaHUKJ
         rNSxngOiCPYHWOjQIJgreHla2gMOCKsK2Cb5x4fyDyvDK9vZnAFK6L53+zcXmJavhVxM
         wC1hODoRd6tPV3gHVLvndfqMY1+Xjvap2eijViykgR0pxnQIJGXGM79akquS9L7t+00V
         28B1HGlR3v6w/PY8dmMh2qDAmuvtPgFeyQAP/M85l8OddBL1f3FjF0a5ug6UQLYkHiZK
         elDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714730684; x=1715335484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QlRc6XuAJnnqxkQVx8zMCJjFKjputAg62Lw6STArfI=;
        b=nrPfK9pBNGxwzCPwZWvXqPGKvJizq98vZjOg37zmzpz8mfII7iUf47IXCEB1gIJAFp
         Rb4gN5fBRGd13NIHVnq98O+vcsRDCxBpbuSfuryOMEfWnVXZsRSCjy+utkRKX0YfMIq8
         rgU6bWPiAoK51k0bBIY8J4xvL+8Nde3+f5ka+ZFR1f+omE7SZgmUE9PdfR+rTu+GQL5H
         xoVxWRmNsVrTfQwxfcQsDJtHzZaximFoRG+tdHsKfxhTEPofbRzHt/wlZThI+LPcgXQQ
         6tvkheVVAEovN0t7fB+NdShuvtztcvR3LNa29TKF64w3pYDJCUMgztn1BQtsUVPPTECV
         l8pg==
X-Forwarded-Encrypted: i=1; AJvYcCXha0ZTEu/n4zYRWkxeEV6G8CW1xmre0MLav4AzE/xLWjbWxNxRe/CXm1xYfxOrZV2FZ3s+sVzNltJfngf0NQ9IJjvUxOlPU9mVNKdw
X-Gm-Message-State: AOJu0Yx+YDBvCGig03QkawRwvc7XXBx+vSQgI5WquC2gRGz8fdPAygcR
	07kye4lOJ5wwjuJUoRHCziSmZrW0U5zBtwYHpLfHfZMVFer2aql1WbNDtqwEp3VRY9AYR+zS541
	EQCaJEzsiIibP7xZ8/uOyDbXHjoBdYiRJLJ6U5A==
X-Google-Smtp-Source: AGHT+IGe93ENTtNXnC3u63lLWZmhfrzE7WbAM/DIBuCLadqT8x6tjos7UYs6Xfv9EVaJn43Md3gXAzLgh7SFOxx7G8o=
X-Received: by 2002:a17:90a:ea91:b0:2af:ff3:e14a with SMTP id
 h17-20020a17090aea9100b002af0ff3e14amr2099186pjz.16.1714730683801; Fri, 03
 May 2024 03:04:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502183604.1216576-1-naresh.solanki@9elements.com> <78af0dfa-7021-4d20-8ea4-69e60ed1263e@roeck-us.net>
In-Reply-To: <78af0dfa-7021-4d20-8ea4-69e60ed1263e@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Fri, 3 May 2024 15:34:32 +0530
Message-ID: <CABqG17i4Rnw2PPWCb-aAosu3YHmXgO_+ONU-UB8TDaArqXFWLg@mail.gmail.com>
Subject: Re: [PATCH v3] hwmon (max6639): Use regmap
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,


On Fri, 3 May 2024 at 01:31, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, May 03, 2024 at 12:06:02AM +0530, Naresh Solanki wrote:
> > Add regmap support & remove local caching.
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>
> Almost there. Couple of minor comments.
>
> Thanks,
> Guenter
>
> > ---
> > Changes in V3:
> > - Remove mutex lock
> > - Remove caching of variable pwm in max6639_data
> > - Use regmap_write_bits in suspend & resume
> > - Remove error check for data in attrube show/store functions.
> > - Remove goto
> >
> > Changes in V2:
> > - Remove local caching in max6639_data struct.
> > - Use define MAX6639_NDEV wherever possible
> > ---
> >  drivers/hwmon/Kconfig   |   1 +
> >  drivers/hwmon/max6639.c | 334 +++++++++++++++++-----------------------
> >  2 files changed, 145 insertions(+), 190 deletions(-)
> >
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index bafc0058c728..e14ae18a973b 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1233,6 +1233,7 @@ config SENSORS_MAX6621
> >  config SENSORS_MAX6639
> >       tristate "Maxim MAX6639 sensor chip"
> >       depends on I2C
> > +     select REGMAP_I2C
> >       help
> >         If you say yes here you get support for the MAX6639
> >         sensor chips.
> > diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> > index 5dd0349e8bd0..f914f1500c96 100644
> > --- a/drivers/hwmon/max6639.c
> > +++ b/drivers/hwmon/max6639.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/err.h>
> >  #include <linux/mutex.h>
> >  #include <linux/platform_data/max6639.h>
> > +#include <linux/regmap.h>
> >
> >  /* Addresses to scan */
> >  static const unsigned short normal_i2c[] =3D { 0x2c, 0x2e, 0x2f, I2C_C=
LIENT_END };
> > @@ -57,6 +58,8 @@ static const unsigned short normal_i2c[] =3D { 0x2c, =
0x2e, 0x2f, I2C_CLIENT_END };
> >
> >  #define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED 0x40
> >
> > +#define MAX6639_NDEV                         2
> > +
>
> FWIW, the define is only used once. I'd suggest to drop it because it
> isn't really that valuable. I'll accept it if you really want it, but
> then please rename it to something like MAX6639_NUM_CHANNELS do
> better reflect its meaning.
I want to retain it & will update it to MAX6639_NUM_CHANNELS
>
> >  static const int rpm_ranges[] =3D { 2000, 4000, 8000, 16000 };
> >
> >  #define FAN_FROM_REG(val, rpm_range) ((val) =3D=3D 0 || (val) =3D=3D 2=
55 ? \
> > @@ -67,22 +70,7 @@ static const int rpm_ranges[] =3D { 2000, 4000, 8000=
, 16000 };
> >   * Client data (each client gets its own)
> >   */
> >  struct max6639_data {
> > -     struct i2c_client *client;
> > -     struct mutex update_lock;
> > -     bool valid;             /* true if following fields are valid */
> > -     unsigned long last_updated;     /* In jiffies */
> > -
> > -     /* Register values sampled regularly */
> > -     u16 temp[2];            /* Temperature, in 1/8 C, 0..255 C */
> > -     bool temp_fault[2];     /* Detected temperature diode failure */
> > -     u8 fan[2];              /* Register value: TACH count for fans >=
=3D30 */
> > -     u8 status;              /* Detected channel alarms and fan failur=
es */
> > -
> > -     /* Register values only written to */
> > -     u8 pwm[2];              /* Register value: Duty cycle 0..120 */
> > -     u8 temp_therm[2];       /* THERM Temperature, 0..255 C (->_max) *=
/
> > -     u8 temp_alert[2];       /* ALERT Temperature, 0..255 C (->_crit) =
*/
> > -     u8 temp_ot[2];          /* OT Temperature, 0..255 C (->_emergency=
) */
> > +     struct regmap *regmap;
> >
> >       /* Register values initialized only once */
> >       u8 ppr;                 /* Pulses per rotation 0..3 for 1..4 ppr =
*/
> > @@ -92,90 +80,43 @@ struct max6639_data {
> >       struct regulator *reg;
> >  };
> >
> > -static struct max6639_data *max6639_update_device(struct device *dev)
> > -{
> > -     struct max6639_data *data =3D dev_get_drvdata(dev);
> > -     struct i2c_client *client =3D data->client;
> > -     struct max6639_data *ret =3D data;
> > -     int i;
> > -     int status_reg;
> > -
> > -     mutex_lock(&data->update_lock);
> > -
> > -     if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->va=
lid) {
> > -             int res;
> > -
> > -             dev_dbg(&client->dev, "Starting max6639 update\n");
> > -
> > -             status_reg =3D i2c_smbus_read_byte_data(client,
> > -                                                   MAX6639_REG_STATUS)=
;
> > -             if (status_reg < 0) {
> > -                     ret =3D ERR_PTR(status_reg);
> > -                     goto abort;
> > -             }
> > -
> > -             data->status =3D status_reg;
> > -
> > -             for (i =3D 0; i < 2; i++) {
> > -                     res =3D i2c_smbus_read_byte_data(client,
> > -                                     MAX6639_REG_FAN_CNT(i));
> > -                     if (res < 0) {
> > -                             ret =3D ERR_PTR(res);
> > -                             goto abort;
> > -                     }
> > -                     data->fan[i] =3D res;
> > -
> > -                     res =3D i2c_smbus_read_byte_data(client,
> > -                                     MAX6639_REG_TEMP_EXT(i));
> > -                     if (res < 0) {
> > -                             ret =3D ERR_PTR(res);
> > -                             goto abort;
> > -                     }
> > -                     data->temp[i] =3D res >> 5;
> > -                     data->temp_fault[i] =3D res & 0x01;
> > -
> > -                     res =3D i2c_smbus_read_byte_data(client,
> > -                                     MAX6639_REG_TEMP(i));
> > -                     if (res < 0) {
> > -                             ret =3D ERR_PTR(res);
> > -                             goto abort;
> > -                     }
> > -                     data->temp[i] |=3D res << 3;
> > -             }
> > -
> > -             data->last_updated =3D jiffies;
> > -             data->valid =3D true;
> > -     }
> > -abort:
> > -     mutex_unlock(&data->update_lock);
> > -
> > -     return ret;
> > -}
> > -
> >  static ssize_t temp_input_show(struct device *dev,
> >                              struct device_attribute *dev_attr, char *b=
uf)
> >  {
> >       long temp;
> > -     struct max6639_data *data =3D max6639_update_device(dev);
> > +     struct max6639_data *data =3D dev_get_drvdata(dev);
> >       struct sensor_device_attribute *attr =3D to_sensor_dev_attr(dev_a=
ttr);
> > +     unsigned int val;
> > +     int res;
> >
> > -     if (IS_ERR(data))
> > -             return PTR_ERR(data);
> > +     res =3D regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(attr->inde=
x), &val);
> > +     if (res < 0)
> > +             return res;
> > +
> > +     temp =3D val >> 5;
> > +     res =3D regmap_read(data->regmap, MAX6639_REG_TEMP(attr->index), =
&val);
> > +     if (res < 0)
> > +             return res;
> > +
>
> It might be worthwhile adding a comment explaining that MAX6639_REG_TEMP
> won't change for at least 250ms after reading MAX6639_REG_TEMP_EXT,
> making a lock unnecessary.
Sure.
>
> > +     temp |=3D val << 3;
> > +     temp *=3D 125;
> >
> > -     temp =3D data->temp[attr->index] * 125;
> >       return sprintf(buf, "%ld\n", temp);
> >  }
> >
> >  static ssize_t temp_fault_show(struct device *dev,
> >                              struct device_attribute *dev_attr, char *b=
uf)
> >  {
> > -     struct max6639_data *data =3D max6639_update_device(dev);
> > +     struct max6639_data *data =3D dev_get_drvdata(dev);
> >       struct sensor_device_attribute *attr =3D to_sensor_dev_attr(dev_a=
ttr);
> > +     unsigned int val;
> > +     int res;
> >
> > -     if (IS_ERR(data))
> > -             return PTR_ERR(data);
> > +     res =3D regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(attr->inde=
x), &val);
> > +     if (res < 0)
> > +             return res;
> >
> > -     return sprintf(buf, "%d\n", data->temp_fault[attr->index]);
> > +     return sprintf(buf, "%d\n", val & 1);
> >  }
> >
> >  static ssize_t temp_max_show(struct device *dev,
> > @@ -183,8 +124,14 @@ static ssize_t temp_max_show(struct device *dev,
> >  {
> >       struct sensor_device_attribute *attr =3D to_sensor_dev_attr(dev_a=
ttr);
> >       struct max6639_data *data =3D dev_get_drvdata(dev);
> > +     unsigned int val;
> > +     int res;
> >
> > -     return sprintf(buf, "%d\n", (data->temp_therm[attr->index] * 1000=
));
> > +     res =3D regmap_read(data->regmap, MAX6639_REG_THERM_LIMIT(attr->i=
ndex), &val);
> > +     if (res < 0)
> > +             return res;
> > +
> > +     return sprintf(buf, "%d\n", (val * 1000));
> >  }
> >
> >  static ssize_t temp_max_store(struct device *dev,
> > @@ -193,7 +140,6 @@ static ssize_t temp_max_store(struct device *dev,
> >  {
> >       struct sensor_device_attribute *attr =3D to_sensor_dev_attr(dev_a=
ttr);
> >       struct max6639_data *data =3D dev_get_drvdata(dev);
> > -     struct i2c_client *client =3D data->client;
> >       unsigned long val;
> >       int res;
> >
> > @@ -201,12 +147,8 @@ static ssize_t temp_max_store(struct device *dev,
> >       if (res)
> >               return res;
> >
> > -     mutex_lock(&data->update_lock);
> > -     data->temp_therm[attr->index] =3D TEMP_LIMIT_TO_REG(val);
> > -     i2c_smbus_write_byte_data(client,
> > -                               MAX6639_REG_THERM_LIMIT(attr->index),
> > -                               data->temp_therm[attr->index]);
> > -     mutex_unlock(&data->update_lock);
> > +     regmap_write(data->regmap, MAX6639_REG_THERM_LIMIT(attr->index),
> > +                  TEMP_LIMIT_TO_REG(val));
> >       return count;
> >  }
> >
> > @@ -215,8 +157,14 @@ static ssize_t temp_crit_show(struct device *dev,
> >  {
> >       struct sensor_device_attribute *attr =3D to_sensor_dev_attr(dev_a=
ttr);
> >       struct max6639_data *data =3D dev_get_drvdata(dev);
> > +     unsigned int val;
> > +     int res;
> > +
> > +     res =3D regmap_read(data->regmap, MAX6639_REG_ALERT_LIMIT(attr->i=
ndex), &val);
> > +     if (res < 0)
> > +             return res;
> >
> > -     return sprintf(buf, "%d\n", (data->temp_alert[attr->index] * 1000=
));
> > +     return sprintf(buf, "%d\n", (val * 1000));
> >  }
> >
> >  static ssize_t temp_crit_store(struct device *dev,
> > @@ -225,7 +173,6 @@ static ssize_t temp_crit_store(struct device *dev,
> >  {
> >       struct sensor_device_attribute *attr =3D to_sensor_dev_attr(dev_a=
ttr);
> >       struct max6639_data *data =3D dev_get_drvdata(dev);
> > -     struct i2c_client *client =3D data->client;
> >       unsigned long val;
> >       int res;
> >
> > @@ -233,12 +180,8 @@ static ssize_t temp_crit_store(struct device *dev,
> >       if (res)
> >               return res;
> >
> > -     mutex_lock(&data->update_lock);
> > -     data->temp_alert[attr->index] =3D TEMP_LIMIT_TO_REG(val);
> > -     i2c_smbus_write_byte_data(client,
> > -                               MAX6639_REG_ALERT_LIMIT(attr->index),
> > -                               data->temp_alert[attr->index]);
> > -     mutex_unlock(&data->update_lock);
> > +     regmap_write(data->regmap, MAX6639_REG_ALERT_LIMIT(attr->index),
> > +                  TEMP_LIMIT_TO_REG(val));
> >       return count;
> >  }
> >
> > @@ -248,8 +191,14 @@ static ssize_t temp_emergency_show(struct device *=
dev,
> >  {
> >       struct sensor_device_attribute *attr =3D to_sensor_dev_attr(dev_a=
ttr);
> >       struct max6639_data *data =3D dev_get_drvdata(dev);
> > +     unsigned int val;
> > +     int res;
> > +
> > +     res =3D regmap_read(data->regmap, MAX6639_REG_OT_LIMIT(attr->inde=
x), &val);
> > +     if (res < 0)
> > +             return res;
> >
> > -     return sprintf(buf, "%d\n", (data->temp_ot[attr->index] * 1000));
> > +     return sprintf(buf, "%d\n", (val * 1000));
> >  }
> >
> >  static ssize_t temp_emergency_store(struct device *dev,
> > @@ -258,7 +207,6 @@ static ssize_t temp_emergency_store(struct device *=
dev,
> >  {
> >       struct sensor_device_attribute *attr =3D to_sensor_dev_attr(dev_a=
ttr);
> >       struct max6639_data *data =3D dev_get_drvdata(dev);
> > -     struct i2c_client *client =3D data->client;
> >       unsigned long val;
> >       int res;
> >
> > @@ -266,12 +214,8 @@ static ssize_t temp_emergency_store(struct device =
*dev,
> >       if (res)
> >               return res;
> >
> > -     mutex_lock(&data->update_lock);
> > -     data->temp_ot[attr->index] =3D TEMP_LIMIT_TO_REG(val);
> > -     i2c_smbus_write_byte_data(client,
> > -                               MAX6639_REG_OT_LIMIT(attr->index),
> > -                               data->temp_ot[attr->index]);
> > -     mutex_unlock(&data->update_lock);
> > +     regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(attr->index), TEM=
P_LIMIT_TO_REG(val));
> > +
> >       return count;
> >  }
> >
> > @@ -280,8 +224,14 @@ static ssize_t pwm_show(struct device *dev, struct=
 device_attribute *dev_attr,
> >  {
> >       struct sensor_device_attribute *attr =3D to_sensor_dev_attr(dev_a=
ttr);
> >       struct max6639_data *data =3D dev_get_drvdata(dev);
> > +     unsigned int val;
> > +     int res;
> > +
> > +     res =3D regmap_read(data->regmap, MAX6639_REG_TARGTDUTY(attr->ind=
ex), &val);
> > +     if (res < 0)
> > +             return res;
> >
> > -     return sprintf(buf, "%d\n", data->pwm[attr->index] * 255 / 120);
> > +     return sprintf(buf, "%d\n", val * 255 / 120);
> >  }
> >
> >  static ssize_t pwm_store(struct device *dev,
> > @@ -290,7 +240,6 @@ static ssize_t pwm_store(struct device *dev,
> >  {
> >       struct sensor_device_attribute *attr =3D to_sensor_dev_attr(dev_a=
ttr);
> >       struct max6639_data *data =3D dev_get_drvdata(dev);
> > -     struct i2c_client *client =3D data->client;
> >       unsigned long val;
> >       int res;
> >
> > @@ -300,38 +249,39 @@ static ssize_t pwm_store(struct device *dev,
> >
> >       val =3D clamp_val(val, 0, 255);
> >
> > -     mutex_lock(&data->update_lock);
> > -     data->pwm[attr->index] =3D (u8)(val * 120 / 255);
> > -     i2c_smbus_write_byte_data(client,
> > -                               MAX6639_REG_TARGTDUTY(attr->index),
> > -                               data->pwm[attr->index]);
> > -     mutex_unlock(&data->update_lock);
> > +     regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(attr->index), va=
l * 120 / 255);
> > +
> >       return count;
> >  }
> >
> >  static ssize_t fan_input_show(struct device *dev,
> >                             struct device_attribute *dev_attr, char *bu=
f)
> >  {
> > -     struct max6639_data *data =3D max6639_update_device(dev);
> > +     struct max6639_data *data =3D dev_get_drvdata(dev);
> >       struct sensor_device_attribute *attr =3D to_sensor_dev_attr(dev_a=
ttr);
> > +     unsigned int val;
> > +     int res;
> >
> > -     if (IS_ERR(data))
> > -             return PTR_ERR(data);
> > +     res =3D regmap_read(data->regmap, MAX6639_REG_FAN_CNT(attr->index=
), &val);
> > +     if (res < 0)
> > +             return res;
> >
> > -     return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
> > -                    data->rpm_range));
> > +     return sprintf(buf, "%d\n", FAN_FROM_REG(val, data->rpm_range));
> >  }
> >
> >  static ssize_t alarm_show(struct device *dev,
> >                         struct device_attribute *dev_attr, char *buf)
> >  {
> > -     struct max6639_data *data =3D max6639_update_device(dev);
> > +     struct max6639_data *data =3D dev_get_drvdata(dev);
> >       struct sensor_device_attribute *attr =3D to_sensor_dev_attr(dev_a=
ttr);
> > +     unsigned int val;
> > +     int res;
> >
> > -     if (IS_ERR(data))
> > -             return PTR_ERR(data);
> > +     res =3D regmap_read(data->regmap, MAX6639_REG_STATUS, &val);
> > +     if (res < 0)
> > +             return res;
> >
> > -     return sprintf(buf, "%d\n", !!(data->status & (1 << attr->index))=
);
> > +     return sprintf(buf, "%d\n", !!(val & (1 << attr->index)));
> >  }
> >
> >  static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
> > @@ -401,6 +351,11 @@ static int rpm_range_to_reg(int range)
> >       return 1; /* default: 4000 RPM */
> >  }
> >
> > +static int max6639_set_ppr(struct max6639_data *data, u8 channel, u8 p=
pr)
> > +{
> > +     return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), p=
pr << 6);
> > +}
> > +
> >  static int max6639_init_client(struct i2c_client *client,
> >                              struct max6639_data *data)
> >  {
> > @@ -408,94 +363,76 @@ static int max6639_init_client(struct i2c_client =
*client,
> >               dev_get_platdata(&client->dev);
> >       int i;
> >       int rpm_range =3D 1; /* default: 4000 RPM */
> > -     int err;
> > +     int err, ppr;
> >
> >       /* Reset chip to default values, see below for GCONFIG setup */
> > -     err =3D i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
> > -                               MAX6639_GCONFIG_POR);
> > +     err =3D regmap_write(data->regmap, MAX6639_REG_GCONFIG, MAX6639_G=
CONFIG_POR);
> >       if (err)
> > -             goto exit;
> > +             return err;
> >
> >       /* Fans pulse per revolution is 2 by default */
> >       if (max6639_info && max6639_info->ppr > 0 &&
> >                       max6639_info->ppr < 5)
> > -             data->ppr =3D max6639_info->ppr;
> > +             ppr =3D max6639_info->ppr;
> >       else
> > -             data->ppr =3D 2;
> > -     data->ppr -=3D 1;
> > +             ppr =3D 2;
> > +     ppr -=3D 1;
> >
> >       if (max6639_info)
> >               rpm_range =3D rpm_range_to_reg(max6639_info->rpm_range);
> >       data->rpm_range =3D rpm_range;
> >
> > -     for (i =3D 0; i < 2; i++) {
> > +     for (i =3D 0; i < MAX6639_NDEV; i++) {
> >
> >               /* Set Fan pulse per revolution */
> > -             err =3D i2c_smbus_write_byte_data(client,
> > -                             MAX6639_REG_FAN_PPR(i),
> > -                             data->ppr << 6);
> > +             err =3D max6639_set_ppr(data, i, ppr);
> >               if (err)
> > -                     goto exit;
> > +                     return err;
> >
> >               /* Fans config PWM, RPM */
> > -             err =3D i2c_smbus_write_byte_data(client,
> > -                     MAX6639_REG_FAN_CONFIG1(i),
> > -                     MAX6639_FAN_CONFIG1_PWM | rpm_range);
> > +             err =3D regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG=
1(i),
> > +                                MAX6639_FAN_CONFIG1_PWM | rpm_range);
> >               if (err)
> > -                     goto exit;
> > +                     return err;
> >
> >               /* Fans PWM polarity high by default */
> >               if (max6639_info && max6639_info->pwm_polarity =3D=3D 0)
> > -                     err =3D i2c_smbus_write_byte_data(client,
> > -                             MAX6639_REG_FAN_CONFIG2a(i), 0x00);
> > +                     err =3D regmap_write(data->regmap, MAX6639_REG_FA=
N_CONFIG2a(i), 0x00);
> >               else
> > -                     err =3D i2c_smbus_write_byte_data(client,
> > -                             MAX6639_REG_FAN_CONFIG2a(i), 0x02);
> > +                     err =3D regmap_write(data->regmap, MAX6639_REG_FA=
N_CONFIG2a(i), 0x02);
> >               if (err)
> > -                     goto exit;
> > +                     return err;
> >
> >               /*
> >                * /THERM full speed enable,
> >                * PWM frequency 25kHz, see also GCONFIG below
> >                */
> > -             err =3D i2c_smbus_write_byte_data(client,
> > -                     MAX6639_REG_FAN_CONFIG3(i),
> > -                     MAX6639_FAN_CONFIG3_THERM_FULL_SPEED | 0x03);
> > +             err =3D regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG=
3(i),
> > +                                MAX6639_FAN_CONFIG3_THERM_FULL_SPEED |=
 0x03);
> >               if (err)
> > -                     goto exit;
> > +                     return err;
> >
> >               /* Max. temp. 80C/90C/100C */
> > -             data->temp_therm[i] =3D 80;
> > -             data->temp_alert[i] =3D 90;
> > -             data->temp_ot[i] =3D 100;
> > -             err =3D i2c_smbus_write_byte_data(client,
> > -                             MAX6639_REG_THERM_LIMIT(i),
> > -                             data->temp_therm[i]);
> > +             err =3D regmap_write(data->regmap, MAX6639_REG_THERM_LIMI=
T(i), 80);
> >               if (err)
> > -                     goto exit;
> > -             err =3D i2c_smbus_write_byte_data(client,
> > -                             MAX6639_REG_ALERT_LIMIT(i),
> > -                             data->temp_alert[i]);
> > +                     return err;
> > +             err =3D regmap_write(data->regmap, MAX6639_REG_ALERT_LIMI=
T(i), 90);
> >               if (err)
> > -                     goto exit;
> > -             err =3D i2c_smbus_write_byte_data(client,
> > -                             MAX6639_REG_OT_LIMIT(i), data->temp_ot[i]=
);
> > +                     return err;
> > +             err =3D regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(i=
), 100);
> >               if (err)
> > -                     goto exit;
> > +                     return err;
> >
> >               /* PWM 120/120 (i.e. 100%) */
> > -             data->pwm[i] =3D 120;
> > -             err =3D i2c_smbus_write_byte_data(client,
> > -                             MAX6639_REG_TARGTDUTY(i), data->pwm[i]);
> > +             err =3D regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(=
i), 120);
> >               if (err)
> > -                     goto exit;
> > +                     return err;
> >       }
> >       /* Start monitoring */
> > -     err =3D i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
> > -             MAX6639_GCONFIG_DISABLE_TIMEOUT | MAX6639_GCONFIG_CH2_LOC=
AL |
> > -             MAX6639_GCONFIG_PWM_FREQ_HI);
> > -exit:
> > -     return err;
> > +     return regmap_write(data->regmap, MAX6639_REG_GCONFIG,
> > +                         MAX6639_GCONFIG_DISABLE_TIMEOUT | MAX6639_GCO=
NFIG_CH2_LOCAL |
> > +                         MAX6639_GCONFIG_PWM_FREQ_HI);
> > +
> >  }
> >
> >  /* Return 0 if detection is successful, -ENODEV otherwise */
> > @@ -524,6 +461,30 @@ static void max6639_regulator_disable(void *data)
> >       regulator_disable(data);
> >  }
> >
> > +static bool max6639_regmap_is_volatile(struct device *dev, unsigned in=
t reg)
> > +{
> > +     switch (reg) {
> > +     case MAX6639_REG_TEMP(0):
> > +     case MAX6639_REG_TEMP_EXT(0):
> > +     case MAX6639_REG_TEMP(1):
> > +     case MAX6639_REG_TEMP_EXT(1):
> > +     case MAX6639_REG_STATUS:
> > +     case MAX6639_REG_FAN_CNT(0):
> > +     case MAX6639_REG_FAN_CNT(1):
>
> MAX6639_REG_TARGTDUTY() is also volatile.
I can do that but my observation is that register reads what is written
to it. So I'm not sure marking it volatile is worth it unless I missed
something.
>
> > +             return true;
> > +     default:
> > +             return false;
> > +     }
> > +}
> > +
> > +static const struct regmap_config max6639_regmap_config =3D {
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 8,
> > +     .max_register =3D MAX6639_REG_DEVREV,
> > +     .cache_type =3D REGCACHE_MAPLE,
> > +     .volatile_reg =3D max6639_regmap_is_volatile,
> > +};
> > +
> >  static int max6639_probe(struct i2c_client *client)
> >  {
> >       struct device *dev =3D &client->dev;
> > @@ -535,7 +496,11 @@ static int max6639_probe(struct i2c_client *client=
)
> >       if (!data)
> >               return -ENOMEM;
> >
> > -     data->client =3D client;
> > +     data->regmap =3D devm_regmap_init_i2c(client, &max6639_regmap_con=
fig);
> > +     if (IS_ERR(data->regmap))
> > +             return dev_err_probe(dev,
> > +                                  PTR_ERR(data->regmap),
> > +                                  "regmap initialization failed\n");
> >
> >       data->reg =3D devm_regulator_get_optional(dev, "fan");
> >       if (IS_ERR(data->reg)) {
> > @@ -558,8 +523,6 @@ static int max6639_probe(struct i2c_client *client)
> >               }
> >       }
> >
> > -     mutex_init(&data->update_lock);
> > -
> >       /* Initialize the max6639 chip */
> >       err =3D max6639_init_client(client, data);
> >       if (err < 0)
> > @@ -573,23 +536,18 @@ static int max6639_probe(struct i2c_client *clien=
t)
> >
> >  static int max6639_suspend(struct device *dev)
> >  {
> > -     struct i2c_client *client =3D to_i2c_client(dev);
> >       struct max6639_data *data =3D dev_get_drvdata(dev);
> > -     int ret =3D i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG)=
;
> > -
> > -     if (ret < 0)
> > -             return ret;
> > +     int ret;
>
> /home/groeck/src/max6639/max6639.c: In function =E2=80=98max6639_suspend=
=E2=80=99:
> /home/groeck/src/max6639/max6639.c:540:13: warning: unused variable =E2=
=80=98ret=E2=80=99
Sure.

Regards,
Naresh
>
> >
> >       if (data->reg)
> >               regulator_disable(data->reg);
> >
> > -     return i2c_smbus_write_byte_data(client,
> > -                     MAX6639_REG_GCONFIG, ret | MAX6639_GCONFIG_STANDB=
Y);
> > +     return regmap_write_bits(data->regmap, MAX6639_REG_GCONFIG, MAX66=
39_GCONFIG_STANDBY,
> > +                              MAX6639_GCONFIG_STANDBY);
> >  }
> >
> >  static int max6639_resume(struct device *dev)
> >  {
> > -     struct i2c_client *client =3D to_i2c_client(dev);
> >       struct max6639_data *data =3D dev_get_drvdata(dev);
> >       int ret;
> >
> > @@ -601,12 +559,8 @@ static int max6639_resume(struct device *dev)
> >               }
> >       }
> >
> > -     ret =3D i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
> > -     if (ret < 0)
> > -             return ret;
> > -
> > -     return i2c_smbus_write_byte_data(client,
> > -                     MAX6639_REG_GCONFIG, ret & ~MAX6639_GCONFIG_STAND=
BY);
> > +     return regmap_write_bits(data->regmap, MAX6639_REG_GCONFIG, MAX66=
39_GCONFIG_STANDBY,
> > +                              ~MAX6639_GCONFIG_STANDBY);
> >  }
> >
> >  static const struct i2c_device_id max6639_id[] =3D {
> >
> > base-commit: 1d4d6733594d407e54153b8e031ba6356ceba81e
> > --
> > 2.42.0
> >
> >

