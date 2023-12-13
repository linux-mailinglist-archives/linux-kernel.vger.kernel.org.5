Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F71C811BB0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjLMR6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjLMR6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:58:33 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87F2E8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:58:36 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c1e3ea2f2so71290505e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702490315; x=1703095115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G4CLDl2ixZ+H+FQqRKQM7M4v6HsSq2CAnqHzFbGsR8E=;
        b=DX2x9Oi3bLRiYyIBv+6q5SM48sK2+S1k2h8XH5/GGwWNJlWNqSpx9Y7o+GCQngBrRt
         wgb43a1f3mBYc06rhL7rPM0yA/a1fksOV+8nm093nbbxAb1BKjttuM5mS+F6jj9p/weR
         olZnYE0nTbcY7zwaKf1jckPJVR0xKVH98g0pn43lowAnGx7bPKoL80yFfzNRN01Aqurk
         F0YxR2JVVfuIsH2tR4fijGP4VD7dI3ydE6u/l9zz5IFh9KKrat98aePeBjPdnuSB/d6D
         p03vw6OPCjm7w1aNFYBCuiO3neutms3buQbXYs6CbN8yZxwO3s1TQ04yQdZX4OkMZReg
         UIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702490315; x=1703095115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4CLDl2ixZ+H+FQqRKQM7M4v6HsSq2CAnqHzFbGsR8E=;
        b=UcYXkt60TWVFPdB8wNzrmt1TSkZhIqpROVuKwrmFFrIq3RfOSJ+KCn1zMcdwqt+5A0
         UtfRRBShHXMypMkVuNSELl08rzObx02E+N++hN5+UDczOV9KUuQCZWGO+ZJWeF4gN0Uq
         mOw61z21gAwOKo0HNyqzsETMgQ0WyU9Kf4Yrbj1Bmdv/usyHTe5ppJUbLKWL6/NRRQXo
         WkCdlQ8OcvI2WgIT6gCnpS1dqswFG5m+gBnTfXY9eWMg79e9Ans468WX3DoaPFz/MnUR
         nsySaFtMsavDoClM2VCJA9FQ1h3JPLDdgw3KDubgDnGWr0qMMuYFWJZtLgcyn94M5C/f
         nc4Q==
X-Gm-Message-State: AOJu0YxqQB9ZyQCepURz38LXdaSinMR+7iqXObJld5JRcaWwzKpYe4Gs
        WT4SYgYe3cZMwmba/n+Xp8vMgw==
X-Google-Smtp-Source: AGHT+IEhW6vgK9xuboxPECZkXuXkNKzNb/nJJt16QuLUHc97+VR5lkHc2vVbexDDQi586wXfSFnz5g==
X-Received: by 2002:a7b:ce0f:0:b0:40c:3103:2eb1 with SMTP id m15-20020a7bce0f000000b0040c31032eb1mr4551565wmc.22.1702490314926;
        Wed, 13 Dec 2023 09:58:34 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.gmail.com with ESMTPSA id bd21-20020a05600c1f1500b0040c25abd724sm23875617wmb.9.2023.12.13.09.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:58:34 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     caleb.connolly@linaro.org, lina.iyer@linaro.org,
        lukasz.luba@arm.com, quic_manafm@quicinc.com,
        quic_priyjain@quicinc.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] PM: QoS: Rename freq to range constraint
Date:   Wed, 13 Dec 2023 18:58:17 +0100
Message-Id: <20231213175818.2826876-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The frequency pm_qos relies on a couple of values, the min and max
frequencies. However more pm_qos will be added with the same logic of
a couple of min and max. Instead of writing new set of constraints as
well as type, etc... let's rename freq_* to a more generic name
range_*

That way, new qos range based can be added easily.

No functional changes intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/base/power/qos-test.c              | 14 +++---
 drivers/base/power/qos.c                   |  4 +-
 drivers/cpufreq/intel_pstate.c             |  8 ++--
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c      |  6 +--
 drivers/macintosh/windfarm_cpufreq_clamp.c |  2 +-
 drivers/powercap/dtpm_cpu.c                |  2 +-
 drivers/thermal/cpufreq_cooling.c          |  2 +-
 include/acpi/processor.h                   |  4 +-
 include/linux/amd-pstate.h                 |  2 +-
 include/linux/cpufreq.h                    |  6 +--
 include/linux/pm_qos.h                     | 55 +++++++++++-----------
 kernel/power/qos.c                         | 53 ++++++++++-----------
 12 files changed, 79 insertions(+), 79 deletions(-)

diff --git a/drivers/base/power/qos-test.c b/drivers/base/power/qos-test.c
index 79fc6c4418da..56f33acb9e3c 100644
--- a/drivers/base/power/qos-test.c
+++ b/drivers/base/power/qos-test.c
@@ -8,8 +8,8 @@
 /* Basic test for aggregating two "min" requests */
 static void freq_qos_test_min(struct kunit *test)
 {
-	struct freq_constraints	qos;
-	struct freq_qos_request	req1, req2;
+	struct range_constraints	qos;
+	struct range_qos_request	req1, req2;
 	int ret;
 
 	freq_constraints_init(&qos);
@@ -36,8 +36,8 @@ static void freq_qos_test_min(struct kunit *test)
 /* Test that requests for MAX_DEFAULT_VALUE have no effect */
 static void freq_qos_test_maxdef(struct kunit *test)
 {
-	struct freq_constraints	qos;
-	struct freq_qos_request	req1, req2;
+	struct range_constraints	qos;
+	struct range_qos_request	req1, req2;
 	int ret;
 
 	freq_constraints_init(&qos);
@@ -70,15 +70,15 @@ static void freq_qos_test_maxdef(struct kunit *test)
 }
 
 /*
- * Test that a freq_qos_request can be added again after removal
+ * Test that a range_qos_request can be added again after removal
  *
  * This issue was solved by commit 05ff1ba412fd ("PM: QoS: Invalidate frequency
  * QoS requests after removal")
  */
 static void freq_qos_test_readd(struct kunit *test)
 {
-	struct freq_constraints	qos;
-	struct freq_qos_request	req;
+	struct range_constraints	qos;
+	struct range_qos_request	req;
 	int ret;
 
 	freq_constraints_init(&qos);
diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 8e93167f1783..ae0b9d2573ec 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -285,14 +285,14 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
 		memset(req, 0, sizeof(*req));
 	}
 
-	c = &qos->freq.min_freq;
+	c = &qos->freq.lower_bound;
 	plist_for_each_entry_safe(req, tmp, &c->list, data.freq.pnode) {
 		apply_constraint(req, PM_QOS_REMOVE_REQ,
 				 PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE);
 		memset(req, 0, sizeof(*req));
 	}
 
-	c = &qos->freq.max_freq;
+	c = &qos->freq.upper_bound;
 	plist_for_each_entry_safe(req, tmp, &c->list, data.freq.pnode) {
 		apply_constraint(req, PM_QOS_REMOVE_REQ,
 				 PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dd6d23e389f1..eafe39f37c9a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1320,9 +1320,9 @@ static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
 	return count;
 }
 
-static void update_qos_request(enum freq_qos_req_type type)
+static void update_qos_request(enum range_qos_req_type type)
 {
-	struct freq_qos_request *req;
+	struct range_qos_request *req;
 	struct cpufreq_policy *policy;
 	int i;
 
@@ -2984,7 +2984,7 @@ static void intel_cpufreq_adjust_perf(unsigned int cpunum,
 
 static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	struct freq_qos_request *req;
+	struct range_qos_request *req;
 	struct cpudata *cpu;
 	struct device *dev;
 	int ret, freq;
@@ -3058,7 +3058,7 @@ static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 static int intel_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
-	struct freq_qos_request *req;
+	struct range_qos_request *req;
 
 	req = policy->driver_data;
 
diff --git a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
index 6f0c32592416..faa7f19a1702 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
@@ -64,7 +64,7 @@ EXPORT_SYMBOL_GPL(cbe_cpufreq_set_pmode_pmi);
 static void cbe_cpufreq_handle_pmi(pmi_message_t pmi_msg)
 {
 	struct cpufreq_policy *policy;
-	struct freq_qos_request *req;
+	struct range_qos_request *req;
 	u8 node, slow_mode;
 	int cpu, ret;
 
@@ -102,7 +102,7 @@ static struct pmi_handler cbe_pmi_handler = {
 
 void cbe_cpufreq_pmi_policy_init(struct cpufreq_policy *policy)
 {
-	struct freq_qos_request *req;
+	struct range_qos_request *req;
 	int ret;
 
 	if (!cbe_cpufreq_has_pmi)
@@ -126,7 +126,7 @@ EXPORT_SYMBOL_GPL(cbe_cpufreq_pmi_policy_init);
 
 void cbe_cpufreq_pmi_policy_exit(struct cpufreq_policy *policy)
 {
-	struct freq_qos_request *req = policy->driver_data;
+	struct range_qos_request *req = policy->driver_data;
 
 	if (cbe_cpufreq_has_pmi) {
 		freq_qos_remove_request(req);
diff --git a/drivers/macintosh/windfarm_cpufreq_clamp.c b/drivers/macintosh/windfarm_cpufreq_clamp.c
index 28d18ef22bbb..a24ddf1072f3 100644
--- a/drivers/macintosh/windfarm_cpufreq_clamp.c
+++ b/drivers/macintosh/windfarm_cpufreq_clamp.c
@@ -16,7 +16,7 @@
 
 static int clamped;
 static struct wf_control *clamp_control;
-static struct freq_qos_request qos_req;
+static struct range_qos_request qos_req;
 static unsigned int min_freq, max_freq;
 
 static int clamp_set(struct wf_control *ct, s32 value)
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 9193c3b8edeb..408dbc842e5b 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -27,7 +27,7 @@
 
 struct dtpm_cpu {
 	struct dtpm dtpm;
-	struct freq_qos_request qos_req;
+	struct range_qos_request qos_req;
 	int cpu;
 };
 
diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index e2cc7bd30862..77f807cf7077 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -77,7 +77,7 @@ struct cpufreq_cooling_device {
 #ifndef CONFIG_SMP
 	struct time_in_idle *idle_time;
 #endif
-	struct freq_qos_request qos_req;
+	struct range_qos_request qos_req;
 };
 
 #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 3f34ebb27525..67092ba80615 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -237,8 +237,8 @@ struct acpi_processor {
 	struct acpi_processor_limit limit;
 	struct thermal_cooling_device *cdev;
 	struct device *dev; /* Processor device. */
-	struct freq_qos_request perflib_req;
-	struct freq_qos_request thermal_req;
+	struct range_qos_request perflib_req;
+	struct range_qos_request thermal_req;
 };
 
 struct acpi_processor_errata {
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 6ad02ad9c7b4..55c3fd4797e6 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -63,7 +63,7 @@ struct amd_aperf_mperf {
 struct amd_cpudata {
 	int	cpu;
 
-	struct	freq_qos_request req[2];
+	struct	range_qos_request req[2];
 	u64	cppc_req_cached;
 
 	u32	highest_perf;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 1c5ca92a0555..08a8ba4bfd2d 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -80,9 +80,9 @@ struct cpufreq_policy {
 	struct work_struct	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
 
-	struct freq_constraints	constraints;
-	struct freq_qos_request	*min_freq_req;
-	struct freq_qos_request	*max_freq_req;
+	struct range_constraints	constraints;
+	struct range_qos_request	*min_freq_req;
+	struct range_qos_request	*max_freq_req;
 
 	struct cpufreq_frequency_table	*freq_table;
 	enum cpufreq_table_sorting freq_table_sorted;
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 4a69d4af3ff8..5f5d967ede32 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -77,25 +77,26 @@ struct pm_qos_flags {
 #define FREQ_QOS_MIN_DEFAULT_VALUE	0
 #define FREQ_QOS_MAX_DEFAULT_VALUE	S32_MAX
 
-enum freq_qos_req_type {
-	FREQ_QOS_MIN = 1,
+enum range_qos_req_type {
+	RANGE_QOS_MIN = 1,
+	RANGE_QOS_MAX,
+	FREQ_QOS_MIN,
 	FREQ_QOS_MAX,
 };
 
-struct freq_constraints {
-	struct pm_qos_constraints min_freq;
-	struct blocking_notifier_head min_freq_notifiers;
-	struct pm_qos_constraints max_freq;
-	struct blocking_notifier_head max_freq_notifiers;
+struct range_constraints {
+	struct pm_qos_constraints lower_bound;
+	struct blocking_notifier_head lower_bound_notifiers;
+	struct pm_qos_constraints upper_bound;
+	struct blocking_notifier_head upper_bound_notifiers;
 };
 
-struct freq_qos_request {
-	enum freq_qos_req_type type;
+struct range_qos_request {
+	enum range_qos_req_type type;
 	struct plist_node pnode;
-	struct freq_constraints *qos;
+	struct range_constraints *qos;
 };
 
-
 enum dev_pm_qos_req_type {
 	DEV_PM_QOS_RESUME_LATENCY = 1,
 	DEV_PM_QOS_LATENCY_TOLERANCE,
@@ -109,7 +110,7 @@ struct dev_pm_qos_request {
 	union {
 		struct plist_node pnode;
 		struct pm_qos_flags_request flr;
-		struct freq_qos_request freq;
+		struct range_qos_request freq;
 	} data;
 	struct device *dev;
 };
@@ -117,7 +118,7 @@ struct dev_pm_qos_request {
 struct dev_pm_qos {
 	struct pm_qos_constraints resume_latency;
 	struct pm_qos_constraints latency_tolerance;
-	struct freq_constraints freq;
+	struct range_constraints freq;
 	struct pm_qos_flags flags;
 	struct dev_pm_qos_request *resume_latency_req;
 	struct dev_pm_qos_request *latency_tolerance_req;
@@ -291,29 +292,29 @@ static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
 }
 #endif
 
-static inline int freq_qos_request_active(struct freq_qos_request *req)
+static inline int freq_qos_request_active(struct range_qos_request *req)
 {
 	return !IS_ERR_OR_NULL(req->qos);
 }
 
-void freq_constraints_init(struct freq_constraints *qos);
+void freq_constraints_init(struct range_constraints *qos);
 
-s32 freq_qos_read_value(struct freq_constraints *qos,
-			enum freq_qos_req_type type);
+s32 freq_qos_read_value(struct range_constraints *qos,
+			enum range_qos_req_type type);
 
-int freq_qos_add_request(struct freq_constraints *qos,
-			 struct freq_qos_request *req,
-			 enum freq_qos_req_type type, s32 value);
-int freq_qos_update_request(struct freq_qos_request *req, s32 new_value);
-int freq_qos_remove_request(struct freq_qos_request *req);
-int freq_qos_apply(struct freq_qos_request *req,
+int freq_qos_add_request(struct range_constraints *qos,
+			 struct range_qos_request *req,
+			 enum range_qos_req_type type, s32 value);
+int freq_qos_update_request(struct range_qos_request *req, s32 new_value);
+int freq_qos_remove_request(struct range_qos_request *req);
+int freq_qos_apply(struct range_qos_request *req,
 		   enum pm_qos_req_action action, s32 value);
 
-int freq_qos_add_notifier(struct freq_constraints *qos,
-			  enum freq_qos_req_type type,
+int freq_qos_add_notifier(struct range_constraints *qos,
+			  enum range_qos_req_type type,
 			  struct notifier_block *notifier);
-int freq_qos_remove_notifier(struct freq_constraints *qos,
-			     enum freq_qos_req_type type,
+int freq_qos_remove_notifier(struct range_constraints *qos,
+			     enum range_qos_req_type type,
 			     struct notifier_block *notifier);
 
 #endif
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 4244b069442e..39919a2eed73 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -440,26 +440,26 @@ static inline bool freq_qos_value_invalid(s32 value)
  * freq_constraints_init - Initialize frequency QoS constraints.
  * @qos: Frequency QoS constraints to initialize.
  */
-void freq_constraints_init(struct freq_constraints *qos)
+void freq_constraints_init(struct range_constraints *qos)
 {
 	struct pm_qos_constraints *c;
 
-	c = &qos->min_freq;
+	c = &qos->lower_bound;
 	plist_head_init(&c->list);
 	c->target_value = FREQ_QOS_MIN_DEFAULT_VALUE;
 	c->default_value = FREQ_QOS_MIN_DEFAULT_VALUE;
 	c->no_constraint_value = FREQ_QOS_MIN_DEFAULT_VALUE;
 	c->type = PM_QOS_MAX;
-	c->notifiers = &qos->min_freq_notifiers;
+	c->notifiers = &qos->lower_bound_notifiers;
 	BLOCKING_INIT_NOTIFIER_HEAD(c->notifiers);
 
-	c = &qos->max_freq;
+	c = &qos->upper_bound;
 	plist_head_init(&c->list);
 	c->target_value = FREQ_QOS_MAX_DEFAULT_VALUE;
 	c->default_value = FREQ_QOS_MAX_DEFAULT_VALUE;
 	c->no_constraint_value = FREQ_QOS_MAX_DEFAULT_VALUE;
 	c->type = PM_QOS_MIN;
-	c->notifiers = &qos->max_freq_notifiers;
+	c->notifiers = &qos->upper_bound_notifiers;
 	BLOCKING_INIT_NOTIFIER_HEAD(c->notifiers);
 }
 
@@ -468,8 +468,8 @@ void freq_constraints_init(struct freq_constraints *qos)
  * @qos: Constraints to evaluate.
  * @type: QoS request type.
  */
-s32 freq_qos_read_value(struct freq_constraints *qos,
-			enum freq_qos_req_type type)
+s32 freq_qos_read_value(struct range_constraints *qos,
+			enum range_qos_req_type type)
 {
 	s32 ret;
 
@@ -477,15 +477,14 @@ s32 freq_qos_read_value(struct freq_constraints *qos,
 	case FREQ_QOS_MIN:
 		ret = IS_ERR_OR_NULL(qos) ?
 			FREQ_QOS_MIN_DEFAULT_VALUE :
-			pm_qos_read_value(&qos->min_freq);
+			pm_qos_read_value(&qos->lower_bound);
 		break;
 	case FREQ_QOS_MAX:
 		ret = IS_ERR_OR_NULL(qos) ?
 			FREQ_QOS_MAX_DEFAULT_VALUE :
-			pm_qos_read_value(&qos->max_freq);
+			pm_qos_read_value(&qos->upper_bound);
 		break;
 	default:
-		WARN_ON(1);
 		ret = 0;
 	}
 
@@ -500,18 +499,18 @@ s32 freq_qos_read_value(struct freq_constraints *qos,
  *
  * This is only meant to be called from inside pm_qos, not drivers.
  */
-int freq_qos_apply(struct freq_qos_request *req,
-			  enum pm_qos_req_action action, s32 value)
+int freq_qos_apply(struct range_qos_request *req,
+		   enum pm_qos_req_action action, s32 value)
 {
 	int ret;
 
 	switch(req->type) {
 	case FREQ_QOS_MIN:
-		ret = pm_qos_update_target(&req->qos->min_freq, &req->pnode,
+		ret = pm_qos_update_target(&req->qos->lower_bound, &req->pnode,
 					   action, value);
 		break;
 	case FREQ_QOS_MAX:
-		ret = pm_qos_update_target(&req->qos->max_freq, &req->pnode,
+		ret = pm_qos_update_target(&req->qos->upper_bound, &req->pnode,
 					   action, value);
 		break;
 	default:
@@ -535,9 +534,9 @@ int freq_qos_apply(struct freq_qos_request *req,
  * Return 1 if the effective constraint value has changed, 0 if the effective
  * constraint value has not changed, or a negative error code on failures.
  */
-int freq_qos_add_request(struct freq_constraints *qos,
-			 struct freq_qos_request *req,
-			 enum freq_qos_req_type type, s32 value)
+int freq_qos_add_request(struct range_constraints *qos,
+			 struct range_qos_request *req,
+			 enum range_qos_req_type type, s32 value)
 {
 	int ret;
 
@@ -571,7 +570,7 @@ EXPORT_SYMBOL_GPL(freq_qos_add_request);
  * Return 1 if the effective constraint value has changed, 0 if the effective
  * constraint value has not changed, or a negative error code on failures.
  */
-int freq_qos_update_request(struct freq_qos_request *req, s32 new_value)
+int freq_qos_update_request(struct range_qos_request *req, s32 new_value)
 {
 	if (!req || freq_qos_value_invalid(new_value))
 		return -EINVAL;
@@ -597,7 +596,7 @@ EXPORT_SYMBOL_GPL(freq_qos_update_request);
  * Return 1 if the effective constraint value has changed, 0 if the effective
  * constraint value has not changed, or a negative error code on failures.
  */
-int freq_qos_remove_request(struct freq_qos_request *req)
+int freq_qos_remove_request(struct range_qos_request *req)
 {
 	int ret;
 
@@ -622,8 +621,8 @@ EXPORT_SYMBOL_GPL(freq_qos_remove_request);
  * @type: Request type.
  * @notifier: Notifier block to add.
  */
-int freq_qos_add_notifier(struct freq_constraints *qos,
-			  enum freq_qos_req_type type,
+int freq_qos_add_notifier(struct range_constraints *qos,
+			  enum range_qos_req_type type,
 			  struct notifier_block *notifier)
 {
 	int ret;
@@ -633,11 +632,11 @@ int freq_qos_add_notifier(struct freq_constraints *qos,
 
 	switch (type) {
 	case FREQ_QOS_MIN:
-		ret = blocking_notifier_chain_register(qos->min_freq.notifiers,
+		ret = blocking_notifier_chain_register(qos->lower_bound.notifiers,
 						       notifier);
 		break;
 	case FREQ_QOS_MAX:
-		ret = blocking_notifier_chain_register(qos->max_freq.notifiers,
+		ret = blocking_notifier_chain_register(qos->upper_bound.notifiers,
 						       notifier);
 		break;
 	default:
@@ -655,8 +654,8 @@ EXPORT_SYMBOL_GPL(freq_qos_add_notifier);
  * @type: Request type.
  * @notifier: Notifier block to remove.
  */
-int freq_qos_remove_notifier(struct freq_constraints *qos,
-			     enum freq_qos_req_type type,
+int freq_qos_remove_notifier(struct range_constraints *qos,
+			     enum range_qos_req_type type,
 			     struct notifier_block *notifier)
 {
 	int ret;
@@ -666,11 +665,11 @@ int freq_qos_remove_notifier(struct freq_constraints *qos,
 
 	switch (type) {
 	case FREQ_QOS_MIN:
-		ret = blocking_notifier_chain_unregister(qos->min_freq.notifiers,
+		ret = blocking_notifier_chain_unregister(qos->lower_bound.notifiers,
 							 notifier);
 		break;
 	case FREQ_QOS_MAX:
-		ret = blocking_notifier_chain_unregister(qos->max_freq.notifiers,
+		ret = blocking_notifier_chain_unregister(qos->upper_bound.notifiers,
 							 notifier);
 		break;
 	default:
-- 
2.34.1

