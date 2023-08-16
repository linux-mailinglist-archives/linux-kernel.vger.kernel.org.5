Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8915277E460
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343893AbjHPO6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343854AbjHPO5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:57:54 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421DD10E9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:57:53 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b703a0453fso100999091fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692197871; x=1692802671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJy2R3P3tqw0+ESpB2MxKyE27+v98SJ0NGWR6OuPHME=;
        b=FFsAYIPCoql6xswQkEnqKEFXrppTVmLHlVv+VfbtsYgPHJnIYrdSYD/SO/BJtXlhoc
         wA+1z0Brl33kk5FQvjYbND1wQ9fwAOxMrJcAS/WU+uQbVZKjJAdVzCUgsZxc2x9n8hVI
         2oRgIb+O1tc2w9KWRgn9oFyAPlavnDtio0/TDhWCwUS4OyFK/4yKNIPxxarXiu1Jjb2/
         m96rlqO+sA7eQA1/eN8AuAWyiBevnw2+iwyXtjCTYASC+t9q7ywMhKt2tsedaY7JQkgU
         LXYANfX8hbUBSw+25eazY8KL4TfCrYl4y4goqFdAyoQMNmgfsLU3UXOsZlKIsiTQLiND
         cR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692197871; x=1692802671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJy2R3P3tqw0+ESpB2MxKyE27+v98SJ0NGWR6OuPHME=;
        b=Z6YdJo1ZvEg9lKawTgvjgg8es9MTUBC1PDtA8S2AzwGAOw/295Ycp/NnZBzHwfzCgG
         2a2ls7bOZyWN5B6Fk5tmVdJpGP8BNxsQYHhofp/MAFPVoA0rfFx1VdT9Jn2eZZ0uEN7V
         +ppEchkBknlCgeV9EAV/BPqq/TQqcbucl3Au21eZEEXYpAcUR6wbdjOZ2ShNtQ6/FU9S
         AO9A8GGe4t/t32bAwTMfoRaByVBWHlmDsq7M7slmI5jsZTdL3P19XINatnDTg97+ljoV
         d0nEZlSM1Y5cDr4bL5MKm4w0GXcsdwqEZaOItSPUYw/QvMcojJJzJ9WCvxgNiqdKCZhy
         gTEQ==
X-Gm-Message-State: AOJu0YxM7GG6LHyYkRc7Nm069w5qDm/Xf8ht+sj6o2J3mxfddlMZgYX6
        fIVChE6mCdK6QHhspMuOWW/xlw==
X-Google-Smtp-Source: AGHT+IFPyEEjR3aBCl4jPyvfEu16V/bunE3zATtqhYdZEh6WtyuA71IJB08RCkr8xn8X4letoC9xUw==
X-Received: by 2002:a2e:86c2:0:b0:2b9:acad:b4b2 with SMTP id n2-20020a2e86c2000000b002b9acadb4b2mr1707919ljj.6.1692197871439;
        Wed, 16 Aug 2023 07:57:51 -0700 (PDT)
Received: from hackbox.lan ([84.232.191.92])
        by smtp.gmail.com with ESMTPSA id f16-20020a170906561000b00992076f4a01sm8610403ejq.190.2023.08.16.07.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 07:57:51 -0700 (PDT)
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
Subject: [PATCH v2 1/6] PM: domains: Allow devices attached to genpd to be managed by HW
Date:   Wed, 16 Aug 2023 17:57:36 +0300
Message-Id: <20230816145741.1472721-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816145741.1472721-1-abel.vesa@linaro.org>
References: <20230816145741.1472721-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

Changes since v1:
 * reword the commit message to mention the dev_pm_genpd_get_hwmode
 * add the get_hwmode_dev callback to the generic_pm_domain
 * call the genpd provider implementation of the get_hwmode_dev from the
   generic API

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

