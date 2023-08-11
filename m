Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FF7779420
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbjHKQQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbjHKQP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:15:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 586102712
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:15:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 865B9113E;
        Fri, 11 Aug 2023 09:16:39 -0700 (PDT)
Received: from pluto.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7C3B3F64C;
        Fri, 11 Aug 2023 09:15:54 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        etienne.carriere@linaro.org, peng.fan@oss.nxp.com,
        chuck.cannon@nxp.com, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 2/6] firmware: arm_scmi: Add Clock v3.2 CONFIG_SET support
Date:   Fri, 11 Aug 2023 17:14:42 +0100
Message-ID: <20230811161446.636253-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811161446.636253-1-cristian.marussi@arm.com>
References: <20230811161446.636253-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI v3.2 introduces a new Clock CONFIG_SET message format that can
optionally carry also OEM specific configuration values beside the usual
clock enable/disable requests.

Refactor internal helpers and add support to use such new format when
talking to a v3.2 compliant SCMI platform.

Support existing enable/disable operations across different Clock protocol
versions: this patch still does not add protocol operations to support the
new OEM specific optional configuration capabilities.

No functional change for the SCMI drivers users of the related enable and
disable clock operations.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 88 ++++++++++++++++++++++++++++---
 1 file changed, 80 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 447d29b5fc72..63bd043365cd 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -23,6 +23,13 @@ enum scmi_clock_protocol_cmd {
 	CLOCK_RATE_CHANGE_REQUESTED_NOTIFY = 0xA,
 };
 
+enum clk_state {
+	CLK_STATE_DISABLE,
+	CLK_STATE_ENABLE,
+	CLK_STATE_RESERVED,
+	CLK_STATE_UNCHANGED,
+};
+
 struct scmi_msg_resp_clock_protocol_attributes {
 	__le16 num_clocks;
 	u8 max_async_req;
@@ -31,7 +38,6 @@ struct scmi_msg_resp_clock_protocol_attributes {
 
 struct scmi_msg_resp_clock_attributes {
 	__le32 attributes;
-#define	CLOCK_ENABLE	BIT(0)
 #define SUPPORTS_RATE_CHANGED_NOTIF(x)		((x) & BIT(31))
 #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) & BIT(30))
 #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
@@ -39,9 +45,18 @@ struct scmi_msg_resp_clock_attributes {
 	__le32 clock_enable_latency;
 };
 
-struct scmi_clock_set_config {
+struct scmi_msg_clock_config_set_v2 {
+	__le32 id;
+	__le32 attributes;
+};
+
+struct scmi_msg_clock_config_set_v21 {
 	__le32 id;
 	__le32 attributes;
+#define NULL_OEM_TYPE			0
+#define REGMASK_OEM_TYPE_SET		GENMASK(23, 16)
+#define REGMASK_CLK_STATE		GENMASK(1, 0)
+	__le32 oem_config_val;
 };
 
 struct scmi_msg_clock_describe_rates {
@@ -100,6 +115,9 @@ struct clock_info {
 	int max_async_req;
 	atomic_t cur_async_req;
 	struct scmi_clock_info *clk;
+	int (*clock_config_set)(const struct scmi_protocol_handle *ph,
+				u32 clk_id, enum clk_state state,
+				u8 oem_type, u32 oem_val, bool atomic);
 };
 
 static enum scmi_clock_protocol_cmd evt_2_cmd[] = {
@@ -394,12 +412,47 @@ static int scmi_clock_rate_set(const struct scmi_protocol_handle *ph,
 }
 
 static int
-scmi_clock_config_set(const struct scmi_protocol_handle *ph, u32 clk_id,
-		      u32 config, bool atomic)
+scmi_clock_config_set_v2(const struct scmi_protocol_handle *ph, u32 clk_id,
+			 enum clk_state state, u8 __unused0, u32 __unused1,
+			 bool atomic)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_clock_config_set_v2 *cfg;
+
+	if (state >= CLK_STATE_RESERVED)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, CLOCK_CONFIG_SET,
+				      sizeof(*cfg), 0, &t);
+	if (ret)
+		return ret;
+
+	t->hdr.poll_completion = atomic;
+
+	cfg = t->tx.buf;
+	cfg->id = cpu_to_le32(clk_id);
+	cfg->attributes = cpu_to_le32(state);
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static int
+scmi_clock_config_set_v21(const struct scmi_protocol_handle *ph, u32 clk_id,
+			  enum clk_state state, u8 oem_type, u32 oem_val,
+			  bool atomic)
 {
 	int ret;
+	u32 attrs;
 	struct scmi_xfer *t;
-	struct scmi_clock_set_config *cfg;
+	struct scmi_msg_clock_config_set_v21 *cfg;
+
+	if (state == CLK_STATE_RESERVED ||
+	    (!oem_type && state == CLK_STATE_UNCHANGED))
+		return -EINVAL;
 
 	ret = ph->xops->xfer_get_init(ph, CLOCK_CONFIG_SET,
 				      sizeof(*cfg), 0, &t);
@@ -408,9 +461,16 @@ scmi_clock_config_set(const struct scmi_protocol_handle *ph, u32 clk_id,
 
 	t->hdr.poll_completion = atomic;
 
+	attrs = FIELD_PREP(REGMASK_OEM_TYPE_SET, oem_type) |
+		 FIELD_PREP(REGMASK_CLK_STATE, state);
+
 	cfg = t->tx.buf;
 	cfg->id = cpu_to_le32(clk_id);
-	cfg->attributes = cpu_to_le32(config);
+	cfg->attributes = cpu_to_le32(attrs);
+	/* Clear in any case */
+	cfg->oem_config_val = cpu_to_le32(0);
+	if (oem_type)
+		cfg->oem_config_val = cpu_to_le32(oem_val);
 
 	ret = ph->xops->do_xfer(ph, t);
 
@@ -421,13 +481,19 @@ scmi_clock_config_set(const struct scmi_protocol_handle *ph, u32 clk_id,
 static int scmi_clock_enable(const struct scmi_protocol_handle *ph, u32 clk_id,
 			     bool atomic)
 {
-	return scmi_clock_config_set(ph, clk_id, CLOCK_ENABLE, atomic);
+	struct clock_info *ci = ph->get_priv(ph);
+
+	return ci->clock_config_set(ph, clk_id, CLK_STATE_ENABLE,
+				    NULL_OEM_TYPE, 0, atomic);
 }
 
 static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id,
 			      bool atomic)
 {
-	return scmi_clock_config_set(ph, clk_id, 0, atomic);
+	struct clock_info *ci = ph->get_priv(ph);
+
+	return ci->clock_config_set(ph, clk_id, CLK_STATE_DISABLE,
+				    NULL_OEM_TYPE, 0, atomic);
 }
 
 static int scmi_clock_count_get(const struct scmi_protocol_handle *ph)
@@ -592,6 +658,12 @@ static int scmi_clock_protocol_init(const struct scmi_protocol_handle *ph)
 			scmi_clock_describe_rates_get(ph, clkid, clk);
 	}
 
+	if (PROTOCOL_REV_MAJOR(version) >= 0x2 &&
+	    PROTOCOL_REV_MINOR(version) >= 0x1)
+		cinfo->clock_config_set = scmi_clock_config_set_v21;
+	else
+		cinfo->clock_config_set = scmi_clock_config_set_v2;
+
 	cinfo->version = version;
 	return ph->set_priv(ph, cinfo);
 }
-- 
2.41.0

