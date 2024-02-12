Return-Path: <linux-kernel+bounces-61553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8879185139A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C002282298
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E858A3B781;
	Mon, 12 Feb 2024 12:33:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16BA3B199
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741193; cv=none; b=r+VwA7q8iy3QZGofR3c9nG9QTvzhWqVn2Q1w0oK43jLOOS4Vp7swI7kZfApFuSNozU+6I7MbCRxweuyYaPoZdd60VwAcjEVHzDZF9epelslcvYZrRNX0N6xuweW9J069Jjdd+7g+ChKdo36dbfQNFc99YKN4uTbT/pyPtqIecHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741193; c=relaxed/simple;
	bh=0FGhoxplAJ+IDq58QH5NR/n1OkM218I0PRVsLtbpa/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARN8KlSNkwOYZ8+jcDgw1jpOj9OugSoM2uxPsJgloeg9aHj4o4Cueoy7XDO/KD8vNvNeJuWep2mmccak3vjvhN7IWj/IQOMghGROrO2E0GTljQLM5D/0nWgW5Bj1V4WxfCeOvD1svn7RkzxZlUwuKpda9nPHBRNXbSh+X+krZ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5EC8FEC;
	Mon, 12 Feb 2024 04:33:52 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E72233F7BD;
	Mon, 12 Feb 2024 04:33:09 -0800 (PST)
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
Subject: [PATCH 06/11] firmware: arm_scmi: Implement Clock .is_notify_supported callback
Date: Mon, 12 Feb 2024 12:32:28 +0000
Message-ID: <20240212123233.1230090-7-cristian.marussi@arm.com>
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

Add a preliminary check to verify if Clock-related notify enable commands
are supported at all by the running platform, and then provide the callback
needed to allow the core SCMI notification subsytem to fine-grain check if
a specific resource domain supports notifications.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 47 ++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 959e48aba1b5..85eda5db40ba 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -158,6 +158,8 @@ struct clock_info {
 	u32 version;
 	int num_clocks;
 	int max_async_req;
+	bool notify_rate_changed_cmd;
+	bool notify_rate_change_requested_cmd;
 	atomic_t cur_async_req;
 	struct scmi_clock_info *clk;
 	int (*clock_config_set)(const struct scmi_protocol_handle *ph,
@@ -204,6 +206,17 @@ scmi_clock_protocol_attributes_get(const struct scmi_protocol_handle *ph,
 	}
 
 	ph->xops->xfer_put(ph, t);
+
+	if (!ret) {
+		if (!ph->hops->protocol_msg_check(ph, CLOCK_RATE_NOTIFY, NULL))
+			ci->notify_rate_changed_cmd = true;
+
+		if (!ph->hops->protocol_msg_check(ph,
+						  CLOCK_RATE_CHANGE_REQUESTED_NOTIFY,
+						  NULL))
+			ci->notify_rate_change_requested_cmd = true;
+	}
+
 	return ret;
 }
 
@@ -329,13 +342,14 @@ scmi_clock_get_permissions(const struct scmi_protocol_handle *ph, u32 clk_id,
 }
 
 static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
-				     u32 clk_id, struct scmi_clock_info *clk,
+				     u32 clk_id, struct clock_info *cinfo,
 				     u32 version)
 {
 	int ret;
 	u32 attributes;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_clock_attributes *attr;
+	struct scmi_clock_info *clk = cinfo->clk + clk_id;
 
 	ret = ph->xops->xfer_get_init(ph, CLOCK_ATTRIBUTES,
 				      sizeof(clk_id), sizeof(*attr), &t);
@@ -368,9 +382,11 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 						    NULL, clk->name,
 						    SCMI_MAX_STR_SIZE);
 
-		if (SUPPORTS_RATE_CHANGED_NOTIF(attributes))
+		if (cinfo->notify_rate_changed_cmd &&
+		    SUPPORTS_RATE_CHANGED_NOTIF(attributes))
 			clk->rate_changed_notifications = true;
-		if (SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(attributes))
+		if (cinfo->notify_rate_change_requested_cmd &&
+		    SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(attributes))
 			clk->rate_change_requested_notifications = true;
 		if (SUPPORTS_PARENT_CLOCK(attributes))
 			scmi_clock_possible_parents(ph, clk_id, clk);
@@ -896,6 +912,28 @@ static const struct scmi_clk_proto_ops clk_proto_ops = {
 	.parent_get = scmi_clock_get_parent,
 };
 
+static bool scmi_clk_notify_supported(const struct scmi_protocol_handle *ph,
+				      u8 evt_id, u32 src_id)
+{
+	bool supported;
+	struct scmi_clock_info *clk;
+	struct clock_info *ci = ph->get_priv(ph);
+
+	if (evt_id >= ARRAY_SIZE(evt_2_cmd))
+		return false;
+
+	clk = scmi_clock_domain_lookup(ci, src_id);
+	if (IS_ERR(clk))
+		return false;
+
+	if (evt_id == SCMI_EVENT_CLOCK_RATE_CHANGED)
+		supported = clk->rate_changed_notifications;
+	else
+		supported = clk->rate_change_requested_notifications;
+
+	return supported;
+}
+
 static int scmi_clk_rate_notify(const struct scmi_protocol_handle *ph,
 				u32 clk_id, int message_id, bool enable)
 {
@@ -980,6 +1018,7 @@ static const struct scmi_event clk_events[] = {
 };
 
 static const struct scmi_event_ops clk_event_ops = {
+	.is_notify_supported = scmi_clk_notify_supported,
 	.get_num_sources = scmi_clk_get_num_sources,
 	.set_notify_enabled = scmi_clk_set_notify_enabled,
 	.fill_custom_report = scmi_clk_fill_custom_report,
@@ -1021,7 +1060,7 @@ static int scmi_clock_protocol_init(const struct scmi_protocol_handle *ph)
 	for (clkid = 0; clkid < cinfo->num_clocks; clkid++) {
 		struct scmi_clock_info *clk = cinfo->clk + clkid;
 
-		ret = scmi_clock_attributes_get(ph, clkid, clk, version);
+		ret = scmi_clock_attributes_get(ph, clkid, cinfo, version);
 		if (!ret)
 			scmi_clock_describe_rates_get(ph, clkid, clk);
 	}
-- 
2.43.0


