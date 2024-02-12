Return-Path: <linux-kernel+bounces-61556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0F685139D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5F41F25C10
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DF53C46E;
	Mon, 12 Feb 2024 12:33:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C822F3BB4D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741198; cv=none; b=p4NOaIMNAqS5C7G245saql84VtLiQZugRK1r+tR+CkcIGQjW4LFJ76eUH2slCRyT/1fKWVZWzHrR/XfzILDGdaPQircM+Uf/3u4hT2b3c+lnZVSywv/4UPvScmHBzGYIWw3TSFqLpn44tBe9HdI1dnj1rd/qkB8BAJDsb48LPog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741198; c=relaxed/simple;
	bh=f3NaXeeCKvIs3nlglu3hHw0k0LBV7uL3e/C7i/VqWeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZCjfXQfkkGqin9oIvn9JJuXU2JYh4kkNokSCBV3zUAhHzyyN11/rQ+8jUfrxwqh64ANrEf73UqSd55VAHF9rByVTmxFo9WnqtmZ6dpprk6CqG+y958eMQ2g3n+MVjfpd1cS5iddCETptbvJd8RXItVFIcjXYndV7PESXHgez6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9FBCFEC;
	Mon, 12 Feb 2024 04:33:57 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 027123F7BD;
	Mon, 12 Feb 2024 04:33:14 -0800 (PST)
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
Subject: [PATCH 09/11] firmware: arm_scmi: Implement Powercap .is_notify_supported callback
Date: Mon, 12 Feb 2024 12:32:31 +0000
Message-ID: <20240212123233.1230090-10-cristian.marussi@arm.com>
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

Add a preliminary check to verify if Powercap-related notify enable
commands are supported at all by the running platform, and then provide the
callback needed to allow the core SCMI notification subsytem to fine-grain
check if a specific resource domain supports notifications.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/powercap.c | 45 +++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index a4c6cd4716fe..aae91f47303e 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -124,6 +124,8 @@ struct scmi_powercap_state {
 struct powercap_info {
 	u32 version;
 	int num_domains;
+	bool notify_cap_cmd;
+	bool notify_measurements_cmd;
 	struct scmi_powercap_state *states;
 	struct scmi_powercap_info *powercaps;
 };
@@ -157,6 +159,18 @@ scmi_powercap_attributes_get(const struct scmi_protocol_handle *ph,
 	}
 
 	ph->xops->xfer_put(ph, t);
+
+	if (!ret) {
+		if (!ph->hops->protocol_msg_check(ph,
+						  POWERCAP_CAP_NOTIFY, NULL))
+			pi->notify_cap_cmd = true;
+
+		if (!ph->hops->protocol_msg_check(ph,
+						  POWERCAP_MEASUREMENTS_NOTIFY,
+						  NULL))
+			pi->notify_measurements_cmd = true;
+	}
+
 	return ret;
 }
 
@@ -200,10 +214,12 @@ scmi_powercap_domain_attributes_get(const struct scmi_protocol_handle *ph,
 		flags = le32_to_cpu(resp->attributes);
 
 		dom_info->id = domain;
-		dom_info->notify_powercap_cap_change =
-			SUPPORTS_POWERCAP_CAP_CHANGE_NOTIFY(flags);
-		dom_info->notify_powercap_measurement_change =
-			SUPPORTS_POWERCAP_MEASUREMENTS_CHANGE_NOTIFY(flags);
+		if (pinfo->notify_cap_cmd)
+			dom_info->notify_powercap_cap_change =
+				SUPPORTS_POWERCAP_CAP_CHANGE_NOTIFY(flags);
+		if (pinfo->notify_measurements_cmd)
+			dom_info->notify_powercap_measurement_change =
+				SUPPORTS_POWERCAP_MEASUREMENTS_CHANGE_NOTIFY(flags);
 		dom_info->async_powercap_cap_set =
 			SUPPORTS_ASYNC_POWERCAP_CAP_SET(flags);
 		dom_info->powercap_cap_config =
@@ -788,6 +804,26 @@ static int scmi_powercap_notify(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+static bool
+scmi_powercap_notify_supported(const struct scmi_protocol_handle *ph,
+			       u8 evt_id, u32 src_id)
+{
+	bool supported;
+	const struct scmi_powercap_info *dom_info;
+	struct powercap_info *pi = ph->get_priv(ph);
+
+	if (evt_id >= ARRAY_SIZE(evt_2_cmd) || src_id >= pi->num_domains)
+		return false;
+
+	dom_info = pi->powercaps + src_id;
+	if (evt_id == SCMI_EVENT_POWERCAP_CAP_CHANGED)
+		supported = dom_info->notify_powercap_cap_change;
+	else if (evt_id == SCMI_EVENT_POWERCAP_MEASUREMENTS_CHANGED)
+		supported = dom_info->notify_powercap_measurement_change;
+
+	return supported;
+}
+
 static int
 scmi_powercap_set_notify_enabled(const struct scmi_protocol_handle *ph,
 				 u8 evt_id, u32 src_id, bool enable)
@@ -904,6 +940,7 @@ static const struct scmi_event powercap_events[] = {
 };
 
 static const struct scmi_event_ops powercap_event_ops = {
+	.is_notify_supported = scmi_powercap_notify_supported,
 	.get_num_sources = scmi_powercap_get_num_sources,
 	.set_notify_enabled = scmi_powercap_set_notify_enabled,
 	.fill_custom_report = scmi_powercap_fill_custom_report,
-- 
2.43.0


