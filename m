Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329D0754D97
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 09:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGPHHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 03:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGPHHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 03:07:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E452E10E6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 00:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689491264; x=1721027264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5j0LS5Gx47FVwaD6yv0YyIGhWddH4zODLXS6CryAiVk=;
  b=H/yfY0wAdsB3F7579i5Tm5F7ow66OoWx9rOgr2vaO2FdrSw+L5KUIe74
   eoU7WAn0aVn0R01y13PnS3/2yu3c6ToUlTUn+30YXmPPTfkBWaYP7Ho3V
   ax0PAEueR83/hTBe8KozhJcpx2Y8b6CY+ThZbYjQRn8DFBbSPTzG/FQYQ
   R62O1FVgpmsf9C8cgeBhalmTwXjAJB5jMd9/dei72QWS/UrC9w5oQFRZb
   Lr26xQ2aEkYK0qNdtz608VNEWU4TlwQ5DrBXPP153eFPG4au7aykJ7BBf
   3eX0+eUyVuPZ7p8QKQO/Uab14knWZglGzSz64J1B2zlSU/6NFIkCiHgTR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="364605551"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="364605551"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 00:07:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="969477737"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="969477737"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jul 2023 00:07:42 -0700
From:   kah.jing.lee@intel.com
To:     dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org, radu.bacrau@intel.com,
        tien.sung.ang@intel.com, Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH v2 2/2] firmware: stratix10-rsu: query spt addresses
Date:   Sun, 16 Jul 2023 15:05:19 +0800
Message-Id: <b565b90641a38f1040017aad917e116e699757ea.1689490408.git.kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689490408.git.kah.jing.lee@intel.com>
References: <cover.1689490408.git.kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radu Bacrau <radu.bacrau@intel.com>

Extend Intel Remote System Update (RSU) driver to get SPT
(Sub-Partition Table) addresses. The query SPT address can be used
to determine if the RSU QSPI layout is 32kB or 64kB aligned.
The alignment can be determined by minus the upper with the lower of
the SPT addresses.

This patch depends on patch:
firmware: stratix10-svc: Generic Mailbox Command

Signed-off-by: Radu Bacrau <radu.bacrau@intel.com>
Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
---
 drivers/firmware/stratix10-rsu.c | 100 ++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
index e51c95f8d445..417627fe8577 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -34,6 +34,10 @@
 #define INVALID_RETRY_COUNTER		0xFF
 #define INVALID_DCMF_VERSION		0xFF
 #define INVALID_DCMF_STATUS		0xFFFFFFFF
+#define INVALID_SPT_ADDRESS		0x0
+
+#define RSU_GET_SPT_CMD			0x5A
+#define RSU_GET_SPT_RESP_LEN		(4 * sizeof(unsigned int))
 
 typedef void (*rsu_callback)(struct stratix10_svc_client *client,
 			     struct stratix10_svc_cb_data *data);
@@ -59,6 +63,9 @@ typedef void (*rsu_callback)(struct stratix10_svc_client *client,
  * @dcmf_status.dcmf3: dcmf3 status
  * @retry_counter: the current image's retry counter
  * @max_retry: the preset max retry value
+ * @spt0_address: address of spt0
+ * @spt1_address: address of spt1
+ * @get_spt_response_buf: response from sdm for get_spt command
  */
 struct stratix10_rsu_priv {
 	struct stratix10_svc_chan *chan;
@@ -90,6 +97,11 @@ struct stratix10_rsu_priv {
 
 	unsigned int retry_counter;
 	unsigned int max_retry;
+
+	unsigned long spt0_address;
+	unsigned long spt1_address;
+
+	unsigned int *get_spt_response_buf;
 };
 
 /**
@@ -259,6 +271,36 @@ static void rsu_dcmf_status_callback(struct stratix10_svc_client *client,
 	complete(&priv->completion);
 }
 
+static void rsu_get_spt_callback(struct stratix10_svc_client *client,
+				     struct stratix10_svc_cb_data *data)
+{
+	struct stratix10_rsu_priv *priv = client->priv;
+	unsigned long *mbox_err = (unsigned long *)data->kaddr1;
+	unsigned long *resp_len = (unsigned long *)data->kaddr2;
+
+	if ((data->status != BIT(SVC_STATUS_OK)) || (*mbox_err) ||
+	    (*resp_len != RSU_GET_SPT_RESP_LEN))
+		goto error;
+
+	priv->spt0_address = priv->get_spt_response_buf[0];
+	priv->spt0_address <<= 32;
+	priv->spt0_address |= priv->get_spt_response_buf[1];
+
+	priv->spt1_address = priv->get_spt_response_buf[2];
+	priv->spt1_address <<= 32;
+	priv->spt1_address |= priv->get_spt_response_buf[3];
+
+	goto complete;
+
+error:
+	dev_err(client->dev, "failed to get SPTs\n");
+
+complete:
+	stratix10_svc_free_memory(priv->chan, priv->get_spt_response_buf);
+	priv->get_spt_response_buf = NULL;
+	complete(&priv->completion);
+}
+
 /**
  * rsu_send_msg() - send a message to Intel service layer
  * @priv: pointer to rsu private data
@@ -288,6 +330,14 @@ static int rsu_send_msg(struct stratix10_rsu_priv *priv,
 	if (arg)
 		msg.arg[0] = arg;
 
+	if (command == COMMAND_MBOX_SEND_CMD) {
+		msg.arg[1] = 0;
+		msg.payload = NULL;
+		msg.payload_length = 0;
+		msg.payload_output = priv->get_spt_response_buf;
+		msg.payload_length_output = RSU_GET_SPT_RESP_LEN;
+	}
+
 	ret = stratix10_svc_send(priv->chan, &msg);
 	if (ret < 0)
 		goto status_done;
@@ -572,6 +622,34 @@ static ssize_t notify_store(struct device *dev,
 	return count;
 }
 
+static ssize_t spt0_address_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	if (priv->spt0_address == INVALID_SPT_ADDRESS)
+		return -EIO;
+
+	return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt0_address);
+}
+
+static ssize_t spt1_address_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	if (priv->spt1_address == INVALID_SPT_ADDRESS)
+		return -EIO;
+
+	return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt1_address);
+}
+
 static DEVICE_ATTR_RO(current_image);
 static DEVICE_ATTR_RO(fail_image);
 static DEVICE_ATTR_RO(state);
@@ -590,6 +668,8 @@ static DEVICE_ATTR_RO(dcmf2_status);
 static DEVICE_ATTR_RO(dcmf3_status);
 static DEVICE_ATTR_WO(reboot_image);
 static DEVICE_ATTR_WO(notify);
+static DEVICE_ATTR_RO(spt0_address);
+static DEVICE_ATTR_RO(spt1_address);
 
 static struct attribute *rsu_attrs[] = {
 	&dev_attr_current_image.attr,
@@ -610,6 +690,8 @@ static struct attribute *rsu_attrs[] = {
 	&dev_attr_dcmf3_status.attr,
 	&dev_attr_reboot_image.attr,
 	&dev_attr_notify.attr,
+	&dev_attr_spt0_address.attr,
+	&dev_attr_spt1_address.attr,
 	NULL
 };
 
@@ -639,11 +721,13 @@ static int stratix10_rsu_probe(struct platform_device *pdev)
 	priv->dcmf_version.dcmf1 = INVALID_DCMF_VERSION;
 	priv->dcmf_version.dcmf2 = INVALID_DCMF_VERSION;
 	priv->dcmf_version.dcmf3 = INVALID_DCMF_VERSION;
-	priv->max_retry = INVALID_RETRY_COUNTER;
 	priv->dcmf_status.dcmf0 = INVALID_DCMF_STATUS;
 	priv->dcmf_status.dcmf1 = INVALID_DCMF_STATUS;
 	priv->dcmf_status.dcmf2 = INVALID_DCMF_STATUS;
 	priv->dcmf_status.dcmf3 = INVALID_DCMF_STATUS;
+	priv->max_retry = INVALID_RETRY_COUNTER;
+	priv->spt0_address = INVALID_SPT_ADDRESS;
+	priv->spt1_address = INVALID_SPT_ADDRESS;
 
 	mutex_init(&priv->lock);
 	priv->chan = stratix10_svc_request_channel_byname(&priv->client,
@@ -693,6 +777,20 @@ static int stratix10_rsu_probe(struct platform_device *pdev)
 		stratix10_svc_free_channel(priv->chan);
 	}
 
+	priv->get_spt_response_buf =
+		stratix10_svc_allocate_memory(priv->chan, RSU_GET_SPT_RESP_LEN);
+
+	if (!priv->get_spt_response_buf) {
+		dev_err(dev, "failed to allocate get spt buffer\n");
+	} else {
+		ret = rsu_send_msg(priv, COMMAND_MBOX_SEND_CMD,
+				RSU_GET_SPT_CMD, rsu_get_spt_callback);
+		if (ret) {
+			dev_err(dev, "Error, getting SPT table %i\n", ret);
+			stratix10_svc_free_channel(priv->chan);
+		}
+	}
+
 	return ret;
 }
 
-- 
2.25.1

