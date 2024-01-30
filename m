Return-Path: <linux-kernel+bounces-44461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3137E84225F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B27F5B2822D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7866773C;
	Tue, 30 Jan 2024 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FPNiddXf"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE16266B44;
	Tue, 30 Jan 2024 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613008; cv=none; b=mP985hp14SultbzNTCt/VjugToXFsKzSIYNmc8/0RFLiFxqntBtDBIqUlWiN9tZWw8Xg6ztziTt+0N2wDtZNWUBAFjaad7IRIDFMwiMJFFCCloELkwXe38k/6WQpG+JfIaJlqnYm4dGuGklNkhzgdZqMunn+7PWlC6wI/6dWb9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613008; c=relaxed/simple;
	bh=zVwO8g0LB/InIsnZFUFRTolbpeB9KuIQB5fFaiaHaOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUT0H7/OW+exu6DQRd7/I8hu3VctSxKSO63PCZdhWVOOEqKSI6/RFazmEY8Ft7sg7OofuYuOBQmmjdIBgxsIxmV9BRaPB9GFGqZR2ri8dzcCGuOUYu5HzEFbCK6hGLHJzeeiHkCkyKO6g7VI5OuoCIBV7u8zMt7m/g3sBW5nRk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FPNiddXf; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UB9psG048437;
	Tue, 30 Jan 2024 05:09:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706612991;
	bh=IKw60T4XT/07rIA6OzLOY16F0C5tx6w/Op4PK8bg8L0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FPNiddXfUiyWV44c48J5T9P9R8Lt49ZhUYtTb+bamaGtPtMf0vBZDWtNs73j/2csg
	 0VnKBlcYXzIYqZYRrXrHDQ8/BqGzhFe0DYKh8hnRL26ugPIcvDs4fMqB/c8IA5eZGA
	 SJdovcdQ76BVQJavgGXHsB2/h0fHdeEo/3Wf3WXA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UB9p25006264
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jan 2024 05:09:51 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 05:09:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 05:09:51 -0600
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UB9ilM088313;
	Tue, 30 Jan 2024 05:09:48 -0600
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <andrew@lunn.ch>, <rogerq@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH net-next 1/2] net: ethernet: ti: Introduce inter-core-virt-eth as RPMsg driver
Date: Tue, 30 Jan 2024 16:39:43 +0530
Message-ID: <20240130110944.26771-2-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240130110944.26771-1-r-gunasekaran@ti.com>
References: <20240130110944.26771-1-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

TI's K3 SoCs comprises heterogeneous processors (Cortex A, Cortex R).
When the ethernet controller is completely managed by a core (Cortex R)
running a flavor of RTOS, in a non virtualized environment, network traffic
tunnelling between heterogeneous processors can be realized by means of
RPMsg based shared memory ethernet driver. With the shared memory used
for the data plane and the RPMsg end point channel used for control plane.

inter-core-virt-eth driver is modelled as a RPMsg based shared
memory ethernet driver for such an use case.

As a first step, register the inter-core-virt-eth as a RPMsg driver.
And introduce basic control messages for querying and responding.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
 drivers/net/ethernet/ti/inter-core-virt-eth.c | 139 ++++++++++++++++++
 drivers/net/ethernet/ti/inter-core-virt-eth.h |  89 +++++++++++
 2 files changed, 228 insertions(+)
 create mode 100644 drivers/net/ethernet/ti/inter-core-virt-eth.c
 create mode 100644 drivers/net/ethernet/ti/inter-core-virt-eth.h

diff --git a/drivers/net/ethernet/ti/inter-core-virt-eth.c b/drivers/net/ethernet/ti/inter-core-virt-eth.c
new file mode 100644
index 000000000000..d3b689eab1c0
--- /dev/null
+++ b/drivers/net/ethernet/ti/inter-core-virt-eth.c
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Texas Instruments K3 Inter Core Virtual Ethernet Driver
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "inter-core-virt-eth.h"
+
+static int icve_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len, void *priv, u32 src)
+{
+	struct icve_common *common = dev_get_drvdata(&rpdev->dev);
+	struct message *msg = (struct message *)data;
+	struct icve_port *port = common->port;
+	u32 msg_type = msg->msg_hdr.msg_type;
+	u32 rpmsg_type;
+
+	switch (msg_type) {
+	case ICVE_RESPONSE_MSG:
+		rpmsg_type = msg->resp_msg.type;
+		switch (rpmsg_type) {
+		case ICVE_RESP_SHM_INFO:
+
+			/* Retrieve Tx and Rx shared memory info from msg */
+			port->tx_buffer = msg->resp_msg.shm_info.tx_buffer;
+
+			if (!port->tx_buffer) {
+				dev_err(common->dev, "Tx Buffer invalid\n");
+				return -ENOMEM;
+			}
+
+			port->tx_buffer->base_addr =
+				msg->resp_msg.shm_info.tx_buffer_base_addr;
+
+			if (!port->tx_buffer->base_addr) {
+				dev_err(common->dev, "Tx Buffer address invalid\n");
+				return -ENOMEM;
+			}
+
+			port->rx_buffer = msg->resp_msg.shm_info.rx_buffer;
+
+			if (!port->rx_buffer) {
+				dev_err(common->dev, "Rx Buffer invalid\n");
+				return -ENOMEM;
+			}
+
+			port->rx_buffer->base_addr =
+				msg->resp_msg.shm_info.rx_buffer_base_addr;
+
+			if (!port->rx_buffer->base_addr) {
+				dev_err(common->dev, "Rx Buffer address invalid\n");
+				return -ENOMEM;
+			}
+
+			port->icve_max_buffers =
+				msg->resp_msg.shm_info.max_buffers;
+
+			break;
+		}
+		break;
+	default:
+		dev_err(common->dev, "Invalid msg type\n");
+		break;
+	}
+
+	return 0;
+}
+
+static int create_request(struct icve_common *common, enum icve_rpmsg_type rpmsg_type)
+{
+	struct message *msg = &common->send_msg;
+	int ret = 0;
+
+	msg->msg_hdr.src_id = common->port->port_id;
+	msg->req_msg.type = rpmsg_type;
+
+	switch (rpmsg_type) {
+	case ICVE_REQ_SHM_INFO:
+		msg->msg_hdr.msg_type = ICVE_REQUEST_MSG;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(common->dev, "Invalid RPMSG request\n");
+	};
+
+	return ret;
+}
+
+static int icve_rpmsg_probe(struct rpmsg_device *rpdev)
+{
+	struct device *dev = &rpdev->dev;
+	struct icve_common *common;
+	unsigned long flags;
+
+	common = devm_kzalloc(&rpdev->dev, sizeof(*common), GFP_KERNEL);
+	if (!common)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, common);
+
+	common->port = devm_kzalloc(dev, sizeof(*common->port), GFP_KERNEL);
+	common->dev = dev;
+	common->rpdev = rpdev;
+
+	spin_lock_init(&common->send_msg_lock);
+	spin_lock_init(&common->recv_msg_lock);
+
+	/* Send request to fetch shared memory details from remote core */
+	spin_lock_irqsave(&common->send_msg_lock, flags);
+	create_request(common, ICVE_REQ_SHM_INFO);
+	rpmsg_send(common->rpdev->ept, (void *)(&common->send_msg), sizeof(common->send_msg));
+	spin_unlock_irqrestore(&common->send_msg_lock, flags);
+
+	return 0;
+}
+
+static void icve_rpmsg_remove(struct rpmsg_device *rpdev)
+{
+	dev_info(&rpdev->dev, "icve rpmsg client driver is removed\n");
+}
+
+static struct rpmsg_device_id icve_rpmsg_id_table[] = {
+	{ .name = "icve-rpsmg-client" },
+	{ },
+};
+MODULE_DEVICE_TABLE(rpmsg, icve_rpmsg_id_table);
+
+static struct rpmsg_driver icve_rpmsg_client = {
+	.drv.name	= KBUILD_MODNAME,
+	.id_table	= icve_rpmsg_id_table,
+	.probe		= icve_rpmsg_probe,
+	.callback	= icve_rpmsg_cb,
+	.remove		= icve_rpmsg_remove,
+};
+module_rpmsg_driver(icve_rpmsg_client);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Siddharth Vadapalli <s-vadapalli@ti.com>");
+MODULE_AUTHOR("Ravi Gunasekaran <r-gunasekaran@ti.com");
+MODULE_DESCRIPTION("TI Inter Core Virtual Ethernet driver");
diff --git a/drivers/net/ethernet/ti/inter-core-virt-eth.h b/drivers/net/ethernet/ti/inter-core-virt-eth.h
new file mode 100644
index 000000000000..063cc371eeb3
--- /dev/null
+++ b/drivers/net/ethernet/ti/inter-core-virt-eth.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Texas Instruments K3 Inter Core Virtual Ethernet Driver
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __INTER_CORE_VIRT_ETH_H__
+#define __INTER_CORE_VIRT_ETH_H__
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rpmsg.h>
+
+enum icve_msg_type {
+	ICVE_REQUEST_MSG = 0,
+	ICVE_RESPONSE_MSG,
+};
+
+enum icve_rpmsg_type {
+	/* Request types */
+	ICVE_REQ_SHM_INFO = 0,
+
+	/* Response types */
+	ICVE_RESP_SHM_INFO,
+};
+
+struct icve_shm_info {
+	void *tx_buffer;
+	void *tx_buffer_base_addr;
+	void *rx_buffer;
+	void *rx_buffer_base_addr;
+	u32 max_buffers;
+} __packed;
+
+struct request_message {
+	u32 type; /* Request Type */
+} __packed;
+
+struct response_message {
+	u32 type;
+	union {
+		struct icve_shm_info shm_info;
+	};
+} __packed;
+
+struct notify_message {
+	u32 type;
+} __packed;
+
+struct message_header {
+	u32 src_id;
+	u32 msg_type; /* Do not use enum type, as enum size is compiler dependent */
+} __packed;
+
+struct message {
+	struct message_header msg_hdr;
+	union {
+		struct request_message req_msg;
+		struct response_message resp_msg;
+		struct notify_message notify_msg;
+	};
+} __packed;
+
+struct shared_mem {
+	u32 head;
+	u32 tail;
+	void *base_addr;
+} __packed;
+
+struct icve_port {
+	struct shared_mem *tx_buffer; /* Write buffer for data to be consumed remote side */
+	struct shared_mem *rx_buffer; /* Read buffer for data to be consumed by this driver */
+	struct icve_common *common;
+	u32 icve_max_buffers;
+	u32 port_id; /* Unique ID for the port : TODO: Define range for use by Linux and non linux */
+
+} __packed;
+
+struct icve_common {
+	struct rpmsg_device *rpdev;
+	spinlock_t send_msg_lock;
+	spinlock_t recv_msg_lock;
+	struct message send_msg;
+	struct message recv_msg;
+	struct icve_port *port;
+	struct device *dev;
+} __packed;
+
+#endif /* __INTER_CORE_VIRT_ETH_H__ */
-- 
2.17.1


