Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CE97FDB78
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbjK2Pb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbjK2PbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:31:20 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47225D46;
        Wed, 29 Nov 2023 07:31:26 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6066EE0011;
        Wed, 29 Nov 2023 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701271884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+cbJLlFkfaPpJj8eq2H7GH+mfMR2CF2wpb8mSuVlsv0=;
        b=NvRyz5oV+vJAoMD+AzwVa0Pd3fnr+0xseEL8Idc6yMEkfYblEjF1tnKQk8dZ9Zsnw3tu2k
        MsWb8UYvtX+4Oa54PdnY5Jo7iNPLv7uDa/6nQl25VeYsqNOzLAufD6dAo1itmaYp9PXDMz
        wkPB5GTCnLIsRV5X9mWxzLAUCm7pLqspV9Weuu7Ltpn4OHxj+PUbYookW9YM9LcNU/VOXt
        Yuq1JzI9DDXHDxWMkVfim4EgxX+SBRzKGBAT0uqghV7frsfBGBsWPQT0UmetjjrtsYRUuK
        KW3G8peHoHsWh4AdoVeR0OqBPvurU6pCrjl4C/hZmDyfTnAA/9PFsOPv+rL2aA==
From:   Thomas Richard <thomas.richard@bootlin.com>
Date:   Wed, 29 Nov 2023 16:31:18 +0100
Subject: [PATCH 2/5] firmware: ti_sci: add suspend/resume support for irqs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-j7200-tisci-s2r-v1-2-c1d5964ed574@bootlin.com>
References: <20231129-j7200-tisci-s2r-v1-0-c1d5964ed574@bootlin.com>
In-Reply-To: <20231129-j7200-tisci-s2r-v1-0-c1d5964ed574@bootlin.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, u-kumar1@ti.com,
        Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On j7200, during suspend to ram, the SoC is powered-off.
The irqs configuration is lost, so it shall be restored at resume.
The ti-sci has an internal list of irqs updated at each set/free.
All irqs in this list are restored at resume.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/firmware/ti_sci.c | 155 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 147 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 7041befc756a..c26ec86a5ff2 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -25,6 +25,7 @@
 #include <linux/soc/ti/ti-msgmgr.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <linux/reboot.h>
+#include <linux/suspend.h>
 
 #include "ti_sci.h"
 
@@ -75,12 +76,24 @@ struct ti_sci_xfers_info {
  * @max_msgs: Maximum number of messages that can be pending
  *		  simultaneously in the system
  * @max_msg_size: Maximum size of data per message that can be handled.
+ * @restore_irqs: Set to true if allocated irqs shall be restored at resume
  */
 struct ti_sci_desc {
 	u8 default_host_id;
 	int max_rx_timeout_ms;
 	int max_msgs;
 	int max_msg_size;
+	bool restore_irqs;
+};
+
+/**
+ * struct ti_sci_irq - Description of allocated irqs
+ * @list: List head
+ * @desc: Description of the irq
+ */
+struct ti_sci_irq {
+	struct list_head list;
+	struct ti_sci_msg_req_manage_irq desc;
 };
 
 /**
@@ -97,6 +110,7 @@ struct ti_sci_desc {
  * @chan_tx:	Transmit mailbox channel
  * @chan_rx:	Receive mailbox channel
  * @minfo:	Message info
+ * @irqs:	List of allocated irqs
  * @node:	list head
  * @host_id:	Host ID
  * @users:	Number of users of this instance
@@ -114,6 +128,7 @@ struct ti_sci_info {
 	struct mbox_chan *chan_tx;
 	struct mbox_chan *chan_rx;
 	struct ti_sci_xfers_info minfo;
+	struct ti_sci_irq irqs;
 	struct list_head node;
 	u8 host_id;
 	/* protected by ti_sci_list_mutex */
@@ -1890,6 +1905,29 @@ static int ti_sci_manage_irq(const struct ti_sci_handle *handle,
 	return ret;
 }
 
+/**
+ * ti_sci_irqs_equal() - Helper API to compare two irqs (generic headers are not
+ *                       compared)
+ * @irq_a:	IRQ A to compare
+ * @irq_b:	IRQ B to compare
+ *
+ * Return: true if the two irqs are equal, else false.
+ */
+static bool ti_sci_irqs_equal(struct ti_sci_msg_req_manage_irq irq_a,
+			      struct ti_sci_msg_req_manage_irq irq_b)
+{
+	return irq_a.valid_params == irq_b.valid_params &&
+		irq_a.src_id == irq_b.src_id &&
+		irq_a.src_index == irq_b.src_index &&
+		irq_a.dst_id == irq_b.dst_id &&
+		irq_a.dst_host_irq == irq_b.dst_host_irq &&
+		irq_a.ia_id == irq_b.ia_id &&
+		irq_a.vint == irq_b.vint &&
+		irq_a.global_event == irq_b.global_event &&
+		irq_a.vint_status_bit == irq_b.vint_status_bit &&
+		irq_a.secondary_host == irq_b.secondary_host;
+}
+
 /**
  * ti_sci_set_irq() - Helper api to configure the irq route between the
  *		      requested source and destination
@@ -1913,15 +1951,39 @@ static int ti_sci_set_irq(const struct ti_sci_handle *handle, u32 valid_params,
 			  u16 dst_host_irq, u16 ia_id, u16 vint,
 			  u16 global_event, u8 vint_status_bit, u8 s_host)
 {
+	struct ti_sci_info *info = handle_to_ti_sci_info(handle);
+	struct ti_sci_msg_req_manage_irq *desc;
+	struct ti_sci_irq *irq;
+	int ret;
+
 	pr_debug("%s: IRQ set with valid_params = 0x%x from src = %d, index = %d, to dst = %d, irq = %d,via ia_id = %d, vint = %d, global event = %d,status_bit = %d\n",
 		 __func__, valid_params, src_id, src_index,
 		 dst_id, dst_host_irq, ia_id, vint, global_event,
 		 vint_status_bit);
 
-	return ti_sci_manage_irq(handle, valid_params, src_id, src_index,
-				 dst_id, dst_host_irq, ia_id, vint,
-				 global_event, vint_status_bit, s_host,
-				 TI_SCI_MSG_SET_IRQ);
+	ret = ti_sci_manage_irq(handle, valid_params, src_id, src_index,
+				dst_id, dst_host_irq, ia_id, vint,
+				global_event, vint_status_bit, s_host,
+				TI_SCI_MSG_SET_IRQ);
+
+	if (ret)
+		return ret;
+
+	irq = kmalloc(sizeof(*irq), GFP_KERNEL);
+	desc = &irq->desc;
+	desc->valid_params = valid_params;
+	desc->src_id = src_id;
+	desc->src_index = src_index;
+	desc->dst_id = dst_id;
+	desc->dst_host_irq = dst_host_irq;
+	desc->ia_id = ia_id;
+	desc->vint = vint;
+	desc->global_event = global_event;
+	desc->vint_status_bit = vint_status_bit;
+	desc->secondary_host = s_host;
+	list_add(&irq->list, &info->irqs.list);
+
+	return ret;
 }
 
 /**
@@ -1947,15 +2009,46 @@ static int ti_sci_free_irq(const struct ti_sci_handle *handle, u32 valid_params,
 			   u16 dst_host_irq, u16 ia_id, u16 vint,
 			   u16 global_event, u8 vint_status_bit, u8 s_host)
 {
+	struct ti_sci_info *info = handle_to_ti_sci_info(handle);
+	struct ti_sci_msg_req_manage_irq irq_desc;
+	struct ti_sci_irq *this_irq;
+	struct list_head *this;
+	int ret;
+
 	pr_debug("%s: IRQ release with valid_params = 0x%x from src = %d, index = %d, to dst = %d, irq = %d,via ia_id = %d, vint = %d, global event = %d,status_bit = %d\n",
 		 __func__, valid_params, src_id, src_index,
 		 dst_id, dst_host_irq, ia_id, vint, global_event,
 		 vint_status_bit);
 
-	return ti_sci_manage_irq(handle, valid_params, src_id, src_index,
-				 dst_id, dst_host_irq, ia_id, vint,
-				 global_event, vint_status_bit, s_host,
-				 TI_SCI_MSG_FREE_IRQ);
+	ret = ti_sci_manage_irq(handle, valid_params, src_id, src_index,
+				dst_id, dst_host_irq, ia_id, vint,
+				global_event, vint_status_bit, s_host,
+				TI_SCI_MSG_FREE_IRQ);
+
+	if (ret)
+		return ret;
+
+	irq_desc.valid_params = valid_params;
+	irq_desc.src_id = src_id;
+	irq_desc.src_index = src_index;
+	irq_desc.dst_id = dst_id;
+	irq_desc.dst_host_irq = dst_host_irq;
+	irq_desc.ia_id = ia_id;
+	irq_desc.vint = vint;
+	irq_desc.global_event = global_event;
+	irq_desc.vint_status_bit = vint_status_bit;
+	irq_desc.secondary_host = s_host;
+
+	list_for_each(this, &info->irqs.list) {
+		this_irq = list_entry(this, struct ti_sci_irq, list);
+		if (ti_sci_irqs_equal(irq_desc, this_irq->desc)) {
+			list_del(&this_irq->list);
+			kfree(this_irq);
+			break;
+		}
+	}
+
+	return ret;
 }
 
 /**
@@ -3266,6 +3359,37 @@ static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
 	return NOTIFY_BAD;
 }
 
+static int __maybe_unused ti_sci_resume_noirq(struct device *dev)
+{
+	const struct ti_sci_desc *desc = device_get_match_data(dev);
+	struct ti_sci_info *info = dev_get_drvdata(dev);
+	struct ti_sci_msg_req_manage_irq *irq_desc;
+	struct ti_sci_irq *irq;
+	struct list_head *this;
+	int ret = 0;
+
+	if (!desc->restore_irqs || pm_suspend_target_state != PM_SUSPEND_MEM)
+		return ret;
+
+	/* restore irqs */
+	list_for_each(this, &info->irqs.list) {
+		irq = list_entry(this, struct ti_sci_irq, list);
+		irq_desc = &irq->desc;
+		ret |=	ti_sci_manage_irq(&info->handle, irq_desc->valid_params,
+					  irq_desc->src_id, irq_desc->src_index,
+					  irq_desc->dst_id, irq_desc->dst_host_irq,
+					  irq_desc->ia_id, irq_desc->vint,
+					  irq_desc->global_event, irq_desc->vint_status_bit,
+					  irq_desc->secondary_host, TI_SCI_MSG_SET_IRQ);
+	}
+
+	return ret;
+}
+
+static const struct dev_pm_ops ti_sci_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, ti_sci_resume_noirq)
+};
+
 /* Description for K2G */
 static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	.default_host_id = 2,
@@ -3286,9 +3410,21 @@ static const struct ti_sci_desc ti_sci_pmmc_am654_desc = {
 	.max_msg_size = 60,
 };
 
+/* Description for J7200 */
+static const struct ti_sci_desc ti_sci_pmmc_j7200_desc = {
+	.default_host_id = 2,
+	/* Conservative duration */
+	.max_rx_timeout_ms = 1000,
+	/* Limited by MBOX_TX_QUEUE_LEN. K2G can handle up to 128 messages! */
+	.max_msgs = 20,
+	.max_msg_size = 64,
+	.restore_irqs = true,
+};
+
 static const struct of_device_id ti_sci_of_match[] = {
 	{.compatible = "ti,k2g-sci", .data = &ti_sci_pmmc_k2g_desc},
 	{.compatible = "ti,am654-sci", .data = &ti_sci_pmmc_am654_desc},
+	{.compatible = "ti,j7200-sci", .data = &ti_sci_pmmc_j7200_desc},
 	{ /* Sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, ti_sci_of_match);
@@ -3415,6 +3551,8 @@ static int ti_sci_probe(struct platform_device *pdev)
 		 info->handle.version.firmware_revision,
 		 info->handle.version.firmware_description);
 
+	INIT_LIST_HEAD(&info->irqs.list);
+
 	mutex_lock(&ti_sci_list_mutex);
 	list_add_tail(&info->node, &ti_sci_list);
 	mutex_unlock(&ti_sci_list_mutex);
@@ -3435,6 +3573,7 @@ static struct platform_driver ti_sci_driver = {
 		   .name = "ti-sci",
 		   .of_match_table = of_match_ptr(ti_sci_of_match),
 		   .suppress_bind_attrs = true,
+		   .pm = &ti_sci_pm_ops,
 	},
 };
 module_platform_driver(ti_sci_driver);

-- 
2.39.2

