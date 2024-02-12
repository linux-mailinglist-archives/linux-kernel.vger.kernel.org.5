Return-Path: <linux-kernel+bounces-61555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A11985139C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D917D28584C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B31D3BB25;
	Mon, 12 Feb 2024 12:33:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813113BB29
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741197; cv=none; b=MGk7g86Zh87tDJUmJVLMoFW/kxqytQvbwk2RCAdpdaqVptx3FBzIUiEA5egAXHWIFRahNoNzqBeVqbZZtH77xuqNJlu66TZuLAjKvIJ893Bzx/EZR8QCpEFnThPTU6wyykAqT7WOXUCdWFobPH9RFbXJWmb9pBcKmbEO4y8JAcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741197; c=relaxed/simple;
	bh=7MvD/ch+A5tGqG+rlOGbr5Kpr5QHYnQ1tNmpJNxdDFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uP5W9MJezjfIax+fF335y5RZ30jtfzS1lX2NOdYO8lREqZwhOO+yJdyqobP4doUdvbLZy5PW9cuzps6BC6DvTngWIOOHJrz8S8B7VXLwJFW8C4VO4Ti5xoQpby3W40vS2j2DusONWDASnwGRxFasoQCvFXT6O35HSqz/+yEoSik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D34911FB;
	Mon, 12 Feb 2024 04:33:56 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E3103F7BD;
	Mon, 12 Feb 2024 04:33:13 -0800 (PST)
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
Subject: [PATCH 08/11] firmware: arm_scmi: Implement Reset .is_notify_supported callback
Date: Mon, 12 Feb 2024 12:32:30 +0000
Message-ID: <20240212123233.1230090-9-cristian.marussi@arm.com>
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

Add a preliminary check to verify if Reset-related notify enable commands
are supported at all by the running platform, and then provide the callback
needed to allow the core SCMI notification subsytem to fine-grain check if
a specific resource domain supports notifications.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/reset.c | 37 ++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 19970d9f9e36..1b318316535e 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -67,6 +67,7 @@ struct reset_dom_info {
 struct scmi_reset_info {
 	u32 version;
 	int num_domains;
+	bool notify_reset_cmd;
 	struct reset_dom_info *dom_info;
 };
 
@@ -89,18 +90,24 @@ static int scmi_reset_attributes_get(const struct scmi_protocol_handle *ph,
 	}
 
 	ph->xops->xfer_put(ph, t);
+
+	if (!ret)
+		if (!ph->hops->protocol_msg_check(ph, RESET_NOTIFY, NULL))
+			pi->notify_reset_cmd = true;
+
 	return ret;
 }
 
 static int
 scmi_reset_domain_attributes_get(const struct scmi_protocol_handle *ph,
-				 u32 domain, struct reset_dom_info *dom_info,
-				 u32 version)
+				 struct scmi_reset_info *pinfo,
+				 u32 domain, u32 version)
 {
 	int ret;
 	u32 attributes;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_reset_domain_attributes *attr;
+	struct reset_dom_info *dom_info = pinfo->dom_info + domain;
 
 	ret = ph->xops->xfer_get_init(ph, RESET_DOMAIN_ATTRIBUTES,
 				      sizeof(domain), sizeof(*attr), &t);
@@ -115,7 +122,9 @@ scmi_reset_domain_attributes_get(const struct scmi_protocol_handle *ph,
 		attributes = le32_to_cpu(attr->attributes);
 
 		dom_info->async_reset = SUPPORTS_ASYNC_RESET(attributes);
-		dom_info->reset_notify = SUPPORTS_NOTIFY_RESET(attributes);
+		if (pinfo->notify_reset_cmd)
+			dom_info->reset_notify =
+				SUPPORTS_NOTIFY_RESET(attributes);
 		dom_info->latency_us = le32_to_cpu(attr->latency);
 		if (dom_info->latency_us == U32_MAX)
 			dom_info->latency_us = 0;
@@ -226,6 +235,20 @@ static const struct scmi_reset_proto_ops reset_proto_ops = {
 	.deassert = scmi_reset_domain_deassert,
 };
 
+static bool scmi_reset_notify_supported(const struct scmi_protocol_handle *ph,
+					u8 evt_id, u32 src_id)
+{
+	struct reset_dom_info *dom;
+	struct scmi_reset_info *pi = ph->get_priv(ph);
+
+	if (evt_id != SCMI_EVENT_RESET_ISSUED || src_id >= pi->num_domains)
+		return false;
+
+	dom = pi->dom_info + src_id;
+
+	return dom->reset_notify;
+}
+
 static int scmi_reset_notify(const struct scmi_protocol_handle *ph,
 			     u32 domain_id, bool enable)
 {
@@ -301,6 +324,7 @@ static const struct scmi_event reset_events[] = {
 };
 
 static const struct scmi_event_ops reset_event_ops = {
+	.is_notify_supported = scmi_reset_notify_supported,
 	.get_num_sources = scmi_reset_get_num_sources,
 	.set_notify_enabled = scmi_reset_set_notify_enabled,
 	.fill_custom_report = scmi_reset_fill_custom_report,
@@ -339,11 +363,8 @@ static int scmi_reset_protocol_init(const struct scmi_protocol_handle *ph)
 	if (!pinfo->dom_info)
 		return -ENOMEM;
 
-	for (domain = 0; domain < pinfo->num_domains; domain++) {
-		struct reset_dom_info *dom = pinfo->dom_info + domain;
-
-		scmi_reset_domain_attributes_get(ph, domain, dom, version);
-	}
+	for (domain = 0; domain < pinfo->num_domains; domain++)
+		scmi_reset_domain_attributes_get(ph, pinfo, domain, version);
 
 	pinfo->version = version;
 	return ph->set_priv(ph, pinfo, version);
-- 
2.43.0


