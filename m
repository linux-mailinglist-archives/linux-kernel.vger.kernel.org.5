Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C5076FFBD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjHDLwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHDLwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:52:39 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50ED127;
        Fri,  4 Aug 2023 04:52:37 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 374BqWwM020848;
        Fri, 4 Aug 2023 06:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691149952;
        bh=TqKxNIGJnt5+2bHiWBaedpD7/IwhNmC4TbxjiKwgcZ8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RrxMsnGjiqivgz5xnJR/bKm7noasx2Eoik02LhdcozNRGZ0uT9MihxaohQw8lx4vp
         w5DA5hZoZ4tXmsXinwldui5MlQyCrs2ZqxBJpahQPeVUBc3nFTe2SU1+ac3RGVIold
         SCnbXlCTQrlwmYyyz1aex42WKX824/Kixvmkll9M=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 374BqWDN123642
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Aug 2023 06:52:32 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Aug 2023 06:52:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Aug 2023 06:52:30 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 374BqUpJ023849;
        Fri, 4 Aug 2023 06:52:30 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        "Santosh Shilimkar" <ssantosh@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>,
        "Kevin Hilman" <khilman@baylibre.com>, Vignesh R <vigneshr@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>,
        Georgi Vlaev <g-vlaev@ti.com>,
        Roger Quadros <rogerq@kernel.org>, Dhruva Gole <d-gole@ti.com>
Subject: [PATCH V7 3/4] firmware: ti_sci: Allocate memory for Low Power Modes
Date:   Fri, 4 Aug 2023 17:20:36 +0530
Message-ID: <20230804115037.754994-4-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804115037.754994-1-d-gole@ti.com>
References: <20230804115037.754994-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

A region of memory in DDR must be used during Deep Sleep for saving
of some system context when using the ti_sci firmware. From DM's point
of view, this can be any contiguous region in the DDR, so can allocate
512KB of DMA reserved memory in probe(), instead of another carveout.

Also send a TISCI_MSG_QUERY_FW_CAPS message to the firmware during
probe to determine if any low power modes are supported and if
ti_sci_init_suspend should be called based on the response received.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
Tested-by: Roger Quadros <rogerq@kernel.org>
[d-gole@ti.com: Use dma_alloc_attrs instead of dma_alloc_coherent]
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/firmware/ti_sci.c | 44 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index ac64e328c313..512338699153 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -10,6 +10,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/debugfs.h>
+#include <linux/dma-mapping.h>
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -26,6 +27,9 @@
 
 #include "ti_sci.h"
 
+/* Low power mode memory context size */
+#define LPM_CTX_MEM_SIZE 0x80000
+
 /* List of all TI SCI devices active in system */
 static LIST_HEAD(ti_sci_list);
 /* Protection for the entire list */
@@ -97,6 +101,9 @@ struct ti_sci_desc {
  * @minfo:	Message info
  * @node:	list head
  * @host_id:	Host ID
+ * @ctx_mem_addr: Low power context memory phys address
+ * @ctx_mem_buf: Low power context memory buffer
+ * @fw_caps:	FW/SoC low power capabilities
  * @users:	Number of users of this instance
  */
 struct ti_sci_info {
@@ -114,6 +121,9 @@ struct ti_sci_info {
 	struct ti_sci_xfers_info minfo;
 	struct list_head node;
 	u8 host_id;
+	dma_addr_t ctx_mem_addr;
+	void *ctx_mem_buf;
+	u64 fw_caps;
 	/* protected by ti_sci_list_mutex */
 	int users;
 };
@@ -3423,6 +3433,25 @@ static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
 	return NOTIFY_BAD;
 }
 
+static int ti_sci_init_suspend(struct platform_device *pdev,
+			       struct ti_sci_info *info)
+{
+	struct device *dev = &pdev->dev;
+
+	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	info->ctx_mem_buf = dma_alloc_attrs(info->dev, LPM_CTX_MEM_SIZE,
+					    &info->ctx_mem_addr,
+					    GFP_KERNEL,
+					    DMA_ATTR_NO_KERNEL_MAPPING |
+					    DMA_ATTR_FORCE_CONTIGUOUS);
+	if (!info->ctx_mem_buf) {
+		dev_err(info->dev, "Failed to allocate LPM context memory\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 /* Description for K2G */
 static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	.default_host_id = 2,
@@ -3573,6 +3602,15 @@ static int ti_sci_probe(struct platform_device *pdev)
 		}
 	}
 
+	/*
+	 * Check if the firmware supports any optional low power modes
+	 * and initialize them if present. Old revisions of TIFS (< 08.04)
+	 * will NACK the request.
+	 */
+	ret = ti_sci_msg_cmd_query_fw_caps(&info->handle, &info->fw_caps);
+	if (!ret && (info->fw_caps & MSG_MASK_CAPS_LPM))
+		ti_sci_init_suspend(pdev, info);
+
 	dev_info(dev, "ABI: %d.%d (firmware rev 0x%04x '%s')\n",
 		 info->handle.version.abi_major, info->handle.version.abi_minor,
 		 info->handle.version.firmware_revision,
@@ -3620,6 +3658,12 @@ static int ti_sci_remove(struct platform_device *pdev)
 		mbox_free_channel(info->chan_rx);
 	}
 
+	if (info->ctx_mem_buf)
+		dma_free_attrs(info->dev, LPM_CTX_MEM_SIZE,
+			       info->ctx_mem_buf,
+			       info->ctx_mem_addr,
+			       DMA_ATTR_NO_KERNEL_MAPPING |
+			       DMA_ATTR_FORCE_CONTIGUOUS);
 	return ret;
 }
 
-- 
2.34.1

