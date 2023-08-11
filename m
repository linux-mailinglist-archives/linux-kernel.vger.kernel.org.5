Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E419779422
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbjHKQQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbjHKQQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:16:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DE752D69
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:16:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92DBD113E;
        Fri, 11 Aug 2023 09:16:44 -0700 (PDT)
Received: from pluto.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F39F63F64C;
        Fri, 11 Aug 2023 09:15:59 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        etienne.carriere@linaro.org, peng.fan@oss.nxp.com,
        chuck.cannon@nxp.com, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 4/6] firmware: arm_scmi: Add Clock .state_get support to pre-v3.2
Date:   Fri, 11 Aug 2023 17:14:44 +0100
Message-ID: <20230811161446.636253-5-cristian.marussi@arm.com>
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

Support Clock .state_get operation against SCMI platform servers that do
not support v3.2 CONFIG_GET dedicated command: while talking with these
platforms the command CLOCK_ATTRIBUTES can be used to gather the current
clock states.

Note that, in case of shared resources, the retrieved clock state 'flavour'
(virtual vs physical) depends on the backend SCMI platform server specific
kind of implementation.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 52 ++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index aaa95624493d..333d08822f77 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -132,6 +132,9 @@ struct clock_info {
 	int (*clock_config_set)(const struct scmi_protocol_handle *ph,
 				u32 clk_id, enum clk_state state,
 				u8 oem_type, u32 oem_val, bool atomic);
+	int (*clock_config_get)(const struct scmi_protocol_handle *ph,
+				u32 clk_id, u8 oem_type, u32 *attributes,
+				bool *enabled, u32 *oem_val, bool atomic);
 };
 
 static enum scmi_clock_protocol_cmd evt_2_cmd[] = {
@@ -511,9 +514,9 @@ static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id,
 }
 
 static int
-scmi_clock_config_get(const struct scmi_protocol_handle *ph, u32 clk_id,
-		      u8 oem_type, u32 *attributes, bool *enabled,
-		      u32 *oem_val, bool atomic)
+scmi_clock_config_get_v21(const struct scmi_protocol_handle *ph, u32 clk_id,
+			  u8 oem_type, u32 *attributes, bool *enabled,
+			  u32 *oem_val, bool atomic)
 {
 	int ret;
 	u32 flags;
@@ -552,11 +555,43 @@ scmi_clock_config_get(const struct scmi_protocol_handle *ph, u32 clk_id,
 	return ret;
 }
 
+static int
+scmi_clock_config_get_v2(const struct scmi_protocol_handle *ph, u32 clk_id,
+			 u8 oem_type, u32 *attributes, bool *enabled,
+			 u32 *oem_val, bool atomic)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_resp_clock_attributes *resp;
+
+	if (!enabled)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, CLOCK_ATTRIBUTES,
+				      sizeof(clk_id), sizeof(*resp), &t);
+	if (ret)
+		return ret;
+
+	t->hdr.poll_completion = atomic;
+	put_unaligned_le32(clk_id, t->tx.buf);
+	resp = t->rx.buf;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret)
+		*enabled = IS_CLK_ENABLED(resp->attributes);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
 static int scmi_clock_state_get(const struct scmi_protocol_handle *ph,
 				u32 clk_id, bool *enabled, bool atomic)
 {
-	return scmi_clock_config_get(ph, clk_id, NULL_OEM_TYPE, NULL,
-				     enabled, NULL, atomic);
+	struct clock_info *ci = ph->get_priv(ph);
+
+	return ci->clock_config_get(ph, clk_id, NULL_OEM_TYPE, NULL,
+				    enabled, NULL, atomic);
 }
 
 static int scmi_clock_count_get(const struct scmi_protocol_handle *ph)
@@ -723,10 +758,13 @@ static int scmi_clock_protocol_init(const struct scmi_protocol_handle *ph)
 	}
 
 	if (PROTOCOL_REV_MAJOR(version) >= 0x2 &&
-	    PROTOCOL_REV_MINOR(version) >= 0x1)
+	    PROTOCOL_REV_MINOR(version) >= 0x1) {
 		cinfo->clock_config_set = scmi_clock_config_set_v21;
-	else
+		cinfo->clock_config_get = scmi_clock_config_get_v21;
+	} else {
 		cinfo->clock_config_set = scmi_clock_config_set_v2;
+		cinfo->clock_config_get = scmi_clock_config_get_v2;
+	}
 
 	cinfo->version = version;
 	return ph->set_priv(ph, cinfo);
-- 
2.41.0

