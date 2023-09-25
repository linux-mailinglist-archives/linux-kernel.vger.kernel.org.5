Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147B27AD8CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjIYNSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjIYNSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:18:03 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5315910D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:17:57 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50306b2920dso7864593e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695647875; x=1696252675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8U5TCt8PhKvPqkMPolS3qJOc5aJpgLowONzlvaY1uCA=;
        b=tuTQwHZ3oOn7V7MGJ5JUH4g8KpgW0WWW0vedNhA8gBr9qhL+69mUbIxuFHDZk8Bz/C
         Pgs0kwULmf15uV8diwpywTMAco385WfGQTM0c3bzlEIc2aitgPU7/EY+fCooUZx9y2bW
         5T1h15ufuDjgJsjY9ipnn/g7Ts0uE8Y+YvsKyOLyBvLenRoAWaPmZjBQd8NzglL0R5H8
         GOL5x6kHAtijhCU+LwQXJkDH5l86JGE8y8N2aLyLpaqBqHbvKuaL3Po+Yk3u8l9ugeN2
         XkRkvMLYlXy2spqhmvR+x6j4Frb7CGdLwL+DXNTtdVJxthnOLwgkjYdOKCLrCDj4lYtl
         25Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695647875; x=1696252675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8U5TCt8PhKvPqkMPolS3qJOc5aJpgLowONzlvaY1uCA=;
        b=XN+i0vZBXORgYIVR8Pft28GcKJiIfYo0uTh6zY1DQZ4kVtTPqtMKwsjDAFtS7CmXxu
         tJ0E8cWwpSQE19QGIFgLusrw+t9xCFNi9sbw70CHmQfpk6QOgm5HAEtvXYEojspjaGjG
         wQPT8hUojrwP14B8mZFK/hRmR6IK33T8YrrQilVEg7UzdetvvEvyARcW0o0zyH3urilc
         HaDt6hwuVNEEkRKeJbu9q+7hHzpgBk3/+pkKfQ0mzfB6kIZpRSaBJMVuCTUlpu+CzZQV
         O1xTuHgzpQ3aUheDZaPw3q6XTb1XqaOZo/+AGRFWvYR4LMozgrnJb28FBt0hWzju5lLB
         OVSA==
X-Gm-Message-State: AOJu0YzSfoEbgX5adtBIqmBbAcYMiyJ6+vExIfRWxF/IEMmxLvvcJjXX
        QQbVcF/i/ttMqWqDJKHfCdfo/g==
X-Google-Smtp-Source: AGHT+IHKbJtqXxLpoL/3TxVjGxZPgSGBoxzRkGP+PUJOzo30gCEuhg29mQ3rnnoMG3KuUNvxb6UVyg==
X-Received: by 2002:a05:6512:acd:b0:4f9:dac6:2f3d with SMTP id n13-20020a0565120acd00b004f9dac62f3dmr3152406lfu.13.1695647875663;
        Mon, 25 Sep 2023 06:17:55 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id m29-20020a056512015d00b004fe10276bbfsm1823583lfo.296.2023.09.25.06.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:17:55 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] PM: domains: Introduce dev_pm_domain_set_performance_state()
Date:   Mon, 25 Sep 2023 15:17:07 +0200
Message-Id: <20230925131715.138411-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925131715.138411-1-ulf.hansson@linaro.org>
References: <20230925131715.138411-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic PM domain is currently the only PM domain variant that supports
performance scaling. To allow performance scaling to be supported through a
common interface, let's add an optional callback ->set_performance_state(),
in the struct dev_pm_domain.

Moreover, let's add a function, dev_pm_domain_set_performance_state(), that
may be called by consumers to request a new performance state for a device
through its PM domain.

Note that, in most cases it's preferred that a consumer use the OPP library
to request a new performance state for its device. Although, this requires
some additional changes to be supported, which are being implemented from
subsequent changes.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/common.c | 21 +++++++++++++++++++++
 include/linux/pm.h          |  2 ++
 include/linux/pm_domain.h   |  6 ++++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 72115917e0bd..44ec20918a4d 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -228,3 +228,24 @@ void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd)
 	device_pm_check_callbacks(dev);
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_set);
+
+/**
+ * dev_pm_domain_set_performance_state - Request a new performance state.
+ * @dev: The device to make the request for.
+ * @state: Target performance state for the device.
+ *
+ * This function should be called when a new performance state needs to be
+ * requested for a device that is attached to a PM domain. Note that, the
+ * support for performance scaling for PM domains is optional.
+ *
+ * Returns 0 on success and when performance scaling isn't supported, negative
+ * error code on failure.
+ */
+int dev_pm_domain_set_performance_state(struct device *dev, unsigned int state)
+{
+	if (dev->pm_domain && dev->pm_domain->set_performance_state)
+		return dev->pm_domain->set_performance_state(dev, state);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pm_domain_set_performance_state);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 1400c37b29c7..4c9f571609c8 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -719,6 +719,7 @@ extern void dev_pm_put_subsys_data(struct device *dev);
  * @activate: Called before executing probe routines for bus types and drivers.
  * @sync: Called after successful driver probe.
  * @dismiss: Called after unsuccessful driver probe and after driver removal.
+ * @set_performance_state: Called to request a new performance state.
  *
  * Power domains provide callbacks that are executed during system suspend,
  * hibernation, system resume and during runtime PM transitions instead of
@@ -731,6 +732,7 @@ struct dev_pm_domain {
 	int (*activate)(struct device *dev);
 	void (*sync)(struct device *dev);
 	void (*dismiss)(struct device *dev);
+	int (*set_performance_state)(struct device *dev, unsigned int state);
 };
 
 /*
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 05ad8cefdff1..34663d0d5c55 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -435,6 +435,7 @@ struct device *dev_pm_domain_attach_by_name(struct device *dev,
 void dev_pm_domain_detach(struct device *dev, bool power_off);
 int dev_pm_domain_start(struct device *dev);
 void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
+int dev_pm_domain_set_performance_state(struct device *dev, unsigned int state);
 #else
 static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
 {
@@ -457,6 +458,11 @@ static inline int dev_pm_domain_start(struct device *dev)
 }
 static inline void dev_pm_domain_set(struct device *dev,
 				     struct dev_pm_domain *pd) {}
+static inline int dev_pm_domain_set_performance_state(struct device *dev,
+						      unsigned int state)
+{
+	return 0;
+}
 #endif
 
 #endif /* _LINUX_PM_DOMAIN_H */
-- 
2.34.1

