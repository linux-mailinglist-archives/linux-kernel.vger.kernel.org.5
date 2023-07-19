Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C90759C80
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGSRgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjGSRgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:36:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA9F619B4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:36:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 704792F4;
        Wed, 19 Jul 2023 10:36:48 -0700 (PDT)
Received: from pluto.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEC663F67D;
        Wed, 19 Jul 2023 10:36:03 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org, peng.fan@nxp.com,
        quic_nkela@quicinc.com,
        Cristian Marussi <cristian.marussi@arm.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH] firmware: arm_scmi: Fix chan_free cleanup on SMC
Date:   Wed, 19 Jul 2023 18:35:33 +0100
Message-ID: <20230719173533.2739319-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI transport based on SMC can optionally use an additional IRQ to signal
message completion; the associated ISR is currently allocated using devres
but the core SCMI stack, on shutdown, will call .chan_free() well before
any managed cleanup is invoked by devres and, as a consequence, the arrival
of a late reply to an in-flight pending transaction could still trigger the
ISR well after the SCMI core has cleaned up the channels, with unpleasant
results.

Inhibit further message processing on the IRQ path by explicitly freeing
the IRQ inside .chan_free() callback itself.

Fixes: dd820ee21d5e ("firmware: arm_scmi: Augment SMC/HVC to allow optional interrupt")
Reported-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Just compile tested, dont have a platform to test it.
---
 drivers/firmware/arm_scmi/smc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 621c37efe3ec..c8c2fb172079 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -40,6 +40,7 @@
 /**
  * struct scmi_smc - Structure representing a SCMI smc transport
  *
+ * @irq: An optional IRQ for completion
  * @cinfo: SCMI channel info
  * @shmem: Transmit/Receive shared memory area
  * @shmem_lock: Lock to protect access to Tx/Rx shared memory area.
@@ -52,6 +53,7 @@
  */
 
 struct scmi_smc {
+	int irq;
 	struct scmi_chan_info *cinfo;
 	struct scmi_shared_mem __iomem *shmem;
 	/* Protect access to shmem area */
@@ -127,7 +129,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	struct resource res;
 	struct device_node *np;
 	u32 func_id;
-	int ret, irq;
+	int ret;
 
 	if (!tx)
 		return -ENODEV;
@@ -167,11 +169,10 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	 * completion of a message is signaled by an interrupt rather than by
 	 * the return of the SMC call.
 	 */
-	irq = of_irq_get_byname(cdev->of_node, "a2p");
-	if (irq > 0) {
-		ret = devm_request_irq(dev, irq, smc_msg_done_isr,
-				       IRQF_NO_SUSPEND,
-				       dev_name(dev), scmi_info);
+	scmi_info->irq = of_irq_get_byname(cdev->of_node, "a2p");
+	if (scmi_info->irq > 0) {
+		ret = request_irq(scmi_info->irq, smc_msg_done_isr,
+				  IRQF_NO_SUSPEND, dev_name(dev), scmi_info);
 		if (ret) {
 			dev_err(dev, "failed to setup SCMI smc irq\n");
 			return ret;
@@ -193,6 +194,10 @@ static int smc_chan_free(int id, void *p, void *data)
 	struct scmi_chan_info *cinfo = p;
 	struct scmi_smc *scmi_info = cinfo->transport_info;
 
+	/* Ignore any possible further reception on the IRQ path */
+	if (scmi_info->irq > 0)
+		free_irq(scmi_info->irq, scmi_info);
+
 	cinfo->transport_info = NULL;
 	scmi_info->cinfo = NULL;
 
-- 
2.41.0

