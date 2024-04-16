Return-Path: <linux-kernel+bounces-147291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5528A7212
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0F42838A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC3A133297;
	Tue, 16 Apr 2024 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="c7Jb77B/"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A887130ACC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713287862; cv=none; b=gLVjIoMnDyXWptZijsqmW+az5FQHenAVuKjjKAaitD7b0wL4YBjomtTz3NkXNtIVOyFec+y11VJ4ZBR5FliV6JheN9CGVSyAXcGQv36efTSBUcrXWiCEW0wELCo9TwXiybwJ6SCI3n+xOAtaF1d4b44Hb3B233wI1iry+HyY9E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713287862; c=relaxed/simple;
	bh=EKXb7yQw/fe0FE8px0sxnaU+bNGR8VwStnqSeNJAK78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpNV2hQRYY18k2LgxsqGlqXxWr2gkWfuAY/Ywqj2eO6c7kZ/7wVgtg52LTkcT0nZMOdaufSPC2U9OugYJvdGWVkQyF1A4asLch1pzShOGcHdk+9+kxv6wn0xTqDMr6dsQrTJA4TjNOb5K4TMwri4Z1KX8dzPgprNx/atr5c9+90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=c7Jb77B/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4187981999fso12470305e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1713287859; x=1713892659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OfhnCdRCj4VDt6eW9kP3dOI/qEqIsCJXQa6tBxYksk=;
        b=c7Jb77B/BPEIHOx7JJlTtzAV0DJKPXAdmN2W/lq7AVN2h+5m+LJeoPv53c7Z4aXp5+
         8bdC1d+3QftXvakUAYPw6uiIQLz7EpnNU4ofO6UJ3tYQk+VYwjoiNc0QFeTNo76llCz0
         0SSwomDBu+XKxESkn61DlE5VvdgMS8Ea1sJkOtKABLAEisc+xjRhUB6lfpdhkpohZYqm
         52JRgd012xA7poByPzcpP9TpR7T0vggHLEagxI1fAsWhSwQkHiROwkQJDyqKlTSRuftC
         //mZRhBvCMfI7mUuPBPUb/UjfC5Hzg+NC0ln0+TeLQNfB3znNoY9Ni/A0P0OanVW4Fw4
         EWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713287859; x=1713892659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OfhnCdRCj4VDt6eW9kP3dOI/qEqIsCJXQa6tBxYksk=;
        b=L7PkV7+P4YeOSTy03HkswDMrUnn4uaEwFAJB37rMisxBcz017t7OdU/mROEkoOD/zF
         7aGt/kPkX4jZyqn88uJISqS79ddCQTOKARGGJoeRy8tESmYkMJhPkp2fvQ1dC80KRYG/
         vcmGg5CYkBCADXk/efX+SecMc1zWbQdIJlX9tIsQ77c66vCMZj2iPhzKrK/LPrBLmP5y
         LLsvRMjhgERSH9qSO7z7sAP3HSwnRhc8IgG5xPUjkqrhvxEQzdy1oxWSW3T8HUWbT51k
         7kBs+fcy56Nz+SAgmQt/lRCHYdK8A3XBrjZash7ksq571gsF7LLj4iJ1No0iU1DMzbhG
         bFRw==
X-Forwarded-Encrypted: i=1; AJvYcCVwFN3UIVRkMYC5B0qOrhHbGpD+7l5NkNm/BFBwgsZp5auBmKiTGCHBvj5Pt9mkuE7016xe83l2cfqJip1zaCmpB1w3zisraV26pED8
X-Gm-Message-State: AOJu0YxscEZUS3IvYZiWrqaPiorFeo3Y0bKhakopotJ9JmF214X26X5l
	ouW8mu4EhfbVh00UDR8oF3BxUpCKVH46gqbKR+z9RpkQ3W1j9g1TPNPMzLaIwJM=
X-Google-Smtp-Source: AGHT+IEzjiaX1n6oQ+liuW4MzJZY5btpgRV0JOFHDzPw647K0dBRyKO/Tjhf3hGYY7dRl/P8Gl3KRQ==
X-Received: by 2002:a05:600c:4506:b0:417:fbc2:caf8 with SMTP id t6-20020a05600c450600b00417fbc2caf8mr8135607wmo.23.1713287858595;
        Tue, 16 Apr 2024 10:17:38 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id w7-20020a05600c474700b004182fab5098sm13016326wmo.20.2024.04.16.10.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 10:17:38 -0700 (PDT)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Guenter Roeck <linux@roeck-us.net>,
	krzysztof.kozlowski+dt@linaro.org,
	u.kleine-koenig@pengutronix.de,
	Jean Delvare <jdelvare@suse.com>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH 2/4] hwmon: (max6639) : Utilise pwm subsystem
Date: Tue, 16 Apr 2024 22:47:15 +0530
Message-ID: <20240416171720.2875916-2-naresh.solanki@9elements.com>
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

Utilise pwm subsystem for fan pwm handling

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 drivers/hwmon/Kconfig   |   1 +
 drivers/hwmon/max6639.c | 200 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 191 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 257ec5360e35..c9cc74f8c807 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1224,6 +1224,7 @@ config SENSORS_MAX6639
 	tristate "Maxim MAX6639 sensor chip"
 	depends on I2C
 	select REGMAP_I2C
+	depends on PWM
 	help
 	  If you say yes here you get support for the MAX6639
 	  sensor chips.
diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 1af93fc53cb5..f37fdd161154 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/platform_data/max6639.h>
+#include <linux/pwm.h>
 #include <linux/regmap.h>
 
 /* Addresses to scan */
@@ -55,6 +56,9 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
 #define MAX6639_GCONFIG_PWM_FREQ_HI		0x08
 
 #define MAX6639_FAN_CONFIG1_PWM			0x80
+#define MAX6639_REG_FAN_CONFIG2a_PWM_POL	0x02
+#define MAX6639_FAN_CONFIG3_FREQ_MASK		0x03
+#define MAX6639_REG_TARGTDUTY_SLOT		120
 
 #define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED	0x40
 
@@ -62,6 +66,10 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
 
 static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
 
+/* Supported PWM frequency */
+static const unsigned int freq_table[] = { 20, 33, 50, 100, 5000, 8333, 12500,
+					   25000 };
+
 #define FAN_FROM_REG(val, rpm_range)	((val) == 0 || (val) == 255 ? \
 				0 : (rpm_ranges[rpm_range] * 30) / (val))
 #define TEMP_LIMIT_TO_REG(val)	clamp_val((val) / 1000, 0, 255)
@@ -93,6 +101,9 @@ struct max6639_data {
 
 	/* Optional regulator for FAN supply */
 	struct regulator *reg;
+	/* max6639 pwm chip */
+	struct pwm_chip chip;
+	struct pwm_device *pwmd[MAX6639_NDEV]; /* max6639 has two pwm device */
 };
 
 static struct max6639_data *max6639_update_device(struct device *dev)
@@ -271,8 +282,11 @@ static ssize_t pwm_show(struct device *dev, struct device_attribute *dev_attr,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
+	struct pwm_state state;
+
+	pwm_get_state(data->pwmd[attr->index], &state);
 
-	return sprintf(buf, "%d\n", data->pwm[attr->index] * 255 / 120);
+	return sprintf(buf, "%d\n", pwm_get_relative_duty_cycle(&state, 255));
 }
 
 static ssize_t pwm_store(struct device *dev,
@@ -281,6 +295,7 @@ static ssize_t pwm_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
+	struct pwm_state state;
 	unsigned long val;
 	int res;
 
@@ -290,10 +305,10 @@ static ssize_t pwm_store(struct device *dev,
 
 	val = clamp_val(val, 0, 255);
 
-	mutex_lock(&data->update_lock);
-	data->pwm[attr->index] = (u8)(val * 120 / 255);
-	regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(attr->index), data->pwm[attr->index]);
-	mutex_unlock(&data->update_lock);
+	pwm_get_state(data->pwmd[attr->index], &state);
+	pwm_set_relative_duty_cycle(&state, val, 255);
+	pwm_apply_state(data->pwmd[attr->index], &state);
+
 	return count;
 }
 
@@ -373,6 +388,158 @@ static struct attribute *max6639_attrs[] = {
 };
 ATTRIBUTE_GROUPS(max6639);
 
+static struct max6639_data *to_max6639_pwm(struct pwm_chip *chip)
+{
+	return container_of(chip, struct max6639_data, chip);
+}
+
+static int max6639_pwm_get_state(struct pwm_chip *chip,
+				 struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	struct max6639_data *data = to_max6639_pwm(chip);
+	int value, i = pwm->hwpwm, x, err;
+	unsigned int freq;
+
+	mutex_lock(&data->update_lock);
+
+	err = regmap_read(data->regmap, MAX6639_REG_FAN_CONFIG1(i), &value);
+	if (err < 0)
+		goto abort;
+
+	if (value & MAX6639_FAN_CONFIG1_PWM) {
+		state->enabled = true;
+
+		/* Determine frequency from respective registers */
+		err = regmap_read(data->regmap, MAX6639_REG_FAN_CONFIG3(i), &value);
+		if (err < 0)
+			goto abort;
+		x = value & MAX6639_FAN_CONFIG3_FREQ_MASK;
+
+		err = regmap_read(data->regmap, MAX6639_REG_GCONFIG, &value);
+		if (err < 0)
+			goto abort;
+		if (value & MAX6639_GCONFIG_PWM_FREQ_HI)
+			x |= 0x4;
+		x &= 0x7;
+		freq = freq_table[x];
+
+		state->period = DIV_ROUND_UP(NSEC_PER_SEC, freq);
+
+		err = regmap_read(data->regmap, MAX6639_REG_TARGTDUTY(i), &value);
+		if (err < 0)
+			goto abort;
+		/* max6639 supports 120 slots only */
+		state->duty_cycle = mul_u64_u32_div(state->period, value, 120);
+
+		err = regmap_read(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), &value);
+		if (err < 0)
+			goto abort;
+		value &= MAX6639_REG_FAN_CONFIG2a_PWM_POL;
+		state->polarity = (value != 0);
+	} else {
+		state->enabled = false;
+	}
+
+abort:
+	mutex_unlock(&data->update_lock);
+	return value;
+}
+
+static int max6639_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	struct max6639_data *data = to_max6639_pwm(chip);
+	int value, i = pwm->hwpwm, x, err;
+	unsigned int freq;
+	struct pwm_state cstate;
+
+	cstate = pwm->state;
+
+	mutex_lock(&data->update_lock);
+
+	if (state->period != cstate.period) {
+		/* Configure frequency */
+		freq = DIV_ROUND_UP_ULL(NSEC_PER_SEC, state->period);
+
+		/* Chip supports limited number of frequency */
+		for (x = 0; x < sizeof(freq_table); x++)
+			if (freq <= freq_table[x])
+				break;
+
+		err = regmap_read(data->regmap, MAX6639_REG_FAN_CONFIG3(i), &value);
+		if (err < 0)
+			goto abort;
+
+		value &= ~MAX6639_FAN_CONFIG3_FREQ_MASK;
+		value |= (x & MAX6639_FAN_CONFIG3_FREQ_MASK);
+		err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG3(i), value);
+		if (err < 0)
+			goto abort;
+
+		err = regmap_read(data->regmap, MAX6639_REG_GCONFIG, &value);
+		if (err < 0)
+			goto abort;
+
+		if (x >> 2)
+			value &= ~MAX6639_GCONFIG_PWM_FREQ_HI;
+		else
+			value |= MAX6639_GCONFIG_PWM_FREQ_HI;
+		err = regmap_write(data->regmap, MAX6639_REG_GCONFIG, value);
+		if (err < 0)
+			goto abort;
+	}
+
+	/* Configure dutycycle */
+	if (state->duty_cycle != cstate.duty_cycle ||
+	    state->period != cstate.period) {
+		value = DIV_ROUND_DOWN_ULL(state->duty_cycle * MAX6639_REG_TARGTDUTY_SLOT,
+					   state->period);
+		err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), value);
+		if (err < 0)
+			goto abort;
+	}
+
+	/* Configure polarity */
+	if (state->polarity != cstate.polarity) {
+		err = regmap_read(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), &value);
+		if (err < 0)
+			goto abort;
+		if (state->polarity == PWM_POLARITY_NORMAL)
+			value |= MAX6639_REG_FAN_CONFIG2a_PWM_POL;
+		else
+			value &= ~MAX6639_REG_FAN_CONFIG2a_PWM_POL;
+		err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), value);
+		if (err < 0)
+			goto abort;
+	}
+
+	if (state->enabled != cstate.enabled) {
+		err = regmap_read(data->regmap, MAX6639_REG_FAN_CONFIG1(i), &value);
+		if (err < 0)
+			goto abort;
+		if (state->enabled)
+			value |= MAX6639_FAN_CONFIG1_PWM;
+		else
+			value &= ~MAX6639_FAN_CONFIG1_PWM;
+
+		err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG1(i), value);
+		if (err < 0)
+			goto abort;
+	}
+	value = 0;
+
+abort:
+	mutex_unlock(&data->update_lock);
+
+	return err;
+}
+
+static const struct pwm_ops max6639_pwm_ops = {
+	.apply = max6639_pwm_apply,
+	.get_state = max6639_pwm_get_state,
+};
+
 /*
  *  returns respective index in rpm_ranges table
  *  1 by default on invalid range
@@ -396,6 +563,7 @@ static int max6639_init_client(struct i2c_client *client,
 		dev_get_platdata(&client->dev);
 	int i;
 	int rpm_range = 1; /* default: 4000 RPM */
+	struct pwm_state state;
 	int err;
 
 	/* Reset chip to default values, see below for GCONFIG setup */
@@ -459,11 +627,15 @@ static int max6639_init_client(struct i2c_client *client,
 		if (err)
 			goto exit;
 
-		/* PWM 120/120 (i.e. 100%) */
-		data->pwm[i] = 120;
-		err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), data->pwm[i]);
-		if (err)
-			goto exit;
+		dev_dbg(&client->dev, "Using chip default PWM");
+		data->pwmd[i] = pwm_request_from_chip(&data->chip, i, NULL);
+		if (IS_ERR(data->pwmd[i]))
+			return PTR_ERR(data->pwmd[i]);
+		pwm_get_state(data->pwmd[i], &state);
+		state.period = DIV_ROUND_UP(NSEC_PER_SEC, 25000);
+		state.polarity = PWM_POLARITY_NORMAL;
+		pwm_set_relative_duty_cycle(&state, 0, 255);
+		pwm_apply_state(data->pwmd[i], &state);
 	}
 	/* Start monitoring */
 	err = regmap_write(data->regmap, MAX6639_REG_GCONFIG,
@@ -540,6 +712,14 @@ static int max6639_probe(struct i2c_client *client)
 				     PTR_ERR(data->regmap),
 				     "regmap initialization failed\n");
 
+	/* Add PWM controller of max6639 */
+	data->chip.dev = dev;
+	data->chip.ops = &max6639_pwm_ops;
+	data->chip.npwm = MAX6639_NDEV;
+	err = devm_pwmchip_add(dev, &data->chip);
+	if (err < 0)
+		return dev_err_probe(dev, err, "failed to add PWM chip\n");
+
 	data->reg = devm_regulator_get_optional(dev, "fan");
 	if (IS_ERR(data->reg)) {
 		if (PTR_ERR(data->reg) != -ENODEV)
-- 
2.42.0


