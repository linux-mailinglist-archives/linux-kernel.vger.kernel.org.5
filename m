Return-Path: <linux-kernel+bounces-76648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 446B585FA76
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3AFC282410
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A636B1468F8;
	Thu, 22 Feb 2024 13:57:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796B5138489;
	Thu, 22 Feb 2024 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610236; cv=none; b=Q2WJWjPTXYy7aWyYeqQTezxPUJ6kIS22tImRbtXw8xjMUbuZkFJdfwz+/jEMV5tEBeOST619KMUlTdYrjJsA3OGqJVKicXamaeCRWtX6DmFAP9RGiSfJ/efD1r0A+Yx5+D6ez9T5Zck6IgHOOJEGBcUhZIj1BexLjuq7Gc2Vu0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610236; c=relaxed/simple;
	bh=vTobQSrduSBuA1TUKnn4ttuDr4UZ3tWYTkDtSYmJZBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GCBlaNH8u7abyeMtBXyLreqg3Tu1SE10Qe0S49I9BtKQrYyO44fuOFKdxr+N5HiU/1vHuzJTNnLOPG9dGoFeEZDe+n3PqxXpQ5k9fLokbL88SoJr5/CsGA45WzYGrTvFOv/+EshHRULhPP8iks5KVkwZQBpJdl12POC70QnNWKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51ED01007;
	Thu, 22 Feb 2024 05:57:52 -0800 (PST)
Received: from e126645.arm.com (unknown [10.57.50.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B5C83F762;
	Thu, 22 Feb 2024 05:57:11 -0800 (PST)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/3] firmware: arm_scmi: Populate perf commands rate_limit
Date: Thu, 22 Feb 2024 14:56:59 +0100
Message-Id: <20240222135702.2005635-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240222135702.2005635-1-pierre.gondois@arm.com>
References: <20240222135702.2005635-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arm SCMI spec. v3.2, s4.5.3.4 PERFORMANCE_DOMAIN_ATTRIBUTES
defines a per-domain rate_limit for performance requests:
"""
Rate Limit in microseconds, indicating the minimum time
required between successive requests. A value of 0
indicates that this field is not supported by the
platform. This field does not apply to FastChannels.
""""
The field is first defined in SCMI v1.0.

Add support to fetch this value and advertise it through
a rate_limit_get() callback.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 21 +++++++++++++++++++++
 include/linux/scmi_protocol.h    |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 211e8e0aef2c..37c80376bd0a 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -153,6 +153,7 @@ struct perf_dom_info {
 	bool perf_fastchannels;
 	bool level_indexing_mode;
 	u32 opp_count;
+	u32 rate_limit_us;
 	u32 sustained_freq_khz;
 	u32 sustained_perf_level;
 	unsigned long mult_factor;
@@ -266,6 +267,8 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 		if (PROTOCOL_REV_MAJOR(version) >= 0x4)
 			dom_info->level_indexing_mode =
 				SUPPORTS_LEVEL_INDEXING(flags);
+		dom_info->rate_limit_us = le32_to_cpu(attr->rate_limit_us) &
+						GENMASK(19, 0);
 		dom_info->sustained_freq_khz =
 					le32_to_cpu(attr->sustained_freq_khz);
 		dom_info->sustained_perf_level =
@@ -855,6 +858,23 @@ scmi_dvfs_transition_latency_get(const struct scmi_protocol_handle *ph,
 	return dom->opp[dom->opp_count - 1].trans_latency_us * 1000;
 }
 
+static int
+scmi_dvfs_rate_limit_get(const struct scmi_protocol_handle *ph,
+			 u32 domain, u32 *rate_limit)
+{
+	struct perf_dom_info *dom;
+
+	if (!rate_limit)
+		return -EINVAL;
+
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
+
+	*rate_limit = dom->rate_limit_us;
+	return 0;
+}
+
 static int scmi_dvfs_freq_set(const struct scmi_protocol_handle *ph, u32 domain,
 			      unsigned long freq, bool poll)
 {
@@ -970,6 +990,7 @@ static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.level_set = scmi_perf_level_set,
 	.level_get = scmi_perf_level_get,
 	.transition_latency_get = scmi_dvfs_transition_latency_get,
+	.rate_limit_get = scmi_dvfs_rate_limit_get,
 	.device_opps_add = scmi_dvfs_device_opps_add,
 	.freq_set = scmi_dvfs_freq_set,
 	.freq_get = scmi_dvfs_freq_get,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index f2f05fb42d28..acd956ffcb84 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -128,6 +128,8 @@ struct scmi_perf_domain_info {
  * @level_set: sets the performance level of a domain
  * @level_get: gets the performance level of a domain
  * @transition_latency_get: gets the DVFS transition latency for a given device
+ * @rate_limit_get: gets the minimum time (us) required between successive
+ *	requests
  * @device_opps_add: adds all the OPPs for a given device
  * @freq_set: sets the frequency for a given device using sustained frequency
  *	to sustained performance level mapping
@@ -154,6 +156,8 @@ struct scmi_perf_proto_ops {
 			 u32 *level, bool poll);
 	int (*transition_latency_get)(const struct scmi_protocol_handle *ph,
 				      u32 domain);
+	int (*rate_limit_get)(const struct scmi_protocol_handle *ph,
+			      u32 domain, u32 *rate_limit);
 	int (*device_opps_add)(const struct scmi_protocol_handle *ph,
 			       struct device *dev, u32 domain);
 	int (*freq_set)(const struct scmi_protocol_handle *ph, u32 domain,
-- 
2.25.1


