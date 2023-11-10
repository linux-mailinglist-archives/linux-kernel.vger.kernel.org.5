Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B89A7E7FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjKJR57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbjKJR4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:56:05 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE3028122
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:21:12 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5afa071d100so37642587b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699611671; x=1700216471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s+EHE1tSh9TUGp4Mr+oOFz1R80eazcuwhmi64rmgAyg=;
        b=qfmogPGSjMtD2g/cQArtmPJ3hUBZMsIXAnqRFsUaLN1YIYqmcpD/etoyFu8Sdu+vTS
         5o6TXkl1FSJ3CEBfrPSRyuMgT4bd/+b6h8ZuRcc2Oj1oqMdDNugCXf3b0Z2zrV8nOeCE
         VcUq1vfbfIa7SmR/ssWgl6qD7PWl29sogtfz77Kx6FO7yPuqoCuQZ6OrffOd+p+qSLMQ
         7sTDX7rSRWnIxBLklmyLuJ1EzJPG6KzidKbQGWk6WBtsJFiXQw42EpALtBo92Zf+SbkS
         uTFWUiGJ68Uk6d0ICa+UJpCvHDYMVJ74Uo4x1WV/yPc4Xv3U2vuwykVR6U2/YfbHc2FL
         k9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699611671; x=1700216471;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s+EHE1tSh9TUGp4Mr+oOFz1R80eazcuwhmi64rmgAyg=;
        b=QKzv9zPaceXN9PD3zpwbtmYlI7ubxWZlNr+yA1hoDogluhKdWrCbGpBDB7NQnHO+tK
         J60mq+oR8zCDedZ0+ltKdojjqIuSuvuCeaBuY8sJLjz89EVmX+auHcSjG7/uTLHN1DV5
         vnIuxbQZQbjTld1UqNAd3X68j/5h4AZ5KvuOPW2ap02ZGyiRhmLluAKAlxdzfax4XOjL
         DHAtKF20dXAslOFDBNrVW2MHZelv4zarynJwSM7YgX26riJg+MsoqWnjBWsK4KmMFe+Q
         YALH+s3/o7ACn6+6/pcqBDbs8xULvh8l0WM+0WVCzWMgHwAOGfSG2GFbqsgSCxmx+WeR
         hzqQ==
X-Gm-Message-State: AOJu0Ywwu70qIhMGB/teiHD+bQm/q87G5ywhnO8oCdV1ZQKOIG4SgeQw
        Kq84arevK+ojFyznaHlFgrc5BXELKZwNxw==
X-Google-Smtp-Source: AGHT+IEOKoMd3lCJVGNfPEwp7n3xZPrvNvW0ZGBHyh/0JmZeaHqLvXRHZgvFWlaysojUQi0nO+x5EgWQi5t69A==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:9805:0:b0:da0:ca55:3efb with SMTP id
 a5-20020a259805000000b00da0ca553efbmr206282ybo.11.1699611671409; Fri, 10 Nov
 2023 02:21:11 -0800 (PST)
Date:   Fri, 10 Nov 2023 10:20:54 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110102054.1393570-1-joychakr@google.com>
Subject: [RFC PATCH] PM: runtime: Apply pinctrl settings if defined
From:   Joy Chakraborty <joychakr@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, manugautam@google.com,
        aniketmaurya@google.com, Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply pinctrl state from  runtime framework device state transtion.

Pinctrl states if defined in DT are bookmarked in device structures
but they need to be explicitly applied from device driver callbacks
which is boiler plate code and also not present in many drivers.

If there is a specific order of setting pinctrl state with other driver
actions then the device driver can choose to do it from its pm callbacks,
in such a case this call will be a no-op from the pinctrl core framework
since the desired pinctrl state would already be set.

We could also add a Kconfig knob to enable/disable this, but I do not
see a need to.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/base/pinctrl.c          | 33 +++++++++++++++++++++++++++++++++
 drivers/base/power/runtime.c    |  9 ++++++++-
 include/linux/pinctrl/devinfo.h | 11 +++++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/base/pinctrl.c b/drivers/base/pinctrl.c
index c22864458511..24bb6dba8cb7 100644
--- a/drivers/base/pinctrl.c
+++ b/drivers/base/pinctrl.c
@@ -103,3 +103,36 @@ int pinctrl_bind_pins(struct device *dev)
 
 	return 0;
 }
+
+#ifdef CONFIG_PM
+/**
+ * pinctrl_state_try_default() - Try setting default state if available
+ * @dev The device to set pinctrl state
+ */
+inline void pinctrl_state_try_default(struct device *dev)
+{
+	if (dev->pins && !IS_ERR(dev->pins->default_state))
+		pinctrl_select_state(dev->pins->p, dev->pins->default_state);
+}
+
+/**
+ * pinctrl_state_try_idle() - Try setting idle state if available
+ * @dev The device to set pinctrl state
+ */
+inline void pinctrl_state_try_idle(struct device *dev)
+{
+	if (dev->pins && !IS_ERR(dev->pins->idle_state))
+		pinctrl_select_state(dev->pins->p, dev->pins->idle_state);
+}
+
+/**
+ * pinctrl_state_try_sleep() - Try setting sleep state if available
+ * @dev The device to set pinctrl state
+ */
+inline void pinctrl_state_try_sleep(struct device *dev)
+{
+	if (dev->pins && !IS_ERR(dev->pins->sleep_state))
+		pinctrl_select_state(dev->pins->p, dev->pins->sleep_state);
+}
+#endif
+
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 4545669cb973..a07efa446330 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -9,6 +9,7 @@
 #include <linux/ktime.h>
 #include <linux/hrtimer.h>
 #include <linux/export.h>
+#include <linux/pinctrl/devinfo.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_wakeirq.h>
 #include <trace/events/rpm.h>
@@ -499,7 +500,7 @@ static int rpm_idle(struct device *dev, int rpmflags)
 
 	/* If no callback assume success. */
 	if (!callback || dev->power.no_callbacks)
-		goto out;
+		goto no_callback;
 
 	/* Carry out an asynchronous or a synchronous idle notification. */
 	if (rpmflags & RPM_ASYNC) {
@@ -529,6 +530,8 @@ static int rpm_idle(struct device *dev, int rpmflags)
 	dev->power.idle_notification = false;
 	wake_up_all(&dev->power.wait_queue);
 
+ no_callback:
+	pinctrl_state_try_idle(dev);
  out:
 	trace_rpm_return_int(dev, _THIS_IP_, retval);
 	return retval ? retval : rpm_suspend(dev, rpmflags | RPM_AUTO);
@@ -676,6 +679,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
  no_callback:
 	__update_runtime_status(dev, RPM_SUSPENDED);
 	pm_runtime_deactivate_timer(dev);
+	pinctrl_state_try_sleep(dev);
 
 	if (dev->parent) {
 		parent = dev->parent;
@@ -918,6 +922,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
  no_callback:
 		__update_runtime_status(dev, RPM_ACTIVE);
 		pm_runtime_mark_last_busy(dev);
+		pinctrl_state_try_default(dev);
 		if (parent)
 			atomic_inc(&parent->power.child_count);
 	}
@@ -1899,6 +1904,7 @@ int pm_runtime_force_suspend(struct device *dev)
 		__update_runtime_status(dev, RPM_SUSPENDED);
 		dev->power.needs_force_resume = 1;
 	}
+	pinctrl_state_try_sleep(dev);
 
 	return 0;
 
@@ -1946,6 +1952,7 @@ int pm_runtime_force_resume(struct device *dev)
 	}
 
 	pm_runtime_mark_last_busy(dev);
+	pinctrl_state_try_default(dev);
 out:
 	dev->power.needs_force_resume = 0;
 	pm_runtime_enable(dev);
diff --git a/include/linux/pinctrl/devinfo.h b/include/linux/pinctrl/devinfo.h
index bb6653af4f92..c3a63e96dd37 100644
--- a/include/linux/pinctrl/devinfo.h
+++ b/include/linux/pinctrl/devinfo.h
@@ -54,6 +54,12 @@ static inline struct pinctrl *dev_pinctrl(struct device *dev)
 	return dev->pins->p;
 }
 
+#ifdef CONFIG_PM
+extern inline void pinctrl_state_try_default(struct device *dev);
+extern inline void pinctrl_state_try_idle(struct device *dev);
+extern inline void pinctrl_state_try_sleep(struct device *dev);
+#endif /* CONFIG_PM */
+
 #else
 
 /* Stubs if we're not using pinctrl */
@@ -73,5 +79,10 @@ static inline struct pinctrl *dev_pinctrl(struct device *dev)
 	return NULL;
 }
 
+#ifdef CONFIG_PM
+static inline void pinctrl_state_try_default(struct device *dev) {}
+static inline void pinctrl_state_try_idle(struct device *dev) {}
+static inline void pinctrl_state_try_sleep(struct device *dev) {}
+#endif /* CONFIG_PM */
 #endif /* CONFIG_PINCTRL */
 #endif /* PINCTRL_DEVINFO_H */
-- 
2.42.0.869.gea05f2083d-goog

