Return-Path: <linux-kernel+bounces-61554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BF685139B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779601F2541F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BBC3BB2A;
	Mon, 12 Feb 2024 12:33:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC583B2B6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741195; cv=none; b=nDleCUwSPlcIhw5ESgB5uvqxsZTddehMhwAON4nGheUxFs/1o3ar9RWnGXOnEuVaneCrbJXYYvapzuRijESmxrBgLSnQRS3e2Ptv5whzVVBUlwY5QedQLT/bm21As/gOndBxv/5DEYYVPufOA/HwI6TJ8kxCfa1k3aq0vHUn5us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741195; c=relaxed/simple;
	bh=wTReGJB67HFBhTtXp137WsohGYKr3VR4+2E7nnpEzNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkAT1CThhUcVRmPeLFi/ggRl4wXYswLG+pMgIUsm0wIYS7rjyCh3fV8Lwz2ZPWmSIWptBTCij2docsG4QC9mdOlyscFQe+z/8klCnROJUocD5L0lPhRX0R0fy2B4JEVRy3wnTycy1EFuyu3Jq0xUW+eXe24kbyRktQfQQDQB44M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 692111063;
	Mon, 12 Feb 2024 04:33:54 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B3853F7BD;
	Mon, 12 Feb 2024 04:33:11 -0800 (PST)
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
Subject: [PATCH 07/11] firmware: arm_scmi: Implement Sensor .is_notify_supported callback
Date: Mon, 12 Feb 2024 12:32:29 +0000
Message-ID: <20240212123233.1230090-8-cristian.marussi@arm.com>
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

Add a preliminary check to verify if Sensor-related notify enable commands
are supported at all by the running platform, and then provide the callback
needed to allow the core SCMI notification subsytem to fine-grain check if
a specific resource domain supports notifications.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/sensors.c | 37 ++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 311149965370..7fc5535ca34c 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -215,6 +215,8 @@ struct scmi_sensor_update_notify_payld {
 
 struct sensors_info {
 	u32 version;
+	bool notify_trip_point_cmd;
+	bool notify_continuos_update_cmd;
 	int num_sensors;
 	int max_requests;
 	u64 reg_addr;
@@ -246,6 +248,18 @@ static int scmi_sensor_attributes_get(const struct scmi_protocol_handle *ph,
 	}
 
 	ph->xops->xfer_put(ph, t);
+
+	if (!ret) {
+		if (!ph->hops->protocol_msg_check(ph,
+						  SENSOR_TRIP_POINT_NOTIFY, NULL))
+			si->notify_trip_point_cmd = true;
+
+		if (!ph->hops->protocol_msg_check(ph,
+						  SENSOR_CONTINUOUS_UPDATE_NOTIFY,
+						  NULL))
+			si->notify_continuos_update_cmd = true;
+	}
+
 	return ret;
 }
 
@@ -594,7 +608,8 @@ iter_sens_descr_process_response(const struct scmi_protocol_handle *ph,
 	 * Such bitfields are assumed to be zeroed on non
 	 * relevant fw versions...assuming fw not buggy !
 	 */
-	s->update = SUPPORTS_UPDATE_NOTIFY(attrl);
+	if (si->notify_continuos_update_cmd)
+		s->update = SUPPORTS_UPDATE_NOTIFY(attrl);
 	s->timestamped = SUPPORTS_TIMESTAMP(attrl);
 	if (s->timestamped)
 		s->tstamp_scale = S32_EXT(SENSOR_TSTAMP_EXP(attrl));
@@ -988,6 +1003,25 @@ static const struct scmi_sensor_proto_ops sensor_proto_ops = {
 	.config_set = scmi_sensor_config_set,
 };
 
+static bool scmi_sensor_notify_supported(const struct scmi_protocol_handle *ph,
+					 u8 evt_id, u32 src_id)
+{
+	bool supported = false;
+	const struct scmi_sensor_info *s;
+	struct sensors_info *sinfo = ph->get_priv(ph);
+
+	s = scmi_sensor_info_get(ph, src_id);
+	if (!s)
+		return false;
+
+	if (evt_id == SCMI_EVENT_SENSOR_TRIP_POINT_EVENT)
+		supported = sinfo->notify_trip_point_cmd;
+	else if (evt_id == SCMI_EVENT_SENSOR_UPDATE)
+		supported = s->update;
+
+	return supported;
+}
+
 static int scmi_sensor_set_notify_enabled(const struct scmi_protocol_handle *ph,
 					  u8 evt_id, u32 src_id, bool enable)
 {
@@ -1099,6 +1133,7 @@ static const struct scmi_event sensor_events[] = {
 };
 
 static const struct scmi_event_ops sensor_event_ops = {
+	.is_notify_supported = scmi_sensor_notify_supported,
 	.get_num_sources = scmi_sensor_get_num_sources,
 	.set_notify_enabled = scmi_sensor_set_notify_enabled,
 	.fill_custom_report = scmi_sensor_fill_custom_report,
-- 
2.43.0


