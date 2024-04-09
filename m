Return-Path: <linux-kernel+bounces-137415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C3589E1B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABBB285E9F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A1A156C45;
	Tue,  9 Apr 2024 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Hq2H/Rx3"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C98B15667F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712684494; cv=none; b=gT5wW1Us7SdPFT7rJTito5l47I/+psSM6xrI+TtaOxqKFJ5IiaVHNr7zXWInrmBh4Zek49p8y/c78Ece2gFanbwcOcxcKbBa20F8hYJbYgml1ArHBj1e/rG+kvfajsmhk+k9Z67RZYgay5OUAj0zYQw42yKcudWm5gfazJJ9yIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712684494; c=relaxed/simple;
	bh=RilpHuz1rOpP5hbcbVR5vakwIvylnnUqUlIz+07gEUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAo0gHMIwcQ5D94QHGNkF3tcJAUcU0EH+B80+pEg1MRwlBRRPaXTNgobJ7RaRbm/LiFGpsDeRN1g/T0IoVo/z7kfHk3aKqMciR4Y/20kRz7KxHksFkY2ubXr5Lzk+Vd6H8u85oX9jOvL/1c/ykXKtg55nYTyg3iQdiACJi5DAlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Hq2H/Rx3; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7e4017dc13fso1861209241.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712684489; x=1713289289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VujH6vvpkYtnRus7wB9qrV/4NI4JW4G35KZtTaghVu0=;
        b=Hq2H/Rx3YwZLs37x3dtFSbZ5LK/BSxhSrmYqfAuI0J+f4tNkT/q9Itn1ztGvf7J0rL
         G/90d+nfAK0DbxdKijKEPqykz5bRwruj5jSiuQnwcWvHaCaz02iJuLQxyLeW+pCeSyyo
         oEwksTSFdzX8mCmiVTaJAnm6F5gxb3+RxPPG54haZ6ujVs7jUPqpwyTf5ex49dksCnEM
         i5N2h8XQzQoTV1d/R8HF8zZnGkofLSWexpIk6CTYzRayZ45IGSj6WmFwUSXW8eoGmQDI
         ZDt87FuAtVoEhNzfLEoO0NMzmIK4HLsejJ5K4BGjUryUIR3fwBOW+EnZ0U0dpxSdwdu9
         ELOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712684489; x=1713289289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VujH6vvpkYtnRus7wB9qrV/4NI4JW4G35KZtTaghVu0=;
        b=fR6LUrIpUDzfo0pKOLyjx9rCbMY7LXztS+3cvLJn1wImtQwvZZn9VOVg/cGfzdwyLn
         0H1atFbURYHcNnbAOOTJAg9c083SpRAZx0AH0soykraIKCl8wDehWsYXZ0w5QA2zn62I
         teHMgK75s39rK2odgw/u+hhp3pF/Ut54LUW6kPAo6pwKfO/O5FdKS3ybGIXWv2shHon3
         R8a1u+Bm2b2R9ZUSVbHIip7olVY/GmxerZ/LDQGSfMjQyTnL1ZH45wIbbBo4DHAcVAJr
         DAlXAICfuO0YbBb/hj5302nRQYYLW9CFEXJHXKDHFYYTxiw7tqtgbtOGY6z5+CmQKYdn
         NPfw==
X-Gm-Message-State: AOJu0YwzUrns9pQ69ChFHKUh9CQcVWrncxNSb2I+azfN78tgBdvujQhn
	mPiOq5a8X5rlA95bOgRRUH+91IoS6WRD+WfRrKnQFiZq+v9rfhRY5/ioOHDxWJ8=
X-Google-Smtp-Source: AGHT+IGXl4DEIRR++UUy1zfJE5z+n5y5S8EbOS9plz8t589kE27fdzx1oxiNqnupEqKrMePyD3MP0A==
X-Received: by 2002:a05:6122:926:b0:4da:a9d8:f719 with SMTP id j38-20020a056122092600b004daa9d8f719mr660605vka.4.1712684489127;
        Tue, 09 Apr 2024 10:41:29 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id o11-20020a0ce40b000000b00699437d4dfbsm3828996qvl.72.2024.04.09.10.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 10:41:28 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	tgamblin@baylibre.com,
	dlechner@baylibre.com
Subject: [PATCH 1/2 v2] pwm: add duty offset support
Date: Tue,  9 Apr 2024 13:41:25 -0400
Message-ID: <20240409174126.1296318-2-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409174126.1296318-1-tgamblin@baylibre.com>
References: <20240409174126.1296318-1-tgamblin@baylibre.com>
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

Functions duty_offset_show(), duty_offset_store(), and
pwm_get_duty_offset() are added to match what exists for duty_cycle.

Handle duty_offset in the new pwmchip char device logic.

Add a check to disallow applying a state with both inversed polarity and
a nonzero duty_offset.

Also add duty_offset to TP_printk in include/trace/events/pwm.h so that
it is reported with other properties when using the event tracing pipe
for debug.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
v2 changes:
* Address feedback in v1:
  * Remove supports_offset flag in pwm_chip struct
  * Don't return EINVAL when state->duty_offset + state->duty_cycle >
    state->period in __pwm_apply(), since this is valid as long as
    neither is greater than state->period on its own
  * Add a check to disallow setting the PWM signal as inverse and a
    nonzero duty_offset at the same time in __pwm_apply(), with a
    comment explaining why

---
 drivers/pwm/core.c         | 82 +++++++++++++++++++++++++++++++++++---
 include/linux/pwm.h        | 15 +++++++
 include/trace/events/pwm.h |  6 ++-
 3 files changed, 95 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 2745941a008b..0d12cce67be7 100644
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
 
@@ -164,13 +183,24 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
 	int err;
 
 	if (!pwm || !state || !state->period ||
-	    state->duty_cycle > state->period)
+	    state->duty_cycle > state->period ||
+	    state->duty_offset > state->period)
 		return -EINVAL;
 
 	chip = pwm->chip;
 
+	/* 
+	 * There is no need to set duty_offset with inverse polarity,
+	 * since signals with duty_offset values greater than 0.5 *
+	 * period can equivalently be represented by an inverted signal
+	 * without offset.
+	 */
+	if (state->polarity == PWM_POLARITY_INVERSED && state->duty_offset)
+		return -EINVAL;
+
 	if (state->period == pwm->state.period &&
 	    state->duty_cycle == pwm->state.duty_cycle &&
+	    state->duty_offset == pwm->state.duty_offset &&
 	    state->polarity == pwm->state.polarity &&
 	    state->enabled == pwm->state.enabled &&
 	    state->usage_power == pwm->state.usage_power)
@@ -292,10 +322,11 @@ int pwm_adjust_config(struct pwm_device *pwm)
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
 
@@ -617,6 +648,41 @@ static ssize_t duty_cycle_store(struct device *pwm_dev,
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
@@ -731,6 +797,7 @@ static ssize_t capture_show(struct device *pwm_dev,
 
 static DEVICE_ATTR_RW(period);
 static DEVICE_ATTR_RW(duty_cycle);
+static DEVICE_ATTR_RW(duty_offset);
 static DEVICE_ATTR_RW(enable);
 static DEVICE_ATTR_RW(polarity);
 static DEVICE_ATTR_RO(capture);
@@ -738,6 +805,7 @@ static DEVICE_ATTR_RO(capture);
 static struct attribute *pwm_attrs[] = {
 	&dev_attr_period.attr,
 	&dev_attr_duty_cycle.attr,
+	&dev_attr_duty_offset.attr,
 	&dev_attr_enable.attr,
 	&dev_attr_polarity.attr,
 	&dev_attr_capture.attr,
@@ -1290,7 +1358,7 @@ static long pwm_cdev_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 			if (state.enabled) {
 				cstate.period = state.period;
 				if (state.polarity == PWM_POLARITY_NORMAL) {
-					cstate.duty_offset = 0;
+					cstate.duty_offset = state.duty_offset;
 					cstate.duty_cycle = state.duty_cycle;
 				} else {
 					cstate.duty_offset = state.duty_cycle;
@@ -1356,6 +1424,7 @@ static long pwm_cdev_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 				state.period = cstate.period;
 				state.polarity = PWM_POLARITY_NORMAL;
 				state.duty_cycle = cstate.duty_cycle;
+				state.duty_offset = cstate.duty_offset;
 			} else {
 				state.enabled = false;
 			}
@@ -1991,6 +2060,7 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 
 		seq_printf(s, " period: %llu ns", state.period);
 		seq_printf(s, " duty: %llu ns", state.duty_cycle);
+		seq_printf(s, " duty_offset: %llu ns", state.duty_offset);
 		seq_printf(s, " polarity: %s",
 			   state.polarity ? "inverse" : "normal");
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index a58db7011807..5a93212c58eb 100644
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


