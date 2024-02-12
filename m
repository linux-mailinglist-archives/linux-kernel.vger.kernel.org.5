Return-Path: <linux-kernel+bounces-61551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3FE851398
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30D11F260B6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668AA3A8EE;
	Mon, 12 Feb 2024 12:33:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345423A28B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741190; cv=none; b=BJ1OsseFgKSScg3gaOgceaJ9B5pG5Hg0z+3BWLRpon8o7gGcVbb9MwOhJhofGaS4fHmdTYL43bysDzl8uVyo/cIRVoZbTEhnokwao4Tt91n2jzljJneiTf0Sd4Ui2ZGSBHapaDgwB2aLx0vBGtyiXXBb/0rgm/C2NykGSCmfTzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741190; c=relaxed/simple;
	bh=EhRH6wggF4z9GA3aEnVE+YklK9O9votDc8JnIxKAR8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCZn9vISN80DdUu6drMcMtw31ojgjDonobnjHPxmDLEbiY88PcfotED3Y7U1v61HPkpRmJFPa7RkfRyUvzkp4WQlymcrpsZk0jMZ+eKSCXQPtfGEhr2Uzo5abvkhWYbqrHmGxcQqVgI4zJP0V5vjpQY/x844VTEEE6ucgP7y+2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59F7F139F;
	Mon, 12 Feb 2024 04:33:49 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BB033F7BD;
	Mon, 12 Feb 2024 04:33:06 -0800 (PST)
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
Subject: [PATCH 04/11] firmware: arm_scmi: Implement Power .is_notify_supported callback
Date: Mon, 12 Feb 2024 12:32:26 +0000
Message-ID: <20240212123233.1230090-5-cristian.marussi@arm.com>
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

Add a preliminary check to verify if Power-related notify enable commands
are supported at all by the running platform, and then provide the callback
needed to allow the core SCMI notification subsytem to fine-grain check if
a specific resource domain supports notifications.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/power.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index c2e6b9b4d941..49666bd1d8ac 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -68,6 +68,7 @@ struct power_dom_info {
 
 struct scmi_power_info {
 	u32 version;
+	bool notify_state_change_cmd;
 	int num_domains;
 	u64 stats_addr;
 	u32 stats_size;
@@ -97,13 +98,18 @@ static int scmi_power_attributes_get(const struct scmi_protocol_handle *ph,
 	}
 
 	ph->xops->xfer_put(ph, t);
+
+	if (!ret)
+		if (!ph->hops->protocol_msg_check(ph, POWER_STATE_NOTIFY, NULL))
+			pi->notify_state_change_cmd = true;
+
 	return ret;
 }
 
 static int
 scmi_power_domain_attributes_get(const struct scmi_protocol_handle *ph,
 				 u32 domain, struct power_dom_info *dom_info,
-				 u32 version)
+				 u32 version, bool notify_state_change_cmd)
 {
 	int ret;
 	u32 flags;
@@ -122,7 +128,9 @@ scmi_power_domain_attributes_get(const struct scmi_protocol_handle *ph,
 	if (!ret) {
 		flags = le32_to_cpu(attr->flags);
 
-		dom_info->state_set_notify = SUPPORTS_STATE_SET_NOTIFY(flags);
+		if (notify_state_change_cmd)
+			dom_info->state_set_notify =
+				SUPPORTS_STATE_SET_NOTIFY(flags);
 		dom_info->state_set_async = SUPPORTS_STATE_SET_ASYNC(flags);
 		dom_info->state_set_sync = SUPPORTS_STATE_SET_SYNC(flags);
 		strscpy(dom_info->name, attr->name, SCMI_SHORT_NAME_MAX_SIZE);
@@ -231,6 +239,20 @@ static int scmi_power_request_notify(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+static bool scmi_power_notify_supported(const struct scmi_protocol_handle *ph,
+					u8 evt_id, u32 src_id)
+{
+	struct power_dom_info *dom;
+	struct scmi_power_info *pinfo = ph->get_priv(ph);
+
+	if (evt_id != SCMI_EVENT_POWER_STATE_CHANGED ||
+	    src_id >= pinfo->num_domains)
+		return false;
+
+	dom = pinfo->dom_info + src_id;
+	return dom->state_set_notify;
+}
+
 static int scmi_power_set_notify_enabled(const struct scmi_protocol_handle *ph,
 					 u8 evt_id, u32 src_id, bool enable)
 {
@@ -285,6 +307,7 @@ static const struct scmi_event power_events[] = {
 };
 
 static const struct scmi_event_ops power_event_ops = {
+	.is_notify_supported = scmi_power_notify_supported,
 	.get_num_sources = scmi_power_get_num_sources,
 	.set_notify_enabled = scmi_power_set_notify_enabled,
 	.fill_custom_report = scmi_power_fill_custom_report,
@@ -326,7 +349,8 @@ static int scmi_power_protocol_init(const struct scmi_protocol_handle *ph)
 	for (domain = 0; domain < pinfo->num_domains; domain++) {
 		struct power_dom_info *dom = pinfo->dom_info + domain;
 
-		scmi_power_domain_attributes_get(ph, domain, dom, version);
+		scmi_power_domain_attributes_get(ph, domain, dom, version,
+						 pinfo->notify_state_change_cmd);
 	}
 
 	pinfo->version = version;
-- 
2.43.0


