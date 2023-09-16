Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AABF7A2B75
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbjIPAMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbjIPALM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:11:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD5C211E;
        Fri, 15 Sep 2023 17:11:06 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FNrukw029538;
        Sat, 16 Sep 2023 00:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=VcAYa/+/r3z+L0siR6izCF50ALvk48KnA2NkBZchfcs=;
 b=kSvtGIkyz/TaSO1345OcfY9kLWCI7b/HtUsFSZ3vhWMxqrHMIcEhRwNFdZCLRGjgwjAx
 EEwojr7S6Az/O/uEdmWaWxxbUwtNI57W1XESWGBbMIGjvdMf/eZtLn47p86sDrCjciJG
 1/nKgUfrajgMFQNN/4iW7XgK06iku2kfQiuzfIWL7ciEpFIeJzagzF60c+CtqikbMIuO
 AGQi9GhnD7xbtZ0Olm4MqLGMeMOF+oMVK5eMuNDCQf3U4HHKdCAkWuHXrqP+8OpaS70g
 i7etaNwRh4AiiDNYI7rrpBnUkhJFAvbCklDbe30EM7m6oMi4TWOLFHwfffgUgRg3u1/b EQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4fsfam5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Sep 2023 00:10:39 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38G0Ac5x018227
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Sep 2023 00:10:38 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 15 Sep 2023 17:10:38 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v6 06/33] ASoC: Add SOC USB APIs for adding an USB backend
Date:   Fri, 15 Sep 2023 17:09:59 -0700
Message-ID: <20230916001026.315-7-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230916001026.315-1-quic_wcheng@quicinc.com>
References: <20230916001026.315-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z2i9aQoMTLLeT6k2fMrsGTvmotByxC3Q
X-Proofpoint-GUID: z2i9aQoMTLLeT6k2fMrsGTvmotByxC3Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309160000
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms may have support for offloading USB audio devices to a
dedicated audio DSP.  Introduce a set of APIs that allow for management of
USB sound card and PCM devices enumerated by the USB SND class driver.
This allows for the ASoC components to be aware of what USB devices are
available for offloading.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 include/sound/soc-usb.h |  48 +++++++++++
 sound/soc/Makefile      |   2 +-
 sound/soc/soc-usb.c     | 185 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 234 insertions(+), 1 deletion(-)
 create mode 100644 include/sound/soc-usb.h
 create mode 100644 sound/soc/soc-usb.c

diff --git a/include/sound/soc-usb.h b/include/sound/soc-usb.h
new file mode 100644
index 000000000000..1fa671924018
--- /dev/null
+++ b/include/sound/soc-usb.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __LINUX_SND_SOC_USB_H
+#define __LINUX_SND_SOC_USB_H
+
+/**
+ * struct snd_soc_usb_device
+ * @card_idx - sound card index associated with USB device
+ * @chip_idx - USB sound chip array index
+ * @num_playback - number of playback streams
+ * @num_capture - number of capture streams
+ **/
+struct snd_soc_usb_device {
+	int card_idx;
+	int chip_idx;
+	int num_playback;
+	int num_capture;
+};
+
+/**
+ * struct snd_soc_usb
+ * @list - list head for SND SOC struct list
+ * @dev - USB backend device reference
+ * @component - reference to ASoC component
+ * @connection_status_cb - callback to notify connection events
+ * @priv_data - driver data
+ **/
+struct snd_soc_usb {
+	struct list_head list;
+	struct device *dev;
+	struct snd_soc_component *component;
+	int (*connection_status_cb)(struct snd_soc_usb *usb,
+			struct snd_soc_usb_device *sdev, bool connected);
+	void *priv_data;
+};
+
+int snd_soc_usb_connect(struct device *usbdev, struct snd_soc_usb_device *sdev);
+int snd_soc_usb_disconnect(struct device *usbdev, struct snd_soc_usb_device *sdev);
+void *snd_soc_usb_get_priv_data(struct device *usbdev);
+
+struct snd_soc_usb *snd_soc_usb_add_port(struct device *dev, void *priv,
+			int (*connection_cb)(struct snd_soc_usb *usb,
+			struct snd_soc_usb_device *sdev, bool connected));
+int snd_soc_usb_remove_port(struct device *dev);
+#endif
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 8376fdb217ed..d597cda11abc 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-utils.o soc-dai.o soc-component.o
+snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-usb.o soc-utils.o soc-dai.o soc-component.o
 snd-soc-core-objs += soc-pcm.o soc-devres.o soc-ops.o soc-link.o soc-card.o
 snd-soc-core-$(CONFIG_SND_SOC_COMPRESS) += soc-compress.o
 
diff --git a/sound/soc/soc-usb.c b/sound/soc/soc-usb.c
new file mode 100644
index 000000000000..b5ab2c1a6dd4
--- /dev/null
+++ b/sound/soc/soc-usb.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include <linux/of.h>
+#include <linux/usb.h>
+#include <sound/soc.h>
+#include <sound/soc-usb.h>
+#include "../usb/card.h"
+
+static DEFINE_MUTEX(ctx_mutex);
+static LIST_HEAD(usb_ctx_list);
+
+static struct device_node *snd_soc_find_phandle(struct device *dev)
+{
+	struct device_node *node;
+
+	node = of_parse_phandle(dev->of_node, "usb-soc-be", 0);
+	if (!node)
+		return ERR_PTR(-ENODEV);
+
+	return node;
+}
+
+static struct snd_soc_usb *snd_soc_find_usb_ctx(struct device *dev)
+{
+	struct device_node *node;
+	struct snd_soc_usb *ctx;
+
+	node = snd_soc_find_phandle(dev);
+	if (IS_ERR(node))
+		return NULL;
+
+	mutex_lock(&ctx_mutex);
+	list_for_each_entry(ctx, &usb_ctx_list, list) {
+		if (ctx->dev->of_node == node) {
+			of_node_put(node);
+			mutex_unlock(&ctx_mutex);
+			return ctx;
+		}
+	}
+	of_node_put(node);
+	mutex_unlock(&ctx_mutex);
+
+	return NULL;
+}
+
+/**
+ * snd_soc_usb_get_priv_data() - Retrieve private data stored
+ * @dev: device reference
+ *
+ * Fetch the private data stored in the USB SND SOC structure.
+ *
+ */
+void *snd_soc_usb_get_priv_data(struct device *dev)
+{
+	struct snd_soc_usb *ctx;
+
+	ctx = snd_soc_find_usb_ctx(dev);
+	if (!ctx) {
+		/* Check if backend device */
+		mutex_lock(&ctx_mutex);
+		list_for_each_entry(ctx, &usb_ctx_list, list) {
+			if (dev->of_node == ctx->dev->of_node) {
+				mutex_unlock(&ctx_mutex);
+				goto out;
+			}
+		}
+		mutex_unlock(&ctx_mutex);
+		ctx = NULL;
+	}
+out:
+	return ctx ? ctx->priv_data : NULL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_get_priv_data);
+
+/**
+ * snd_soc_usb_add_port() - Add a USB backend port
+ * @dev: USB backend device
+ * @priv: private data
+ * @connection_cb: connection status callback
+ *
+ * Register a USB backend device to the SND USB SOC framework.  Memory is
+ * allocated as part of the USB backend device.
+ *
+ */
+struct snd_soc_usb *snd_soc_usb_add_port(struct device *dev, void *priv,
+			int (*connection_cb)(struct snd_soc_usb *usb,
+			struct snd_soc_usb_device *sdev, bool connected))
+{
+	struct snd_soc_usb *usb;
+
+	usb = devm_kzalloc(dev, sizeof(*usb), GFP_KERNEL);
+	if (!usb)
+		return ERR_PTR(-ENOMEM);
+
+	usb->connection_status_cb = connection_cb;
+	usb->dev = dev;
+	usb->priv_data = priv;
+
+	mutex_lock(&ctx_mutex);
+	list_add_tail(&usb->list, &usb_ctx_list);
+	mutex_unlock(&ctx_mutex);
+
+	return usb;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_add_port);
+
+/**
+ * snd_soc_usb_remove_port() - Remove a USB backend port
+ * @dev: USB backend device
+ *
+ * Remove a USB backend device from USB SND SOC.  Memory is freed when USB
+ * backend is removed.
+ *
+ */
+int snd_soc_usb_remove_port(struct device *dev)
+{
+	struct snd_soc_usb *ctx, *tmp;
+
+	mutex_lock(&ctx_mutex);
+	list_for_each_entry_safe(ctx, tmp, &usb_ctx_list, list) {
+		if (ctx->dev == dev) {
+			list_del(&ctx->list);
+			break;
+		}
+	}
+	mutex_unlock(&ctx_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_remove_port);
+
+/**
+ * snd_soc_usb_connect() - Notification of USB device connection
+ * @usbdev: USB bus device
+ * @card_idx: USB SND card instance
+ *
+ * Notify of a new USB SND device connection.  The card_idx can be used to
+ * handle how the DPCM backend selects, which device to enable USB offloading
+ * on.
+ *
+ */
+int snd_soc_usb_connect(struct device *usbdev, struct snd_soc_usb_device *sdev)
+{
+	struct snd_soc_usb *ctx;
+
+	if (!usbdev)
+		return -ENODEV;
+
+	ctx = snd_soc_find_usb_ctx(usbdev);
+	if (!ctx)
+		return -ENODEV;
+
+	if (ctx->connection_status_cb)
+		ctx->connection_status_cb(ctx, sdev, true);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_connect);
+
+/**
+ * snd_soc_usb_disconnect() - Notification of USB device disconnection
+ * @usbdev: USB bus device
+ *
+ * Notify of a new USB SND device disconnection to the USB backend.
+ *
+ */
+int snd_soc_usb_disconnect(struct device *usbdev, struct snd_soc_usb_device *sdev)
+{
+	struct snd_soc_usb *ctx;
+
+	if (!usbdev)
+		return -ENODEV;
+
+	ctx = snd_soc_find_usb_ctx(usbdev);
+	if (!ctx)
+		return -ENODEV;
+
+	if (ctx->connection_status_cb)
+		ctx->connection_status_cb(ctx, sdev, false);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_disconnect);
