Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7CC7AC174
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 13:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjIWLud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 07:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjIWLu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 07:50:26 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FF51AD
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 04:50:19 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bffdf50212so57568641fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 04:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695469818; x=1696074618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPs/8kVgbnM0mW5nRHnV6PsEkWTa8KX9zy7vOpy7zco=;
        b=PweBAeQYomHnpiZ33syNTGedNrTDTDRbzwDrg2QFtoBAWX4zfrpQJWtGWfHpYUBFvz
         LjJ3D/C4MZX36ce4zqfbwiqTizZYeXmMzflqyNHdKSavFKR/y2p69e/S4dUz8bLypykt
         c+Upo6GoERq9MggkLvsUTLv3UJtwOLkczlWVB/TFXtwqFoyV9WhojPT4zmri5xu2BQKA
         +35LV/dGfnWyeBqI0c8qud3KWaV9/9JLGJgFYxrSyDmbzAZj3X2G2hbqiUHXH0JZxKqS
         MFOmHGL8ziqvMOFTdhsD9RfYljE24B+6XdUG6vM1L2SBkDbgd2r/+goXPNV0elSaoROM
         tW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695469818; x=1696074618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPs/8kVgbnM0mW5nRHnV6PsEkWTa8KX9zy7vOpy7zco=;
        b=dyIvOOLG6sSkKebuIXaDwPlRHc1HHlIuuQhAN2Ord1oXfDKV+NfILpNx9002UlMy5S
         tpAKzTcR6lLV0qCHOhC8qvTZo+ycKlM86WkpP6yQn0BBX9YqZVtyL8xiQpwr19gUxp63
         TPj3BnlP7xOZj4n40kL7IK4uZKePVQjbWpUyUSk5CCQOPTqYmpd8jXsqv+sBY0HhT43L
         uynCVpyiI2Trv2cWL3SBwDMeX2befCbBQBCm8YIrSvWNqO5Pc5fVWYEW1u+gKEd1KsIP
         crrzWiU5F9UxfMShIuVFpZSrvzM8vwy6ymzHedw65mJ7pr6QKifR1p2GPZ5K2TOepm0D
         NUYQ==
X-Gm-Message-State: AOJu0Yz7dFFyjQfAu8w5phgWuHPuf1F0ZMBfXfJLqOjGckBxf6Ab2oc0
        1pr0rSgvhF2EJ360s1W+OZyiVQ==
X-Google-Smtp-Source: AGHT+IF3iCPcqri7mExufzMYrYPnONmgorXVtSZYUy19mZQ/qSGbhFXVMLsCZeWD4KykDA+ieBz8OA==
X-Received: by 2002:a2e:9d98:0:b0:2bc:e882:f717 with SMTP id c24-20020a2e9d98000000b002bce882f717mr1448649ljj.53.1695469817288;
        Sat, 23 Sep 2023 04:50:17 -0700 (PDT)
Received: from hackbox.lan ([86.120.16.169])
        by smtp.gmail.com with ESMTPSA id k15-20020a1709062a4f00b009ad8084e08asm3853310eje.0.2023.09.23.04.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 04:50:16 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: [RESEND v3 1/5] PM: domains: Allow devices attached to genpd to be managed by HW
Date:   Sat, 23 Sep 2023 14:50:04 +0300
Message-Id: <20230923115008.1698384-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923115008.1698384-1-abel.vesa@linaro.org>
References: <20230923115008.1698384-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Some power-domains may be capable of relying on the HW to control the power
for a device that's hooked up to it. Typically, for these kinds of
configurations the device doesn't really need to be attached to a PM domain
(genpd), from Linux point of view. However, in some cases the behaviour of
the power-domain and its device can be changed in runtime.

To allow a consumer driver to change the behaviour of the PM domain for its
device, let's provide a new function, dev_pm_genpd_set_hwmode(). Moreover,
let's add a corresponding optional genpd callback, ->set_hwmode_dev(),
which the genpd provider should implement if it can support switching
between HW controlled mode and SW controlled mode. Similarly, add the
dev_pm_genpd_get_hwmode() to allow consumers to read the current mode and
its corresponding optional genpd callback, ->get_hwmode_dev(), which the
genpd provider can also implement for reading back the mode from the
hardware.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/base/power/domain.c | 69 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   | 17 +++++++++
 2 files changed, 86 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5cb2023581d4..dfb4f1de540d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -541,6 +541,75 @@ void dev_pm_genpd_synced_poweroff(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_synced_poweroff);
 
+/**
+ * dev_pm_genpd_set_hwmode - Set the HW mode for the device and its PM domain.
+ *
+ * @dev: Device for which the HW-mode should be changed.
+ * @enable: Value to set or unset the HW-mode.
+ *
+ * Some PM domains can rely on HW signals to control the power for a device. To
+ * allow a consumer driver to switch the behaviour for its device in runtime,
+ * which may be beneficial from a latency or energy point of view, this function
+ * may be called.
+ *
+ * It is assumed that the users guarantee that the genpd wouldn't be detached
+ * while this routine is getting called.
+ *
+ * Returns 0 on success and negative error values on failures.
+ */
+int dev_pm_genpd_set_hwmode(struct device *dev, bool enable)
+{
+	struct generic_pm_domain *genpd;
+	int ret = 0;
+
+	genpd = dev_to_genpd_safe(dev);
+	if (!genpd)
+		return -ENODEV;
+
+	if (!genpd->set_hwmode_dev)
+		return -EOPNOTSUPP;
+
+	genpd_lock(genpd);
+
+	if (dev_gpd_data(dev)->hw_mode == enable)
+		goto out;
+
+	ret = genpd->set_hwmode_dev(genpd, dev, enable);
+	if (!ret)
+		dev_gpd_data(dev)->hw_mode = enable;
+
+out:
+	genpd_unlock(genpd);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_set_hwmode);
+
+/**
+ * dev_pm_genpd_get_hwmode - Get the HW mode setting for the device.
+ *
+ * @dev: Device for which the current HW-mode setting should be fetched.
+ *
+ * This helper function allows consumer drivers to fetch the current HW mode
+ * setting of its the device.
+ *
+ * It is assumed that the users guarantee that the genpd wouldn't be detached
+ * while this routine is getting called.
+ */
+bool dev_pm_genpd_get_hwmode(struct device *dev)
+{
+	struct generic_pm_domain *genpd;
+
+	genpd = dev_to_genpd_safe(dev);
+	if (!genpd)
+		return false;
+
+	if (genpd->get_hwmode_dev)
+		return genpd->get_hwmode_dev(genpd, dev);
+
+	return dev_gpd_data(dev)->hw_mode;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_get_hwmode);
+
 static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f776fb93eaa0..36d308ba40b0 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -146,6 +146,10 @@ struct generic_pm_domain {
 	int (*set_performance_state)(struct generic_pm_domain *genpd,
 				     unsigned int state);
 	struct gpd_dev_ops dev_ops;
+	int (*set_hwmode_dev)(struct generic_pm_domain *domain,
+			      struct device *dev, bool enable);
+	bool (*get_hwmode_dev)(struct generic_pm_domain *domain,
+			      struct device *dev);
 	int (*attach_dev)(struct generic_pm_domain *domain,
 			  struct device *dev);
 	void (*detach_dev)(struct generic_pm_domain *domain,
@@ -208,6 +212,7 @@ struct generic_pm_domain_data {
 	unsigned int performance_state;
 	unsigned int default_pstate;
 	unsigned int rpm_pstate;
+	bool hw_mode;
 	void *data;
 };
 
@@ -237,6 +242,8 @@ int dev_pm_genpd_remove_notifier(struct device *dev);
 void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next);
 ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev);
 void dev_pm_genpd_synced_poweroff(struct device *dev);
+int dev_pm_genpd_set_hwmode(struct device *dev, bool enable);
+bool dev_pm_genpd_get_hwmode(struct device *dev);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -305,6 +312,16 @@ static inline ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev)
 static inline void dev_pm_genpd_synced_poweroff(struct device *dev)
 { }
 
+static inline int dev_pm_genpd_set_hwmode(struct device *dev, bool enable)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool dev_pm_genpd_get_hwmode(struct device *dev)
+{
+	return false;
+}
+
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif
-- 
2.34.1

