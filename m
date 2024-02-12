Return-Path: <linux-kernel+bounces-61552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284C6851399
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8EB1C21A77
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924323B191;
	Mon, 12 Feb 2024 12:33:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAF33A8DE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741191; cv=none; b=HhWIC5OEMG4jdsDy0pvuMzVFvYPxh+zZfETopzW10xM6tpsNNn2uEkTaaNtk3qb+v6YY4HSHJGIG/0P+KxjOhdvhgjsvJQH0VNfBbHGU1JTToURh4VvSL8DJqOoB8ggY9JbqcCuLsjqpwJCLMAcRaosrpHqG6W2wghH638IpwbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741191; c=relaxed/simple;
	bh=jVHR1bg6dtwxToygY7pKHGPE6Yy7UaPmdSrAUqoo5JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7h14M6nRjbHbtALn8FjOr/uHqXZCKPD0Uobt4S+PJxxzrus/LTBpHTaMIDav1vHxYsIQ7WRkWpa5VaLZOncJw+AoAy0tGL5Cw6ZCcbNkROu7/enAoRtjrC6rsLedDSHoCJe8ctLHDhgCYNIMpXJYP+DvYSKzizzAPF1vY60W7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D2131063;
	Mon, 12 Feb 2024 04:33:51 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F0ED3F7BD;
	Mon, 12 Feb 2024 04:33:08 -0800 (PST)
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
Subject: [PATCH 05/11] firmware: arm_scmi: Implement SysPower .is_notify_supported callback
Date: Mon, 12 Feb 2024 12:32:27 +0000
Message-ID: <20240212123233.1230090-6-cristian.marussi@arm.com>
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

Add a preliminary check to verify if SysPower-related notify enable
commands are supported at all by the running platform, and then provide the
callback needed to allow the core SCMI notification subsytem to fine-grain
check if a specific resource domain supports notifications.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/system.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
index 1621da97bcbb..b6358c155f7f 100644
--- a/drivers/firmware/arm_scmi/system.c
+++ b/drivers/firmware/arm_scmi/system.c
@@ -36,8 +36,20 @@ struct scmi_system_power_state_notifier_payld {
 struct scmi_system_info {
 	u32 version;
 	bool graceful_timeout_supported;
+	bool power_state_notify_cmd;
 };
 
+static bool scmi_system_notify_supported(const struct scmi_protocol_handle *ph,
+					 u8 evt_id, u32 src_id)
+{
+	struct scmi_system_info *pinfo = ph->get_priv(ph);
+
+	if (evt_id != SCMI_EVENT_SYSTEM_POWER_STATE_NOTIFIER)
+		return false;
+
+	return pinfo->power_state_notify_cmd;
+}
+
 static int scmi_system_request_notify(const struct scmi_protocol_handle *ph,
 				      bool enable)
 {
@@ -114,6 +126,7 @@ static const struct scmi_event system_events[] = {
 };
 
 static const struct scmi_event_ops system_event_ops = {
+	.is_notify_supported = scmi_system_notify_supported,
 	.set_notify_enabled = scmi_system_set_notify_enabled,
 	.fill_custom_report = scmi_system_fill_custom_report,
 };
@@ -147,6 +160,9 @@ static int scmi_system_protocol_init(const struct scmi_protocol_handle *ph)
 	if (PROTOCOL_REV_MAJOR(pinfo->version) >= 0x2)
 		pinfo->graceful_timeout_supported = true;
 
+	if (!ph->hops->protocol_msg_check(ph, SYSTEM_POWER_STATE_NOTIFY, NULL))
+		pinfo->power_state_notify_cmd = true;
+
 	return ph->set_priv(ph, pinfo, version);
 }
 
-- 
2.43.0


