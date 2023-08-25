Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73F17885B4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243786AbjHYL1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243123AbjHYL1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:27:02 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5C52111
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:26:59 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5009969be25so1244457e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692962817; x=1693567617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZyavBljZ6bXtEMO1YiWYQRSGsvRcVG1p9MSq1Bupjk=;
        b=OvylDRGVVO3TdvKJKhoXJim3LUJR/93YBmXecEuCodIYF5tWEawMNzFDaNRE3H4fCg
         EjjDEvon+OrRMoyRmdrGZdgt5eLqVLG/mP49WEBEGOM01ugChlZgSh6ZMPmCXYwzUAHi
         Qfn9s9V7v0mqXJqiv18oVngMRPPmV3U3LfGsjwQsABe716Vr1p4TR49O5PSexKkTyVYI
         6t3GQBBOhqS4ah97cgTTWUtg6EkJhxEp5SkIT/FQQTeSc8F67s3GDy9mdxSc/eStsxV3
         YXZsVHyiexH6E/55BWUhImJ+bXr8eIPPrQsLIX/uMe8T6nfK4J5U8saAajj0lgEK07CG
         UUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962817; x=1693567617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZyavBljZ6bXtEMO1YiWYQRSGsvRcVG1p9MSq1Bupjk=;
        b=ilAOB6lGRUPrWRtdhP0Gw3zLPtMYWdxwxX/YRb8y6vtnZiCxfP75p0slvwyh3SFNuq
         NCOx7613evx8bwvDfjxTZE4DqwUODjs5J8ecuwBZLyeKXS3h7nPPXSbVTov+RQIF8eXv
         KYPghy63Uu4pxrUIwM6JLCvcgHjv4b9+TDdfM3VKfW/6rF35rIPIi4DD/iILWQ8rOcHD
         enfSY5jSi+mzA6TjY5UrkiXTBWZfEb0suRRqsWHEzek9/Gt/k8npObDAQMagZf/K14SV
         Eb3gLUOsmm3L1Lk1f8dqsr2VTCnOQa30kmEniKKdwt/qe0+iCtDSQVjmctPRmkIQ4ja1
         LLog==
X-Gm-Message-State: AOJu0YwW6R2IxXGcitstFYpzeHlT7fji/ftSPl1kCyY7k6W9ocFRaCKY
        lLfKwc5Ey8Yj3NT6xYa98dU71qBaxN45bDeO83yAUA==
X-Google-Smtp-Source: AGHT+IHvNEcavvFkt9u2gx9F7pKes/Di+z4YnJPqsOPsIz14+K9zThP70V4pc8oatR9pZEda3Auhew==
X-Received: by 2002:a05:6512:689:b0:4fd:d64f:c0a6 with SMTP id t9-20020a056512068900b004fdd64fc0a6mr15976438lfe.48.1692962817505;
        Fri, 25 Aug 2023 04:26:57 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id g7-20020ac25387000000b004fb7ac67bbdsm259164lfh.41.2023.08.25.04.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:26:56 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/13] firmware: arm_scmi: Align perf ops to use domain-id as in-parameter
Date:   Fri, 25 Aug 2023 13:26:24 +0200
Message-Id: <20230825112633.236607-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825112633.236607-1-ulf.hansson@linaro.org>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
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

Most scmi_perf_proto_ops are already using an "u32 domain" as an
in-parameter to indicate what performance domain we shall operate upon.
However, some of the ops are using a "struct device *dev", which means that
an additional OF parsing is needed each time the perf ops gets called, to
find the corresponding domain-id.

To avoid the above, but also to make the code more consistent, let's
replace the in-parameter "struct device *dev" with an "u32 domain". Note
that, this requires us to make some corresponding changes to the scmi
cpufreq driver, so let's do that too.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Re-based.

---
 drivers/cpufreq/scmi-cpufreq.c   | 14 +++++++++-----
 drivers/firmware/arm_scmi/perf.c | 22 ++++------------------
 include/linux/scmi_protocol.h    |  6 +++---
 3 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 7d05d48c0337..125e8a8421fb 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -137,7 +137,7 @@ scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
 
 static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 {
-	int ret, nr_opp;
+	int ret, nr_opp, domain;
 	unsigned int latency;
 	struct device *cpu_dev;
 	struct scmi_data *priv;
@@ -149,6 +149,10 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		return -ENODEV;
 	}
 
+	domain = scmi_cpu_domain_id(cpu_dev);
+	if (domain < 0)
+		return domain;
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -187,7 +191,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	  */
 	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
 	if (nr_opp <= 0) {
-		ret = perf_ops->device_opps_add(ph, cpu_dev);
+		ret = perf_ops->device_opps_add(ph, cpu_dev, domain);
 		if (ret) {
 			dev_warn(cpu_dev, "failed to add opps to the device\n");
 			goto out_free_cpumask;
@@ -220,7 +224,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	priv->cpu_dev = cpu_dev;
-	priv->domain_id = scmi_cpu_domain_id(cpu_dev);
+	priv->domain_id = domain;
 
 	policy->driver_data = priv;
 	policy->freq_table = freq_table;
@@ -228,14 +232,14 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	/* SCMI allows DVFS request for any domain from any CPU */
 	policy->dvfs_possible_from_any_cpu = true;
 
-	latency = perf_ops->transition_latency_get(ph, cpu_dev);
+	latency = perf_ops->transition_latency_get(ph, domain);
 	if (!latency)
 		latency = CPUFREQ_ETERNAL;
 
 	policy->cpuinfo.transition_latency = latency;
 
 	policy->fast_switch_possible =
-		perf_ops->fast_switch_possible(ph, cpu_dev);
+		perf_ops->fast_switch_possible(ph, domain);
 
 	return 0;
 
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index d20bb6b8abfa..092b51cf9596 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -795,17 +795,13 @@ static int scmi_dev_domain_id(struct device *dev)
 }
 
 static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
-				     struct device *dev)
+				     struct device *dev, u32 domain)
 {
-	int idx, ret, domain;
+	int idx, ret;
 	unsigned long freq;
 	struct scmi_opp *opp;
 	struct perf_dom_info *dom;
 
-	domain = scmi_dev_domain_id(dev);
-	if (domain < 0)
-		return -EINVAL;
-
 	dom = scmi_perf_domain_lookup(ph, domain);
 	if (IS_ERR(dom))
 		return PTR_ERR(dom);
@@ -838,15 +834,10 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 
 static int
 scmi_dvfs_transition_latency_get(const struct scmi_protocol_handle *ph,
-				 struct device *dev)
+				 u32 domain)
 {
-	int domain;
 	struct perf_dom_info *dom;
 
-	domain = scmi_dev_domain_id(dev);
-	if (domain < 0)
-		return -EINVAL;
-
 	dom = scmi_perf_domain_lookup(ph, domain);
 	if (IS_ERR(dom))
 		return PTR_ERR(dom);
@@ -942,15 +933,10 @@ static int scmi_dvfs_est_power_get(const struct scmi_protocol_handle *ph,
 }
 
 static bool scmi_fast_switch_possible(const struct scmi_protocol_handle *ph,
-				      struct device *dev)
+				      u32 domain)
 {
-	int domain;
 	struct perf_dom_info *dom;
 
-	domain = scmi_dev_domain_id(dev);
-	if (domain < 0)
-		return false;
-
 	dom = scmi_perf_domain_lookup(ph, domain);
 	if (IS_ERR(dom))
 		return false;
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 71923ae63b01..bf6b0be1890e 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -140,9 +140,9 @@ struct scmi_perf_proto_ops {
 			 u32 *level, bool poll);
 	int (*device_domain_id)(struct device *dev);
 	int (*transition_latency_get)(const struct scmi_protocol_handle *ph,
-				      struct device *dev);
+				      u32 domain);
 	int (*device_opps_add)(const struct scmi_protocol_handle *ph,
-			       struct device *dev);
+			       struct device *dev, u32 domain);
 	int (*freq_set)(const struct scmi_protocol_handle *ph, u32 domain,
 			unsigned long rate, bool poll);
 	int (*freq_get)(const struct scmi_protocol_handle *ph, u32 domain,
@@ -150,7 +150,7 @@ struct scmi_perf_proto_ops {
 	int (*est_power_get)(const struct scmi_protocol_handle *ph, u32 domain,
 			     unsigned long *rate, unsigned long *power);
 	bool (*fast_switch_possible)(const struct scmi_protocol_handle *ph,
-				     struct device *dev);
+				     u32 domain);
 	enum scmi_power_scale (*power_scale_get)(const struct scmi_protocol_handle *ph);
 };
 
-- 
2.34.1

