Return-Path: <linux-kernel+bounces-65807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D54DD85521D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875331F29D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D3F12C527;
	Wed, 14 Feb 2024 18:30:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA4812BF38
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935439; cv=none; b=Lrcu6tXW2Jiua/+jVKwSWGbHU31O8qTaKukeGMj90Xg1MuoqPgiQatbfv/biByt2rFg2ba9G7Zez9ECNwW6TMrFOG/3QerH+NLzMS6GfxW8bptanJm8SFW2ipen/r9Fa3t5UVtj1UzOqxQqRcLQw95Y/kUCSkEw3wq53QlvaDSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935439; c=relaxed/simple;
	bh=kKN6YUR8GBEY6aJ6XdGiwTYMxulxghywt7sHCnYQMJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTADOTT4g4IncfrsqfTvzF8ph8+/ugNDt31rDsudK0l740OLqC5OAQ7Rjn4A6kSk+hJbuM87UuX58OUF6jIjwEEzXIu53XczWHMsc3e+oD0pwWtSf6CyitHH7SjYebhaAFhTFy6+Ttu9qKYxQHuMoScc59UBhfYXSuNx+6sakT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A678E1FB;
	Wed, 14 Feb 2024 10:31:17 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD7EB3F7B4;
	Wed, 14 Feb 2024 10:30:34 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 3/7] firmware: arm_scmi: Add Clock check for extended config support
Date: Wed, 14 Feb 2024 18:30:02 +0000
Message-ID: <20240214183006.3403207-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214183006.3403207-1-cristian.marussi@arm.com>
References: <20240214183006.3403207-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCMI v3.2 added support to set/get Clock custom OEM types; such support is
conditionally present, though, depending on an extended config attribute
bit possibly advertised by the platform server on a per-domain base.

Add a check to verify if OEM types are supported before allowing any kind
of OEM-specific get/set operation and also a check around all Clock v3.2
features.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
base-commit: 7dd3d11f4dac301e958f00e18db4901a35cefc70
---
 drivers/firmware/arm_scmi/clock.c | 33 +++++++++++++++++++++++++------
 include/linux/scmi_protocol.h     |  1 +
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 959e48aba1b5..9d80ad95b467 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -54,6 +54,7 @@ struct scmi_msg_resp_clock_attributes {
 #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) & BIT(30))
 #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
 #define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
+#define SUPPORTS_EXTENDED_CONFIG(x)		((x) & BIT(27))
 #define SUPPORTS_GET_PERMISSIONS(x)		((x) & BIT(1))
 	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 	__le32 clock_enable_latency;
@@ -372,10 +373,14 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 			clk->rate_changed_notifications = true;
 		if (SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(attributes))
 			clk->rate_change_requested_notifications = true;
-		if (SUPPORTS_PARENT_CLOCK(attributes))
-			scmi_clock_possible_parents(ph, clk_id, clk);
-		if (SUPPORTS_GET_PERMISSIONS(attributes))
-			scmi_clock_get_permissions(ph, clk_id, clk);
+		if (PROTOCOL_REV_MAJOR(version) >= 0x3) {
+			if (SUPPORTS_PARENT_CLOCK(attributes))
+				scmi_clock_possible_parents(ph, clk_id, clk);
+			if (SUPPORTS_GET_PERMISSIONS(attributes))
+				scmi_clock_get_permissions(ph, clk_id, clk);
+			if (SUPPORTS_EXTENDED_CONFIG(attributes))
+				clk->extended_config = true;
+		}
 	}
 
 	return ret;
@@ -684,7 +689,7 @@ scmi_clock_get_parent(const struct scmi_protocol_handle *ph, u32 clk_id,
 	return ret;
 }
 
-/* For SCMI clock v2.1 and onwards */
+/* For SCMI clock v3.0 and onwards */
 static int
 scmi_clock_config_set_v2(const struct scmi_protocol_handle *ph, u32 clk_id,
 			 enum clk_state state, u8 oem_type, u32 oem_val,
@@ -757,7 +762,7 @@ static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id,
 				    NULL_OEM_TYPE, 0, atomic);
 }
 
-/* For SCMI clock v2.1 and onwards */
+/* For SCMI clock v3.0 and onwards */
 static int
 scmi_clock_config_get_v2(const struct scmi_protocol_handle *ph, u32 clk_id,
 			 u8 oem_type, u32 *attributes, bool *enabled,
@@ -844,6 +849,14 @@ static int scmi_clock_config_oem_set(const struct scmi_protocol_handle *ph,
 				     bool atomic)
 {
 	struct clock_info *ci = ph->get_priv(ph);
+	struct scmi_clock_info *clk;
+
+	clk = scmi_clock_domain_lookup(ci, clk_id);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	if (!clk->extended_config)
+		return -EOPNOTSUPP;
 
 	return ci->clock_config_set(ph, clk_id, CLK_STATE_UNCHANGED,
 				    oem_type, oem_val, atomic);
@@ -854,6 +867,14 @@ static int scmi_clock_config_oem_get(const struct scmi_protocol_handle *ph,
 				     u32 *attributes, bool atomic)
 {
 	struct clock_info *ci = ph->get_priv(ph);
+	struct scmi_clock_info *clk;
+
+	clk = scmi_clock_domain_lookup(ci, clk_id);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	if (!clk->extended_config)
+		return -EOPNOTSUPP;
 
 	return ci->clock_config_get(ph, clk_id, oem_type, attributes,
 				    NULL, oem_val, atomic);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 0cc40af5519a..caeca3f51be2 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -50,6 +50,7 @@ struct scmi_clock_info {
 	bool state_ctrl_forbidden;
 	bool rate_ctrl_forbidden;
 	bool parent_ctrl_forbidden;
+	bool extended_config;
 	union {
 		struct {
 			int num_rates;
-- 
2.43.0


