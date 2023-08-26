Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B95B7896D2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 14:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjHZMyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 08:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjHZMx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 08:53:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71BE9173F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 05:53:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8787DD75;
        Sat, 26 Aug 2023 05:54:35 -0700 (PDT)
Received: from pluto.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B1A43F64C;
        Sat, 26 Aug 2023 05:53:53 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        etienne.carriere@foss.st.com, peng.fan@oss.nxp.com,
        chuck.cannon@nxp.com, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 6/6] firmware: arm_scmi: Add Clock OEM config clock operations
Date:   Sat, 26 Aug 2023 13:53:08 +0100
Message-ID: <20230826125308.462328-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230826125308.462328-1-cristian.marussi@arm.com>
References: <20230826125308.462328-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose a couple of new SCMI Clock operations to get and set OEM specific
clock configurations when talking to an SCMI v3.2 compliant.

Issuing such requests against an SCMI platform server not supporting v3.2
extension for OEM specific clock configurations will fail.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 22 ++++++++++++++++++++++
 include/linux/scmi_protocol.h     |  7 +++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 519f4586c47b..19f2ab5e23b0 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -594,6 +594,26 @@ static int scmi_clock_state_get(const struct scmi_protocol_handle *ph,
 				    enabled, NULL, atomic);
 }
 
+static int scmi_clock_config_oem_set(const struct scmi_protocol_handle *ph,
+				     u32 clk_id, u8 oem_type, u32 oem_val,
+				     bool atomic)
+{
+	struct clock_info *ci = ph->get_priv(ph);
+
+	return ci->clock_config_set(ph, clk_id, CLK_STATE_UNCHANGED,
+				    oem_type, oem_val, atomic);
+}
+
+static int scmi_clock_config_oem_get(const struct scmi_protocol_handle *ph,
+				     u32 clk_id, u8 oem_type, u32 *oem_val,
+				     u32 *attributes, bool atomic)
+{
+	struct clock_info *ci = ph->get_priv(ph);
+
+	return ci->clock_config_get(ph, clk_id, oem_type, attributes,
+				    NULL, oem_val, atomic);
+}
+
 static int scmi_clock_count_get(const struct scmi_protocol_handle *ph)
 {
 	struct clock_info *ci = ph->get_priv(ph);
@@ -625,6 +645,8 @@ static const struct scmi_clk_proto_ops clk_proto_ops = {
 	.enable = scmi_clock_enable,
 	.disable = scmi_clock_disable,
 	.state_get = scmi_clock_state_get,
+	.config_oem_get = scmi_clock_config_oem_get,
+	.config_oem_set = scmi_clock_config_oem_set,
 };
 
 static int scmi_clk_rate_notify(const struct scmi_protocol_handle *ph,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index c03cd4510c10..dee2eaf01cb4 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -81,6 +81,8 @@ struct scmi_protocol_handle;
  * @enable: enables the specified clock
  * @disable: disables the specified clock
  * @state_get: get the status of the specified clock
+ * @config_oem_get: get the value of an OEM specific clock config
+ * @config_oem_set: set the value of an OEM specific clock config
  */
 struct scmi_clk_proto_ops {
 	int (*count_get)(const struct scmi_protocol_handle *ph);
@@ -97,6 +99,11 @@ struct scmi_clk_proto_ops {
 		       bool atomic);
 	int (*state_get)(const struct scmi_protocol_handle *ph, u32 clk_id,
 			 bool *enabled, bool atomic);
+	int (*config_oem_get)(const struct scmi_protocol_handle *ph, u32 clk_id,
+			      u8 oem_type, u32 *oem_val, u32 *attributes,
+			      bool atomic);
+	int (*config_oem_set)(const struct scmi_protocol_handle *ph, u32 clk_id,
+			      u8 oem_type, u32 oem_val, bool atomic);
 };
 
 /**
-- 
2.42.0

