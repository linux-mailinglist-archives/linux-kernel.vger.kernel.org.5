Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6089F7DDE07
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjKAJEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjKAJEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:04:34 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0309C10C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:04:25 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9d2e7726d5bso490105266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 02:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698829463; x=1699434263; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViHvhY7/7pjsjCfPWyii+lKtXPJD6Bts4D46Eo2ic5Q=;
        b=aWmBGsGrQ2Zajj+q79lcA8o0RRq3c2MXPsej5V2IU0eyohQ6DPXpfHvN+6ItkhIIXB
         Wrek/aLx8P0VF1onu6QpmKedOYI/SazSL62Sz90FHqF2Kp3cqsVG7xOqqaDRdL43EIyF
         gSZdGVgOLJb+ZGLjn8TO76vxCExigvILdUi3v2JGta3en4EHHFcsZmahYu5obG70SGog
         DDL1aFwiLZjM5Jw/mSsFvGMQfIYC7J6NBjRuxLXuIMzxSb4GjqVIIsTRKKnZGdIP+5QY
         yRo2eV8MWPsF6izyTAQ4s/GPDeVF5DHoiEpzfn3Xu85PvqtX/rlxxefchGEhz6v6dA1C
         pM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698829463; x=1699434263;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViHvhY7/7pjsjCfPWyii+lKtXPJD6Bts4D46Eo2ic5Q=;
        b=q9e4Zwq+i+i/dkuxtY58ZNRB0jYS8zzqOZ9ZTQ5lURhJw5dVF+APdfQk6D8EF308cn
         wxzB750I0l0EvYw2SiqUedH3G/0DySeEaU1hJSF5gXvN25EDz98CrFSx63yf6uvYWZTt
         wSG/sGAov2sq/fRCYAwMyVGuNQ4Y9hOP07DswS5Kj3Sfpo11kUQYfuPoqDfQDWlfba4Q
         am2FjdQCIhrISWyWA6zTcSCJdw9IkJmXb/mLkAB+cHvIH+FaPCeArWfbjat6RN0RuzSm
         FATlkHI8PLTQRPkoWJoe9rW9JioghvTZAUOpiDZCz3nVu6wtf2K3sZd1IGXhSKQxZmAR
         ejeQ==
X-Gm-Message-State: AOJu0YyFyIQPBocWbEr4OCJkPD9LlcjUV6q3/Ik93V/sEF28xF1Rehuh
        sOKT2Rbe5kze7vK3DIzqAiyptQ==
X-Google-Smtp-Source: AGHT+IHgfedVe+e1xDscZqpmwYEVUPqDIi8n61Kt2vd/n+wQV4pwVLy7AzvncRBXdQzxbke7FOiz5Q==
X-Received: by 2002:a17:907:31c9:b0:9d5:7c6f:de66 with SMTP id xf9-20020a17090731c900b009d57c6fde66mr1530396ejb.38.1698829463279;
        Wed, 01 Nov 2023 02:04:23 -0700 (PDT)
Received: from [127.0.1.1] ([86.122.213.220])
        by smtp.gmail.com with ESMTPSA id l25-20020a170906a41900b0099cd1c0cb21sm2152781ejz.129.2023.11.01.02.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 02:04:22 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Wed, 01 Nov 2023 11:04:07 +0200
Subject: [PATCH RESEND v3 1/5] PM: domains: Allow devices attached to genpd
 to be managed by HW
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-gdsc-hwctrl-v3-1-0740ae6b2b04@linaro.org>
References: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
In-Reply-To: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5556; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=32sYVIPbODR7bZmmLO/F82004WOVKvzKlgNaKLnb6O8=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlQhSNlwiaCkrAaRR5zOijghAtEwYGf4/QARt4t
 z2quO7an3WJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZUIUjQAKCRAbX0TJAJUV
 VkO7D/wOG+0OZ38ra04gQ31fYcS6XYOhaapbNoqndp26GKjWdwLhAWk1idQFvBYODw1jziEaXMg
 kRuoETr4u+h5RIh8rEXexzYBTCB0MJaRwlWXwCJ++d2zvzIMf/MLdIARHtbU/FEzSwU2CdpCmxn
 kfpQrXblCVsqcpA6+Zl8SiyXiPJ2vrQ7l2CZEH48i/9rl4y0CH5lNgphMWHRu3HaGJF8FC5HsbD
 qrUbMbmkoWCo9FhZNjcFNJBhVEM+ZdTa3UBvVkfkgF/XFliRg40keW+Q2Lj/GM1uojaN6oLIOxI
 pgi3h/0VfgjD2mj3WFDyVN1GTpodflaSok/o+eQVQ0KH+ROSl3ockHPzlaaR1x/GbEpam00NuLk
 BZXnfRjPgvGn9e0MfqdSSWn4dIOvKpb5bzkhOFRRtdIlJ5BAz33NPppV0OMHB6OYPloIvwKLDJL
 SoudyqMZP8+f8+f59geJCciVEeQjHVHW639mfhYWmmkufmyoTOmmQsKuvaFtXGLZ7ScxrzJyBP9
 QkjvGx4qBcsXXUVRNqDgihbr3K23bGjf9oxZMUGAl1AHaOiW72ngUcokeEheeV4+Cr68fGSB2yL
 jz4PHX8bS7Ce4TdcukX6LFc4/XaSfxYKmjGAlR4ALa1NZm1K8kp9Ekk4dnCgxb9+5HTIQvoSxnM
 1lLzP+ekrNwUaGw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/base/power/domain.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   | 17 +++++++++++
 2 files changed, 86 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index da1777e39eaa..3fb1a234c7f2 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -550,6 +550,75 @@ void dev_pm_genpd_synced_poweroff(struct device *dev)
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
index 34663d0d5c55..0e7d177fdc3e 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -151,6 +151,10 @@ struct generic_pm_domain {
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
@@ -213,6 +217,7 @@ struct generic_pm_domain_data {
 	unsigned int performance_state;
 	unsigned int default_pstate;
 	unsigned int rpm_pstate;
+	bool hw_mode;
 	void *data;
 };
 
@@ -242,6 +247,8 @@ int dev_pm_genpd_remove_notifier(struct device *dev);
 void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next);
 ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev);
 void dev_pm_genpd_synced_poweroff(struct device *dev);
+int dev_pm_genpd_set_hwmode(struct device *dev, bool enable);
+bool dev_pm_genpd_get_hwmode(struct device *dev);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -310,6 +317,16 @@ static inline ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev)
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

