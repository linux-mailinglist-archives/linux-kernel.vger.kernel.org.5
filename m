Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EF476FFBC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjHDLwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHDLwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:52:36 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB36B1;
        Fri,  4 Aug 2023 04:52:34 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 374BqTe5071727;
        Fri, 4 Aug 2023 06:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691149949;
        bh=Sf06WqJO/HbtSUfaOLN3KmMobKyfRUj7yEivxrrLPu4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qkWWA4m8DEaIUZroKT5q/gw+KL9k1Pskts1Q/r+cicHTAZ4Y7oNZIv9batWYyMOGu
         LLqBDPkaE6Kp6g32eMTcGe983+QLUgSaepBCUWXAGJDXDdLyaXZ4yMRSwSIrzE870M
         gBVXwVAWliUrQ96m+VKCi83D4gqwsu4sHO9EZn64=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 374BqTJr004008
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Aug 2023 06:52:29 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Aug 2023 06:52:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Aug 2023 06:52:29 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 374BqRKe130190;
        Fri, 4 Aug 2023 06:52:28 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        "Santosh Shilimkar" <ssantosh@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>,
        "Kevin Hilman" <khilman@baylibre.com>, Vignesh R <vigneshr@ti.com>,
        Georgi Vlaev <g-vlaev@ti.com>, Dhruva Gole <d-gole@ti.com>
Subject: [PATCH V7 2/4] firmware: ti_sci: Add support for querying the firmware caps
Date:   Fri, 4 Aug 2023 17:20:35 +0530
Message-ID: <20230804115037.754994-3-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804115037.754994-1-d-gole@ti.com>
References: <20230804115037.754994-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Georgi Vlaev <g-vlaev@ti.com>

This patch adds support for the TISCI_MSG_QUERY_FW_CAPS
message, used to retrieve the firmware capabilities of the
currently running system firmware. The message belongs to
the TISCI general core message API [1] and is available in
SysFW version 08.04.03 and above. Currently, the message is
supported on devices with split architecture of the system
firmware (DM + TIFS) like AM62x. Old revisions or not yet
supported platforms will NACK this request.

We're using this message locally in ti_sci.c to get the low
power featutes of the FW/SoC. As there's no other kernel
consumers yet, this is not added to struct ti_sci_core_ops.

Also have a has_lpm list of SOCs to ensure that proper LPM
capabilities are used and if any versions of firmware that happen to
advertise garbage value for fw_caps are ignored.
This was needed as the API is buggy on TI SYSFW v09.00 and below

[1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html

Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
[d-gole@ti.com: add workaround for sysfw fw_caps inconsistency]
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/firmware/ti_sci.c | 81 +++++++++++++++++++++++++++++++++++++++
 drivers/firmware/ti_sci.h | 26 +++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index fc35d78b7e42..ac64e328c313 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/soc/ti/ti-msgmgr.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
+#include <linux/sys_soc.h>
 #include <linux/reboot.h>
 
 #include "ti_sci.h"
@@ -1723,6 +1724,86 @@ static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
 	return ret;
 }
 
+/*
+ * This is the list of SoCs not affected by SYSFW Bug causing the fw_caps
+ * to return garbage values.
+ * As and when new SoC's start supporting low power modes, this struct can
+ * be updated with those new SOC family entries.
+ */
+static const struct soc_device_attribute has_lpm[] = {
+	{ .family = "AM62X" },
+	{ /* sentinel */ }
+};
+
+/**
+ * ti_sci_msg_cmd_query_fw_caps() - Get the FW/SoC capabilities
+ * @handle:		Pointer to TI SCI handle
+ * @fw_caps:		Each bit in fw_caps indicating one FW/SOC capability
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_msg_cmd_query_fw_caps(const struct ti_sci_handle *handle,
+					u64 *fw_caps)
+{
+	struct ti_sci_info *info;
+	struct ti_sci_xfer *xfer;
+	struct ti_sci_msg_resp_query_fw_caps *resp;
+	struct device *dev;
+	int ret = 0;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+	dev = info->dev;
+
+	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_QUERY_FW_CAPS,
+				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   sizeof(struct ti_sci_msg_hdr),
+				   sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		dev_err(dev, "Message alloc failed(%d)\n", ret);
+		return ret;
+	}
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret) {
+		dev_err(dev, "Mbox send fail %d\n", ret);
+		goto fail;
+	}
+
+	resp = (struct ti_sci_msg_resp_query_fw_caps *)xfer->xfer_buf;
+
+	if (!ti_sci_is_response_ack(resp)) {
+		ret = -ENODEV;
+		goto fail;
+	}
+
+	/*
+	 * fw_caps 1st bit is used to check Generic capability. Other than
+	 * that the 1:4 bits are used for various LPM capabilities.
+	 * The API is buggy on SYSFW 9.00 and below, on some devices.
+	 * Hence, to avoid any sort of bugs arising due to garbage values
+	 * Let's allow the fw_caps to be set to whatever the firmware
+	 * says only on devices listed under has_lpm. These devices should
+	 * have lpm features tested and implemented in the firmware
+	 * and only then should they be added to has_lpm struct.
+	 * Otherwise, set the value to 1 that is the default.
+	 */
+	if (fw_caps && soc_device_match(has_lpm))
+		*fw_caps = resp->fw_caps;
+	else
+		*fw_caps = resp->fw_caps & MSG_FLAG_CAPS_GENERIC;
+
+fail:
+	ti_sci_put_one_xfer(&info->minfo, xfer);
+
+	return ret;
+}
+
 static int ti_sci_cmd_core_reboot(const struct ti_sci_handle *handle)
 {
 	struct ti_sci_info *info;
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 9c9b4dae9521..56f66368746b 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -19,6 +19,7 @@
 #define TI_SCI_MSG_WAKE_REASON	0x0003
 #define TI_SCI_MSG_GOODBYE	0x0004
 #define TI_SCI_MSG_SYS_RESET	0x0005
+#define TI_SCI_MSG_QUERY_FW_CAPS	0x0022
 
 /* Device requests */
 #define TI_SCI_MSG_SET_DEVICE_STATE	0x0200
@@ -135,6 +136,31 @@ struct ti_sci_msg_req_reboot {
 	struct ti_sci_msg_hdr hdr;
 } __packed;
 
+/**
+ * struct ti_sci_msg_resp_query_fw_caps - Response for query firmware caps
+ * @hdr:	Generic header
+ * @fw_caps:	Each bit in fw_caps indicating one FW/SOC capability
+ *		MSG_FLAG_CAPS_GENERIC: Generic capability (LPM not supported)
+ *		MSG_FLAG_CAPS_LPM_DEEP_SLEEP: Deep Sleep LPM
+ *		MSG_FLAG_CAPS_LPM_MCU_ONLY: MCU only LPM
+ *		MSG_FLAG_CAPS_LPM_STANDBY: Standby LPM
+ *		MSG_FLAG_CAPS_LPM_PARTIAL_IO: Partial IO in LPM
+ *
+ * Response to a generic message with message type TI_SCI_MSG_QUERY_FW_CAPS
+ * providing currently available SOC/firmware capabilities. SoC that don't
+ * support low power modes return only MSG_FLAG_CAPS_GENERIC capability.
+ */
+struct ti_sci_msg_resp_query_fw_caps {
+	struct ti_sci_msg_hdr hdr;
+#define MSG_FLAG_CAPS_GENERIC		TI_SCI_MSG_FLAG(0)
+#define MSG_FLAG_CAPS_LPM_DEEP_SLEEP	TI_SCI_MSG_FLAG(1)
+#define MSG_FLAG_CAPS_LPM_MCU_ONLY	TI_SCI_MSG_FLAG(2)
+#define MSG_FLAG_CAPS_LPM_STANDBY	TI_SCI_MSG_FLAG(3)
+#define MSG_FLAG_CAPS_LPM_PARTIAL_IO	TI_SCI_MSG_FLAG(4)
+#define MSG_MASK_CAPS_LPM		GENMASK_ULL(4, 1)
+	u64 fw_caps;
+} __packed;
+
 /**
  * struct ti_sci_msg_req_set_device_state - Set the desired state of the device
  * @hdr:		Generic header
-- 
2.34.1

