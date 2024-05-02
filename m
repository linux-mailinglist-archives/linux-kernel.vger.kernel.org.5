Return-Path: <linux-kernel+bounces-166781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF808B9F70
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A29289BD4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0A016FF43;
	Thu,  2 May 2024 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="G8JRBcll"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC1316F91B
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670731; cv=none; b=SjkQjZ0YHpngs9pJPZp/YrSrUEKZrc8DBMdUvFiZ4FEYZaNPPygIF8Ed+yc+1xBAsQQQAbmJBCPePW84zydxcMjg4i3uGAAO3R0fP2IKAKRBwLikZJfJ14fNob90qWr3yV9COxR4IrogZRMKvTXh/+CCnCcm2bdD/fMSK3rFE7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670731; c=relaxed/simple;
	bh=dTXuJy2r24dMIffzcXGcc1ZXhtkLM7w3+qnvAvuhLu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ud+XWqGz6aCQXLCt5FTUwX5ofvuETJ7giUNKNdB9w9iC128aeUZmg4mbAF7k6k32vl0oWqxRecN+JfEpH9Xe//yDI0jP21enyBK/SYDpxT9h/JUtL4tFoeaUTXEiFz2gvUgP6JsYq7/wg9OdKzUaUHO/oDk1LzVWkEN6kBxiwjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=G8JRBcll; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ae913878b0so6173993a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 10:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1714670729; x=1715275529; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FUXzXPe4RcQN0noX04pUF7dVJGdZFvmYhsiDkLV/E4c=;
        b=G8JRBcllD3/6USYNAdPvoZh4707heRjlfLox+l0b7ivf36enD6k8fPHxD5ekZAgfOJ
         YvlBToLc4K/GSSE33sci7Oyd6TFZh3iNH8pyG07VQCD5W+LHuLRw4m63yafIuiK4y5MV
         ApHfYvIC9DLfjU0JAaDs6rHRvGuQTTlDT28jglcvN53JKO7Q1jc3/TwR+pAzOSdL7t5Q
         1MoCZW+2gj5JWf3OjSg6lvIO8/ao36uzuh8t3No9dc1Jasx/wSdehBaNPvrunnRCZ3e5
         zaDfpNZR8furlXzCyznFqENyOtaExlr3FGgVsasVJJ+npzRu9EH3CmqMhpbeQPdCnFP2
         FUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714670729; x=1715275529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUXzXPe4RcQN0noX04pUF7dVJGdZFvmYhsiDkLV/E4c=;
        b=oC5jDTltAcvuEA0uSM8UHimKWzy5oSgMNjF00cRlRdhALewpmuQvXhThRyF5Uq1Xle
         mC2zrT75DcN8DLMfTI9NwRRiabUYzSi3pILbm372YPJdGF4T/N70jtNhm4bVi+Mfgxp1
         bN91zsaFgKGQALVQ6Ca37xgDjaRsHrAqmwNaMynB+qdVjOucWXT9M0m0ojHJeq9jHxjx
         39gq+RzPqiL393gIl001TdkbSfYiYWjj0joNAD9fVguqmuq4SIJNldBeLnLen1CyyfvD
         LCfBglPaLedO7Z63PsOQA2+WEw69qwHv1Gqiq/0lWel77WHfw6RuuVRSEP9m8KXhuBc5
         OvcA==
X-Forwarded-Encrypted: i=1; AJvYcCU0+fG+swGWIuk1d0+094KyXQ4YWj8iBFfwBgl005kCSVxb2zIxK7Jvhw4UhoBA4Zt4/mc7oAcLwGmyqg74kwWIff+4xj9BUpW2A+Dp
X-Gm-Message-State: AOJu0YxRrNGyjvspigyuu57hItOWekyWBj7C/K0IXwupvkMnvcU+Gdxb
	TlFqazgCb/PpFEgr3boqQMEWH5i4EHfg0yOb56NOeY5VfpmOe/nTrHPXxd/LaomGalXNN9Xkgxg
	KLlXzqxdNtq9DWrJCkJrQzzjv1IbyrgQE4zdTAQ==
X-Google-Smtp-Source: AGHT+IFfCeeC7atBVM5NE7LMUgMrGuE51xevydU/NAxeisIESWOifC8ES5xu+49bKvFIzRI2aGo0oR7bokxNxJpOxJo=
X-Received: by 2002:a17:90a:898b:b0:2b1:74ad:e243 with SMTP id
 v11-20020a17090a898b00b002b174ade243mr397348pjn.24.1714670728302; Thu, 02 May
 2024 10:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430210539.935040-1-naresh.solanki@9elements.com> <52e7692c-abaa-4201-8248-3f42bb250335@roeck-us.net>
In-Reply-To: <52e7692c-abaa-4201-8248-3f42bb250335@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Thu, 2 May 2024 22:55:17 +0530
Message-ID: <CABqG17j2kMEK98T90eudb_ZWftaV2L4_MdA8ML+v_cm3MHFs1w@mail.gmail.com>
Subject: Re: [PATCH v2] hwmon (max6639): Use regmap
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

On Wed, 1 May 2024 at 19:27, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, May 01, 2024 at 02:35:38AM +0530, Naresh Solanki wrote:
> > Add regmap support & remove local caching.
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
> >  drivers/hwmon/Kconfig   |   1 +
> >  drivers/hwmon/max6639.c | 310 ++++++++++++++++++++--------------------
> >  2 files changed, 154 insertions(+), 157 deletions(-)
> >
> >
> > base-commit: 8b3aa2c488653fa1e127cf6e11499a8cbbaccad0
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
> > index 5dd0349e8bd0..b12d2098e259 100644
> > --- a/drivers/hwmon/max6639.c
> > +++ b/drivers/hwmon/max6639.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/err.h>
> >  #include <linux/mutex.h>
> >  #include <linux/platform_data/max6639.h>
> > +#include <linux/regmap.h>
> >
> >  /* Addresses to scan */
> >  static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
> > @@ -57,6 +58,8 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
> >
> >  #define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED 0x40
> >
> > +#define MAX6639_NDEV                         2
> > +
> >  static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
> >
> >  #define FAN_FROM_REG(val, rpm_range) ((val) == 0 || (val) == 255 ? \
> > @@ -67,22 +70,11 @@ static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
> >   * Client data (each client gets its own)
> >   */
> >  struct max6639_data {
> > -     struct i2c_client *client;
> > +     struct regmap *regmap;
> >       struct mutex update_lock;
>
> I think that lock can be dropped entirely.
Sure.
>
> > -     bool valid;             /* true if following fields are valid */
> > -     unsigned long last_updated;     /* In jiffies */
> > -
> > -     /* Register values sampled regularly */
> > -     u16 temp[2];            /* Temperature, in 1/8 C, 0..255 C */
> > -     bool temp_fault[2];     /* Detected temperature diode failure */
> > -     u8 fan[2];              /* Register value: TACH count for fans >=30 */
> > -     u8 status;              /* Detected channel alarms and fan failures */
> >
> >       /* Register values only written to */
> > -     u8 pwm[2];              /* Register value: Duty cycle 0..120 */
> > -     u8 temp_therm[2];       /* THERM Temperature, 0..255 C (->_max) */
> > -     u8 temp_alert[2];       /* ALERT Temperature, 0..255 C (->_crit) */
> > -     u8 temp_ot[2];          /* OT Temperature, 0..255 C (->_emergency) */
> > +     u8 pwm[MAX6639_NDEV];           /* Register value: Duty cycle 0..120 */
>
> pwm caching needs to be dropped as well. It is no longer initialized in
> max6639_init_client(), but updated and later used in pwm_store() and
> pwm_show(). Looking at the datasheet, the pwm registers are volatile
> and should not be cached in the first place.
Yes. I did that but found that the register is write only. i.e.,
>
>
> >
> >       /* Register values initialized only once */
> >       u8 ppr;                 /* Pulses per rotation 0..3 for 1..4 ppr */
> > @@ -92,90 +84,58 @@ struct max6639_data {
> >       struct regulator *reg;
> >  };
> >
> > -static struct max6639_data *max6639_update_device(struct device *dev)
> > -{
> > -     struct max6639_data *data = dev_get_drvdata(dev);
> > -     struct i2c_client *client = data->client;
> > -     struct max6639_data *ret = data;
> > -     int i;
> > -     int status_reg;
> > -
> > -     mutex_lock(&data->update_lock);
> > -
> > -     if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
> > -             int res;
> > -
> > -             dev_dbg(&client->dev, "Starting max6639 update\n");
> > -
> > -             status_reg = i2c_smbus_read_byte_data(client,
> > -                                                   MAX6639_REG_STATUS);
> > -             if (status_reg < 0) {
> > -                     ret = ERR_PTR(status_reg);
> > -                     goto abort;
> > -             }
> > -
> > -             data->status = status_reg;
> > -
> > -             for (i = 0; i < 2; i++) {
> > -                     res = i2c_smbus_read_byte_data(client,
> > -                                     MAX6639_REG_FAN_CNT(i));
> > -                     if (res < 0) {
> > -                             ret = ERR_PTR(res);
> > -                             goto abort;
> > -                     }
> > -                     data->fan[i] = res;
> > -
> > -                     res = i2c_smbus_read_byte_data(client,
> > -                                     MAX6639_REG_TEMP_EXT(i));
> > -                     if (res < 0) {
> > -                             ret = ERR_PTR(res);
> > -                             goto abort;
> > -                     }
> > -                     data->temp[i] = res >> 5;
> > -                     data->temp_fault[i] = res & 0x01;
> > -
> > -                     res = i2c_smbus_read_byte_data(client,
> > -                                     MAX6639_REG_TEMP(i));
> > -                     if (res < 0) {
> > -                             ret = ERR_PTR(res);
> > -                             goto abort;
> > -                     }
> > -                     data->temp[i] |= res << 3;
> > -             }
> > -
> > -             data->last_updated = jiffies;
> > -             data->valid = true;
> > -     }
> > -abort:
> > -     mutex_unlock(&data->update_lock);
> > -
> > -     return ret;
> > -}
> > -
> >  static ssize_t temp_input_show(struct device *dev,
> >                              struct device_attribute *dev_attr, char *buf)
> >  {
> >       long temp;
> > -     struct max6639_data *data = max6639_update_device(dev);
> > +     struct max6639_data *data = dev_get_drvdata(dev);
> >       struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> > +     unsigned int val;
> > +     int res;
> >
> >       if (IS_ERR(data))
> >               return PTR_ERR(data);
>
> Drop
Sure
>
> >
> > -     temp = data->temp[attr->index] * 125;
> > +     mutex_lock(&data->update_lock);
> > +     res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(attr->index), &val);
> > +     if (res < 0)
> > +             goto exit;
> > +
> > +     temp = val >> 5;
> > +     res = regmap_read(data->regmap, MAX6639_REG_TEMP(attr->index), &val);
> > +     if (res < 0)
> > +             goto exit;
> > +
> > +     temp |= val << 3;
> > +     temp *= 125;
> > +
> > +exit:
> > +     mutex_unlock(&data->update_lock);
Sure
>
> Given that updates to MAX6639_REG_TEMP are blocked for up to 250ms
> after reading MAX6639_REG_TEMP_EXT, I think this lock is unnecessary.
>
> > +     if (res < 0)
> > +             return res;
> > +
> >       return sprintf(buf, "%ld\n", temp);
> >  }
> >
> >  static ssize_t temp_fault_show(struct device *dev,
> >                              struct device_attribute *dev_attr, char *buf)
> >  {
> > -     struct max6639_data *data = max6639_update_device(dev);
> > +     struct max6639_data *data = dev_get_drvdata(dev);
> >       struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> > +     unsigned int val;
> > +     int res;
> >
> >       if (IS_ERR(data))
> >               return PTR_ERR(data);
>
> Drop
Ack
>
> >
> > -     return sprintf(buf, "%d\n", data->temp_fault[attr->index]);
> > +     mutex_lock(&data->update_lock);
> > +     res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(attr->index), &val);
> > +     mutex_unlock(&data->update_lock);
>
> Updates are blocked for 250ms after the extended temperature is read.
> I don't think there is a good reason to hold the lock while reading
> the register; worst case the value will be read here and by another thread
> from temp_input_show() at the same time, but that should not make a
> practical difference.
Ack
>
> > +
> > +     if (res < 0)
> > +             return res;
> > +
> > +     return sprintf(buf, "%d\n", val & 1);
> >  }
> >
> >  static ssize_t temp_max_show(struct device *dev,
> > @@ -183,8 +143,17 @@ static ssize_t temp_max_show(struct device *dev,
> >  {
> >       struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > +     unsigned int val;
> > +     int res;
> >
> > -     return sprintf(buf, "%d\n", (data->temp_therm[attr->index] * 1000));
> > +     mutex_lock(&data->update_lock);
> > +     res = regmap_read(data->regmap, MAX6639_REG_THERM_LIMIT(attr->index), &val);
> > +     mutex_unlock(&data->update_lock);
>
> Unnecessary lock. In general there is really hardly ever a good reason
> to hold a local lock during single register regmap accesses. Regmap
> serializes those accesses internally anyway.
Ack
>
> > +
> > +     if (res < 0)
> > +             return res;
> > +
> > +     return sprintf(buf, "%d\n", (val * 1000));
> >  }
> >
> >  static ssize_t temp_max_store(struct device *dev,
> > @@ -193,7 +162,6 @@ static ssize_t temp_max_store(struct device *dev,
> >  {
> >       struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     struct i2c_client *client = data->client;
> >       unsigned long val;
> >       int res;
> >
> > @@ -202,10 +170,8 @@ static ssize_t temp_max_store(struct device *dev,
> >               return res;
> >
> >       mutex_lock(&data->update_lock);
> > -     data->temp_therm[attr->index] = TEMP_LIMIT_TO_REG(val);
> > -     i2c_smbus_write_byte_data(client,
> > -                               MAX6639_REG_THERM_LIMIT(attr->index),
> > -                               data->temp_therm[attr->index]);
> > +     regmap_write(data->regmap, MAX6639_REG_THERM_LIMIT(attr->index),
> > +                  TEMP_LIMIT_TO_REG(val));
> >       mutex_unlock(&data->update_lock);
>
> Now unnecessary lock (it was necessary previously to ensure that
> data->temp_therm[] and the register value are in sync).
Ack
>
> >       return count;
> >  }
> > @@ -215,8 +181,17 @@ static ssize_t temp_crit_show(struct device *dev,
> >  {
> >       struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > +     unsigned int val;
> > +     int res;
> > +
> > +     mutex_lock(&data->update_lock);
> > +     res = regmap_read(data->regmap, MAX6639_REG_ALERT_LIMIT(attr->index), &val);
> > +     mutex_unlock(&data->update_lock);
>
> Unnecessary lock
Ack
>
> >
> > -     return sprintf(buf, "%d\n", (data->temp_alert[attr->index] * 1000));
> > +     if (res < 0)
> > +             return res;
> > +
> > +     return sprintf(buf, "%d\n", (val * 1000));
> >  }
> >
> >  static ssize_t temp_crit_store(struct device *dev,
> > @@ -225,7 +200,6 @@ static ssize_t temp_crit_store(struct device *dev,
> >  {
> >       struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     struct i2c_client *client = data->client;
> >       unsigned long val;
> >       int res;
> >
> > @@ -234,10 +208,8 @@ static ssize_t temp_crit_store(struct device *dev,
> >               return res;
> >
> >       mutex_lock(&data->update_lock);
> > -     data->temp_alert[attr->index] = TEMP_LIMIT_TO_REG(val);
> > -     i2c_smbus_write_byte_data(client,
> > -                               MAX6639_REG_ALERT_LIMIT(attr->index),
> > -                               data->temp_alert[attr->index]);
> > +     regmap_write(data->regmap, MAX6639_REG_ALERT_LIMIT(attr->index),
> > +                  TEMP_LIMIT_TO_REG(val));
>
> Now unnecessary lock
Ack
>
> >       mutex_unlock(&data->update_lock);
> >       return count;
> >  }
> > @@ -248,8 +220,17 @@ static ssize_t temp_emergency_show(struct device *dev,
> >  {
> >       struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > +     unsigned int val;
> > +     int res;
> >
> > -     return sprintf(buf, "%d\n", (data->temp_ot[attr->index] * 1000));
> > +     mutex_lock(&data->update_lock);
> > +     res = regmap_read(data->regmap, MAX6639_REG_OT_LIMIT(attr->index), &val);
> > +     mutex_unlock(&data->update_lock);
>
> Unnecessary lock
Ack
>
> > +
> > +     if (res < 0)
> > +             return res;
> > +
> > +     return sprintf(buf, "%d\n", (val * 1000));
> >  }
> >
> >  static ssize_t temp_emergency_store(struct device *dev,
> > @@ -258,7 +239,6 @@ static ssize_t temp_emergency_store(struct device *dev,
> >  {
> >       struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     struct i2c_client *client = data->client;
> >       unsigned long val;
> >       int res;
> >
> > @@ -267,10 +247,7 @@ static ssize_t temp_emergency_store(struct device *dev,
> >               return res;
> >
> >       mutex_lock(&data->update_lock);
> > -     data->temp_ot[attr->index] = TEMP_LIMIT_TO_REG(val);
> > -     i2c_smbus_write_byte_data(client,
> > -                               MAX6639_REG_OT_LIMIT(attr->index),
> > -                               data->temp_ot[attr->index]);
> > +     regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(attr->index), TEMP_LIMIT_TO_REG(val));
>
> Unnecessary lock
Ack
>
> >       mutex_unlock(&data->update_lock);
> >       return count;
> >  }
> > @@ -290,7 +267,6 @@ static ssize_t pwm_store(struct device *dev,
> >  {
> >       struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     struct i2c_client *client = data->client;
> >       unsigned long val;
> >       int res;
> >
> > @@ -299,12 +275,9 @@ static ssize_t pwm_store(struct device *dev,
> >               return res;
> >
> >       val = clamp_val(val, 0, 255);
> > -
> > -     mutex_lock(&data->update_lock);
> >       data->pwm[attr->index] = (u8)(val * 120 / 255);
> > -     i2c_smbus_write_byte_data(client,
> > -                               MAX6639_REG_TARGTDUTY(attr->index),
> > -                               data->pwm[attr->index]);
> > +     mutex_lock(&data->update_lock);
> > +     regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(attr->index), data->pwm[attr->index]);
> >       mutex_unlock(&data->update_lock);
>
> Now unnecessary lock (after data->pwm is removed)
Ack
>
> >       return count;
> >  }
> > @@ -312,26 +285,35 @@ static ssize_t pwm_store(struct device *dev,
> >  static ssize_t fan_input_show(struct device *dev,
> >                             struct device_attribute *dev_attr, char *buf)
> >  {
> > -     struct max6639_data *data = max6639_update_device(dev);
> > +     struct max6639_data *data = dev_get_drvdata(dev);
> >       struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> > +     unsigned int val;
> > +     int res;
> >
> >       if (IS_ERR(data))
> >               return PTR_ERR(data);
> >
> > -     return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
> > -                    data->rpm_range));
> > +     res = regmap_read(data->regmap, MAX6639_REG_FAN_CNT(attr->index), &val);
> > +     if (res < 0)
> > +             return res;
> > +
> > +     return sprintf(buf, "%d\n", FAN_FROM_REG(val, data->rpm_range));
> >  }
> >
> >  static ssize_t alarm_show(struct device *dev,
> >                         struct device_attribute *dev_attr, char *buf)
> >  {
> > -     struct max6639_data *data = max6639_update_device(dev);
> > +     struct max6639_data *data = dev_get_drvdata(dev);
> >       struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> > +     unsigned int val;
> > +     int res;
> >
> >       if (IS_ERR(data))
> >               return PTR_ERR(data);
> >
> > -     return sprintf(buf, "%d\n", !!(data->status & (1 << attr->index)));
> > +     res = regmap_read(data->regmap, MAX6639_REG_STATUS, &val);
> > +
> > +     return sprintf(buf, "%d\n", !!(val & (1 << attr->index)));
> >  }
> >
> >  static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
> > @@ -401,6 +383,11 @@ static int rpm_range_to_reg(int range)
> >       return 1; /* default: 4000 RPM */
> >  }
> >
> > +static int max6639_set_ppr(struct max6639_data *data, u8 channel, u8 ppr)
> > +{
> > +     return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), ppr << 6);
> > +}
> > +
> >  static int max6639_init_client(struct i2c_client *client,
> >                              struct max6639_data *data)
> >  {
> > @@ -408,49 +395,43 @@ static int max6639_init_client(struct i2c_client *client,
> >               dev_get_platdata(&client->dev);
> >       int i;
> >       int rpm_range = 1; /* default: 4000 RPM */
> > -     int err;
> > +     int err, ppr;
> >
> >       /* Reset chip to default values, see below for GCONFIG setup */
> > -     err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
> > -                               MAX6639_GCONFIG_POR);
> > +     err = regmap_write(data->regmap, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_POR);
> >       if (err)
> >               goto exit;
> >
> >       /* Fans pulse per revolution is 2 by default */
> >       if (max6639_info && max6639_info->ppr > 0 &&
> >                       max6639_info->ppr < 5)
> > -             data->ppr = max6639_info->ppr;
> > +             ppr = max6639_info->ppr;
> >       else
> > -             data->ppr = 2;
> > -     data->ppr -= 1;
> > +             ppr = 2;
> > +     ppr -= 1;
> >
> >       if (max6639_info)
> >               rpm_range = rpm_range_to_reg(max6639_info->rpm_range);
> >       data->rpm_range = rpm_range;
> >
> > -     for (i = 0; i < 2; i++) {
> > +     for (i = 0; i < MAX6639_NDEV; i++) {
> >
> >               /* Set Fan pulse per revolution */
> > -             err = i2c_smbus_write_byte_data(client,
> > -                             MAX6639_REG_FAN_PPR(i),
> > -                             data->ppr << 6);
> > +             err = max6639_set_ppr(data, i, ppr);
> >               if (err)
> >                       goto exit;
> >
> >               /* Fans config PWM, RPM */
> > -             err = i2c_smbus_write_byte_data(client,
> > -                     MAX6639_REG_FAN_CONFIG1(i),
> > -                     MAX6639_FAN_CONFIG1_PWM | rpm_range);
> > +             err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG1(i),
> > +                                MAX6639_FAN_CONFIG1_PWM | rpm_range);
> >               if (err)
> >                       goto exit;
> >
> >               /* Fans PWM polarity high by default */
> >               if (max6639_info && max6639_info->pwm_polarity == 0)
> > -                     err = i2c_smbus_write_byte_data(client,
> > -                             MAX6639_REG_FAN_CONFIG2a(i), 0x00);
> > +                     err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x00);
> >               else
> > -                     err = i2c_smbus_write_byte_data(client,
> > -                             MAX6639_REG_FAN_CONFIG2a(i), 0x02);
> > +                     err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x02);
> >               if (err)
> >                       goto exit;
> >
> > @@ -458,42 +439,31 @@ static int max6639_init_client(struct i2c_client *client,
> >                * /THERM full speed enable,
> >                * PWM frequency 25kHz, see also GCONFIG below
> >                */
> > -             err = i2c_smbus_write_byte_data(client,
> > -                     MAX6639_REG_FAN_CONFIG3(i),
> > -                     MAX6639_FAN_CONFIG3_THERM_FULL_SPEED | 0x03);
> > +             err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG3(i),
> > +                                MAX6639_FAN_CONFIG3_THERM_FULL_SPEED | 0x03);
> >               if (err)
> >                       goto exit;
> >
> >               /* Max. temp. 80C/90C/100C */
> > -             data->temp_therm[i] = 80;
> > -             data->temp_alert[i] = 90;
> > -             data->temp_ot[i] = 100;
> > -             err = i2c_smbus_write_byte_data(client,
> > -                             MAX6639_REG_THERM_LIMIT(i),
> > -                             data->temp_therm[i]);
> > +             err = regmap_write(data->regmap, MAX6639_REG_THERM_LIMIT(i), 80);
> >               if (err)
> >                       goto exit;
> > -             err = i2c_smbus_write_byte_data(client,
> > -                             MAX6639_REG_ALERT_LIMIT(i),
> > -                             data->temp_alert[i]);
> > +             err = regmap_write(data->regmap, MAX6639_REG_ALERT_LIMIT(i), 90);
> >               if (err)
> >                       goto exit;
> > -             err = i2c_smbus_write_byte_data(client,
> > -                             MAX6639_REG_OT_LIMIT(i), data->temp_ot[i]);
> > +             err = regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(i), 100);
> >               if (err)
> >                       goto exit;
> >
> >               /* PWM 120/120 (i.e. 100%) */
> > -             data->pwm[i] = 120;
> > -             err = i2c_smbus_write_byte_data(client,
> > -                             MAX6639_REG_TARGTDUTY(i), data->pwm[i]);
> > +             err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), 120);
> >               if (err)
> >                       goto exit;
> >       }
> >       /* Start monitoring */
> > -     err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
> > -             MAX6639_GCONFIG_DISABLE_TIMEOUT | MAX6639_GCONFIG_CH2_LOCAL |
> > -             MAX6639_GCONFIG_PWM_FREQ_HI);
> > +     err = regmap_write(data->regmap, MAX6639_REG_GCONFIG,
> > +                        MAX6639_GCONFIG_DISABLE_TIMEOUT | MAX6639_GCONFIG_CH2_LOCAL |
> > +                        MAX6639_GCONFIG_PWM_FREQ_HI);
> >  exit:
> >       return err;
> >  }
> > @@ -524,6 +494,30 @@ static void max6639_regulator_disable(void *data)
> >       regulator_disable(data);
> >  }
> >
> > +static bool max6639_regmap_is_volatile(struct device *dev, unsigned int reg)
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
> pwm registers are also volatile.
>
> > +             return true;
> > +     default:
> > +             return false;
> > +     }
> > +}
> > +
> > +static const struct regmap_config max6639_regmap_config = {
> > +     .reg_bits = 8,
> > +     .val_bits = 8,
> > +     .max_register = MAX6639_REG_DEVREV,
> > +     .cache_type = REGCACHE_MAPLE,
> > +     .volatile_reg = max6639_regmap_is_volatile,
> > +};
> > +
> >  static int max6639_probe(struct i2c_client *client)
> >  {
> >       struct device *dev = &client->dev;
> > @@ -535,7 +529,11 @@ static int max6639_probe(struct i2c_client *client)
> >       if (!data)
> >               return -ENOMEM;
> >
> > -     data->client = client;
> > +     data->regmap = devm_regmap_init_i2c(client, &max6639_regmap_config);
> > +     if (IS_ERR(data->regmap))
> > +             return dev_err_probe(dev,
> > +                                  PTR_ERR(data->regmap),
> > +                                  "regmap initialization failed\n");
> >
> >       data->reg = devm_regulator_get_optional(dev, "fan");
> >       if (IS_ERR(data->reg)) {
> > @@ -573,25 +571,24 @@ static int max6639_probe(struct i2c_client *client)
> >
> >  static int max6639_suspend(struct device *dev)
> >  {
> > -     struct i2c_client *client = to_i2c_client(dev);
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     int ret = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
> > +     int ret, err;
> >
> > -     if (ret < 0)
> > -             return ret;
> > +     err = regmap_read(data->regmap, MAX6639_REG_GCONFIG, &ret);
> > +
>
> Unnecessary empty line.
Ack
>
> > +     if (err < 0)
> > +             return err;
> >
> >       if (data->reg)
> >               regulator_disable(data->reg);
> >
> > -     return i2c_smbus_write_byte_data(client,
> > -                     MAX6639_REG_GCONFIG, ret | MAX6639_GCONFIG_STANDBY);
> > +     return regmap_write(data->regmap, MAX6639_REG_GCONFIG, ret | MAX6639_GCONFIG_STANDBY);
> >  }
> >
> >  static int max6639_resume(struct device *dev)
> >  {
> > -     struct i2c_client *client = to_i2c_client(dev);
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     int ret;
> > +     int ret, err;
> >
> >       if (data->reg) {
> >               ret = regulator_enable(data->reg);
> > @@ -601,12 +598,11 @@ static int max6639_resume(struct device *dev)
> >               }
> >       }
> >
> > -     ret = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
> > -     if (ret < 0)
> > -             return ret;
> > +     err = regmap_read(data->regmap, MAX6639_REG_GCONFIG, &ret);
> > +     if (err < 0)
> > +             return err;
> >
> > -     return i2c_smbus_write_byte_data(client,
> > -                     MAX6639_REG_GCONFIG, ret & ~MAX6639_GCONFIG_STANDBY);
> > +     return regmap_write(data->regmap, MAX6639_REG_GCONFIG, ret & ~MAX6639_GCONFIG_STANDBY);
> >  }
> >
> >  static const struct i2c_device_id max6639_id[] = {

Regards,
Naresh

