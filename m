Return-Path: <linux-kernel+bounces-61550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E22E0851396
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706051F2606F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CA83A8D2;
	Mon, 12 Feb 2024 12:33:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBD43A1B2
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741188; cv=none; b=XVIy+3IwOFiCKcZ7wIvXs7z9bDdQftDsWqy1CObDbuwe21F4f+CRfj19PrQcSP4ANE4R89CiaYFb+YoqHLOYtQ9i9urP++A25pwQlyd5fdDDuT2vuDKJDtGnipZ2o/If9PYXNRxMga72lOc6DnTi0+TSeAE+rRD4jdlazxjIaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741188; c=relaxed/simple;
	bh=evkNOnm5oC5eo6hVIW+ZaWP1k6EADRqFYfcbNt8e4+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqnjS9ZMFgga2C7cAi2zJaqtvZX9SdgwmNwbZQrfcwWxuHFjITpHJxf4JUpmQu6ETBdtFrisBx+olxrrb5ZTaTQUFwyA98yyL26QY34NbYKTu/hMXp21eSyabzIz/limN0b+12bYMi+qSZ8aSw+aF3WNR719c9YbIlayELvK/y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6B2911FB;
	Mon, 12 Feb 2024 04:33:47 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7C1B3F7BD;
	Mon, 12 Feb 2024 04:33:04 -0800 (PST)
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
Subject: [PATCH 03/11] firmware: arm_scmi: Implement Perf .is_notify_supported callback
Date: Mon, 12 Feb 2024 12:32:25 +0000
Message-ID: <20240212123233.1230090-4-cristian.marussi@arm.com>
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

Add a preliminary check to verify if Perf-related notify enable commands
are supported at all by the running platform, and then provide the callback
needed to allow the core SCMI notification subsytem to fine-grain check if
a specific resource domain supports notifications.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 45 +++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 9e7b1ee94940..2627ace5b07f 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -182,6 +182,8 @@ struct scmi_perf_info {
 	enum scmi_power_scale power_scale;
 	u64 stats_addr;
 	u32 stats_size;
+	bool notify_lvl_cmd;
+	bool notify_lim_cmd;
 	struct perf_dom_info *dom_info;
 };
 
@@ -222,6 +224,15 @@ static int scmi_perf_attributes_get(const struct scmi_protocol_handle *ph,
 	}
 
 	ph->xops->xfer_put(ph, t);
+
+	if (!ret) {
+		if (!ph->hops->protocol_msg_check(ph, PERF_NOTIFY_LEVEL, NULL))
+			pi->notify_lvl_cmd = true;
+
+		if (!ph->hops->protocol_msg_check(ph, PERF_NOTIFY_LIMITS, NULL))
+			pi->notify_lim_cmd = true;
+	}
+
 	return ret;
 }
 
@@ -239,6 +250,7 @@ static void scmi_perf_xa_destroy(void *data)
 static int
 scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 				struct perf_dom_info *dom_info,
+				bool notify_lim_cmd, bool notify_lvl_cmd,
 				u32 version)
 {
 	int ret;
@@ -260,8 +272,12 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 
 		dom_info->set_limits = SUPPORTS_SET_LIMITS(flags);
 		dom_info->info.set_perf = SUPPORTS_SET_PERF_LVL(flags);
-		dom_info->perf_limit_notify = SUPPORTS_PERF_LIMIT_NOTIFY(flags);
-		dom_info->perf_level_notify = SUPPORTS_PERF_LEVEL_NOTIFY(flags);
+		if (notify_lim_cmd)
+			dom_info->perf_limit_notify =
+				SUPPORTS_PERF_LIMIT_NOTIFY(flags);
+		if (notify_lvl_cmd)
+			dom_info->perf_level_notify =
+				SUPPORTS_PERF_LEVEL_NOTIFY(flags);
 		dom_info->perf_fastchannels = SUPPORTS_PERF_FASTCHANNELS(flags);
 		if (PROTOCOL_REV_MAJOR(version) >= 0x4)
 			dom_info->level_indexing_mode =
@@ -993,6 +1009,27 @@ static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.power_scale_get = scmi_power_scale_get,
 };
 
+static bool scmi_perf_notify_supported(const struct scmi_protocol_handle *ph,
+				       u8 evt_id, u32 src_id)
+{
+	bool supported;
+	struct perf_dom_info *dom;
+
+	if (evt_id >= ARRAY_SIZE(evt_2_cmd))
+		return false;
+
+	dom = scmi_perf_domain_lookup(ph, src_id);
+	if (IS_ERR(dom))
+		return false;
+
+	if (evt_id == SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED)
+		supported = dom->perf_limit_notify;
+	else
+		supported = dom->perf_level_notify;
+
+	return supported;
+}
+
 static int scmi_perf_set_notify_enabled(const struct scmi_protocol_handle *ph,
 					u8 evt_id, u32 src_id, bool enable)
 {
@@ -1082,6 +1119,7 @@ static const struct scmi_event perf_events[] = {
 };
 
 static const struct scmi_event_ops perf_event_ops = {
+	.is_notify_supported = scmi_perf_notify_supported,
 	.get_num_sources = scmi_perf_get_num_sources,
 	.set_notify_enabled = scmi_perf_set_notify_enabled,
 	.fill_custom_report = scmi_perf_fill_custom_report,
@@ -1126,7 +1164,8 @@ static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
 		struct perf_dom_info *dom = pinfo->dom_info + domain;
 
 		dom->id = domain;
-		scmi_perf_domain_attributes_get(ph, dom, version);
+		scmi_perf_domain_attributes_get(ph, dom, pinfo->notify_lim_cmd,
+						pinfo->notify_lvl_cmd, version);
 		scmi_perf_describe_levels_get(ph, dom, version);
 
 		if (dom->perf_fastchannels)
-- 
2.43.0


