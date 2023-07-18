Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6E07581C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjGRQKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjGRQKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:10:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D910EB5;
        Tue, 18 Jul 2023 09:10:03 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IFACIs032176;
        Tue, 18 Jul 2023 16:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=EMr7lI1FtOfRgJJzfIai6cHL8/662XyamwtQ9ueKMTo=;
 b=T/0cTUh5gyjdshuqGw85oxPl2pOr+zZwcg7jS0dGxp6MnY6Q+Euvjd+9ffPK8MJnWuxw
 keQJgkMWOOhnSPxh9zpWarXA1NuQM+O6QVi1Np+lppKSUdZSTIsnFCr2d3jITWKHDWmh
 UQDUgV3t5AS2TPMuBKfJ97RZHnmYthSehdxYW4eylO3Y+FWeLB/rz9uvyvAipRN+SW6+
 8enEgBBTeEsixJFOZUmPuvHorJMi2NQPlYTeCWwd16zQmyIjqUnMpOgnoZwj+uxqvMDx
 kfygwdjFghMM5lKIIkDuKPrBTmAKNaSp+isGHcpVGkqlPTvMqVq2oDXq3DnDdhVeNxSX LA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rweag24hd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 16:09:04 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36IG93OD025886
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 16:09:03 GMT
Received: from car-linux11.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 09:09:02 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH 2/2] firmware: arm_scmi: Add qcom hvc/shmem transport
Date:   Tue, 18 Jul 2023 09:08:33 -0700
Message-ID: <20230718160833.36397-3-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230718160833.36397-1-quic_nkela@quicinc.com>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zgH8mamMYULPC-sedBZgmjs4H6nt-aBG
X-Proofpoint-GUID: zgH8mamMYULPC-sedBZgmjs4H6nt-aBG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_12,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180148
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new transport channel to the SCMI firmware interface driver for
SCMI message exchange on Qualcomm virtual platforms.

The hypervisor associates an object-id also known as capability-id
with each hvc doorbell object. The capability-id is used to identify the
doorbell from the VM's capability namespace, similar to a file-descriptor.

The hypervisor, in addition to the function-id, expects the capability-id
to be passed in x1 register when HVC call is invoked.

The qcom hvc doorbell/shared memory transport uses a statically defined
shared memory region that binds with "arm,scmi-shmem" device tree node.

The function-id & capability-id are allocated by the hypervisor on bootup
and are stored in the shmem region by the firmware before starting Linux.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---
 drivers/firmware/arm_scmi/Kconfig    |  13 ++
 drivers/firmware/arm_scmi/Makefile   |   1 +
 drivers/firmware/arm_scmi/common.h   |   3 +
 drivers/firmware/arm_scmi/driver.c   |   4 +
 drivers/firmware/arm_scmi/qcom_hvc.c | 241 +++++++++++++++++++++++++++
 5 files changed, 262 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/qcom_hvc.c

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index ea0f5083ac47..40d07329ebf7 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -99,6 +99,19 @@ config ARM_SCMI_TRANSPORT_OPTEE
 	  If you want the ARM SCMI PROTOCOL stack to include support for a
 	  transport based on OP-TEE SCMI service, answer Y.
 
+config ARM_SCMI_TRANSPORT_QCOM_HVC
+	bool "SCMI transport based on hvc doorbell & shmem for Qualcomm SoCs"
+	depends on ARCH_QCOM
+	select ARM_SCMI_HAVE_TRANSPORT
+	select ARM_SCMI_HAVE_SHMEM
+	default y
+	help
+	  Enable hvc doorbell & shmem based transport for SCMI.
+
+	  If you want the ARM SCMI PROTOCOL stack to include support for a
+	  hvc doorbell and shmem transport on Qualcomm virtual platforms,
+	  answer Y.
+
 config ARM_SCMI_TRANSPORT_SMC
 	bool "SCMI transport based on SMC"
 	depends on HAVE_ARM_SMCCC_DISCOVERY
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index b31d78fa66cc..ba1ff5893ec0 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -10,6 +10,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
+scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_QCOM_HVC) += qcom_hvc.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
 scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
 
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index c46dc5215af7..5c98cbb1278b 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -298,6 +298,9 @@ extern const struct scmi_desc scmi_virtio_desc;
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_OPTEE
 extern const struct scmi_desc scmi_optee_desc;
 #endif
+#ifdef CONFIG_ARM_SCMI_TRANSPORT_QCOM_HVC
+extern const struct scmi_desc scmi_qcom_hvc_desc;
+#endif
 
 void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv);
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index b5957cc12fee..c54519596c29 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2918,6 +2918,10 @@ static const struct of_device_id scmi_of_match[] = {
 #endif
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
 	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
+#endif
+#ifdef CONFIG_ARM_SCMI_TRANSPORT_QCOM_HVC
+	{ .compatible = "qcom,scmi-hvc-shmem",
+	  .data = &scmi_qcom_hvc_desc },
 #endif
 	{ /* Sentinel */ },
 };
diff --git a/drivers/firmware/arm_scmi/qcom_hvc.c b/drivers/firmware/arm_scmi/qcom_hvc.c
new file mode 100644
index 000000000000..3b6096d8fe67
--- /dev/null
+++ b/drivers/firmware/arm_scmi/qcom_hvc.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) Message
+ * Qualcomm HVC/shmem Transport driver
+ *
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright 2020 NXP
+ *
+ * This is copied from drivers/firmware/arm_scmi/smc.c
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/processor.h>
+#include <linux/slab.h>
+
+#include "common.h"
+
+/**
+ * struct scmi_qcom_hvc - Structure representing a SCMI qcom hvc transport
+ *
+ * @cinfo: SCMI channel info
+ * @shmem: Transmit/Receive shared memory area
+ * @shmem_lock: Lock to protect access to Tx/Rx shared memory area.
+ * @func_id: hvc call function-id
+ * @cap_id: hvc doorbell's capability id
+ */
+
+struct scmi_qcom_hvc {
+	struct scmi_chan_info *cinfo;
+	struct scmi_shared_mem __iomem *shmem;
+	/* Protect access to shmem area */
+	struct mutex shmem_lock;
+	u32 func_id;
+	unsigned long cap_id;
+};
+
+static irqreturn_t qcom_hvc_msg_done_isr(int irq, void *data)
+{
+	struct scmi_qcom_hvc *scmi_info = data;
+
+	scmi_rx_callback(scmi_info->cinfo,
+			 shmem_read_header(scmi_info->shmem), NULL);
+
+	return IRQ_HANDLED;
+}
+
+static bool qcom_hvc_chan_available(struct device_node *of_node, int idx)
+{
+	struct device_node *np = of_parse_phandle(of_node, "shmem", 0);
+
+	if (!np)
+		return false;
+
+	of_node_put(np);
+	return true;
+}
+
+static inline void qcom_hvc_channel_lock_init(struct scmi_qcom_hvc *scmi_info)
+{
+	mutex_init(&scmi_info->shmem_lock);
+}
+
+static inline void
+qcom_hvc_channel_lock_acquire(struct scmi_qcom_hvc *scmi_info,
+			      struct scmi_xfer *xfer __maybe_unused)
+{
+	mutex_lock(&scmi_info->shmem_lock);
+}
+
+static inline void qcom_hvc_channel_lock_release(struct scmi_qcom_hvc
+						 *scmi_info)
+{
+	mutex_unlock(&scmi_info->shmem_lock);
+}
+
+static int qcom_hvc_chan_setup(struct scmi_chan_info *cinfo,
+			       struct device *dev, bool tx)
+{
+	struct device *cdev = cinfo->dev;
+	struct scmi_qcom_hvc *scmi_info;
+	resource_size_t size;
+	struct resource res;
+	struct device_node *np;
+	unsigned long cap_id;
+	u32 func_id;
+	int ret, irq;
+
+	if (!tx)
+		return -ENODEV;
+
+	scmi_info = devm_kzalloc(dev, sizeof(*scmi_info), GFP_KERNEL);
+	if (!scmi_info)
+		return -ENOMEM;
+
+	np = of_parse_phandle(cdev->of_node, "shmem", 0);
+	if (!of_device_is_compatible(np, "arm,scmi-shmem"))
+		return -ENXIO;
+
+	ret = of_address_to_resource(np, 0, &res);
+	of_node_put(np);
+	if (ret) {
+		dev_err(cdev, "failed to get SCMI Tx shared memory\n");
+		return ret;
+	}
+
+	size = resource_size(&res);
+
+	/* let's map 2 additional ulong since
+	 * func-id & capability-id are kept after shmem.
+	 *     +-------+
+	 *     |       |
+	 *     | shmem |
+	 *     |       |
+	 *     |       |
+	 *     +-------+ <-- size
+	 *     | funcId|
+	 *     +-------+ <-- size + sizeof(ulong)
+	 *     | capId |
+	 *     +-------+ <-- size + 2*sizeof(ulong)
+	 */
+
+	scmi_info->shmem = devm_ioremap(dev, res.start,
+					size + 2 * sizeof(unsigned long));
+	if (!scmi_info->shmem) {
+		dev_err(dev, "failed to ioremap SCMI Tx shared memory\n");
+		return -EADDRNOTAVAIL;
+	}
+
+	func_id = readl((void *)(scmi_info->shmem) + size);
+
+#ifdef CONFIG_ARM64
+	cap_id = readq((void *)(scmi_info->shmem) + size +
+		       sizeof(unsigned long));
+#else
+	cap_id = readl((void *)(scmi_info->shmem) + size +
+		       sizeof(unsigned long));
+#endif
+
+	/*
+	 * If there is an interrupt named "a2p", then the service and
+	 * completion of a message is signaled by an interrupt rather than by
+	 * the return of the hvc call.
+	 */
+	irq = of_irq_get_byname(cdev->of_node, "a2p");
+	if (irq > 0) {
+		ret = devm_request_irq(dev, irq, qcom_hvc_msg_done_isr,
+				       IRQF_NO_SUSPEND,
+				       dev_name(dev), scmi_info);
+		if (ret) {
+			dev_err(dev, "failed to setup SCMI completion irq\n");
+			return ret;
+		}
+	} else {
+		cinfo->no_completion_irq = true;
+	}
+
+	scmi_info->func_id = func_id;
+	scmi_info->cap_id = cap_id;
+	scmi_info->cinfo = cinfo;
+	qcom_hvc_channel_lock_init(scmi_info);
+	cinfo->transport_info = scmi_info;
+
+	return 0;
+}
+
+static int qcom_hvc_chan_free(int id, void *p, void *data)
+{
+	struct scmi_chan_info *cinfo = p;
+	struct scmi_qcom_hvc *scmi_info = cinfo->transport_info;
+
+	cinfo->transport_info = NULL;
+	scmi_info->cinfo = NULL;
+
+	return 0;
+}
+
+static int qcom_hvc_send_message(struct scmi_chan_info *cinfo,
+				 struct scmi_xfer *xfer)
+{
+	struct scmi_qcom_hvc *scmi_info = cinfo->transport_info;
+	struct arm_smccc_res res;
+
+	/*
+	 * Channel will be released only once response has been
+	 * surely fully retrieved, so after .mark_txdone()
+	 */
+	qcom_hvc_channel_lock_acquire(scmi_info, xfer);
+
+	shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
+
+	arm_smccc_1_1_hvc(scmi_info->func_id, scmi_info->cap_id,
+			  0, 0, 0, 0, 0, 0, &res);
+
+	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
+	if (res.a0) {
+		qcom_hvc_channel_lock_release(scmi_info);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static void qcom_hvc_fetch_response(struct scmi_chan_info *cinfo,
+				    struct scmi_xfer *xfer)
+{
+	struct scmi_qcom_hvc *scmi_info = cinfo->transport_info;
+
+	shmem_fetch_response(scmi_info->shmem, xfer);
+}
+
+static void qcom_hvc_mark_txdone(struct scmi_chan_info *cinfo, int ret,
+				 struct scmi_xfer *__unused)
+{
+	struct scmi_qcom_hvc *scmi_info = cinfo->transport_info;
+
+	qcom_hvc_channel_lock_release(scmi_info);
+}
+
+static const struct scmi_transport_ops scmi_qcom_hvc_ops = {
+	.chan_available = qcom_hvc_chan_available,
+	.chan_setup = qcom_hvc_chan_setup,
+	.chan_free = qcom_hvc_chan_free,
+	.send_message = qcom_hvc_send_message,
+	.mark_txdone = qcom_hvc_mark_txdone,
+	.fetch_response = qcom_hvc_fetch_response,
+};
+
+const struct scmi_desc scmi_qcom_hvc_desc = {
+	.ops = &scmi_qcom_hvc_ops,
+	.max_rx_timeout_ms = 30,
+	.max_msg = 20,
+	.max_msg_size = 128,
+	.sync_cmds_completed_on_ret = true,
+};
-- 
2.17.1

