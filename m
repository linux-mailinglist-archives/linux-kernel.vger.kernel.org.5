Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323E27F00E6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 17:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjKRQRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 11:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKRQRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 11:17:21 -0500
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C326131;
        Sat, 18 Nov 2023 08:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1700324236; bh=rw3yuZwRM4coXuFSWdAAB0AmFnrEdMRGbfIK2PGnYcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p3ifLUBHx2skFL5K16Z4/gAHjW+i3efpWR8WSkqBXoYKe33f7MAaQN5MX8ei12qeZ
         8M5pJxqIjXFDpAchtk2uy1LevMT5rK9sTllAhkNw4sbnnG+tY8EkgUyIbZ91M7f9MT
         mLiVVtGyjBPuyMChx1r19OxjtebNfd8LPQiGdFHa7/krZECmGA7jqY+4zlJao3awAO
         U+ITsLzJh3C3BZHdKc8NG/QwNpK4e7r+X/WGspuAydT+0v5CnQ0/wMQo6MHC4nDDfq
         ykT/syEX1AQiHJnRrCAkwq8MbuNhbQG8dDBdQfqlc/Bx+4//mNH01inUPghP4izk5r
         E448EL6FSGGTg==
Received: by gofer.mess.org (Postfix, from userid 501)
        id 7B5EB1002A7; Sat, 18 Nov 2023 16:17:16 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1700324200; bh=rw3yuZwRM4coXuFSWdAAB0AmFnrEdMRGbfIK2PGnYcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Evr2he8N3kI99w8fPKRGXo9YPqtS7KsKX4jriXsRmjDQwKJMlswbVi30sqNpB8Ryn
         n4gp6+oyAOBuChoOY9LXOZFPb8Zjz46TG2yxTHQ8zynvAT/kBzTcPZIwEVVYb7EKnF
         pD58UR3I9yx7bBykX+ECFlN/fYfAAamy6dz4D9WSSrJb5FdAlRMHBdT3TZtuYWe3j9
         jIDAwWzM/FpaGii51c36P6X+o39kjzEUySKUiS3634QnMUPrfZv6HsLVr2sklFy9hM
         KV4ifkOZeT5quxu22dhdk0bVFlmYRHGrE4Ss8JIlRDXZ/hIC7d9+Qd5Zy5J3igU1ZF
         NMTPGu1ayVBmw==
Received: from bigcore.mess.org (bigcore-239.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by gofer.mess.org (Postfix) with ESMTPSA id C0A39100100;
        Sat, 18 Nov 2023 16:16:40 +0000 (GMT)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc:     Sean Young <sean@mess.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] pwm: make it possible to apply pwm changes in atomic context
Date:   Sat, 18 Nov 2023 16:16:18 +0000
Message-ID: <ab49d3c11dd3fa432459cc8e11a77127f1a803dd.1700323916.git.sean@mess.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1700323916.git.sean@mess.org>
References: <cover.1700323916.git.sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some pwm devices require sleeping, for example if the pwm device is
connected over i2c. However, many pwm devices could be used from atomic
context, e.g. memmory mapped pwm. This is useful for, for example, the
pwm-ir-tx driver which requires precise timing. Sleeping causes havoc
with the generated IR signal.

Since not all pmw devices can support atomic context, we also add a
pwm_is_atomic() function to check if it is supported.

Signed-off-by: Sean Young <sean@mess.org>
---
 Documentation/driver-api/pwm.rst |  9 +++++
 drivers/pwm/core.c               | 63 ++++++++++++++++++++++++++------
 drivers/pwm/pwm-renesas-tpu.c    |  1 -
 include/linux/pwm.h              | 29 ++++++++++++++-
 4 files changed, 87 insertions(+), 15 deletions(-)

diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index 5f6d1540dcd7e..921d1306e5932 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -43,6 +43,15 @@ After being requested, a PWM has to be configured using::
 
 	int pwm_apply_cansleep(struct pwm_device *pwm, struct pwm_state *state);
 
+Some PWM devices can be used from atomic context. You can check if this is
+supported with::
+
+        bool pwm_is_atomic(struct pwm_device *pwm);
+
+If true, the PWM can be configured from atomic context with::
+
+	int pwm_apply_atomic(struct pwm_device *pwm, struct pwm_state *state);
+
 This API controls both the PWM period/duty_cycle config and the
 enable/disable state.
 
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 928531c34f481..84a849a69b347 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -463,24 +463,15 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 }
 
 /**
- * pwm_apply_cansleep() - atomically apply a new state to a PWM device
+ * pwm_apply_unchecked() - atomically apply a new state to a PWM device
  * @pwm: PWM device
  * @state: new state to apply
  */
-int pwm_apply_cansleep(struct pwm_device *pwm, const struct pwm_state *state)
+static int pwm_apply_unchecked(struct pwm_device *pwm, const struct pwm_state *state)
 {
 	struct pwm_chip *chip;
 	int err;
 
-	/*
-	 * Some lowlevel driver's implementations of .apply() make use of
-	 * mutexes, also with some drivers only returning when the new
-	 * configuration is active calling pwm_apply_cansleep() from atomic context
-	 * is a bad idea. So make it explicit that calling this function might
-	 * sleep.
-	 */
-	might_sleep();
-
 	if (!pwm || !state || !state->period ||
 	    state->duty_cycle > state->period)
 		return -EINVAL;
@@ -501,16 +492,64 @@ int pwm_apply_cansleep(struct pwm_device *pwm, const struct pwm_state *state)
 
 	pwm->state = *state;
 
+	return 0;
+}
+
+/**
+ * pwm_apply_cansleep() - atomically apply a new state to a PWM device
+ * Cannot be used in atomic context.
+ * @pwm: PWM device
+ * @state: new state to apply
+ */
+int pwm_apply_cansleep(struct pwm_device *pwm, const struct pwm_state *state)
+{
+	int err;
+
+	/*
+	 * Some lowlevel driver's implementations of .apply() make use of
+	 * mutexes, also with some drivers only returning when the new
+	 * configuration is active calling pwm_apply_cansleep() from atomic context
+	 * is a bad idea. So make it explicit that calling this function might
+	 * sleep.
+	 */
+	might_sleep();
+
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm->chip->atomic) {
+		/*
+		 * Catch any sleeping drivers when atomic is set.
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
 EXPORT_SYMBOL_GPL(pwm_apply_cansleep);
 
+/**
+ * pwm_apply_atomic() - apply a new state to a PWM device from atomic context
+ * Not all pwm devices support this function, check with pwm_is_atomic().
+ * @pwm: PWM device
+ * @state: new state to apply
+ */
+int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state)
+{
+	WARN_ONCE(!pwm->chip->atomic,
+		  "sleeping pwm driver used in atomic context");
+
+	return pwm_apply_unchecked(pwm, state);
+}
+EXPORT_SYMBOL_GPL(pwm_apply_atomic);
+
 /**
  * pwm_capture() - capture and report a PWM signal
  * @pwm: PWM device
diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 4239f2c3e8b2a..47ea92cd8c67f 100644
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
index c4b066f7c5097..495aba06c64c3 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -286,6 +286,7 @@ struct pwm_ops {
  * @npwm: number of PWMs controlled by this chip
  * @of_xlate: request a PWM device given a device tree PWM specifier
  * @of_pwm_n_cells: number of cells expected in the device tree PWM specifier
+ * @atomic: can the driver execute pwm_apply_cansleep in atomic context
  * @list: list node for internal use
  * @pwms: array of PWM devices allocated by the framework
  */
@@ -299,6 +300,7 @@ struct pwm_chip {
 	struct pwm_device * (*of_xlate)(struct pwm_chip *chip,
 					const struct of_phandle_args *args);
 	unsigned int of_pwm_n_cells;
+	bool atomic;
 
 	/* only used internally by the PWM framework */
 	struct list_head list;
@@ -308,6 +310,7 @@ struct pwm_chip {
 #if IS_ENABLED(CONFIG_PWM)
 /* PWM user APIs */
 int pwm_apply_cansleep(struct pwm_device *pwm, const struct pwm_state *state);
+int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state);
 int pwm_adjust_config(struct pwm_device *pwm);
 
 /**
@@ -378,6 +381,17 @@ static inline void pwm_disable(struct pwm_device *pwm)
 	pwm_apply_cansleep(pwm, &state);
 }
 
+/**
+ * pwm_is_atomic() - is pwm_apply_atomic() supported?
+ * @pwm: PWM device
+ *
+ * Returns: true pwm_apply_atomic() can be called from atomic context.
+ */
+static inline bool pwm_is_atomic(struct pwm_device *pwm)
+{
+	return pwm->chip->atomic;
+}
+
 /* PWM provider APIs */
 int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 		unsigned long timeout);
@@ -406,16 +420,27 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
 				       struct fwnode_handle *fwnode,
 				       const char *con_id);
 #else
+static inline bool pwm_is_atomic(struct pwm_device *pwm)
+{
+	return false;
+}
+
 static inline int pwm_apply_cansleep(struct pwm_device *pwm,
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
2.42.1

