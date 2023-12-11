Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C244080C304
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjLKIZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjLKIZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:25:21 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63ABE5;
        Mon, 11 Dec 2023 00:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1702283125; bh=7UH+oSSqKJIJniMZRwAXNQdXab/8KZ6Hy7de6PhiNtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+KcQeeAW9UCaPgpNNSD/mpgie0yfdcX/ieZ+CdlXo1aRzVOK13P8GjHBp8dP10Pd
         rJloVTABVsk/jV+rmqeytOU9HOsYeHgUWUG3sOuw7ioP5Kuhh8t+5FwMgJ/AhfXYFN
         cT/V0BJq3Yo/kji3775LVXcQGyRk/m4R/Fw9FFMWJ/gby8RwIXmwLq+V3HRLa2KSo1
         jnkvGFFAXRrwbk4ybukEFwqvFFi07TXFKepW7xuGlR468QCaXgPaTAhPiKcpvRXIwu
         v2sd82JFV8TjzJ19bI8qthuwzEHM7K21X3wXqTtjC1+6PzBOwbEuMiF5Oe+5cUBco3
         UsvBjjhw3gxyQ==
Received: by gofer.mess.org (Postfix, from userid 501)
        id 0D4E8100A08; Mon, 11 Dec 2023 08:25:25 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1702283109; bh=7UH+oSSqKJIJniMZRwAXNQdXab/8KZ6Hy7de6PhiNtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NXte5TjmDav3bRBaL1uvFZCTblYaeo3nLqnA7IlQpgQLnW2MVhLBYMSfPQ/c/WDmD
         gDF4+QzXtOoyH6UXia6IEPuaDYWr9ZMVRws+GjA746TuhjALfLRCbFUd/pjd3CGPj/
         +aWzdkxAyLiCNVvGnUB6oEB1HVuQ1aOg/Xm++nF9dszORAPub6eo+sYVjBAGTWXggn
         W6qJvmrHTqfHzy8y1XdElVx/jdilf3CRTE3rR0PJOfDmNfa73N6DAysmPwDc43KaFE
         5lkkSnOTBH2wu68zYJUnYcSrufDHiMCxDq83Y32lWvCzmcdM8YwNJR6QLd00j6ffHb
         zJElHImT8hh2g==
Received: from localhost.localdomain (bigcore.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by gofer.mess.org (Postfix) with ESMTPSA id 3AA5A10005E;
        Mon, 11 Dec 2023 08:25:09 +0000 (GMT)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc:     Sean Young <sean@mess.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/4] pwm: Make it possible to apply PWM changes in atomic context
Date:   Mon, 11 Dec 2023 08:24:53 +0000
Message-ID: <aacf0081cbc36d6b21cbc207e40b6df54953214d.1702282807.git.sean@mess.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702282806.git.sean@mess.org>
References: <cover.1702282806.git.sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/pwm/core.c               | 64 ++++++++++++++++++++++++++------
 drivers/pwm/pwm-renesas-tpu.c    |  1 -
 include/linux/pwm.h              | 29 ++++++++++++++-
 5 files changed, 89 insertions(+), 16 deletions(-)

diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index f1d8197c8c430..3c28ccc4b6113 100644
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
index c2a9e0b5594e7..b55ac220b923d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17585,7 +17585,7 @@ F:	drivers/video/backlight/pwm_bl.c
 F:	include/dt-bindings/pwm/
 F:	include/linux/pwm.h
 F:	include/linux/pwm_backlight.h
-K:	pwm_(config|apply_might_sleep|ops)
+K:	pwm_(config|apply_might_sleep|apply_atomic|ops)
 
 PXA GPIO DRIVER
 M:	Robert Jarzmik <robert.jarzmik@free.fr>
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c2d78136625d5..5fd35cda5786b 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -433,24 +433,15 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 }
 
 /**
- * pwm_apply_might_sleep() - atomically apply a new state to a PWM device
+ * pwm_apply_unchecked() - atomically apply a new state to a PWM device
  * @pwm: PWM device
  * @state: new state to apply
  */
-int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
+static int pwm_apply_unchecked(struct pwm_device *pwm, const struct pwm_state *state)
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
@@ -471,16 +462,65 @@ int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
 
 	pwm->state = *state;
 
+	return 0;
+}
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
+		err = pwm_apply_unchecked(pwm, state);
+		non_block_end();
+	} else {
+		err = pwm_apply_unchecked(pwm, state);
+	}
+
 	/*
 	 * only do this after pwm->state was applied as some
 	 * implementations of .get_state depend on this
 	 */
 	pwm_apply_debug(pwm, state);
 
-	return 0;
+	return err;
 }
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
+		  "sleeping PWM driver used in atomic context");
+
+	return pwm_apply_unchecked(pwm, state);
+}
+EXPORT_SYMBOL_GPL(pwm_apply_atomic);
+
 /**
  * pwm_capture() - capture and report a PWM signal
  * @pwm: PWM device
diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index ce92db1f85113..28265fdfc92a9 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index b64b8a82415c4..495af3627939c 100644
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
@@ -403,16 +417,27 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
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
 	might_sleep();
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
+}
+
+static inline int pwm_apply_atomic(struct pwm_device *pwm,
+				   const struct pwm_state *state)
+{
+	return -EOPNOTSUPP;
 }
 
 static inline int pwm_adjust_config(struct pwm_device *pwm)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
-- 
2.43.0

