Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB8077941F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbjHKQQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjHKQQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:16:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E40EB271E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:15:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13E9C139F;
        Fri, 11 Aug 2023 09:16:42 -0700 (PDT)
Received: from pluto.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 738ED3F64C;
        Fri, 11 Aug 2023 09:15:57 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        etienne.carriere@linaro.org, peng.fan@oss.nxp.com,
        chuck.cannon@nxp.com, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 3/6] firmware: arm_scmi: Add v3.2 Clock CONFIG_GET support
Date:   Fri, 11 Aug 2023 17:14:43 +0100
Message-ID: <20230811161446.636253-4-cristian.marussi@arm.com>
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

Add support for v3.2 Clock CONFIG_GET command and related new clock
protocol operation state_get() to retrieve the status of a clock.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 64 +++++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h     |  3 ++
 2 files changed, 67 insertions(+)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 63bd043365cd..aaa95624493d 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -21,6 +21,7 @@ enum scmi_clock_protocol_cmd {
 	CLOCK_NAME_GET = 0x8,
 	CLOCK_RATE_NOTIFY = 0x9,
 	CLOCK_RATE_CHANGE_REQUESTED_NOTIFY = 0xA,
+	CLOCK_CONFIG_GET = 0xB,
 };
 
 enum clk_state {
@@ -59,6 +60,19 @@ struct scmi_msg_clock_config_set_v21 {
 	__le32 oem_config_val;
 };
 
+struct scmi_msg_clock_config_get {
+	__le32 id;
+	__le32 flags;
+#define REGMASK_OEM_TYPE_GET		GENMASK(7, 0)
+};
+
+struct scmi_msg_resp_clock_config_get {
+	__le32 attributes;
+	__le32 config;
+#define IS_CLK_ENABLED(x)		le32_get_bits((x), BIT(0))
+	__le32 oem_config_val;
+};
+
 struct scmi_msg_clock_describe_rates {
 	__le32 id;
 	__le32 rate_index;
@@ -496,6 +510,55 @@ static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id,
 				    NULL_OEM_TYPE, 0, atomic);
 }
 
+static int
+scmi_clock_config_get(const struct scmi_protocol_handle *ph, u32 clk_id,
+		      u8 oem_type, u32 *attributes, bool *enabled,
+		      u32 *oem_val, bool atomic)
+{
+	int ret;
+	u32 flags;
+	struct scmi_xfer *t;
+	struct scmi_msg_clock_config_get *cfg;
+
+	ret = ph->xops->xfer_get_init(ph, CLOCK_CONFIG_GET,
+				      sizeof(*cfg), 0, &t);
+	if (ret)
+		return ret;
+
+	t->hdr.poll_completion = atomic;
+
+	flags = FIELD_PREP(REGMASK_OEM_TYPE_GET, oem_type);
+
+	cfg = t->tx.buf;
+	cfg->id = cpu_to_le32(clk_id);
+	cfg->flags = cpu_to_le32(flags);
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		struct scmi_msg_resp_clock_config_get *resp = t->rx.buf;
+
+		if (attributes)
+			*attributes = le32_to_cpu(resp->attributes);
+
+		if (enabled)
+			*enabled = IS_CLK_ENABLED(resp->config);
+
+		if (oem_val && oem_type)
+			*oem_val = le32_to_cpu(resp->oem_config_val);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_clock_state_get(const struct scmi_protocol_handle *ph,
+				u32 clk_id, bool *enabled, bool atomic)
+{
+	return scmi_clock_config_get(ph, clk_id, NULL_OEM_TYPE, NULL,
+				     enabled, NULL, atomic);
+}
+
 static int scmi_clock_count_get(const struct scmi_protocol_handle *ph)
 {
 	struct clock_info *ci = ph->get_priv(ph);
@@ -526,6 +589,7 @@ static const struct scmi_clk_proto_ops clk_proto_ops = {
 	.rate_set = scmi_clock_rate_set,
 	.enable = scmi_clock_enable,
 	.disable = scmi_clock_disable,
+	.state_get = scmi_clock_state_get,
 };
 
 static int scmi_clk_rate_notify(const struct scmi_protocol_handle *ph,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index b4c631a8d0ac..d11ca4286d57 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -80,6 +80,7 @@ struct scmi_protocol_handle;
  * @rate_set: set the clock rate of a clock
  * @enable: enables the specified clock
  * @disable: disables the specified clock
+ * @state_get: get the status of the specified clock
  */
 struct scmi_clk_proto_ops {
 	int (*count_get)(const struct scmi_protocol_handle *ph);
@@ -94,6 +95,8 @@ struct scmi_clk_proto_ops {
 		      bool atomic);
 	int (*disable)(const struct scmi_protocol_handle *ph, u32 clk_id,
 		       bool atomic);
+	int (*state_get)(const struct scmi_protocol_handle *ph, u32 clk_id,
+			 bool *enabled, bool atomic);
 };
 
 /**
-- 
2.41.0

