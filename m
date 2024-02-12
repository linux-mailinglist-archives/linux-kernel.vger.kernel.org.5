Return-Path: <linux-kernel+bounces-61558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA81385139F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAAB71C21A77
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910633CF5B;
	Mon, 12 Feb 2024 12:33:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793EA3C680
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741202; cv=none; b=uah3FQ8G9TciA6DCmSjKNi85L2ZoF81cjUrBJrKhsoFthIrkZeo1yIlGpo019mAqg7d2TFV+sZZQcB+JRsbqK75/EWE2M3fFIkL5+Bae292YCWQQyjK4qF3P/Tc+fOrf/Lz27idRzAD+IqRtNtNnHbhUyX8IGur6A7I+PZkRTrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741202; c=relaxed/simple;
	bh=Vq/13jyMTK0Hthb91RLpCC6/kQOlazmQH58gWq/rq14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbLPJ42jchclUbziFNQaNWMc+pz1IKQvO+Ln4RJR+LzttDx4ohY5dxjDOqQkbHLE/wpqIM5J+FUXbiXXQ74fpaUGIkABj2cCxbHUgHVrvOVRtfpYXx9gs3wJ5JMais2d4D7HZx2Ktgif3jdoUpOt328ccIKGZ870UKt9ewVpiog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FF1B139F;
	Mon, 12 Feb 2024 04:34:01 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60AFF3F7BD;
	Mon, 12 Feb 2024 04:33:18 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 11/11] firmware: arm_scmi: Report frequencies in Perf notifications
Date: Mon, 12 Feb 2024 12:32:33 +0000
Message-ID: <20240212123233.1230090-12-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212123233.1230090-1-cristian.marussi@arm.com>
References: <20240212123233.1230090-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the Perf notification report to include pre-calculated frequencies
corresponding to the reported limits/levels event; such frequencies are
properly computed based on the stored known OPPs information taking into
consideration if the current operating mode is level indexed or not.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 69 ++++++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h    |  3 ++
 2 files changed, 72 insertions(+)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index e20d137a92f6..981e327e63e3 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -1055,18 +1055,47 @@ static int scmi_perf_set_notify_enabled(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+static int
+scmi_perf_xlate_opp_to_freq(struct perf_dom_info *dom,
+			    unsigned int index, unsigned long *freq)
+{
+	struct scmi_opp *opp;
+
+	if (!dom || !freq)
+		return -EINVAL;
+
+	if (!dom->level_indexing_mode) {
+		opp = xa_load(&dom->opps_by_lvl, index);
+		if (!opp)
+			return -ENODEV;
+
+		*freq = opp->perf * dom->mult_factor;
+	} else {
+		opp = xa_load(&dom->opps_by_idx, index);
+		if (!opp)
+			return -ENODEV;
+
+		*freq = opp->indicative_freq * dom->mult_factor;
+	}
+
+	return 0;
+}
+
 static void *scmi_perf_fill_custom_report(const struct scmi_protocol_handle *ph,
 					  u8 evt_id, ktime_t timestamp,
 					  const void *payld, size_t payld_sz,
 					  void *report, u32 *src_id)
 {
+	int ret;
 	void *rep = NULL;
+	struct perf_dom_info *dom;
 
 	switch (evt_id) {
 	case SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED:
 	{
 		const struct scmi_perf_limits_notify_payld *p = payld;
 		struct scmi_perf_limits_report *r = report;
+		unsigned long freq_min, freq_max;
 
 		if (sizeof(*p) != payld_sz)
 			break;
@@ -1076,14 +1105,36 @@ static void *scmi_perf_fill_custom_report(const struct scmi_protocol_handle *ph,
 		r->domain_id = le32_to_cpu(p->domain_id);
 		r->range_max = le32_to_cpu(p->range_max);
 		r->range_min = le32_to_cpu(p->range_min);
+		/* Check if the reported domain exist at all */
+		dom = scmi_perf_domain_lookup(ph, r->domain_id);
+		if (IS_ERR(dom))
+			break;
+		/*
+		 * Event will be reported from this point on...
+		 * ...even if, later, xlated frequencies were not retrieved.
+		 */
 		*src_id = r->domain_id;
 		rep = r;
+
+		ret = scmi_perf_xlate_opp_to_freq(dom, r->range_max, &freq_max);
+		if (ret)
+			break;
+
+		ret = scmi_perf_xlate_opp_to_freq(dom, r->range_min, &freq_min);
+		if (ret)
+			break;
+
+		/* Report translated freqs ONLY if both available */
+		r->range_max_freq = freq_max;
+		r->range_min_freq = freq_min;
+
 		break;
 	}
 	case SCMI_EVENT_PERFORMANCE_LEVEL_CHANGED:
 	{
 		const struct scmi_perf_level_notify_payld *p = payld;
 		struct scmi_perf_level_report *r = report;
+		unsigned long freq;
 
 		if (sizeof(*p) != payld_sz)
 			break;
@@ -1091,9 +1142,27 @@ static void *scmi_perf_fill_custom_report(const struct scmi_protocol_handle *ph,
 		r->timestamp = timestamp;
 		r->agent_id = le32_to_cpu(p->agent_id);
 		r->domain_id = le32_to_cpu(p->domain_id);
+		/* Report translated freqs ONLY if available */
 		r->performance_level = le32_to_cpu(p->performance_level);
+		/* Check if the reported domain exist at all */
+		dom = scmi_perf_domain_lookup(ph, r->domain_id);
+		if (IS_ERR(dom))
+			break;
+		/*
+		 * Event will be reported from this point on...
+		 * ...even if, later, xlated frequencies were not retrieved.
+		 */
 		*src_id = r->domain_id;
 		rep = r;
+
+		/* Report translated freqs ONLY if available */
+		ret = scmi_perf_xlate_opp_to_freq(dom, r->performance_level,
+						  &freq);
+		if (ret)
+			break;
+
+		r->performance_level_freq = freq;
+
 		break;
 	}
 	default:
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 0cc40af5519a..9b9351e07a11 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -956,6 +956,8 @@ struct scmi_perf_limits_report {
 	unsigned int	domain_id;
 	unsigned int	range_max;
 	unsigned int	range_min;
+	unsigned long	range_max_freq;
+	unsigned long	range_min_freq;
 };
 
 struct scmi_perf_level_report {
@@ -963,6 +965,7 @@ struct scmi_perf_level_report {
 	unsigned int	agent_id;
 	unsigned int	domain_id;
 	unsigned int	performance_level;
+	unsigned long	performance_level_freq;
 };
 
 struct scmi_sensor_trip_point_report {
-- 
2.43.0


