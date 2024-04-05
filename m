Return-Path: <linux-kernel+bounces-132295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB808992A2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEFC0B23566
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A94CE572;
	Fri,  5 Apr 2024 00:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Mw4enQKX"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214D617F8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712277034; cv=none; b=H4/hWMviqTf1D3lRpX+H5dErUgm49sMqLSzoABnaqplKCVOU2fHpzZ+rg0XciObVLDZIuWm8ssoMpInr5Bhncd4bcntfBwMUf7Irw5ilEpSJ1nW6c0orUq7zw8cWbjgjNkpsB4rTwlUkXMaVDNYs05dWjqhwF4V2ArEIxh+EkhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712277034; c=relaxed/simple;
	bh=4AgyvYLStYaefPpieUHnAMDvsbOsjZpYhGh6QgQbxo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRrKibR7D0uiPR3S40YlfWPIcDe0COpQLyjOKtf/laM46PTr3dKywP6d2tU8kYPmmZO9EDN+cd02yi8bC14LLdXoA1cI2uVr68QHZlAkWTpGxNet8DRRglcZGqJqNC/ADygPZlQQwQcMry+c0mM49pZbuCQBsy9D/0xj6GlnMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Mw4enQKX; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-615038fc5baso17429787b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 17:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712277029; x=1712881829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShutlIE8DACdzeSSC3XVEeXZaPNv1RHdPHW39J6XIEY=;
        b=Mw4enQKXzGDUW91byFQ//+UjBHOOnZa9PoPXty9Q6mFnnxn8icMNytl89Yn2gANoAb
         EVOCrAmmA3q9TolkXoao0QlFYBwRAC4xxkPE4xuJ1j+2d8/ty4+PqRHbspTxEj/jZeqD
         iDdle8CEl/EHZqI+cycUkxD92/gjFIlomHq9iPyonTWc7B+sXel3esOftgja+yCXn17q
         0fhCm3Ba5JHr8qEf9c+MFuadG6GhgtuPeUwix44zYhAY2X0Xd0JSdvIG2RZeWsBlPg11
         bY+obqdAfqrmWi77O0QqlkLlVi7fSKQg/D+DhJN3RiimRgVjWni1NuX4YpctP7Zh5A3a
         /rkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712277029; x=1712881829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShutlIE8DACdzeSSC3XVEeXZaPNv1RHdPHW39J6XIEY=;
        b=jZaFAA5KpWNaK0L1KxVhqWjsLEIWwynXeyuCV4D/3GOhF/6fMPhdabmPOsrUZidEAZ
         r5nRa/7UUNths9OlgRhcV6Hf/bFcJ7xdAHhFIDepXseg2RKrC8Jkc7tt7hEHXCcBEIy7
         4RU2zAoo1AKnC2j/DnU2i05H6Fq7OfaAyV+cMCayLmYzUiDUfdGiJ6+zW4xHTqdD2ec3
         YSyxWJ54BbK/18944JbqM5kyUp6/Mdjm8i700dTFrgPJZoOVk1JZYGQPa94rrfyLc2gr
         Ds/lCQbGJLgCuc6X1zq6zgiKO1qFdAHYXhYau1OZ9VjN5ouQm/apReKCYj+jXaTImBza
         Xziw==
X-Gm-Message-State: AOJu0YyDypSXJisDfcVZB8e3+gtkU2oZXF8QtQufE1/UGSJvs7x8ZXX8
	LXw5JLvsbqZOjCy3dz+byJPXIYpxzb2PqLHnFaXaBRROG1/h9/BOIeFUh7susLxnW9hhpttg5VM
	5Vhg=
X-Google-Smtp-Source: AGHT+IG4nNl8NLkWyptttyOjJv5e8/6gL5vdyaS5k8cT6wp2uWJiNGzpKwk4N7atiVBD6rvmfaDxQQ==
X-Received: by 2002:a25:8745:0:b0:dcc:cadf:3376 with SMTP id e5-20020a258745000000b00dcccadf3376mr1118624ybn.18.1712277029082;
        Thu, 04 Apr 2024 17:30:29 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id o4-20020ac86d04000000b00432feda5986sm232728qtt.35.2024.04.04.17.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 17:30:28 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	tgamblin@baylibre.com,
	dlechner@baylibre.com
Subject: [RFC PATCH 1/3] pwm: add duty offset support
Date: Thu,  4 Apr 2024 20:30:23 -0400
Message-ID: <20240405003025.739603-2-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405003025.739603-1-tgamblin@baylibre.com>
References: <20240405003025.739603-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some PWM chips support a "phase" or "duty_offset" feature. This patch
continues adding support for configuring this property in the PWM
subsystem.

The pwm_chip struct gains a new supports_offset flag, which can be set
for compatible parts. This is checked in __pwm_apply, where attempts to
set duty_offset result in an EOPNOTSUPP if the flag is not set.

Functions duty_offset_show(), duty_offset_store(), and
pwm_get_duty_offset() are added to match what exists for duty_cycle.

Handle duty_offset in the new pwmchip char device logic.

Also add duty_offset to TP_printk in include/trace/events/pwm.h so that
it is reported with other properties when using the event tracing pipe
for debug.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/pwm/core.c         | 75 +++++++++++++++++++++++++++++++++++---
 include/linux/pwm.h        | 17 +++++++++
 include/trace/events/pwm.h |  6 ++-
 3 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 2745941a008b..0e05518feb21 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -80,6 +80,7 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 	 */
 	if (s1.enabled && s1.polarity != state->polarity) {
 		s2.polarity = state->polarity;
+		s2.duty_offset = s1.duty_cycle;
 		s2.duty_cycle = s1.period - s1.duty_cycle;
 		s2.period = s1.period;
 		s2.enabled = s1.enabled;
@@ -121,6 +122,23 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 			 state->duty_cycle, state->period,
 			 s2.duty_cycle, s2.period);
 
+	if (state->enabled &&
+	    last->polarity == state->polarity &&
+	    last->period == s2.period &&
+	    last->duty_offset > s2.duty_offset &&
+	    last->duty_offset <= state->duty_offset)
+		dev_warn(pwmchip_parent(chip),
+			 ".apply didn't pick the best available duty offset (requested: %llu/%llu, applied: %llu/%llu, possible: %llu/%llu)\n",
+			 state->duty_offset, state->period,
+			 s2.duty_offset, s2.period,
+			 last->duty_offset, last->period);
+
+	if (state->enabled && state->duty_offset < s2.duty_offset)
+		dev_warn(pwmchip_parent(chip),
+			 ".apply is supposed to round down duty_offset (requested: %llu/%llu, applied: %llu/%llu)\n",
+			 state->duty_offset, state->period,
+			 s2.duty_offset, s2.period);
+
 	if (!state->enabled && s2.enabled && s2.duty_cycle > 0)
 		dev_warn(pwmchip_parent(chip),
 			 "requested disabled, but yielded enabled with duty > 0\n");
@@ -144,12 +162,13 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 	if (s1.enabled != last->enabled ||
 	    s1.polarity != last->polarity ||
 	    (s1.enabled && s1.period != last->period) ||
+	    (s1.enabled && s1.duty_offset != last->duty_offset) ||
 	    (s1.enabled && s1.duty_cycle != last->duty_cycle)) {
 		dev_err(pwmchip_parent(chip),
-			".apply is not idempotent (ena=%d pol=%d %llu/%llu) -> (ena=%d pol=%d %llu/%llu)\n",
+			".apply is not idempotent (ena=%d pol=%d %llu/%llu/%llu) -> (ena=%d pol=%d %llu/%llu/%llu)\n",
 			s1.enabled, s1.polarity, s1.duty_cycle, s1.period,
-			last->enabled, last->polarity, last->duty_cycle,
-			last->period);
+			s1.duty_offset, last->enabled, last->polarity,
+			last->duty_cycle, last->period, last->duty_offset);
 	}
 }
 
@@ -164,13 +183,17 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
 	int err;
 
 	if (!pwm || !state || !state->period ||
-	    state->duty_cycle > state->period)
+	    state->duty_offset + state->duty_cycle > state->period)
 		return -EINVAL;
 
 	chip = pwm->chip;
 
+	if (!chip->supports_offset && state->duty_offset)
+		return -EOPNOTSUPP;
+
 	if (state->period == pwm->state.period &&
 	    state->duty_cycle == pwm->state.duty_cycle &&
+	    state->duty_offset == pwm->state.duty_offset &&
 	    state->polarity == pwm->state.polarity &&
 	    state->enabled == pwm->state.enabled &&
 	    state->usage_power == pwm->state.usage_power)
@@ -292,10 +315,11 @@ int pwm_adjust_config(struct pwm_device *pwm)
 	 * been configured.
 	 *
 	 * In either case, we setup the new period and polarity, and assign a
-	 * duty cycle of 0.
+	 * duty cycle and offset of 0.
 	 */
 	if (!state.period) {
 		state.duty_cycle = 0;
+		state.duty_offset = 0;
 		state.period = pargs.period;
 		state.polarity = pargs.polarity;
 
@@ -617,6 +641,41 @@ static ssize_t duty_cycle_store(struct device *pwm_dev,
 	return ret ? : size;
 }
 
+static ssize_t duty_offset_show(struct device *pwm_dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	const struct pwm_device *pwm = pwm_from_dev(pwm_dev);
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return sysfs_emit(buf, "%llu\n", state.duty_offset);
+}
+
+static ssize_t duty_offset_store(struct device *pwm_dev,
+				struct device_attribute *attr,
+				const char *buf, size_t size)
+{
+	struct pwm_export *export = pwmexport_from_dev(pwm_dev);
+	struct pwm_device *pwm = export->pwm;
+	struct pwm_state state;
+	u64 val;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&export->lock);
+	pwm_get_state(pwm, &state);
+	state.duty_offset = val;
+	ret = pwm_apply_might_sleep(pwm, &state);
+	mutex_unlock(&export->lock);
+
+	return ret ? : size;
+}
+
 static ssize_t enable_show(struct device *pwm_dev,
 			   struct device_attribute *attr,
 			   char *buf)
@@ -731,6 +790,7 @@ static ssize_t capture_show(struct device *pwm_dev,
 
 static DEVICE_ATTR_RW(period);
 static DEVICE_ATTR_RW(duty_cycle);
+static DEVICE_ATTR_RW(duty_offset);
 static DEVICE_ATTR_RW(enable);
 static DEVICE_ATTR_RW(polarity);
 static DEVICE_ATTR_RO(capture);
@@ -738,6 +798,7 @@ static DEVICE_ATTR_RO(capture);
 static struct attribute *pwm_attrs[] = {
 	&dev_attr_period.attr,
 	&dev_attr_duty_cycle.attr,
+	&dev_attr_duty_offset.attr,
 	&dev_attr_enable.attr,
 	&dev_attr_polarity.attr,
 	&dev_attr_capture.attr,
@@ -1290,7 +1351,7 @@ static long pwm_cdev_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 			if (state.enabled) {
 				cstate.period = state.period;
 				if (state.polarity == PWM_POLARITY_NORMAL) {
-					cstate.duty_offset = 0;
+					cstate.duty_offset = state.duty_offset;
 					cstate.duty_cycle = state.duty_cycle;
 				} else {
 					cstate.duty_offset = state.duty_cycle;
@@ -1356,6 +1417,7 @@ static long pwm_cdev_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 				state.period = cstate.period;
 				state.polarity = PWM_POLARITY_NORMAL;
 				state.duty_cycle = cstate.duty_cycle;
+				state.duty_offset = cstate.duty_offset;
 			} else {
 				state.enabled = false;
 			}
@@ -1991,6 +2053,7 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 
 		seq_printf(s, " period: %llu ns", state.period);
 		seq_printf(s, " duty: %llu ns", state.duty_cycle);
+		seq_printf(s, " duty_offset: %llu ns", state.duty_offset);
 		seq_printf(s, " polarity: %s",
 			   state.polarity ? "inverse" : "normal");
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index a58db7011807..e0e5960f91ba 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -51,6 +51,7 @@ enum {
  * struct pwm_state - state of a PWM channel
  * @period: PWM period (in nanoseconds)
  * @duty_cycle: PWM duty cycle (in nanoseconds)
+ * @duty_offset: PWM duty offset (in nanoseconds)
  * @polarity: PWM polarity
  * @enabled: PWM enabled status
  * @usage_power: If set, the PWM driver is only required to maintain the power
@@ -61,6 +62,7 @@ enum {
 struct pwm_state {
 	u64 period;
 	u64 duty_cycle;
+	u64 duty_offset;
 	enum pwm_polarity polarity;
 	bool enabled;
 	bool usage_power;
@@ -130,6 +132,15 @@ static inline u64 pwm_get_duty_cycle(const struct pwm_device *pwm)
 	return state.duty_cycle;
 }
 
+static inline u64 pwm_get_duty_offset(const struct pwm_device *pwm)
+{
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return state.duty_offset;
+}
+
 static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 {
 	struct pwm_state state;
@@ -161,6 +172,9 @@ static inline void pwm_get_args(const struct pwm_device *pwm,
  * ->duty_cycle value exceed the pwm_args->period one, which would trigger
  * an error if the user calls pwm_apply_might_sleep() without adjusting ->duty_cycle
  * first.
+ *
+ * ->duty_offset is likewise set to zero to avoid inconsistent default
+ *  states.
  */
 static inline void pwm_init_state(const struct pwm_device *pwm,
 				  struct pwm_state *state)
@@ -176,6 +190,7 @@ static inline void pwm_init_state(const struct pwm_device *pwm,
 	state->period = args.period;
 	state->polarity = args.polarity;
 	state->duty_cycle = 0;
+	state->duty_offset = 0;
 	state->usage_power = false;
 }
 
@@ -275,6 +290,7 @@ struct pwm_ops {
  * @npwm: number of PWMs controlled by this chip
  * @of_xlate: request a PWM device given a device tree PWM specifier
  * @atomic: can the driver's ->apply() be called in atomic context
+ * @supports_offset: does the driver support duty cycle offset
  * @uses_pwmchip_alloc: signals if pwmchip_allow was used to allocate this chip
  * @operational: signals if the chip can be used (or is already deregistered)
  * @nonatomic_lock: mutex for nonatomic chips
@@ -292,6 +308,7 @@ struct pwm_chip {
 	struct pwm_device * (*of_xlate)(struct pwm_chip *chip,
 					const struct of_phandle_args *args);
 	bool atomic;
+	bool supports_offset;
 
 	/* only used internally by the PWM framework */
 	bool uses_pwmchip_alloc;
diff --git a/include/trace/events/pwm.h b/include/trace/events/pwm.h
index 12b35e4ff917..2d25ac5de816 100644
--- a/include/trace/events/pwm.h
+++ b/include/trace/events/pwm.h
@@ -18,6 +18,7 @@ DECLARE_EVENT_CLASS(pwm,
 		__field(struct pwm_device *, pwm)
 		__field(u64, period)
 		__field(u64, duty_cycle)
+		__field(u64, duty_offset)
 		__field(enum pwm_polarity, polarity)
 		__field(bool, enabled)
 		__field(int, err)
@@ -27,13 +28,14 @@ DECLARE_EVENT_CLASS(pwm,
 		__entry->pwm = pwm;
 		__entry->period = state->period;
 		__entry->duty_cycle = state->duty_cycle;
+		__entry->duty_offset = state->duty_offset;
 		__entry->polarity = state->polarity;
 		__entry->enabled = state->enabled;
 		__entry->err = err;
 	),
 
-	TP_printk("%p: period=%llu duty_cycle=%llu polarity=%d enabled=%d err=%d",
-		  __entry->pwm, __entry->period, __entry->duty_cycle,
+	TP_printk("%p: period=%llu duty_cycle=%llu duty_offset=%llu polarity=%d enabled=%d err=%d",
+		  __entry->pwm, __entry->period, __entry->duty_cycle, __entry->duty_offset,
 		  __entry->polarity, __entry->enabled, __entry->err)
 
 );
-- 
2.44.0


