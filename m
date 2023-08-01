Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DD476A95C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjHAGmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjHAGmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:42:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FF91735;
        Mon, 31 Jul 2023 23:42:00 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RFQTW3PYWzVjyk;
        Tue,  1 Aug 2023 14:40:15 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 14:41:57 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <robbiek@xsightlabs.com>, <sudeep.holla@arm.com>,
        <guohanjun@huawei.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wanghuiqiang@huawei.com>, <zhangzekun11@huawei.com>,
        <wangxiongfeng2@huawei.com>, <tanxiaofei@huawei.com>,
        <wangkefeng.wang@huawei.com>, <liuyonglong@huawei.com>,
        <lihuisong@huawei.com>
Subject: [PATCH RESEND v4 1/2] mailbox: pcc: Add support for platform notification handling
Date:   Tue, 1 Aug 2023 14:38:26 +0800
Message-ID: <20230801063827.25336-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20230801063827.25336-1-lihuisong@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230801063827.25336-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.79.22]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, PCC driver doesn't support the processing of platform
notification for type 4 PCC subspaces.

According to ACPI specification, if platform sends a notification
to OSPM, it must clear the command complete bit and trigger platform
interrupt. OSPM needs to check whether the command complete bit is
cleared, clear platform interrupt, process command, and then set the
command complete and ring doorbell to the Platform.

Let us stash the value of the pcc type and use the same while processing
the interrupt of the channel. We also need to set the command complete
bit and ring doorbell in the interrupt handler for the type 4 channel to
complete the communication flow after processing the notification from
the Platform.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/mailbox/pcc.c | 50 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index a44d4b3e5beb..80310b48bfb6 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -91,6 +91,7 @@ struct pcc_chan_reg {
  * @cmd_update: PCC register bundle for the command complete update register
  * @error: PCC register bundle for the error status register
  * @plat_irq: platform interrupt
+ * @type: PCC subspace type
  */
 struct pcc_chan_info {
 	struct pcc_mbox_chan chan;
@@ -100,12 +101,15 @@ struct pcc_chan_info {
 	struct pcc_chan_reg cmd_update;
 	struct pcc_chan_reg error;
 	int plat_irq;
+	u8 type;
 };
 
 #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
 static struct pcc_chan_info *chan_info;
 static int pcc_chan_count;
 
+static int pcc_send_data(struct mbox_chan *chan, void *data);
+
 /*
  * PCC can be used with perf critical drivers such as CPPC
  * So it makes sense to locally cache the virtual address and
@@ -221,6 +225,34 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
 	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
 }
 
+static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
+{
+	u64 val;
+	int ret;
+
+	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
+	if (ret)
+		return false;
+
+	if (!pchan->cmd_complete.gas)
+		return true;
+
+	/*
+	 * Judge if the channel respond the interrupt based on the value of
+	 * command complete.
+	 */
+	val &= pchan->cmd_complete.status_mask;
+	/*
+	 * If this is PCC slave subspace channel, and the command complete
+	 * bit 0 indicates that Platform is sending a notification and OSPM
+	 * needs to respond this interrupt to process this command.
+	 */
+	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
+		return !val;
+
+	return !!val;
+}
+
 /**
  * pcc_mbox_irq - PCC mailbox interrupt handler
  * @irq:	interrupt number
@@ -236,17 +268,9 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	int ret;
 
 	pchan = chan->con_priv;
-
-	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
-	if (ret)
+	if (!pcc_mbox_cmd_complete_check(pchan))
 		return IRQ_NONE;
 
-	if (val) { /* Ensure GAS exists and value is non-zero */
-		val &= pchan->cmd_complete.status_mask;
-		if (!val)
-			return IRQ_NONE;
-	}
-
 	ret = pcc_chan_reg_read(&pchan->error, &val);
 	if (ret)
 		return IRQ_NONE;
@@ -262,6 +286,13 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 
 	mbox_chan_received_data(chan, NULL);
 
+	/*
+	 * The PCC slave subspace channel needs to set the command complete bit
+	 * and ring doorbell after processing message.
+	 */
+	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
+		pcc_send_data(chan, NULL);
+
 	return IRQ_HANDLED;
 }
 
@@ -698,6 +729,7 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 
 		pcc_parse_subspace_shmem(pchan, pcct_entry);
 
+		pchan->type = pcct_entry->type;
 		pcct_entry = (struct acpi_subtable_header *)
 			((unsigned long) pcct_entry + pcct_entry->length);
 	}
-- 
2.22.0

