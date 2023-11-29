Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C167FD1DD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjK2JOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjK2JOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:14:01 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E27B85;
        Wed, 29 Nov 2023 01:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1701249245; bh=zNR+aeImCqAdRkG1SvWjFV213n3uXznj5mE4jh4HySc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CuHPQxsXUGaKs/8k++KjAvqrzI3IsoTd3WM9JtvHeTsv1dqTsTnMwFKj73shnVSm8
         5YeV9jDzfeGU5IzkGlQw6duLT8fop9etVzyZdJ/JBLF3Y0jrl+ux2TFYAN+2eHRLPn
         lxErSTkyOQhBCRYku9uPxGqm8llZ01dhogKxKCz6gzMXEytuVoWNk5p6hvNEFIagqx
         ZCL1Z1U9MgkMjM3uuudpMmgL9EEKgsPo0gHythcF4L6DTYYlTVMBmoVYGSmveQKSmA
         r6BMJG169z8WvIXiQt/R9sdvVUdOlBo5DMCJwZmaMbZXYDkY8TCwMLZCTzwc6A4seq
         z6OS4XABxmdmQ==
Received: by gofer.mess.org (Postfix, from userid 501)
        id DD3FF1002A1; Wed, 29 Nov 2023 09:14:05 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1701249229; bh=zNR+aeImCqAdRkG1SvWjFV213n3uXznj5mE4jh4HySc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=doe8Ar56WbfOP+pS0zqAvmNsHGwT7YJ6Fq2bEBB88u/GrPgCFg3nkzFsMehxdDQAF
         /TIqPGGXemrQNXym/cg/iFcV2SF3UP4W29gyoPYISW4/6QQHlCrJw8mnp2iGVr6Zt3
         1Rv06crl+cgpqtI44MQ7Ov4sBNUmoFJDMpMpBU3zotu8BBfQkqbfKpTMd96kQQFQ9d
         3m3RBhLkYAPy80lCOaN0FNBNLWaY5NWhTCnpLW+4YPazu+mA3E2sU3CGqxkCrffWix
         OheST9d8b1BiKkBZwBbboXRDvqveczloTlyrofZEKZVYhdizLbukRtZWj2Iky5fcrr
         QU3wdpYVy2rVA==
Received: from localhost.localdomain (bigcore-99.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by gofer.mess.org (Postfix) with ESMTPSA id 13354100064;
        Wed, 29 Nov 2023 09:13:49 +0000 (GMT)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc:     Sean Young <sean@mess.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] pwm: make it possible to apply pwm changes in atomic context
Date:   Wed, 29 Nov 2023 09:13:35 +0000
Message-ID: <734c9985a6f54d34d9ef20203ba7f962b572cb45.1701248996.git.sean@mess.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701248996.git.sean@mess.org>
References: <cover.1701248996.git.sean@mess.org>
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
index f1d8197c8c43..1d4536fdf47c 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -43,6 +43,15 @@ After being requested, a PWM has to be configured using::
 
 	int pwm_apply_might_sleep(struct pwm_device *pwm, struct pwm_state *state);
 
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
index fc92ba622e56..63174e207400 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -463,24 +463,15 @@ static void pwm_apply_debug(struct pwm_device *pwm,
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
@@ -501,16 +492,64 @@ int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
 
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
 EXPORT_SYMBOL_GPL(pwm_apply_might_sleep);
 
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
index 4239f2c3e8b2..47ea92cd8c67 100644
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
index 5c5c456948a4..f1fa1243e95a 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -286,6 +286,7 @@ struct pwm_ops {
  * @npwm: number of PWMs controlled by this chip
  * @of_xlate: request a PWM device given a device tree PWM specifier
  * @of_pwm_n_cells: number of cells expected in the device tree PWM specifier
+ * @atomic: can the driver call pwm_apply_atomic in atomic context
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
 int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state);
+int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state);
 int pwm_adjust_config(struct pwm_device *pwm);
 
 /**
@@ -378,6 +381,17 @@ static inline void pwm_disable(struct pwm_device *pwm)
 	pwm_apply_might_sleep(pwm, &state);
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

