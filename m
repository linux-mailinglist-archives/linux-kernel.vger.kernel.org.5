Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702CC779424
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjHKQQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbjHKQQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:16:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF12630EA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:16:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1987C139F;
        Fri, 11 Aug 2023 09:16:50 -0700 (PDT)
Received: from pluto.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A9963F64C;
        Fri, 11 Aug 2023 09:16:05 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        etienne.carriere@linaro.org, peng.fan@oss.nxp.com,
        chuck.cannon@nxp.com, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 6/6] [RFC] firmware: arm_scmi: Add Clock OEM config clock operations
Date:   Fri, 11 Aug 2023 17:14:46 +0100
Message-ID: <20230811161446.636253-7-cristian.marussi@arm.com>
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
index 333d08822f77..d18bf789fc24 100644
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
index d11ca4286d57..e09ac428fa1b 100644
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
2.41.0

