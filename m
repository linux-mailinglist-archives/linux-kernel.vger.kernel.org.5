Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C986376E072
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjHCGnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjHCGn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:43:26 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2499EE4C;
        Wed,  2 Aug 2023 23:43:25 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3736hGP5092012;
        Thu, 3 Aug 2023 01:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691044997;
        bh=VeoVsdsgVkCJrOnZ98Oebz58niZg49T9Cb4r+m07XsA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Meoo2BLUMA6fdIbfXDzve3DaaRo8e8Q/N3v5G6CIrlFXF7Jng7NG2jWHbN7nW/7Te
         dwpw+yZl017WSGRzDFRu/XLb1U8hu0vmFnmIPf0O4OPPKUXEyOWMqF9W83UjJIv4l5
         EXV/vyPma34cpuRXiFW9yjoRIBz6fQ9F219dmnn0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3736hGmL045109
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 01:43:16 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 01:43:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 01:43:16 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3736hFlI057701;
        Thu, 3 Aug 2023 01:43:16 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        "Santosh Shilimkar" <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Praneeth Bajjuri" <praneeth@ti.com>,
        Tony Lindgren <tony@atomide.com>, Georgi Vlaev <g-vlaev@ti.com>
Subject: [PATCH V6 2/4] firmware: ti_sci: Add support for querying the firmware caps
Date:   Thu, 3 Aug 2023 12:12:45 +0530
Message-ID: <20230803064247.503036-3-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803064247.503036-1-d-gole@ti.com>
References: <20230803064247.503036-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

[1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html

Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
---
 drivers/firmware/ti_sci.c | 56 +++++++++++++++++++++++++++++++++++++++
 drivers/firmware/ti_sci.h | 26 ++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 31a71613ca54..3b40f9336b3f 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1723,6 +1723,62 @@ static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
 	return ret;
 }
 
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
+	if (fw_caps)
+		*fw_caps = resp->fw_caps;
+
+fail:
+	ti_sci_put_one_xfer(&info->minfo, xfer);
+
+	return ret;
+}
+
 /**
  * ti_sci_msg_cmd_lpm_wake_reason() - Get the wakeup source from LPM
  * @handle:		Pointer to TI SCI handle
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index e4bfe146c43d..d5b23d91b9b9 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -19,6 +19,7 @@
 #define TI_SCI_MSG_WAKE_REASON	0x0003
 #define TI_SCI_MSG_GOODBYE	0x0004
 #define TI_SCI_MSG_SYS_RESET	0x0005
+#define TI_SCI_MSG_QUERY_FW_CAPS	0x0022
 
 /* Device requests */
 #define TI_SCI_MSG_SET_DEVICE_STATE	0x0200
@@ -137,6 +138,31 @@ struct ti_sci_msg_req_reboot {
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

