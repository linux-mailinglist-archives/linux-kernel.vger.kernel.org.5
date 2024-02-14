Return-Path: <linux-kernel+bounces-65808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC57F85521F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829F328F2CA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7439F12D754;
	Wed, 14 Feb 2024 18:30:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331ED12CD92
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935441; cv=none; b=J9zCxWjoq7+2QsjUBO/gmvDL91rNSAJIXps8HrfFmxf/i4QvQ+llYUgYI00xJ1wJaU1q0WPJJnpni4C1evT4AdQO2DtY7+0+SffdZysw56SK2yQfQiN5xxJ1iKRpOmcftFbZZppDli09Axgl0jmJ0v9oTNOVfAl/M+KleHpBY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935441; c=relaxed/simple;
	bh=xq9MVF5FMpmg0wbRQ2f/6kGNHVmkgomTX1MR7bkw9HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTBas1Ku06BXPixxGwCAxK6G4J7Jl2ZVQvX7J8qioMQ5GfqViSQiyi1B5jvCLfwyftzgqklQ2BC8mVNvWJsQ8nHQqE5y1UWZL8peLxu7PYEDPFsBvaRlPz+Eb/1nMWuuUYXaEDKDU6O6uB7j2k04w4r397OFanQJZws7apA0uBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93EBADA7;
	Wed, 14 Feb 2024 10:31:19 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2A7E3F7B4;
	Wed, 14 Feb 2024 10:30:36 -0800 (PST)
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
Subject: [PATCH 4/7] firmware: arm_scmi: Add standard Clock OEM definitions
Date: Wed, 14 Feb 2024 18:30:03 +0000
Message-ID: <20240214183006.3403207-5-cristian.marussi@arm.com>
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

Add a common enum to define the standard Clock OEM types defined by the
SCMI specification, so as to enable the configuration of such extended
configuration properties with the existent clock protocol operations.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 32 ++++++++++++++++++-------------
 include/linux/scmi_protocol.h     | 14 +++++++++++---
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 9d80ad95b467..4e7f072142b9 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -163,10 +163,12 @@ struct clock_info {
 	struct scmi_clock_info *clk;
 	int (*clock_config_set)(const struct scmi_protocol_handle *ph,
 				u32 clk_id, enum clk_state state,
-				u8 oem_type, u32 oem_val, bool atomic);
+				enum scmi_clock_oem_config oem_type,
+				u32 oem_val, bool atomic);
 	int (*clock_config_get)(const struct scmi_protocol_handle *ph,
-				u32 clk_id, u8 oem_type, u32 *attributes,
-				bool *enabled, u32 *oem_val, bool atomic);
+				u32 clk_id, enum scmi_clock_oem_config oem_type,
+				u32 *attributes, bool *enabled, u32 *oem_val,
+				bool atomic);
 };
 
 static enum scmi_clock_protocol_cmd evt_2_cmd[] = {
@@ -602,7 +604,8 @@ static int scmi_clock_rate_set(const struct scmi_protocol_handle *ph,
 
 static int
 scmi_clock_config_set(const struct scmi_protocol_handle *ph, u32 clk_id,
-		      enum clk_state state, u8 __unused0, u32 __unused1,
+		      enum clk_state state,
+		      enum scmi_clock_oem_config __unused0, u32 __unused1,
 		      bool atomic)
 {
 	int ret;
@@ -692,7 +695,8 @@ scmi_clock_get_parent(const struct scmi_protocol_handle *ph, u32 clk_id,
 /* For SCMI clock v3.0 and onwards */
 static int
 scmi_clock_config_set_v2(const struct scmi_protocol_handle *ph, u32 clk_id,
-			 enum clk_state state, u8 oem_type, u32 oem_val,
+			 enum clk_state state,
+			 enum scmi_clock_oem_config oem_type, u32 oem_val,
 			 bool atomic)
 {
 	int ret;
@@ -765,8 +769,8 @@ static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id,
 /* For SCMI clock v3.0 and onwards */
 static int
 scmi_clock_config_get_v2(const struct scmi_protocol_handle *ph, u32 clk_id,
-			 u8 oem_type, u32 *attributes, bool *enabled,
-			 u32 *oem_val, bool atomic)
+			 enum scmi_clock_oem_config oem_type, u32 *attributes,
+			 bool *enabled, u32 *oem_val, bool atomic)
 {
 	int ret;
 	u32 flags;
@@ -807,8 +811,8 @@ scmi_clock_config_get_v2(const struct scmi_protocol_handle *ph, u32 clk_id,
 
 static int
 scmi_clock_config_get(const struct scmi_protocol_handle *ph, u32 clk_id,
-		      u8 oem_type, u32 *attributes, bool *enabled,
-		      u32 *oem_val, bool atomic)
+		      enum scmi_clock_oem_config oem_type, u32 *attributes,
+		      bool *enabled, u32 *oem_val, bool atomic)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -845,8 +849,9 @@ static int scmi_clock_state_get(const struct scmi_protocol_handle *ph,
 }
 
 static int scmi_clock_config_oem_set(const struct scmi_protocol_handle *ph,
-				     u32 clk_id, u8 oem_type, u32 oem_val,
-				     bool atomic)
+				     u32 clk_id,
+				     enum scmi_clock_oem_config oem_type,
+				     u32 oem_val, bool atomic)
 {
 	struct clock_info *ci = ph->get_priv(ph);
 	struct scmi_clock_info *clk;
@@ -863,8 +868,9 @@ static int scmi_clock_config_oem_set(const struct scmi_protocol_handle *ph,
 }
 
 static int scmi_clock_config_oem_get(const struct scmi_protocol_handle *ph,
-				     u32 clk_id, u8 oem_type, u32 *oem_val,
-				     u32 *attributes, bool atomic)
+				     u32 clk_id,
+				     enum scmi_clock_oem_config oem_type,
+				     u32 *oem_val, u32 *attributes, bool atomic)
 {
 	struct clock_info *ci = ph->get_priv(ph);
 	struct scmi_clock_info *clk;
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index caeca3f51be2..24e8de581744 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -76,6 +76,13 @@ struct scmi_handle;
 struct scmi_device;
 struct scmi_protocol_handle;
 
+enum scmi_clock_oem_config {
+	SCMI_CLOCK_CFG_DUTY_CYCLE = 0x1,
+	SCMI_CLOCK_CFG_PHASE,
+	SCMI_CLOCK_CFG_OEM_START = 0x80,
+	SCMI_CLOCK_CFG_OEM_END = 0xFF,
+};
+
 /**
  * struct scmi_clk_proto_ops - represents the various operations provided
  *	by SCMI Clock Protocol
@@ -108,10 +115,11 @@ struct scmi_clk_proto_ops {
 	int (*state_get)(const struct scmi_protocol_handle *ph, u32 clk_id,
 			 bool *enabled, bool atomic);
 	int (*config_oem_get)(const struct scmi_protocol_handle *ph, u32 clk_id,
-			      u8 oem_type, u32 *oem_val, u32 *attributes,
-			      bool atomic);
+			      enum scmi_clock_oem_config oem_type,
+			      u32 *oem_val, u32 *attributes, bool atomic);
 	int (*config_oem_set)(const struct scmi_protocol_handle *ph, u32 clk_id,
-			      u8 oem_type, u32 oem_val, bool atomic);
+			      enum scmi_clock_oem_config oem_type,
+			      u32 oem_val, bool atomic);
 	int (*parent_get)(const struct scmi_protocol_handle *ph, u32 clk_id, u32 *parent_id);
 	int (*parent_set)(const struct scmi_protocol_handle *ph, u32 clk_id, u32 parent_id);
 };
-- 
2.43.0


