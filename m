Return-Path: <linux-kernel+bounces-147292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F978A7214
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF022836B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E82133983;
	Tue, 16 Apr 2024 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="CXpJpjnu"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D9B13280C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713287864; cv=none; b=FkqMnG4kg/gOtQlYYSl4O+JGJ0Ji5m/THULYUpri6qIKI60UGOvvXNMaAJg4dHp8pJJzMETgnvfk3Mp1K4EejbpmSuryZMNCLo8RknTjMQjyb4AHR7SpzzW94e/Bk8vS7OJff8aCDgBzHWW40JxeO/dyWrk1tNTZt9Y5cVjNWSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713287864; c=relaxed/simple;
	bh=JjPWPECbgQ70y8Fda+Qzz2dyjIK5uHg4LKC4Y0x9NGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRj1jaO4FeX+w5yYL8v2heuzrTg2gynV9O6sYF+gjk7aRwS3M5pYNkbLwnXbnu3aBnl2t1wL9RWnrxVYFNKmQIDByAc0QH0sgNFjfKDaPAkpD+lSmQ8KMq5cb6uZZc9He3CbEbYOkPYrlf5rqCnDHD74fGP4Hvce/6TVaKyUU9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=CXpJpjnu; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so45683781fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1713287861; x=1713892661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9v/FQWgcRKzVZOWVCcwsYZeI4Wx0vx2fYRhr6/mkVy4=;
        b=CXpJpjnucCbZ/c6EO1GGlTepQV3uxHX5aSUHH9PkW7VaycTR7UdKHnVdkb6doNRLJQ
         7P3h8H5psI81W9TSQYwCwU3sCwZ6cic9tobkyQpoIXHwAZPB85S5P4doJnSa78UuMdi/
         hq/3IqvbJOBicogWPKcoSdVD+fJASj1c7DfrZLp7ZPHvs0gYbloI9g+xMRnksrtX88d5
         CBUbh34lHroEDIkZdeTzQiXJN8cPaL342XPyt6P/GDMShGfGlG2pZvA5IFfvUeWdDvaU
         Ue7con+VFmW0ia9W/4AhyQoHSoeRKao/9r1JyBVwtwmIl1dx+wnosyiWW6Je4ZhKD9Wd
         LkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713287861; x=1713892661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9v/FQWgcRKzVZOWVCcwsYZeI4Wx0vx2fYRhr6/mkVy4=;
        b=P/NVh+xdbvyeM++kZCH6OpuJafA6gVgLbzQqHEdyFxbRZJ1ojWUsBnNC8vdO+mVdy1
         RdOUuBL9rXuWGyq9lrOO0Ld4ZwPOXv/snvlrP2YDfOUKWRiU+fT634AmQcPKMwXWz0K5
         aH+BwC6GoLJtuxSPC2xfXI1hbx3ofEuZRoQHJNj2D126seeYJQSG+tabAXBGxAux9Pdr
         nswYCALHc9VTs715aIpXHQ1x9OP4aCW4XXF8tQ7udx2iKgAWDo+5myR6npwkqGPilFFU
         La/yuHtwSX90RJEj1V9Pz47A7UV1xgvgzGmk0soto2eVbGnK29ThmKgexTOTUJLtcBMV
         fsNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOfcwTFsdBknYAroPw3cjwYIr53nMjD3U5Gcv9FcOZ3GZu2ImpHtdFkVGijCaGRwdV/t936pMUwMjXEpcgJTaOglEYUfRSlgaCzplw
X-Gm-Message-State: AOJu0Yypt8Pupu2t0GbiUOgvNJiHhJvkPiRESzPTqXp2/kiKf5x3WiPo
	/0UTg+LXJSXv4Jx0DoQRuN3z9NlnEy+JdgE6j0mxtiaiciJ9eRj+A5IMPe/MUm8=
X-Google-Smtp-Source: AGHT+IFu92QOtSXiVgXr3rSx99oUQvOjjnRi8SjySanUwTWrYlk/+S3nIve3uNf4tPx9Qmgggyd/iA==
X-Received: by 2002:a2e:7408:0:b0:2d7:1f9e:670 with SMTP id p8-20020a2e7408000000b002d71f9e0670mr7668608ljc.0.1713287860416;
        Tue, 16 Apr 2024 10:17:40 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id w7-20020a05600c474700b004182fab5098sm13016326wmo.20.2024.04.16.10.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 10:17:39 -0700 (PDT)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Guenter Roeck <linux@roeck-us.net>,
	krzysztof.kozlowski+dt@linaro.org,
	u.kleine-koenig@pengutronix.de,
	Jean Delvare <jdelvare@suse.com>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] hwmon: (max6639) : Add hwmon init using info
Date: Tue, 16 Apr 2024 22:47:16 +0530
Message-ID: <20240416171720.2875916-3-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240416171720.2875916-1-naresh.solanki@9elements.com>
References: <20240416171720.2875916-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add hwmon init with info
Also added additional attribute for fan i.e.,
fanY_pulse
pwmY_freq

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 drivers/hwmon/max6639.c | 408 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 379 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index f37fdd161154..d9b23202d7a2 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -62,6 +62,8 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
 
 #define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED	0x40
 
+#define MAX6639_FAN_PPR_MASK(ppr)		(((ppr) - 1) << 6)
+
 #define MAX6639_NDEV				2
 
 static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
@@ -79,25 +81,27 @@ static const unsigned int freq_table[] = { 20, 33, 50, 100, 5000, 8333, 12500,
  */
 struct max6639_data {
 	struct regmap *regmap;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	bool valid;		/* true if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
 	/* Register values sampled regularly */
-	u16 temp[2];		/* Temperature, in 1/8 C, 0..255 C */
-	bool temp_fault[2];	/* Detected temperature diode failure */
-	u8 fan[2];		/* Register value: TACH count for fans >=30 */
-	u8 status;		/* Detected channel alarms and fan failures */
+	u16 temp[MAX6639_NDEV];		/* Temperature, in 1/8 C, 0..255 C */
+	bool temp_fault[MAX6639_NDEV];	/* Detected temperature diode failure */
+	bool fan_enable[MAX6639_NDEV];
+	u8 fan[MAX6639_NDEV];		/* Register value: TACH count for fans >=30 */
+	u8 status;			/* Detected channel alarms and fan failures */
 
 	/* Register values only written to */
-	u8 pwm[2];		/* Register value: Duty cycle 0..120 */
-	u8 temp_therm[2];	/* THERM Temperature, 0..255 C (->_max) */
-	u8 temp_alert[2];	/* ALERT Temperature, 0..255 C (->_crit) */
-	u8 temp_ot[2];		/* OT Temperature, 0..255 C (->_emergency) */
+	u8 pwm[MAX6639_NDEV];		/* Register value: Duty cycle 0..120 */
+	u8 temp_therm[MAX6639_NDEV];	/* THERM Temperature, 0..255 C (->_max) */
+	u8 temp_alert[MAX6639_NDEV];	/* ALERT Temperature, 0..255 C (->_crit) */
+	u8 temp_ot[MAX6639_NDEV];	/* OT Temperature, 0..255 C (->_emergency) */
 
 	/* Register values initialized only once */
-	u8 ppr;			/* Pulses per rotation 0..3 for 1..4 ppr */
-	u8 rpm_range;		/* Index in above rpm_ranges table */
+	u8 ppr[MAX6639_NDEV];	/* Pulses per rotation 0..3 for 1..4 ppr */
+	u8 rpm_range[MAX6639_NDEV]; /* Index in above rpm_ranges table */
 
 	/* Optional regulator for FAN supply */
 	struct regulator *reg;
@@ -128,7 +132,7 @@ static struct max6639_data *max6639_update_device(struct device *dev)
 
 		data->status = status_reg;
 
-		for (i = 0; i < 2; i++) {
+		for (i = 0; i < MAX6639_NDEV; i++) {
 			err = regmap_read(data->regmap, MAX6639_REG_FAN_CNT(i), &res);
 			if (err < 0) {
 				ret = ERR_PTR(err);
@@ -322,7 +326,7 @@ static ssize_t fan_input_show(struct device *dev,
 		return PTR_ERR(data);
 
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
-		       data->rpm_range));
+		       data->rpm_range[attr->index]));
 }
 
 static ssize_t alarm_show(struct device *dev,
@@ -388,6 +392,342 @@ static struct attribute *max6639_attrs[] = {
 };
 ATTRIBUTE_GROUPS(max6639);
 
+static int max6639_temp_set_max(struct max6639_data *data, int channel, unsigned long val)
+{
+	int res;
+
+	mutex_lock(&data->update_lock);
+	data->temp_therm[channel] = TEMP_LIMIT_TO_REG(val);
+	res = regmap_write(data->regmap, MAX6639_REG_THERM_LIMIT(channel),
+			   data->temp_therm[channel]);
+	mutex_unlock(&data->update_lock);
+	return res;
+}
+
+static int max6639_temp_set_crit(struct max6639_data *data, int channel, unsigned long val)
+{
+	int res;
+
+	mutex_lock(&data->update_lock);
+	data->temp_alert[channel] = TEMP_LIMIT_TO_REG(val);
+	res = regmap_write(data->regmap, MAX6639_REG_ALERT_LIMIT(channel),
+			   data->temp_alert[channel]);
+	mutex_unlock(&data->update_lock);
+	return res;
+}
+
+static int max6639_temp_set_emergency(struct max6639_data *data, int channel, unsigned long val)
+{
+	int res;
+
+	mutex_lock(&data->update_lock);
+	data->temp_ot[channel] = TEMP_LIMIT_TO_REG(val);
+	res = regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(channel),
+			   data->temp_ot[channel]);
+	mutex_unlock(&data->update_lock);
+	return res;
+}
+
+static int set_ppr(struct max6639_data *data, u8 channel, u8 ppr)
+{
+	return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), MAX6639_FAN_PPR_MASK(ppr));
+}
+
+static int max6639_read_fan(struct device *dev, u32 attr, int channel,
+			    long *val)
+{
+	struct max6639_data *data = max6639_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	switch (attr) {
+	case hwmon_fan_input:
+		*val = FAN_FROM_REG(data->fan[channel], data->rpm_range[channel]);
+		return 0;
+	case hwmon_fan_fault:
+		*val = !!(data->status & (2 >> channel));
+		return 0;
+	case hwmon_fan_pulses:
+		*val = data->ppr[channel];
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int max6639_write_fan(struct device *dev, u32 attr, int channel,
+			     long val)
+{
+	struct max6639_data *data = max6639_update_device(dev);
+	int err;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	switch (attr) {
+	case hwmon_fan_pulses:
+		if (val <= 0 || val > 5) {
+			dev_err(dev, "invalid pulses-per-revolution %ld. Valid range id 1 - 4.",
+				val);
+			return -EINVAL;
+		}
+		/* Set Fan pulse per revolution */
+		err = set_ppr(data, channel, val);
+		if (err)
+			dev_err(dev, "Failed to set pulses-per-revolution");
+		else
+			data->ppr[channel] = val;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t max6639_fan_is_visible(const void *_data, u32 attr, int channel)
+{
+	struct max6639_data *data = (struct max6639_data *)_data;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	switch (attr) {
+	case hwmon_fan_input:
+	case hwmon_fan_fault:
+		if (data->fan_enable[channel])
+			return 0444;
+		else
+			return 0;
+	case hwmon_fan_pulses:
+		if (data->fan_enable[channel])
+			return 0644;
+		else
+			return 0;
+	default:
+		return 0;
+	}
+}
+
+static int max6639_read_pwm(struct device *dev, u32 attr, int channel,
+			    long *val)
+{
+	struct max6639_data *data = max6639_update_device(dev);
+	struct pwm_state state;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	switch (attr) {
+	case hwmon_pwm_input:
+		pwm_get_state(data->pwmd[channel], &state);
+		*val = pwm_get_relative_duty_cycle(&state, 255);
+		return 0;
+	case hwmon_pwm_freq:
+		pwm_get_state(data->pwmd[channel], &state);
+		*val = DIV_ROUND_UP_ULL(NSEC_PER_SEC, state.period);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int max6639_write_pwm(struct device *dev, u32 attr, int channel,
+			     long val)
+{
+	struct max6639_data *data = max6639_update_device(dev);
+	struct pwm_state state;
+	int err, duty_cycle;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	switch (attr) {
+	case hwmon_pwm_input:
+		val = clamp_val(val, 0, 255);
+		pwm_get_state(data->pwmd[channel], &state);
+		pwm_set_relative_duty_cycle(&state, val, 255);
+		err = pwm_apply_state(data->pwmd[channel], &state);
+		return err;
+
+	case hwmon_pwm_freq:
+		val = clamp_val(val, 0, 25000);
+		pwm_get_state(data->pwmd[channel], &state);
+		duty_cycle = pwm_get_relative_duty_cycle(&state, 255);
+		state.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, val);
+		pwm_set_relative_duty_cycle(&state, duty_cycle, 255);
+		err = pwm_apply_state(data->pwmd[channel], &state);
+		return err;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t max6639_pwm_is_visible(const void *_data, u32 attr, int channel)
+{
+	struct max6639_data *data = (struct max6639_data *)_data;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	if (IS_ERR(data->pwmd[channel]))
+		return 0;
+
+	switch (attr) {
+	case hwmon_pwm_input:
+	case hwmon_pwm_freq:
+		if (data->fan_enable[channel])
+			return 0644;
+		else
+			return 0;
+	default:
+		return 0;
+	}
+}
+
+static int max6639_read_temp(struct device *dev, u32 attr, int channel,
+			     long *val)
+{
+	struct max6639_data *data = max6639_update_device(dev);
+
+	switch (attr) {
+	case hwmon_temp_input:
+		*val = data->temp[channel] * 125;
+		return 0;
+	case hwmon_temp_fault:
+		*val = data->temp_fault[channel] * 125;
+		return 0;
+	case hwmon_temp_max:
+		*val = data->temp_therm[channel] * 1000;
+		return 0;
+	case hwmon_temp_crit:
+		*val = data->temp_alert[channel] * 1000;
+		return 0;
+	case hwmon_temp_emergency:
+		*val = data->temp_ot[channel] * 1000;
+		return 0;
+	case hwmon_temp_max_alarm:
+		*val = !!(data->status & (0x08 >> channel));
+		return 0;
+	case hwmon_temp_crit_alarm:
+		*val = !!(data->status & (0x80 >> channel));
+		return 0;
+	case hwmon_temp_emergency_alarm:
+		*val = !!(data->status & (0x20 >> channel));
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int max6639_write_temp(struct device *dev, u32 attr, int channel,
+			      long val)
+{
+	struct max6639_data *data = max6639_update_device(dev);
+
+	switch (attr) {
+	case hwmon_temp_max:
+		return max6639_temp_set_max(data, channel, val);
+	case hwmon_temp_crit:
+		return max6639_temp_set_crit(data, channel, val);
+	case hwmon_temp_emergency:
+		return max6639_temp_set_emergency(data, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t MAX6639_NDEV_is_visible(const void *_data, u32 attr, int channel)
+{
+	switch (attr) {
+	case hwmon_temp_input:
+	case hwmon_temp_fault:
+	case hwmon_temp_max_alarm:
+	case hwmon_temp_crit_alarm:
+	case hwmon_temp_emergency_alarm:
+		return 0444;
+	case hwmon_temp_max:
+	case hwmon_temp_crit:
+	case hwmon_temp_emergency:
+		return 0644;
+	default:
+		return 0;
+	}
+}
+
+static int max6639_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	switch (type) {
+	case hwmon_fan:
+		return max6639_read_fan(dev, attr, channel, val);
+	case hwmon_pwm:
+		return max6639_read_pwm(dev, attr, channel, val);
+	case hwmon_temp:
+		return max6639_read_temp(dev, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int max6639_write(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long val)
+{
+	switch (type) {
+	case hwmon_fan:
+		return max6639_write_fan(dev, attr, channel, val);
+	case hwmon_pwm:
+		return max6639_write_pwm(dev, attr, channel, val);
+	case hwmon_temp:
+		return max6639_write_temp(dev, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t max6639_is_visible(const void *data,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_fan:
+		return max6639_fan_is_visible(data, attr, channel);
+	case hwmon_pwm:
+		return max6639_pwm_is_visible(data, attr, channel);
+	case hwmon_temp:
+		return MAX6639_NDEV_is_visible(data, attr, channel);
+	default:
+		return 0;
+	}
+}
+
+static const struct hwmon_channel_info * const max6639_info[] = {
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_PULSES,
+			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_PULSES),
+	HWMON_CHANNEL_INFO(pwm,
+			   HWMON_PWM_INPUT | HWMON_PWM_FREQ,
+			   HWMON_PWM_INPUT | HWMON_PWM_FREQ),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_MAX | HWMON_T_MAX_ALARM |
+			   HWMON_T_CRIT | HWMON_T_CRIT_ALARM | HWMON_T_EMERGENCY |
+			   HWMON_T_EMERGENCY_ALARM,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_MAX | HWMON_T_MAX_ALARM |
+			   HWMON_T_CRIT | HWMON_T_CRIT_ALARM | HWMON_T_EMERGENCY |
+			   HWMON_T_EMERGENCY_ALARM),
+	NULL
+};
+
+static const struct hwmon_ops max6639_hwmon_ops = {
+	.is_visible = max6639_is_visible,
+	.read = max6639_read,
+	.write = max6639_write,
+};
+
+static const struct hwmon_chip_info max6639_chip_info = {
+	.ops = &max6639_hwmon_ops,
+	.info = max6639_info,
+};
+
 static struct max6639_data *to_max6639_pwm(struct pwm_chip *chip)
 {
 	return container_of(chip, struct max6639_data, chip);
@@ -542,18 +882,18 @@ static const struct pwm_ops max6639_pwm_ops = {
 
 /*
  *  returns respective index in rpm_ranges table
- *  1 by default on invalid range
+ *  3 by default on invalid range
  */
 static int rpm_range_to_reg(int range)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(rpm_ranges); i++) {
-		if (rpm_ranges[i] == range)
+		if (range <= rpm_ranges[i])
 			return i;
 	}
 
-	return 1; /* default: 4000 RPM */
+	return 3; /* default: 16000 RPM */
 }
 
 static int max6639_init_client(struct i2c_client *client,
@@ -564,7 +904,7 @@ static int max6639_init_client(struct i2c_client *client,
 	int i;
 	int rpm_range = 1; /* default: 4000 RPM */
 	struct pwm_state state;
-	int err;
+	int err, ppr = 2;
 
 	/* Reset chip to default values, see below for GCONFIG setup */
 	err = regmap_write(data->regmap, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_POR);
@@ -574,25 +914,27 @@ static int max6639_init_client(struct i2c_client *client,
 	/* Fans pulse per revolution is 2 by default */
 	if (max6639_info && max6639_info->ppr > 0 &&
 			max6639_info->ppr < 5)
-		data->ppr = max6639_info->ppr;
-	else
-		data->ppr = 2;
-	data->ppr -= 1;
+		ppr = max6639_info->ppr;
+	ppr -= 1;
+	data->ppr[0] = ppr;
+	data->ppr[1] = ppr;
 
 	if (max6639_info)
 		rpm_range = rpm_range_to_reg(max6639_info->rpm_range);
-	data->rpm_range = rpm_range;
+	data->rpm_range[0] = rpm_range;
+	data->rpm_range[1] = rpm_range;
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < MAX6639_NDEV; i++) {
 
 		/* Set Fan pulse per revolution */
-		err = regmap_write(data->regmap, MAX6639_REG_FAN_PPR(i), data->ppr << 6);
+		err = regmap_write(data->regmap, MAX6639_REG_FAN_PPR(i),
+				   MAX6639_FAN_PPR_MASK(data->ppr[i]));
 		if (err)
 			goto exit;
 
 		/* Fans config PWM, RPM */
 		err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG1(i),
-				   MAX6639_FAN_CONFIG1_PWM | rpm_range);
+				   MAX6639_FAN_CONFIG1_PWM | data->rpm_range[i]);
 		if (err)
 			goto exit;
 
@@ -617,6 +959,8 @@ static int max6639_init_client(struct i2c_client *client,
 		data->temp_therm[i] = 80;
 		data->temp_alert[i] = 90;
 		data->temp_ot[i] = 100;
+		data->fan_enable[i] = true;
+
 		err = regmap_write(data->regmap, MAX6639_REG_THERM_LIMIT(i), data->temp_therm[i]);
 		if (err)
 			goto exit;
@@ -699,7 +1043,6 @@ static int max6639_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct max6639_data *data;
-	struct device *hwmon_dev;
 	int err;
 
 	data = devm_kzalloc(dev, sizeof(struct max6639_data), GFP_KERNEL);
@@ -748,10 +1091,17 @@ static int max6639_probe(struct i2c_client *client)
 	if (err < 0)
 		return err;
 
-	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
-							   data,
-							   max6639_groups);
-	return PTR_ERR_OR_ZERO(hwmon_dev);
+	if (0)
+		data->hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+									 data,
+									 max6639_groups);
+
+	data->hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, data,
+							       &max6639_chip_info, NULL);
+	if (IS_ERR(data->hwmon_dev))
+		return dev_err_probe(dev, PTR_ERR(data->hwmon_dev),
+				     "unable to register hwmon device\n");
+	return 0;
 }
 
 static int max6639_suspend(struct device *dev)
-- 
2.42.0


