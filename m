Return-Path: <linux-kernel+bounces-22156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B290829A30
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F7B1F286CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A6D481A8;
	Wed, 10 Jan 2024 12:10:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C16447F72
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD7BE2F4;
	Wed, 10 Jan 2024 04:10:42 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 524BF3F73F;
	Wed, 10 Jan 2024 04:09:56 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: Rework Clock domains info lookups
Date: Wed, 10 Jan 2024 12:09:16 +0000
Message-ID: <20240110120916.2482603-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accessing Clock domains descriptors by the index from the SCMI drivers
can potentially lead to out-of-bound violations if the SCMI drivers
misbehaves.

Use a common helper to check the consistency of such accesses.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index b76ff23721df..ff1aa04e5a10 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -167,6 +167,15 @@ static enum scmi_clock_protocol_cmd evt_2_cmd[] = {
 	CLOCK_RATE_CHANGE_REQUESTED_NOTIFY,
 };
 
+static inline struct scmi_clock_info *
+scmi_clock_domain_lookup(struct clock_info *ci, u32 clk_id)
+{
+	if (clk_id >= ci->num_clocks)
+		return ERR_PTR(-EINVAL);
+
+	return ci->clk + clk_id;
+}
+
 static int
 scmi_clock_protocol_attributes_get(const struct scmi_protocol_handle *ph,
 				   struct clock_info *ci)
@@ -580,10 +589,9 @@ scmi_clock_set_parent(const struct scmi_protocol_handle *ph, u32 clk_id,
 	struct clock_info *ci = ph->get_priv(ph);
 	struct scmi_clock_info *clk;
 
-	if (clk_id >= ci->num_clocks)
-		return -EINVAL;
-
-	clk = ci->clk + clk_id;
+	clk = scmi_clock_domain_lookup(ci, clk_id);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	if (parent_id >= clk->num_parents)
 		return -EINVAL;
@@ -800,10 +808,10 @@ scmi_clock_info_get(const struct scmi_protocol_handle *ph, u32 clk_id)
 	struct scmi_clock_info *clk;
 	struct clock_info *ci = ph->get_priv(ph);
 
-	if (clk_id >= ci->num_clocks)
+	clk = scmi_clock_domain_lookup(ci, clk_id);
+	if (IS_ERR(clk))
 		return NULL;
 
-	clk = ci->clk + clk_id;
 	if (!clk->name[0])
 		return NULL;
 
-- 
2.43.0


