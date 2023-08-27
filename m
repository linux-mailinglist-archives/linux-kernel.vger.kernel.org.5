Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BFD78A378
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjH0Xc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjH0XcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:32:23 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5A3D9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:32:20 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fef56f7222so25614515e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1693179139; x=1693783939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKKysv7DeWgPbTOyNyifgpcbSUovrPlrZuMk8nNVMOo=;
        b=dFgXEbgdDCk8PUU90zCUl0B8csLXO17vnjUIxPsdtE8J47/h8mcK13ZrFFzAh+tiqZ
         PF54exyacLV7X92B/oLbETb3PzAeqC4zzyiJZAzalwS7xuVoBko4njA7wbU7xhOPS1aQ
         1AH+oDmWzaBZi2Wyu74x5RwgFEPPZco5BiDcGlz2kV/Ws3IblSlm/6mWJYG/Bo+RaRhO
         KC4cpw58xcVuHa08WI3aRKsCtz2iIJG/usDO23U5RbwVZbE+2/Ya7IzdUY0hMF19WrR9
         9lBB4+HDGKCkOJ71CpoITQpIGocTiBtfJzhqJwse/XW+FQ9JGWM39yFHYkAJ/zxAqHPY
         CrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693179139; x=1693783939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKKysv7DeWgPbTOyNyifgpcbSUovrPlrZuMk8nNVMOo=;
        b=iJ+EvP9yopxbUxIpWrg2PI1AuNwQN00cnu53Q+tALP8nIRnRkD90/dw08KgyP2oKp6
         gTNN09JrSbpuAP7o4Jt8R3Q9pqKSjsljiULTgrejL8Nh0JzNCu8cDd9iJKWqh2VkXKHa
         S/jn5rju5YPIsXqh3A0jNS8zLlxiGVWFkKa+K8hjju+Od2sqemVMk6bmDGDWj7V3DB/+
         m3KXhbkvHpsl2WvEGq6nfq+IcC56/dPe67x6WNNpmSIPsjvUU7CssiF0h3G4fWTbPNVP
         k5PNlqByyWhf0SvHmYTCIlYG/cm6tVc+Cd+dWJqeeDVIZDaez16U5MjnIpi6eu1n04SB
         T7oQ==
X-Gm-Message-State: AOJu0YyE2qDmuxL0+gljbv08LK5SlONh8vUgI/UYfoe1AOOv4t5Ys25N
        6e41A+J2cY0JzUpc9Q+/+nkA7A==
X-Google-Smtp-Source: AGHT+IF9StEg0qazpZWzlZFuMzkvYcK1GqvIslrZtcKvNrbYJs1UMmIl4VRr/NlseTjAs9Khgatvkg==
X-Received: by 2002:a05:600c:ac8:b0:401:bd2e:49f2 with SMTP id c8-20020a05600c0ac800b00401bd2e49f2mr4200758wmr.0.1693179138917;
        Sun, 27 Aug 2023 16:32:18 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c029500b003fe1a96845bsm12220395wmk.2.2023.08.27.16.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 16:32:18 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 5/7] sched/schedutil: Add a new tunable to dictate response time
Date:   Mon, 28 Aug 2023 00:32:01 +0100
Message-Id: <20230827233203.1315953-6-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230827233203.1315953-1-qyousef@layalina.io>
References: <20230827233203.1315953-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new tunable, response_time_ms,  allow us to speed up or slow down
the response time of the policy to meet the perf, power and thermal
characteristic desired by the user/sysadmin. There's no single universal
trade-off that we can apply for all systems even if they use the same
SoC. The form factor of the system, the dominant use case, and in case
of battery powered systems, the size of the battery and presence or
absence of active cooling can play a big role on what would be best to
use.

The new tunable provides sensible defaults, but yet gives the power to
control the response time to the user/sysadmin, if they wish to.

This tunable is applied when we map the util into frequency.

TODO: to retain previous behavior, we must multiply default time with
80%..

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 Documentation/admin-guide/pm/cpufreq.rst | 19 ++++++-
 kernel/sched/cpufreq_schedutil.c         | 70 +++++++++++++++++++++++-
 2 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
index 6adb7988e0eb..c43df0e716a7 100644
--- a/Documentation/admin-guide/pm/cpufreq.rst
+++ b/Documentation/admin-guide/pm/cpufreq.rst
@@ -417,7 +417,7 @@ is passed by the scheduler to the governor callback which causes the frequency
 to go up to the allowed maximum immediately and then draw back to the value
 returned by the above formula over time.
 
-This governor exposes only one tunable:
+This governor exposes two tunables:
 
 ``rate_limit_us``
 	Minimum time (in microseconds) that has to pass between two consecutive
@@ -427,6 +427,23 @@ This governor exposes only one tunable:
 	The purpose of this tunable is to reduce the scheduler context overhead
 	of the governor which might be excessive without it.
 
+``respone_time_ms``
+	Amount of time (in milliseconds) required to ramp the policy from
+	lowest to highest frequency. Can be decreased to speed up the
+	responsiveness of the system, or increased to slow the system down in
+	hope to save power. The best perf/watt will depend on the system
+	characteristics and the dominant workload you expect to run. For
+	userspace that has smart context on the type of workload running (like
+	in Android), one can tune this to suite the demand of that workload.
+
+	Note that when slowing the response down, you can end up effectively
+	chopping off the top frequencies for that policy as the util is capped
+	to 1024. On HMP systems where some CPUs have a capacity less than 1024,
+	unless affinity is used, the task would have probably migrated to
+	a bigger core before you reach the max performance of the policy. If
+	they're locked to that policy, then they should reach the max
+	performance after the specified time.
+
 This governor generally is regarded as a replacement for the older `ondemand`_
 and `conservative`_ governors (described below), as it is simpler and more
 tightly integrated with the CPU scheduler, its overhead in terms of CPU context
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 04aa06846f31..42f4c4100902 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -11,6 +11,7 @@
 struct sugov_tunables {
 	struct gov_attr_set	attr_set;
 	unsigned int		rate_limit_us;
+	unsigned int		response_time_ms;
 };
 
 struct sugov_policy {
@@ -22,6 +23,7 @@ struct sugov_policy {
 	raw_spinlock_t		update_lock;
 	u64			last_freq_update_time;
 	s64			freq_update_delay_ns;
+	unsigned int		freq_response_time_ms;
 	unsigned int		next_freq;
 	unsigned int		cached_raw_freq;
 
@@ -59,6 +61,45 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
 
 /************************ Governor internals ***********************/
 
+static inline u64 sugov_calc_freq_response_ms(struct sugov_policy *sg_policy)
+{
+	int cpu = cpumask_first(sg_policy->policy->cpus);
+	unsigned long cap = capacity_orig_of(cpu);
+
+	return approximate_runtime(cap);
+}
+
+/*
+ * Shrink or expand how long it takes to reach the maximum performance of the
+ * policy.
+ *
+ * sg_policy->freq_response_time_ms is a constant value defined by PELT
+ * HALFLIFE and the capacity of the policy (assuming HMP systems).
+ *
+ * sg_policy->tunables->response_time_ms is a user defined response time. By
+ * setting it lower than sg_policy->freq_response_time_ms, the system will
+ * respond faster to changes in util, which will result in reaching maximum
+ * performance point quicker. By setting it higher, it'll slow down the amount
+ * of time required to reach the maximum OPP.
+ *
+ * This should be applied when selecting the frequency. By default no
+ * conversion is done and we should return util as-is.
+ */
+static inline unsigned long
+sugov_apply_response_time(struct sugov_policy *sg_policy, unsigned long util)
+{
+	unsigned long mult;
+
+	if (sg_policy->freq_response_time_ms == sg_policy->tunables->response_time_ms)
+		return util;
+
+	mult = sg_policy->freq_response_time_ms * SCHED_CAPACITY_SCALE;
+	mult /=	sg_policy->tunables->response_time_ms;
+	mult *= util;
+
+	return mult >> SCHED_CAPACITY_SHIFT;
+}
+
 static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 {
 	s64 delta_ns;
@@ -143,6 +184,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	unsigned int freq = arch_scale_freq_invariant() ?
 				policy->cpuinfo.max_freq : policy->cur;
 
+	util = sugov_apply_response_time(sg_policy, util);
 	freq = map_util_freq(util, freq, max);
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
@@ -539,8 +581,32 @@ rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf, size_t count
 
 static struct governor_attr rate_limit_us = __ATTR_RW(rate_limit_us);
 
+static ssize_t response_time_ms_show(struct gov_attr_set *attr_set, char *buf)
+{
+	struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
+
+	return sprintf(buf, "%u\n", tunables->response_time_ms);
+}
+
+static ssize_t
+response_time_ms_store(struct gov_attr_set *attr_set, const char *buf, size_t count)
+{
+	struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
+	unsigned int response_time_ms;
+
+	if (kstrtouint(buf, 10, &response_time_ms))
+		return -EINVAL;
+
+	tunables->response_time_ms = response_time_ms;
+
+	return count;
+}
+
+static struct governor_attr response_time_ms = __ATTR_RW(response_time_ms);
+
 static struct attribute *sugov_attrs[] = {
 	&rate_limit_us.attr,
+	&response_time_ms.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(sugov);
@@ -704,6 +770,7 @@ static int sugov_init(struct cpufreq_policy *policy)
 	}
 
 	tunables->rate_limit_us = cpufreq_policy_transition_delay_us(policy);
+	tunables->response_time_ms = sugov_calc_freq_response_ms(sg_policy);
 
 	policy->governor_data = sg_policy;
 	sg_policy->tunables = tunables;
@@ -763,7 +830,8 @@ static int sugov_start(struct cpufreq_policy *policy)
 	void (*uu)(struct update_util_data *data, u64 time, unsigned int flags);
 	unsigned int cpu;
 
-	sg_policy->freq_update_delay_ns	= sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
+	sg_policy->freq_update_delay_ns		= sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
+	sg_policy->freq_response_time_ms	= sugov_calc_freq_response_ms(sg_policy);
 	sg_policy->last_freq_update_time	= 0;
 	sg_policy->next_freq			= 0;
 	sg_policy->work_in_progress		= false;
-- 
2.34.1

