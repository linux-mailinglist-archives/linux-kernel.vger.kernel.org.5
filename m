Return-Path: <linux-kernel+bounces-61557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CE285139E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50D80B2520D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E083C68A;
	Mon, 12 Feb 2024 12:33:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A973C470
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741200; cv=none; b=Y5FH2vpzstC+8DvPfOeeJ4KSQ7kqF617LY1FbB/lu8dZ3xF5fJh17m+mnlA4Xc4Uywi58GIYCXTSbUbRt5Re7gQcW2oAayPFXL4qB2hUfBfDv2kzYo4kIR2wYXc8ZH/Oulw1esJEZyNP8uOsXO9ZoP09KZ2mj/JBfV07YQfFhNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741200; c=relaxed/simple;
	bh=yXhEbCbYSCQ4YzJa83bk7mpJs0n/q8sL94l7OJKG/SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDF7m+LjsXC/x19HoxEqhUJ/SXJ/zjCe5Cv+zssHaE5RLXcEr8A/xiFj9uaGe+IQenyjF6COuW1kqLbt4qUp/cvOvkwS5wowPmf5wMOAVLRGtkWItvpnJm0AIfiVpTXGqZ3R4E1d+1NPNJ8o14uFSDC7MsFUqESY0NODYza/RJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ACBC1063;
	Mon, 12 Feb 2024 04:33:59 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD85F3F7BD;
	Mon, 12 Feb 2024 04:33:16 -0800 (PST)
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
Subject: [PATCH 10/11] firmware: arm_scmi: Use opps_by_lvl to store opps
Date: Mon, 12 Feb 2024 12:32:32 +0000
Message-ID: <20240212123233.1230090-11-cristian.marussi@arm.com>
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

Store all the discovered OPPs into the XArray opps_by_lvl even when
level_indexing mode is not used, since it comes handy to easily retrieve
OPPs by level.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 2627ace5b07f..e20d137a92f6 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -326,9 +326,9 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 					    dom_info->id, NULL, dom_info->info.name,
 					    SCMI_MAX_STR_SIZE);
 
+	xa_init(&dom_info->opps_by_lvl);
 	if (dom_info->level_indexing_mode) {
 		xa_init(&dom_info->opps_by_idx);
-		xa_init(&dom_info->opps_by_lvl);
 		hash_init(dom_info->opps_by_freq);
 	}
 
@@ -371,13 +371,21 @@ static int iter_perf_levels_update_state(struct scmi_iterator_state *st,
 }
 
 static inline void
-process_response_opp(struct scmi_opp *opp, unsigned int loop_idx,
+process_response_opp(struct device *dev, struct perf_dom_info *dom,
+		     struct scmi_opp *opp, unsigned int loop_idx,
 		     const struct scmi_msg_resp_perf_describe_levels *r)
 {
+	int ret;
+
 	opp->perf = le32_to_cpu(r->opp[loop_idx].perf_val);
 	opp->power = le32_to_cpu(r->opp[loop_idx].power);
 	opp->trans_latency_us =
 		le16_to_cpu(r->opp[loop_idx].transition_latency_us);
+
+	ret = xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
+	if (ret)
+		dev_warn(dev, "Failed to add opps_by_lvl at %d - ret:%d\n",
+			 opp->perf, ret);
 }
 
 static inline void
@@ -385,16 +393,21 @@ process_response_opp_v4(struct device *dev, struct perf_dom_info *dom,
 			struct scmi_opp *opp, unsigned int loop_idx,
 			const struct scmi_msg_resp_perf_describe_levels_v4 *r)
 {
+	int ret;
+
 	opp->perf = le32_to_cpu(r->opp[loop_idx].perf_val);
 	opp->power = le32_to_cpu(r->opp[loop_idx].power);
 	opp->trans_latency_us =
 		le16_to_cpu(r->opp[loop_idx].transition_latency_us);
 
+	ret = xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
+	if (ret)
+		dev_warn(dev, "Failed to add opps_by_lvl at %d - ret:%d\n",
+			 opp->perf, ret);
+
 	/* Note that PERF v4 reports always five 32-bit words */
 	opp->indicative_freq = le32_to_cpu(r->opp[loop_idx].indicative_freq);
 	if (dom->level_indexing_mode) {
-		int ret;
-
 		opp->level_index = le32_to_cpu(r->opp[loop_idx].level_index);
 
 		ret = xa_insert(&dom->opps_by_idx, opp->level_index, opp,
@@ -404,12 +417,6 @@ process_response_opp_v4(struct device *dev, struct perf_dom_info *dom,
 				 "Failed to add opps_by_idx at %d - ret:%d\n",
 				 opp->level_index, ret);
 
-		ret = xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
-		if (ret)
-			dev_warn(dev,
-				 "Failed to add opps_by_lvl at %d - ret:%d\n",
-				 opp->perf, ret);
-
 		hash_add(dom->opps_by_freq, &opp->hash, opp->indicative_freq);
 	}
 }
@@ -424,7 +431,8 @@ iter_perf_levels_process_response(const struct scmi_protocol_handle *ph,
 
 	opp = &p->perf_dom->opp[st->desc_index + st->loop_idx];
 	if (PROTOCOL_REV_MAJOR(p->version) <= 0x3)
-		process_response_opp(opp, st->loop_idx, response);
+		process_response_opp(ph->dev, p->perf_dom, opp, st->loop_idx,
+				     response);
 	else
 		process_response_opp_v4(ph->dev, p->perf_dom, opp, st->loop_idx,
 					response);
-- 
2.43.0


