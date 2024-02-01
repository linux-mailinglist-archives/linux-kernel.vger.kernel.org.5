Return-Path: <linux-kernel+bounces-47883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C55C684541D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CD2AB22FFC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3471215D5A7;
	Thu,  1 Feb 2024 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iyrYuYHb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A63415B983
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780005; cv=none; b=PtSvBVz5KoMgOYiaNl33nBZJSwfJXhkVaFY16d5ixa7QXIKmXHUiqSCeNT9VhPeu52YchmZjO+9GmFYrjeLKulnm1WZNf4e2Oso1XNqWFBaFEnN/JbwFgJ+VFSpRjv9lEDoRZwCFPMYhNt62Bc7v6fHgNuzueuPaS+cq1VPe47Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780005; c=relaxed/simple;
	bh=O5mPy11j1ho/Gik2SO3unm82tQu4oMlxIWapItCDpew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EgcWZ9cqka/mGqYFraaLuKopg0UsHn/TLWnlHhFruabCeO2ewoxH798qGxLW1+h8DnQ+2JR6StzKUaQOpW/Jeeoy9s0kf/3bhLisU1lgR2jlt4SVa1bYBEew3Cz2L3HLM8sE0sBD4eyecVkQxP8snsCRNABgTB/jYBTRXUlwJLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iyrYuYHb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706780003; x=1738316003;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O5mPy11j1ho/Gik2SO3unm82tQu4oMlxIWapItCDpew=;
  b=iyrYuYHbWAlRrCMcx/9e6PVY/t7je773ONb7/9bErxc4SrHiDT/Wv4Ds
   PSNGUCapNg2SmDVnIrD6HR1Dml+hj+IW14zAnfvAzaHwcYmH6Uj47PpLw
   lWbl63kuzm1nflUYD1IfhV5KxiayPacCeHyCh2T95YAWCS8wOFlr3NHno
   4KsX65kTIkS/tIALijq2mcL7Ek8uphlQ5RROXCIVdA2W7BsnBuzhkuKf0
   T72rLjVTCSNrfG+xzjIvLNHEnGhWe1pqwi4Cq++UclWogcE8i3bbDmAKJ
   1hDxRXud+6eOdEVyfvO4On9GMYc2RXcq62s+6ogNX64WMbeYnxXAa2Lke
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2789234"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="2789234"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 01:33:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788895868"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="788895868"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2024 01:33:19 -0800
From: kah.jing.lee@intel.com
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH] drivers: firmware: stratix10-rsu: Query device info
Date: Thu,  1 Feb 2024 17:32:22 +0800
Message-Id: <20240201093221.3709583-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kah Jing Lee <kah.jing.lee@intel.com>

Extend Intel Remote System Update (RSU) driver to get device info table
using SMC call. Device info table contains size and erasesize for multiple
flashes. Empty flash will return 0 for size and erasesize.

Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
---
 drivers/firmware/stratix10-rsu.c              | 204 ++++++++++++++++++
 drivers/firmware/stratix10-svc.c              |  11 +
 include/linux/firmware/intel/stratix10-smc.h  |  23 ++
 .../firmware/intel/stratix10-svc-client.h     |   4 +
 4 files changed, 242 insertions(+)

diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
index e20cee9c2d32..614121b24842 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -19,6 +19,7 @@
 #define RSU_VERSION_MASK		GENMASK_ULL(63, 32)
 #define RSU_ERROR_LOCATION_MASK		GENMASK_ULL(31, 0)
 #define RSU_ERROR_DETAIL_MASK		GENMASK_ULL(63, 32)
+#define RSU_ERASE_SIZE_MASK		GENMASK_ULL(63, 32)
 #define RSU_DCMF0_MASK			GENMASK_ULL(31, 0)
 #define RSU_DCMF1_MASK			GENMASK_ULL(63, 32)
 #define RSU_DCMF2_MASK			GENMASK_ULL(31, 0)
@@ -34,10 +35,17 @@
 #define INVALID_DCMF_VERSION		0xFF
 #define INVALID_DCMF_STATUS		0xFFFFFFFF
 #define INVALID_SPT_ADDRESS		0x0
+#define INVALID_DEVICE_INFO		0x0
 
 #define RSU_GET_SPT_CMD			0x5A
+#define RSU_GET_DEVICE_INFO_CMD		0x74
 #define RSU_GET_SPT_RESP_LEN		(4 * sizeof(unsigned int))
 
+struct flash_device_info {
+	unsigned int size;
+	unsigned int erase_size;
+};
+
 typedef void (*rsu_callback)(struct stratix10_svc_client *client,
 			     struct stratix10_svc_cb_data *data);
 /**
@@ -60,6 +68,8 @@ typedef void (*rsu_callback)(struct stratix10_svc_client *client,
  * @dcmf_status.dcmf1: dcmf1 status
  * @dcmf_status.dcmf2: dcmf2 status
  * @dcmf_status.dcmf3: dcmf3 status
+ * @device_info.size: flash size
+ * @device_info.erase_size: flash erase size
  * @retry_counter: the current image's retry counter
  * @max_retry: the preset max retry value
  * @spt0_address: address of spt0
@@ -94,6 +104,8 @@ struct stratix10_rsu_priv {
 		unsigned int dcmf3;
 	} dcmf_status;
 
+	struct flash_device_info device_info[4];
+
 	unsigned int retry_counter;
 	unsigned int max_retry;
 
@@ -270,6 +282,50 @@ static void rsu_dcmf_status_callback(struct stratix10_svc_client *client,
 	complete(&priv->completion);
 }
 
+/**
+ * rsu_get_device_info_callback() - Callback from Intel service layer for getting
+ * the QSPI device info
+ * @client: pointer to client
+ * @data: pointer to callback data structure
+ *
+ * Callback from Intel service layer for QSPI device info
+ */
+static void rsu_get_device_info_callback(struct stratix10_svc_client *client,
+					 struct stratix10_svc_cb_data *data)
+{
+	struct stratix10_rsu_priv *priv = client->priv;
+	struct arm_smccc_1_2_regs *res = (struct arm_smccc_1_2_regs *)data->kaddr1;
+
+	if (data->status == BIT(SVC_STATUS_OK)) {
+		priv->device_info[0].size = res->a1;
+		priv->device_info[0].erase_size =
+			FIELD_GET(RSU_ERASE_SIZE_MASK, res->a1);
+		priv->device_info[1].size = res->a2;
+		priv->device_info[1].erase_size =
+			FIELD_GET(RSU_ERASE_SIZE_MASK, res->a2);
+		priv->device_info[2].size = res->a3;
+		priv->device_info[2].erase_size =
+			FIELD_GET(RSU_ERASE_SIZE_MASK, res->a3);
+		priv->device_info[3].size = res->a4;
+		priv->device_info[3].erase_size =
+			FIELD_GET(RSU_ERASE_SIZE_MASK, res->a4);
+
+	} else {
+		dev_err(client->dev, "COMMAND_RSU_GET_DEVICE_INFO returned 0x%lX\n",
+			res->a0);
+		priv->device_info[0].size = INVALID_DEVICE_INFO;
+		priv->device_info[1].size = INVALID_DEVICE_INFO;
+		priv->device_info[2].size = INVALID_DEVICE_INFO;
+		priv->device_info[3].size = INVALID_DEVICE_INFO;
+		priv->device_info[0].erase_size = INVALID_DEVICE_INFO;
+		priv->device_info[1].erase_size = INVALID_DEVICE_INFO;
+		priv->device_info[2].erase_size = INVALID_DEVICE_INFO;
+		priv->device_info[3].erase_size = INVALID_DEVICE_INFO;
+	}
+
+	complete(&priv->completion);
+}
+
 static void rsu_get_spt_callback(struct stratix10_svc_client *client,
 				 struct stratix10_svc_cb_data *data)
 {
@@ -621,6 +677,122 @@ static ssize_t notify_store(struct device *dev,
 	return count;
 }
 
+static ssize_t size0_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	if (priv->device_info[0].size == INVALID_DEVICE_INFO)
+		return -EIO;
+
+	return scnprintf(buf, PAGE_SIZE, "0x%08x\n", priv->device_info[0].size);
+}
+
+static ssize_t size1_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	if (priv->device_info[1].size == INVALID_DEVICE_INFO)
+		return -EIO;
+
+	return scnprintf(buf, PAGE_SIZE, "0x%08x\n", priv->device_info[1].size);
+}
+
+static ssize_t size2_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	if (priv->device_info[2].size == INVALID_DEVICE_INFO)
+		return -EIO;
+
+	return scnprintf(buf, PAGE_SIZE, "0x%08x\n", priv->device_info[2].size);
+}
+
+static ssize_t size3_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	if (priv->device_info[3].size == INVALID_DEVICE_INFO)
+		return -EIO;
+
+	return scnprintf(buf, PAGE_SIZE, "0x%08x\n", priv->device_info[3].size);
+}
+
+static ssize_t erase_size0_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	if (priv->device_info[0].erase_size == INVALID_DEVICE_INFO)
+		return -EIO;
+
+	return scnprintf(buf, PAGE_SIZE, "0x%08x\n",
+					 priv->device_info[0].erase_size);
+}
+
+static ssize_t erase_size1_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	if (priv->device_info[1].erase_size == INVALID_DEVICE_INFO)
+		return -EIO;
+
+	return scnprintf(buf, PAGE_SIZE, "0x%08x\n",
+					 priv->device_info[1].erase_size);
+}
+
+static ssize_t erase_size2_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	if (priv->device_info[2].erase_size == INVALID_DEVICE_INFO)
+		return -EIO;
+
+	return scnprintf(buf, PAGE_SIZE, "0x%08x\n",
+					 priv->device_info[2].erase_size);
+}
+
+static ssize_t erase_size3_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	if (priv->device_info[3].erase_size == INVALID_DEVICE_INFO)
+		return -EIO;
+
+	return scnprintf(buf, PAGE_SIZE, "0x%08x\n",
+					 priv->device_info[3].erase_size);
+}
+
 static ssize_t spt0_address_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
@@ -665,6 +837,14 @@ static DEVICE_ATTR_RO(dcmf0_status);
 static DEVICE_ATTR_RO(dcmf1_status);
 static DEVICE_ATTR_RO(dcmf2_status);
 static DEVICE_ATTR_RO(dcmf3_status);
+static DEVICE_ATTR_RO(size0);
+static DEVICE_ATTR_RO(size1);
+static DEVICE_ATTR_RO(size2);
+static DEVICE_ATTR_RO(size3);
+static DEVICE_ATTR_RO(erase_size0);
+static DEVICE_ATTR_RO(erase_size1);
+static DEVICE_ATTR_RO(erase_size2);
+static DEVICE_ATTR_RO(erase_size3);
 static DEVICE_ATTR_WO(reboot_image);
 static DEVICE_ATTR_WO(notify);
 static DEVICE_ATTR_RO(spt0_address);
@@ -687,6 +867,14 @@ static struct attribute *rsu_attrs[] = {
 	&dev_attr_dcmf1_status.attr,
 	&dev_attr_dcmf2_status.attr,
 	&dev_attr_dcmf3_status.attr,
+	&dev_attr_size0.attr,
+	&dev_attr_size1.attr,
+	&dev_attr_size2.attr,
+	&dev_attr_size3.attr,
+	&dev_attr_erase_size0.attr,
+	&dev_attr_erase_size1.attr,
+	&dev_attr_erase_size2.attr,
+	&dev_attr_erase_size3.attr,
 	&dev_attr_reboot_image.attr,
 	&dev_attr_notify.attr,
 	&dev_attr_spt0_address.attr,
@@ -727,6 +915,14 @@ static int stratix10_rsu_probe(struct platform_device *pdev)
 	priv->max_retry = INVALID_RETRY_COUNTER;
 	priv->spt0_address = INVALID_SPT_ADDRESS;
 	priv->spt1_address = INVALID_SPT_ADDRESS;
+	priv->device_info[0].size = INVALID_DEVICE_INFO;
+	priv->device_info[1].size = INVALID_DEVICE_INFO;
+	priv->device_info[2].size = INVALID_DEVICE_INFO;
+	priv->device_info[3].size = INVALID_DEVICE_INFO;
+	priv->device_info[0].erase_size = INVALID_DEVICE_INFO;
+	priv->device_info[1].erase_size = INVALID_DEVICE_INFO;
+	priv->device_info[2].erase_size = INVALID_DEVICE_INFO;
+	priv->device_info[3].erase_size = INVALID_DEVICE_INFO;
 
 	mutex_init(&priv->lock);
 	priv->chan = stratix10_svc_request_channel_byname(&priv->client,
@@ -776,6 +972,14 @@ static int stratix10_rsu_probe(struct platform_device *pdev)
 		stratix10_svc_free_channel(priv->chan);
 	}
 
+	/* get QSPI device info from firmware */
+	ret = rsu_send_msg(priv, COMMAND_RSU_GET_DEVICE_INFO,
+			   0, rsu_get_device_info_callback);
+	if (ret) {
+		dev_err(dev, "Error, getting QSPI Device Info %i\n", ret);
+		stratix10_svc_free_channel(priv->chan);
+	}
+
 	priv->get_spt_response_buf =
 		stratix10_svc_allocate_memory(priv->chan, RSU_GET_SPT_RESP_LEN);
 
diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 528f37417aea..218b9e31198b 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -369,6 +369,12 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 		res.a2 = res.a2 * BYTE_TO_WORD_SIZE;
 		cb_data->kaddr2 = &res.a2;
 		break;
+	case COMMAND_RSU_GET_DEVICE_INFO:
+		cb_data->status = BIT(SVC_STATUS_OK);
+		cb_data->kaddr1 = &res;
+		cb_data->kaddr2 = NULL;
+		cb_data->kaddr3 = NULL;
+		break;
 	default:
 		pr_warn("it shouldn't happen\n");
 		break;
@@ -487,6 +493,11 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = 0;
 			a2 = 0;
 			break;
+		case COMMAND_RSU_GET_DEVICE_INFO:
+			a0 = INTEL_SIP_SMC_RSU_GET_DEVICE_INFO;
+			a1 = 0;
+			a2 = 0;
+			break;
 
 		/* for FCS */
 		case COMMAND_FCS_DATA_ENCRYPTION:
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index ee80ca4bb0d0..7d9dce61da55 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -424,6 +424,29 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_RSU_DCMF_STATUS \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_DCMF_STATUS)
 
+/**
+ * Request INTEL_SIP_SMC_RSU_GET_DEVICE_INFO
+ *
+ * Sync call used by service driver at EL1 to query QSPI device info from FW
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_RSU_GET_DEVICE_INFO
+ * a1-7 not used
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ * a1 erasesize0 | size0
+ * a2 erasesize1 | size1
+ * a3 erasesize2 | size2
+ * a4 erasesize3 | size3
+ * Or
+ *
+ * a0 INTEL_SIP_SMC_RSU_ERROR
+ */
+#define INTEL_SIP_SMC_FUNCID_RSU_GET_DEVICE_INFO 22
+#define INTEL_SIP_SMC_RSU_GET_DEVICE_INFO \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_GET_DEVICE_INFO)
+
 /**
  * Request INTEL_SIP_SMC_SERVICE_COMPLETED
  * Sync call to check if the secure world have completed service request
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 60ed82112680..2a141c7ba2a1 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -124,6 +124,9 @@ struct stratix10_svc_chan;
  * @COMMAND_RSU_DCMF_STATUS: query firmware for the DCMF status
  * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
  *
+ * @COMMAND_RSU_GET_DEVICE_INFO: query firmware for QSPI device info
+ * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
  * @COMMAND_FCS_REQUEST_SERVICE: request validation of image from firmware,
  * return status is SVC_STATUS_OK, SVC_STATUS_INVALID_PARAM
  *
@@ -158,6 +161,7 @@ enum stratix10_svc_command_code {
 	COMMAND_RSU_DCMF_VERSION,
 	COMMAND_RSU_DCMF_STATUS,
 	COMMAND_FIRMWARE_VERSION,
+	COMMAND_RSU_GET_DEVICE_INFO,
 	/* for FCS */
 	COMMAND_FCS_REQUEST_SERVICE = 20,
 	COMMAND_FCS_SEND_CERTIFICATE,

base-commit: 1bbb19b6eb1b8685ab1c268a401ea64380b8bbcb
-- 
2.25.1


