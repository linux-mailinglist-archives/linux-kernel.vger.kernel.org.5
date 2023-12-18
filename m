Return-Path: <linux-kernel+bounces-3216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C50816957
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665C51C225FF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610AC134CB;
	Mon, 18 Dec 2023 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="FOxTn7/a";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="I4H5flPJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D71111C95;
	Mon, 18 Dec 2023 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702890438; bh=nq08shY4F84JWnlQ3SSHlueQDTZg9R3tBoXVvnOsM60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FOxTn7/aDUtOeUOzjNz5FSNs+NWeUi6NUfYs9zTgeX0pU5cBCoTQK9FdfleLSjnwD
	 fbUwRl47+2NyCUkSQAOE0WOTkJzEzQUyFXrPMtAMj4THzT0KkuUfuI04FYP3Y/u8RB
	 IuJoDUgsEGm5xj1cFNvWtu7UegW7goaz8qy+v8664SNhan7jmFKGf2xm0KMcC/PVIF
	 dirRu4u/7l2SGwFqg6ht/U45BP5W93sSgmPKNXih/H6K/8h69zgL+3or5kDjkHjvA3
	 CuLS5evuFQZQ+41yRYPCh0XbcMdhFAk5LiAFarMrMgXFmeM1s1r2a517ucmk1mjH9n
	 vT+kd8Se9csrA==
Received: by gofer.mess.org (Postfix, from userid 501)
	id 1A937100A09; Mon, 18 Dec 2023 09:07:18 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702890420; bh=nq08shY4F84JWnlQ3SSHlueQDTZg9R3tBoXVvnOsM60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I4H5flPJJAIwcRSTQGENETb9ftnG6shx2tMwk799sk5aFg+eehZcD45atMqdSani+
	 ZIFR8g+2jRJ5d2LRNykgt2wh68Wi7Bmrzg4CngsbL8YdfraNfQztKEfJV5Lvm6xB5H
	 p4q8pjE/edXZFixXIbuF/1Nrq3OpiOKhw7mWqObWKCde+sOJcrgnVlw+EdzizgUMQi
	 yzdSzBT0rNXkoFfcoGMpNUyFa11roD+IvLCh6uVBqGOEJwAu3xfl7vAEpUJ4EU/ikx
	 VjivjpQXOs2lbI8A+sffdR8AbBCmC7ixpCx5SoA4fciN21UNzowdVUboLewc8lueRy
	 n5EvfsdZ9WVsw==
Received: from localhost.localdomain (bigcore-79.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id B65781002A3;
	Mon, 18 Dec 2023 09:07:00 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Sean Young <sean@mess.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 4/6] pwm: Make it possible to apply PWM changes in atomic context
Date: Mon, 18 Dec 2023 09:06:45 +0000
Message-ID: <2a08b7876059f30c5c081d02978876022fa8d3ea.1702890244.git.sean@mess.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702890244.git.sean@mess.org>
References: <cover.1702890244.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some PWM devices require sleeping, for example if the pwm device is
connected over I2C. However, many PWM devices could be used from atomic
context, e.g. memory mapped PWM. This is useful for, for example, the
pwm-ir-tx driver which requires precise timing. Sleeping causes havoc
with the generated IR signal.

Since not all PWM devices can support atomic context, we also add a
pwm_might_sleep() function to check if is not supported.

Signed-off-by: Sean Young <sean@mess.org>
---
 Documentation/driver-api/pwm.rst |  9 +++++
 MAINTAINERS                      |  2 +-
 drivers/pwm/core.c               | 62 ++++++++++++++++++++++++++------
 include/linux/pwm.h              | 25 +++++++++++++
 4 files changed, 86 insertions(+), 12 deletions(-)

diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index f1d8197c8c43..3c28ccc4b611 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -46,6 +46,15 @@ After being requested, a PWM has to be configured using::
 This API controls both the PWM period/duty_cycle config and the
 enable/disable state.
 
+PWM devices can be used from atomic context, if the PWM does not sleep. You
+can check if this the case with::
+
+        bool pwm_might_sleep(struct pwm_device *pwm);
+
+If false, the PWM can also be configured from atomic context with::
+
+	int pwm_apply_atomic(struct pwm_device *pwm, struct pwm_state *state);
+
 As a consumer, don't rely on the output's state for a disabled PWM. If it's
 easily possible, drivers are supposed to emit the inactive state, but some
 drivers cannot. If you rely on getting the inactive state, use .duty_cycle=0,
diff --git a/MAINTAINERS b/MAINTAINERS
index c58480595220..5342cf32d73f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17576,7 +17576,7 @@ F:	drivers/video/backlight/pwm_bl.c
 F:	include/dt-bindings/pwm/
 F:	include/linux/pwm.h
 F:	include/linux/pwm_backlight.h
-K:	pwm_(config|apply_might_sleep|ops)
+K:	pwm_(config|apply_might_sleep|apply_atomic|ops)
 
 PXA GPIO DRIVER
 M:	Robert Jarzmik <robert.jarzmik@free.fr>
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c2d78136625d..39bfc8b52294 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -433,24 +433,15 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 }
 
 /**
- * pwm_apply_might_sleep() - atomically apply a new state to a PWM device
+ * __pwm_apply() - atomically apply a new state to a PWM device
  * @pwm: PWM device
  * @state: new state to apply
  */
-int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
+static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
 {
 	struct pwm_chip *chip;
 	int err;
 
-	/*
-	 * Some lowlevel driver's implementations of .apply() make use of
-	 * mutexes, also with some drivers only returning when the new
-	 * configuration is active calling pwm_apply_might_sleep() from atomic context
-	 * is a bad idea. So make it explicit that calling this function might
-	 * sleep.
-	 */
-	might_sleep();
-
 	if (!pwm || !state || !state->period ||
 	    state->duty_cycle > state->period)
 		return -EINVAL;
@@ -479,8 +470,57 @@ int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
 
 	return 0;
 }
+
+/**
+ * pwm_apply_might_sleep() - atomically apply a new state to a PWM device
+ * Cannot be used in atomic context.
+ * @pwm: PWM device
+ * @state: new state to apply
+ */
+int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
+{
+	int err;
+
+	/*
+	 * Some lowlevel driver's implementations of .apply() make use of
+	 * mutexes, also with some drivers only returning when the new
+	 * configuration is active calling pwm_apply_might_sleep() from atomic context
+	 * is a bad idea. So make it explicit that calling this function might
+	 * sleep.
+	 */
+	might_sleep();
+
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm->chip->atomic) {
+		/*
+		 * Catch any drivers that have been marked as atomic but
+		 * that will sleep anyway.
+		 */
+		non_block_start();
+		err = __pwm_apply(pwm, state);
+		non_block_end();
+	} else {
+		err = __pwm_apply(pwm, state);
+	}
+
+	return err;
+}
 EXPORT_SYMBOL_GPL(pwm_apply_might_sleep);
 
+/**
+ * pwm_apply_atomic() - apply a new state to a PWM device from atomic context
+ * Not all PWM devices support this function, check with pwm_might_sleep().
+ * @pwm: PWM device
+ * @state: new state to apply
+ */
+int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state)
+{
+	WARN_ONCE(!pwm->chip->atomic,
+		  "sleeping PWM driver used in atomic context\n");
+
+	return __pwm_apply(pwm, state);
+}
+EXPORT_SYMBOL_GPL(pwm_apply_atomic);
+
 /**
  * pwm_capture() - capture and report a PWM signal
  * @pwm: PWM device
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index c9cb87b59ac8..495af3627939 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -285,6 +285,7 @@ struct pwm_ops {
  * @npwm: number of PWMs controlled by this chip
  * @of_xlate: request a PWM device given a device tree PWM specifier
  * @of_pwm_n_cells: number of cells expected in the device tree PWM specifier
+ * @atomic: can the driver's ->apply() be called in atomic context
  * @pwms: array of PWM devices allocated by the framework
  */
 struct pwm_chip {
@@ -297,6 +298,7 @@ struct pwm_chip {
 	struct pwm_device * (*of_xlate)(struct pwm_chip *chip,
 					const struct of_phandle_args *args);
 	unsigned int of_pwm_n_cells;
+	bool atomic;
 
 	/* only used internally by the PWM framework */
 	struct pwm_device *pwms;
@@ -305,6 +307,7 @@ struct pwm_chip {
 #if IS_ENABLED(CONFIG_PWM)
 /* PWM user APIs */
 int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state);
+int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state);
 int pwm_adjust_config(struct pwm_device *pwm);
 
 /**
@@ -375,6 +378,17 @@ static inline void pwm_disable(struct pwm_device *pwm)
 	pwm_apply_might_sleep(pwm, &state);
 }
 
+/**
+ * pwm_might_sleep() - is pwm_apply_atomic() supported?
+ * @pwm: PWM device
+ *
+ * Returns: false if pwm_apply_atomic() can be called from atomic context.
+ */
+static inline bool pwm_might_sleep(struct pwm_device *pwm)
+{
+	return !pwm->chip->atomic;
+}
+
 /* PWM provider APIs */
 int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 		unsigned long timeout);
@@ -403,6 +417,11 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
 				       struct fwnode_handle *fwnode,
 				       const char *con_id);
 #else
+static inline bool pwm_might_sleep(struct pwm_device *pwm)
+{
+	return true;
+}
+
 static inline int pwm_apply_might_sleep(struct pwm_device *pwm,
 					const struct pwm_state *state)
 {
@@ -410,6 +429,12 @@ static inline int pwm_apply_might_sleep(struct pwm_device *pwm,
 	return -EOPNOTSUPP;
 }
 
+static inline int pwm_apply_atomic(struct pwm_device *pwm,
+				   const struct pwm_state *state)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int pwm_adjust_config(struct pwm_device *pwm)
 {
 	return -EOPNOTSUPP;
-- 
2.43.0


