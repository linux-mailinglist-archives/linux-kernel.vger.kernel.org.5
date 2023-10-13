Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52D67C8399
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjJMKrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjJMKra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:47:30 -0400
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA88AD;
        Fri, 13 Oct 2023 03:47:26 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 501)
        id B507C1000C4; Fri, 13 Oct 2023 11:47:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1697194044; bh=BPGCbyR+TQNm6kx/RctEE5jmHK5Z6c5mZ1jS/g7uJ/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i5ulWeE67zrXNBPSDrHdLWH5A9Cg3aO/ZldoanPVTXu/p1ucYdTI4wXJqtlmNp8kh
         1rze5jMXQX+BryiZdFJMVWyAeGDYcTKX7YgwdPt/U7hYR+QixoY4YkarRqGZ1GxAR1
         +UOIAV0jNNU3g3RrTUY1pADCwLLVS4xZP+JvymDaRvR99VQJaKSYYLvX84Q/ITPNpL
         qDsP3bdRTK5MPBwqMj4vo8oC+6uXTKEr919LX0C+Icaxe7gFtpNNfcLyHtrRF04yal
         tGJmFCCZ08Aqw+lOYHm4w+zYLr8QIatFmNPjedmIQclIkwkf4LUFbj4iQgstE9g9B2
         jesrYh9H0mwLg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from bigcore.mess.org (unknown [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by gofer.mess.org (Postfix) with ESMTPSA id 6154E1000C4;
        Fri, 13 Oct 2023 11:47:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1697194043; bh=BPGCbyR+TQNm6kx/RctEE5jmHK5Z6c5mZ1jS/g7uJ/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YjTcWDQFlQc5ZE2UNkgTGp7+iy64nWdtcYgAXxzPUcbzpkqwe1kQwcew2MfE7y5rr
         U5VngV/vcehLbJvjVPbrzbY63amvwFMdCRV7HovaB/yKXZZ9TV/u4kapwsEo+3m4E5
         tM0G333bpew4mkqX9j/eMHIR7vzwEca76EDFnwdkurZn/ezph4/c8q20HKjpDDl/kx
         mIlVg7VJwyIK46KRhOQKlOaDhqYuFs/+Uh30+Jwrrne8hIkMyyJZF7y7w/d9Gf9qP4
         +GPE4iwXWARUdIbnnSMzu1aaXCASVRpxxPNgsXSKZCx9MT0ggkc5GB12d1pCQFQSQO
         MbS7kE2p/oy7w==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sean Young <sean@mess.org>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] pwm: make it possible to apply pwm changes in atomic context
Date:   Fri, 13 Oct 2023 11:46:14 +0100
Message-ID: <9c0f1616fca5b218336b9321bfefe7abb7e1749f.1697193646.git.sean@mess.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697193646.git.sean@mess.org>
References: <cover.1697193646.git.sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers require sleeping, for example if the pwm device is connected
over i2c. The pwm-ir-tx requires precise timing, and sleeping causes havoc
with the generated IR signal when sleeping occurs.

This patch makes it possible to use pwm when the driver does not sleep,
by introducing the pwm_can_sleep() function.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/pwm/core.c            | 62 ++++++++++++++++++++++++++++-------
 drivers/pwm/pwm-renesas-tpu.c |  1 -
 include/linux/pwm.h           | 29 ++++++++++++++--
 3 files changed, 78 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index dc66e3405bf5..241510ba1823 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -489,24 +489,15 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 }
 
 /**
- * pwm_apply_state() - atomically apply a new state to a PWM device
+ * pwm_apply_state_unchecked() - atomically apply a new state to a PWM device
  * @pwm: PWM device
  * @state: new state to apply
  */
-int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
+static int pwm_apply_state_unchecked(struct pwm_device *pwm, const struct pwm_state *state)
 {
 	struct pwm_chip *chip;
 	int err;
 
-	/*
-	 * Some lowlevel driver's implementations of .apply() make use of
-	 * mutexes, also with some drivers only returning when the new
-	 * configuration is active calling pwm_apply_state() from atomic context
-	 * is a bad idea. So make it explicit that calling this function might
-	 * sleep.
-	 */
-	might_sleep();
-
 	if (!pwm || !state || !state->period ||
 	    state->duty_cycle > state->period)
 		return -EINVAL;
@@ -535,8 +526,57 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 
 	return 0;
 }
+
+/**
+ * pwm_apply_state() - atomically apply a new state to a PWM device
+ * Cannot be used in atomic context.
+ * @pwm: PWM device
+ * @state: new state to apply
+ */
+int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
+{
+	/*
+	 * Some lowlevel driver's implementations of .apply() make use of
+	 * mutexes, also with some drivers only returning when the new
+	 * configuration is active calling pwm_apply_state() from atomic context
+	 * is a bad idea. So make it explicit that calling this function might
+	 * sleep.
+	 */
+	might_sleep();
+
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm->chip->ops->atomic) {
+		int err;
+
+		/*
+		 * Catch any sleeping drivers when atomic is set.
+		 */
+		non_block_start();
+		err = pwm_apply_state_unchecked(pwm, state);
+		non_block_end();
+
+		return err;
+	}
+
+	return pwm_apply_state_unchecked(pwm, state);
+}
 EXPORT_SYMBOL_GPL(pwm_apply_state);
 
+/**
+ * pwm_apply_state_atomic() - atomically apply a new state to a PWM device
+ * Can be used from atomic context.
+ * @pwm: PWM device
+ * @state: new state to apply
+ */
+int pwm_apply_state_atomic(struct pwm_device *pwm,
+			   const struct pwm_state *state)
+{
+	WARN_ONCE(!pwm->chip->ops->atomic,
+		  "sleeping pwm driver used in atomic context");
+
+	return pwm_apply_state_unchecked(pwm, state);
+}
+EXPORT_SYMBOL_GPL(pwm_apply_state_atomic);
+
 /**
  * pwm_capture() - capture and report a PWM signal
  * @pwm: PWM device
diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index d7311614c846..96797a33d8c6 100644
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
index d2f9f690a9c1..93f166ab03c1 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -267,6 +267,7 @@ struct pwm_capture {
  * @get_state: get the current PWM state. This function is only
  *	       called once per PWM device when the PWM chip is
  *	       registered.
+ * @atomic: can the driver execute pwm_apply_state in atomic context
  * @owner: helps prevent removal of modules exporting active PWMs
  */
 struct pwm_ops {
@@ -278,6 +279,7 @@ struct pwm_ops {
 		     const struct pwm_state *state);
 	int (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
 			 struct pwm_state *state);
+	bool atomic;
 	struct module *owner;
 };
 
@@ -310,6 +312,7 @@ struct pwm_chip {
 #if IS_ENABLED(CONFIG_PWM)
 /* PWM user APIs */
 int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state);
+int pwm_apply_state_atomic(struct pwm_device *pwm, const struct pwm_state *state);
 int pwm_adjust_config(struct pwm_device *pwm);
 
 /**
@@ -380,6 +383,17 @@ static inline void pwm_disable(struct pwm_device *pwm)
 	pwm_apply_state(pwm, &state);
 }
 
+/**
+ * pwm_is_atomic() - is pwm_apply_state_atomic() supported?
+ * @pwm: PWM device
+ *
+ * Returns: true pwm_apply_state_atomic() can be called from atomic context.
+ */
+static inline bool pwm_is_atomic(struct pwm_device *pwm)
+{
+	return pwm->chip->ops->atomic;
+}
+
 /* PWM provider APIs */
 int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 		unsigned long timeout);
@@ -408,16 +422,27 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
 				       struct fwnode_handle *fwnode,
 				       const char *con_id);
 #else
+static inline bool pwm_is_atomic(struct pwm_device *pwm)
+{
+	return false;
+}
+
 static inline int pwm_apply_state(struct pwm_device *pwm,
 				  const struct pwm_state *state)
 {
 	might_sleep();
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
+}
+
+static inline int pwm_apply_state_atomic(struct pwm_device *pwm,
+					 const struct pwm_state *state)
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
2.42.0

