Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CBA7FDB7A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343765AbjK2Pbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbjK2PbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:31:21 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D02CD6E;
        Wed, 29 Nov 2023 07:31:27 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 980B2E0012;
        Wed, 29 Nov 2023 15:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701271886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ONeuGYPs2IMgsIBQkR63Bawpq/9TA/sG6QW/wej75m4=;
        b=BO10/zqYJKqTCTIriRT9JmPYFVTsWtcA7KqYL7K/1BHkPPd1Xn0YV9WLZVcrbte4oXJ2t5
        3yPSNaxWnpuWxT/A/2D2eVv/dIWO5zasx3T0t64s3Yj6FmsKEAE9y5lN+X7hL+eZrye8NF
        xkapT2x0QOo5fK3O2yfX6sJo38ukCLlKiAf2Y7brH8S8iwQC2oH8hgCG4TXlO4V72aIQsd
        roI5ybfc38SLcyjs2xBIR2XOgXfHQtbegtMgxm+pcQNyM8DNq2Qa6Yt5psl0+3Qt7agspG
        vwaOIprv1oFe5JB3R6Mwc5LCySr4SG8rjNzBhjIWr1LzOig16YdDNBxyDGLmLQ==
From:   Thomas Richard <thomas.richard@bootlin.com>
Date:   Wed, 29 Nov 2023 16:31:20 +0100
Subject: [PATCH 4/5] firmware: ti-sci: for j7200 before suspend check the
 reserved memory for lpm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-j7200-tisci-s2r-v1-4-c1d5964ed574@bootlin.com>
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

On j7200, a reserved memory region is needed for TF-A to save its context
during suspend to ram.
In ti-sci suspend, check if the region was defined, if not return an
error.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/firmware/ti_sci.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index c26ec86a5ff2..deaca17322df 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -77,6 +77,8 @@ struct ti_sci_xfers_info {
  *		  simultaneously in the system
  * @max_msg_size: Maximum size of data per message that can be handled.
  * @restore_irqs: Set to true if allocated irqs shall be restored at resume
+ * @lpm_region: Set to true if a reserved memory region is needed for suspend to
+ *		ram
  */
 struct ti_sci_desc {
 	u8 default_host_id;
@@ -84,6 +86,7 @@ struct ti_sci_desc {
 	int max_msgs;
 	int max_msg_size;
 	bool restore_irqs;
+	bool lpm_region;
 };
 
 /**
@@ -3359,6 +3362,32 @@ static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
 	return NOTIFY_BAD;
 }
 
+static bool ti_sci_check_lpm_region(void)
+{
+	struct device_node *parent, *node;
+
+	parent = of_find_node_by_path("/reserved-memory");
+	for_each_child_of_node(parent, node) {
+		if (of_node_name_eq(node, "lpm-memory"))
+			return true;
+	}
+
+	return false;
+}
+
+static int __maybe_unused ti_sci_suspend(struct device *dev)
+{
+	const struct ti_sci_desc *desc = device_get_match_data(dev);
+
+	if (pm_suspend_target_state == PM_SUSPEND_MEM &&
+	    desc->lpm_region && !ti_sci_check_lpm_region()) {
+		dev_err(dev, "lpm region is required for suspend to ram but is not provided\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int __maybe_unused ti_sci_resume_noirq(struct device *dev)
 {
 	const struct ti_sci_desc *desc = device_get_match_data(dev);
@@ -3387,6 +3416,7 @@ static int __maybe_unused ti_sci_resume_noirq(struct device *dev)
 }
 
 static const struct dev_pm_ops ti_sci_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(ti_sci_suspend, NULL)
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, ti_sci_resume_noirq)
 };
 
@@ -3419,6 +3449,7 @@ static const struct ti_sci_desc ti_sci_pmmc_j7200_desc = {
 	.max_msgs = 20,
 	.max_msg_size = 64,
 	.restore_irqs = true,
+	.lpm_region = true,
 };
 
 static const struct of_device_id ti_sci_of_match[] = {
@@ -3546,6 +3577,11 @@ static int ti_sci_probe(struct platform_device *pdev)
 		}
 	}
 
+#ifdef CONFIG_PM_SLEEP
+	if (desc->lpm_region && !ti_sci_check_lpm_region())
+		dev_warn(dev, "lpm region is required for suspend to ram but is not provided\n");
+#endif
+
 	dev_info(dev, "ABI: %d.%d (firmware rev 0x%04x '%s')\n",
 		 info->handle.version.abi_major, info->handle.version.abi_minor,
 		 info->handle.version.firmware_revision,

-- 
2.39.2

